Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9017995E
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875603; cv=none; b=J0piO2gib2YgAKrUcml13bArPmLDUIhXEGzO2LRijtLq/IzusaoZjBcgfQAdMNIWebMFpAky/QOGYIpiU8Q5xEYTq0wmyUU7aa6LeJInbQ3NyCMSv2g/+kVgZgoIor8gAdkDzpLOHnIa6awY2aeOFvLWYrOydlSmHBvrq7eWKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875603; c=relaxed/simple;
	bh=7XmE/GvxjXcHGSbS+bBz+OHk5xHz201xnlXtWdgmNwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMBOF2HA6UN1ePHyHIpha09/TksAj+j2C2bKjF3MXaaU1IAFjBU9xXn97epNfAW2cp6zI950a1FaCEafymvEZri/7aL/4bFgvgdLgNsyxCCfbQY8/+Pl+SDmUPhi4tnWQIGmhZTNjhTDEuoRr7hh7gMl6ht2Up65c2bWZGfCQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=beiY9Ler; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWRQWgKj; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="beiY9Ler";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWRQWgKj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A8CFC1380218;
	Wed,  6 Nov 2024 01:46:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 01:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730875599;
	 x=1730961999; bh=MzVEBdXCiXL6WCXwwBd5LVjv2l0rc0+wy0X7eGSwzxo=; b=
	beiY9LerbtbS27IHHhD1bG7KBVXJsOIXH6fuems8OEEam0pXe5EqvPoZNIUHQqw8
	h+WH0XgPkNrfsu3ewXdSXvAc9ugryXEFw0yX5YbTjSILUa/63IdxX72kmsq7j2an
	rPHpYzZ3qFGjjxgqlj1c8qk0iG8aCk3GraFOzzX4RKi7VbD7OIz5k8m5N8tf/+LV
	DGwX9fpW+Ti0/6YVUnY4UtwW2KLjeLRg7ZcilSCkmlDL6ILesDYVkwjXfRwwO69E
	Q31bkmDEQFmBKy/jiKkfo5sVO3w/sR0wB8x4dnq6W5wXLnYFOqOuvRdT0uOIZqZS
	icbf3lI9YZx7iujbcYblew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730875599; x=
	1730961999; bh=MzVEBdXCiXL6WCXwwBd5LVjv2l0rc0+wy0X7eGSwzxo=; b=l
	WRQWgKjPZ5E8izpuWFlhulfl4nAs1qVXWdl6xXJ9Ivddmv7M/9qVe+vHUaY5kWEd
	bQvh1voATW98/W10+VdSIeQZYuevgfP2okRT5t8SEgW6beh3LanTtxRAXBUAfL8c
	hC1wS740D2qiMpH83gyxqWT1Cx3F2B0DcYTNQfMYpCdswxUeB3HJYS/DRWKrNk9h
	I3GQErpYHjG6eSAJMAZvXM9MGgCyGW4KCfPboNdm8vednBXEL3eo7oXIbdG5XXld
	THXdDhxKGnzI9l0nQnO2PeTcudgXJYMz7yAyMxzjbXaBh+fpi1l7MIUptxNu6HX7
	4awL70zNjAgvEBcfhkTgg==
X-ME-Sender: <xms:zxArZ4HmrKwyGBCSg9dkAJQ-1dctf3H5L2eLIERcEULShb-NA1vcOA>
    <xme:zxArZxUnmIFBYk1gU6UZV_lCxatHuplBgCXQrFK9x8JrUyxr_S8nBf5tBr3Vd4njt
    z-jEfCtcKXa2uXrhg>
X-ME-Received: <xmr:zxArZyLaoRX42V6VTe8o3-c3-YC-UIlgeZ2OTT1WLWHogT0817c1jMN7oXKzEJrj7KQY1r3aQ5_cs2usanA4QPOsRJROFjwoyI57CUUCyDXleA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdegueeu
    keetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehshhhu
    sghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zxArZ6HYH3jtIOV7XKevEKEtM8Tx8nive6pw62-GMs7JS73IZE6jbA>
    <xmx:zxArZ-Wm31AS73OQ_Ty_kvFhFO0UtavWQk2veVnz1LOu3QY0pDNzDg>
    <xmx:zxArZ9NpLlH1ZgtL-rtiWkbjCOpLbzuItQuH6RGrhbHNnVcfehW8wg>
    <xmx:zxArZ10y-D79ngtvO2rkbH77sLWeG49bE4Gs00b1Dg0gWhaSaVyAIQ>
    <xmx:zxArZwLulK-5CJX3hvtZ41PHGWJMI9jYD9vbWcJBqxPBovm62kSKn-9j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 01:46:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4988cb0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Nov 2024 06:46:11 +0000 (UTC)
