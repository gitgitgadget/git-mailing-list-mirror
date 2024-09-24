Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49013A25B
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159570; cv=none; b=MEK/uOUR/MTYHX1yQJcjwK8/r9BEUV3nyAhH6yERcQ+uFt+DGJyr/g0qSTJl54tLBspTqI4cahAIci6t6hHjdlZK6BmWTFOlOR35mCVK6tiHl+TO39NV+ojYIg6zwwWpP/peIUIicxc4U0tNI+ibGEFyxvanbxo/EEIvtOuRHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159570; c=relaxed/simple;
	bh=DhoJMzi10nhAZaXFLS8OwfFMIHzhYQwakQ6CNr9U7oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOK0giDH7mq7/j5H9nkHP1mqMaOC5xevIM/Zitb//OscpZYwULRVhUY15/ir3ordrvcLNLtvfGmTLg/ORFBFzrRG4xgRNawZoe4BX5vLkV0ICrLIP8NkkiQDzNJ3YeQ3QDn3MjF1m+Asc1gtW+VxXxIjY8wyTo1qPf7ubpPmWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RoKhwMy/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqwdLTy/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RoKhwMy/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqwdLTy/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69B501140262;
	Tue, 24 Sep 2024 02:32:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 24 Sep 2024 02:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159568; x=1727245968; bh=LoRvuZzUtv
	JANRdWTc9l817etVbX1asmB4XoIqFgeb0=; b=RoKhwMy/pVjYINcSw90IDS8EBl
	dYBlmk2Y5JsisEad2aOGdb52KJhxQYDgLGQ0l0L0tBYpB1Nxro7lidVrrfvS9LhJ
	vILoEi4v4dkE5yzFME9kEGbobOFpiB3iku/TI6DXSZactUGu63f8c4vVclmqBLem
	xmh78dASmIgQjMUWxt0BmI01e4X2cVBtkf2H6gCVB2TT+tabTE2jxqKbGBwUnXLx
	188u/V/x8dCiIfzHeXbZZyShM+l4BY8Z8Yy00CoJaQ0ENDDBOGTVPxrw/zKvJtE4
	xDFdazwzBTd9LRetg9y+ei4OVncl2YL2li7dhmEgrJw3ezrolMSMxXeemosg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159568; x=1727245968; bh=LoRvuZzUtvJANRdWTc9l817etVbX
	1asmB4XoIqFgeb0=; b=GqwdLTy/JVK4F7dBulBi01rwfNh64dDDHw9AMh1StiC3
	+6U67mZ9vjBLe+k2Oy4+C7Bsv2pamY76k4fdHOuLZDvcsBntsVGK/4PBi9iT4bA0
	KtdNdplJSnYVPtXzhXFpt0ulmbS4SjrxMXli0QOhbDDumJCWUvCzBvdu9+YlocrG
	CQqd/Xf5+roG/jH8vI+w0SowQOdXwBj1c7U5V6s8Ia9JYIUfARViP73vSEbehF4f
	b/JMhuHfG7ioDOYqTCO1YDOJ5qyxnTv49RDYsWjWfc8/6+jS3jw4aOYbtUCN7TO6
	nqr6otpSPVOdaIF7RPy+M896IV9XVC+CkVc3BHQKGw==
X-ME-Sender: <xms:EF3yZs7IiDFFgc_a4PpCFN1L6YEUyCb6yYKB8suBKzG4vhr956ACGA>
    <xme:EF3yZt6vhAVs3_Orz0bUSeZxQyo8PSDDGbG2c9XrdUMONca7tgloq7R5pbvmLY_It
    VTgl49jMf7WXm0-pA>
X-ME-Received: <xmr:EF3yZretiCsyYuXeDlhtP3VMRAw4CGv2Za82pEJezD3a4TcJNB6KZlNxuUL7IyPvQIwAi7ZwEM20E2OgY2sLH2dZwP4dPSHrutj8cEg1zQvEiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:EF3yZhLN23A_2-ncSOYblSTLX1WjAjBgpu6PqpIW3oPFKjUh3nSKfA>
    <xmx:EF3yZgJBsGxEerTQNr7ZIjW2R740kPFHIK2eHP5tVckl_UA7L4xDkA>
    <xmx:EF3yZiwWMsxMt3anRh7ytglN1w9hlMv9r-sb1gxMvRlfGh7zcWLlEg>
    <xmx:EF3yZkKKbPzzbWb4YbE-7TiGAf7lq-tZ6_uTQaOCBBr-bDbVcHjJSQ>
    <xmx:EF3yZk2VPty6KDEfXWt3pEi1W2826JgULL03Scg-6yqbsrlNoE_OW0BK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9aac0b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:14 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/22] reftable/stack: handle allocation failures in auto
 compaction
Message-ID: <99f4868c38f48ccff91f8a9366dad7444d493786.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures in `reftable_stack_auto_compact()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2e6dd513d72..990784d9d2f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1518,6 +1518,8 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 	uint64_t *sizes;
 
 	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len);
+	if (!sizes)
+		return NULL;
 
 	for (size_t i = 0; i < st->merged->readers_len; i++)
 		sizes[i] = st->readers[i]->size - overhead;
@@ -1527,11 +1529,17 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 
 int reftable_stack_auto_compact(struct reftable_stack *st)
 {
-	uint64_t *sizes = stack_table_sizes_for_compaction(st);
-	struct segment seg =
-		suggest_compaction_segment(sizes, st->merged->readers_len,
-					   st->opts.auto_compaction_factor);
+	struct segment seg;
+	uint64_t *sizes;
+
+	sizes = stack_table_sizes_for_compaction(st);
+	if (!sizes)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+	seg = suggest_compaction_segment(sizes, st->merged->readers_len,
+					 st->opts.auto_compaction_factor);
 	reftable_free(sizes);
+
 	if (segment_size(&seg) > 0)
 		return stack_compact_range(st, seg.start, seg.end - 1,
 					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
-- 
2.46.0.551.gc5ee8f2d1c.dirty

