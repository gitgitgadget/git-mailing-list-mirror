Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE11C84B8
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220986; cv=none; b=dzJ76Aas+UUvvg7INYnPvUZp1RauFdGcmQYN+yyz31QXBdZOKLZMuDv9PVG4aFIpsDMDD8sptWBQ7Y4mM0I9qb35K7jYs9LZzmoHuWXnUk3JhdrofAo3tgLOZ0BhpzA2/P51bE0DAnd5rwNES5NdD6wmYAcSk8WXt4DtOOC52XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220986; c=relaxed/simple;
	bh=95bAyS6G2Qm2hjPrePVmdp71Azsu3dFuEvAaT40HahY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NBqONSJaeoR5iy0+kvRoFXPbXGVGPaeAN7erEwybu1uSFJ0H41wPUoIo+MCHY+KxXHmoCcks5IRO9AKUVZxZkYKqwJ9aSiVN0wyfrlhD30lojhZGswUp6nNIVIj5eJ3pZQ0ipLdHn1/tzCq6nYHdKhMhr/T2drf//8kiBS0Iak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVVdf1IL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVVdf1IL"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0b42d5so10717315e9.2
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220982; x=1755825782; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N2nrnG/Nq5rDHbHlXYquf2ZRpzuGxjZdzBdddllQsU=;
        b=AVVdf1IL6QLbpX2mn19JaX+GEBp0lgEKdB1qpQdgopNZzT3q5Xb2xvzIzx9ZfgD/YQ
         kR2WsGkSknvTQbXhLupdEL6f3OSvuJ66GWW5ypqHwyNNpLJG9ap0WFup8PuDkXemP0kD
         bUjhjA5KySjCNjP12a+AcjjJe0kqnXNLBT0RmXXLefk2EVGTbFQc4K5wXDfx0faiysoP
         onm0zWs7iKGZAARxboiQbFCgHhPUW2nGY3p3GGhC+F9TL7QOlsx8ZL3+dyDzulxKs8nW
         +yWz6L9YySSNxzU4krbdtji0BaF19TNj1ZNgp959LY8lCiMa6pblH58IgHUIRRrAnRbw
         ryvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220982; x=1755825782;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N2nrnG/Nq5rDHbHlXYquf2ZRpzuGxjZdzBdddllQsU=;
        b=UiH/ZFYwxafdEI1n8wNIAKG1QeeCmMNKBXm94Jn9+G5Ga+/tZ9WF40Tczh+usvpnVf
         JAJOq8Addbs0qbfZhYHPuvE7Vk0HFx4pXvqtTiuObEjx6eB3d7ejOyRk5ZwzsJ0uaszi
         jjCikbe9T4H8LSFd2THQzgJJv9mrbs7Kh25mOXt53kRPP4VZZ2Gudv94QJlWPrL6UVHZ
         47II5mEaE+dWMvMwV+i3rjzDXpi1dt8aJje+8u0fFc/QxTqI6svDXS8nDYbZR8sruQp9
         HrsyzYip6A4fqTgWukQBdq2cjBooygqCNyHFXcwQHMxRr5fBqPFlZcaHvR7BI+uWwbi/
         XFAQ==
X-Gm-Message-State: AOJu0Yx4zEUoP+sqTgyrn+5fat2PLxUwN/s2b1baSTpXtraABKuL66mG
	0MsMjlv1YvA4zOEWpkkT2ecaY7NznroTEA7MbX9e1YzNpBW6uuCbmjHOUjRp5g==
X-Gm-Gg: ASbGncviWkMosFhG5RqDH2kqvq++4OFbH5alsT+Tm9qTQPZwfymx7iTon8StlNsa2oB
	fFmS397eG2GizW3dIPTBcBQTM6SQsUsW34+pTrqdFd2QJwv4J8+RL3yB3kINtOT2SnzMMpN5PCh
	KuMtDqGIhmhYmwutHSjXb8RUE1rs4js8T9Ucs+SP0/DnGVGEI+8KEzOWfnMj7Ke1pQmlPL1QPbE
	SyCE4oscH/XPkcLwyWYduqjNjKC9JDsYwXbILhGuhk8XsVtbZnjT2Y6453Q6ha7MIxNiPQmDQ7O
	CymfYzAMpAaHpNLR3J+O71SoJ9bwFfI2FCVNbTr9tvrejohJoWQVjLLl6N/4uPIcI+dAdgpMhEa
	NG9XCOlC+/xKDUew83XHlWiqSbbsKwTMtPQ==
