Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3D1519BE
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595262; cv=none; b=jC5zaktTr9ZmLftKXdemD1zwp1EkCD+itzLxkE3iysg2vRP6aiJWXWej0TaWjC/+MxATKZtMog8hQHHxNeoyfRfksw/tBthPkOMFE/E3Gbr28Rd+LXzgYXxhUbaJwgDanj9mLcmyDZv2muPL1b0XhdiXcYIIlXqpyylKFHrDSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595262; c=relaxed/simple;
	bh=2nTsyrGHw+XCmRPukf5pU1cwCi6d7mTdzOzxBS71ib0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6k7uL7sgwJxIY5zeKD21YptLudy9YOrelWfGcSkeckShVhzgD6YiIJwBsmU3wP0tlPgYKkaWzsLFz93kbveuyaCBZv3f/2k3sDnxdovRgE4L9TxNvj1nKyDLaLIdnGjurlvHFCHJJVpAts0MYpz4cpHDrXOezV37EhBdCM25qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ztl748A/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ztl748A/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2264c423e37so60151225ad.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595258; x=1743200058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuGERBik4HT2lKH4rQ9bnF6QK3BCUniO5qbigeP6qHY=;
        b=Ztl748A/RT2plJIy7P7t0zcEZFT+X3NMsNLWiVxoum7rPjWfyG9Dmr7JsPl+tDg3wC
         lUaXqU7sP4QUi9gOH6kZw/sOLUFMZw+0C9Dp9NJIosKWx9MGsBwEgnO5ZvWwBAY031mQ
         hiPk2xKtk8jmsWWyAGhnmz/9cLFcjiEGXbU/tjz1XWzWfuip96HdJbrUdFGy+yyiCy1Z
         8OwNvkb8SbGegGxy4fkkbvSfVaZVM0zOxStq9BhpHoYQLqz2wr8RST6X4XXFsff4USwF
         Ok0z5wxDq96GpOgw0ee6pSN31L82quMvVrzyET6RZuOW/3xsU5tv/nfK0tDUApIdXmst
         tq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595258; x=1743200058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuGERBik4HT2lKH4rQ9bnF6QK3BCUniO5qbigeP6qHY=;
        b=OjBr3ecCb+zjTM8BXaVv7SzFpTZP27oDjqr1aF2p4LLUPUklluxJr10a+5433Lcbwk
         Ahm7detkp7LGnhzy9o2QI4c5tPvoTm1tQrnbjniJbwPHR8SUNWSDqAPaF2/va05/2foM
         ill0YEZm2930/a20dEutDBpo2Odor7rZ6w9CtxObPt2JU/Vg1yHtA9juL8RItuTioxSZ
         gcGyMAkJZuSUOBOidF/UF3G3V0ak3DYpZXohhXYyWNcDXzwIxsGqPnIiJYNyP6bB/B1X
         P/VtX0zKQPRBOWnyEIRlRjowCkY9ThrVoSaOgZxwpSwr3O8vX4IXF+V/YKq3y8vfP8l3
         Cqhw==
X-Gm-Message-State: AOJu0Yx7GHQVU5CfP/44DSmbB3++LF3rF9XVrrWMxMalvtEWx2PyJr2I
	GwJLn5mkt2q1JGvE8UJsPZNsHFXQXJu2rLhhyAqK0zZpHnvmtw2R1DYzBgVZdtFLHA49HF8IIyO
	9taItGjOEKHdrskgdsOrMOT2rxEBcI0m1TdHeArfIHX4Vd6BhdNxZBvUYjKCOMK/alqaMFNus1Q
	crSGaK4XiXjOUhTqlwLueZdyQ9VceRsKc+Ve2MTV4=
X-Google-Smtp-Source: AGHT+IGU5yucxAB+Pl0GnmgobqyjAEmMPnmUNzR+eY9zssnDIR4O14r5ExV/4ZkBn0IPoP6mf/RI84uBuQCvBQ==
X-Received: from pfuv10.prod.google.com ([2002:a05:6a00:148a:b0:736:3cd5:ba3a])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1409:b0:737:e73:f64b with SMTP id d2e1a72fcca58-7390593b7ffmr6905335b3a.1.1742595258010;
 Fri, 21 Mar 2025 15:14:18 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:08 -0700
In-Reply-To: <cover.1742594960.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net> <cover.1742594960.git.steadmon@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
Subject: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and build out
 of tree
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Unlike `cargo build`, `cargo package` does not get access to the entire Git repo
containing a Rust crate. Instead, it prepares a directory starting from the
crate root (potentially excluding files, such as those not under version
control, or explicity excluded in the Cargo.toml file).

