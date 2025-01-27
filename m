Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23B1FFC5D
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983066; cv=none; b=TREMZ5Z1oQwftRX5YPSm3KH2sd9qbXttGAnJ/xYxJHAczV7taJlOnjB3oqVuoDkzTuyNBi+yrRJI03U9kReFYQ9OOLbuOFlWwh+10c+wIntsUijEJpUCa8ABwNQgWXT02ah5ElJe1VeMYMYa606je5iPJTVy507X0F0/Xp+HTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983066; c=relaxed/simple;
	bh=yNiOIXNMH8qUXRFfatF/Hrv0zHHaZv1NHqVuolomlxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTTW0E7Rmlz5vE1zRxTfnzRsFS/lOQn1QyKa7dBxyG8obO3rPaOwMwKyP2YUFI3bZzrq/yGU52dg1k0n0sxy76H8be4/khZrADKE7inlG3z0eIzyHg8VNa8wS0PvnZvyLu4qKfCF5tVP6wBztPFv+T8GPtIPykffDPrDrc32GcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EiGmj75i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2Yju8A4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EiGmj75i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2Yju8A4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3151913801C4;
	Mon, 27 Jan 2025 08:04:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 08:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983064;
	 x=1738069464; bh=WuG4AcUl6HDdJnnwSbtTHemegXqNW+IiTeBaIn9TSHA=; b=
	EiGmj75izMcTDEyOMVC56kA3conALZujyKHLCdtjyMAafzO/1CV0tRVzQ9nnCWcW
	FvQ6eqPFRNagXQ6KC7H8IiFR2gyZ+7v56xhHzTtC1++rS60xXRzoDTWXDBvr6iEW
	4SEPhAaxspHWlL4fppIEFidoa0/C/pMxdQ6Rp53vwaKmL8rZZWFASANS9cKo49cY
	BLJNdL+xyyLBPMY3a70DwVBktUAm92KOHAPTKhS37Z5WFXvai6ofHBodyfCU04e7
	aSAmT3R2fAB3bMvQN140GHFjFP5Z8KVhPywS2kfg33kog0gf4Hkb3lijX3Z8EXl9
	3Yvd+/59EnMDhW9UYTDfYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983064; x=
	1738069464; bh=WuG4AcUl6HDdJnnwSbtTHemegXqNW+IiTeBaIn9TSHA=; b=P
	2Yju8A4ZOEn2r83zXnvOkRszzRSoqCz/mIj7u8h3/Faq/s6rnPr0rl4Oe7JLRFfh
	aSXzqfc4DDDAa3f0QNuao4gNMeeLxw6/sxKSrFusO+PNSwK293KfqTtc3y7ltDUh
	cVJMqRHPsk4MA7wWp9vZiOosUNVyNTM3VdHXUAu8ZWvxC1LCuWLmXtSzx/akP033
	PWyoNAjBQCbmuIlAxc0UPoEAqwDVASpKsfe6nUxexnCbr3F+0v77iFELm0qfSumP
	FAXFKwbNaFDaGXVLmAcrF/zJ1Jf5RHJkJiEI6I9zQgz5rGEZVE8/LTV3fCtoFmDj
	yQFunjPgsoKSYDC/wzHlw==
X-ME-Sender: <xms:WISXZwNm5G4izKLVldqCgSNpTLXMvnI2zklB-aTSNdSii_8w2o-FyQ>
    <xme:WISXZ289oFdLx6Fa4I-kfBmUJvdibLYzpJ_SGVTV8bPbGg4G8xSxr98kxHHQu4bUQ
    ZlJCPN97IvO_TExwQ>
X-ME-Received: <xmr:WISXZ3Q6ICJD1GBYEkh9ewpbV7fC0EGVGIP3qVj_61MkDKU-3LR-REiD-sezikM4ZhFeQNNnqh42JKRe3m27p9bSBiCnISdO6tNn93D4P82b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WISXZ4uHEDy0JdrSXQ24z4lF7TxoDWms9qtYB15CFzt8V2cqg11f7w>
    <xmx:WISXZ4dcOCc4hNWRZvP2Fw2Fa7layQvyHpX_E_Feyqd0wqHwekNPOQ>
    <xmx:WISXZ81LezUXxOuafSgJowwQqmtJH_mCxfvIJD9DH7TiHwMWV-Zckg>
    <xmx:WISXZ88FM6VjardUkQ8W5Loo7ASV8fTNlL-LYY0md2G4ObZt-8hN4A>
    <xmx:WISXZ5rTCQWUB3t-qwMX3cKei-3t5k3RVWjYu_I-gLwK-ucn2lkNU9lD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3c4598a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:18 +0100
Subject: [PATCH 10/19] reftable/reader: stop using `ARRAY_SIZE()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-10-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

We have a single user of the `ARRAY_SIZE()` macro in the reftable
reader. Drop its use to reduce our dependence on the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index bf07a0a586..c3a3674665 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -849,7 +849,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	printf("header:\n");
 	printf("  block_size: %d\n", r->block_size);
 
-	for (i = 0; i < ARRAY_SIZE(sections); i++) {
+	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
 		err = table_iter_seek_start(&ti, sections[i].type, 0);
 		if (err < 0)
 			goto done;

-- 
2.48.1.362.g079036d154.dirty

