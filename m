Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE0289377
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709909; cv=none; b=baSh5oADX1pjkJk3/FHFMaODNyT2ss+XUEq4L7o767EpvDhvRPabNIkKrsRVj5xODYQK7ZpSjqbA1uYnw02nuN1nzczgstoRhZ7iWAOsshR0H1lfeKeNYjpJHvSiOWEurbh3WpZTKbTMEHnkqnDYdw3J5CeUIh/KrPDikI77Zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709909; c=relaxed/simple;
	bh=KzVE25F9klQPQl3JzrIhEzunbZ7X8hqng+8Gt0BRB2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXk1SUmycoO05gAGiJpgHFU3m95XP9NnLG7Pgcu53tj5j7qwQxc4QCdqlSq0e+ALiqVZAMtpMrDTegJ55kM0X8eoFqRInOX55oZydpua9Tge+hQV+6uMK2Z5CgKXW3UvIeXlxwfCAVeM19PrRr2Eys3nLtH50InHmVrDSE7syzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JMHVSQG/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8uOkcCA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JMHVSQG/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8uOkcCA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 53B3C114031F;
	Tue, 15 Apr 2025 05:38:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 05:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709906;
	 x=1744796306; bh=xh0sKLdowBuU8e1gW7im3Wiu28TT/V+kLv1rAyZYnnY=; b=
	JMHVSQG/mp36xyWt75YDC5eCHoLHLnYeXA4SXP2iKRrjX7hsMBFMtzMp4kiOQZzm
	tUZbHib6m7jFHk7qp42EIVtuXe8ICFoAS818Iy92+cqDm8Kao3skjEwXkPRC5Exj
	/UIHpNW32BgNmX5p+P0z9FWuOvSKmeK7uXqCgs/eIL40IxleMSUeJG4HdMd8Z4SR
	3pKt7ivPKW4RMs9hRxH/LUsj8rw7JDyfTvqoV1IaS00Sm1UDs1B8AtnCW7l27O1A
	tOVF5Q8xUMs0YOHd/2aNBtJF3KKnFcIvG/ncjpLMQ+uIOOA1ujHn3NM3u70srdkJ
	Je6ctmTjOb/8JUBwirukug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709906; x=
	1744796306; bh=xh0sKLdowBuU8e1gW7im3Wiu28TT/V+kLv1rAyZYnnY=; b=Z
	8uOkcCAddYBHTHkce3mr+kgV5McJeh+4iUtwLIV8Xo/ux6o2/fmE1e3b2BHlcdZn
	bhk9qgTPBA/e5mpRRWRDCiUYP0FG3diqppIY2iicK70fDrswFBn6Agho8lhTS4jN
	gzA9mQa5hr/ZjVLFeSlc0CK4W3hs57j+g3ZQHAd0COP4azt04K96XV/Lqe+Uk0uD
	qVTSHBRP6GAGKcx07BvX3Q9PqcoHpKVtDWBKcc2HLywTfcd9M8xQ96SOJke7actB
	J8lTwH2c42KGBkQlqV8k1cjPuMy7ul3R4PZ+rtVLA25+8BtmB8vTEw3e+Bo/3GQp
	y38A4qfBzwNQc7WFww3qw==
X-ME-Sender: <xms:Ein-Z9bR-u63cH2QnnMWEIc0mMSljUKcM6_RU8f5rCVfXBvd9U48Iw>
    <xme:Ein-Z0a4j2b4sxTQl6G7i7sAQV3HN0p-OXJiviLfX_GUgrUh9g13cArmHjB4izK5K
    00xUns1qyRtLLe1Nw>
