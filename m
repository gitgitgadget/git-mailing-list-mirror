Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2D2FC898
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935392; cv=none; b=id1UjtXL2j55GXy1pyjetMa3iTLIiJlZgctgQ+P5U4b5jJ2XxbMEtWSP8R7I27oY1+4hBgT89Pdl0dPS3PRdekv0l6rTUyEkHLoDWzZUkfneI0j50nrsdBobZRaPFgLvjLIgBstWp/xrmnW0eOX2y5BMWHy9c6O85/P3GitLkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935392; c=relaxed/simple;
	bh=XnkLk9QmzdjyH3eF2gwhPNYYi2S9EP0kVxG853wkKRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OW7wMHKiCtpgKyit25wIUvuqxfK9cOjUphvOtweX0PJd3LUG3KykEa/QNGJg27QF0XDCBU1AByhJNqI9aDDerKqIQbkb/dpojJjrj9DQv5zIQcWmip7DBoacxxVFGRzUXi3Gz2Tf2vEgVyX27R1gqxbykzPnOJgtsji267MIDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XljhGl9H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKm8mqg1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XljhGl9H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKm8mqg1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EA5714001B5;
	Mon, 15 Sep 2025 07:23:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 07:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935389;
	 x=1758021789; bh=gmnGtabFFPs5V218lhkNs7afhRKHr3b9jeRLhL7blQc=; b=
	XljhGl9HfUF0QJqVrwKnXqLclgjip+UBFykSAK1itn0btUajB2ZkGIsXZkgmMltX
	1A/Frb4AwBO1z5YF+2Cykvo7qALKIoDEoQLkH9YVlCVLtCeHl1ysEKpqfs9fNs40
	3nswXF8kOqI6bLyDP7R2a7A6zpBy6ebWxI8FwkPULWwT64tLhUSaXugNo/uTYnco
	xnBUUTBt8KOa/TKkuS7pAFxQYBRdI18cw9LUaD4lyT2eQPNxGOBmIqHqsKWBY5Rt
	2fi6/dwogOaGpVqHyYu5AlJYBsNcELFW/8Sf5nsfI8BNcnGbR/qCF9B/tvvVIOCN
	I+OvfHvYReNx3Uf9m0pd7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935389; x=
	1758021789; bh=gmnGtabFFPs5V218lhkNs7afhRKHr3b9jeRLhL7blQc=; b=i
	Km8mqg1Ud/Q5hpW3m/8vvkF3Ufyq6/nH7g42BNfqwfvDWFz7Y3f4MiH9n017se45
	gKsnm7wSykPlWsT5N1UrCXzMwxEZXuINwnEQCXJNPv4NzFIMSE8x61113TO9V750
	HzYxcrllCMl0u61MOfk18JV4T9t+I77rt/jceROpKUm+l5pZwGM0owNpsnZF/qDp
	XP8qgMAmSpz6pETC3SmHItYkEojSdCwxxvcaPMvqgi2xt96UHQB+XhYwI1rd5gGt
	YKsRwGMEznGYCv10B8fLmdir/g14/oHybHBQaA9dBP6trVZlk4W9CBtvUGs52xAI
	LA3/IrPbt3ySEOmFq8aUA==
X-ME-Sender: <xms:HffHaJBYDb7BVe0IH-vZvxq2AAf--8LrEPR-2LAP_HiACjNfHztSmA>
    <xme:HffHaIKF485TGYkBHX5BrTi28RZLwvsvqyA2o01AN2hTTfjgLzb6kdUPF-O_DOC5g
    E9K7VOAFwonhPUm2A>
X-ME-Received: <xmr:HffHaPtzPKdRCt9Hq1u48Zwx3d7Aywm84etACsZgfDE6QNvUftoJLFbaeo8oVN2x0DZ0Pwx6R3CdjVQoDFlYEO7BASaQQYM-NdqbIrAicJlTTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefgvedtvedufedutedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepvgiivg
    hkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdq
    vghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhope
    gvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtsgesvdehiegs
    ihhtrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:HffHaIXu_zRvecw4nH1KcQHjaLElVODMNsjPVswmnYVh_gkit6rS9w>
    <xmx:HffHaCJsk21YKGmeqMzXsdy810u4mYnev6A53blOHFJskC4ubsGzeg>
    <xmx:HffHaF8elVrkP6z0VXcE1zAUtsy_MnYzSgrcM8d31JMxHrT3t9UPEw>
    <xmx:HffHaIOG4ctwbJSKr6qVqR2LiBqF8sXAA3gbiZqhTPYUIEAWs9KKZg>
    <xmx:HffHaCzOpXWHzDK-pYPH0iU2rxZww8OKe2ZyjwY4B0ZyjHIKkFOCnjM6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce7b0e26 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 13:22:48 +0200
Subject: [PATCH v5 1/9] meson: add infrastructure to build internal Rust
 library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-1-dc3a32fbb216@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
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
2.51.0.450.g87641ccf93.dirty

