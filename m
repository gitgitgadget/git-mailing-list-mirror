Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB921A83F3
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568657; cv=none; b=Lo+XWVT2XiHm7mhXXTHZzNLXV0UdE20rc7oGKr5w/VMRMuSEXoW7GMIucHcfDpobESvwd4IViFQ9V9ck8RaBzKs5fLgdGwWWkB1d9JgfC9lycCNpoY8/n2Kf9md9AXax5B4v2emD4ZLtCHsKy9jDLxR6vQGW6WSaVc9m8VwSJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568657; c=relaxed/simple;
	bh=hHs7xNJrbCntwLsN7ypdNjXvodsO8B1AuGi31bzOgpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNwnRt6e6yY6fXbokJAqT51Nu547rC9dIKWKvsMI2H56XBERob64Dp9ekSOXCpEmwNMA/YqWKKUYJX59cmjHSmx7wb56v71QYqe+H7YEPd1RGSr6ICzQicVYx2/mayRGp1+bna8a5gaB4QQu5V9sbR5pYS6jZLk8tLVbU6FJsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XqIh/GDf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p016gYZp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XqIh/GDf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p016gYZp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44F0425401E8;
	Mon, 30 Dec 2024 09:24:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 30 Dec 2024 09:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568654;
	 x=1735655054; bh=jcKBDe4jJr35zAm8Yn2FRBVUrhTOzCwPlNxHKCzB6ds=; b=
	XqIh/GDf1DqimL6fxjw9afK8QpftMBJV7X543ohvdVOVfr4dXVR+SrqELPZwpJ0Q
	gzWGnjhJNolOFRIeHlbI7VbaPf+Y9f4MgZ0Xk52Pnq/kCrX9H8a7kTi1XZMS1QJw
	RRP+54sC4eQprvg1+SsRm2sWmmTqhM1oEkIBc8rTudUjpN3XXeTrwfbjVScPBo9/
	W1dRepZ9jd+Kh026OFoJuDnRMBh/PbQMN/DmbkP98beKBLcKsNIHqr4OU9EKKith
	RE9O3XQbuiyXkgdVIHM8gNMPotspg5vqNyuUwunAS18BXF2hnPszNDWT9LG8T/LP
	/Lvxhz1UcylF4FBzWVteiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568654; x=
	1735655054; bh=jcKBDe4jJr35zAm8Yn2FRBVUrhTOzCwPlNxHKCzB6ds=; b=p
	016gYZpNCXonHBsDqYi9+eHudDT3xjHGE6A1BVVGr5OEGoWR0609etWv2rpa/LDl
	vz+P/8xRt9umj6zCXT5umP84wg5HYQlNLE6yzP+tzNL/wMOnr1LWSw3BD83hMMLD
	niTCvvu5DAV8iQj+hrSh3NOvel8smcU7FtWVeFQy/zj1rhWlhCgtkWWXrT5rN0X5
	vFdbkDXoHoZvzlE96FJ1aLc0KdzPmZxQy4Qhs00T8ikKSXsbEsQBGUD3FaAwRAbI
	HCv5RtqaOIvsdfCWtjcEWiZGOZrNxSz1Zg395ID4687oqRWnvsXU6R8XvXyKnX7l
	aM+YaWmHg46kug5Ix7KUg==
X-ME-Sender: <xms:Da1yZw1KjNM4Ud2j8ROYgFSZsDin8O1pZoAEWegFpPizsy2CEGyYLw>
    <xme:Da1yZ7FRNe9ABkyyrLIXN-zBMeAcqJoynNsHMQ5kmgoaHICTXB2mIi9R70nC1q4sp
    NnEDV4OCPmDBvzQuw>
X-ME-Received: <xmr:Da1yZ44mpYV-iSRCLTYp8M1WPtfFVbOg9lkHraNeHaRdp9e1K0Ue26czOc-kAkzK_5rO0_3vHxVslYAD4y5_vtyv0goPOF1cSx8DyuIJ5JFXBKMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgeegudehhf
    ejveeujeeftddtjefhleffhefgfeelgffgfeehudegieffvdffueegnecuffhomhgrihhn
    pehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Da1yZ51qwDvGhLTgQjoxAeKrHFLOy6MDrVBH2KSCIGiODIyD67Oygg>
    <xmx:Da1yZzE3tvupH--DdY1OWdSDvhzBEPPOK_CLhd09zpE-Pld8tzi6qg>
    <xmx:Da1yZy8iPsK-meuZcCA5AmFtWgd5OGyk4o3aCKicBfgd-1zgXXT69A>
    <xmx:Da1yZ4lZHD8iPPDhEiA_Pn8eiN-UU2SKfcnKP29mBDTyIbqElk_M2g>
    <xmx:Dq1yZ7D-sKgr21eTCG98ybBcJnZK6VKmRMXiIWab_cxaY5XzBg6U_MSK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b52d94e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:06 +0100
Subject: [PATCH 06/10] meson: require SecurityFramework when it's used as
 SHA1 backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-6-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The Security framework is required when we use CommonCrypto either as
HTTPS or SHA1 backend, but we only require it in case it is set up as
HTTPS backend. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6fa4d900ee02f0b80bc3c36d58a07a118ec3fb20..bc75ad954a4949342125b769d3d8d8362ef4e8a3 100644
--- a/meson.build
+++ b/meson.build
@@ -1329,7 +1329,7 @@ https_backend = get_option('https_backend')
 sha1_backend = get_option('sha1_backend')
 sha256_backend = get_option('sha256_backend')
 
-security_framework = dependency('Security', required: https_backend == 'CommonCrypto')
+security_framework = dependency('Security', required: https_backend == 'CommonCrypto' or sha1_backend == 'CommonCrypto')
 core_foundation_framework = dependency('CoreFoundation', required: security_framework.found())
 if https_backend == 'auto' and security_framework.found()
   https_backend = 'CommonCrypto'

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

