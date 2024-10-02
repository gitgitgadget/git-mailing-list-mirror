Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FE201257
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866577; cv=none; b=eoH+19Wb5GJbklAHNAmNuXHsO8ZYHBDSOZTJ8j0COpR2TgwNLS0HgIP1Qj/i1hmUvvr3LGBDgatpceCwoLw1eJdphOzZKgG1fq5iJ+Avjv/GapjSum3ZYxKDdSSm29qZchw6NnDiEeraq+CXntxZMAl3QXY1vzqKKy41O+Oeep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866577; c=relaxed/simple;
	bh=w+2eowW1AanmbkxWiJ4TTQpslKYmKUD6TDLC/4OpVVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCsIKzAa1JsYf0CVU1DSIRdXFsFiIWdxYjWAcRAraBHfnoaECeXxd9hMj34ZZObuy+R4iA1qIdc4YURitPgDAmaP/GdypaxjcP/ndgj8BrK5H9HT1Vn+wx+0LD+yI4bGz2kGO/mPjxfs2BrLZTtIT/Gyu107VDx+3oW2g5CKswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ac58g5z2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4tVBZgu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ac58g5z2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4tVBZgu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CF441380241;
	Wed,  2 Oct 2024 06:56:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 06:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866575; x=1727952975; bh=ctMvMp+aBj
	0Gl7Q5KgdMIXoAv9A2WUMeXeT3hFDa88s=; b=ac58g5z2ye2vuyWG4QbxXgu9/D
	QntEHvmatw/AQfF2Hfcoz++dmu5TZkz5sQ8wBv9nMt40PLVOpX+yzQ7dZ1grS92p
	vSYlFmSLu/rPcoJiOMQx+x1du+3qVI/mcROIzyurFlt1PjgD3wS9IrGedah2D9TQ
	TCcD2/V8sljT6enpGpp1iD25T/3sPfORSAdvO2zBbRSIMuDMyx+dFBgCWOQ1/scX
	gl5l1xf6qTadZ31+jdFc5OTYhAES6CV7GWlsIdeG/TLW9QfXGHtedyFyrrSo04e1
	Sxs30qTjqtjM/s38Rrxgw56v3cmyiLiot8BICBrN0B4SJCg2v81CdI2xbQ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866575; x=1727952975; bh=ctMvMp+aBj0Gl7Q5KgdMIXoAv9A2
	WUMeXeT3hFDa88s=; b=K4tVBZguy0Q2ttwGkP91l6tWutS6ExYDHykzn7HJx5ly
	LbkFgMOzqIHcFxCo5OQIMAmjZXvlAViNEl8heTbjh5JwOsQo48whscsPC/CqBjyH
	wivrQD7Au5c4oxSjV7isu7nJuZMcHlxzixYHrdQhKRFgSHekeQicUSdCzsiuhaSH
	xZL0mNkvGjRYevEy0zduckSeqfCM5NtkX0GkfgGVDal8Fkk0fYSrSX/Ri3JxjJud
	d/gFD8fjaYowgZIhIiTM18dQBIxQhsqq8X7KdpI5AWrR5U4amw3OjxkQgk7jc4uW
	rf3JMyZk9B6VVkDlWY4rW7yS5aDJr9InsXXeM0+CJQ==
X-ME-Sender: <xms:zyb9ZvbnewnhPvwTIgoPk2Ql4VbEu-s8V_ktYtN9vWYn1hA0AwxaBw>
    <xme:zyb9Zubj5s5ZrzPTUYXjL87oG6Qi1kGEkxaaqS-a8_4msdI3aEoE-OUaFloNay1sn
    Wvo5y2x8FGia-PD8w>
X-ME-Received: <xmr:zyb9Zh8FeAzD6Scolciytyse2OkrG5Uz2-Kjs6AJCR0p2QepeDG27u4jWCY2WxfbRWoNQIKc_MlarL6ExeB9cDgqOx-8CuSSGLnEsJdj15jryIwr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:zyb9Zlp0KwOQ168OzfLYoXofR33D9nums75ZxyWY5v48g2CwRxsPDA>
    <xmx:zyb9ZqoqRe9yFbFt-J-BiDbeVyPpvZN5gfgR-9E92-0YkHCsB-gRjA>
    <xmx:zyb9ZrSCZkZuFzsCVHxVG9BBUaQEdc6y2NYC9jGzPaft-H5gwX4smg>
    <xmx:zyb9ZirwoBuvx4U4xAnRX0SsXltONuQrDWR-BAS-vAmghs5HAuPopQ>
    <xmx:zyb9Zjma7KUchURCTNeBSbP9vXSu7nDBCNvLkFb2VVQKxCTyrXHtxGv9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39101c89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:24 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 16/25] reftable/stack: handle allocation failures in auto
 compaction
Message-ID: <103a59ef0a5318b2ecef7ba65b7bb0c049b6dc6c.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

Handle allocation failures in `reftable_stack_auto_compact()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2e6dd513d7..990784d9d2 100644
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
2.47.0.rc0.dirty

