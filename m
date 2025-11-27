Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECD28C2A1
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205847; cv=none; b=BWVlLzXgOXekOMn5YIAvaNeAG4LKR1NlaPilCVAVXllgdzgGwKo5r9aY21/oGD7MtCb472YjetU2ideKcEpyPnCQsgiDaQ6yUtph+XVdDYR0ANMbhjrqMRjnWHAU7I6FaI531XI4Eievuktk+W7ozJZQRkWtqtAbSt1bQxC5PNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205847; c=relaxed/simple;
	bh=7RM7z4JN6H6Ir+BibaG0JSiTuB409DrVsgwECODN/ww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fpPdfrsAsMU4Q+O1UVurIey2roiAFwRSaoUYQawdpF5MX3Ym9jOOOiVqqQgi7mBKI7GWC5bKyXXEpz7Bj8baNli/hz59ZjG1UELszoHkLdIU31ZOB1gA1qpN21/fS5YylI3zKJ+AmWqL8GGfDuJlWfgPUEOcoSrG6bjh6LhefTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/U8gqBs; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/U8gqBs"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4336f8e97c3so2242275ab.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205843; x=1764810643; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBLr2FeJ1hjSHMOpMHhMORdg6ubYoW3g74KEYpVWhhQ=;
        b=O/U8gqBspFr7LnDoPhLIlGggh/lYN5dDzc+xvR6Kw/Bg6uSGp7pZcQek3h8kiSLPSh
         5H5zBxciImmQ6KIbRgSr+q+2R/UD+zsEjylMIvYVe2bNHsib/gIn8Hmaez3OXI3sfny+
         k8x3qbIXNFQK8S2krZ7c18qyGcEdsK8EZ54Zk/G90RWBeesdoUOe1RnIY3CMS/wOcytX
         PyjUYgxbdZEhmFLMiiA8EMJR+bYskwaGbHTurXNm09jcijKyY1cb2IOwcbcYTR/dinrc
         B/BdDJF8jwi+ndQYNue2sja1s8CiGNWG2FYFAHwZw3S4xtOzG3ahMzdnRjT0cQSNM2to
         Pwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205843; x=1764810643;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OBLr2FeJ1hjSHMOpMHhMORdg6ubYoW3g74KEYpVWhhQ=;
        b=L60gernmck8WgnMN74WuEURDIcIGHZ5x7rgxXGzJgGGGWswD2AuCV/MTvqHOUNYzVR
         +Czw9vibd39cU3RJk3rpD8DFm57yHuKrPhcRE/I4hP2/BqVrgedWJjVsEBywKQEQRVLK
         NfyZ4c+QzUW7ByPUN6fR6X1GBzT+tUh5MCwMF+N1dmwgm+p3kDnuobMCxvYIxCddKR5Q
         5cd52mWoQqm6FJ+5bTXOL/weqvE07sUYHC281BpNxyRWu4iJMQiBdDRK/kJG5RVECSPR
         cFn3yrF713Zrfj//e7ot7+LCS07Nt8e/imP2OizIjySHmi5Mkn7/OL56xd44ZGJpQFrG
         VjSA==
X-Gm-Message-State: AOJu0YzhQGvEZ24FW0FGIqvVdn4t36edUYPvE91Pwmstmkdwp6DSKujr
	v+cNNjt7NUgb9T4m89M4/OmxJDuP88DVApNp2HVidL3K5fe7pAxTtuHO27dxaQ==
X-Gm-Gg: ASbGnctWCI4Ey5aum+JOfIpKeTtr3dqF+Gaq55xXiRSUPehvzDKgm79nVMLPkYbRnYN
	BZgdtdiraxKGFS75q7mZ03DA1rqLmLVxyVXX3V6TWlT7GPIBXNquYhxbq6NJ0jy9ohs2OdIw+XT
	5kqVokJ+mnxkYfcS8fz56GNG2/mdo2fg+J9M7ogxcWiWklswlaj+yJBMoPBSY4DDHWGoGVNUrDF
	08rK2/hsD1ENrfeMFN0wZM3+eILm5ArU4tqy83CyOsE//drCi/8L65hiSwJ5RchOR0uYTwEwTfr
	ReHcO2RdZeJtigJ+ykYcTFsLnDgOZQHXbe2kPJ/a+K1wHAFYEzp2ZXJejrxgEUJF94F6om5dP+J
	XE4+OFkiJ23+qNbKtzDUCnCVn6DWn/XcIrTLUqzNkDgfAB3RcckDniSQsrxy7pfLpBTNKnudDuo
	M2jS+ACMfagv7zvAOBWSPcBAkj
X-Google-Smtp-Source: AGHT+IGU0nMICD04/5MVOYlqaYfky6iqLlftSiBnONg+0HZQrsv7BYbHJcWXZSnLjlQw7hsCW3lvnw==
X-Received: by 2002:a05:6e02:2487:b0:430:ac49:b3b1 with SMTP id e9e14a558f8ab-435b8c09914mr163282865ab.12.1764205843389;
        Wed, 26 Nov 2025 17:10:43 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436a530c093sm801695ab.15.2025.11.26.17.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:42 -0800 (PST)
