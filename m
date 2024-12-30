Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D11A9B3D
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568656; cv=none; b=bixAShHFwyBkiC2aKPJDlPNhLEOgzdpMXtmNhOQi21qkEcxQm99JA/N5iIoVNwQDTMDHk9LgusArq7pLQ+XpyMEcNkfN8sEHRJzt83q6XRzTWnw3pLnaVQillgpHxnaDLGKMh7EoKHAZzG8RnsMFhkzaoWs5/6nTqQCILtkWJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568656; c=relaxed/simple;
	bh=f4j5qHrXcxEI2Xxo7gXYMi+5xZHEfMGfRSrrft79XOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZGr03eUtzqPRG/l0Rz1gk43qSlq+v2Iug9IoFC75NO+Vxh3QhG6UICyO7pKlgP4IRfLdEIHAdjY7xRBUFz2NCXrO8UMwj5W+s7hhifb/5iuurTUOa/kea0yrzrDfx5icePzSgjw1AqBM3VlLrcrMVgd62ZvBCP7pV4PCXxFjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPs4RmhF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8gHzTTQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPs4RmhF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8gHzTTQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ADB9E1140190;
	Mon, 30 Dec 2024 09:24:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 30 Dec 2024 09:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568653;
	 x=1735655053; bh=KynKY8HHWUrF3HJwh6jviUUOFfXluBQ3hYG3l1ZEyIs=; b=
	WPs4RmhFrGTG+O2+dy/K8ug81mfdI2wmunyqXo1BxM1dh5ErTiSBPR5mKOWq46Eg
	XIVRt21wFx1H0mhsEWnUgwP4TLt6OzeXNhSpNtsPvZExLwTsLDDtLsuy8plrwTbx
	3P/9XCgDYZn+DDv6w0/QFk1naEMPn8gnoAVqu98D9E51+x1ekJksDUxFqZW9oS8i
	f/1MQCHpQPNsd8gPzxQrD/SvvkOwWFrxGtK1+prhNs4XS23yWO85q3U6DcvW61PE
	LOB+VoAxOqzPYFLY/yDB2uXwY+4cZ81PbAY3j2Uqmi/N5Skd2ZP5StfX/fCZT7fx
	zXaxy4iNmUDrrVzXHbBYZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568653; x=
	1735655053; bh=KynKY8HHWUrF3HJwh6jviUUOFfXluBQ3hYG3l1ZEyIs=; b=j
	8gHzTTQXRpUnra/Gdp8I6MZesnpCDr0jnTiBNow1OQfLcMep3Yam7iycFeorKa5g
	7pvM4qcd4Z0BDQMX1yfVNd18zJcDGA7n3p7lNlp4CbLi/8yd4DlvQ7S7RKv5Y/7o
	pZhJLoyP7ymAAt0GHMclkWku/TV4zQU4SOxHyCDcH4zRc7ebxE51rCjNlUX99y6p
	6zseQM7mWDhCcfCXXrlTCg+RsKDYSZ5z0Z2fe8jJUaTMySBXYpDBEdYjFx+HKlUr
	UvbdE63Xp+2rDW5upgMiP8ZVdvbXRFNChmxEa7MVUgudk50YgM1yaCr1F+RaAK+z
	18HYD3Gty1hX0CSMAQajg==
X-ME-Sender: <xms:Da1yZ0DrAGhoWUHmC-Wk4ccxvPGj-I6DKaQ6bjHOW4PdR6nzcZA9-g>
    <xme:Da1yZ2jGtcLqDVc0lspUHpMycsh_Tlxut6F6tnuocEDb3tRGjMtSqH8Y5VOtl8MIj
    9Oh3NG6eCG3ZziNuQ>
X-ME-Received: <xmr:Da1yZ3lC50anfvaEj-JpBNxBZ36VUZSb289a1v6o5PLOq9qd_rSnv6ZCSYDHOSGt2mdEXga-sm0l-xNzqcxN19crSP3g-VHBmEk8-a0bLnXHIe-1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Da1yZ6xvn3DIGvKNDUg_kVvEp_g7StJyNsnNw-1dN2Me4hI5OpWI4Q>
    <xmx:Da1yZ5TYCommm1cQ3QpzcShUcwO8qFYqT6sFzXRmci8sxJr2rFIMPA>
    <xmx:Da1yZ1bLiZlQhWEky0jG4y9IQrxsBqusinCU9AEcIjpRI79tGD0jTQ>
    <xmx:Da1yZyRpQKYTFGhL--mVsGJvtsg-atC4_dmIwqosLGjieDrT5ReWfw>
    <xmx:Da1yZ7cFJBMBE9VU0ue9AHRAEZ3Dk6sU_2ig4cw9_GnWrdqk9wSkdb4V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d342b4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:05 +0100
Subject: [PATCH 05/10] meson: deduplicate access to SHA1/SHA256 backend
 options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-5-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We've got a couple of repeated calls to `get_option()` for the SHA1 and
SHA256 backend options. While not an issue, it makes the code needlessly
verbose.

Fix this by consistently using a local variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 9da58dafe0f1023cc72f4ea3eff5515c9d479099..6fa4d900ee02f0b80bc3c36d58a07a118ec3fb20 100644
--- a/meson.build
+++ b/meson.build
@@ -1326,6 +1326,8 @@ if not meson.is_cross_build() and fs.exists('/dev/tty')
 endif
 
 https_backend = get_option('https_backend')
+sha1_backend = get_option('sha1_backend')
+sha256_backend = get_option('sha256_backend')
 
 security_framework = dependency('Security', required: https_backend == 'CommonCrypto')
 core_foundation_framework = dependency('CoreFoundation', required: security_framework.found())
@@ -1333,7 +1335,7 @@ if https_backend == 'auto' and security_framework.found()
   https_backend = 'CommonCrypto'
 endif
 
-openssl_required = https_backend == 'openssl' or get_option('sha1_backend') == 'openssl' or get_option('sha256_backend') == 'openssl'
+openssl_required = https_backend == 'openssl' or sha1_backend == 'openssl' or sha256_backend == 'openssl'
 openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
 if https_backend == 'auto' and openssl.found()
   https_backend = 'openssl'
@@ -1354,7 +1356,6 @@ if https_backend != 'openssl'
   libgit_c_args += '-DNO_OPENSSL'
 endif
 
-sha1_backend = get_option('sha1_backend')
 if sha1_backend == 'sha1dc'
   libgit_c_args += '-DSHA1_DC'
   libgit_c_args += '-DSHA1DC_NO_STANDARD_INCLUDES=1'
@@ -1382,7 +1383,6 @@ else
   error('Unhandled SHA1 backend ' + sha1_backend)
 endif
 
-sha256_backend = get_option('sha256_backend')
 if sha256_backend == 'openssl'
   libgit_c_args += '-DSHA256_OPENSSL'
   libgit_dependencies += openssl

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

