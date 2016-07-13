APP = $(foreach file, $(wildcard *.json), $(subst .json,.app,$(file)))
REPO = repo

all: clean build bundle
build: $(APP)

clean:
	@rm -rf app repo .flatpak-builder $(subst .app,.bundle,$(APP))

bundle:
	@flatpak build-bundle repo org.gnumdk.Lollypop.bundle org.gnumdk.Lollypop 0.9.112

%.app: %.json
	@flatpak-builder --ccache --require-changes --repo=$(REPO) --subject="Build of $<, `date`" ${EXPORT_ARGS} app $<


