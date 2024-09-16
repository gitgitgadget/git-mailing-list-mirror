Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80109158D7B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489746; cv=none; b=oux65eu3sSYtpovSh/pBub7OKMqmSXNqlCCCQnUTUJtBvOJnCq8eby2F5smtlTjG0vDlNdDdYa5Ftn6RIw7hx2/OYxmg7gh8wBefvszd8wSVOyJGd/ZF51mpbP++UvzIDkbzR/hzyAW6PjAuVME2TKAnwBq3exhW/vntObj5t7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489746; c=relaxed/simple;
	bh=DhoJMzi10nhAZaXFLS8OwfFMIHzhYQwakQ6CNr9U7oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WycKnDR7/jEDAAh4RiMBidHMubW+4/lfTT5snEe2VTriyDKVZ8CZL1YTAJZ+uoqEok9PtsD2jQb6bSp7x4Vu9ScpaYQkx/5TF9qRCP6k+sFtuQpdlxhLk5qAOllz95be5jLlgvh9ex28XxElUaeyNbn/hJr3OYR3N3WEYy8YfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sweB0Nhm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRcqsCrT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sweB0Nhm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRcqsCrT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDC19114025C;
	Mon, 16 Sep 2024 08:29:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 08:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489744; x=1726576144; bh=LoRvuZzUtv
	JANRdWTc9l817etVbX1asmB4XoIqFgeb0=; b=sweB0NhmB9pWhpTXe+3I1+sf3l
	EbNKxpUZW1LeNe9MN7Sovo858XG94oSWl8Wrv2/AA9tv723p286YmJMUbcU1ZQNq
	a+vLKM+T6t1ojosSq+tCL0vSTA/E7pEVKWxF53K9vFa8725zCqh4UNHTVpC/+6Rf
	J+WW3NMyLgk39+ykpqMcV0nCdJ0pu7lkfdijqj8qrML3oPzJj3sokDeZ+UejTl+t
	1gnO+t95ORvWAKGiejWA9Vd78XwCzUFSjdzhNRMLfCJDaJ4EitoaqdV1atwTCkGv
	DWe1ULPxMRlr7DovQzBDvsqFVHHn4oWxBE/Kplq/EaaumccRDMobGmIpMbQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489744; x=1726576144; bh=LoRvuZzUtvJANRdWTc9l817etVbX
	1asmB4XoIqFgeb0=; b=lRcqsCrTLVxu8rB2ETjR3FLnsI9g1J6HaxlmlRvZzN30
	qrAz4Y6K1GyE9OXqTxOhOjeS3EMsoGJRw9dq3p4nc4rJ+E84qauOen0HKmSAvto+
	D0oXU/RIUywXMgFz4EyCj2he5rlsQWMw8k4X1gfyBFl7Bh8ZjhnUdPfrmK+q3Prn
	7sJdZMRU1wepBguPmnkdG0Fycah8NNtS+jv0HvankKJiccXG0S3HHPbbSrumInXu
	eP1vSiXjROjfC6tQgJWgIQxrZJXW1noT2sHw/KYWT9Dyno+jySzwLbhyATLuh1da
	q2m/HyGHZsfY+pZwSAHhMnSfkL9hg65b5tsV4dyvsQ==
X-ME-Sender: <xms:kCToZh5ttM_H3ny1VzC8lNkI5SyS6F-tvtYAE3BjdngsOqCSCLIG2A>
    <xme:kCToZu6FeW3QkSH-pHYn8hbq7Yhv4IsVuLkW7TGVk_uggHQCL1BGalzJZ4HPLTtip
    I7wqT2MxZi1ss2zmQ>
X-ME-Received: <xmr:kCToZocy2p0zEFOL1bOZBoPbfuJyzB-kvqdJ_lFb4SrlysnRnGYSaBnHNLeAlJGTD9XnMeoxwfKgu-LrhGi9xZTjZ67V-i4hjCwd78M56Vd7SjuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:kCToZqI5pCqlN10RHZwP3b5Fvh884EIpWMgPf6OF316jjkiERYa1yg>
    <xmx:kCToZlLaT43ljhNRgkFgOuiLG6LWBbqHB_PeSp2YPH2kcraCV5Fc6g>
    <xmx:kCToZjw9pMl6D00wCenSAR3lp4diD02xJ3DNrwcc6VrtznzJJ5RpHA>
    <xmx:kCToZhKM31dZBDqOtZKimCToQ033lmL6yoOlwd6qzHR1BXfs-pXbkg>
    <xmx:kCToZsUfiQg9mJ_em8aHtZKk74iSM9hNatXmvC1J7ivX_sBDitfHKZWV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f47f5e68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:47 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 16/22] reftable/stack: handle allocation failures in auto
 compaction
Message-ID: <2c19f258fe7ed789f1900ce208cb48c1a3b3b571.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

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

