Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B681922D9
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875939; cv=none; b=eotL+RNetPEeHVeevdqlVxKz9lQLyXbSHe1M5EmS410msKTLC50TzkG1Ws65ti/JOcT0U8ZSVQFixn4RFnTT4S3meEy585iwHCiULG8VWIKsBVrh4Q9zirqb4I7UhtH1kferQWSmcpdx/y4nditixcAo3AFnEISv5EVMMDEoJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875939; c=relaxed/simple;
	bh=cP7Qtcltzijafw7OM+p9BRDfOyK6HQ2yYdA78lBRzoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl/DJIr+0oFrT0CUlK3Gy3RtMGFFD/trkhcu1ORb1Ke+bWDD+7bgZo2YcCLESGUrHRREXwfypw5J7GYNxTgK5mLsPTgC5eyvnpFgXd5Wn5YIN0VnKgJoQLvqhLTReX69aSOU754PaOM7fW6UKGMniV08O44zDkXpsReeGJHatUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A6/QUh7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9h5Rn2/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A6/QUh7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9h5Rn2/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A505413801F4;
	Wed,  6 Nov 2024 01:52:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 01:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730875936;
	 x=1730962336; bh=7cBxtMj4JeLkXo8FbxWfBWcXNvO2zBTQi0yT6eIRDxs=; b=
	A6/QUh7Qvf7WunvOl7Elvz5+FuQI+xcqdE3eCafATdhRoFjZylq55CjRPAMnrWpN
	W3jDU1c2UmBgviBSrCLKHBAR0/l0M/OJIc5dzpOgOJTKV5teJIFgMsBpacDpo+Zi
	epyekwBBBbbiJhM+or38p5PAMZkjUzCwlc8JY+Z2dd+ToYdKUfnNGvyWGeMnahqh
	qi0ZjU9kXceit/MVKnVB0V9rhndEnwm3opIyRo0SLbTKXjDh6MX2NYjo+NWdd/ig
	hB48lAheeLKQp+deJ1sN93UGFVXseJ8wcWNYE12uMk3rw6DDlOQ2jssQEYxIi2aF
	2uHxc1FfjHMb6j5AB7/VfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730875936; x=
	1730962336; bh=7cBxtMj4JeLkXo8FbxWfBWcXNvO2zBTQi0yT6eIRDxs=; b=d
	9h5Rn2/cY6RetRFOaE8gReMBzC1JjnRgDYFVzrfBbP3Ib6ulTbkOwJfyw6BTpU8G
	p3U9970K7U25UySvFskQjGWAHmAwbwxErrbV8RM0gKtaeRnzJv4X6TlVJI2dbHJB
	/PZSYFEbknJgXNhV7B0uxo8Dweq3XjWhulN0e7qiFhshpQw2gGguygN5cd+/JFfu
	4LN19Y8FrknM8gK6TYXriB8GCJgQBAhai3zqifJztroxO1Bi8vcPypIHvESOxKrR
	DceGJwBGSTW2rRLq8Jspxxf6vrSaak3BD26cgAJemgCokXCs9eeSsx6e9NXQ1bL6
	0ymZt7qpyXo1j+aSbBQCQ==
X-ME-Sender: <xms:IBIrZ7ZrbxsGEFB_UBmUqCmDC3XSbQqn-OAnR1BruieWPkZs2l0fnw>
    <xme:IBIrZ6Z89DBIF1KfHEv9dwjRUOsV4kVPMq2fV9DFE5aLS5MXISx-V34ozc5Ik4RRi
    VmvxNhPnPUL14bm1w>
