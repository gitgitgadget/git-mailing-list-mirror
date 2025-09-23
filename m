Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A231FED3
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620736; cv=none; b=dIpOBYSGpIE1OP6w1grW5NxI+RIayEjjlqlPKYIqrw8E8t+jk7RNRUvonnasbCC9JEwcLT0EDWFkpI1EOWE+36I/vGlvzbupoXjMqzyJ2feCQyPiEkRhQL0+QNIobambh79/xTI3yuzFHQDZGPHW+DoXL3rtmuVF2/+JRmTFaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620736; c=relaxed/simple;
	bh=4Y0j1F1MiZXlce5xaZIdZPP9wpTxxQxqb/IpAWlAf5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0IPa5XB/A70Hloy9T+sSA2cOyXM/mNIdEz9gBHMtwh1yQneolZ72J9hr+DVeUEesWUX4JLH/OVz99pYGn/FZqFm8up4VkuVv38EYDy0xn8o+FPf0I7xPRWO5VH0XeMNFdABDta4be6avIv23ooNJCScE6tyXYMJZ3HByLh+I10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hK+lsPJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJrtjE9S; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hK+lsPJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJrtjE9S"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84C7C7A02CA;
	Tue, 23 Sep 2025 05:45:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 23 Sep 2025 05:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620733;
	 x=1758707133; bh=RX5WKe5TJTRnVZAwTVm1ofxzD8MoSb5MblPFCAnbfb4=; b=
	hK+lsPJ9Rg5O7rK3ElGQueqEHw9KLTOcwpRtXN1/ElPC9VQ1xeEj8tyOXI9HCFJv
	AVfSkYMTA1pmeCcncn5ShWyczqO1Wz9BkOspY42UB/y1LyQrqCChrlp82HiLCXN4
	eQjGoy/pb2DNriwwV13zJNIXE5B48s889s1UTlmVk0w3UflV+/O4f2qgM47yH2p+
	Hd1xRziw/hgx83vZu+vaWe3dgKkgp30V67LonkhzyrCkE0937NivVn+FQ1efeHLx
	4Y2VTr/rkrnnwljvuQvRas4EzOaBrRvWGYMdIYNdDJ11wPZnb/PFcEbq3sk2UVe/
	EzgpAL5rut7qAbkS4JNwRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620733; x=
	1758707133; bh=RX5WKe5TJTRnVZAwTVm1ofxzD8MoSb5MblPFCAnbfb4=; b=K
	JrtjE9SSvTuAaFYj/Fesr18Gk65XVtwpKRO51KVHyxcLMjCr/EEkmt2oNzOozUj/
	zv5m817Yrhrd0B1/bcBuLzDUYU+PyZqPsyKGknjJ3O3GpqqJTuBxtTvJbdhcmHCO
	S3L1JYRzMQGyM5nxbGn/40O0Yl9NQSROvCkmjLtrmxGNlKtjfg1bB66z6+sM/zTW
	VxRtQBLKQzCo5dxeILAic0uUl+t3+U7YnrulNRC5pxovm5eQUf53zL4zlDX2+Azz
	Vb8GpcC613QQ/ylow1bguTDZAxPdNpxGMMWaJE/B2AKiAH9nrePyK9ewUCiI/nxh
	UdWzq3RLd3ltQylUnIUZA==
X-ME-Sender: <xms:PWzSaMC1XTv-Ci2LOhI8bMgXgtyrMW3QhFYe6D23jxhg0fbPqKysTg>
    <xme:PWzSaO9V27hRnvSwscz2jl6Ftffa6kMz_Gt0xRbHJd1354fKajUSOwRUujo6Lh9p1
    I4M0Q1v_ttIM9XD5QtTLbUlXrEvvDVDs-mBq0qHDQ4WmNdyx1U5Ehc>
X-ME-Received: <xmr:PWzSaPXAz5-6398gcyxw6vRdsvB9rLXY0gDVDq3x59nBwakydFKHSwoCsIAFijjnQT1BfSpTXoCqUjFWABI8X7pI9GI_o3JSug6YQHFfsGTT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefgvedtvedufedutedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtsgesvdehiegsihhtrdhorh
    hgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PWzSaPIVP2GEErn1FGpCNoJOO_4gKT11xqOseaqBZzjgG7aclumY9w>
    <xmx:PWzSaLDOVkfx-wpTIOWz1419tKDhIxq9daU-wlutk1bPbEyvz6-QIA>
    <xmx:PWzSaHGAmzt2M77_-uFXc5W3Qdh3uUV-w6EGxE9R9geDjWrrX5JEzQ>
    <xmx:PWzSaAK-GJH2hrlmwIW9cTrLR_wAaXi-LZeSass5hvopiP-H-jHQ0g>
    <xmx:PWzSaJvYZrogaPXrypXZVwfRLohwKiDoG8m2mR15mYTGm1P0qIojdVQ2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 680bf8a7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 11:45:20 +0200
Subject: [PATCH v6 1/9] meson: add infrastructure to build internal Rust
 library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-1-59076fee486a@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
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
index 00000000000..b9a41dbc792
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "git"
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
index 00000000000..f29745beb36
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
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a" >/dev/null 2>&1
+then
+	cp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a"
+fi
diff --git a/src/lib.rs b/src/lib.rs
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/src/meson.build b/src/meson.build
new file mode 100644
index 00000000000..734de0b4fa9
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
+  output: 'libgit.a',
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
2.51.0.536.g15c5d4f767.dirty

