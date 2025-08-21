Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BB2C11E0
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758457; cv=none; b=OzmwhXJZG2aKEI8w+EdvSxpH13w2Y2/JZtNEXxxoM4xayuVJpSClZJVFpc2nNnP8QSlgjhJc0quPss9anJsVjmbfZ89oVaoCfGnjCrqQD5Orr3yCQd6AKOWZMNAIz5iBzM+AyQwPqrYIDKx45WDJ2+KF0D8zPj41lw1lFGaVR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758457; c=relaxed/simple;
	bh=qI74wt4/K9/ysPraYC49GJPniE+BFvwPZiTMa0S0LWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0RCAksxQ/YfbGZ8L1e7qN7u0tXCavfBcqVgys9/L90NAHvePCZtZS9Nv/DoeD7zbCn+XP8mhw1HdoOdYZ+PvEJ85BgCfhOelb1FxphHcrQniEH8tpC/Yy66x/jpmZyHmcfV7z5L6GSY1UQe5tewUIoXiZxPrGKG+ULTHMFylvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S6rJqNae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oG4SFUQT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S6rJqNae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oG4SFUQT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4F2614000B2;
	Thu, 21 Aug 2025 02:40:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 02:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755758454; x=1755844854; bh=w0pC5NzxmB
	QZ7LPWWtyg2TnhPaDh7X4eepo6G4UlfSM=; b=S6rJqNaeQv1RHj4zxKpMVZ/2or
	MlwT4UOwfUH7vJEtmp9m00uVstfdDpTTezV9Rq0ehfVTIIi82a7+F9MsnoJDDnIX
	4y/szKD2yUbwKp4BIZcZZzcjYa4LpzCHkBrdID/Fx3vHKoV6ySqjJkGDMFr6700K
	Kfb+w7YKLY1ybelgDqFE6HIandFaMG0SSImnEzVW8egAKYobyLOawO2+lQi563B5
	72RjEb2Gl7JHMHVdwSfHqUQWpbLZyTClfG/mfw6qyX4S/xPedzhvg8KLGD/B1cRb
	F4EQ2hDfUQlmQb8Bh46zX2/OBDIn6KWJYAh99cmqTlMLjdORK2AWpCJU76ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755758454; x=1755844854; bh=w0pC5NzxmBQZ7LPWWtyg2TnhPaDh7X4eepo
	6G4UlfSM=; b=oG4SFUQThxe+xkHothkw59KnxOcF90iSZtzwDM9+YEIhO094Q9a
	WIbZxbD8JzbZkNen3NF08Kgc9WlaDzdnRqdwK7saaTQ/eKW1xy44KRHgj1lx46G4
	nZ7aTES2ORPL7SSaR/mDD67NMrLGuWMVixYnr/pdcLe3he79wz8O1R769J0iSZC9
	djFBGWJd/adlq6u4vMnUGRz/Fo3mbyvE6zhamxd9cMX26dgZ2V11BlNfcqebY83u
	DWxgdJQGEjZSQdI0HM1Vue41XrODfrItEuVM8MchEve/crAtZyXdGG3U58PAjPQR
	IfJ2TqQW7lVGCN5dGzTNwYLtM8oBoKwNz0A==
X-ME-Sender: <xms:dr-maFRcQqpWhp6MCpDNft6DJuLlU48Ii6UhTHXeJeTaifwuKAcpEg>
    <xme:dr-maO-97UY5Hm6OxrZTX2FpBAUqmkNmcfbE1WT4G6UkBKA0HNkWgQHUOeP2_fjvJ
    7O4KU2dDfSx4IIl6g>
X-ME-Received: <xmr:dr-maMrhDE6fH9Rev8nS44EyaG4AskkvTWQrejKd8OwnLWMNNp_hl9a6A-6jIfrxJ30EMwJrPMwG9bohGEoxF-FumYdOBf9-q7TlQ8_mNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dr-maLkcVgrDq6F64jaxysEWpkbw3--aU9dWqJ1x8llxENjznD6Uog>
    <xmx:dr-maDJcnEpq2BSqnAgqjNharIGzCj367o2pHFYulJYYSuvzfAjvjQ>
    <xmx:dr-maAzgFHUT0tnXOUkWdsHfsCbMf_FN8S2ylx83V3gipQtR6VlLOQ>
    <xmx:dr-maLskEECNj9BVFn8iuosWJK4Q23Rq7Jl1xkG_C8DuB2K0HF-b7g>
    <xmx:dr-maGiO5fW4PvFK0vyRdR3Bjl1ii6tQFTToFZNy90g8IsMHC9ykpXzy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 02:40:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51e9bfce (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 06:40:53 +0000 (UTC)
Date: Thu, 21 Aug 2025 08:40:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/16] packfile: remove `get_packed_git()`
Message-ID: <aKa_cg0Q8QMSBKGp@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-14-1660842e125a@pks.im>
 <CAOLa=ZR7eXDAsrRifyvxzTt9RwSR1TcQFs4KLaV7n6byxQM0zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR7eXDAsrRifyvxzTt9RwSR1TcQFs4KLaV7n6byxQM0zA@mail.gmail.com>

On Wed, Aug 20, 2025 at 06:50:05AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We have two different functions to retrieve packfiles for a packfile
> > store:
> >
> >   - `get_packed_git()` returns the list of packfiles directly.
> >
> >   - `get_all_packs()` does more work and also prepares packfiles that
> >     are being indexed by a multi-pack-index.
> >
> 
> Question, under what situation would a packfile not returned by
> `get_packed_git()` but be indexed by a multi-pack-index.

Okay, this whole commit message isn't all that enlightening. The only
difference between these two functions is that `get_packed_git()` only
calls `packfile_store_prepare()` and then returns the list of packs,
whereas `get_all_packs()` does the same and then also prepares the pack
so that it's properly marked as being indexed by an MIDX.

Now that means that `get_packed_git()` does _less_ work. But both
functions already load the MIDX via `packfile_store_prepare()` anyway,
so the only difference is that we now also call `prepare_midx_pack()`
for each indexed pack. And that function does not do a lot: we have
already loaded the pack itself, so `packfile_store_load_pack()` returns
the already-in-memory pack. So all we end up doing is to figure out
whether the pack is indexed in the MIDX and then store this info in
`p->multi_pack_index` as well as `m->packs[pack_int_id]`.

So the amount of extra work shouldn't really matter. I'll rephrase the
commit message.

> > The distinction is not immediately obvious. Furthermore, to make the
> > situation even worse, `get_packed_git()` would return the same result as
> > `get_all_packs()` once the latter has been called once as they both
> > refer to the same list.
> >
> > As it turns out, the distinction isn't necessary. We only have a couple
> > of callers of `get_packed_git()`, and all of those callers are prepared
> > to call `get_all_packs()` instead:
> >
> >   - "builtin/gc.c": We explicitly check how many packfiles aren't
> >     contained in the multi-pack-index, so loading extra packfiles that
> >     are indexed by it won't change the result.
> >
> >   - "builtin/grep.c": We only care `get_packed_git()` to prepare eagerly
> >     load packfiles. In the preceding commit we have started to expose
> 
> Nit: the first sentence reads a bit weird.

Ah, that was supposed to read "call", not "care".

Patrick
