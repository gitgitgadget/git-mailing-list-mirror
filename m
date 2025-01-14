Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301124025B
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855784; cv=none; b=U8x9835kLWjGTNF90e9lp7rmn1dyqoijUeiLRGkpsjBSp/Un7dZxdusO/67O0Q0e+G33dO7j1u95v37EiNX2wgA4HS2BwSs6eMBvP+XMqGw6ZT90diMCJW+X1DA1Rhd4g99cINpQDXs+2wLOxWPNIvwru2MAHnHfu5kQVjrU+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855784; c=relaxed/simple;
	bh=1/ZMGrjHzkYgB+k/z2RG+GIoGpdJOTe6AlYZQ2TGW8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V803wvi8L7IiVqA+xkVSS7laFfaj/N5Tu2KgHNlBYr+Y8EY0tukxjRZOvWpP+BHBElsHDDTzxDmxFTd+GSDIF7ubyJ3x5PIc/dllr4Mnaiiovfm7QrMGynJHlMdhZhBDEa2zZ3RIoIXdgPYtBF1990++gf/Kr5XDlspDlpGA82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kO3R40WU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnvWVdjq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kO3R40WU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnvWVdjq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 56F5913802DA;
	Tue, 14 Jan 2025 06:56:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jan 2025 06:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855782;
	 x=1736942182; bh=NdXRFBALmsgg9pu8o5pE0rU71pzDb0632ki0cnaDLWY=; b=
	kO3R40WUzVRsEE/xdvQhzYmdeRVTaQqA94Xm3WE+9HLijnBTx8Cya8PiA2xGQckI
	y9uDfXxlPG4CO46PpjkAJeY9TGt950k5TzrLjGTQ0IyJj+iVJKdlhE4jX1ZbA0RM
	YeLzopuuwdHqit8ECT2WKdKvQ7NW49iunlRH8q6oIAmkk2AhWBhL87UUxPAsB9TW
	r95bJgATMxBVAm4PIAdzOdIzpmZazS45mCWtBCHUTM5QkniWtrrqDrlLiSZ4o0ts
	DqLeisFbAdzfhaXxs1dD4ZK5baltPo+n0hxbLg/6xgu6NP8rn3ZumrhJRoOrtFnE
	6wf6Iav4tp44Q8fStlyKHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855782; x=
	1736942182; bh=NdXRFBALmsgg9pu8o5pE0rU71pzDb0632ki0cnaDLWY=; b=X
	nvWVdjqklC3d/j0kEWM0+3ovGHr968CyXqzLJwZuK4mfhomGVtgs+i2Us1FHMN1G
	AE3O9hQG8w5x7AeG0i75MztwJ6Xe7Fa6VOQqZds+IdPCTd3LKgENExA4uCzWu/K/
	FX8gdB3BaI8zGMxblog2+OazFRnmVvRxUDNTTCoe67I5IaXzZD7bAxoRzJkjd0jU
	ekyliWwgtsUlIIlZXaIJiPhgMl+XWl9mOc41GBfiIv4hJ8PMhFRpBqhe/4+/R2bZ
	pqvZaYKk6pY7w9kLNiT1l6o4rE6nwihG/vjYWzqS1QYQ+3yQjaymSFtI5fqvY3u6
	fFpFo/w5FPCdDRYTs/3MQ==
X-ME-Sender: <xms:5lCGZy9yk3ormz5Oolklnht42qiXMbC2lzgEEJ6ewBgJ7UzRt8ACXQ>
    <xme:5lCGZyv0p_bwWfsKOpcq8hJU1s8mCPHpW-MKvBFDV_IUCNX2kj_WlkaEXPErBy0ub
    Yv81yPz4QtaeiHKFA>
X-ME-Received: <xmr:5lCGZ4Dw5UO4NSZpXrN7XeFRr_aJBl2bbaVxkJDtIsNkYzOJoJZ-dllc0PLD2iG6y-jkt_OQGzKKyvqUtWBjfeqB0D_D8DsVej0_pDx5NLtIvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:5lCGZ6fS3XkxoM38wJj8BQ6zBp0GdrAbyVEyhlWu_tyDcRUBeXjDdQ>
    <xmx:5lCGZ3N_7G7Jv_9v-weMsbPT8mT77xn_qNWBRpPVRpfMDgGqw-PT7w>
    <xmx:5lCGZ0kyHm7FLbylcj6n2Uc9wkrlHAQM7mc8p3dr4Mp66WDvDxXGAw>
    <xmx:5lCGZ5uQ8h8DsHSYM14HksB7WlcUvJlwFLatLxXl95aJFy2e-O8RIA>
    <xmx:5lCGZy1zvCSW9PtRftNPh1HrOs6z_qksuxOIlcjGBnLtB1TPzVrw9dfI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8b26b81c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:18 +0100