X-Google-Smtp-Source: AGHT+IGEfbq79+9J+RLNjdauV3nXxwitMHDiQBQE9FjTpTk6UDgMha5RfCntu1fxGQiORziEURQspg==
X-Received: by 2002:a5d:64c9:0:b0:3b4:6577:eed5 with SMTP id ffacd0b85a97d-3bb66564c78mr99434f8f.12.1755220982096;
        Thu, 14 Aug 2025 18:23:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6863f14asm94595f8f.63.2025.08.14.18.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:01 -0700 (PDT)
Message-Id: <7dc241e668293ec1048d93c5b9649f7eb1ce1104.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:43 +0000
Subject: [PATCH v2 08/17] github workflows: install rust
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
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Since we have introduced rust, it needs to be installed for the
continuous integration build targets. Create an install script
(build_rust.sh) that needs to be run as the same user that builds git.
Because of the limitations of meson, create build_rust.sh which makes
it easy to centralize how rust is built between meson and make.

There are 2 interesting decisions worth calling out in this commit:

* The 'output' field of custom_target() does not allow specifying a
  file nested inside the build directory. Thus create build_rust.sh to
  build rust with all of its parameters and then moves libxdiff.a to
  the root of the build directory.

* Install curl, to facilitate the rustup install script.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml |  1 +
 Makefile                   | 46 +++++++++++++++++++----------
 build_rust.sh              | 59 ++++++++++++++++++++++++++++++++++++++
 ci/install-dependencies.sh | 14 ++++-----
 ci/install-rust.sh         | 33 +++++++++++++++++++++
 ci/lib.sh                  |  8 ++++++
 ci/make-test-artifacts.sh  |  7 +++++
 ci/run-build-and-tests.sh  | 10 +++++++
 meson.build                | 40 +++++++++++---------------
 9 files changed, 172 insertions(+), 46 deletions(-)
 create mode 100755 build_rust.sh
 create mode 100644 ci/install-rust.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7dbf9f7f123c..8aac18a6ba45 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -4,6 +4,7 @@ on: [push, pull_request]
 
 env:
   DEVELOPER: 1
+  RUST_VERSION: 1.87.0
 
 # If more than one workflow run is triggered for the very same commit hash
 # (which happens when multiple branches pointing to the same commit), only
diff --git a/Makefile b/Makefile
index db39e6e1c28e..e659b6eefe82 100644
--- a/Makefile
+++ b/Makefile
@@ -919,11 +919,29 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
+
+EXTLIBS =
+
 ifeq ($(DEBUG), 1)
-RUST_LIB = rust/target/debug/libxdiff.a
+  RUST_BUILD_MODE = debug
 else
-RUST_LIB = rust/target/release/libxdiff.a
+  RUST_BUILD_MODE = release
+endif
+
+RUST_TARGET_DIR = rust/target/$(RUST_BUILD_MODE)
+RUST_FLAGS_FOR_C = -L$(RUST_TARGET_DIR)
+
+.PHONY: compile_rust
+compile_rust:
+	./build_rust.sh . $(RUST_BUILD_MODE) xdiff
+
+EXTLIBS += ./$(RUST_TARGET_DIR)/libxdiff.a
+
+UNAME_S := $(shell uname -s)
+ifeq ($(UNAME_S),Linux)
+  EXTLIBS += -ldl
 endif
+
 REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
@@ -1395,9 +1413,7 @@ UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
-EXTLIBS =
 
-GITLIBS += $(RUST_LIB)
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
@@ -2548,7 +2564,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2898,17 +2914,17 @@ headless-git.o: compat/win32/headless.c GIT-CFLAGS
 headless-git$X: headless-git.o git.res GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -mwindows -o $@ $< git.res
 
