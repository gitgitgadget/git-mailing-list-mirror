Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D526B94F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042230; cv=none; b=K6D0LX6cI55ZZwKG2PFgsq/Bmk6+Rdzec1k9dUBCLNoIhpZgsb5Y9DRk4ZMdXU28w5/R928Pm5OHQe6BRDkQKbh2ah69BJQ5vpGZ1yziABCIqlf57gSz5EFmG6kDvbitNfEEjArc8x1qJIQ0VFLtDmRzd9B8HMBY+rekBWJJqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042230; c=relaxed/simple;
	bh=4FkLnjy6yAyqzRpb436j8U+hFmj9bI0nwLS/CTOSOj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=le4Z96EOf7w/+KP3kxta4xh1JTVBiwBKa10CFsH44/ZgteE9ZeD6vpfOp3BNg9qR6H7v/LhcozU2P26wqLeMSNdBAllFQRUTAvxaIAdZ+D5/3CWCyv3ErcFv1iGYaaFD9vGO9p7DubJZRzV3qYzF9TFH8ww6MHWCXufG1owI+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gEvLc33J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TyfyFX2u; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gEvLc33J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TyfyFX2u"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 39837140024C;
	Wed,  9 Jul 2025 02:23:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 02:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042228;
	 x=1752128628; bh=ehTv/q1UsOq85ttIXkJ+cYl5N7AGTX/5bf+xu0l5tWM=; b=
	gEvLc33JhVtgDFZK5zcY+9xOEPT4O8UylRAPz9KAsX02rNYHqofjQRgXvcO61KCV
	0Lq4UfU3MhFzZ7FHqiPmejbq0OEkVPnGX4pn1nGutQz6BIZJH2oDempKVpcg6A0a
	X+2SyYv53J1jspqk0bxs8hvd16t29u79otswlSro3jKMxjVjq/MBAPW+UkSPmeVo
	rWpw4YDn5V6cBHeDWA4X+9mBJzmLo7+PIE5LT0+0zLa6xAaZyhbT2VzBMJORMoFZ
	YBXQaJSHuoJEyvKpiKJIbKRfg8rsvzmKB3JCK1WGQ0svDJBV51uFJa/gKLqyGbg4
	sScDNln6fRjOI6yfMtXP3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042228; x=
	1752128628; bh=ehTv/q1UsOq85ttIXkJ+cYl5N7AGTX/5bf+xu0l5tWM=; b=T
	yfyFX2umAS4haXsA2A04jc1ACTA24n2GitO6eLMnLx9FpcWnZuUCoeK2x+9WUZVO
	HGlo9Xjb6QAiB57Ux0MV1zZoHQid7cBHim1RGbGQHFiZh4kZxLs0CRvBJL4bTeLs
	+aqugDJNdOjN02HPe31dpyARYrskoknckAxIE9FDSdsufzUeK3Hys6hhvhyOLiGG
	cW4r00sK3dEp5Uu/D8V+r8qI/HZtmdoofRzXAO+cyklNjkHELZ2ZOqDSuAkki0Nx
	P4keZFA5uiVoBEoGS2WssdjrE6QXL1W+yp7n7N4gAobWi7bV5p3aKf2yTDG2aP8d
	sRygmYUBLoso2DYNlbdCQ==
X-ME-Sender: <xms:8wpuaAeRiPOmUdb67DUwaGMSOnUG-FDGMi_ja4y5qVHpL9vyXBjz6A>
    <xme:8wpuaGDemm_rBUQ31tOvZnY1_PpVeOK2En5NtxzgejXJdruvsPWeysS-3vx5Q7lXa
    3t2EchwHLMlzfCZbA>
X-ME-Received: <xmr:8wpuaKlOiDvkR40XfnVHXk48pHhQzW1rdfkGTABeeQslg8EqKEb1NJYVau1nj3bCObsCLU04w5jvpqu0PzeTbJgTatTiSlNsjFC7g-SB9vWnQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehirhgvtggtrg
    drkhhunhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgr
    mhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8wpuaJevW1UVjDqY_IujGPp7hpY61Zg2BkR9DWz7831F3hqqcrkfOQ>
    <xmx:8wpuaGRoaBcetE8RGduh1u3dqwmG3qUoBDFyaB1jrRXMGnWjrISo8w>
    <xmx:8wpuaIsI-0z2QMinL3DefNuQWoPZksouHrErG991Z9pHckRk2IFY3g>
    <xmx:8wpuaPeinC_1q994XUNeUZkdwgQaOLnOZx0CMa9Eiutk8iiE8TD9jQ>
    <xmx:9ApuaI1gIzTmCTTGUaPZRP5xcL_AFcXCX8g3OIYMY8uWQSoGijGP53BP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:23:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bdf0fbc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:23:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:36 +0200
Subject: [PATCH v3 2/8] meson: stop printing 'https' option twice in our
 summaries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-2-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The value for the 'https' backend option is printed twice: once via the
summary of auto-detected features and once via our summary of backends.
Drop it from the former summary.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4ee1a55b0bb..0ed00254ef3 100644
--- a/meson.build
+++ b/meson.build
@@ -2200,7 +2200,6 @@ summary({
   'expat': expat.found(),
   'gettext': intl.found(),
   'gitweb': gitweb_option.allowed(),
-  'https': https_backend,
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
   'perl': perl_features_enabled,

-- 
2.50.1.327.g047016eb4a.dirty

