Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163F539A
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023551; cv=none; b=NV5MA4Pjf9mgOzI/gwQ9ASE02Hv9zvMf6bHSG2uicux35eEgpVrOWBttT03MhnHO6o2xd//A3wjCS60KGL0mJ7nIUoH7YTOU5VcPrCplhusQm8h02F9BrP7bXVD9e79PwdyPQHXJP8XgG3qgxstkmz8epy666XQkCp/0tnit6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023551; c=relaxed/simple;
	bh=N5mobiNDYEey4KGZ9v4e3GzZIx/VAQ6WbmK3Vo4+Xok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eEx2rvL1pJfL9xgNtA/N8LERQ58GkoSoV4yUL403aDNFVmPtI5C/jYhEMxrYBbZHal72MOdiRnB91xJtQB02bW7xYp4m1Y2tHq1OovbZvNZe1+C0CEnCzdHEktmQBJAmhk4h4y4kkkaf6/UvA9h7OgRFwcLip5eNDCQ4vyiQwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwUdxXev; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwUdxXev"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so9671001a91.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738023548; x=1738628348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FhkZFXQ8xCbqx6HKmX0gBSMW9TX0HQL0feAZJLACP4=;
        b=bwUdxXev5zE/I9KhnFhN27bPu2EUcwfG9BKQRag8MvwRxQJ7PgPepCbBLCcEWgcZEC
         Ezqmv8GIWHdtv/zvc28JaP+rCiE4mYKowAnwKVIH4ynVL+cfMi+xMD85l3LnBKC+r2xF
         OC7itqvW7tmlkB3yt+95tV/Awd4qFZZtnAtcCAP2/aooTIeSBnicYW2LG1DJloGFOXea
         Jpevd8HfkFAY8GQBIYlk5gisZuZsFEumVGMRqnrJhKJ0P0+4buVkclrMaKykvFkXgbRl
         9DsDmPQD/+tSC4/G7GKgwc+wMK5ZEhChAshexESN30N5U2iwneIzN5HS9hGX1uprj2Mm
         exng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738023548; x=1738628348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FhkZFXQ8xCbqx6HKmX0gBSMW9TX0HQL0feAZJLACP4=;
        b=WtqyguQsBMSF2lV9VdIMe5sM0QXrPHAHxmtfafTbQh45K3GpEsQEfrTocrV9UIyIeB
         vmXBHj+t56ZHbrJA+urJKVV4ks2eyZLdkYKk3MQUAu63Cyk9Ye+q2oD+HRorpb02MGZP
         KP0h5EOAoD8hJogXfem/8NWlCGlD3Bd9kL58UbpILWAXmXlGy+FL177zap22C4szYDQm
         Py5ONXoQ59eUKThYgEeBtbCQADtjPDBnlTOTGaPWlTVSmdyrUuawlHGX+SCu6XkdBEBb
         A8rFgj7ykkEvh0IcVdKoHE1BdjGKjdh2tbWNNJBUx8itv0HZ/7FtjHknSi+Xp5FnPpHr
         00Vw==
X-Gm-Message-State: AOJu0YwzOC9XScNrHMV9V8XRyVO4C6PsdNl8SONVz8M+FNs7wV4hokXx
	/tcpfxnnfKxdowsRaM72rUp9146ACX9lpLP2Ueixnqq2ZkYdexzuEgFYl84u5oCtEyXA3mrrZzB
	12wFjSkCcR3M1BhfLVeFC9vEucmCj8HzGt11wQfhOQkjpiMvvPap/2/MaqXVpD+8AyYE8sI3kpr
	G/uxlJ/CVA3F5qvBMD7d9ulOyhC2HmolHFxDLpdTY=
X-Google-Smtp-Source: AGHT+IG4wnX2mJvaoNWyRZ+alCZSEEUB5ZWzg1QXTm2yY9nnTKhuXlDMkXAqk2uKnhXzYADfAKfFblqm2b7uyw==
X-Received: from pfbjc1.prod.google.com ([2002:a05:6a00:6c81:b0:725:e46a:4fdd])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c9b:b0:725:e015:9090 with SMTP id d2e1a72fcca58-72daf9508a0mr51414388b3a.9.1738023547963;
 Mon, 27 Jan 2025 16:19:07 -0800 (PST)
