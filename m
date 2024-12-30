Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7C19DFA5
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735540156; cv=none; b=JLaku59n61OrBhx7FlCtbhKPqKg7c6BAK+WzFIiKZCGOnGjzZP4kgN2125C+u76Q44m+V67BZlL/TU9Dz95zA6eZvszMThEI1wKjH3SqG8xu5qmXyGeFSwCoIZE8qJweU7BPXGd2UpgHtV2aeQm2eeHAAjD0pemSP6Dng0BRgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735540156; c=relaxed/simple;
	bh=f6TNj7M5JSKQ8yjU3Il2vOFCNWADs9zR0I4m9z7ElcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p375Y/OaMEWZSc5t7yuOwmviXKSvx/tPGTJU870gjNupLKTRrjjlgalwJh1Zylfy99xQL2AQ9G7DydZd2P6JqyqOA3timtzuw9aQCR3vUkbNpfX5+ifj+Tj9OWlBoAP4mwM53mYLKOXnX1NfJLq1DsE1pqX2euj5C5d4apu8oT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ebWVnyFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYZLp2Ig; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ebWVnyFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYZLp2Ig"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 69C131380198;
	Mon, 30 Dec 2024 01:29:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 30 Dec 2024 01:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735540152;
	 x=1735626552; bh=e0YyrPfULZkwAFc1fu3AVuAZGkissfJWQKgGSg1BwaY=; b=
	ebWVnyFR650PLFXQ5FFdejwTesfnVuoTilxaa8YADTUC3zkcUryFsm++rnK25+YZ
	X05AqRfp7gGc9fzHus1O5qN3aJ9ll3XmticgGwHqZsolj7qBAePVWyCJazZIy2fI
	m9nDTsrGNVMO+GPhS4Djk7GyA2nQX26blA+nnEUk/4EO0UAe6zPE4kMoBCJd/CgK
	oDUpAAzUbEzkAJXuYoC9OFI/y3wvOMIa454JPVfsEsk9SMAtJ51DENqXhocSn4uS
	cDjfxWBlqAraToC56NzEkTggVOJ9XP9CKozooNJ25/QJaMZYlsk/2tbdEVyhOLCP
	s2uJCQnF70BjAVLAattc3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735540152; x=
	1735626552; bh=e0YyrPfULZkwAFc1fu3AVuAZGkissfJWQKgGSg1BwaY=; b=m
	YZLp2IgdxcQAJeKERgDEQXZhoiClxZRriGNNycS8IvmO9iCyFUK4+57SrUC1DbVF
	mPe6sVq6t+2eDeNPZ+Ma8TdAs95W0UBswaSokZ+kMs27BNhovqs0dUQ9vFO57DNx
	g2csQ7u8Il7LPMPnqTBHLADQOj1vLb7eD6ea9iou3bRt9WtwMDwv1IHsDRsVT68w
	17BBhzIylFa8zBceGfj4NBgKxEV8Vrkv9Te1/Drki6djIfLRAtQau6GAIW6UbIT8
	aZwamhJqX2psNkH0HPe3ygSHwzF878393UirEKKYq6OdFmDY4XvRvIXI0Mx8HEP9
	hh2AOnIJIuQSuARdNCz9A==
X-ME-Sender: <xms:uD1yZ_sxaQOcz6Ei4pyN6GPImRVz-s9MTQe6LbLRlFVw1zbK2XjAUQ>
    <xme:uD1yZwfmC_ymLd3TOF3bPDtdVS7FBqS2lVrLoDWmkYLUB_qIGtR-EVLAmg7saoNfG
    U10A9m-vK5IJgJzBg>
