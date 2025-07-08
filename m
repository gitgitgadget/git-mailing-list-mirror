Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA557299952
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961479; cv=none; b=FbyfQih7762XS4Fj2LdNDUnlvMBxcy0/1HYwelMNtkwiPPEVeopMShRdu6hkfMP5Cwbv/MZk0ekeVINswP/S2Yl1QXgteovKgwyxdKNpIual8xq00LUTailwRqeZpXtqtpbtv8WLTpSA/xl9O9Iv6KbADkci20LiqFdXVs4ul0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961479; c=relaxed/simple;
	bh=RtwqhFBJt4y05kSqqv7Ga4DIRFs+Fb5KiQWQOjL1hvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJ4X4ZfXmLl0DfUD7hTphAqnwkawh4hJDDKSCkJyu5N3XI1peoQucWapfuMdm82vApe2D0KIjMVAm/4/SbnTnA5a88CCv37ARUn+CMmIozHwniPxsFA7iQ5+Jkf4/VBEQK3Djh0jmNh9RidH/A/2MvooDm7NKwMEK58e/y0K2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mAvZiCir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aj9j3I9b; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mAvZiCir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aj9j3I9b"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4D04140022F;
	Tue,  8 Jul 2025 03:57:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Jul 2025 03:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961476;
	 x=1752047876; bh=pjg/GzGbvEXoOVHUHvCNk6Dez0yblk75di76Mw20+Ks=; b=
	mAvZiCirImOozJ7VfsOiOkvl+e6HzoTosLqars+keyK3uRIUkc806bDODY5VomvM
	ay82OittSiztp56+04QS3JV2OL0axMCTYwmsGHxrJ8BVo3dD9Vsym1nBWH8A5fqC
	f8r+p8CTctrPN2+LpnKaIQUv/sc9TdvXyZ46joEHRPwUqQQ/t4BibulCoH2fOE2n
	+5c19AsULfRje4mmBYIvyLPnTwqoi4Vb4wp72lVKD/d5rhwKgDcHhBCOO0rYrQP6
	OzU/jwKV5k0aLxRN+xt3D6n0MWS4aBeSF+SItDotFJ/ofrP92GlGQsTRzd0hatn2
	p5zkbrgAQmX1A98sGbG/fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961476; x=
	1752047876; bh=pjg/GzGbvEXoOVHUHvCNk6Dez0yblk75di76Mw20+Ks=; b=a
	j9j3I9bCj2k6wJMB24FU6hW9pfr7ctoF/DOrld1V2kv0M/p5nOjgQKW6G9T0mMo/
	GRozVdZLN8OnCZQclHK3TdKa2jLJVrWHBfgVwiVL2d9glilEHTOgLE7v4R1hEphu
	Bc7gm8TlB9ufv9UCDADuRiJb+WSwmFuAlVCZXtCSAS3hFo/WzQ7RsPadZPct3RU/
	xeklByRyvOSr5kwUqBH1ikI8Wo+/4//3JzSNkCnoeqzP1q6wsbVbQGfNlCfeD8Xl
	mdkpXihaXGTrKQ7lRg7dY2/gEUFbge8IQZTzZ/hblQRs0wNtD9klYlf2gPxOjpyc
	tDE3Cpb3ALVtKuuunukLQ==
X-ME-Sender: <xms:hM9saJ4oHKZKSMnCQob3LiCBnfMMl0bU6zYfj9Mxs6NVr_qcm7krVA>
    <xme:hM9saHoOmeI5ITVNT2Xooy3nCqIdN5yt4ZPRUvNKLmonXMj8hVxO9c16Kiq6kvKBr
    yGm5ktEizIieoPkhQ>
X-ME-Received: <xmr:hM9saMnk1LFDxFCXZ0uxXKIGxAJcdgbJMhLX2yYNs0YAuk_u-2XH_XY_c3bEtT2bx6mzfGTDlqXTVocH4GQRNnOYl5D_rdqVtBqCjd7IrC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrghdprhgtphhtthhopehirhgvtggtrgdrkhhunhesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:hM9saDN2hkJnfHg5m-FA61bVYbmgZWzDLHOc0IQRbNr7rSe8LYGJUQ>
    <xmx:hM9saAMqRFGaGhVvPJyf28-IZltB_dEbQkvtgbBFH1jMuuB2f0zw2w>
    <xmx:hM9saEhxzBdfiypRNss2fI8abGpenK7jbo54lZ-NX4LF8kTIWydRrg>
    <xmx:hM9saNtZ4jyj0h15bU8G69VfUw6WMbf5lxbKUYrFr3yjKJ0YUxrCGA>
    <xmx:hM9saBaggCxZa9uZZUJvQDUFY2XaALIQHQDVH8_xUzJedu160ua_6r42>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:57:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d6c4e0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:57:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:43 +0200
Subject: [PATCH v2 2/8] meson: stop printing 'https' option twice in our
 summaries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-2-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The value for the 'https' backend option is printed twice: once via the
summary of auto-detected features and once via our summary of backends.
Drop it from the former summary.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index 21fdff0f496..4e41c3007bb 100644
--- a/meson.build
+++ b/meson.build
@@ -2197,7 +2197,6 @@ summary({
   'expat': expat.found(),
   'gettext': intl.found(),
   'gitweb': gitweb_option.allowed(),
-  'https': https_backend,
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
   'perl': perl_features_enabled,

-- 
2.50.0.195.g74e6fc65d0.dirty

