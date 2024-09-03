Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8B1A0BF0
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356935; cv=none; b=XkjdTn9ZQm/6bISj/wQwNYV2LxPOI82/Ezr/rmblGSebFlqtzlxi4N1qdh4ijxqGRuprtQUM2QsthWrrUPF18bqpgDxhn3gtVr9RE39gEiYrY9wYR9DvP1RWp+CIc8XiqOgjcGD42MJG73W6fW9vcnDAQ2oMXB13sXSc3o4toyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356935; c=relaxed/simple;
	bh=57/W+F2vvNA97M89wUPeTPHda8mpyhPisvOFv6Go73c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faaw68l4ka+ZHwZojTSadzrv+AOf6oSMBS7uHiPahPmskaBMSC0r7uua94h3APh9M4nhI3zDzfZTn9XVqstNb1F3/7VHBe/01nEzBUFLwpx93dAsV+cSJUuiKb8JmdRWkog7njo/hAgmgYowSAphTpFL48FXCbTMFic6BpNXwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NxnWVaYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwfZBMR+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NxnWVaYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwfZBMR+"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDE6D114030C;
	Tue,  3 Sep 2024 05:48:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Sep 2024 05:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725356932;
	 x=1725443332; bh=mF4saK1elKhJgqki7JnxD04LgAAmzVl8s7J2fhpvrbg=; b=
	NxnWVaYYinF54+3EBmtZF32CgnTAy8jnngSFDRI4EmSb1uTiSQQOpuoUMG/T24sj
	ilZpINQhcZEAsW+ZqfjqO00e9lq/wdyapqtjcjmN+Dy097XQovstF6I7bXG9FoAn
	Ucb3XqwHoYnGUP2U10x7pyGbWfjYEhoHEb6CpYpyrvrletbkO/LLOmWyPnBcJ/dJ
	lEvsRifQAEDh2Oqz0+6W2zCtjrjB8dLnCMjTntRiPKYegZsz2iQNijdj26gH/XyW
	0SXkjRibYiArIGnLvrqG6fuKm7NWC+VrYfRTnbxn+KiD9F69oH2tCabXgoeXvcVj
	nP6XQr78gX33k+7tmXxTjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725356932; x=
	1725443332; bh=mF4saK1elKhJgqki7JnxD04LgAAmzVl8s7J2fhpvrbg=; b=Q
	wfZBMR+0a3fcYVkVjhFe7jQ15oObP5wjYxN+W3DRoNRTRBfevWHhOX9R8KNStcJm
	N5y1hdnmM2TfCgTk4DSC/57uuwPd81Qvcoi7FD3CchaKL7+bu+nAJ9rFcaRgj/KO
	XjYJ8iAwg/gJhILwoaG+dN6Y4VtLmJzpb4SQ38pcSIozFt39uX/XiS1AuxFFCAmF
	BcRsg0tmwp/Sqek364qBgaNw4UFav2CqZ0oGXXWNr9XDZ6mYrpwLLM/BCaGTxJVj
	7H/CjerNOU7g7Q20rPMZv76iz2jU6K1NBdl6n2DnxSnWIVRt29Io8d826WOLdmKu
	GxV9vhUny10Z4mUDQ4r7Q==
X-ME-Sender: <xms:hNvWZgJeD6GXTgwrkJT8jJc_qveiJVPMI0YLu37Qr3C2HDWMa9Q5Jw>
    <xme:hNvWZgLvzg-tRl5GPP4mGUfRC6tyV7M0MlZD3p0s3A4VRJ50ZfoyRvRNMsf1t5xt0
    h6igc1i5MeP1FrfdA>
X-ME-Received: <xmr:hNvWZgvoD68ihWtx4IFlTmAM7u6wzSvuntFO0ec1A0THzlsJYMCvd79RTJPYT_gxyOqGqyF59Uo-YNKqT_gSkYWs9DPTIg-S-1Ninx1d3H1VkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleevgedvtd
    ejtefgteefvdekiefflefhgedukeffveeftdfhveeuhfegfeduveffnecuffhomhgrihhn
    pegvgigrmhhplhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhhusghhrghmshhiiiiilhgvshesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hNvWZtYaR40RL0Whh6J0BG-SBDm2YZGzFJqqleNg923u9Egn6kE2Hg>
    <xmx:hNvWZnZ17palesKHHiH8Y8EGLzVXQa2Rc5MuIHh7ov5WW4wlGGV46Q>
    <xmx:hNvWZpCjvp7wfr8ojvprLpaFmh8mvgvHwMNUEtAQSWZ2cfOJzhym9w>
    <xmx:hNvWZtaVfPnilGw_gcYYWQWnbI4-_R773vkcEZjwO-r5tH08O9w_ag>
    <xmx:hNvWZjHrodcRtnX5yEElln1rNdX7YfDiE9XIJhqmDK9Pa61yH_v7yymV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:48:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50f7cdad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:48:43 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:48:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubhamsizzles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes
 to fetch
