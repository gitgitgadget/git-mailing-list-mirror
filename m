Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE03054D9
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340809; cv=none; b=HIz1JhDvJIepHf+vOmornXkg7CfwqKl6CivPxm44A/Sy8ZMGQQWDWjh6uDaFAbuswuQR8qTkABWVBU021TwrwXdU4YUuqR/fPHIDLN01ukz63G9JwmVDce0xihYBYzO0jd6SGYD3iTUMNBXjf2MjYuXyYOzdozHupprUU/Hd0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340809; c=relaxed/simple;
	bh=mGK7uTNhEffC6/iUtA6OcBPRYjZcv4aDt1AaInMg4YY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXurLtKB4/S7zQ28inrDD9ecS71rCXy0VQ3OgNCHhfogV+w76B7XJlOzQoX2dS/aC5RElRN85uDdgAOKnhr3rLLjn0j49JvIwffFfpgie4vQZp07jutp+M73omrbqTK1+Zefqtazb0XnglYngvOerLF751jm0vwu5+UhBWJbPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nw6PonMy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2Tk1e6o; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nw6PonMy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2Tk1e6o"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44CDC14000EE;
	Mon,  8 Sep 2025 10:13:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 08 Sep 2025 10:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340806;
	 x=1757427206; bh=axX75r5V7YhhCFEoMVxE2c3wUoS7qo99+/XBK2sRxjU=; b=
	nw6PonMyNAT3gPzofrz3SvVmMIKypdnOvmlalOgVpmLvZys1uv2xupxmpb8ouTHM
	39//uOJv2kvsLibJbhp88jneud4rLurJgkXJZjN2MNVNhQQqJeZXkCHCBipNapWy
	TwDzKgt680gH41CEA2351e6BvoIv8xaIKWTlmwG4pLHUveOLIUlX8hVMWC5L3oea
	9pXy7ylV487LD2snR2QdJIX6z0pXm9Uy/iffI/h3W+j8VYw5faRvcXYT8YURn4L9
	BeUDBUsnQSkOqTChyzpYH6UCw3hSZqdyAKN62a/sle0HcLYNVaa+vw9qTqIDVw0O
	7PP0HdY9YNxndPwkcQu8pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340806; x=
	1757427206; bh=axX75r5V7YhhCFEoMVxE2c3wUoS7qo99+/XBK2sRxjU=; b=l
	2Tk1e6oO4hxZ6b5keqzALCbz3jpufAkCgVq2WvJJkezPKRjrstWB1U3+tsI4Pn7F
	EGVc3/5oIrB0D4wSop7ZobQltf0f5G03u5wgOnqX1THCpVOSB3iZDyvUl5AQkW87
	KPk9INlqtqnn1pO/CzBkIm14WSy3qdq2MK00zjIfc0nuOT6ByS3R2LrwCjRRbrSo
	YhhRtzt4BZkfInzSaXgSKZWAcfsO7aCgDPxQD6cE4u2ch9OW59p0+Ts7DkvvKkc3
	ut/3ft7BGIwmakv1ij0W5AZHRPK0UwWhnaxu3B4Lf5cj2C2aJrNpIdFdpAMv+hJR
	rMxRoCFcyEmj5LpUZD9SA==
X-ME-Sender: <xms:heS-aOoRymJ-1whGGuuQ3O_f96DuiF5rz3sxoJVkZB6zLOL_a5z7Nw>
    <xme:heS-aMxtlU7EDUdoohkw_ZAYfRUPDONAR9YobKfHvEP_obBcuKz_OTHm8NusL8KAo
    WfGZiotCXCty-MjoQ>
X-ME-Received: <xmr:heS-aKocil1KsDhav8mr_7709nwN1A70DxnKX9jZ5F9GcQDUgZrYfNwC9XvrzBwYeEbY4gPJRMkZwuK1T6esTwVL28Ymj5QOcEOp6GhKIwglew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghonhhtrggtth
    eshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhr
    ghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:heS-aEeQDW8Qwvv0oNdTKslBvP22sHJ5z0eLNsFUMDLlWRfZ53zStQ>
    <xmx:heS-aFpcQSey8zPLMFclQQXrZ0zWBCfJ8ofWBt6NQgYVIuHAE5_uOQ>
    <xmx:heS-aGkz8DLbv1rrCIjbOfEkx_7kqqhYq9vIz7gyxYbwQESvFikqmA>
    <xmx:heS-aOSs7CQabnNX-HnMvDImWCZn6BmnoPG8cw-rNelx9ZnWOMBdDw>
    <xmx:huS-aD-8rUZ8LYohf-rl6H__KawgTP6gJ08xrSI0UCXSU9-YNKxxgOd2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c1bbd66a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:08 +0200
