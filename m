Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863C2F5330
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781824; cv=none; b=lRx6GVkNNk+w6G2J7d44b40rJjn29ownrsPl/7qOp96XG3UsGpkHuwLWN+IPycmCM8gvkSci5Hxu38UHgcVFxsitXoMXm1rki9gMzwUuUGu77uB/Z8Wu1yhPkWqQvmIVOUOdobWaHvGHAJHiGTKJFTC/SAe/LJLoZwAIIQBG4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781824; c=relaxed/simple;
	bh=Yn7/qEVNtUP+oxHbH6bZLGr+cG6ZiGOSraQAmZUOjBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlxVCyRcj9HtIUHHhKcvSSxkxtWbCmWTM8NBbIy+5XZNz5WWRaIhatEqOi2ndnEc4iarpzpEYu+HnoNAmZqfCFXRRI7dZk9NcCmWtwJhmZAxCyHisTFAVLB3ay7c/klodARSH/YWjehLXQb9lckXFar0xfSmgRykGpMD6ml7sGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=elhrvLh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fUnLhzXa; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="elhrvLh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fUnLhzXa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B95A1D0017B;
	Thu, 25 Sep 2025 02:30:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 02:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781821;
	 x=1758868221; bh=5/wRNJE+Hamnfp48VHmLamq6ZYk6oPVCj8vuS7riayU=; b=
	elhrvLh4dobRAI/GjscDPalhnRWIwVgNJmYlqqmfQmSVBBRliiAS4hbsWXJPUv8C
	hv3ndNZ1kkbyUNvUr0Da5h2Uruspyq+SakfadFje2DN4I2n3ziDmf4M//jy2D5up
	iZw+jUcLNEA/3uRI3HSC42aEVrKNEc3SFsh/Xphx+NE03SXezXfYk4Z0Bii66MYb
	ScuZXLELQUzQxAp8DQLWCXnnJVQH/qOzRrGqm+7775xaaEkgPAyniq1Yj6YPfOMu
	SVZIYbpEfXSly/c36EROKYOpqINixqZpJfRT0X4ukajHMeOp+YtRbWiaQLNDRV0a
	v9m8Tc9syvOTR1mTV3OixQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781821; x=
	1758868221; bh=5/wRNJE+Hamnfp48VHmLamq6ZYk6oPVCj8vuS7riayU=; b=f
	UnLhzXayhNjj8C1ux3mLb79tLtFkNxs+CHwmXQk4QE3UwRh4bW2DQpMMTjKHfSGY
	1zwHe2ZV/DNf12u63UZa1YN/kgnzkXySvjOk5gkQ7i6ggDLSxqVuHdrm+m3fdaYA
	Wr+FB2qhH6NqxI9swNFEnaSGAMC73thguAx3GLiz1SgT7hD/WNAwLiXWt11EOIWW
	8aty7YR4DovGBzA3mRe4XRGCAffkbQVzvRcgulLRmlaIIpsI/FchSd3hZe2YnAoH
	i15n9WccpKk4iqLMpGB8mmacxLt5xdFWKvMAf5TMNTNd8XlVRcOKw1i2RMcPnAxF
	ZbElPWR0FMvZ90cpAJbNA==
X-ME-Sender: <xms:fOHUaMRLC_bf6xtSorxVi1uxk-Nc1wNaYCV1I7M2bwNJaP0YeN1j9A>
    <xme:fOHUaKPNO-1RkPP9Y3Sv0AYJJVX4bgM92O_XtJm7IzMDwLHm6DS8v-53x0Z0sy93S
    dKDlp3GPBwu1_gLCaIRCzwqXek9jMiUfG-KNEL-474Smj1oyGkhFA>
X-ME-Received: <xmr:fOHUaJlwXgrT5-03NUR-_74FN69krExd8WczP-XX-UNJcuFdFMGTmp5_2MNn-dTSSD7rXK70Lj4yEeMO8ZmaTdd48C1_DAsinGn9AN9bO2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefgvedtvedufedutedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnh
    htohhordhorhhgpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhr
    hiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmhgv
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsrghm
    sehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:fOHUaMY2_RRji-0O-j8UGXgiaiTWNb2ckFDZ7wrsedX_R_f45jivGg>
    <xmx:fOHUaPRAObyAE7CNaQ4nSjOkEUANvttZmMLEJjo1vUB7luL9aVaf4A>
    <xmx:fOHUaGU_X8FGHL9W9LXzlEh3ijYYbiRu6pcer5ldz7e-8cxulPsM0w>
    <xmx:fOHUaOZD8AP1Vx92S3YOHXV2kPJVqoQdneAauOzGNfm605NfSdT8BA>
    <xmx:feHUaA-5HHlD_Y7jJlXN7EpZ8Y97TTgoufjJR_vq9kKgZMFul-fnsyTc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6011b9a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:03 +0200
Subject: [PATCH v7 1/9] meson: add infrastructure to build internal Rust
 library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-1-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Add the infrastructure into Meson to build an internal Rust library.
Building the Rust parts of Git are for now entirely optional, as they
are mostly intended as a test balloon for both Git developers, but also
for distributors of Git. So for now, they may contain:

  - New features that are not mission critical to Git and that users can
    easily live without.

  - Alternative implementations of small subsystems.