Date: Mon, 27 Jan 2025 16:19:01 -0800
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <cover.1738023208.git.steadmon@google.com>
Subject: [PATCH v7 0/4] Introduce libgit-rs, a Rust wrapper around libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

This series provides two small Rust wrapper libraries around parts of
Git: "libgit-sys", which exposes a few functions from libgit.a, and
"libgit", which provides a more Rust-friendly interface to some of those
functions. In addition to included unit tests, at $DAYJOB we have tested
building JJ[1] with our library and used it to replace some of the
libgit2-rs uses.

[1] https://github.com/jj-vcs/jj

There is known NEEDSWORK, but I feel that they can be addressed in
follow-up changes, rather than in this series. If you feel otherwise,
please let me know:

* Investigate alternative methods of managing symbol visibility &
  renaming.

* Figure out symbol versioning

Changes in V7:
* Moved the ConfigSet implementation in libgit-rs to a `config` module.

* Added doc comments for ConfigSet and its methods.

* Fix meson builds by adding new object files to `libgit_sources`

* Moved INCLUDE_LIBGIT_RS Makefile changes earlier in the series, so
  that we can make it optional to compile some of the libgitpub sources.
  Squashed V6 patch 5/5 into this series' patch 4/4.

* Don't publicly export FFI types in libgit-rs.

* Removed extraneous `-r` argument to $(RM) in the clean rules.

* Added TODO reminder in Cargo.toml about removing Cargo.lock once we
  hit a certain minimum supported Rust version.

* Style cleanup in public_symbol_export.c

Changes in V6:
* Rebased onto current master, since V5 was several months old.

* Move libgit-sys out of libgit-rs; while this sort of nesting is common
  in Rust crates with standalone repositories, it doesn't make as much
  sense when they're contained in the larger Git project's repo.

* Standardize the naming of some of the Makefile targets to always
  include a dash in the "-rs" or "-sys" suffixes.

* Clean up READMEs and crate descriptions in preparation for
  uploading to crates.io.

Changes in V5:
* When building with INCLUDE_LIBGIT_RS defined, add
  "-fvisibility=hidden" to CFLAGS. This allows us to manage symbol
  visibility in libgitpub.a without causing `make all` to rebuild from
  scratch due to changing CFLAGS.

* Avoid using c_int in the higher-level Rust API.

* Remove libgitpub.a and intermediate files with `make clean`.

Changes in V4:
* Drop V3 patch #3, which added wrappers around repository
  initialization and config access. These are not well-libified, and
  they are not necessary for JJ's proof-of-concept use case, so let's
  avoid exporting them for now.

* Set a minimum supported Rust version of 1.63. Autodetect whether our
  Rust version has c_int and c_char types; if not, define them
  ourselves.

* When building libgitpub.a via build.rs, set DEVELOPER=1 to catch
  additional errors at build time.

* In build.rs, use the make_cmd crate to portable select the correct
  invocation of GNU Make.

* Follow naming standards for _alloc() and _free() functions.

* Use String instead of CString in higher-level API.

* Move libgit_configset_alloc() and libgit_configset_free() out of
  upstream Git, to the libgitpub shim library.

* In libgitpub, initialize libgit_config_set structs in the _alloc()
  function rather than with a separate _init() function.

* Remove unnecessary comments in libgit-sys showing where the wrapped
  functions were originally defined.

* Fix clippy lint: don't reborrow configfile path references.

* Various typo fixes and `cargo fmt` fixes.

Changes in V3:
* Renamed cgit-rs to libgit-rs and cgit-sys to libgit-sys

* Makefile cleanup, particularly adding config.mak options that
  developers can set to run Rust builds and tests by default (Patch 6)

* Provide testdata configs for unit tests

* ConfigSet API now uses &Path instead of &str -- more ergonomic for
  Rust users to pass in and errors out if the path string isn't UTF-8

* Fixed unresolved dependency on libz in Cargo.toml


Calvin Wan (1):
  libgit: add higher-level libgit crate