Subject: [PATCH RFC v3 1/8] meson: add infrastructure to build internal
 Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-1-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
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
 Cargo.lock        | 22 +++++++++++++++++++
 Cargo.toml        |  9 ++++++++
 meson.build       | 19 ++++++++++++++++-
 meson_options.txt |  2 ++
 src/lib.rs        |  0
 src/meson.build   | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/Cargo.lock b/Cargo.lock
new file mode 100644
index 00000000000..2b80a01e22a
--- /dev/null
+++ b/Cargo.lock
@@ -0,0 +1,22 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+# Fix this to version 3. This is required so that older toolchains can still
+# read the lock file. Furthermore, while an argument could be made that we
+# should not even commit the "Cargo.lock" file in the first place, there's two
+# reasons to still do so:
+#
+#   - It thwarts supply-chain attacks by committing checksums into the
+#     repository.
+#
+#   - It is required by Meson so that it can extract Cargo dependencies.
+#
+# Cargo dependencies can be accessed in Meson via:
+#
+#   dependency('${package_name}-${package_api_version}-rs')
+#
+# E.g. with a dependency "time-0.3.43", you would pass "time-0.3-rs".
+version = 3
+
+[[package]]
+name = "git"
+version = "0.1.0"
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
index e8ec0eca165..3d6601225ba 100644
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
@@ -1702,6 +1702,22 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
+# Starting with Meson 1.5, it knows to parse the "Cargo.lock" file and extract
+# dependencies from it. So from hereon we don't need Cargo anymore to build
+# Git.
+if meson.version().version_compare('>=1.5.0')
+  rust_available = add_languages('rust', native: false, required: get_option('rust'))
+else
+  cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
+  rust_available = cargo.found()
+endif
+rust_option = get_option('rust').disable_auto_if(not rust_available)
+
+if rust_option.allowed()
+  subdir('src')
+  libgit_c_args += '-DWITH_RUST'
+endif
+
 libgit = declare_dependency(
   link_with: static_library('git',
     sources: libgit_sources,
@@ -2239,6 +2255,7 @@ summary({
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
 
diff --git a/src/lib.rs b/src/lib.rs
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/src/meson.build b/src/meson.build
new file mode 100644
index 00000000000..59e810b4d41
--- /dev/null
+++ b/src/meson.build
@@ -0,0 +1,63 @@
+libgit_rs_sources = [
+  'lib.rs',
+]
+
+if meson.version().version_compare('>=1.5.0')
+  libgit_rs = static_library('git_rs',
+    sources: libgit_rs_sources,
+    rust_abi: 'c',
+  )
+
+  # The Rust module does not seem to work on macOS as expected right now. As
+  # such, we only conditionally enable tests.
+  if get_option('tests') and host_machine.system() != 'darwin'
+    rustmod = import('rust')
+    rustmod.test('rust', libgit_rs)
+  endif
+else
+  cargo_command = [
+    cargo,
+    'build',
+    '--lib',
+    '--quiet',
+    '--manifest-path',
+    meson.project_source_root() / 'Cargo.toml',
+    '--target-dir',
+    meson.current_build_dir() / 'target',
+    # `--out-dir` is unstable, but supported since 2018. It's been recently
+    # renamed to `--artifact-dir`, but for now both options are supported.
+    '-Z',
+    'unstable-options',
+    '--out-dir',
+    meson.current_build_dir(),
+  ]
+
+  if get_option('buildtype') == 'release'
+    cargo_command += '--release'
+  endif
+
+  libgit_rs = custom_target('git_rs',
+    input: libgit_rs_sources + [
+      meson.project_source_root() / 'Cargo.lock',
+      meson.project_source_root() / 'Cargo.toml',
+    ],
+    output: 'libgit.a',
+    command: cargo_command,
+  )
+
+  if get_option('tests')
+    test('rust', cargo,
+      args: [
+        'test',
+        '--manifest-path',
+        meson.project_source_root() / 'Cargo.toml',
+        '--target-dir',
+        meson.current_build_dir() / 'target',
+      ],
+      timeout: 0,
+      protocol: 'rust',
+    )
+  endif
+endif
+
+libgit_dependencies += declare_dependency(link_with: libgit_rs)

-- 
2.51.0.417.g1ba7204a04.dirty

