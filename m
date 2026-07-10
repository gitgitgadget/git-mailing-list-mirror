Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F83B19A6
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673360; cv=none; b=QQeXcjcnE/vtf09e597qqpkMA4W+2brC16NMrluXPN9v0UlceGA+4+QuH4MLWt10XLdKnVYqyTxaosBCGZqY9YOpaAf4R5nu3ypMO8jowge6BZtXWqFRQ7HRIw3qwjxw459xfe6PesyIpiN35ToMWUyxm2EZv+m+e1WaBJi7MoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673360; c=relaxed/simple;
	bh=utV59+RC5NPt3c8xWyzwuZQymBRZIXAt8Wt3IpPZnpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhdDYGE1x9VDdrkIjzbHMBiLmg9AHZlKTYggbhUtBxc3If1VcpTL0xqFsIjAwDyBvHnGkWzbv4qDQR1JyXlO5XqSvKNSUfmwoIpY38Bjw98RZ40QDO9y6j7Y98tTPwDM4gNIM9TazGmnvf5gAsj4UyIisFltQsHBEG9z4Qo19AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jsXFrYPv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipAdDJ0F; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jsXFrYPv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipAdDJ0F"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C2F31400096;
	Fri, 10 Jul 2026 04:49:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 04:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673358;
	 x=1783759758; bh=tjofXOTiaJuTRexRl3o18oqXjmsGhHmcPUji2+MfeXA=; b=
	jsXFrYPvRyjwj8IARrxju0Eg6FtsJQhfjvChCIHq9TIJ754ZiA2903EDEdRodgnk
	7Y/FnptoKf4OYlDyC1PktSMUbPPzaQL3UeC/0pBVgZLqz+SlJQ2SzIzUGr3UcT4h
	KjF9TIUtB4tmVzEo9HrMwHJU8+Rri80o3p525HB4eYsHLwWQHyq3CH0ck1s58DxN
	sui2Y5+18ltW89hFIcC4rq99X6vHYNSYkQyy8PzGEooPCoplQCEC9uPOlRh5OSW/
	FjPXK6jZC0sS+NrvWe2N4+7OyOoyuVs8NluY3RWVXawcSI47A7TAWecBrbDLfx3g
	m2R2KQjFi68DCLDkIFatYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673358; x=
	1783759758; bh=tjofXOTiaJuTRexRl3o18oqXjmsGhHmcPUji2+MfeXA=; b=i
	pAdDJ0F54VhfEMql5DqIEb7EolSgjtbSPlMfFOTsuRMkirGaA02W4zi22vH5CfD2
	1pMPJMiueJpbAsgwZWNfghW10i7tbhGRXlEM7MBVhbf+ZdLls02x/qqemG8hiEkj
	ASAT1sYbbtQTJ0FFG4pMei8NUTQB5jewti6+MnTu8G2aAyet1hBhuYGDSfW2xn4w
	c37PJggZtICri6fff/vXjPHv/msLH2vu5IJcfE1W5RbzUT+EWTB7tPnYpSFVJ7ng
	9N61IxGpBWdHyzmoSV2m7twgAh4QGI3JzfuubghKRvWf/GfkpE49QmhCmi2WyQtI
	JAvjmOXCxwRRlu2Yn6YoQ==
X-ME-Sender: <xms:DrJQar7xpJLOg2qGxmEON9AS9Bc3sR0nrWZjFOHQJ4Bz6Q0Bys_Vcw>
    <xme:DrJQaoWZZfIz_q6oa7njbaACnySzztTPDOOR9mzIGChP6T6k-SDt1dH2KS4Cbmjas
    VQWoSi2J_-eWIF5v4ik8VwI-wHSjor35FxkYuo0bBUONfu9CTE>
