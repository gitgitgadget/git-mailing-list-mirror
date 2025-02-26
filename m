Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17118189B94
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558149; cv=none; b=tIhpN1+lAUI0Vzc/nl0CsyWjoJmzPJ2udR/Rq9dJiSaGYcbEHqGtXwHmnDgpXdRoLH+UuI8MwzvKT9YGMCUaIGnZ0CVnFtK/gUMMX/k1wYywdKGePYnn5VEoorKwfRT5hM/S/IpAK0tHZ61buANUm4SQwwXlyJd6x3Ge0/VN9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558149; c=relaxed/simple;
	bh=QwHX4kzniNWQHSS0nscvYUH0MGPn5K8/wKtmXPChiFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ki/gX0LmWtRYXK84JbSMVYV6HgnS4WiCyD+RbSLkSJ4tZiWJtNPM07SwWEIkwZAt/fpYqMonpVkZ2IZc2qtAX5xDRG/RWJ+8og7+B4ZD7hG//LTcqwUoLQey3Ih3lS37tzwwTSGhvBpypv/sPGUOzqXoa5aIZum3Nw2sC7M2N6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DW+P8d79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yDKLWpEe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DW+P8d79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yDKLWpEe"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24AA611400A0;
	Wed, 26 Feb 2025 03:22:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 03:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558145;
	 x=1740644545; bh=LTHF9Z0vbSMnEjrJXlCTNsdjP2O81MfdlYn7sXKZfJ0=; b=
	DW+P8d79kg1nT2+fqtTcX9SFyybHTFZfvmGdT2rfn+GHOjzdvn3/jMcyH1lqEcsc
	5LCsSWT4ZujSq7MRI2T380lLD+z2xryWXjcV7xipOSrQ8kg83n7uAhYL40tH8ib9
	rHZq28Ni899I9EOFK1xppz4YjGvmoG8j+u2GFsY8CoFHX7YpUmuoqpJE6HPBBj8g
	Wdnn7YOGaJNhlBQ5o0x+S/doa9mC47mAsgpJevsUhlTGW0D/BN4tq3lrxjQBlgRR
	eW7UXU1NrAC/3dpP36XBqvdHsE7Q+49veTbiHqWp7X8PlsSIJ/yjA+cHU9qxbekU
	I3X/KNBjf0VpJHyL5c6nJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558145; x=
	1740644545; bh=LTHF9Z0vbSMnEjrJXlCTNsdjP2O81MfdlYn7sXKZfJ0=; b=y
	DKLWpEeFyq7pBB2kpT8eNxG7WMGC2IYqRl068iDqObfg0kj+0/hdSN33/RpFKWDE
	B9YfZhLfAAq/F6Up04JB+Eg0ohPktMviiTso9k1pKfM64ikapn6H8weFCntk28MA
	GTFrxrdUnbwVosW/bean7B6QcXnUN9IdtbZHSxWGCs7EmiC4PvkW/zt0Vwc13UnQ
	SzgdxXBudEdtiR7pm+w+SwgAbCOVaCNWyyBzXAElBzL04rruecVzctNdUI53ztoc
	CozPXoS/SwIJjc1LSTBIQShXn8uXmpAs+RANDfEoBU1tHGnPk5RGgq2A7hO+W9b3
	zlkL2T5wlRbRYQZwgpNWQ==
X-ME-Sender: <xms:QM--Z8rR1EZ_AAntQNfSs2CrrK87hrhgVP7uF8pmq_7WXdVi7L8u3g>
    <xme:QM--ZyrrRjeSaeDdxWvLdaBjAoTDGVn3BxvovhJwHsZkw7HeHja7NIjflSHbqEFuR
    jTdMWWxA7ST_HiTww>
X-ME-Received: <xmr:QM--ZxM1km5oTYnmcC3T6xnN16pwES4pBlH_OykYHeLeTSbmx0VRq3B-kt9xtTt08x5aTEPsCNa3S81rw3Fu5wldRCFePyOaCNOWHbRc5X1FiHyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepgeegudehhfejveeujeeftddtjefhleffhefgfeel
    gffgfeehudegieffvdffueegnecuffhomhgrihhnpehpkhhsrdhimhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Qc--Zz4XVxyDjCOlKSRDTgN7xRKn-VS1jKFgQ4XD9-5l-W7UzdbWlw>
    <xmx:Qc--Z75dYr3Z_YQw2wyO1aQsOSP_r2zADvpRYvmv5WR2DN0xmYq8Fg>
    <xmx:Qc--Zzg6KbMtqj7hxypRo8ZwZ8P375wsDzD4XYRRKfjjZpeA4CNLSg>
    <xmx:Qc--Z16rGQHbRHGMMGJ3GRbD3_DeThkdRvl_tgc7qcGkkfF3l3WQEg>
    <xmx:Qc--Z-0HRpE6voTQ2oZ_VI8Bzt53EMJ3a8aKl6j-rQiztk1B9CMHGEE1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5d2b67b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:12 +0100
Subject: [PATCH v3 02/13] meson: fix OpenSSL fallback when not explicitly
 required
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-2-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When OpenSSL isn't provided by the system we know to fall back to the
subproject wrapper. This is especially helpful on Windows systems, where
you typically don't have OpenSSL available, in order to reduce the
number of required dependencies.

The fallback is broken though when the OpenSSL backend is set to 'auto'
as we end up calling `dependency('openssl', required: false)` in that
case, which implicitly disables falling back to the wrapper.

Fix the issue by re-allowing the fallback in case either OpenSSL is
required or in case the backend is set to 'auto'. While at it, fix
reporting of the backend in case the user asked us to pick no HTTPS
backend at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1f83dc58c24..83ed55c75c6 100644
--- a/meson.build
+++ b/meson.build
@@ -1352,7 +1352,11 @@ if https_backend == 'auto' and security_framework.found()
 endif
 
 openssl_required = 'openssl' in [csprng_backend, https_backend, sha1_backend, sha1_unsafe_backend, sha256_backend]
-openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
+openssl = dependency('openssl',
+  required: openssl_required,
+  allow_fallback: openssl_required or https_backend == 'auto',
+  default_options: ['default_library=static'],
+)
 if https_backend == 'auto' and openssl.found()
   https_backend = 'openssl'
 endif
@@ -1366,6 +1370,7 @@ elif https_backend == 'openssl'
 else
   # We either couldn't find any dependencies with 'auto' or the user requested
   # 'none'. Both cases are benign.
+  https_backend = 'none'
 endif
 
 if https_backend != 'openssl'

-- 
2.48.1.741.g8a9f3a5cdc.dirty