Josh Steadmon (3):
  common-main: split init and exit code into new files
  libgit-sys: introduce Rust wrapper for libgit.a
  libgit-sys: also export some config_set functions

 .gitignore                                |   2 +
 Makefile                                  |  45 +++++++++
 common-exit.c                             |  26 ++++++
 common-init.c                             |  63 +++++++++++++
 common-init.h                             |   6 ++
 common-main.c                             |  83 +----------------
 contrib/libgit-rs/Cargo.lock              |  77 ++++++++++++++++
 contrib/libgit-rs/Cargo.toml              |  17 ++++
 contrib/libgit-rs/README.md               |  13 +++
 contrib/libgit-rs/build.rs                |   4 +
 contrib/libgit-rs/src/config.rs           | 106 ++++++++++++++++++++++
 contrib/libgit-rs/src/lib.rs              |   1 +
 contrib/libgit-rs/testdata/config1        |   2 +
 contrib/libgit-rs/testdata/config2        |   2 +
 contrib/libgit-rs/testdata/config3        |   2 +
 contrib/libgit-sys/Cargo.lock             |  69 ++++++++++++++
 contrib/libgit-sys/Cargo.toml             |  19 ++++
 contrib/libgit-sys/README.md              |   4 +
 contrib/libgit-sys/build.rs               |  35 +++++++
 contrib/libgit-sys/public_symbol_export.c |  51 +++++++++++
 contrib/libgit-sys/public_symbol_export.h |  18 ++++
 contrib/libgit-sys/src/lib.rs             |  79 ++++++++++++++++
 meson.build                               |   2 +
 t/Makefile                                |  15 +++
 24 files changed, 660 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/README.md
 create mode 100644 contrib/libgit-rs/build.rs
 create mode 100644 contrib/libgit-rs/src/config.rs
 create mode 100644 contrib/libgit-rs/src/lib.rs
 create mode 100644 contrib/libgit-rs/testdata/config1
 create mode 100644 contrib/libgit-rs/testdata/config2
 create mode 100644 contrib/libgit-rs/testdata/config3
 create mode 100644 contrib/libgit-sys/Cargo.lock
 create mode 100644 contrib/libgit-sys/Cargo.toml
 create mode 100644 contrib/libgit-sys/README.md
 create mode 100644 contrib/libgit-sys/build.rs
 create mode 100644 contrib/libgit-sys/public_symbol_export.c
 create mode 100644 contrib/libgit-sys/public_symbol_export.h
 create mode 100644 contrib/libgit-sys/src/lib.rs