X-ME-Received: <xmr:uD1yZyyTjxkLp6NQFkfGFJ044GZjBhGyNN0ccWVCy99rwrwhPa3fXgPyi-d7IEXWRd0_fsYvSKX_AUit2Z3V4Nb-Y1gayS4jlrR3-eRGLueVxJcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uD1yZ-OdzvkQxWVHqWDnQVBSxvsnU1sr6PK6WJBuK7wILVMzAMJ1ig>
    <xmx:uD1yZ__vWqLCGfBqiW-Kg8Izk2YiVrS1bk0DktrLZgp7wb7OC3QDzw>
    <xmx:uD1yZ-XlUbZuPYPUvaDn3SsjpRORCPGbo31u3yoEq0x3AtFXbOb0SA>
    <xmx:uD1yZwcyJC0P_IlM7C-2aR9SszG0Y8CNrOFtrhU8sIOBBlXQxRnAgQ>
    <xmx:uD1yZxJebjYGErwEk4v2AjYl0D0vWbS5TgFSh4pwAU1x9ZKlyoaA74S1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 01:29:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b756d4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 06:29:08 +0000 (UTC)
Date: Mon, 30 Dec 2024 07:29:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] reftable: avoid leaks on realloc error
Message-ID: <Z3I9s3ur5NDtW4oD@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <9b2f4baa-b602-4cc5-8dfc-dd941b1d7af6@web.de>
 <Z26CjQpewcyLwfs4@pks.im>
 <039f15a8-aef7-41a0-a396-c395a8416c3c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <039f15a8-aef7-41a0-a396-c395a8416c3c@web.de>

On Fri, Dec 27, 2024 at 09:16:27PM +0100, René Scharfe wrote:
> Am 27.12.24 um 11:33 schrieb Patrick Steinhardt:
> > On Wed, Dec 25, 2024 at 07:38:29PM +0100, René Scharfe wrote:
> >> When realloc(3) fails, it returns NULL and keeps the original allocation
> >> intact.  REFTABLE_ALLOC_GROW overwrites both the original pointer and
> >> the allocation count variable in that case, simultaneously leaking the
> >> original allocation and misrepresenting the number of storable items.
> >>
> >> parse_names() and reftable_buf_add() avoid leaking by restoring the
> >> original pointer value on failure, but all other callers seem to be OK
> >> with losing the old allocation.  Add a new variant of the macro,
> >> REFTABLE_ALLOC_GROW_OR_NULL, which plugs the leak and zeros the
> >> allocation counter.  Use it for those callers.
> >
> > Hm, okay. I find it a bit curious to discern those two macros from each
> > other as all callers need to handle OOM errors anyway, so doing the safe
> > thing should likely be our default here and all callsites that don't
> > should be adapted, shouldn't they?
> 
> I agree, and I my first version only had REFTABLE_ALLOC_GROW.  Keeping
> stuff unchanged if we cannot grow should be safer, right?  But it would
> introduce a leak if the caller exits without cleaning up, so each of
> them needs to be audited.  I was too lazy for that.  And it's work that
> can be parallelized..

Fair enough.

> > In the case of `reftable_buf_add()` I kind of doubt the usefulness of
> > handling the error just to keep the old pointer intact, as all callsites
> > will ultimately error out anyway.
> 
> I can imagine use cases where an object is built piece by piece, one
> part is too large and then you still want to keep all the rest and just
> replace the huge thing with a placeholder or entirely ignore it.  Could
> be a case of YAGNI, though.

Probably.

> > But in the case of `parse_names()` we
> > do in fact want to handle the case specially so that we can free any
> > names we have already parsed, so that case makes sense indeed.
> 
> Yes.  But that leads me on a tangent: Is it really a good idea to load
> a file into lots of individual string objects instead of loading into
> a single big buffer and pointing directly into it?  Do those strings
> need to have individual lifetimes?

Good question indeed. I don't think we ever need individual lifetimes
here. On the other hand it's probably okayish, too, given that the
number of table names should be limited due to automatic compaction.

> > So there is merit in having two separate wrappers, but it would be nice
> > if `REFTABLE_ALLOC_GROW()` would be doing the "right thing" for most
> > cases while the above two callsites would be adapted to use a wrapper
> > that requires a bit more thought to use correctly. For example something
> > like `REFTABLE_TRY_ALLOC_GROW()` or similar.
> 
> So this is about naming?  And with "right thing" you mean failing to
> grow should lead to destruction?

Yup, exactly. I just want to give callers a better indicator which of
these functions does what, and having sane defaults helps in my opinion.

I guess this also depends on whether or not we want to eventually adapt
all callsites to handle allocation errors themselves.

Patrick
