Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E592980DB
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059860; cv=none; b=nSWYrnMfVeGL8R1hUJS9eLpqO9YojJ2ytj7k7kc7/pFOVIP9k269PPH8viwJVBQePwX4Sk7cByx5fEUz0n79nX8vrol6HmaqJbmE/zpcA9bY6nB1ajrhHP3ALeaQhoP2e36NxjaQ1KCH7+JVvZPPEkNXxBbGbcFHeCIAXB+v0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059860; c=relaxed/simple;
	bh=+AEU/k5y+XHMffmIRzy7dauDuQSdbwIvxBwdG2x9B7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2g5G4gtFDZOA01SBkHMP4eGi3lBipFR+5C3sq8wyWrc5tXW5HsJOauuJFrq4Tud3Eikn9c36uAv5gaoHm4SNouTZ1CtHo0tl/BLSBwy828CA1nICwzx9SWRcb72hFuGqMpEHnKXSZhPr6xxa6RLiusktOg48L6B9SRWjhUCY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PKbrQkoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CrtIvILU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PKbrQkoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CrtIvILU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E8C4EC04D3
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 09 Jul 2025 07:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059858;
	 x=1752146258; bh=wrIHUtqzJyP6hjLSgKe7y6/KuoJGyvy7YRxq1g0xFso=; b=
	PKbrQkoyR/mxRJg5K/4eQ4FBu7i1NH1Ck7eE4djNIGtL0/M1S3xLYxUiKGoJVkkn
	iHKPKR/nX3jcSjQhcADEgxsca3sGWI4xKpNfd4kzuhC9z9c1SXD8nnQfQOOpz8kO
	zaaJEjSglU8HIrzxM4FQWA8EgibWnd/PdF5u9GQu71Eov3DhtciuFdYfJt5DGbG+
	mLpDxej7lZWJPcS/NXR/jH7UbCs/E/jj/PIA5LnHar6c3Xo++MIbz1wG0ItPleSr
	V3WTb9Wt8kTpLWSvbOMav1hBUlcPlVtjCRckLVYvaP25RAVA0Y9y8P0rEAhvGV/w
	eESIthFcmx3pfg3TtLiNAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059858; x=
	1752146258; bh=wrIHUtqzJyP6hjLSgKe7y6/KuoJGyvy7YRxq1g0xFso=; b=C
	rtIvILU0HZEhutmROXu8VUOSkYHPBxDTGgrcA5aYEvFD8CVVDnQjzideu30lXRY/
	8nSxREsFOWFIjoir09cmIuCvEX6ZD8kS/gzOrzPzlYYdFc6PaHQO7xLd3rYzobNA
	CNFVCLMi6B4eEgsa16/n5bVrnd8ORwC3DxM2PAkJctWIwqYrFObfZQKrYQjZRbme
	rS0dvwD8ScvRJC16JxAAgddRL19L9unXayRbDOEAnFpHLrQPm0evXjoultjED6EZ
	0radh93dCS1cL7ojEh12fCOq8G+AHoH39n8IVnar8JPQj3UBhEGj2P7n8Yd/UUcz
	1k8ODorJREs+aJIny0QLQ==
X-ME-Sender: <xms:0k9uaKc1dBZDt32jGx2PnwNyLd8PFsic-Qj7g2m5jCzcRFuB_ZBcsQ>
    <xme:0k9uaGNNxbtD98EzP976aTrHgSITXZqsAcI4RpN_L2mGZgQA5t4Ii__kICaeTam_e
    _0x_spWqaiENBe-EA>
X-ME-Received: <xmr:0k9uaE5mQtD5NPn6aC4Qp4E0TijVJcASxWLKEtnj1B0CtOniqJFv1BjhSk5bY64zTQC0Te9-A1CFLdpvCJe9j0zwDzD1Uihqkbp53q4osI9Hjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:0k9uaKKYPOnUoBd4wpWWmopgbefus2l0C6sNQDXkRJCJozY7qCKQkg>
    <xmx:0k9uaOd18bKjWY8KGgUmERv2P_tUHHdbEmDjj6wt9w65wAVyQd80Rw>
    <xmx:0k9uaNfGrzJrxpuhlQLMTpXefWb5zmsGwt6t7B7fPaOVLNqNbCl33A>
    <xmx:0k9uaBNzRBpoBxiAAA6hGON7to2Dt0yo7nlX2bykBZQaAv8RWFESAg>
    <xmx:0k9uaBEqJ235vwsqjEIJINze9GNdrOSyg4RW1JasIfpfUBu1KnPj0_Yf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a95e7ea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:16 +0200
Subject: [PATCH 06/19] object-file: get rid of `the_repository` in
 `loose_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-6-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While `loose_object_info()` already accepts a repository as parameter we
still have one callsite in there where we use `the_repository` to figure
out the hash algorithm. Use the passed-in repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 3453989b7e3..800eeae85af 100644
--- a/object-file.c
+++ b/object-file.c
@@ -421,7 +421,7 @@ int loose_object_info(struct repository *r,
 	enum object_type type_scratch;
 
 	if (oi->delta_base_oid)
-		oidclr(oi->delta_base_oid, the_repository->hash_algo);
+		oidclr(oi->delta_base_oid, r->hash_algo);
 
 	/*
 	 * If we don't care about type or size, then we don't

-- 
2.50.1.327.g047016eb4a.dirty

