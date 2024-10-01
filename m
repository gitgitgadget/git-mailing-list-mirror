Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337F19F430
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777659; cv=none; b=E8IcKEel+k4HgEPnF7+FyMKPbeD8+34X1wOj5EUU7QcXuibb0rb0TW2x3Q05RXApZ+2M+Lsjq5hAlC9FqhUrWLMF3NvGoPB/Wg8QuH/z9NX5WsCNRAEsuuAtpRczQS53XkMuZ8TWM/gjjH7FVxex63BpHGQAt9o2i6dMORnK7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777659; c=relaxed/simple;
	bh=9rjb6iYlL1fDfn4TnQueYeemAnZsgj60pwVMxMI2WY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL2miLG2O7GEo8pVEtBuCZVtHJL4hcgkifsmfA3qMROggf2A2M22K1/K2u5+pjm1huAgzHjhgqwcApDvPTR0QL2OYtX4FHCuBo7W7W8W0lTlx0eFL9u4K6YJERHw/RnsofpX016zmd6oiRqPxEHIJ3zk1+OOpwNAYtvf670VY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IVJPKhla; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHnpSbZC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVJPKhla";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHnpSbZC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DBE851381D5C;
	Tue,  1 Oct 2024 06:14:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 06:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727777656;
	 x=1727864056; bh=HXR2QcSCZYhKWAgjXQ/EtjfjpyVOtezYsMtyKJLf9J0=; b=
	IVJPKhlad8+gbifoY7fXZYMG4n++QLMb8q8akXnyIi2f9/fczfnZgMgw2zBg/Bz8
	+G2bKZw68pyAywTYOvPbZ9mkJLWR1hDHOw38Dd9skAQ2tJqSRK6TlEJeoks7jK29
	lBrQCt+dXnxDUSCPDq8fm7LNCi0bpYjRWckJG205ehtAcDXzvyBN63aQrHUC+YtY
	yfO9J3nJaR7eqn1T9VPuW4s803MI7+9JvsokktViBAJOThlGIVpHJtDilhQZBIMZ
	zzmv85k2PqGCO7bzc5fy4n5nLHq9g9VMP1ZGRYzASe+HyHNJNzZcFbZPo14XqPTc
	5zERuFQAxHMMhqlRX1yTvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727777656; x=
	1727864056; bh=HXR2QcSCZYhKWAgjXQ/EtjfjpyVOtezYsMtyKJLf9J0=; b=Y
	HnpSbZCm1gP/OyQylOjjwPM7jwjjC5IgW6z8xsNphiqekIaAbmQGFfN8OpQw4NHy
	40EnXcDs809uA7tcj63nzsQ5PR/twNubeQDllqOQqF4A0izBNYzLPvpgzmbStuha
	okQzzzsj1vf0RgQN4fuGpb4sWr0CiBFprdltm8c9Dz9zggyQyMeW7kuKe03q6XJ3
	HFnhlnVruBwd+U2SyFsxj3AGAFlwyIME27ghtmebEuLPHc65+DKR/OiiPjDQfVnT
	0M+2X5tCbivA80kefVIWDKBMuQDemfJS/XjWKRt+BP149EQ7h4pcx39dV4QtVyOy
	f6QKQiyJk8b4tPTSrM8qQ==
X-ME-Sender: <xms:eMv7ZmFCdrJo4L7qRgAblu5LKh8vOnu5lXs0yDi4VW6XCSU5pECf1A>
    <xme:eMv7ZnWFX9NH26vAgDg0NANRurApgtPiQAhihoxICpnGzbSPqBg4BLrdv8CDjMc2s
    eL7BxiUi8Vzid9YLw>
X-ME-Received: <xmr:eMv7ZgJJz0atb4eIF06hqOXPmt08bojikoT4WI-a6w2vBxYV1fTZTtrovKruiEoVzyfz_g_iBL23SFbfEGYD-NKk5rDXBcV94p6c1LRKTrPUUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:eMv7ZgFOlbAE21wDrP6_b9zPhN5Cha4x0PH-FsJp-LSOmwJJ771DKQ>
    <xmx:eMv7ZsXg1laQeEnzq6vwTr1nStEFS0RD8TxaTnIrHBDtjQr1NesL7w>
    <xmx:eMv7ZjNO8ZNCj8QRJOL4pAdrOaFp4LJwh-b84ORD4oExxAKMNM6m5g>
    <xmx:eMv7Zj2voY0s5JuDJGEUIlN4AgPgTB7XSdGwXiDCAAvr4nRgVzpm6w>
    <xmx:eMv7ZvFWubWN6BiEy1who2TMXQ69aQbnckr5xmEkyFgqITyciwSeMGTO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 06:14:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 705020f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 10:13:27 +0000 (UTC)