-git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
+git-%$X: %.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -2918,11 +2934,11 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
+scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -3309,7 +3325,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3929,13 +3945,13 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 .PHONY: fuzz-all
 fuzz-all: $(FUZZ_PROGRAMS)
 
-$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
+$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS compile_rust
 	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \
-	$(GITLIBS) GIT-LDFLAGS
+	$(GITLIBS) GIT-LDFLAGS compile_rust
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
@@ -3954,7 +3970,7 @@ $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h $(UNIT_TEST_DIR)/gene
 $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
 $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
-$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
+$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS compile_rust
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
diff --git a/build_rust.sh b/build_rust.sh
new file mode 100755
index 000000000000..4c12135cd205
--- /dev/null
+++ b/build_rust.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+if [ -z "$CARGO_HOME" ]; then
+  export CARGO_HOME=$HOME/.cargo
+  echo >&2 "::warning:: CARGO_HOME is not set"
+fi
+echo "CARGO_HOME=$CARGO_HOME"
+
+rustc -vV
+cargo --version
+
+dir_git_root=${0%/*}
+dir_build=$1
+rust_target=$2
+crate=$3
+
+dir_rust=$dir_git_root/rust
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
+if [ "$rust_target" = "" ]; then
+  echo "did not specify the rust_target"
+  exit 1
+fi
+
+if [ "$rust_target" = "release" ]; then
+  rust_args="--release"
+  export RUSTFLAGS='-Aunused_imports -Adead_code'
+elif [ "$rust_target" = "debug" ]; then
+  rust_args=""
+  export RUSTFLAGS='-Aunused_imports -Adead_code -C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
+else
+  echo "illegal rust_target value $rust_target"
+  exit 1
+fi
+
+cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; cd ..
+
+libfile="lib${crate}.a"
+dst=$dir_build/$libfile
+
+if [ "$dir_git_root" != "$dir_build" ]; then
+  src=$dir_rust/target/$rust_target/$libfile
+  if [ ! -f $src ]; then
+    echo >&2 "::error:: cannot find path of static library"
+    exit 5
+  fi
+
+  rm $dst 2>/dev/null
+  mv $src $dst
+fi
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d061a4729339..7801075821ba 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -24,14 +24,14 @@ fi
 
 case "$distro" in
 alpine-*)
-	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
+	apk add --update shadow sudo meson ninja-build gcc libc-dev curl curl-dev openssl-dev expat-dev gettext \
 		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl curl-devel pcre2-devel >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -55,8 +55,8 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
 		$LANGUAGES apache2 cvs cvsps git gnupg $SVN \
-		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
-		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
+		make libssl-dev curl libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
+		tcl tk gettext zlib1g zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
@@ -121,13 +121,13 @@ ClangFormat)
 	;;
 StaticAnalysis)
 	sudo apt-get -q update
-	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
+	sudo apt-get -q -y install coccinelle curl libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
 sparse)
 	sudo apt-get -q update -q
-	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
-		libexpat-dev gettext zlib1g-dev sparse
+	sudo apt-get -q -y install libssl-dev curl libcurl4-openssl-dev \
+		libexpat-dev gettext zlib1g zlib1g-dev sparse
 	;;
 Documentation)
 	sudo apt-get -q update
diff --git a/ci/install-rust.sh b/ci/install-rust.sh
new file mode 100644
index 000000000000..141ceddb17cf
--- /dev/null
+++ b/ci/install-rust.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+if [ "$(id -u)" -eq 0 ]; then
+  echo >&2 "::warning:: installing rust as root"
+fi
+
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::warning:: CARGO_HOME is not set"
+  export CARGO_HOME=$HOME/.cargo
+fi
+
+export RUSTUP_HOME=$CARGO_HOME
+
+if [ "$RUST_VERSION" = "" ]; then
+  echo >&2 "::error:: RUST_VERSION is not set"
+  exit 2
+fi
+
+## install rustup
+curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
+if [ ! -f $CARGO_HOME/env ]; then
+  echo "PATH=$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
+fi
+## install a specific version of rust
+if [ "$BITNESS" = "32" ]; then
+  $CARGO_HOME/bin/rustup set default-host i686-unknown-linux-gnu || exit $?
+  $CARGO_HOME/bin/rustup install $RUST_VERSION || exit $?
+  $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $?
+else
+  $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
+fi
+
+. $CARGO_HOME/env
diff --git a/ci/lib.sh b/ci/lib.sh
index f561884d4016..ad0e49a68dcb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,13 @@
 # Library of functions shared by all CI scripts
 
+
+export BITNESS="64"
+if command -v getconf >/dev/null && [ "$(getconf LONG_BIT 2>/dev/null)" = "32" ]; then
+  export BITNESS="32"
+fi
+echo "BITNESS=$BITNESS"
+
+
 if test true = "$GITHUB_ACTIONS"
 then
 	begin_group () {
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 74141af0cc74..56aa7efb1d53 100755
--- a/ci/make-test-artifacts.sh
+++ b/ci/make-test-artifacts.sh
@@ -7,6 +7,13 @@ mkdir -p "$1" # in case ci/lib.sh decides to quit early
 
 . ${0%/*}/lib.sh
 
+## install rust per user rather than system wide
+. ${0%/*}/install-rust.sh
+
 group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
 
+if [ -d "$CARGO_HOME" ]; then
+  rm -rf $CARGO_HOME
+fi
+
 check_unignored_build_artifacts
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 01823fd0f140..dbab1cb2f936 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,6 +5,12 @@
 
 . ${0%/*}/lib.sh
 
+## install rust per user rather than system wide
+. ${0%/*}/install-rust.sh
+
+rustc -vV
+cargo --version || exit $?
+
 run_tests=t
 
 case "$jobname" in
@@ -72,5 +78,9 @@ case "$jobname" in
 	;;
 esac
 
+if [ -d "$CARGO_HOME" ]; then
+  rm -rf $CARGO_HOME
+fi
+
 check_unignored_build_artifacts
 save_good_tree
diff --git a/meson.build b/meson.build
index 2d8da17f6515..047d7e5b6630 100644
--- a/meson.build
+++ b/meson.build
@@ -277,26 +277,17 @@ else
   rustflags = '-Aunused_imports -Adead_code -C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
 endif
 
-
-rust_leaf = custom_target('rust_leaf',
+rust_build_xdiff = custom_target('rust_build_xdiff',
   output: 'libxdiff.a',
   build_by_default: true,
   build_always_stale: true,
-  command: ['cargo', 'build',
-            '--manifest-path', meson.project_source_root() / 'rust/Cargo.toml'
-  ] + rust_args,
-  env: {
-    'RUSTFLAGS': rustflags,
-  },
+  command: [
+    meson.project_source_root() / 'build_rust.sh',
+    meson.current_build_dir(), rust_target, 'xdiff',
+  ],
   install: false,
 )
 
-rust_xdiff_dep = declare_dependency(
-  link_args: ['-L' + meson.project_source_root() / 'rust/target' / rust_target, '-lxdiff'],
-#  include_directories: include_directories('xdiff/include'),  # Adjust if you expose headers
-)
-
-
 compiler = meson.get_compiler('c')
 
 libgit_sources = [
@@ -1707,17 +1698,18 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
-libgit_dependencies += rust_xdiff_dep
-
 libgit = declare_dependency(
-  link_with: static_library('git',
-    sources: libgit_sources,
-    c_args: libgit_c_args + [
-      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
-    ],
-    dependencies: libgit_dependencies,
-    include_directories: libgit_include_directories,
-  ),
+  link_with: [
+    static_library('git',
+      sources: libgit_sources,
+      c_args: libgit_c_args + [
+        '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+      ],
+      dependencies: libgit_dependencies,
+      include_directories: libgit_include_directories,
+    ),
+    rust_build_xdiff,
+  ],
   compile_args: libgit_c_args,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
-- 
gitgitgadget

