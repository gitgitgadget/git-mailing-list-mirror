Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47D2F6921
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371154; cv=none; b=IFXy700MYWOc4Jhauq2+P7VjpQyyETC7VI1SaA+hpsDo3lyIyksRD6sZ7fKcHOv1CgpQqKw2tWXHiifILVKd0rB3xPEzzbx2ep0hOBZ053Kj19p6PkaR3LUArojW2milBDgyL166y6JShBTHrWbgZC96WLeq2EdcxVT43DQs1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371154; c=relaxed/simple;
	bh=oFW5igjwJ4lNambaRHbFkb9DfuoR5UC18mzZNi0iJ6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fntt5XAT0Fgm23aRtJCDiZ5JSThTUImogq5/dc1hJM9xegFpAQMCnKEbO94NJqTZnsaXu/Ij64F3GsTfZ3rVF+iQPI8n20Wo2XS7q0+k23bsIJNHnt5EvO61SVHPkFm/v2eVMLwUrDds+4X7FMRUQUjjUVU3rCjFvPM7ygc+jLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S9cdVlDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpBXArxn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S9cdVlDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpBXArxn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A631140003B;
	Wed, 10 Dec 2025 07:52:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 10 Dec 2025 07:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765371151;
	 x=1765457551; bh=J4K5CSGdSUVH/rRzmhGDYT6A4rQ7X97gbghw29XK2D0=; b=
	S9cdVlDTOuxvYGdRQhzI94PiOf8/StL9qbg0m3p/dwPYKC0DlJTTBwFkH4UGUtVA
	N9Zjzs9xYCadE4BX7T2IGwS9SgjUinZuGHwYxhX/Kddw4JrpghbqZSy1ox9plcys
	eDMxm48DRGIk2osIEomEEgK0EWcC5C8ipkCZYm9VrsVAmWFYhHOot6a5VJAK0v72
	D7Q9xJpidLcEZ6yvoNJmiAsmNFcftO6RdtapP3u3hBrOcMQ9TmYWuk3bSJDuWXh2
	baOHm4Oj9cCxStwvv65vUaiJBwqQTg4imcmOQP6lafPuJ602Yq92Rmsbvvvv6blR
	pNVrRYNQsPp+I9Y2ekth6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765371151; x=
	1765457551; bh=J4K5CSGdSUVH/rRzmhGDYT6A4rQ7X97gbghw29XK2D0=; b=j
	pBXArxnFYHNGbWJp/mJgcHYDGNk2TTCSSEeY50oAaZK4N2E0XK+4dasuKYIdU/XH
	xc2YAsTardBn4h7Px4q2A6AHOK/57XSsmCMgeKfmjh1zVKfzqygwJtaswKkCgnIy
	jK8+XQrVbkcQ86A0bWxCKJiB+l3/fh/qVmyukMN39pmHpsjnx2k8qjW96mWrYuWx
	QzMtc0xaAtsB5HUkpcIzDhf2FKvh+AOTIvH62V8Yus93w+iEXp94jZPMAVUJYXmn
	A051q8LcisH8F0HVs6bkfOcdAZQ5PBYw4jc4f0Pm56MUhulUNmVwRDbPKCYkhfkN
	TMmsxCJHgxx7t8LffHlRg==
X-ME-Sender: <xms:D205aX3n1RMRMAm5-_iWUTotqTjamZPUGl5BjFl1TonsGH2T4ZDoVA>
    <xme:D205adjVGx8Cmk7s1eqFzJyj3JXmJ58_Fl1joMq5d2_Ujkl6_1Rwe1FFkMhDEO2LJ
    HgD400Ft5aSckVmyOYEkCpNaAYSc2SrAZM9EWStyK59LnJz1nnSEA>
X-ME-Received: <xmr:D205aVQlmOhv1lwCrlu1NLNsfi-pEVARWT8CqgQu2HI2INZ-9NmbmgwTiOs9jbn_ygytzPKbJomTIbjsRj0XgpU3VoL6wq1f7RkT7TMSKdl->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:D205aWjgi-S_X8Ai3k5hdTDsmYWRXMJz4diV-n2vbE50UO5Y12GFPg>
    <xmx:D205ad53bXVFSwYmuQiFi5dRcqZz8-PhoWa6IdoG3MKgSYq2CeUFlg>
    <xmx:D205abD-hmjq8Dx0AepRbrsCHBXtjWGHH71W0N7A4WDVjeag71cUyA>
    <xmx:D205acaaX6LYBTf2uvJUsGIQwW7zAKSM_v9rTzM7ThkwfNjVWq0rKA>
    <xmx:D205aZ9LK6QSc7_WXjsnZMHTG1ipx8hizuttCSeOLb37jrC7eRiPVvNb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 07:52:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa47ebb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 12:52:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 13:52:19 +0100
Subject: [PATCH v2 2/3] midx-write: extract function to test whether MIDX
 needs updating
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-pks-skip-noop-rewrite-v2-2-f813a9e44f28@pks.im>
References: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
In-Reply-To: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

In `write_midx_internal()` we know to skip writing the new multi-pack
index in case it would be the same as the existing one. This logic does
not handle the `--stdin-packs` option yet though, so we end up always
rewriting the MIDX if that option is passed to us.

Extract the logic to decide whether or not to rewrite the MIDX into a
separate function. This will allow us to extend that feature in the next
commit to address the above issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx-write.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index e3e9be6d03..78bc8a65b8 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1014,6 +1014,41 @@ static void clear_midx_files(struct odb_source *source,
 	strbuf_release(&buf);
 }
 
+static bool midx_needs_update(struct write_midx_context *ctx)
+{
+	struct multi_pack_index *midx = ctx->m;
+	bool needed = true;
+
+	/*
+	 * Ignore incremental updates for now. The assumption is that any
+	 * incremental update would be either empty (in which case we will bail
+	 * out later) or it would actually cover at least one new pack.
+	 */
+	if (ctx->incremental)
+		goto out;
+
+	/*
+	 * If there is no MIDX then either it doesn't exist, or we're doing a
+	 * geometric repack. We cannot (yet) determine whether we need to
+	 * update the multi-pack index in the second case.
+	 */
+	if (!midx)
+		goto out;
+
+	/*
+	 * Otherwise, we need to verify that the packs covered by the existing
+	 * MIDX match the packs that we already have. This test is somewhat
+	 * lenient and will be fixed.
+	 */
+	if (ctx->nr != midx->num_packs + midx->num_packs_in_base)
+		goto out;
+
+	needed = false;
+
+out:
+	return needed;
+}
+
 static int write_midx_internal(struct odb_source *source,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
@@ -1111,9 +1146,7 @@ static int write_midx_internal(struct odb_source *source,
 	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
-	    !ctx.incremental &&
-	    !(packs_to_include || packs_to_drop)) {
+	if (!packs_to_include && !packs_to_drop && !midx_needs_update(&ctx)) {
 		struct bitmap_index *bitmap_git;
 		int bitmap_exists;
 		int want_bitmap = flags & MIDX_WRITE_BITMAP;

-- 
2.52.0.270.g3f4935d65f.dirty