Range-diff against v6:
1:  ff6cd62397 ! 1:  cd0cb9aa04 common-main: split init and exit code into new files
    @@ common-main.c
     -
     -	return code;
     -}
    +
    + ## meson.build ##
    +@@ meson.build: libgit_sources = [
    +   'commit-graph.c',
    +   'commit-reach.c',
    +   'commit.c',
    ++  'common-exit.c',
    ++  'common-init.c',
    +   'compat/nonblock.c',
    +   'compat/obstack.c',
    +   'compat/terminal.c',
2:  5fc66cdb16 ! 2:  f1502b8590 libgit-sys: introduce Rust wrapper for libgit.a
    @@ .gitignore: Release/
     +/contrib/libgit-sys/target
     
      ## Makefile ##
    +@@ Makefile: include shared.mak
    + # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
    + # programs in oss-fuzz/.
    + #
    ++# Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
    ++# test the Rust crate in contrib/libgit-sys.
    ++#
    + # === Optional library: libintl ===
    + #
    + # Define NO_GETTEXT if you don't want Git output to be translated.
     @@ Makefile: CURL_CONFIG = curl-config
      GCOV = gcov
      STRIP = strip
    @@ Makefile: CURL_CONFIG = curl-config
      
      export TCL_PATH TCLTK_PATH
      
    -@@ Makefile: OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
    - OBJECTS += $(UNIT_TEST_OBJS)
    +@@ Makefile: ifdef FSMONITOR_OS_SETTINGS
    + 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
    + endif
    + 
    ++ifdef INCLUDE_LIBGIT_RS
    ++	# Enable symbol hiding in contrib/libgit-sys/libgitpub.a without making
    ++	# us rebuild the whole tree every time we run a Rust build.
    ++	BASIC_CFLAGS += -fvisibility=hidden
    ++endif
    ++
    + ifeq ($(TCLTK_PATH),)
    + NO_TCLTK = NoThanks
    + endif
    +@@ Makefile: OBJECTS += $(UNIT_TEST_OBJS)
      OBJECTS += $(CLAR_TEST_OBJS)
      OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
    -+OBJECTS += contrib/libgit-sys/public_symbol_export.o
      
    ++ifdef INCLUDE_LIBGIT_RS
    ++	OBJECTS += contrib/libgit-sys/public_symbol_export.o
    ++endif
    ++
      ifndef NO_CURL
      	OBJECTS += http.o http-walker.o remote-curl.o
    + endif
     @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
      	$(MAKE) -C Documentation/ clean
      	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
     +	$(RM) -r contrib/libgit-sys/target
    -+	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
    -+	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
    -+	$(RM) -r contrib/libgit-sys/libgitpub.a
    ++	$(RM) contrib/libgit-sys/partial_symbol_export.o
    ++	$(RM) contrib/libgit-sys/hidden_symbol_export.o
    ++	$(RM) contrib/libgit-sys/libgitpub.a
      ifndef NO_PERL
      	$(RM) -r perl/build/
      endif
    @@ Makefile: $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GIT
      unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
      	$(MAKE) -C t/ unit-tests
     +
    ++.PHONY: libgit-sys
    ++libgit-sys:
    ++	$(QUIET)(\
    ++		cd contrib/libgit-sys && \
    ++		cargo build \
    ++	)
    ++ifdef INCLUDE_LIBGIT_RS
    ++all:: libgit-sys
    ++endif
    ++
     +contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
     +	$(LD) -r $^ -o $@
     +
    @@ contrib/libgit-sys/Cargo.toml (new)
     +edition = "2021"
     +build = "build.rs"
     +links = "gitpub"
    -+rust-version = "1.63"
    ++rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
    ++                      # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
     +description = "Native bindings to a portion of libgit"
     +
     +[lib]
    @@ contrib/libgit-sys/build.rs (new)
     +        .env_remove("PROFILE")
     +        .current_dir(git_root.clone())
     +        .args([
    -+            "CFLAGS=-fvisibility=hidden",
    ++            "INCLUDE_LIBGIT_RS=YesPlease",
     +            "contrib/libgit-sys/libgitpub.a",
     +        ])
     +        .output()
    @@ contrib/libgit-sys/build.rs (new)
     
      ## contrib/libgit-sys/public_symbol_export.c (new) ##
     @@
    -+// Shim to publicly export Git symbols. These must be renamed so that the
    -+// original symbols can be hidden. Renaming these with a "libgit_" prefix also
    -+// avoids conflicts with other libraries such as libgit2.
    ++/* Shim to publicly export Git symbols. These must be renamed so that the
    ++ * original symbols can be hidden. Renaming these with a "libgit_" prefix also
    ++ * avoids conflicts with other libraries such as libgit2.
    ++ */
     +
     +#include "git-compat-util.h"
     +#include "contrib/libgit-sys/public_symbol_export.h"
    @@ contrib/libgit-sys/src/lib.rs (new)
     +        );
     +    }
     +}
    +
    + ## t/Makefile ##
    +@@ t/Makefile: perf:
    + 
    + .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
    + 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
    ++
    ++.PHONY: libgit-sys-test
    ++libgit-sys-test:
    ++	$(QUIET)(\
    ++		cd ../contrib/libgit-sys && \
    ++		cargo test \
    ++	)
    ++ifdef INCLUDE_LIBGIT_RS
    ++all:: libgit-sys-test
    ++endif