Subject: [PATCH v2 08/11] meson: make the CSPRNG backend configurable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-8-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The CSPRNG backend is not configurable in Meson and isn't quite
discoverable, either. Make it configurable and add the actual backend
used to the summary.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 28 +++++++++++++++++++++-------
 meson_options.txt |  2 ++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 95baada74af8f7731867e7075d9986b32a034ff4..e50ccac5c9f6d310d8c9f83d893ea802b5827252 100644
--- a/meson.build
+++ b/meson.build
@@ -1332,6 +1332,7 @@ if not meson.is_cross_build() and fs.exists('/dev/tty')
   libgit_c_args += '-DHAVE_DEV_TTY'
 endif
 
+csprng_backend = get_option('csprng_backend')
 https_backend = get_option('https_backend')
 sha1_backend = get_option('sha1_backend')
 sha1_unsafe_backend = get_option('sha1_unsafe_backend')
@@ -1343,7 +1344,7 @@ if https_backend == 'auto' and security_framework.found()
   https_backend = 'CommonCrypto'
 endif
 
-openssl_required = 'openssl' in [https_backend, sha1_backend, sha1_unsafe_backend, sha256_backend]
+openssl_required = 'openssl' in [csprng_backend, https_backend, sha1_backend, sha1_unsafe_backend, sha256_backend]
 openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
 if https_backend == 'auto' and openssl.found()
   https_backend = 'openssl'
@@ -1428,18 +1429,30 @@ else
   error('Unhandled SHA256 backend ' + sha256_backend)
 endif
 
-if compiler.has_header_symbol('stdlib.h', 'arc4random_buf')
+# Backends are ordered to reflect our preference for more secure and faster
+# ones over the ones that are less so.
+if csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
   libgit_c_args += '-DHAVE_ARC4RANDOM'
-elif compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf')
+  csprng_backend = 'arc4random'
+elif csprng_backend in ['auto', 'arc4random_bsd'] and compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random_bsd')
   libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
-elif compiler.has_function('getrandom', prefix: '#include <sys/random.h>')
+  csprng_backend = 'arc4random_bsd'
+elif csprng_backend in ['auto', 'getrandom'] and compiler.has_header_symbol('sys/random.h', 'getrandom', required: csprng_backend == 'getrandom')
   libgit_c_args += '-DHAVE_GETRANDOM'
-elif compiler.has_function('getentropy', prefix: '#include <unistd.h>')
+  csprng_backend = 'getrandom'
+elif csprng_backend in ['auto', 'getentropy'] and compiler.has_header_symbol('unistd.h', 'getentropy', required: csprng_backend == 'getentropy')
   libgit_c_args += '-DHAVE_GETENTROPY'
-elif compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>')
+  csprng_backend = 'getentropy'
+elif csprng_backend in ['auto', 'rtlgenrandom'] and compiler.has_header_symbol('ntsecapi.h', 'RtlGenRandom', prefix: '#include <windows.h>', required: csprng_backend == 'rtlgenrandom')
   libgit_c_args += '-DHAVE_RTLGENRANDOM'
-elif openssl.found()
+  csprng_backend = 'rtlgenrandom'
+elif csprng_backend in ['auto', 'openssl'] and openssl.found()
   libgit_c_args += '-DHAVE_OPENSSL_CSPRNG'
+  csprng_backend = 'openssl'
+elif csprng_backend in ['auto', 'urandom']
+  csprng_backend = 'urandom'
+else
+  error('Unsupported CSPRNG backend: ' + csprng_backend)
 endif
 
 if get_option('runtime_prefix')
@@ -1976,6 +1989,7 @@ summary({
 }, section: 'Auto-detected features')
 
 summary({
+  'csprng': csprng_backend,
   'https': https_backend,
   'sha1': sha1_backend,
   'sha1_unsafe': sha1_unsafe_backend,
diff --git a/meson_options.txt b/meson_options.txt
index 34ba679cf931b67a794a9bb7e765bfb22106381e..5429022f30621105cd6974e4260cca60e5f24324 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -47,6 +47,8 @@ option('regex', type: 'feature', value: 'auto',
   description: 'Use the system-provided regex library instead of the bundled one.')
 
 # Backends.
+option('csprng_backend', type: 'combo', value: 'auto', choices: ['auto', 'arc4random', 'arc4random_bsd', 'getrandom', 'getentropy', 'rtlgenrandom', 'openssl', 'urandom'],
+  description: 'The backend to use for generating cryptographically-secure pseudo-random numbers.')
 option('https_backend', type: 'combo', value: 'auto', choices: ['auto', 'openssl', 'CommonCrypto', 'none'],
   description: 'The HTTPS backend to use when connecting to remotes.')
 option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'CommonCrypto'], value: 'sha1dc',

-- 
2.48.0.257.gd3603152ad.dirty