Message-ID: <ZtbbejUrUO2tdsUQ@pks.im>
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
 <Zs8KzG0vzCEDvkvx@tanuki>
 <xmqq4j7438yc.fsf@gitster.g>
 <CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>
 <ZtacHCuql0pX3V2u@tanuki>
 <CAG=Um+17JYyqC6n0gU3GSNaVz1PaB1U50M1hy87zObB+Rc03Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+17JYyqC6n0gU3GSNaVz1PaB1U50M1hy87zObB+Rc03Qg@mail.gmail.com>

On Tue, Sep 03, 2024 at 11:31:04AM +0530, Shubham Kanodia wrote:
> On Tue, Sep 3, 2024 at 10:48 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Sep 02, 2024 at 09:16:24PM +0530, Shubham Kanodia wrote:
> > > > Patrick Steinhardt <ps@pks.im> writes:
> > > >
> > > > > I'm not aware of any discussion around this...
> > > >
> > > > I do not think so, either.
> > > >
> > > > I agree that it makes as much sense to limit prefetches to a subset
> > > > of remotes as it makes sense to limit to certain hierarchies (e.g.
> > > > excluding refs/changes/ or even limiting to refs/heads/seen and
> > > > nothing else).
> > >
> > > I'm seeking advice on the configuration option structure for this
> > > feature. The typical config format for maintenance tasks seems to be
> > > as follows:
> > >
> > > `maintenance.<task-name>.<option>`
> > >
> > > A natural extension of this for the prefetch task could be:
> > >
> > > ```
> > > git config maintenance.prefetch.<remote-name>.refs refs/heads/master
> > > ```
> > >
> > > In this structure, the 'refs' value represents only the source part of
> > > a refspec, and both remote and refs can be configured.
> > > Specifying a full refspec isn't necessary since the --prefetch option
> > > may override the destination anyway.
> > >
> > > While I've successfully implemented this approach, I'm open to
> > > suggestions for alternative configuration options. My concerns are:
> > >
> > > 1. Most Git configurations are nested up to three levels deep, whereas
> > > this proposal introduces a fourth level.
> > > 2. This configuration appears in the config file as:
> > >
> > > ```
> > > [maintenance "prefetch.origin"]
> > >        refs = refs/heads/master
> > > ```
> > > which might look odd?
> >
> > Agreed, it does. To me, the most natural way to configure this would be
> > as part of the remotes themselves:
> >
> > ```
> > [remote "origin"]
> >     url = https://example.com/repo.git
> >     fetch = +refs/heads/*:refs/remotes/origin/*
> >     # Whether or not the prefetch task shall fatch this repository.
> >     # Defaults to `true`.
> >     prefetch = true
> >     # An arbitrary number of refspecs used by the prefetch task.
> >     # Overrides the fetch refspec if given, otherwise we fall back to
> >     # using the fetch refspec.
> >     prefetchRefspec = +refs/heads/main:refs/remotes/origin/main
> > ```
> >
> > The prefetch refspec would be rewritten by git-maintenance(1) such that
> > the destination part (the right-hand side of the refspec) is prefixed
> > with `refs/prefetch/`, same as the fetch refspec would be changed in
> > this way.
> >
> > An alternative would be to _not_ rewrite the prefetch refspec at all and
> > thus allow the user to prefetch into arbitrary hierarchies. But I'm a
> > bit worried that this might cause users to misconfigure prefetches by
> > accident, causing it to overwrite their usual set of refs.
> >
> > > Also, hopefully my mail is formatted better this time!
> >
> > It is, thanks!
> >
> > Patrick
> 
> Interesting. I guess if we put this in `remote.*` instead of
> `maintenance.*` what's unclear then is if this setting should also be
> respected by `git fetch --prefetch`
> when used outside the context of a maintenance task — since that'd
> probably be a bigger change.

I would've expected it to already do, given that it is explicitly
documented in git-fetch(1) to be for git-maintenance(1). I don't have
enough knowledge around the prefetching task though to be able to tell
whether it should or shouldn't.

> For instance, the `skipFetchAll` remote config option seems to apply
> to prefetches (within maintenance & outside) and normal fetches.
> 
> Additionally, we'd need to discuss what to do with backward compatibility:
> 
> If we were designing maintenance prefetch right now, it'd probably
> make sense not to fetch it for any remote / refspec by default unless
> explicitly enabled since
> fetching all refs can be a waste of space in more cases than not.
> 
> However, since the current behaviour already fetches all remotes and
> refs, I don't know if breaking this is something we could do? If not,
> the behavior would be —
> 
> 1. If none of the remotes specify a `prefetch: true`, then prefetch
> all remotes and refs (backwards compat)
> 2. If at least one of the remotes specifies `prefetch: true` then only
> that remote should be fetched
> 3. Two-tier `fetch` / `prefetchRefSpec` hierarchy to decide which refs
> to fetch (we can decide on the name later as `fetch` and
> `prefetchRefSpec` seem asymmetrical)

I don't think we should change the current default. As mentioned in my
mail, `prefetch` should default to `true` such that the behaviour as we
have it right now is unchanged. Thus any remote that doesn't have it
gets fetched by default, and to disable fetching a specific remote you
would have to set `remote.<name>.prefetch = false`.

While the second item, namely change the default to `false` when there
is at least one `prefetch` config, might be something to consider. But
in the end I think it would lead to confusing behaviour, so I'd not go
there personally.

Patrick