This means that the current method of building the libgit-sys crate does not
work with `cargo package`, as it tries to execute the Makefile from "../.."
relative to the crate root.

Fix this by adding a `git-src` symlink in the crate that points to the Git
repository root. `cargo package` will flatten this to a copy of the Git repo,
excluding non-version-controlled files, any explicitly-excluded files, and trees
that contain a Cargo.toml file (this prevents infinite recursion on the
symlink).

We can then execute the Makefile under the flattened git-src directory from our
build.rs script. However, this exposes a second problem; Cargo will check that
the build script does not add, delete, or modify any files in the source tree.
Without further changes, Cargo complains about the object files and other
generated files created during the build.

To avoid this problem, add a CARGO_OUT_DIR variable to the Makefile. When this
is set, object files and other generated files will be created there, rather
than in the main source tree. This change has only been applied to files created
as part of the libgitpub.a build, to avoid unnecessary churn in the Makefile.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                    | 135 +++++++++++++++++++++---------------
 contrib/libgit-sys/build.rs |   7 +-
 contrib/libgit-sys/git-src  |   1 +
 shared.mak                  |   5 ++
 4 files changed, 91 insertions(+), 57 deletions(-)
 create mode 120000 contrib/libgit-sys/git-src

diff --git a/Makefile b/Makefile
index 52eed88dde..91677448ba 100644
--- a/Makefile
+++ b/Makefile
@@ -420,6 +420,9 @@ include shared.mak
 # Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
 # test the Rust crates in contrib/libgit-sys and contrib/libgit-rs.
 #
+# Define CARGO_OUT_DIR to specify a directory where object files and other files
+# generated during the build of libgitpub.a should be created.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -699,6 +702,7 @@ THIRD_PARTY_SOURCES =
 UNIT_TEST_PROGRAMS =
 UNIT_TEST_DIR = t/unit-tests
 UNIT_TEST_BIN = $(UNIT_TEST_DIR)/bin
+CARGO_OUT_DIR =
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -917,11 +921,21 @@ export PYTHON_PATH
 
 TEST_SHELL_PATH = $(SHELL_PATH)
 
-LIB_FILE = libgit.a
-XDIFF_LIB = xdiff/lib.a
-REFTABLE_LIB = reftable/libreftable.a
+### Generated files which may need to live in Cargo output directory
+
+GIT_CFLAGS = $(call maybe_join_path,$(CARGO_OUT_DIR),GIT-CFLAGS)
+GIT_PREFIX = $(call maybe_join_path,$(CARGO_OUT_DIR),GIT-PREFIX)
+GIT_USER_AGENT_FILE = $(call maybe_join_path,$(CARGO_OUT_DIR),GIT-USER-AGENT)
+GIT_VERSION_FILE = $(call maybe_join_path,$(CARGO_OUT_DIR),GIT-VERSION-FILE)
+GIT_VERSION_PATH = $(dir $(GIT_VERSION_FILE))$(notdir $(GIT_VERSION_FILE))
+COMMAND_LIST_H = $(call maybe_join_path,$(CARGO_OUT_DIR),command-list.h)
+VERSION_DEF_H = $(call maybe_join_path,$(CARGO_OUT_DIR),version-def.h)
 
-GENERATED_H += command-list.h
+LIB_FILE = $(call maybe_join_path,$(CARGO_OUT_DIR),libgit.a)
+XDIFF_LIB = $(call maybe_join_path,$(CARGO_OUT_DIR),xdiff/lib.a)
+REFTABLE_LIB = $(call maybe_join_path,$(CARGO_OUT_DIR),reftable/libreftable.a)
+
+GENERATED_H += $(COMMAND_LIST_H)
 GENERATED_H += config-list.h
 GENERATED_H += hook-list.h
 GENERATED_H += $(UNIT_TEST_DIR)/clar-decls.h
@@ -1472,7 +1486,7 @@ ifdef DEVELOPER
 include config.mak.dev
 endif
 
-GIT-VERSION-FILE: FORCE
+$(GIT_VERSION_FILE): FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
 	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
 	NEW=$$(cat $@ 2>/dev/null || :) && \
@@ -1482,7 +1496,7 @@ GIT-VERSION-FILE: FORCE
 # otherwise any user-provided value for GIT_VERSION would have been overridden
 # already.
 GIT_VERSION_OVERRIDE := $(GIT_VERSION)
--include GIT-VERSION-FILE
+-include $(GIT_VERSION_FILE)
 
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
@@ -2403,9 +2417,9 @@ endif
 GIT_USER_AGENT_SQ = $(subst ','\'',$(GIT_USER_AGENT))
 GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
 GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
