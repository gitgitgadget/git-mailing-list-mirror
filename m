Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BB1A7AE3
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371151; cv=none; b=KEVoo+S7G/gjVPOSLiyq/brrQWjFcJvtjnNaNXBNKGZ0yKw93SLT5xxcCtYBy2FByqjUB43CcFLZ0r6yUmALUehMSLGYHlpYD1Y+kL+fIiBx83GoCEBfCnQsOzEdmeba3IU5CjmJ2v3rURgi5wKWM5xRGn2eeiLi+VgDh51oAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371151; c=relaxed/simple;
	bh=AiwkMrmVseWUjO32FmM0KW/JUEgxksFjRcthDvpdNL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UL7zTk+adEMsWWaz7P1RCHSIYQULBs2QDGatmnPx0A0BhaeT8IIzwfsQnll5eOpOZu7cF7bjyduFiQu9LOLJhvra4m/16dUwUdZ9tNLZUlhm8KBTOBTy7IRv5QbdI+5UjcMg0cjDRPKIODMEuIUUI1yi1CzakM6n10zUe7RyVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c2uAVuXA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OjeOLOyj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c2uAVuXA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjeOLOyj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2823214000B6;
	Wed, 10 Dec 2025 07:52:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Dec 2025 07:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765371148;
	 x=1765457548; bh=K7YLzIjlo4c7b3vhUwHNliMqXSewWmvDjRydxgUxF08=; b=
	c2uAVuXAMgHwc6lc2v1nGvF1m09qHKxf4B9IH5t99A4sbzHqrcR8Oz3J4+HszC5K
	+tGpMhXuGCVRCRVKsWDrX8rlMEkM13dgQuze8xrV0t0hDi30/8Yk/eBkcqi88AeX
	gsQa1G3n0Ia1V9FySycCz3HZ1HW1liQPqcDJK8D4x+PKpRsU+0sfqSR5V+pMwtTq
	q1PH74q9ZkwLudzhpP/Uus/JBjBCP9di6Mdp7ds7VqE+Muc478HLFQ2SgZCsuffP
	B/Lx/m173E5PRn1Dl5wXy2S5hJYPa+Sqb5iKkrslHm9PWwfHO6haXG4iEiSDewnT
	rUbQkKf0bDxdo1TEyUp5OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765371148; x=
	1765457548; bh=K7YLzIjlo4c7b3vhUwHNliMqXSewWmvDjRydxgUxF08=; b=O
	jeOLOyjXpe0+2Owjp4qYirVeLKz/6GT78LdrJcMr3+47FFns+VAmAdaH0b+xq8RC
	SVCL28uNBubSv+qeQd1x0XESb1t2w7H0Uu5V+cV2h16Spxa44tDpCKtqU0xhWq6h
	dbLczmT725IUZIK+T6iGsO0ifSL4DHMtvvvZklyv/+tkT6wHpVBHhiWYfQeGFNwH
	tJElYkt5jR++gosN9kkFB/dTZliqeTP49nI4PsQBL7D8XsulqsoOTKJGKPpdIafm
	FIoZMR12eR+RkO/wInA7ZG5z0abKLVBiBLnejwsPOxteWTd+xaLu6wAirKFY1mBE
	0ZNcSD3rRAhIzcLWaQM+g==
X-ME-Sender: <xms:DG05aaRpW2_Z-A9qJa18MaZC8Rx4fQW-IbiBnHqKcnG_1X7u9DeAeA>
    <xme:DG05aXNK19fOPfoBIB42r1MZ1deFhxihHf-hfdMnDBLcEvNMZO9WXPmqBwS4Zozck
    3sWV3otESeYxD9SDF_oD0sbcG1sqqDKSglACMqEVXPIjfG9C8PZZQ>
