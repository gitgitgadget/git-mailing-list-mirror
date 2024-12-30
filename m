Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800991AAA15
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568658; cv=none; b=C6cOqZfMqF32U5GjNVZ/x8PbxfFDcgeszUrwdSHcyTYiauZGtoR6S/0ACTmrPfXgl1SIQ2xKP/WfH7+SP/vauxaWOKUl7rTnoPHP0u7DIdOBYeaevCHtt88G1mVV7Q9UWQ86yXk2FyyXhgsuPnHUFudPhFGkfx7rNxnf3kyS44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568658; c=relaxed/simple;
	bh=qpEfzuMcNo514bSGK24EdJEVrMsmGS+P+wFNN8W1Xis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0lyaIiU04N94Ma+a5TXOF97BwMyCxOh7OSVGTpiPJz6fwJGXNvYcWdz9pA98vuO2zNbUyFgtVsRTtR235gW/Z7EryjQq9XWpJti0eDCz1titdmrKmhwJfcGgblfPaTTE5K7RWRJvY+nH9xNpxH5O1VOMk08JbMBQqD2KuSEgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LeXff+D9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BphY9QnA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LeXff+D9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BphY9QnA"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3F6225401EA;
	Mon, 30 Dec 2024 09:24:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 30 Dec 2024 09:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568655;
	 x=1735655055; bh=kdXKKg1aM4Enzs8M6dQYU3DMegOOVGQ7oY1B58DGaN4=; b=
	LeXff+D9M3wDpC48anmljWovLDgVSPNPBa0WuDv55Ig9LyBimxaSJbnwpcvmrILA
	khrtz04EhDOaTO0MaEE1KCnwy8gq/XxLKAzV21HNy8wh9uNcVhZfrGBO1cwiHQvp
	5za+XnLLlYIWRxQ6FbJX+lQMIJyvGNYMoN3OCDuvyx8ojgaSYvTi4hvfPVBf0vkJ
	3HxCdGeDTS4vuNc/LuhE4pmWkSFD/LeJJ9bjXMwEli/NAz0OqFS7pMFscYv48igq
	R5E2k9Po6BX4o/mCbxDt/cQuPr/KneV2H7C1Dh8jx0DiJzQ8A/1RPZnDDh0czdLi
	VqwzVyJPj5d7CohzSeCHxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568655; x=
	1735655055; bh=kdXKKg1aM4Enzs8M6dQYU3DMegOOVGQ7oY1B58DGaN4=; b=B
	phY9QnA1sQrZPbZz2MkZpqFUHfkdvdnxAeZo3owZb/nzxm8Yba64PZIedP2/+ovv
	a1XDA024ck6Sp5o3p67GRMTHJiouKRJJhsHakNg4aG2gIZXdVN74RWdGHpNTRLIt
	JzubP1eX/d8lx2z0WeP8S0g/pH9nt+D2IsyH5CZ2Zjh2DF8JHpnC3cm7HV2pj8Dj
	KKTrpMJWxCvZ8sRjOmFCwjQ3qB/B7KMQuRb9uxXBAi83pS/PqJ0rDcaQVA75lQ7a
	/KAZzCJ59QYUwZIWiNrgOBN1A4BcMy+GOzuRB3DzuTYtt8+DNgukY4v5xOFOC/kS
	CQB4TRIIwaG5ERfzv7Qug==
X-ME-Sender: <xms:D61yZ4Noz_PryEH4F80qtqFWI3WELZZKEFsGbYvGz6zgIj1CuaIQOg>
    <xme:D61yZ-9N72GbABQW05CNEJXV0LlSESCMl8Mw2hAOD0p4Qe5tLIu2TLGXm_EqsBZsU
    0ySH2YgpwZ8MxjO7A>
X-ME-Received: <xmr:D61yZ_RAncSLSkyjvsTF6HpYnyTadH5z0mWutEot5ehllQ_ZICBBfkC76SrfAwgFk-jclbShqvWoKqu8gfr81fk864Vj44U8eGgOPNxSrEqnQAjH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:D61yZwtMI70oe2L4exni0SYKHB85oB5PGt7iZvhzHqM8P9xc3Yr9hw>
    <xmx:D61yZwcHwR5rr-RkB3NTKD2Zh8qR23W9WQ41x8G4bc_xTXTSCkDKiA>
    <xmx:D61yZ03k2pEor8Hd4s80pvKXpk0GxioWQG8wEYcTWgesQFsedp63ag>
    <xmx:D61yZ0_06XKvLBv5DrMMnAU2pSeZiZ5aqTKU90b1waw5vTxTpfeNDg>
    <xmx:D61yZ46mzHgPC4UuA8py8kQKChW1c6JcGoYvTpxEta4aHPmfkhu9-gEA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 973b548a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:09 +0100
