Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE9157466
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489738; cv=none; b=ImFnzSBJPE4bo0IKWvGamrM79eUQt9D1QJumOVPseo05WnczgNYcIlxovQi22XiXePhgwSsTVFhv3WKirVsOMeF3w8rGBdbf2pzy2QEa/svbjsJNo/TwUnNvdPpt34WN+upQDYxIOQ64DYABH+Kj5DEGI1y5hblO6Jft+upS8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489738; c=relaxed/simple;
	bh=OY9C61FkcHlQQXu4trXRzGI+RySs2Y/YDle9yxxW0YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXyB4A7WXI2ouFfOvmSkYsJV5nS4wTOn//widG6fP7YlsVmBuPaXmy9JAD7ACdUzqvSE08zBN8A7XL1s4KUWcEFFBsj3BL3RPnVelFfN+yJ/kA+qofCGASJF6FNLFvo8Q7v8m+uMgKP8jwVZ3WOXffSKxUtkLfz6cSM2uRp8IdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e0nR6dqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ohtFHo9R; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e0nR6dqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ohtFHo9R"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D90A411401A9;
	Mon, 16 Sep 2024 08:28:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 08:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489736; x=1726576136; bh=TesJB1AjF+
	+s+deMbqGkdD1eXm5H0XTm8LbGM/c05+Y=; b=e0nR6dqmRoUapjMHitBG1bRwAf
	rZrFp+7pmE73BqJghWkldxuEHWSAXvSGFpAhD4cTGRh+935Cmar45pQLgWunYulO
	hdaZ8Ao7GhMXSek0n2ey1EWD+quefKnLsrfpqN6sbnr429aqAeIcPswlQuC5LNLB
	a5nKM9W3TMikFkZT9kLL3cZ8aFgvof0yFBMsdmuFUFP4MmyPO1r8fn5ykIL+AMKT
	kF5IWiwCJVM6bhXEOg7CXz2LH0VtOjo+CTAqvYTcGkSOlCg3lVO8VHVyrFNrvSp6
	c/ziW+/mk0u73kmjq0e0Bwbt3vBR/RtDcd4V0gy5dN/4TDTfoVX1HueYIgjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489736; x=1726576136; bh=TesJB1AjF++s+deMbqGkdD1eXm5H
	0XTm8LbGM/c05+Y=; b=ohtFHo9RF88H+bv/atqD3bhFltzMYAdXQj6RQv78pbyB
	5naX2zGAeT54RrO/rNtX9xwQMuiGNjIvPikohtTxa+PV+ppounfuslVvEIRf9YQd
	JXVQQN9G0Xt5nh8pSeGXFS8TMwMTOFIDiETk93aLmC7Qmsp9opKY512GOBosBzCD
	JeuaPtCtZIX91A+vZosPkZO+tCOXfMR6qFyDggj2w9bI4z/tUctC2Y5N0gUnQtbW
	TgK6GlOkliKcFbcB3Sr1T12oRRZvAFmyAC0J9AkHDT9Ws5TrioEIKU6CWDwlmiia
	bliDmM3VZBE1TyuDGuZUf97PeuSPyiMCKwX8+KakKg==
X-ME-Sender: <xms:iCToZmU9XwZdHemQgIOsUTxhz_mD_2xwfrQvHvxcsJOQ50cYi03AlA>
    <xme:iCToZin-x75IWO4AZQ8PMzrXfYntSlE2PYQtM6nyiWr8X39er5sp74QNj3X9S80So
    USm538CzmOLx7KC3w>
X-ME-Received: <xmr:iCToZqZlrLyLTQKueUfuPQrIWGJTiBJp_jjuyn_6hRcDuWx1C4gR6Uge_wS0G2HDLtceVYoymfP6VOOFP2AYOQ4nPtfFeh5HqS0m8iYVwc93iDgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:iCToZtXXpSZ5uiqwG8YvRdM7r27T4ANGp9ZVaT8xIsrXfBEMeFpgyA>
    <xmx:iCToZgkIJl-9P20cwIeagXG2fVA3sNGeltgg_b21sgGs8v-PQiYYQA>
    <xmx:iCToZicenGUdzVfPyLzP485uo5dQo3fOxD__yvO0vAOAuZYEN0F3dw>
    <xmx:iCToZiFyIZcl4rNoRabJP7CY3c4oTCOMZEe5B0B92IYIwiQ_SNiM0w>
    <xmx:iCToZlyt_F_mCZAf8uKWVL-4YEl0gAvrV44Kek36TXef4rGm4MZVjRiH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61d9c817 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:38 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 13/22] reftable/stack: handle allocation failures on reload
Message-ID: <6ef25b6c65513e837f9ef8faf1dfa8f4761ff546.1726489647.git.ps@pks.im>
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

Handle allocation failures in `reftable_stack_reload_once()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index bb4d2309189..060b2c1b90d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -214,13 +214,13 @@ void reftable_stack_destroy(struct reftable_stack *st)
 }
 
 static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
-						   int cur_len)
+						   size_t cur_len)
 {
 	struct reftable_reader **cur = reftable_calloc(cur_len, sizeof(*cur));
-	int i = 0;
-	for (i = 0; i < cur_len; i++) {
+	if (!cur)
+		return NULL;
+	for (size_t i = 0; i < cur_len; i++)
 		cur[i] = st->readers[i];
-	}
 	return cur;
 }
 
@@ -229,18 +229,30 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      int reuse_open)
 {
 	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
-	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
+	struct reftable_reader **cur;
 	struct reftable_reader **reused = NULL;
-	size_t reused_len = 0, reused_alloc = 0;
-	size_t names_len = names_length(names);
-	struct reftable_reader **new_readers =
-		reftable_calloc(names_len, sizeof(*new_readers));
+	struct reftable_reader **new_readers;
+	size_t reused_len = 0, reused_alloc = 0, names_len;
 	size_t new_readers_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
 	struct strbuf table_path = STRBUF_INIT;
 	int err = 0;
 	size_t i;
 
+	cur = stack_copy_readers(st, cur_len);
+	if (!cur) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
+	names_len = names_length(names);
+
+	new_readers = reftable_calloc(names_len, sizeof(*new_readers));
+	if (!new_readers) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	while (*names) {
 		struct reftable_reader *rd = NULL;
 		const char *name = *names++;
@@ -261,6 +273,10 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				 * do by bumping their refcount.
 				 */
 				REFTABLE_ALLOC_GROW(reused, reused_len + 1, reused_alloc);
+				if (!reused) {
+					err = REFTABLE_OUT_OF_MEMORY_ERROR;
+					goto done;
+				}
 				reused[reused_len++] = rd;
 				reftable_reader_incref(rd);
 				break;
-- 
2.46.0.551.gc5ee8f2d1c.dirty