3:  03f39b6c3a < -:  ---------- libgit-sys: also export some config_set functions
5:  84706f0db7 ! 3:  d67d3648d1 Makefile: add option to build and test libgit-rs and libgit-rs-sys
    @@
      ## Metadata ##
    -Author: Calvin Wan <calvinwan@google.com>
    +Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    Makefile: add option to build and test libgit-rs and libgit-rs-sys
    +    libgit-sys: also export some config_set functions
     
    -    Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
    -    to their respective Makefiles so they can be built and tested without
    -    having to run cargo build/test.
    +    In preparation for implementing a higher-level Rust API for accessing
    +    Git configs, export some of the upstream configset API via libgitpub and
    +    libgit-sys. Since this will be exercised as part of the higher-level API
    +    in the next commit, no tests have been added for libgit-sys.
     
    -    Add build variable, INCLUDE_LIBGIT_RS, that when set, automatically
    -    builds and tests libgit-rs and libgit-rs-sys when `make all` is run.
    +    While we're at it, add git_configset_alloc() and git_configset_free()
    +    functions in libgitpub so that callers can manage config_set structs on
    +    the heap. This also allows non-C external consumers to treat config_sets
    +    as opaque structs.
     
    -    Co-authored-by: Josh Steadmon <steadmon@google.com>
    +    Co-authored-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
    - ## Makefile ##
    -@@ Makefile: include shared.mak
    - # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
    - # programs in oss-fuzz/.
    - #
    -+# Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
    -+# test the Rust crates in contrib/libgit-rs/ and contrib/libgit-rs/libgit-sys/.
    -+#
    - # === Optional library: libintl ===
    - #
    - # Define NO_GETTEXT if you don't want Git output to be translated.
    -@@ Makefile: ifdef FSMONITOR_OS_SETTINGS
    - 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
    - endif
    + ## contrib/libgit-sys/public_symbol_export.c ##
    +@@
    +  */
      
    -+ifdef INCLUDE_LIBGIT_RS
    -+	# Enable symbol hiding in contrib/libgit-rs/libgit-sys/libgitpub.a
    -+	# without making us rebuild the whole tree every time we run a Rust
    -+	# build.
    -+	BASIC_CFLAGS += -fvisibility=hidden
    -+endif
    -+
    - ifeq ($(TCLTK_PATH),)
    - NO_TCLTK = NoThanks
    - endif
    -@@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
    - unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
    - 	$(MAKE) -C t/ unit-tests
    + #include "git-compat-util.h"
    ++#include "config.h"
    + #include "contrib/libgit-sys/public_symbol_export.h"
    + #include "version.h"
      
    -+.PHONY: libgit-sys
    -+libgit-sys:
    -+	$(QUIET)(\
    -+		cd contrib/libgit-sys && \
    -+		cargo build \
    -+	)
    -+.PHONY: libgit-rs
    -+libgit-rs:
    -+	$(QUIET)(\
    -+		cd contrib/libgit-rs && \
    -+		cargo build \
    -+	)
    -+ifdef INCLUDE_LIBGIT_RS
    -+all:: libgit-rs
    -+endif
    -+
    - contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
    - 	$(LD) -r $^ -o $@
    + #pragma GCC visibility push(default)
      
    ++struct libgit_config_set *libgit_configset_alloc(void)
    ++{
    ++	struct config_set *cs = xmalloc(sizeof(struct config_set));
    ++	git_configset_init(cs);
    ++	return (struct libgit_config_set *) cs;
    ++}
    ++
    ++void libgit_configset_free(struct libgit_config_set *cs)
    ++{
    ++	git_configset_clear((struct config_set *) cs);
    ++	free((struct config_set *) cs);
    ++}
    ++
    ++int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
    ++{
    ++	return git_configset_add_file((struct config_set *) cs, filename);
    ++}
    ++
    ++int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
    ++{
    ++	return git_configset_get_int((struct config_set *) cs, key, dest);
    ++}
    ++
    ++int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
    ++{
    ++	return git_configset_get_string((struct config_set *) cs, key, dest);
    ++}
    ++
    + const char *libgit_user_agent(void)
    + {
    + 	return git_user_agent();
     
    - ## contrib/libgit-sys/build.rs ##
    -@@ contrib/libgit-sys/build.rs: pub fn main() -> std::io::Result<()> {
    -         .env_remove("PROFILE")
    -         .current_dir(git_root.clone())
    -         .args([
    --            "CFLAGS=-fvisibility=hidden",
    -+            "INCLUDE_LIBGIT_RS=YesPlease",
    -             "contrib/libgit-sys/libgitpub.a",
    -         ])
    -         .output()
    + ## contrib/libgit-sys/public_symbol_export.h ##
    +@@
    + #ifndef PUBLIC_SYMBOL_EXPORT_H
    + #define PUBLIC_SYMBOL_EXPORT_H
    + 
    ++struct libgit_config_set *libgit_configset_alloc(void);
    ++
    ++void libgit_configset_free(struct libgit_config_set *cs);
    ++
    ++int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename);
    ++
    ++int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest);
    ++
    ++int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
    ++
    + const char *libgit_user_agent(void);
    + 
    + const char *libgit_user_agent_sanitized(void);
     
    - ## t/Makefile ##
    -@@ t/Makefile: perf:
    + ## contrib/libgit-sys/src/lib.rs ##
    +@@
    + #[cfg(has_std__ffi__c_char)]
    +-use std::ffi::c_char;
    ++use std::ffi::{c_char, c_int};
    + 
    + #[cfg(not(has_std__ffi__c_char))]
    + #[allow(non_camel_case_types)]
    + pub type c_char = i8;
    + 
    ++#[cfg(not(has_std__ffi__c_char))]
    ++#[allow(non_camel_case_types)]
    ++pub type c_int = i32;
    ++
    + extern crate libz_sys;
    + 
    ++#[allow(non_camel_case_types)]
    ++#[repr(C)]
    ++pub struct libgit_config_set {
    ++    _data: [u8; 0],
    ++    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
    ++}
    ++
    + extern "C" {
    +     pub fn libgit_user_agent() -> *const c_char;
    +     pub fn libgit_user_agent_sanitized() -> *const c_char;
    ++
    ++    pub fn libgit_configset_alloc() -> *mut libgit_config_set;
    ++    pub fn libgit_configset_free(cs: *mut libgit_config_set);
    ++
    ++    pub fn libgit_configset_add_file(cs: *mut libgit_config_set, filename: *const c_char) -> c_int;
    ++
    ++    pub fn libgit_configset_get_int(
    ++        cs: *mut libgit_config_set,
    ++        key: *const c_char,
    ++        int: *mut c_int,
    ++    ) -> c_int;
    ++
    ++    pub fn libgit_configset_get_string(
    ++        cs: *mut libgit_config_set,
    ++        key: *const c_char,
    ++        dest: *mut *mut c_char,
    ++    ) -> c_int;
    ++
    + }
      
    - .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
    - 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
    -+
    -+.PHONY: libgit-sys-test
    -+libgit-sys-test:
    -+	$(QUIET)(\
    -+		cd ../contrib/libgit-sys && \
    -+		cargo test \
    -+	)
    -+.PHONY: libgit-rs-test
    -+libgit-rs-test:
    -+	$(QUIET)(\
    -+		cd ../contrib/libgit-rs && \
    -+		cargo test \
    -+	)
    -+ifdef INCLUDE_LIBGIT_RS
    -+all:: libgit-sys-test libgit-rs-test
    -+endif
    + #[cfg(test)]
