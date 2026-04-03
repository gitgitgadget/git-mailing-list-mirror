Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A811F3D56
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179045; cv=none; b=AnXXq30cYm8cvzLPCBd31vN0kGoZt9z9SZzQi8KCgOTYWcMDImvwvYIGFP8NLcOFJdhom6OqUVIatUXcHEIMHcnRuXinhQ0oau4i5lqKJcCzhmCxZ2Tq0frkj+QbMRFk1q/nUu3xh/bsMo3mnvZy4TEkQSDwuZe9dRUrltDvNrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179045; c=relaxed/simple;
	bh=zfPsK1QrwCPo4POVcUbBoCgf4hF2lwV/nvN4KegotWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdvCq58FA7e2Xz4QW9iS/UASzPl/xnW3XSQKudzbnCMdPCtt+nUIbPdBSI0cojOA9sDWLOPkTu64TSSghvWfZ+wPhVOetBCQMi/ZzJzhIGeK4Td+mS9k7G8/ZMqRmal2CS3nFPLSelIrK4tuBHHZd8lDVo6iqp6xxBDIzEQeerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RxxQbqfX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RxxQbqfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775179042;
	bh=zfPsK1QrwCPo4POVcUbBoCgf4hF2lwV/nvN4KegotWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=RxxQbqfXlj1LnkUWwsy2MwPtZFvwEMOG2q3sNSNET0imwSDSAZpL9p1MR5Mm1ChJZ
	 7RVSGkBZTuFV0KD8ya+Wj6GgJgHckeSTcuobyTa0LL1BY0NGcN7EbgJz+IWMP2Qt2U
	 1NycYMr6TkmACsqXoLmbAZrhelKsiIhrXObr+wrN4gbXX7o2OT7bjYOcJdDIjbxv21
	 i1ciwolxhTwyGRaK1aDqbqURK49EcUe4NVBy0Zal8s2Kr5G/sU3ajrYfIqQdesDhaS
	 VFRbc6OELuEBEaael2lLk7FgavaJo+wYfYL//mWJoTsdnL5/TDnyLEjHOy/0U0ArMK
	 mDVFabRMQ4fHBINeOA9zPYhM45f1q2VfG/h5AMNTsDdrNFkTPCyJ0VyztZyKWBpl+t
	 WqblhVKy+b3KUsoM3DgscGho3LhCFataQXVTpxsSiboM5O5x0hMWBfOxSeWA3uSRab
	 NIQgJ3Bhjq1dwrtVHP+TU1+ocRb0peZwhFdrKZY9RIOW+L6ow22
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4fc4:8150:dc47:49e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DD7F2243C8;
	Fri,  3 Apr 2026 01:17:22 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 4/4] Enable Rust by default
Date: Fri,  3 Apr 2026 01:12:49 +0000
Message-ID: <20260403011249.4133372-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
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
single job without.  Similarly, update the Windows Makefile job to not
use Rust, while the Meson job (which does not build with ci/lib.sh) will
default to having it enabled.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                  | 10 +++++-----
 ci/lib.sh                 |  3 +++
 ci/run-build-and-tests.sh |  2 +-
 meson.build               |  2 +-
 meson_options.txt         |  2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index dbf0022054..84b59959de 100644
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
index 28cfe730ee..bf1fdbe968 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,7 +10,6 @@ export TEST_CONTRIB_TOO=yes
 case "$jobname" in
 fedora-breaking-changes-musl|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
-	export WITH_RUST=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	MESONFLAGS="$MESONFLAGS -Drust=enabled"
 	;;
@@ -30,6 +29,7 @@ linux-TEST-vars)
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
 linux-clang)
+	export NO_RUST=UnfortunatelyYes
 	export GIT_TEST_DEFAULT_HASH=sha1
 	;;
 linux-sha256)
diff --git a/meson.build b/meson.build
index 8309942d18..4e1a58ee01 100644
--- a/meson.build
+++ b/meson.build
@@ -1746,7 +1746,7 @@ version_def_h = custom_target(
 libgit_sources += version_def_h
 
 cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
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