Date: Wed, 6 Nov 2024 07:46:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
Message-ID: <ZysQvUyxgdRqjvj2@pks.im>
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
 <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
 <Zym--GVNJt_lsQEz@pks.im>
 <b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
 <CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>

On Tue, Nov 05, 2024 at 09:56:52PM +0530, Shubham Kanodia wrote:
> On Tue, Nov 5, 2024 at 8:17 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > On 05/11/2024 06:45, Patrick Steinhardt wrote:
> > > On Fri, Oct 04, 2024 at 08:21:32PM +0000, Shubham Kanodia via GitGitGadget wrote:
> > >> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> > >> index 8efc53e836d..186f439ed7b 100644
> > >> --- a/Documentation/config/remote.txt
> > >> +++ b/Documentation/config/remote.txt
> > >> @@ -33,6 +33,13 @@ remote.<name>.fetch::
> > >>      The default set of "refspec" for linkgit:git-fetch[1]. See
> > >>      linkgit:git-fetch[1].
> > >>
> > >> +remote.<name>.prefetchref::
> > >> +    Specify the refs to be prefetched when fetching from this
> > >> +    remote. The value is a space-separated list of ref patterns
> > >> +    (e.g., "refs/heads/main !refs/heads/develop*"). This can be
> > >> +    used to optimize fetch operations by specifying exactly which
> > >> +    refs should be prefetched.
> > >
> > > I'm a bit surprised that we use a space-separated list here instead of
> > > accepting a multi-valued config like we do for "remote.<name>.fetch".
> > > Shouldn't we use the format here to make things more consistent?
> >
> > I agree that would be a good idea. I also think that it would be helpful
> > to expand the documentation to explain exactly how the patterns are
> > matched. I think "remote.<name>.prefetch" would better match the
> > existing "remote.<name>.fetch" and "remote.<push>.name" config key names.
> >
> > Best Wishes
> >
> > Phillip
> >
> 
> Thanks for taking the time to look at this!
> 
> Let me add context here based on a few things that have already been discussed
> as a part of this thread or an earlier discussion on
> https://lore.kernel.org/git/CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com/
> 
> > I'm coming rather late to the party and simply want to review this so
> > that the thread gets revived. So my context may be lacking, please
> > forgive me if I am reopening things that were already discussed.
> 
> I don't have a particular preference here, and this was discussed in
> an earlier thread
> where Junio opined (https://lore.kernel.org/git/xmqq5xrcn2k1.fsf@gitster.g/—

Fair enough, thanks for the pointer! The reason stated by Junio is that
having a space-separated list of refspecs makes it easier to reset the
refspec again, as we can simply use a "last-one-wins" pattern. And while
I understand that, I would claim that we already have a properly
established way to reset multi-valued lists by first assigning an empty
value:

    [remote "origin"]
        prefetchref = refs/heads/*
        prefetchref = refs/tags/*
        prefetchref =
        prefetchref = refs/heads/*

The final value would be only "refs/heads/*" due to the reset.

So overall I'm still leaning into the direction of making this a
multi-valued list for the sake of consistency with other refspec
configs. @Junio Let me know in case you disagree though.

> > I agree that it is the right place to configure this as attributes
> > to remotes.  It would make it handy if we could give a catch-all
> > configuration, though.  For example:
> >
> > [remote "origin"]
> >       prefetch = true
> >        prefetchref = refs/heads/* refs/tags/*
> > [remote "*"]
> >        prefetch = false
> >
> > may toggle prefetch off for all remotes, except that the tags and
> > the local branches of the remote "origin" are prefetched.  Instead
> > of a multi-value configuration variable (like remote.*.fetch) where
> > we need to worry about clearing convention, we can use a regular
> > "last one wins" variable that is whitespace separated patterns, as
> > such a pattern can never have a whitespace in it.
> 
> which is what my implementation is based on.
> 
> > This is essentially open-coding a bunch of logic around how we parse
> > refspecs. I'd propose to instead use the APIs we already have in this
> > area, namely those in "refspec.h".
> 
> Is there any that you would suggest? I don't see anything in `refspec.h` that
> might cover a similar logic. I'd previously used `wildmatch.h`, but
> that is really
> only suitable for glob-style wildcards.

The logic around refspecs is somewhat split up between different headers
indeed. "refspec.h" really only concerns parsing of refspecs, but does
not provide the interfaces to also use them to translate or match refs.

I think the closest to what you need is `omit_name_by_refspec()`: you
give it a refspec and a refname, and it returns whether any of the
refspec items matches that ref. This also takes into oaccount whether
the refspec item is negated ("!" prefix") or whether it is a pattern
(contains "*").

Ideally, we'd move interfaces that provide basic refspec functionality
into "refspec.h" so that they are easier to discover. But I'm fine with
making this a #leftoverbit, I don't want to push the burden on you.

Patrick