Message-Id: <a4b79e70c152a8774b59822763045456a8c6b828.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:26 +0000
Subject: [PATCH 04/13] build: build Rust with Makefile and Meson
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile            | 91 ++++++++++++++++++++++++++++++++++++++-------
 meson.build         | 63 ++++++++++++++++++++++++++++++-
 rust/build-crate.sh | 58 +++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 15 deletions(-)
 create mode 100755 rust/build-crate.sh

diff --git a/Makefile b/Makefile
index 28bc00e648..0aa6b3ae73 100644
--- a/Makefile
+++ b/Makefile
@@ -483,6 +483,14 @@ include shared.mak
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
 # in /foo/bar/include and /foo/bar/lib directories.
 #
+# == Optional Rust support ==
+#
+# Define WITH_RUST=false if you don't want to include features and subsystems
+# written in Rust into Git. For now, Rust is still an optional feature of the
+# build process. With Git 3.0 though, Rust will be mandatory.
+#
+# Building Rust code requires Cargo.
+#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -919,9 +927,55 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 
-GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
 
+GIT_BUILD_DIR := $(CURDIR)
+export GIT_BUILD_DIR
+
+RUST_CRATES := gitcore
+.PHONY: rust-compile rust-clean
+
+WITH_RUST ?= true
+ifeq ($(WITH_RUST),true)
+
+ifeq ($(DEBUG), 1)
+	RUST_BUILD_MODE := debug
+else
+	RUST_BUILD_MODE := release
+endif
+
+RUST_LIBS := $(foreach c,$(RUST_CRATES),$(GIT_BUILD_DIR)/lib$(c).a)
+
+rust-compile:
+	@for c in $(RUST_CRATES); do \
+		echo "Building $$c..."; \
+		./rust/build-crate.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $$c || exit $$?; \
+	done
+
+rust-clean:
+	$(RM) $(RUST_LIBS) Cargo.lock
+	cargo clean
+
+$(GIT_BUILD_DIR)/lib%.a:
+	echo $(RUST_LIBS)
+	./rust/build-crate.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*
+
+UNAME_S := $(shell uname -s)
+ifeq ($(UNAME_S),Linux)
+	EXTLIBS += -ldl
+endif
+
+else ifeq ($(WITH_RUST),false)
+rust-compile:
+	:
+rust-clean:
+	:
+else
+$(error 'WITH_RUST' must be true or false)
+endif
+
+GITLIBS = common-main.o $(LIB_FILE)
+
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
 ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
@@ -938,6 +992,11 @@ CC_LD_DYNPATH = -Wl,-rpath,
 BASIC_CFLAGS = -I.
 BASIC_LDFLAGS =
 
+ifeq ($(WITH_RUST),true)
+	BASIC_CFLAGS += -DWITH_RUST
+	BASIC_CFLAGS += -fPIE
+endif
+
 # library flags
 ARFLAGS = rcs
 PTHREAD_CFLAGS =
@@ -1303,7 +1362,9 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
+ifeq ($(WITH_RUST),false)
 LIB_OBJS += varint.o
+endif
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
@@ -2409,6 +2470,10 @@ endif
 # from the dependency list, that would make each entry appear twice.
 LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
+ifeq ($(WITH_RUST),true)
+LIBS += $(RUST_LIBS)
+endif
+
 BASIC_CFLAGS += $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
@@ -2564,7 +2629,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2889,17 +2954,17 @@ headless-git.o: compat/win32/headless.c GIT-CFLAGS
 headless-git$X: headless-git.o git.res GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -mwindows -o $@ $< git.res
 
