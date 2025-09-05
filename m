Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4332275E
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073073; cv=none; b=lknf6AnoW/A1z7Pr9tf76/rmDV7ExQob3UuiGFrS1Uxm2l97P/XJhNwc60G0oFlDtF0zzy5v9Ccx7oRZ6U+QneAs5EZ7gCxLMXaKbQjrlwLNvtb34TjLHJc/ixgrur/lI2iH/XSUYT7AFps1YwmMkzYDDC4CqFv9T0uq5sdqADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073073; c=relaxed/simple;
	bh=KkmS+mFXR7W5YknH69eln6O90iAH79eTDfe2PA6ALkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMcXY8JOuihtc/azJFPSt5MHkXyVj0XZvd1F6LpB6GAAhEwJTcyF7zHewb8HcMHAI/u8sQpt844bE28BPqEwMaFesTLs2GcZh9kfgOKOxBjImIH7KxAtRHNzew3aL91StlwcC2stBnqaAHPuM+JBiInfeC0b/GDfwnjJUJXZnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eErNe6ou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jsCe1Xxj; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eErNe6ou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jsCe1Xxj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 626AC7A0527;
	Fri,  5 Sep 2025 07:51:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 05 Sep 2025 07:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073069;
	 x=1757159469; bh=QL+VuTZEE3KVkyxos+BuXBbRsQCtzK4+OvmbDUdyDug=; b=
	eErNe6ouFZB+nx0A+qjhUmqM4XiLA59wg9SarhF+sShxR87uXO0QhjYS4mwQ395J
	uri3xM8mFRK334UUVVU2ZP2w3T+CgYn1pnievEiqHyCfCmmXOb2GhCtkfqt8vmj2
	FDtjLUmii++rJRYWYEXn8/00FH6fGKV5CkZYhZKnf77GYpwkaTfyNlA+vUYWPdbe
	CryWf8FmwRpm9yQD1kmikpSfBNCI3kIeuGtPQOyMCa5RbwfYElVZJLa8Ra/WhjbU
	RGfY1Q+oWMOPd+0JwzVHPg4AlqVE8mf3dTQbUNxRqk1Sm5jdJbA6vR8DSbhkJsq3
	zXhbtle5H/dMK2uZbd+xfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073069; x=
	1757159469; bh=QL+VuTZEE3KVkyxos+BuXBbRsQCtzK4+OvmbDUdyDug=; b=j
	sCe1XxjmcCT/VT4MVSOUmWt97njiqQbpqHf3ZyKF+HVG0kP2qrTlKeXIQCfd6Aw0
	TCPpnhdmC+benCwAyvvs/HJSWiCkkoSGmjvyGZa8X7spChLJrEYiQgAGNTWGDfUU
	WggizFRIo3saerGSTM9JSigWjilPRMyRQQqpDA42Z3sXJGUVTJp/soposD+0sM9T
	udio2o/SzbcKkWxxYYMmK9a4pDuid3vp77liynIgkBvIC+319d4dxX0pOQblsEia
	4Z00UBjKccPZFoAGn8QNXS15g22BDL6jYpxVYQEmInVhid4oWmmCYFLmgK4srLQ9
	FYQTrpQvJP8rjXw4kY0QQ==
X-ME-Sender: <xms:rM66aCjWYzCIg3NlZrSGSvVfmOFLxpMLbAXcEgbMB71TM1NHwviakg>
    <xme:rM66aDKwhax0qdGpPjYIGYfdt1J9_lSZuJjJrMjLc9hQ7VpjkXAtFYBwPc3Ahcpfn
    HLFZDNMeUY9r_CF1A>
X-ME-Received: <xmr:rM66aBgGhuKUU2IfWPRJeFaBpbgfdpYH5QRp8kR5y9z7cQjHkevobXiqGjH_Wdioe2kn-MHz8nbJhu5KuYSxr8DmvDQCYhAVXeEMsSvlqlDC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrg
    gttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    gssedvheeisghithdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rM66aB3IcPcW_aPAQjKToPYS5EkGSTODfTYmawghbrFtlY3UkLsZUw>
    <xmx:rM66aHhm8mq6QNvLtHVfvUDcnz52BUCSsWLxdk2VXRvccTDy7-TJrA>
    <xmx:rM66aC92EGyDsBKZ9k8U7Pg_j-usBSuPwj7pzQ0uUELFrUt47sG4Rw>
    <xmx:rM66aDL_Lrb9Kr4ellTkEZ5ZVKCX1nY-wH9ruAspl2SwfTFOzpSPKA>
    <xmx:rc66aFX5XNdLuuVhypu9hG_tGgRCiIb2G9UyBQGrT1XylY3rN7Z1zass>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9033821a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 13:50:57 +0200
Subject: [PATCH RFC v2 1/7] meson: add infrastructure to build internal
 Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-1-6939cbf4a0b8@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 12 +++++++++++-
 meson_options.txt |  2 ++
 src/lib.rs        |  0
 src/meson.build   | 15 +++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index e8ec0eca165..5b2e9af1bf1 100644
--- a/meson.build
+++ b/meson.build
@@ -1702,8 +1702,17 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
+libgit_libraries = [ ]
+
+rust_available = add_languages('rust', native: false, required: get_option('rust'))
+rust_option = get_option('rust').disable_auto_if(not rust_available)
+if rust_option.allowed()
+  subdir('src')
+  libgit_c_args += '-DWITH_RUST'
+endif
+
 libgit = declare_dependency(
-  link_with: static_library('git',
+  link_with: libgit_libraries + static_library('git',
     sources: libgit_sources,
     c_args: libgit_c_args + [
       '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
@@ -2239,6 +2248,7 @@ summary({
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
index 00000000000..eb752651d35
--- /dev/null
+++ b/src/meson.build
@@ -0,0 +1,15 @@
+libgit_rs = static_library('git_rs',
+  sources: [
+    'lib.rs',
+  ],
+  rust_crate_type: 'staticlib',
+)
+libgit_libraries += libgit_rs
+
+# The 'rust' module was only introduced in Meson 1.0. Furthermore, the module
+# does not seem to work on macOS as expected right now. As such, we only
+# conditionally enable tests.
+if meson.version().version_compare('>=1.0.0') and host_machine.system() != 'darwin'
+  rustmod = import('rust')
+  rustmod.test('rust', libgit_rs)
+endif

-- 
2.51.0.417.g1ba7204a04.dirty