X-ME-Received: <xmr:DG05aVMNEOTrMR4q67bweCyJ38xrWu7rNRzyQo0fadLeKxgn7TAHfUveLG8BcWY7iZ5ABaTv7nqcj1tZMVyt7mMOl5_B6IULc2Ywrc2mGLBu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:DG05afvBHLIiz9z3OB-AVu_3XGbA8Je7UjssfUPQ9zTNRFRgyFyNSA>
    <xmx:DG05aXWVS5QlSQp6DRnW5zaCj547VhGgcSuWCp0Lnlegn3SZOSrwVw>
    <xmx:DG05aftB41QIIdPGht8jV31XyLu4E-bAMENp1OJKPx9hCJvkoud8ag>
    <xmx:DG05abWjQT2wudBezOR2Rg7LaayQI1bh0OGPihZ6yxeVXxzfO6P-EQ>
    <xmx:DG05aepRC4vsUXWd4hzPY9V3Sr4nv0kmApm2U3S01u2iOy-NYz-MK_it>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 07:52:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80aa2f38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 12:52:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 13:52:18 +0100
Subject: [PATCH v2 1/3] midx: fix `BUG()` when getting preferred pack
 without a reverse index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-pks-skip-noop-rewrite-v2-1-f813a9e44f28@pks.im>
References: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
In-Reply-To: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The function `midx_preferred_pack()` returns the preferred pack for a
given multi-pack index. To compute the preferred pack we:

  1. Take the first position indexed by the MIDX in pseudo-pack order.

  2. Convert this pseudo-pack position into the MIDX position.

  3. We then look up the pack that corresponds to this MIDX position.

This reliably returns the preferred pack given that all of its contained
objects will be up front in pseudo-pack order.

The second step that turns the pseudo-pack order into MIDX order
requires the reverse index though, which may not exist for example when
the MIDX does not have a bitmap. And in that case one may easily hit a
bug:

    BUG: ../pack-revindex.c:491: pack_pos_to_midx: reverse index not yet loaded

In theory, `midx_preferred_pack()` already knows to handle the case
where no reverse index exists, as it calls `load_midx_revindex()` before
calling into `midx_preferred_pack()`. But we only check for negative
return values there, even though the function returns a positive error
code in case the reverse index does not exist.

Fix the issue by testing for a non-zero return value instead, same as
all the other callers of this function already do. While at it, document
the return value of `load_midx_revindex()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c                      |  2 +-
 pack-revindex.h             |  3 ++-
 t/t5319-multi-pack-index.sh | 13 +++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 24e1e72175..b681b18fc1 100644
--- a/midx.c
+++ b/midx.c
@@ -686,7 +686,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
 		uint32_t midx_pos;
-		if (load_midx_revindex(m) < 0) {
+		if (load_midx_revindex(m)) {
 			m->preferred_pack_idx = -2;
 			return -1;
 		}
diff --git a/pack-revindex.h b/pack-revindex.h
index 422c2487ae..0042892091 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -72,7 +72,8 @@ int verify_pack_revindex(struct packed_git *p);
  * multi-pack index by mmap-ing it and assigning pointers in the
  * multi_pack_index to point at it.
  *
- * A negative number is returned on error.
+ * A negative number is returned on error. A positive number is returned in
+ * case the multi-pack-index does not have a reverse index.
  */
 int load_midx_revindex(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 93f319a4b2..9492a9737b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -350,7 +350,20 @@ test_expect_success 'preferred pack from existing MIDX without bitmaps' '
 		# the new MIDX
 		git multi-pack-index write --preferred-pack=pack-$pack.pack
 	)
+'
 
+test_expect_success 'preferred pack cannot be determined without bitmap' '
+	test_when_finished "rm -fr preferred-can-be-queried" &&
+	git init preferred-can-be-queried &&
+	(
+		cd preferred-can-be-queried &&
+		test_commit initial &&
+		git repack -Adl --write-midx --no-write-bitmap-index &&
+		test_must_fail test-tool read-midx --preferred-pack .git/objects 2>err &&
+		test_grep "could not determine MIDX preferred pack" err &&
+		git repack -Adl --write-midx --write-bitmap-index &&
+		test-tool read-midx --preferred-pack .git/objects
+	)
 '
 
 test_expect_success 'verify multi-pack-index success' '

-- 
2.52.0.270.g3f4935d65f.dirty

