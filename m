Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FFF23774
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326557; cv=none; b=bPZA2AqRt6WLphcUYIW7xBOan0y2oLzcalE5nCTdvHNrhue3dOsN6RDduHEQpwkY231b87wkpLqkXe4k9QuQkxMoHIrEUQ4/iwTNCjFv+5+uX5L/6uDL6HwFsT3OtTvu3Na+nWOj8mv8VG2mp6wft8jDh9Phq5F2ZpZQCJ/t2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326557; c=relaxed/simple;
	bh=rWVurxbZERmSNlrw2fgOcMV/hBtNdIE88S+LnuOVa+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUI/zyVkBjiJ6+th4w4uIN9/es22bccv3Rwtg1j3I/wXkQYP01T/mBQFmLvSqYelgPupLWBOq7tNzEJ5hEabA5RjFVKZpNbn/980477jadRHCL2LFLOfr8cHv2QnXOC7e0avOd4iKRFmYI6HVBpr6zfj7r9vxBOJBwoz30j9hZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hV8ba2O+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rbYI8b2S; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hV8ba2O+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbYI8b2S"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1B9A61151BA8;
	Thu, 22 Aug 2024 07:35:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 22 Aug 2024 07:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724326554; x=1724412954; bh=CG1qxApC9k
	t0Pj3DamHh6mhvd1JMRVcWZTInki5GtKw=; b=hV8ba2O+Z+S/XnsQaHEPgV+HFg
	TlYKgdAYs6EDcNeHU+2A73ORDtR/S0UFu/zVm7AV++jvxDu009LEQCaxHN+zjY6n
	08uIAZNt4NZ7jgrQ9I8Lw1JgPUC/gg82G9bkKn/TCDPDyYmq9HInhlsrfy39WAy/
	lWJJDYq1Ptip0NXl49mya5terMzVVaRZcHbJLQTvgY0hsvFkxPyaX1Dq1+Z3x3ZX
	PjuYmiDiEezC+K8+URoaZ17HYtfihyfaEUlUvMK66AFO6CV5R0mvH7wUeRJtl1Jp
	jaqGfC90LtekS0KsOsJ5szg4WpRIK1YsfpsadQp+06VG1PkSwfPLGl8vc8lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724326554; x=1724412954; bh=CG1qxApC9kt0Pj3DamHh6mhvd1JM
	RVcWZTInki5GtKw=; b=rbYI8b2SGd43iUpxyIg46l0Rsq7MkwO6idrd+EhaSBfQ
	S8++mWobq5f1RrUxeMbx1fvsKVJRuut1O/MMArcGYkI8n0aDRxrAoPCuPClS8VAU
	Q2zf6O1ltJ7HrqyPVHJT5zOcNiMuX1K3krlgujMAhmp30/DdRt0BCqtXbsTglotz
	mfA9yhwDVCyqzdNzVSF0LoCwLfwqieqflUjaI7SSCailxAULIS1Z216L6ZKjUfn8
	W0y8WHvh81NiAnUOs95TIgrqNrl+qZvmOgE9e9YPmvQMit3eigjhQbhuDstsf+uk
	qz7Hy+yDUWKD/6NyO4zJRh6Fb/B4XPcwGMB6g4Yq+w==
X-ME-Sender: <xms:mSLHZlBQ-RL8R4fcXK8spi8g0GWtLnXku3G8q5NDaHkwhz4t_V3ClA>
    <xme:mSLHZjguBcRsqWGLcPtL-DRfKKiUT-Xz6xUapngBtiTrO5TcDrc_OmytBtqJuV0Lq
    sIGjdSFoHL7N4HGQQ>
X-ME-Received: <xmr:mSLHZglWu0B_S8gOoO9dpL6E2XiUDbO-wqkahA8KU_DxmuJ9kiGbof2MFmeMgisMYUXbbrdGbUCSnduUM7JSpvURPL2vUt4NeXLgU-zQhhuklEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mSLHZvwjP0JslZI_o2IX14bsMzGFoYGKcc5bDnB6wf1lndxoSIS6lA>
    <xmx:mSLHZqR-yt8axp-o8O6UgYFq33nNrwU-02mME_Y-jmQzeRLe35TinA>
    <xmx:mSLHZibgFa8BGoSCqbfclDRVfXEphj-veVo2x47bHW2XMX4BDzCkag>
    <xmx:mSLHZrQlWD13aHn0ivJAbqRZ8dcdS1QW6pnDZhUi1UbhaV3n-ddwxA>
    <xmx:miLHZofkLw15SC1YDgufVNTBHREhzj_fYktaiyVuSJ2jzxWlAp4kEv5c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 07:35:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be9ad1c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 11:35:16 +0000 (UTC)
Date: Thu, 22 Aug 2024 13:35:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/10] reftable/reader: introduce refcounting
Message-ID: <ZscilS_kLcJyHThx@framework>
References: <cover.1724080006.git.ps@pks.im>
 <fc0ed68d4675bcd4c89bf63419ec6e8b6b7f5fca.1724080006.git.ps@pks.im>
 <CAOLa=ZThdm98qrcQVu2uXkHJ2meEnJJCsBSPSLMQeSwsojQ-Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZThdm98qrcQVu2uXkHJ2meEnJJCsBSPSLMQeSwsojQ-Fg@mail.gmail.com>

