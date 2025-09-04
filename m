Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2568312837
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996032; cv=none; b=jMQvOYUNlWu7AV1p4qvIYBWTY/WzlSAle1lxHNK4UKMgpWbdFifCxMeWOiYchzoGOPgoasHUpS1DUKNSCuVdZuSbumzq62GmKjnxyWxW4uGZ7Isthjqypcp419RWN4GEqRo8uOgrE6ZbSRoK8h3r+8xTCAEzr3dy5tx/wTOigW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996032; c=relaxed/simple;
	bh=N5xCjst5RPfukolH3BAv9D1P7opsgvVw/EDmzYr3nS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WADJGmQnkjBKhC9z8bM+eB+ffzFub1yl23Bt+WytUa+aiCIiPKac1/OuTLIJtCY824PGuwHtJyGb6GvYxFO8sE1mkiLG4ucUz0q7dqTlLf2znVTwo7Zngq64LR35Bh2ll9kdKs9SBRFHcmGy3iAfktstv866E82t1R5Wn/u9UV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AnOivn/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYTpDiRa; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AnOivn/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYTpDiRa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DC697A035D;
	Thu,  4 Sep 2025 10:27:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 04 Sep 2025 10:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996029;
	 x=1757082429; bh=OrVkTehIeO0XRkDDkFo4B7eC7HsR7w8WIiiGcb2y5Vg=; b=
	AnOivn/pFJCuKRkC9LHq0IeGGKaYeI54Uy30xx4QUZkMVBzCW+XVU2vje2h5WrFH
	K3xxdJwS2csZpQc+wry3GoUGj3fa/qf8Ci0DeCvTjntveD5V+G9zU1fwm8JA1B64
	6m1WOr10M82I2yNcjJku8qvLRv3ksQITEsGUbDUaPiSIWx7uP+Q+8Ej9jpWv1Jvk
	3Y2L3GMAhnFKOCLhjvEoaQbmzLcrH1cpUtMcxTgENQglmZzQElOrJASqUBvp62eC
	FRJPg8ukZMVB7/OUKjXYmsbYMGPG5rCY6E70VSOfs1MZLc2WoPhUfiU3D3LJSGcB
	Dtw6CdjkOHVjcn3sPm0iig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996029; x=
	1757082429; bh=OrVkTehIeO0XRkDDkFo4B7eC7HsR7w8WIiiGcb2y5Vg=; b=N
	YTpDiRarwYfLn8J/MH4geGapQys4CJ6kyAduKsilyzSAS9zn0DT00fe/OWeMe54b
	CPApbjxvWopE5p7HVtWIeREGfRuhdUjGD7sU8KI7pjirMPB2Q+jmRYuJFA4yjOHW
	oC2HiqzVMLzlj5qnGpPdpAZFFtexL5uDExjtXOy+2WgZAK0/0pSn2jlWZ+ammH7W
	7w38GmR5vASXW963UPSUTNO07ePS1tJrSRZABViI0D6QGU+V/JtRCMqioQtogxwm
	r+x4kya2FpUdV1I/c3nq79n6vW31WuyGmT3TUP+HCySnWj80xees+zzu/awEll4L
	elE15KBvsk4YRsC3kCExg==
X-ME-Sender: <xms:vKG5aKCQz4KbePQO7VLSVv8ZejrBSOgGiJ4zJJO6xoIZEczjqzPWOw>
    <xme:vKG5aErli4SNkjmjLlIRDQkaQDRUWGl0SoUA5t5J4TfzpE7a-vzwJQvZSZkzgTH5l
    3pizUqV-5t9t1g4pw>
X-ME-Received: <xmr:vKG5aFAx_jKN5fV420rjnSOPWjroCK7TpcGFTRQYC9aC1AQDmyWbkOgGE7ZWjKb_VAGLPB6s3LQOBa_rW9AyP7w7EVQWSUdYjo_DPWwMdqpPjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuh
    hnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhht
    ohhordhorhhgpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:vKG5aPV-D5kXcj4ZMN8hAnXnWKydMd1Owxo1R1ErmH34-70DmYRuDQ>
    <xmx:vKG5aHBQ7LJ--N_jJr5PeD712dm_wt1FVGODYzy4REKPre9vPxGRBA>
    <xmx:vKG5aMfkTVpivRH9YA2e_SGep11HikI6H4F751_6oCRvM-7Et0FhpQ>
    <xmx:vKG5aOql0xtQdL7ODQYPWzRJTa4CqW3DZzDdCwksPqW-0YiRFXFQbA>
    <xmx:vaG5aDsm_S_89i1knQOmVOc7FE8yIZJCYwJyUWnVXzSmm_rpEOVE1Fh3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b28d15e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:26:43 +0200
Subject: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
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
 meson.build       | 16 +++++++++++++++-
 meson_options.txt |  2 ++
 src/lib.rs        |  0
 src/meson.build   | 12 ++++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index e8ec0eca165..1c0e98bbc14 100644
--- a/meson.build
+++ b/meson.build
@@ -1702,8 +1702,21 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
+libgit_libraries = [ ]
+
+if meson.version().version_compare('>=1.9.0')
+  rust_available = add_languages('rust', native: false, required: get_option('rust'))
+else
+  rust_available = false
+endif
+rust_option = get_option('rust').disable_auto_if(not rust_available)
+
+if rust_option.allowed() and meson.version().version_compare('>=1.9.0')
+  subdir('src')
+endif
+
 libgit = declare_dependency(
-  link_with: static_library('git',
+  link_with: libgit_libraries + static_library('git',
     sources: libgit_sources,
     c_args: libgit_c_args + [
       '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
@@ -2239,6 +2252,7 @@ summary({
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
index 00000000000..2bd2045a8ab
--- /dev/null
+++ b/src/meson.build
@@ -0,0 +1,12 @@
+rustmod = import('rust')
+
+libgit_rs = static_library('git_rs',
+  sources: [
+    'lib.rs',
+  ],
+  rust_abi: 'c',
+)
+
+rustmod.test('git-rs', libgit_rs)
+
+libgit_libraries += libgit_rs

-- 
2.51.0.417.g1ba7204a04.dirty

