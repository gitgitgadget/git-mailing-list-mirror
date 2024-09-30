Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75461741CB
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683744; cv=none; b=ty0P30QKHjEK0IFxReT3KNe2fY1tqzNtXsIb0gqWcsLrLKOfqC7TzAlPAjUlM4ny+yJe5kpcXIKXwnhIo3ZRbLy7WFGBUbdoPam7mRshcC6xizcgqfIH/TRjVVBMuscQXfE2XBLgguYOjVBbdzmowectdI93hGXtfxitvAuJmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683744; c=relaxed/simple;
	bh=P9IzqVnItwRvVxhnCjm9uAVypvriqJW8QjT4NSpYOBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHnz9mg2VTIynlWFYXZyojo8H5sYrLWtfBfKxvdKaKgkvO1nZB3hbOmhd0Dzzpnd8na5lPMEM0kCexK1JYJ16tKNE42H3h3GH19BnaGp755IYGrBm8tjzZmm2xI4RVO1oQ7h1stdXRKcFdJfAFQxRaUpOAWCHPh7KZJp1MbTXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E2K7gWtO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqClrgIN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E2K7gWtO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqClrgIN"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1256B114020E;
	Mon, 30 Sep 2024 04:09:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Sep 2024 04:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683742; x=1727770142; bh=x1z1QJP2jx
	ivIIyJSHoxy0gNQ8wbD3oyjqeZ/uHjKQg=; b=E2K7gWtONdHi1YSfUYHffULv++
	/4u32CtW3zt8q+v0tbpKh/qLh/IC6eiQvv/TumIHALumVYkt0g5OVsdOR+9p+YAr
	2V/r/QVqfeM7jtB6PVb/lXZoIg7QpoEcGBgWwohlqbGfaRoqoV25ZhMBC6AwQ6NW
	2AarLEoP3ZJHh6fJj58CcyxyF+vibBE+Bw+fhhFr5POQQcGCVmUxyGtSTGumyl12
	dpHsH5oZSygsMitlwSWuyDuwaAeSwDIX6nYhejb/JN4DVa0g8wNRub0f3NvvX8ee
	sM7kc7noFvGvzgN23xIrnSxy+CgkecLQvQ/dWjIlDpLSST7Ob21yhJ8v7oXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683742; x=1727770142; bh=x1z1QJP2jxivIIyJSHoxy0gNQ8wb
	D3oyjqeZ/uHjKQg=; b=IqClrgINy/8bq9IjFvta5KS9IwY324CyduX0WMtX/zLW
	o9hsmKKdN6Ozy9utRvvdqlYBgm62zc2F4v8dVgMc8Ay/6hJmKcGNtxIUHlBkKb3Y
	nsGF5w5r9Pjq3hLRFhUA78d9gu5pbwF1IP50n4/ODG5pTH+CSErF0FfZtaVAZqRI
	1WdIpxkFDK1hfI2dHeFwA28NRIAUmA1JLsvBdi/JSBEXNB4MrVoPZwCvALXJ1klK
	xeed7IfWtNywH1ZR8kacMkSSO7CrB7KOJsiKk8Qk2zAm0NMVPtpIlxdcv9hhPMg+
	UEWfMf3b0CO+3pPxretSn8e2NSYvP6YtyajlRNd/FA==
X-ME-Sender: <xms:nVz6Zrt_A4Ba_mdrXe19aBAuewMEgw2eewYyxeeIPjeNQZw_hghpiA>
    <xme:nVz6ZseAmdguyEh6ptmiJaUzc-AKkHHWVpaUygmgpF1Ta1qLvFs2kHVaHXanm1GAh
    eKHxUYyXiLjgsEJOA>
X-ME-Received: <xmr:nVz6Zuz24mOSFgWWbGi-XUDZ2GJLlit-xd31HtniCTyVKDEOj5uoMjWY-_OIU8bgfFOsSLNi0rioxXtbrs3t0V8--qAKdWjdltFr_dQ-fRSlhhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomh
X-ME-Proxy: <xmx:nVz6ZqOW7v8Ye36EklPzdjZPTXXtFvbXFBZh4mQQV_d2Go55-DfkBw>
    <xmx:nVz6Zr9ZdMhdIKUU6GGVKJrdAmaazi7nt6wLCVaV0U0sVuT5f-6sig>
    <xmx:nVz6ZqVsJsEBZdHvWykdIlrO7gujJoNzGXxoeNspmZGd9yuCfpDMCA>
    <xmx:nVz6ZscRsnO7iYQbv7DVkRR3pyPDkZwyzxh1h6YgyKEaUIRGa4wu-Q>
    <xmx:nlz6ZnZyswLW4rBjZE3pJuBOVKmO3l7XZVqyMVpawOLCNaXw_k4bNXMY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:09:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2da73fed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:14 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 16/22] reftable/stack: handle allocation failures in auto
 compaction
Message-ID: <19acebd9195e7ba587ae17154d5ad7d0d218ec10.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

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
2.46.2.852.g229c0bf0e5.dirty

