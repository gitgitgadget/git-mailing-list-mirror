Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F5212FB2
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547563; cv=none; b=OSmCCMvWnLw0X6E3zJxv5D6cHbROWvPICIA54CNWmUjIlJYTPFNpElwfeLyJ2M4E22RoooUiYaFBmff0rjVqJ18jkf9tON0aQo1ppz6UqxYbUv+9ySzDCuRn2le4TqnM5dnREVGuo+YG02SVFSCTO6X/+i4Da0yvkN5+klw9ynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547563; c=relaxed/simple;
	bh=/JrCEUlxIP4VVWbWSTwTZ+1wNmZDTeE88YD/98/PMfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+IIjrVYdnLSocUjKi8myRyucNDwHoVO23FBWbaFgFeWM8M6o+UA6ptlot4wL/LFb9ygH8dZNWJL6DPqU3roppi52sbOMpcrgsFOt9W3KM25V8OzVngp0IVMjSm8IkjUmC9dyznIKq3VUfU+rDdtKF7UG7B3vBbkfy1SBS71jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uppdafg7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObvOHsjp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uppdafg7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObvOHsjp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E73B11400B4;
	Wed, 22 Jan 2025 07:06:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 22 Jan 2025 07:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547561;
	 x=1737633961; bh=FcPGgaN0gI4JyDHDpSA47Pof5qztuZtx26+kcCgTJzY=; b=
	Uppdafg7v3IZzNVaU+sE+VEChlQ6FUfmmXvevEmZfgvScG3KFKBetVdzsVrjCSB2
	AbfWi2lBoiy8C/qMmYyM9JmJSA3phFjk/sxIey4X08qF2mcf0qvl9YDANKT/KOLh
	5DQB1GiZSSsq6k44EcMi9RdMBtPnG0UFNarGG3mWfDhhNbiHajTvij4/A0msJeGK
	os9ThpNE1JXPW89ux+gV2+wTnbMJPJK+gxUlVbusD48T7krs0LtYmy66/KMxnPe9
	aUzsujO1ro/7Q2vxn5NrDN1iAEEp9rHiZMxti5NtKaDS4/SfTPnqiNNC3fVcDEA/
	DDGkurtL1LgXn3oB7qLdrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547561; x=
	1737633961; bh=FcPGgaN0gI4JyDHDpSA47Pof5qztuZtx26+kcCgTJzY=; b=O
	bvOHsjpwsPWhvHhSX+8BQJep02pDsun1MdmNEnfsHyi1L6weSaKx0z8VGAMAdPiW
	uhj531rGGUiY9m8jUCaVi0ZPiGAQ1qy3VEW9wUqAnzYAYYv4Lb/L9GkqQqFCW2i7
	AxgSFZoBcvNAAysypuLQoNcP9btx5eKb2jX1svJnbJgIi/tw3iud+qUatUTa2rRn
	Tds748UOXg+DGXjh6VyzgdXBAwBNl9mR/QGwLxOhaI7FSkdMTbZ9jLHxrAwAliId
	ePjqR0hkvGG+QBcK5F+67Tfvg3olFEzZjo3RHm4SV9eA6SSg1KQMmEfbpSjgSd/f
	5cxFUZl4E+6jXO0wITisg==
X-ME-Sender: <xms:Kd-QZ7nkKMT05MkBxn2sdgTbz8s0yTbP8M4sNoR3bq9TyYY7T3yZ0w>
    <xme:Kd-QZ-20adPUEIw5DP2I7yw1N0gzs3_q7ir7IG_fpv0bH8LyvhYVMI1sqcbMmK7vq
    iHGbpi_7yoNvrFL9w>
X-ME-Received: <xmr:Kd-QZxpPa0Rsbelj2r_3y9wwFBM243UY-V0BR7KYI333i5_XF7E0sS87ba8z3ABAUZB4vbctvJrXT80gTVYOjdZJK2raIPHeUq6ZftLJMddSv1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepmhhirhhthh
    drhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohht
    tghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Kd-QZzl2nUc_NSkDhPvhlFjqWlpr9kJo4nF1fXl3fkkpGjtb7kpTGA>
    <xmx:Kd-QZ51QEp0DGfgOUfID3rXeA6o7Ni3RrriIRhpE2DIZBg6pGu64VA>
    <xmx:Kd-QZyv920z5q-0q8LQ5Ez8T8TLz8ucw8pAyNyGkwy7RKT84Zk3AnA>
    <xmx:Kd-QZ9X-YH-Dg22c6SK0pWecIa303K59FiDqj8O6MDXd7t-iLtM7ZA>
    <xmx:Kd-QZzrqbM819m1TOGQNKiq4PJG9opKWthPwCblcP1PeDguiUprh3o4m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9516d26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:51 +0100
Subject: [PATCH v3 08/11] meson: make the CSPRNG backend configurable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-8-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
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
index 052bd80ac4..22dcd4aeee 100644
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
@@ -1977,6 +1990,7 @@ summary({
 }, section: 'Auto-detected features')
 
 summary({
+  'csprng': csprng_backend,
   'https': https_backend,
   'sha1': sha1_backend,
   'sha1_unsafe': sha1_unsafe_backend,
diff --git a/meson_options.txt b/meson_options.txt
index 34ba679cf9..5429022f30 100644
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
2.48.1.321.gbf1f004a4a.dirty

