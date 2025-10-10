Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8687154654
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095363; cv=none; b=KXfb9TOP50V1mgk60Z6BrR9QVWd5R5wDfcG2dxI+81prrRE/zko/Nqm99t3jhhyEf8OANQXvJv6chungE5zBb1gOkNIZysQ3i/w8BRbVvwA8yzFRT+UwCzHjYM/C+jPXU+u9iG/pb+Iey32RttQDAfmD/z3d/rUABPDZzYkIcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095363; c=relaxed/simple;
	bh=mLyRtGWiPgkNQG1d9JwhKgLSI63MbU21MV88o2GN6Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amRaEJOxaDGXCXDt4T31FrLNbzHYxqUqx4HLH3tsC7Sk7Mrb96vaeOFXHqqN1nxBaYu0QOlA4kAuz5/ga1hW9ONkWGj8AGf4iQXYQ5v7dx6PVLILhfL7fDHCjZdNRp6IX/N/XMXIXE7bMP9lGhrDfbW1E07hojVyIPIx2hr4OUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p0S/vhNl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVO7B5MK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p0S/vhNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVO7B5MK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AF78DEC00C7;
	Fri, 10 Oct 2025 07:22:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Oct 2025 07:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095360; x=1760181760; bh=qmMPDEbPkp
	Ad/HYSdlmRxC/YRk1yxzsO8Tz07VDFpuw=; b=p0S/vhNlhIdPQSq667L7EiaF5+
	ar8mVuAxB/m4WOHoFbAUVE0AsUpK5F/j8GK4K+5TXhmavZi6/fWnsJdBqrQJ4NHm
	gkjMrtrdm1UXMqHIl+pdHB8zq7YBHxJTEa/ZxV8p2CGqFyq9MUbBi7akKgGcZ7Bt
	vQ/gc9yCoQhH4Gj6CCZBN12cqmYVdN+IfeUfN11th1abCWxVcIp8nFXZ2adXTqDs
	VEGFXzp4XpHh8cCBV2mpGigs/dhsXREWm2tcNIHnH1G6h2EQfS6FqlA4yxKeFrOm
	K7xFiRbs76QZBKsKBHJYa8q2SAMv0ypK8yR5czhwqDMQoJhYCuh16HfLs7sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095360; x=1760181760; bh=qmMPDEbPkpAd/HYSdlmRxC/YRk1yxzsO8Tz
	07VDFpuw=; b=lVO7B5MKgQV5k4bBLwfOMcb568R5F9N659OGCBwmu5dC5PRk+f6
	jUfpz5XFFsjvD8ajoZFx4A82DwOyEYa1DVAIgvNVyPr4n9olSSNGo/GeNlpk5Jtm
	HKxdP0OWvZbkfDtqB4NymGwIS01Zc1Qle+h4Se/TI8ooVBoo7Qbg+hdOh1dvKfeC
	0xJbZMc733ssxXa+03BZ6uvhTv8HgA/w1wczUY+BtjDOPA4HCXFcicxINs0IQBuX
	ijqdBa8Xx5GEBG08MD8c4z+AFHPSQkP4I7BYHAfIhqZ5HLbQqv6JcM6VdSOfhubT
	Z4wFa0gNI40byth58FSY1jqwGez0W8s2DEA==
X-ME-Sender: <xms:gOzoaMpkdMOaojwo32qDKdLG6im49WgG5eEzT_SBNkP5D7mJPfitdQ>
    <xme:gOzoaIoF6LliRFUjpSWxgthobQy_zzDi3x_hd8XXtvsxaIT-tIp9FNzaqhqF-dO0g
    fC3kMolZWWyYou5BljwsFt-cXbO-5tDngztB8M2pZNCpEJWeykSMA>
X-ME-Received: <xmr:gOzoaO1NRZg3nU6Girnimk0fkBa8umRgS3wXWwzypnPeBwBqOmoajyqt1BZtC1uwXSMZHPqVhMREo_OprgmHqADxnnQlnuyGrMO5T8a8OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gOzoaPBk253lF0FLeUWKVqz9uGsRXv_km9nUBseSiMyahrROA3elVA>
    <xmx:gOzoaOcXIGqkapFj6Ei1OtxNpnKxH45Llq-_y-93p6Zo-ADv6Lg7vQ>
    <xmx:gOzoaMiir_3-SjdOGqSyMgF_X2umEtTt_82ZKVGMhJvHCRYFpfGqwQ>
    <xmx:gOzoaOqx_Cton-q7S_KNM6XO7TCkyGo9rNqEvdUqitDcWK4g-oapqQ>
    <xmx:gOzoaGYcxxOIj9hsQ_P9PtqRqdFbx4AI-fMazpIcclteTjkoeFIsp1-T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9dd9e3d2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:39 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] reftable/stack: return stack segments directly
Message-ID: <aOjse9udPEoWqUaO@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-6-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-6-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:10PM +0200, Karthik Nayak wrote:
> The `stack_table_sizes_for_compaction()` function returns individual
> sizes of each reftable table. This function is only called by
> `reftable_stack_auto_compact()` to process the table sizes.

Maybe: "to decide which tables need to be compacted, if any."

> Modify the function to directly return the segments, this avoids the

s/this/which/

> extra step of receiving the sizes only to pass it to
> `suggest_compaction_segment()`.
> 
> A future commit will also add functionality for checking if

s/if/whether/

> auto-compaction is necessary without performing it. This change allows
> code re-usability in that context.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  reftable/stack.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index f91ce50bcd..9d9326ce0e 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1639,29 +1640,29 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
>  
>  	REFTABLE_CALLOC_ARRAY(sizes, st->merged->tables_len);
>  	if (!sizes)
> -		return NULL;
> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
>  
>  	for (size_t i = 0; i < st->merged->tables_len; i++)
>  		sizes[i] = st->tables[i]->size - overhead;
>  
> -	return sizes;
> +	*seg = suggest_compaction_segment(sizes, st->merged->tables_len,
> +					  st->opts.auto_compaction_factor);
> +	reftable_free(sizes);
> +
> +	return 0;
>  }
>  
>  int reftable_stack_auto_compact(struct reftable_stack *st)
>  {
>  	struct segment seg;
> -	uint64_t *sizes;
> +	int err = 0;

The initialization is unnecessary.

Other than that this patch looks good to me.

Patrick