4:  65166ea0c0 ! 4:  88425bb0b1 libgit: add higher-level libgit crate
    @@ .gitignore: Release/
      /contrib/libgit-sys/target
     
      ## Makefile ##
    +@@ Makefile: include shared.mak
    + # programs in oss-fuzz/.
    + #
    + # Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
    +-# test the Rust crate in contrib/libgit-sys.
    ++# test the Rust crates in contrib/libgit-sys and contrib/libgit-rs.
    + #
    + # === Optional library: libintl ===
    + #
     @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
      	$(MAKE) -C Documentation/ clean
      	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
     -	$(RM) -r contrib/libgit-sys/target
    -+	$(RM) -r contrib/libgit-rs/target contrib/libgit-sys/target
    - 	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
    - 	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
    - 	$(RM) -r contrib/libgit-sys/libgitpub.a
    ++	$(RM) -r contrib/libgit-sys/target contrib/libgit-rs/target
    + 	$(RM) contrib/libgit-sys/partial_symbol_export.o
    + 	$(RM) contrib/libgit-sys/hidden_symbol_export.o
    + 	$(RM) contrib/libgit-sys/libgitpub.a
    +@@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
    + unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
    + 	$(MAKE) -C t/ unit-tests
    + 
    +-.PHONY: libgit-sys
    ++.PHONY: libgit-sys libgit-rs
    + libgit-sys:
    + 	$(QUIET)(\
    + 		cd contrib/libgit-sys && \
    + 		cargo build \
    + 	)
    ++libgit-rs:
    ++	$(QUIET)(\
    ++		cd contrib/libgit-rs && \
    ++		cargo build \
    ++	)
    + ifdef INCLUDE_LIBGIT_RS
    +-all:: libgit-sys
    ++all:: libgit-sys libgit-rs
    + endif
    + 
    + contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
     
      ## contrib/libgit-rs/Cargo.lock (new) ##
     @@
    @@ contrib/libgit-rs/Cargo.toml (new)
     +version = "0.1.0"
     +edition = "2021"
     +build = "build.rs"
    -+rust-version = "1.63"
    ++rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
    ++                      # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
    ++
     +
     +[lib]
     +path = "src/lib.rs"
    @@ contrib/libgit-rs/build.rs (new)
     +    ac.emit_has_path("std::ffi::c_char");
     +}
     
    - ## contrib/libgit-rs/src/lib.rs (new) ##
    + ## contrib/libgit-rs/src/config.rs (new) ##
     @@
     +use std::ffi::{c_void, CStr, CString};
     +use std::path::Path;
    @@ contrib/libgit-rs/src/lib.rs (new)
     +
     +#[cfg(not(has_std__ffi__c_char))]
     +#[allow(non_camel_case_types)]
    -+pub type c_char = i8;
    ++type c_char = i8;
     +
     +#[cfg(not(has_std__ffi__c_char))]
     +#[allow(non_camel_case_types)]
    -+pub type c_int = i32;
    ++type c_int = i32;
     +
     +use libgit_sys::*;
     +
    ++/// A ConfigSet is an in-memory cache for config-like files such as `.gitmodules` or `.gitconfig`.
    ++/// It does not support all config directives; notably, it will not process `include` or
    ++/// `includeIf` directives (but it will store them so that callers can choose whether and how to
    ++/// handle them).
     +pub struct ConfigSet(*mut libgit_config_set);
     +impl ConfigSet {
    ++    /// Allocate a new ConfigSet
     +    pub fn new() -> Self {
     +        unsafe { ConfigSet(libgit_configset_alloc()) }
     +    }
     +
    ++    /// Load the given files into the ConfigSet; conflicting directives in later files will
    ++    /// override those given in earlier files.
     +    pub fn add_files(&mut self, files: &[&Path]) {
     +        for file in files {
     +            let pstr = file.to_str().expect("Invalid UTF-8");
    @@ contrib/libgit-rs/src/lib.rs (new)
     +        }
     +    }
     +
    ++    /// Load the value for the given key and attempt to parse it as an i32. Dies with a fatal error
    ++    /// if the value cannot be parsed. Returns None if the key is not present.
     +    pub fn get_int(&mut self, key: &str) -> Option<i32> {
     +        let key = CString::new(key).expect("Couldn't convert to CString");
     +        let mut val: c_int = 0;
    @@ contrib/libgit-rs/src/lib.rs (new)
     +        Some(val.into())
     +    }
     +
    ++    /// Clones the value for the given key. Dies with a fatal error if the value cannot be
    ++    /// converted to a String. Returns None if the key is not present.
     +    pub fn get_string(&mut self, key: &str) -> Option<String> {
     +        let key = CString::new(key).expect("Couldn't convert key to CString");
     +        let mut val: *mut c_char = std::ptr::null_mut();
    @@ contrib/libgit-rs/src/lib.rs (new)
     +    }
     +}
     
    + ## contrib/libgit-rs/src/lib.rs (new) ##
    +@@
    ++pub mod config;
    +
      ## contrib/libgit-rs/testdata/config1 (new) ##
     @@
     +[trace2]
    @@ contrib/libgit-sys/src/lib.rs: pub struct libgit_config_set {
          pub fn libgit_user_agent() -> *const c_char;
          pub fn libgit_user_agent_sanitized() -> *const c_char;
      
    +
    + ## t/Makefile ##
    +@@ t/Makefile: perf:
    + .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
    + 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
    + 
    +-.PHONY: libgit-sys-test
    ++.PHONY: libgit-sys-test libgit-rs-test
    + libgit-sys-test:
    + 	$(QUIET)(\
    + 		cd ../contrib/libgit-sys && \
    + 		cargo test \
    + 	)
    ++libgit-rs-test:
    ++	$(QUIET)(\
    ++		cd ../contrib/libgit-rs && \
    ++		cargo test \
    ++	)
    + ifdef INCLUDE_LIBGIT_RS
    +-all:: libgit-sys-test
    ++all:: libgit-sys-test libgit-rs-test
    + endif

base-commit: 757161efcca150a9a96b312d9e780a071e601a03
-- 
2.48.1.262.g85cc9f2d1e-goog