X-ME-Received: <xmr:Ein-Z_-xqFZPpwqHpqUiEK07NZmTAZuUgtHp7Xun2N_qeUKNJLhBSpuW-sM95T5AlU7bn4WFLwndGBLtGZu1cLCcEgcukR3r_zGi1T0RnBiSMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:Ein-Z7pPtvPBdSitJF0ibXSMnZBrpJE25JqygeqyzoZpVBh3Kw4WOA>
    <xmx:Ein-Z4rS_Jfki371DAUc3K8Iq91fDTrXuWw5DWcn-6kkzg1NqGkgYQ>
    <xmx:Ein-ZxQ97B91H8qpz5C0l_dGfrcj21IydFiteWzTKCvLfq56teHvuw>
    <xmx:Ein-ZwqLg-85kXJK_1ePTV2uz_u1jnebbaqRfqLxfDGruADbxkJzrg>
    <xmx:Ein-Z2C8pJjmuSthIXhpC1hkNv8sVPzCYxUxjuAX-WJgkHr8gd79Vb7I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76179f7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:20 +0200
Subject: [PATCH v3 07/10] object-file: drop `index_blob_stream()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-7-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `index_blob_stream()` function is a mere wrapper around
`index_blob_bulk_checkin()`. This has been the case since 568508e7657
(bulk-checkin: replace fast-import based implementation, 2011-10-28),
which has moved the implementation from `index_blob_stream()` (which was
still called `index_stream()`) into `index_bulk_checkin()` (which has
since been renamed to `index_blob_bulk_checkin()`).

Remove the redirection by dropping the wrapper. Move the comment to
`index_blob_bulk_checkin()` to retain its context.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.h | 15 +++++++++++++++
 object-file.c  | 26 ++------------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/bulk-checkin.h b/bulk-checkin.h
index aa7286a7b3e..7246ea58dcf 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -9,6 +9,21 @@
 void prepare_loose_object_bulk_checkin(void);
 void fsync_loose_object_bulk_checkin(int fd, const char *filename);
 
+/*
+ * This creates one packfile per large blob unless bulk-checkin
+ * machinery is "plugged".
+ *
+ * This also bypasses the usual "convert-to-git" dance, and that is on
+ * purpose. We could write a streaming version of the converting
+ * functions and insert that before feeding the data to fast-import
+ * (or equivalent in-core API described above). However, that is
+ * somewhat complicated, as we do not know the size of the filter
+ * result, which we need to know beforehand when writing a git object.
+ * Since the primary motivation for trying to stream from the working
+ * tree file and to avoid mmaping it in core is to deal with large
+ * binary blobs, they generally do not want to get any conversion, and
+ * callers should avoid this code path when filters are requested.
+ */
 int index_blob_bulk_checkin(struct object_id *oid,
 			    int fd, size_t size,
 			    const char *path, unsigned flags);
diff --git a/object-file.c b/object-file.c
index 2051991f4de..6084d603136 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1356,28 +1356,6 @@ static int index_core(struct index_state *istate,
 	return ret;
 }
 
-/*
- * This creates one packfile per large blob unless bulk-checkin
- * machinery is "plugged".
- *
- * This also bypasses the usual "convert-to-git" dance, and that is on
- * purpose. We could write a streaming version of the converting
- * functions and insert that before feeding the data to fast-import
- * (or equivalent in-core API described above). However, that is
- * somewhat complicated, as we do not know the size of the filter
- * result, which we need to know beforehand when writing a git object.
- * Since the primary motivation for trying to stream from the working
- * tree file and to avoid mmaping it in core is to deal with large
- * binary blobs, they generally do not want to get any conversion, and
- * callers should avoid this code path when filters are requested.
- */
-static int index_blob_stream(struct object_id *oid, int fd, size_t size,
-			     const char *path,
-			     unsigned flags)
-{
-	return index_blob_bulk_checkin(oid, fd, size, path, flags);
-}
-
 int index_fd(struct index_state *istate, struct object_id *oid,
 	     int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
@@ -1398,8 +1376,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	else
-		ret = index_blob_stream(oid, fd, xsize_t(st->st_size), path,
-					flags);
+		ret = index_blob_bulk_checkin(oid, fd, xsize_t(st->st_size), path,
+					     flags);
 	close(fd);
 	return ret;
 }

-- 
2.49.0.805.g082f7c87e0.dirty