-GIT-USER-AGENT: FORCE
-	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat GIT-USER-AGENT 2>/dev/null`"; then \
-		echo '$(GIT_USER_AGENT_SQ)' >GIT-USER-AGENT; \
+$(GIT_USER_AGENT_FILE): FORCE
+	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat $(GIT_USER_AGENT_FILE) 2>/dev/null`"; then \
+		echo '$(GIT_USER_AGENT_SQ)' >$(GIT_USER_AGENT_FILE); \
 	fi
 
 ifdef DEFAULT_HELP_FORMAT
@@ -2523,7 +2537,7 @@ strip: $(PROGRAMS) git$X
 #   dependencies here will not need to change if the force-build
 #   details change some day.
 
-git.sp git.s git.o: GIT-PREFIX
+git.sp git.s git.o: $(GIT_PREFIX)
 git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2533,10 +2547,10 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
-help.sp help.s help.o: command-list.h
+help.sp help.s $(call maybe_join_path,$(CARGO_OUT_DIR),help.o): $(COMMAND_LIST_H)
 builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h $(GIT_PREFIX)
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2545,13 +2559,13 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
 PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
-pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
+pager.sp pager.s $(call maybe_join_path,$(CARGO_OUT_DIR),pager.o): EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
-version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
+$(VERSION_DEF_H): version-def.h.in GIT-VERSION-GEN $(GIT_VERSION_FILE) $(GIT_USER_AGENT_FILE)
 	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
-version.sp version.s version.o: version-def.h
+version.sp version.s $(call maybe_join_path,$(CARGO_OUT_DIR),version.o): $(VERSION_DEF_H)
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -2564,9 +2578,9 @@ config-list.h: generate-configlist.sh
 config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
 
-command-list.h: generate-cmdlist.sh command-list.txt
+$(COMMAND_LIST_H): generate-cmdlist.sh command-list.txt
 
-command-list.h: $(wildcard Documentation/git*.adoc)
+$(COMMAND_LIST_H): $(wildcard Documentation/git*.adoc)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		. $@
@@ -2589,10 +2603,10 @@ $(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh generate-script.sh GIT-BUILD-OPTIONS G
 	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
 	mv $@+ $@
 
-git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
+git.rc: git.rc.in GIT-VERSION-GEN $(GIT_VERSION_FILE)
 	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
-git.res: git.rc GIT-PREFIX
+git.res: git.rc $(GIT_PREFIX)
 	$(QUIET_RC)$(RC) -i $< -o $@
 
 # This makes sure we depend on the NO_PERL setting itself.
@@ -2626,8 +2640,8 @@ endif
 
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
-$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@+" && \
+$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER $(GIT_VERSION_FILE)
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION_PATH) GIT-PERL-HEADER "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
@@ -2691,7 +2705,7 @@ CONFIGURE_RECIPE = sed -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
 		   autoconf -o configure configure.ac+ && \
 		   $(RM) configure.ac+
 
-configure: configure.ac GIT-VERSION-FILE
+configure: configure.ac $(GIT_VERSION_FILE)
 	$(QUIET_GEN)$(CONFIGURE_RECIPE)
 
 ifdef AUTOCONFIGURED
@@ -2774,6 +2788,14 @@ endif
 .PHONY: objects
 objects: $(OBJECTS)
 
+ifdef CARGO_OUT_DIR
+OBJECTS := $(addprefix $(CARGO_OUT_DIR)/,$(OBJECTS))
+LIB_OBJS := $(addprefix $(CARGO_OUT_DIR)/,$(LIB_OBJS))
+REFTABLE_OBJS := $(addprefix $(CARGO_OUT_DIR)/,$(REFTABLE_OBJS))
+XDIFF_OBJS := $(addprefix $(CARGO_OUT_DIR)/,$(XDIFF_OBJS))
+BASIC_CFLAGS += -I$(CARGO_OUT_DIR)
+endif
+
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 
@@ -2805,10 +2827,15 @@ missing_compdb_dir =
 compdb_args =
 endif
 