X-ME-Received: <xmr:DrJQav3jSY7VtcGTUc1amSQ-AjpJd20M03pTQoOLK0nSPk6mRBRjFaF7nPpSwGC3h7I_kSJDZlfhcE7c6_T91FZI4B7xpVTXYPEVZVCQxPWyqw>
X-ME-Proxy-Cause: dmFkZTGb4Vrx08qDmYPi9ab4YASd2IUWYaD5+JRoIRe7FbbJyO9XbgM1xNd/z3RU6mbk7z
    bE6U1CXfMdE7NeJMbBrOnmMVpvtGzdwJ5CdtO+lPSd1b46MXWof+UdyM9zCCDZpnlioVM2
    Z/+w/D7Q9O4UU/SAMZMQRfWxZ47QG39Tr8smjIKlVUgCJ20PuyOyeM8bz0cPdbGr4Ds/ON
    OhjY6GxRHw3bcJCmKq4D0ET4QUuwm3TWJicoFxOilXA7z/UHvjTPswYOOjc4s7CXbNT5hF
    sKsHPEhbnvPoa7IhgtQcgjSjkXRlr5isIrsN7kZXGgnAReTx0k7p6dtBK04pDoLPbvO2cC
    M+LWW6Nj6baYNfsGI86BGixsyCcGd4eRxMYcJFkWtG1ZiK1c6gJviT88m8vrdoJMI/CuNn
    rtuhkGns7aHpoAGz0GoXT3BuZsDNmfg+JIhH546MZB/gI/hzI7FyaG+6H4zw6Mz6VorfJk
    348WN0rOqNMD1n8wEcLy80wjH8QrfQiPBxQKHhoqo7CvT8Fr0pPRVynvPSzcDMWhyNbYj+
    ePdRBEpkJrmU/7OfVmv9L5iKkxhS+GXkCroQwCOmpBcz4kz5binFXgC2ywv7IOPcvnNeq1
    BsYPh2E8C/KtBMT94+xarWUoixA/WITG3DwhUaHPdMRjAxOVJMzmTdfiHZ5g
X-ME-Proxy: <xmx:DrJQal3kUXRJBbk7WdBGSVrP91yDfLYRfcg0qjuwJR55JesMOM_y8w>
    <xmx:DrJQai9FJ7DHBfJAr9QLgJlqatjir_AWa-F8JtTlqWSdNuUPiJoapA>
    <xmx:DrJQai0wxtwdCB-RAB5KpHZAabZxS5dkq9QDsxCcWotlczllBIJJKA>
    <xmx:DrJQav_6-ez7HYUhH_Ckb14DO69RbX_iUzV7jniACahhEKwNFpH5iA>
    <xmx:DrJQagV8Wys9gkGqykCjPNAHGwLzqs4scuFdUhaeXHsnrKom6RQYKQd8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 068fa19a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:48:57 +0200
Subject: [PATCH v2 5/8] pack-bitmap: drop `_1` suffix from functions that
 open bitmaps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-5-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In the preceding commit we've refactored how we open bitmaps. As part of
the refactoring we have consolidated `open_pack_bitmap()` as well as
`open_midx_bitmap()` into `open_bitmap_for_source()`. Consequently, we
only have their `open_pack_bitmap_1()` and `open_midx_bitmap_1()`
variants left over, where the `_1` suffix doesn't really make much sense
anymore.

Drop the suffix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e32795a595..72c8ae3228 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -460,8 +460,8 @@ char *pack_bitmap_filename(struct packed_git *p)
 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
-static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
-			      struct multi_pack_index *midx)
+static int open_midx_bitmap(struct bitmap_index *bitmap_git,
+			    struct multi_pack_index *midx)
 {
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
@@ -539,7 +539,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
+static int open_pack_bitmap(struct bitmap_index *bitmap_git, struct packed_git *packfile)
 {
 	int fd;
 	struct stat st;
@@ -603,7 +603,7 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 
 		/*
 		 * The multi-pack-index's .rev file is already loaded via
-		 * open_pack_bitmap_1().
+		 * open_pack_bitmap().
 		 *
 		 * But we still need to open the individual pack .rev files,
 		 * since we will need to make use of them in pack-objects.
@@ -687,7 +687,7 @@ static int open_bitmap_for_source(struct odb_source_packed *source,
 	struct packfile_list_entry *e;
 	bool found = false;
 
-	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
+	if (midx && !open_midx_bitmap(bitmap_git, midx))
 		found = true;
 
 	for (e = packfile_store_get_packs(source); e; e = e->next) {
@@ -698,7 +698,7 @@ static int open_bitmap_for_source(struct odb_source_packed *source,
 		if (found && !trace2_is_enabled())
 			break;
 
-		if (!open_pack_bitmap_1(bitmap_git, e->pack))
+		if (!open_pack_bitmap(bitmap_git, e->pack))
 			found = true;
 	}
 
@@ -746,7 +746,7 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx))
+	if (!open_midx_bitmap(bitmap_git, midx))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);

-- 
2.55.0.229.g6434b31f56.dirty