Subject: [PATCH 09/10] meson: wire up unsafe SHA1 backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-9-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 06c92dafb8 (Makefile: allow specifying a SHA-1 for non-cryptographic
uses, 2024-09-26), we have introduced a cryptographically-insecure
backend for SHA1 that can optionally be used in some contexts where the
processed data is not security relevant. This effort was in-flight with
the effort to introduce Meson, so we don't have an equivalent here.

Wire up a new build option that lets users pick an unsafe SHA1 backend.

Note that for simplicity's sake we have to drop the error condition
around an unhandled SHA1 backend. This should be fine though given that
Meson verifies the value for combo-options for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 40 ++++++++++++++++++++++++++++++----------
 meson_options.txt |  2 ++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index 46f807899b7bae33dd6aa7a94a54931d69ab0d62..dc82c23cb4f07646a9a7bb96fefcf832f9840975 100644
--- a/meson.build
+++ b/meson.build
@@ -1327,15 +1327,16 @@ endif
 
 https_backend = get_option('https_backend')
 sha1_backend = get_option('sha1_backend')
+sha1_unsafe_backend = get_option('sha1_unsafe_backend')
 sha256_backend = get_option('sha256_backend')
 
-security_framework = dependency('Security', required: 'CommonCrypto' in [https_backend, sha1_backend])
+security_framework = dependency('Security', required: 'CommonCrypto' in [https_backend, sha1_backend, sha1_unsafe_backend])
 core_foundation_framework = dependency('CoreFoundation', required: security_framework.found())
 if https_backend == 'auto' and security_framework.found()
   https_backend = 'CommonCrypto'
 endif
 
-openssl_required = 'openssl' in [https_backend, sha1_backend, sha256_backend]
+openssl_required = 'openssl' in [https_backend, sha1_backend, sha1_unsafe_backend, sha256_backend]
 openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
 if https_backend == 'auto' and openssl.found()
   https_backend = 'openssl'
@@ -1368,19 +1369,38 @@ if sha1_backend == 'sha1dc'
     'sha1dc/sha1.c',
     'sha1dc/ubc_check.c',
   ]
-elif sha1_backend == 'CommonCrypto'
+endif
+if sha1_backend == 'CommonCrypto' or sha1_unsafe_backend == 'CommonCrypto'
+  if sha1_backend == 'CommonCrypto'
+    libgit_c_args += '-DSHA1_APPLE'
+  endif
+  if sha1_unsafe_backend == 'CommonCrypto'
+    libgit_c_args += '-DSHA1_APPLE_UNSAFE'
+  endif
+
   libgit_c_args += '-DCOMMON_DIGEST_FOR_OPENSSL'
-  libgit_c_args += '-DSHA1_APPLE'
   # Apple CommonCrypto requires chunking
   libgit_c_args += '-DSHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L'
-elif sha1_backend == 'openssl'
-  libgit_c_args += '-DSHA1_OPENSSL'
+endif
+if sha1_backend == 'openssl' or sha1_unsafe_backend == 'openssl'
+  if sha1_backend == 'openssl'
+    libgit_c_args += '-DSHA1_OPENSSL'
+  endif
+  if sha1_unsafe_backend == 'openssl'
+    libgit_c_args += '-DSHA1_OPENSSL_UNSAFE'
+  endif
+
   libgit_dependencies += openssl
-elif sha1_backend == 'block'
-  libgit_c_args += '-DSHA1_BLK'
+endif
+if sha1_backend == 'block' or sha1_unsafe_backend == 'block'
+  if sha1_backend == 'block'
+    libgit_c_args += '-DSHA1_BLK'
+  endif
+  if sha1_unsafe_backend == 'block'
+    libgit_c_args += '-DSHA1_BLK_UNSAFE'
+  endif
+
   libgit_sources += 'block-sha1/sha1.c'
-else
-  error('Unhandled SHA1 backend ' + sha1_backend)
 endif
 
 if sha256_backend == 'openssl'
diff --git a/meson_options.txt b/meson_options.txt
index d8d283982bcdd0f688556e0102c0133061dfb304..8282b1dea8e852fbd3a28309a96fdc83412f245d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -51,6 +51,8 @@ option('https_backend', type: 'combo', value: 'auto', choices: ['auto', 'openssl
   description: 'The HTTPS backend to use when connecting to remotes.')
 option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'CommonCrypto'], value: 'sha1dc',
   description: 'The backend used for hashing objects with the SHA1 object format.')
+option('sha1_unsafe_backend', type: 'combo', choices: ['openssl', 'block', 'CommonCrypto', 'none'], value: 'none',
+  description: 'The backend used for hashing data with the SHA1 object format in case no cryptographic security is needed.')
 option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
   description: 'The backend used for hashing objects with the SHA256 object format.')
 

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