X-ME-Received: <xmr:IBIrZ9-OflRvIrz835VtAo8nJVYk_clsB1kaQMN4qxIk8PftTugFXd-I9qpeXEOGjCJHBGJXqzTdU6BIgF8NpsC7gnSB4ajTrEsl5CMlIgc-OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdegueeu
    keetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    hhuhgshhgrmhdrkhgrnhhoughirgdutdesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IBIrZxqbtgp7_bQ5CxrijXdwUgq-zuW-bgvGYJ3FJ5LEgpc54CIX4A>
    <xmx:IBIrZ2oqVWOoFC_omloXihBd-T_0V9fsdSIuf-iDurVbbEF6jMHlFA>
    <xmx:IBIrZ3Tn_FVespw5K2mFBHQNGpqZ_X-si4DMjzoOJXC_sSVVnokZ7A>
    <xmx:IBIrZ-pVLj6ttwO4Bq-BQZlWz4fXpd9iNNFleOCcTQ7RGbpY6OgRQw>
    <xmx:IBIrZ3cqB5D8tPLOJZN8bhVSLRpTeBD0GiYvEulIBallKi9nwNBv9kyG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 01:52:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f3a661a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Nov 2024 06:51:50 +0000 (UTC)
Date: Wed, 6 Nov 2024 07:52:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
Message-ID: <ZysSEJUqSKUq4PKb@pks.im>
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
 <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
 <Zym--GVNJt_lsQEz@pks.im>
 <b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
 <CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>
 <xmqqy11xqjpx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy11xqjpx.fsf@gitster.g>

On Tue, Nov 05, 2024 at 04:39:06PM -0800, Junio C Hamano wrote:
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
> 
> > I don't have a particular preference here, and this was discussed in
> > an earlier thread
> > where Junio opined (https://lore.kernel.org/git/xmqq5xrcn2k1.fsf@gitster.g/—
> >
> >> I agree that it is the right place to configure this as attributes
> >> to remotes.  It would make it handy if we could give a catch-all
> >> configuration, though.  For example:
> >>
> >> [remote "origin"]
> >>       prefetch = true
> >>        prefetchref = refs/heads/* refs/tags/*
> >> [remote "*"]
> >>        prefetch = false
> >>
> >> may toggle prefetch off for all remotes, except that the tags and
> >> the local branches of the remote "origin" are prefetched.  Instead
> >> of a multi-value configuration variable (like remote.*.fetch) where
> >> we need to worry about clearing convention, we can use a regular
> >> "last one wins" variable that is whitespace separated patterns, as
> >> such a pattern can never have a whitespace in it.
> > which is what my implementation is based on.
> 
> I am fine with space separated list or multi-valued variable.  The
> only difference is that with multi-valued list, we'd need to worry
> about ensuring that we have a way to "clear" the values we have seen
> so far.  It has plenty of precedence and is not a rocket science.
> The above, if I recall correctly, was solely about the need for
> "catch-all default" (aka "*" remote) and not about multi-value vs
> space separated last-one-wins value at all.  IOW, the above could
> have been
> 
>     [remote "origin"]
> 	prefetch = true
> 	prefetchref = refs/heads/*
> 	prefetchref = refs/tags/*
>     [remote "*"]
> 	prefetch = false
> 
> and conveyed exactly what I wanted to say in the message you quoted.

Ah, I missed your mail here. I replied to this bit in a parallel email.

> In any case, I somehow thought that we discarded the arrangement
> with "*" wildcard as unworkable.  If I remember the discussion
> before I left correctly, didn't it turn out to be troublesome to
> have [remote "*"] section because existing code would need to
> enumerate configured remotes, and we do not want to see "*" listed?

I wouldn't say unworkable, but it certainly isn't as easy as just adding
the new syntax.

> If we found a workable solution to that while I was away, that would
> be great, but I haven't looked at what this latest round of the
> series does to solve it (yet).  Perhaps teaching "git remote" and
> "git fetch --all" to skip "*" while enumerating remotes was
> sufficient?  I dunno.

So yes, we'd have to teach Git to ignore "*" remotes in many places. I
would hope that it isn't all that involved and that we only need to
adjust a couple of places to ignore "*". But the remote logic is
somewhat outside of my area of expertise, so my hope might be misplaced.

If so, we might think about using a different syntax to achieve the same
thing.

Patrick