-$(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+ifdef CARGO_OUT_DIR
+$(OBJECTS): $(CARGO_OUT_DIR)/%.o: %.c $(GIT_CFLAGS) $(missing_dep_dirs) $(missing_compdb_dir)
+	$(QUIET_CC)$(CC) -o $(CARGO_OUT_DIR)/$*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+else
+$(OBJECTS): %.o: %.c $(GIT_CFLAGS) $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+endif
 
-%.s: %.c GIT-CFLAGS FORCE
+%.s: %.c $(GIT_CFLAGS) FORCE
 	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
@@ -2829,27 +2856,27 @@ compile_commands.json:
 	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
 endif
 
-exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
-exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
+exec-cmd.sp exec-cmd.s $(call maybe_join_path,$(CARGO_OUT_DIR),exec-cmd.o): $(GIT_PREFIX)
+exec-cmd.sp exec-cmd.s $(call maybe_join_path,$(CARGO_OUT_DIR),exec-cmd.o): EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
-setup.sp setup.s setup.o: GIT-PREFIX
-setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
+setup.sp setup.s $(call maybe_join_path,$(CARGO_OUT_DIR),setup.o): $(GIT_PREFIX)
+setup.sp setup.s $(call maybe_join_path,$(CARGO_OUT_DIR),setup.o): EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.sp config.s config.o: GIT-PREFIX
-config.sp config.s config.o: EXTRA_CPPFLAGS = \
+config.sp config.s $(call maybe_join_path,$(CARGO_OUT_DIR),config.o): $(GIT_PREFIX)
+config.sp config.s $(call maybe_join_path,$(CARGO_OUT_DIR),config.o): EXTRA_CPPFLAGS = \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-attr.sp attr.s attr.o: GIT-PREFIX
-attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
+attr.sp attr.s $(call maybe_join_path,$(CARGO_OUT_DIR),attr.o): $(GIT_PREFIX)
+attr.sp attr.s $(call maybe_join_path,$(CARGO_OUT_DIR),attr.o): EXTRA_CPPFLAGS = \
 	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
-gettext.sp gettext.s gettext.o: GIT-PREFIX
-gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
+gettext.sp gettext.s $(call maybe_join_path,$(CARGO_OUT_DIR),gettext.o): $(GIT_PREFIX)
+gettext.sp gettext.s $(call maybe_join_path,$(CARGO_OUT_DIR),gettext.o): EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
 http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
@@ -2872,7 +2899,7 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
 endif
 
-headless-git.o: compat/win32/headless.c GIT-CFLAGS
+headless-git.o: compat/win32/headless.c $(GIT_CFLAGS)
 	$(QUIET_CC)$(CC) $(ALL_CFLAGS) $(COMPAT_CFLAGS) \
 		-fno-stack-protector -o $@ -c -Wall -Wwrite-strings $<
 
@@ -3116,9 +3143,9 @@ endif
 NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
-perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS GIT-VERSION-FILE GIT-PERL-DEFINES
+perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS $(GIT_VERSION_FILE) GIT-PERL-DEFINES
 	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@"
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION_PATH) GIT-PERL-HEADER "$<" "$@"
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(call mkdir_p_parent_template)
@@ -3146,20 +3173,20 @@ cscope: cscope.out
 TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
 		$(localedir_SQ)
 
-GIT-PREFIX: FORCE
+$(GIT_PREFIX): FORCE
 	@FLAGS='$(TRACK_PREFIX)'; \
-	if test x"$$FLAGS" != x"`cat GIT-PREFIX 2>/dev/null`" ; then \
+	if test x"$$FLAGS" != x"`cat $(GIT_PREFIX) 2>/dev/null`" ; then \
 		echo >&2 "    * new prefix flags"; \
-		echo "$$FLAGS" >GIT-PREFIX; \
+		echo "$$FLAGS" >$(GIT_PREFIX); \
 	fi
 
 TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):$(USE_GETTEXT_SCHEME)
 
-GIT-CFLAGS: FORCE
+$(GIT_CFLAGS): FORCE
 	@FLAGS='$(TRACK_CFLAGS)'; \
-	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
+	    if test x"$$FLAGS" != x"`cat $(GIT_CFLAGS) 2>/dev/null`" ; then \
 		echo >&2 "    * new build flags"; \
-		echo "$$FLAGS" >GIT-CFLAGS; \
+		echo "$$FLAGS" >$(GIT_CFLAGS); \
             fi
 
 TRACK_LDFLAGS = $(subst ','\'',$(ALL_LDFLAGS))
@@ -3751,7 +3778,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
-	$(RM) version-def.h
+	$(RM) $(VERSION_DEF_H)
 	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) $(test_bindir_programs)
 	$(RM) -r po/build/
@@ -3774,8 +3801,8 @@ ifndef NO_TCLTK
 	$(MAKE) -C gitk-git clean
 	$(MAKE) -C git-gui clean
 endif
