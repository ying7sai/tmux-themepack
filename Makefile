BUILDER := bin/build-theme
THEME_SRC := $(shell find src -name '*.tmuxtheme')
INCLUDES := $(shell find src -name '*.tmuxsh')
THEMES := $(patsubst src/%,%,$(THEME_SRC))
TESTS := $(addsuffix .test,$(THEMES))

.PHONY: build
build: $(THEMES)

.PHONY: clean
clean:
	rm $(shell find * -name "*.tmuxtheme" -not -path "src/*")

.PHONY: test
test:
	$(foreach file,$(THEMES), \
		$(BUILDER) "src/$(file)" | diff -q "$(file)" - && \
	) true

$(THEMES): %.tmuxtheme: src/%.tmuxtheme $(INCLUDES)
	$(BUILDER) "src/$@" "$@"

$(TESTS): %.test: src/%.test