If these test balloons are successful, we will eventually make Rust a
mandatory dependency for our build process in Git 3.0.

The availability of a Rust toolchain will be auto-detected by Meson at
setup time. This behaviour can be tweaked via the `-Drust=` feature
toggle.

Next to the linkable Rust library, also wire up tests that can be
executed via `meson test`. This allows us to use the native unit testing
capabilities of Rust.

Note that the Rust edition is currently set to 2018. This edition is
supported by Rust 1.49, which is the target for the upcoming gcc-rs
backend. For now we don't use any features of Rust that would require a
newer version, so settling on this old version makes sense so that
gcc-rs may become an alternative backend for compiling Git. If we _do_
want to introduce features that were added in more recent editions of
Rust though we should reevaluate that choice.

Inspired-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Cargo.toml         |  9 +++++++++
 meson.build        | 10 +++++++++-
 meson_options.txt  |  2 ++
 src/cargo-meson.sh | 32 ++++++++++++++++++++++++++++++++
 src/lib.rs         |  0
 src/meson.build    | 40 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 00000000000..45c9b34981a
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "gitcore"
+version = "0.1.0"
+edition = "2018"
+
+[lib]
+crate-type = ["staticlib"]
+
+[dependencies]
diff --git a/meson.build b/meson.build
index e8ec0eca165..234a9e9d6fd 100644
--- a/meson.build
+++ b/meson.build
@@ -220,7 +220,7 @@ project('git', 'c',
   # learned to define __STDC_VERSION__ with C11 and later. We thus require
   # GNU C99 and fall back to C11. Meson only learned to handle the fallback
   # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
-  default_options: meson.version().version_compare('>=1.3.0') ? ['c_std=gnu99,c11'] : ['c_std=gnu99'],
+  default_options: meson.version().version_compare('>=1.3.0') ? ['rust_std=2018', 'c_std=gnu99,c11'] : ['rust_std=2018', 'c_std=gnu99'],
 )
 
 fs = import('fs')
@@ -1702,6 +1702,13 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
+cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
+rust_option = get_option('rust').disable_auto_if(not cargo.found())
+if rust_option.allowed()
+  subdir('src')
+  libgit_c_args += '-DWITH_RUST'
+endif
+
 libgit = declare_dependency(
   link_with: static_library('git',
     sources: libgit_sources,
@@ -2239,6 +2246,7 @@ summary({
   'pcre2': pcre2,
   'perl': perl_features_enabled,
   'python': target_python.found(),
+  'rust': rust_option.allowed(),
 }, section: 'Auto-detected features', bool_yn: true)
 
 summary({
diff --git a/meson_options.txt b/meson_options.txt
index 1668f260a18..143dee9237c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -71,6 +71,8 @@ option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], valu
 # Build tweaks.
 option('breaking_changes', type: 'boolean', value: false,
   description: 'Enable upcoming breaking changes.')
+option('rust', type: 'feature', value: 'auto',
+  description: 'Enable building with Rust.')
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,
   description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
 
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
new file mode 100755
index 00000000000..99400986d93
--- /dev/null
+++ b/src/cargo-meson.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+if test "$#" -lt 2
+then
+	exit 1
+fi
+
+SOURCE_DIR="$1"
+BUILD_DIR="$2"
+BUILD_TYPE=debug
+
+shift 2
+
+for arg
+do
+	case "$arg" in
+	--release)
+		BUILD_TYPE=release;;
+	esac
+done
+
+cargo build --lib --quiet --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
+RET=$?
+if test $RET -ne 0
+then
+	exit $RET
+fi
+
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+then
+	cp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a"
+fi
diff --git a/src/lib.rs b/src/lib.rs
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/src/meson.build b/src/meson.build
new file mode 100644
index 00000000000..c8d874b2106
--- /dev/null
+++ b/src/meson.build
@@ -0,0 +1,40 @@
+libgit_rs_sources = [
+  'lib.rs',
+]
+
+# Unfortunately we must use a wrapper command to move the output file into the
+# current build directory. This can fixed once `cargo build --artifact-dir`
+# stabilizes. See https://github.com/rust-lang/cargo/issues/6790 for that
+# effort.
+cargo_command = [
+  shell,
+  meson.current_source_dir() / 'cargo-meson.sh',
+  meson.project_source_root(),
+  meson.current_build_dir(),
+]
+if get_option('buildtype') == 'release'
+  cargo_command += '--release'
+endif
+
+libgit_rs = custom_target('git_rs',
+  input: libgit_rs_sources + [
+    meson.project_source_root() / 'Cargo.toml',
+  ],
+  output: 'libgitcore.a',
+  command: cargo_command,
+)
+libgit_dependencies += declare_dependency(link_with: libgit_rs)
+
+if get_option('tests')
+  test('rust', cargo,
+    args: [
+      'test',
+      '--manifest-path',
+      meson.project_source_root() / 'Cargo.toml',
+      '--target-dir',
+      meson.current_build_dir() / 'target',
+    ],
+    timeout: 0,
+    protocol: 'rust',
+  )
+endif

-- 
2.51.0.618.g983fd99d29.dirty