-	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
-	$(RM) GIT-USER-AGENT GIT-PREFIX
+	$(RM) $(GIT_VERSION_FILE) $(GIT_CFLAGS) GIT-LDFLAGS GIT-BUILD-OPTIONS
+	$(RM) $(GIT_USER_AGENT_FILE) $(GIT_PREFIX)
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
 ifdef MSVC
 	$(RM) $(patsubst %.o,%.o.pdb,$(OBJECTS))
@@ -3937,14 +3964,14 @@ ifdef INCLUDE_LIBGIT_RS
 all:: libgit-sys libgit-rs
 endif
 
-LIBGIT_PUB_OBJS += contrib/libgitpub/public_symbol_export.o
-LIBGIT_PUB_OBJS += libgit.a
-LIBGIT_PUB_OBJS += reftable/libreftable.a
-LIBGIT_PUB_OBJS += xdiff/lib.a
-
-LIBGIT_PARTIAL_EXPORT = contrib/libgitpub/partial_symbol_export.o
+LIBGIT_PUB_OBJS += $(CARGO_OUT_DIR)/contrib/libgitpub/public_symbol_export.o
+LIBGIT_PUB_OBJS += $(LIB_FILE)
+LIBGIT_PUB_OBJS += $(REFTABLE_LIB)
+LIBGIT_PUB_OBJS += $(XDIFF_LIB)
 
-LIBGIT_HIDDEN_EXPORT = contrib/libgitpub/hidden_symbol_export.o
+LIBGIT_PARTIAL_EXPORT = $(CARGO_OUT_DIR)/contrib/libgitpub/partial_symbol_export.o
+LIBGIT_HIDDEN_EXPORT = $(CARGO_OUT_DIR)/contrib/libgitpub/hidden_symbol_export.o
+GITPUB_LIB = $(call maybe_join_path,$(CARGO_OUT_DIR),contrib/libgitpub/libgitpub.a)
 
 $(LIBGIT_PARTIAL_EXPORT): $(LIBGIT_PUB_OBJS)
 	$(LD) -r $^ -o $@
@@ -3952,5 +3979,5 @@ $(LIBGIT_PARTIAL_EXPORT): $(LIBGIT_PUB_OBJS)
 $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 	$(OBJCOPY) --localize-hidden $^ $@
 
-contrib/libgitpub/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
+$(GITPUB_LIB): $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
index e0d979c196..19407663f5 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -6,7 +6,7 @@ pub fn main() -> std::io::Result<()> {
     ac.emit_has_path("std::ffi::c_char");
 
     let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
-    let git_root = crate_root.join("../..");
+    let git_root = crate_root.join("git-src");
     let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
 
     let make_output = make_cmd::gnu_make()
@@ -14,8 +14,9 @@ pub fn main() -> std::io::Result<()> {
         .env_remove("PROFILE")
         .current_dir(git_root.clone())
         .args([
+            &format!("CARGO_OUT_DIR={}", dst.display()),
             "INCLUDE_LIBGIT_RS=YesPlease",
-            "contrib/libgitpub/libgitpub.a",
+            &format!("{}/contrib/libgitpub/libgitpub.a", dst.display()),
         ])
         .output()
         .expect("Make failed to run");
@@ -26,8 +27,8 @@ pub fn main() -> std::io::Result<()> {
             String::from_utf8(make_output.stderr).unwrap()
         );
     }
-    std::fs::copy(git_root.join("contrib/libgitpub/libgitpub.a"), dst.join("libgitpub.a"))?;
     println!("cargo:rustc-link-search=native={}", dst.display());
+    println!("cargo:rustc-link-search=native={}", dst.join("contrib/libgitpub").display());
     println!("cargo:rustc-link-lib=gitpub");
     println!("cargo:rerun-if-changed={}", git_root.display());
 
diff --git a/contrib/libgit-sys/git-src b/contrib/libgit-sys/git-src
new file mode 120000
index 0000000000..c25bddb6dd
--- /dev/null
+++ b/contrib/libgit-sys/git-src
@@ -0,0 +1 @@
+../..
\ No newline at end of file
diff --git a/shared.mak b/shared.mak
index 1a99848a95..0dc611dd90 100644
--- a/shared.mak
+++ b/shared.mak
@@ -127,3 +127,8 @@ GIT_USER_AGENT="$(GIT_USER_AGENT)" \
 GIT_VERSION="$(GIT_VERSION_OVERRIDE)" \
 $(SHELL_PATH) "$(1)/GIT-VERSION-GEN" "$(1)" "$(2)" "$(3)"
 endef
+
+# Apply a path prefix if the prefix is non-empty
+define maybe_join_path
+$(if $(1),$(1)/$(2),$(2))
+endef
-- 
2.49.0.395.g12beb8f557-goog

