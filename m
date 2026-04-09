Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD29396573
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774679; cv=none; b=tcxlK+OZON6A7aLWtT326P1fslWzvyzurKcTjSZ/Ic2qi2IHCSG1rsMqvPiU6Ve8nTb4RB16vF+46rqpaxMAoLSBeFtcdyg0ZcmU1UFhzNwXK1WA2Ku7l7sGEPGtOocwTeqLXXSecUj2Hx6bIbZZlKoqSQwwXgJMRUIE1AhbvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774679; c=relaxed/simple;
	bh=tBYzBVWImgEH4I8q0iccMtxqaTBmX5b+mq0hG9DybPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ex0QRABYfXvHjj4f4RpB6xK7pmmg/hhOL2P98z2m0uH5L1B9EZIu8l7u2AIIw2k+RtZbZpVJHVPR41z9GUY4uWs3MANMwgoB0sMjiGgTwovlh8gw7xek867/L4O72JKhdqaiFS4/jUcdsxR3zplNcjArabDProYgBHfODPHymqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Y0GeO38f; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Y0GeO38f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775774676;
	bh=tBYzBVWImgEH4I8q0iccMtxqaTBmX5b+mq0hG9DybPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Y0GeO38fwtwNqXovAq4WDnd5og6nHm1dClEDajLs/d32lco8tpJbN6T6q8EOg8tLi
	 oj5Rahh/qyc+TuZTCctOAoQoqzTIZVgvWYiRPFw4exzzlGQbBxSYsQXFf3hhX9/7Lw
	 BopsuiNCzCbJtTM0IROl3mjpyJ01Nb/bjwTucLEeubvMlIj8FGQIVuvEUSIr/o3lhF
	 w02OpztwO+Ib0/Tusb6zt8EflLmLLyu+ySr9M2Ist3qMxkZPMxCxYxOw9zjAVGGqXS
	 mEmg5xuOz5RLz2KyMCssAcqOOoNttQPoCNCC5gsAY60c/DGZKgzgPVKx5+Ds0UN/Tc
	 9z8LrIHaPCz6n10rh1Ajg5ofJsq8noKVV5ZjD+4xlAtkLIoMwdxLwKbL6W3sYDo+xj
	 020oK8vWNXkPBC8YAPp+TvY72G8UUF9wRoaw7gvk010P4ltqXAAGoRR7G6RaZdm/mI
	 uMCHIfJqKasWQ11FZ+4ZqH75vx/OlxLfQjVSDKNUygN/zfynDMr
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:fec4:70ef:431f:d174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5DB0124403;
	Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 4/4] Enable Rust by default
Date: Thu,  9 Apr 2026 22:44:34 +0000
Message-ID: <20260409224434.1861422-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our breaking changes document says that we'll enable Rust by default in
Git 2.54.  Adjust the Makefile to switch the option from WITH_RUST to
NO_RUST to enable it by default and update the help text accordingly.
Similarly, for Meson, enable the option by default and do not
automatically disable it if Cargo is missing, since the goal is to help
users find where they are likely to have problems in the future.

Update our CI tests to swap out the single Linux job with Rust to a
single job without, both for Makefile and Meson.  Similarly, update the
Windows Makefile job to not use Rust, while the Meson job (which does
not build with ci/lib.sh) will default to having it enabled.

Move the check for Cargo in the Meson build because it is no longer
needed in the main script.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                  | 10 +++++-----
 ci/lib.sh                 |  3 +++
 ci/run-build-and-tests.sh |  6 ++++--
 meson.build               |  3 +--
 meson_options.txt         |  2 +-
 src/meson.build           |  1 +
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 5d22394c2e..945adb9aa5 100644
--- a/Makefile
+++ b/Makefile
@@ -498,9 +498,9 @@ include shared.mak
 #
 # == Optional Rust support ==
 #
-# Define WITH_RUST if you want to include features and subsystems written in
-# Rust into Git. For now, Rust is still an optional feature of the build
-# process. With Git 3.0 though, Rust will always be enabled.
+# Define NO_RUST if you want to disable features and subsystems written in Rust
+# from being compiled into Git. For now, Rust is still an optional feature of
+# the build process. With Git 3.0 though, Rust will always be enabled.
 #
 # Building Rust code requires Cargo.
 #
@@ -1351,7 +1351,7 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
-ifndef WITH_RUST
+ifdef NO_RUST
 LIB_OBJS += varint.o
 endif
 LIB_OBJS += version.o
@@ -1590,7 +1590,7 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
 ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 
-ifdef WITH_RUST
+ifndef NO_RUST
 BASIC_CFLAGS += -DWITH_RUST
 GITLIBS += $(RUST_LIB)
 ifeq ($(uname_S),Windows)
diff --git a/ci/lib.sh b/ci/lib.sh
index 42a2b6a318..1cfc8c6efc 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -372,6 +372,9 @@ linux-asan-ubsan)
 osx-meson)
 	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=osxkeychain"
 	;;
+windows-*)
+	export NO_RUST=UnfortunatelyYes
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 28cfe730ee..e2d783d90b 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -8,11 +8,12 @@
 export TEST_CONTRIB_TOO=yes
 
 case "$jobname" in
+linux-musl-meson)
+	MESONFLAGS="$MESONFLAGS -Drust=disabled"
+	;;
 fedora-breaking-changes-musl|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
-	export WITH_RUST=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
-	MESONFLAGS="$MESONFLAGS -Drust=enabled"
 	;;
 linux-TEST-vars)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
@@ -30,6 +31,7 @@ linux-TEST-vars)
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
 linux-clang)
+	export NO_RUST=UnfortunatelyYes
 	export GIT_TEST_DEFAULT_HASH=sha1
 	;;
 linux-sha256)
diff --git a/meson.build b/meson.build
index 8309942d18..deff129cf6 100644
--- a/meson.build
+++ b/meson.build
@@ -1745,8 +1745,7 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
-cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
-rust_option = get_option('rust').disable_auto_if(not cargo.found())
+rust_option = get_option('rust')
 if rust_option.allowed()
   subdir('src')
   libgit_c_args += '-DWITH_RUST'
diff --git a/meson_options.txt b/meson_options.txt
index 659cbb218f..80a8025f20 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -77,7 +77,7 @@ option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], valu
 # Build tweaks.
 option('breaking_changes', type: 'boolean', value: false,
   description: 'Enable upcoming breaking changes.')
-option('rust', type: 'feature', value: 'auto',
+option('rust', type: 'feature', value: 'enabled',
   description: 'Enable building with Rust.')
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,
   description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
diff --git a/src/meson.build b/src/meson.build
index 45739957b4..41a4b231e6 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -29,6 +29,7 @@ libgit_rs = custom_target('git_rs',
 )
 libgit_dependencies += declare_dependency(link_with: libgit_rs)
 
+cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
 if get_option('tests')
   test('rust', cargo,
     args: [