-git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
+git-%$X: %.o GIT-LDFLAGS $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -2909,11 +2974,11 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
+scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -3286,7 +3351,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) rust-compile
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3751,7 +3816,7 @@ cocciclean:
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) contrib/coccinelle/*.cocci.patch
 
-clean: profile-clean coverage-clean cocciclean
+clean: profile-clean coverage-clean cocciclean rust-clean
 	$(RM) -r .build $(UNIT_TEST_BIN)
 	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
@@ -3907,13 +3972,13 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 .PHONY: fuzz-all
 fuzz-all: $(FUZZ_PROGRAMS)
 
-$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
+$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS rust-compile
 	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \
-	$(GITLIBS) GIT-LDFLAGS
+	$(GITLIBS) GIT-LDFLAGS rust-compile
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
@@ -3932,7 +3997,7 @@ $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h $(UNIT_TEST_DIR)/gene
 $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
 $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
-$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
+$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS rust-compile
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
diff --git a/meson.build b/meson.build
index 8966596ee8..94ec5e4ac0 100644
--- a/meson.build
+++ b/meson.build
@@ -267,6 +267,55 @@ version_gen_environment.set('GIT_DATE', get_option('build_date'))
 version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
 version_gen_environment.set('GIT_VERSION', get_option('version'))
 
+rust_crates = ['gitcore']
+
+rust_builds = []
+with_rust = get_option('with_rust')
+if with_rust
+  rustc = find_program('rustc', required : false)
+  cargo = find_program('cargo', required : false)
+
+  if not rustc.found() or not cargo.found()
+    error('Rust toolchain not found. Reconfigure with -Dwith_rust=false')
+  endif
+
+  if get_option('optimization') in ['2', '3', 's', 'z']
+    rust_build_profile = 'release'
+  else
+    rust_build_profile = 'debug'
+  endif
+
+  # Run `rustup show active-toolchain` and capture output
+  rustup_out = run_command('rustup', 'show', 'active-toolchain',
+                           check: true).stdout().strip()
+
+  rust_environment = script_environment
+
+  foreach crate : rust_crates
+    if rustup_out.contains('windows-msvc')
+      libfile = crate + '.lib'
+    else
+      libfile = 'lib' + crate + '.a'
+    endif
+
+    rust_builds += custom_target(
+      'rust_build_'+crate,
+      output: libfile,
+      build_by_default: true,
+      build_always_stale: true,
+      command: [
+        meson.project_source_root() / 'rust' / 'build-crate.sh',
+        meson.current_build_dir(), rust_build_profile, crate,
+      ],
+      install: false,
+      env: rust_environment,
+    )
+  endforeach
+else
+  message('Rust components disabled (-Dwith_rust=false)')
+endif
+
+
 compiler = meson.get_compiler('c')
 
 libgit_sources = [
@@ -548,6 +597,10 @@ libgit_sources = [
   'xdiff/xutils.c',
 ]
 
+if not with_rust
+  libgit_sources += 'varint.c'
+endif
+
 libgit_sources += custom_target(
   input: 'command-list.txt',
   output: 'command-list.h',
@@ -782,6 +835,10 @@ libgit_c_args = [
   '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
 ]
 
+if with_rust
+  libgit_c_args += '-DWITH_RUST'
+endif
+
 system_attributes = get_option('gitattributes')
 if system_attributes != ''
   libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
@@ -1274,6 +1331,7 @@ elif host_machine.system() == 'windows'
   ]
 
   libgit_dependencies += compiler.find_library('ntdll')
+  libgit_dependencies += compiler.find_library('userenv')
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
@@ -1710,14 +1768,15 @@ version_def_h = custom_target(
 libgit_sources += version_def_h
 
 libgit = declare_dependency(
-  link_with: static_library('git',
+  link_with: [
+    static_library('git',
     sources: libgit_sources,
     c_args: libgit_c_args + [
       '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
     ],
     dependencies: libgit_dependencies,
     include_directories: libgit_include_directories,
-  ),
+  )] + rust_builds,
   compile_args: libgit_c_args,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
diff --git a/rust/build-crate.sh b/rust/build-crate.sh
new file mode 100755
index 0000000000..b3debf70e5
--- /dev/null
+++ b/rust/build-crate.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+rustc -vV || exit $?
+cargo --version || exit $?
+
+dir_git_root=${0%/*}
+dir_build=$1
+rust_build_profile=$2
+crate=$3
+
+if [ "$dir_git_root" = "" ]; then
+  echo "did not specify the directory for the root of git"
+  exit 1
+fi
+
+if [ "$dir_build" = "" ]; then
+  echo "did not specify the build directory"
+  exit 1
+fi
+
+if [ "$rust_build_profile" = "" ]; then
+  echo "did not specify the rust_build_profile"
+  exit 1
+fi
+
+if [ "$rust_build_profile" = "release" ]; then
+  rust_args="--release"
+  export RUSTFLAGS=''
+elif [ "$rust_build_profile" = "debug" ]; then
+  rust_args=""
+  export RUSTFLAGS='-C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
+else
+  echo "illegal rust_build_profile value $rust_build_profile"
+  exit 1
+fi
+
+libfile="lib${crate}.a"
+if rustc -vV | grep windows-msvc; then
+  libfile="${crate}.lib"
+  PATH="$(echo $PATH | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr/bin)$" | paste -sd: -):/mingw64/bin:/usr/bin"
+fi
+
+CARGO_TARGET_DIR=$dir_git_root/.build/rust/$crate
+export CARGO_TARGET_DIR
+
+cargo clean && pwd && USE_LINKING="false" cargo build -p $crate $rust_args
+
+src=$CARGO_TARGET_DIR/$rust_build_profile/$libfile
+dst=$dir_build/$libfile
+
+if [ ! -f $src ]; then
+  echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
+  exit 5
+fi
+
+rm $dst 2>/dev/null
+echo mv $src $dst
+mv $src $dst
-- 
gitgitgadget

