Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5E2343A5
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757247; cv=none; b=iMn+0TK/WXfmvcyRfO+nekN4Lb2rB8nJ3zZeeZ3cNXuaGioEXoJlJowZp7/xKsBrAcZF87y3blI9l7W/sIce4ZwaGk3v1WvqPd/Z5a6YmZ7NXsLAy8NeWFr+h5wnsPio6PjBWmMRkpWU1MD5yWKJ/YeVc49eGKzypsOnhKLCqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757247; c=relaxed/simple;
	bh=kB5zdHoXu3t+oPAvdoE5S81nT4nrfyXveLXDLoyZDHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDrh6w4exBel2nJ/YvjM0U/JUtHwaUOKsiBfewK/RMTdGWmYfGSJoN4buZ9TsNSPwRe4CUZx2P5DAXmrBBaEz0GNQzxQe+jx2EAFqL9a5s/gmitUNJtM/ilwVvgpt1aFUESBli6ko/cyPv63EebFLmouz0rF67A4lf+z74H1HkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mbS6Lioo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDeMFcK1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mbS6Lioo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDeMFcK1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B78C1140139;
	Mon, 13 Jan 2025 03:34:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jan 2025 03:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757245;
	 x=1736843645; bh=s9ekD9NLDs0JPpLlp3fJoVFsnFdaez9db1rIcUI7xXQ=; b=
	mbS6LiooqWCnPInCpKRJTLDLGmIoFls2pCjiudggf1/FKJLTwUsAHGJrW9ruqoUY
	MhWwcKDwf7mSOlnddVgAztOSNN3rwCoJJf8k+AxfLC/c5M9VYBi2Rpc6BQEbs3Xo
	vUGpREXutmjJZ0tv34chvqvB1Xcc1SR9JDdmYMRbAyVw6716f6LrBnQ8eZDA213n
	oojazJxla10c/t4BZoeb7BCUGrG7eYPeesN/CQpOyCABlgWTJN25OgwjnzYB7bgZ
	1iWS6nI43RTrKrHy5++otcL++2joftU+Jl34ZMVde7IdO6caSC1qLDzdWof+MRg3
	TbsAolg6v986TpLCyki7Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757245; x=
	1736843645; bh=s9ekD9NLDs0JPpLlp3fJoVFsnFdaez9db1rIcUI7xXQ=; b=T
	DeMFcK1gMjiCFaTtBOl4HItdoYi5e5PXcLZKJgDBno5wNlUG0dwGQqqbsaTMcnEl
	71RAAJW+RlRFeYp7NJ4GPrGK0qo0CrXXtjOO+9IGEgYt7VF9C85SuQsKtG8vAQb9
	xReypmMcZNpKvQp7JoVD3choCHSAEApb6INcAuMpFBMlFlxzv2SggjiHSk1Vz7Bw
	CFjfE0jxI8EzZTlukSEU21sHlI+hE0LlYnPIo9MErgHfBQ5x17qjJvw5LaRr5rut
	VvEPK1AxIdjCHPOQPQ0ft2gMqzyCPEt/7TDkI6jjU9j2Ajs7ftS0v73M40nRfS0s
	lmKrt9zvv8PUJ6YH5Hy4A==
X-ME-Sender: <xms:_c-EZwGHs1YSDwGfdiHalPTL6BrS6u46ZBemCphQzWN0qk5tNY3cWg>
    <xme:_c-EZ5V9ndDC9dNy7jmN4y-gDwOiGASqmvwWRqXabyiNLHW30qZulkhnV4wChtYp9
    SYwfvZ_26N_MIyyPA>
X-ME-Received: <xmr:_c-EZ6KunkR3Zve8tBcveDexuwPq6__UoC4KfpVoTXW9itgaKYlycUo_OzuqZuseNyd1A2F6OS4lrpBBa5lohIFfWXGr3457ge9oOH3ISQg35Xef>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_c-EZyFTsYYXuqzxQZa8YGgzbs5MkF8bv8dTxijsjGKv3algVcgVPg>
    <xmx:_c-EZ2XP3ybDq1ltqONWfmv_SrxQhx0OIpw99LdOMzGVd71CqyBkug>
    <xmx:_c-EZ1Ooounf9IabHCFdxwMx7SgW4MGJtUnz1KtC_qbWH8vvE_eq_A>
    <xmx:_c-EZ93OnTbCIq0hJtQAXoDIpXG5S4dv4mwynKkFcl_9AH6ylvA0JQ>
    <xmx:_c-EZ1SlKuvFLLDUcMzvrsKBhqau41ofIu5h1BCgq2F7IaGiGb0XlpVl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36c40c61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:34:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:40 +0100
Subject: [PATCH 7/9] meson: make the CSPRNG backend configurable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-7-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The CSPRNG backend is not configurable in Meson and isn't quite
discoverable, either. Make it configurable and add the actual backend
used to the summary.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 26 +++++++++++++++++++-------
 meson_options.txt |  2 ++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 5e1373f6a52a91beb527d00d8fd5c55d377c718b..cb352ce6fd50616e3281a776104692c5b2bfa5b2 100644
--- a/meson.build
+++ b/meson.build
@@ -1325,6 +1325,7 @@ if not meson.is_cross_build() and fs.exists('/dev/tty')
   libgit_c_args += '-DHAVE_DEV_TTY'
 endif
 
+csprng_backend = get_option('csprng_backend')
 https_backend = get_option('https_backend')
 sha1_backend = get_option('sha1_backend')
 sha1_unsafe_backend = get_option('sha1_unsafe_backend')
@@ -1336,7 +1337,7 @@ if https_backend == 'auto' and security_framework.found()
   https_backend = 'CommonCrypto'
 endif
 
-openssl_required = 'openssl' in [https_backend, sha1_backend, sha1_unsafe_backend, sha256_backend]
+openssl_required = 'openssl' in [csprng_backend, https_backend, sha1_backend, sha1_unsafe_backend, sha256_backend]
 openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
 if https_backend == 'auto' and openssl.found()
   https_backend = 'openssl'
@@ -1421,18 +1422,28 @@ else
   error('Unhandled SHA256 backend ' + sha256_backend)
 endif
 
-if compiler.has_header_symbol('stdlib.h', 'arc4random_buf')
+if csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
   libgit_c_args += '-DHAVE_ARC4RANDOM'
-elif compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf')
+  csprng_backend = 'arc4random'
+elif csprng_backend in ['auto', 'arc4random_bsd'] and compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random_bsd')
   libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
-elif compiler.has_function('getrandom', prefix: '#include <sys/random.h>')
+  csprng_backend = 'arc4random_bsd'
+elif csprng_backend in ['auto', 'getrandom'] and compiler.has_function('getrandom', prefix: '#include <sys/random.h>', required: csprng_backend == 'getrandom')
   libgit_c_args += '-DHAVE_GETRANDOM'
-elif compiler.has_function('getentropy', prefix: '#include <unistd.h>')
+  csprng_backend = 'getrandom'
+elif csprng_backend in ['auto', 'getentropy'] and compiler.has_function('getentropy', prefix: '#include <unistd.h>', required: csprng_backend == 'getentropy')
   libgit_c_args += '-DHAVE_GETENTROPY'
-elif compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>')
+  csprng_backend = 'getentropy'
+elif csprng_backend in ['auto', 'rtlgenrandom'] and compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>', required: csprng_backend == 'rtlgenrandom')
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
@@ -1969,6 +1980,7 @@ summary({
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