On Thu, Aug 22, 2024 at 02:47:43AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > It was recently reported that concurrent reads and writes may cause the
> > reftable backend to segfault. The root cause of this is that we do not
> > properly keep track of reftable readers across reloads.
> >
> > Suppose that you have a reftable iterator and then decide to reload the
> > stack while iterating through the iterator. When the stack has been
> > rewritten since we have created the iterator, then we would end up
> > discarding a subset of readers that may still be in use by the iterator.
> > The consequence is that we now try to reference deallocated memory,
> > which of course segfaults.
> >
> > One way to trigger this is in t5616, where some background maintenance
> > jobs have been leaking from one test into another. This leads to stack
> > traces like the following one:
> >
> >   + git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 --refetch origin
> >   AddressSanitizer:DEADLYSIGNAL
> >   =================================================================
> >   ==657994==ERROR: AddressSanitizer: SEGV on unknown address 0x7fa0f0ec6089 (pc 0x55f23e52ddf9 bp
> > 0x7ffe7bfa1700 sp 0x7ffe7bfa1700 T0)
> >   ==657994==The signal is caused by a READ memory access.
> >       #0 0x55f23e52ddf9 in get_var_int reftable/record.c:29
> >       #1 0x55f23e53295e in reftable_decode_keylen reftable/record.c:170
> >       #2 0x55f23e532cc0 in reftable_decode_key reftable/record.c:194
> >       #3 0x55f23e54e72e in block_iter_next reftable/block.c:398
> >       #4 0x55f23e5573dc in table_iter_next_in_block reftable/reader.c:240
> >       #5 0x55f23e5573dc in table_iter_next reftable/reader.c:355
> >       #6 0x55f23e5573dc in table_iter_next reftable/reader.c:339
> >       #7 0x55f23e551283 in merged_iter_advance_subiter reftable/merged.c:69
> >       #8 0x55f23e55169e in merged_iter_next_entry reftable/merged.c:123
> >       #9 0x55f23e55169e in merged_iter_next_void reftable/merged.c:172
> >       #10 0x55f23e537625 in reftable_iterator_next_ref reftable/generic.c:175
> >       #11 0x55f23e2cf9c6 in reftable_ref_iterator_advance refs/reftable-backend.c:464
> >       #12 0x55f23e2d996e in ref_iterator_advance refs/iterator.c:13
> >       #13 0x55f23e2d996e in do_for_each_ref_iterator refs/iterator.c:452
> >       #14 0x55f23dca6767 in get_ref_map builtin/fetch.c:623
> >       #15 0x55f23dca6767 in do_fetch builtin/fetch.c:1659
> >       #16 0x55f23dca6767 in fetch_one builtin/fetch.c:2133
> >       #17 0x55f23dca6767 in cmd_fetch builtin/fetch.c:2432
> >       #18 0x55f23dba7764 in run_builtin git.c:484
> >       #19 0x55f23dba7764 in handle_builtin git.c:741
> >       #20 0x55f23dbab61e in run_argv git.c:805
> >       #21 0x55f23dbab61e in cmd_main git.c:1000
> >       #22 0x55f23dba4781 in main common-main.c:64
> >       #23 0x7fa0f063fc89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> >       #24 0x7fa0f063fd44 in __libc_start_main_impl ../csu/libc-start.c:360
> >       #25 0x55f23dba6ad0 in _start (git+0xadfad0) (BuildId: 803b2b7f59beb03d7849fb8294a8e2145dd4aa27)
> >
> 
> The stacktrace is for iterating over refs, what I don't understand is
> where in this flow do we actually reload the stack.

Basically, whenever you call into the reftable backend we check whether
we need to reload the stack. So, when creating a reftable iterator,
reading a single ref, writing refs and so on. So in the above code flow
we had a ref iterator, but during iteration we ended up reading other
refs, as well.

> > While it is somewhat awkward that the maintenance processes survive
> > tests in the first place, it is totally expected that reftables should
> > work alright with concurrent writers. Seemingly they don't.
> >
> > The only underlying resource that we need to care about in this context
> > is the reftable reader, which is responsible for reading a single table
> > from disk. These readers get discarded immediately (unless reused) when
> > calling `reftable_stack_reload()`, which is wrong. We can only close
> > them once we know that there are no iterators using them anymore.
> >
> > Prepare for a fix by converting the reftable readers to be refcounted.
> >
> 
> Okay so my understanding is that `refcounted` refers to a reference
> count which keeps tracks of the stacks which are referring to the
> reader. The name is also used in `struct blame_origin` in blame.{c,h}.
> Makes a lot more sense now :)

Yup.

> > diff --git a/reftable/reader.h b/reftable/reader.h
> > index 88b4f3b421..3710ee09b4 100644
> > --- a/reftable/reader.h
> > +++ b/reftable/reader.h
> > @@ -50,6 +50,8 @@ struct reftable_reader {
> >  	struct reftable_reader_offsets ref_offsets;
> >  	struct reftable_reader_offsets obj_offsets;
> >  	struct reftable_reader_offsets log_offsets;
> > +
> > +	uint64_t refcount;
> 
> Wonder if there is a chance that we decrement refcount from 0 and hence
> cause a wraparound.

This should never happen in practice. And if it does, we would hit a
BUG():

    void reftable_reader_decref(struct reftable_reader *r)
    {
    	if (!r)
    		return;
    	if (!r->refcount)
    		BUG("cannot decrement ref counter of dead reader");
    	if (--r->refcount)
    		return;
    	block_source_close(&r->source);
    	FREE_AND_NULL(r->name);
    	reftable_free(r);
    }

If the refcount is at zero already, we hit the bug.

Patrick