Date: Tue, 1 Oct 2024 12:14:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
Message-ID: <ZvvLbXskyA4V0gM3@pks.im>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <20240910163000.1985723-4-christian.couder@gmail.com>
 <ZvpZy9XMpLI0DQQg@pks.im>
 <CAP8UFD3+YVE+pgGtSP6gDDN9=-0acuJCnDamWjeCX-g5aqTp3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3+YVE+pgGtSP6gDDN9=-0acuJCnDamWjeCX-g5aqTp3g@mail.gmail.com>

On Mon, Sep 30, 2024 at 03:28:20PM +0200, Christian Couder wrote:
> On Mon, Sep 30, 2024 at 9:57 AM Patrick Steinhardt <ps@pks.im> wrote:
> > So I assume the intent here is to let the client add that promisor
> > remote with that exact, server-provided name? That makes me wonder about
> > two different scenarios:
> >
> >   - We must keep the remote from announcing "origin".
> 
> I agree that it might not be a good idea to have something else than
> the main remote named origin. I am not sure it's necessary to
> explicitly disallow it though.
> 
> >   - What if we eventually decide to allow users to provide their own
> >     names for remotes during git-clone(1)?
> 
> I think it could be confusing, so I would say that we should wait
> until a concrete case where it could be useful appear before allowing
> this.

I think we've been talking past another on this item. What I'm worried
about is a potential future where the default remote isn't called
"origin", but something else. I for example quite frequently rename the
remote right after cloning because I add a handful of remotes, and
"origin" would be too confusing. So there is a usecase that may at one
point in the future cause us to make this configurable at clone-time.

Which brings me to the issue with the current design: if the remote
dictates the names of additional remotes we basically cannot do the
above change anymore because we have to assume that no matter which
remote name is chosen, it could already be used by a promisor remote.
Our hands are bound by potential implementations of this feature by a
third party, which I think is not a good idea in general.

Now I'm not against advertising a name and storing it in our config when
we create the additional remote, for example by storing it as a separate
key "remote.<generated>.promisor-name". But the name of the remote
itself should not be controlled by the server, but should instead be
generated by the client.

> > Overall, I don't think that it's a good idea to let the remote dictate
> > which name a client's remotes have.
> 
> Maybe a new mode like "KnownURL" but where only the URL and not the
> name should match could be interesting in some cases then? If that's
> the case it's very simple to add it. I just prefer not to do it for
> now as I am not yet convinced there is a very relevant use case. I
> think that if a client doesn't want to trust and cooperate with the
> server at all, it might just be better in most cases for it to just
> leave the server alone and not access it at all, independently of
> using promisor remote or not.

It's not only about trust, as explained above. It's more about not
letting server operators dictate how Git can evolve in that context and
not taking away the ability of a user to configure their repository how
they want to.

> > I wonder how that is supposed to interact
> > with clients that do not know about the "promisor-remote" capability at
> > all though.
> 
> When that happens, S can fetch from X the objects it doesn't have, and
> then proceed as usual to respond to the client. This has the drawback
> of duplicating these objects on S, but perhaps there could be some
> kind of garbage collection process that would regularly remove those
> duplicated objects from S.
> 
> Another possibility that could be added in the future would be for S
> to warn the client that it should be upgraded to have the
> "promisor-remote" capability. Or S could just refuse to serve the
> client in that case. I don't think we should implement these
> possibilities right now, but it could be useful to do it in the
> future.
> 
> > From my point of view the server should be able tot handle that just
> > fine and provide a full packfile to the client. That would of course
> > require the server to fetch missing objects from its own promisor
> > remotes.
> 
> It's what already happens.
> 
> > Do we want to state explicitly that this is a MUST for servers
> > so that we don't end up in a future where clients wouldn't be able to
> > fetch from some forges anymore?
> 
> I don't think we should enforce anything like this. For example in
> corporate setups, it might be easy to install the latest version of
> Git and it might be a good thing to make sure the server doesn't get
> overloaded with large files when they are supposed to only be stored
> on a promisor remote.

Partitioning the Git userbase depending on the Git version they can use
doesn't feel sensible to me. We have been able to get by without
breaking backwards compatibility on the transport layer until now. So it
would be too bad if this new feature would break that.

Also, the argument with a corporate setup cuts both ways, I think. If
the administrators tightly control the Git version anyway they can just
upgrade it for all clients, and consequently all of the clients would
know how to handle the new capability and thus the server wouldn't be
overloaded.

Patrick
