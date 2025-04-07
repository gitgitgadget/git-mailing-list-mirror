Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79E15382E
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029059; cv=none; b=CYxOf77quaKULMWh6OpNjkL8VVxfdkdFLx7mm7IX6yWIlbEWuJG6vU46Au899xCvah1Hp+PbAUad5T/mYJSTD/mn185zRSl+gpH7Zf+OvPjZ19fP/Rc4xFj9vk9TEyVlYidEqAt53apw25ngnOM6VD6YAypXqnX6tzSIegv4YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029059; c=relaxed/simple;
	bh=BArgUDan1nWrGxB7HCcdL4hQxhc8+03iA4m2SVmFOuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBjbFtevuHVE7fUhNkpJlPwXT0+zhA1A5/wRoGcoYBJS0QBeHCzqPzw65N5kULPabl7SOk/SLW6I87RnX1jIHR/DbDtrSOZSsc12IUu5rSumwQueqM98poBbfTNprGVYXKmni3rplmYSLn7BIey7s1z40/VB4R4eBt7QPj70cRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0XySyD6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYFf3SHm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0XySyD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYFf3SHm"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B2031380116;
	Mon,  7 Apr 2025 08:30:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 07 Apr 2025 08:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744029056; x=1744115456; bh=DlEoCeZ9/h
	k4GxAr+frVJxqvGYgbATxjh5q09vBn2GM=; b=W0XySyD6zOLLBj/sA6oPR7Y824
	dh+YrL8tzFvLW+oI/eb+QOuOrGgtK31QaOQTZzmsx/jXeaS0ADtnDBuGvd8UT8md
	wVz6KTNv1Bx8qEVpVdgK2wz1/CjT+ZXj5sjiPO84xrM8Qz1DeDLt6k4fm7ra0Vhu
	5DDwuYUgTwPGZ4iPWJ3yiOetYw6afoVIxF9KeP+r0OzmxgmON6zmlrrcECtC+NGc
	xucNKsNRyIV/Ftsab5ASsBtS8P5EZJeCgZn7drBVi48WtZeNN72Ke7vglLXD8jbm
	KUahvX9XNQJjU9+3qOQsPmZgeaQ6o736tDU221clpji9gS8LGmW5Z72npiPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744029056; x=1744115456; bh=DlEoCeZ9/hk4GxAr+frVJxqvGYgbATxjh5q
	09vBn2GM=; b=nYFf3SHmgfClqEfF5dX9Nthq0N1ukFnEVq+K5b/IhcsQCCCKUw0
	YZITyw5lkQ35vQBRiVd8KY+8Jg+xa2cf9Nq5bBhp0xX5EEBEW29RJs81AjzdEEua
	86kf2SXvLSnl5PZSCRYTzCtZQKAcQ6jzO4cRWOpjc0fF1hjebkCuuzobPSkSR3SG
	kc47E4Qzit8w+WYG7k/ugTw9SIGGalPlEYHe7vqW3Ym0Gik42C2zLRcD+EfAO52/
	+ZkU6mlXa3NWej3ikoecu1V5mY8HwB3FF4dA4Igf8QMOYlWV1JRZRhLOke3ZEZbW
	HiN2zpWdfpnyjwvbdkN4uYId2NzJqIlbJzw==
X-ME-Sender: <xms:gMXzZz2oMmKKCrwT2_Clp92AFxMq3-x82i4wqyVdbYnXeDkUJag7DA>
    <xme:gMXzZyGM6pjQoOaKeEsFg5b8El-YO-EXO3nvI9JeT0EpF4UDltdPlX0_3F8uQN4RV
    3zhcCowZ1IUcMiLIw>
X-ME-Received: <xmr:gMXzZz6oj5kX5uXY9aRNpWKLQYSQJuhTx4qESE11KsDtGfDskrDlb1Qo9ehVu2plEPrYPblfKWYKJ4w5vCf8NWgtpZcU7w96mVskWK5b3DAG1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gMXzZ43CXZUDyLyEQqYdZb24k5JbRyPqxK3JfCh-S-jb9ZTIWmV1eg>
    <xmx:gMXzZ2FI9rH_qBG29d3yhWQXWlhvkMu3RZ4hVvyAEpClDf-JAoU_1Q>
    <xmx:gMXzZ5-TNmN0SHj98EvDQ96JExdgwZt-jfPASZyVBpbUSrm_elazrg>
    <xmx:gMXzZzlGD7Lx3jV2wGGobP5OTIo7LUPNf9ioeSk3oW-HybIIwOMymA>
    <xmx:gMXzZ9j5u87L7QKSz5ZyifNOHzFVP_opWTMpZzecjC4noy4oW3dxMHut>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 08:30:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7768f313 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 12:30:52 +0000 (UTC)
Date: Mon, 7 Apr 2025 14:30:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/16] reftable/block: rename `block_reader` to
 `reftable_block`
Message-ID: <Z_PFfNwJVfVIuTPO@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-7-ebed5247434c@pks.im>
 <y47rmb3ahghwvhdukfj27fihddmg57rqpfcqmaylfejqjjxvrr@luc7xuu5qiza>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y47rmb3ahghwvhdukfj27fihddmg57rqpfcqmaylfejqjjxvrr@luc7xuu5qiza>

On Wed, Apr 02, 2025 at 03:39:57PM -0500, Justin Tobler wrote:
> On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> > diff --git a/reftable/block.c b/reftable/block.c
> > index ad162ecdbf6..d188665388d 100644
> > --- a/reftable/block.c
> > +++ b/reftable/block.c
> > @@ -222,10 +222,10 @@ static int read_block(struct reftable_block_source *source,
> >  	return block_source_read_data(source, dest, off, sz);
> >  }
> >  
> > -int block_reader_init(struct block_reader *br,
> > -		      struct reftable_block_source *source,
> > -		      uint32_t offset, uint32_t header_size,
> > -		      uint32_t table_block_size, uint32_t hash_size)
> > +int reftable_block_init(struct reftable_block *block,
> > +			struct reftable_block_source *source,
> > +			uint32_t offset, uint32_t header_size,
> > +			uint32_t table_block_size, uint32_t hash_size)
> >  {
> >  	uint32_t guess_block_size = table_block_size ?
> >  		table_block_size : DEFAULT_BLOCK_SIZE;
> > @@ -236,19 +236,19 @@ int block_reader_init(struct block_reader *br,
> >  	uint8_t block_type;
> >  	int err;
> >  
> > -	err = read_block(source, &br->block, offset, guess_block_size);
> > +	err = read_block(source, &block->block, offset, guess_block_size);
> >  	if (err < 0)
> >  		goto done;
> >  
> > -	block_type = br->block.data[header_size];
> > +	block_type = block->block.data[header_size];
> 
> Ah, in the previous patch I suggested renaming the `block` field to
> `data`, but I guess that would lead to `block->data.data` here and would
> also be a bit funny. It's probably fine to just leave it as-is then.

Fair, but I think if we rename this to `block_data` then it's fine and
helps to clarify things a bit. I've done that now.

Patrick
