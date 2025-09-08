Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA1747F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313859; cv=none; b=CKBCO6rXX4z0giafyd5BhvVifBJ0Ngv3o4JursIEbtp1ezIwzF/Isu4Y2RJMm0XQDJKvSiYtfrn/jd0KOoL5SZ+DTnsxOeqs5PB6yT9oo5F0VtnGUpGHfR+eUX8AAlqxM6PvOVGivSAcLxkUYrvEkBODX7C+X/AhOBSzG4A6Xc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313859; c=relaxed/simple;
	bh=WiLUvLFl8c2apWsbNpOgfr9y4h9Ek/TS53qqb4bMIg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNFiDgdwaXBZ6S+gR3bzUcU02G+aB9Ppksg6wt7cpi2Bdd/EvHShVUlCqpOFjD8AnwddrJ1vu3uD3VAA/7QWsBoy6csDQyS/+Ew8w9rZnk7+SQoLulmXDzs0iWV2L8nO4q12Dz+MBMtvVESf4tdrNby1b2xHKKUPPVD/Fx+GI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qPJq9dZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4AZmXHO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qPJq9dZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4AZmXHO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A9C61D0012C;
	Mon,  8 Sep 2025 02:44:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 02:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757313857;
	 x=1757400257; bh=XV+dRDdaMMknMiCaLHro64OiUH69PnGO5ra6PJJks/k=; b=
	qPJq9dZJiKdu0/iNlXAO7sSnUq3+kaB9AemfSGyakuQlh2H3zS4DS62xmWDR8gDR
	aNG/W1oaajczyD6x+xU2/t5Pz5OHNl521h6uw3mSh1ZHXXuc0D+rnCUZQQgqhDvD
	VycU/0nsPiUuFKtIBWVu6JzDRYW4axsLAnu7lwtgenw1BYztUtFKttgiv3KUkzK2
	7dmoU1GNYYt4eHeHX+NenJ/X1L4PjVH3Hkpaf5v9ykwTOfB+dLHcLNq6FJqkPLC9
	pghJFMgzIuAWFojsjMACcrGoWGmoojkxuPtMwvwfS8EROGXkhkkezA+smESBULsE
	rWP9ieP+goccOBBVVvbsew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757313857; x=
	1757400257; bh=XV+dRDdaMMknMiCaLHro64OiUH69PnGO5ra6PJJks/k=; b=Y
	4AZmXHOksq2rAtSEPNjqCFJ7QNKdOuz9QdZBoCw5sfuIKVThh1W6nwjky7fHSH8Y
	jey1jQIPsEeGeup19u+BqRz9GK4vzJ3QMYyEljNVGBY0255MdzgKqy6E4GVdds+h
	0nydLkTd46uPF7qmg59+6YbqS/56gU1VqLc7lfZRgiNmqlmlmjlu5Wm9egvQNK9V
	V+juOjisQcnua8l90yNVfIOQDj34ZwWfZwjO8/jwjL4o1yF3mkw9J460Pq6m9zqC
	Xe0f+hgtGR/+3eAogjHZts29J3Wmm4f9fB+5PdCsUkgHBCamK1am4Zy6zZ6ZPgLG
	jcXxZulkp/eNbk/cN+itw==
X-ME-Sender: <xms:QHu-aKbyLBOE1Y02ritBnapWPC4KcSdiFYsTjwpR2bc--msy6PsPGQ>
    <xme:QHu-aJMU890LlBWAtFMbkFnj1hlVoLhzAESpnJ2Q2HILRhdGthZkw0uy23o2CQ39J
    twvXrtfQV77zFIrlQ>
X-ME-Received: <xmr:QHu-aLb45nFTA3uwmFthMRwu1qt0Y_1O06bUxCfpCuyQVE-Z06SP_5w40w3rg3v96uPya0CI9LUlC7ocMZilkjOA0TSRF_uK7HJynz0IvHfIpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvd
    ehiegsihhtrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdr
    mhgvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    holhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrgh
X-ME-Proxy: <xmx:QHu-aJVuvrJyySNBh0AIVWGzPRbI9XFFh84BXdRdp0p1huOwWzAJXg>
    <xmx:QHu-aKBmdY3oZ92I3bcGLGsnix2LNR2Wk7It_eHfNpxgpeWJ1i8KbQ>
    <xmx:QHu-aFLik3H-ygEQ5xLyJpeI-_PE65R4zKpCBo8WzLzaQ4cgmiVBbg>
    <xmx:QHu-aIvYdk8lC8Y3FD4IYHq4jsAQJegWsk43DesUFqNJ8geCxt-BnA>
    <xmx:QXu-aGIh7L2gUHNrfcpNW8MgpY6UNUlOM33j5lMuBNIBaEu7jzrqtT9D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:44:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27cfe55f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:44:12 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:44:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
Message-ID: <aL57ONmEKTmqFhIZ@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
 <aLrzqR2Z9jz5CuJu@pks.im>
 <CABPp-BGpdEP9+CTApknmGNO=b=66bFKVzWL2s3gmgCMtTBTjPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGpdEP9+CTApknmGNO=b=66bFKVzWL2s3gmgCMtTBTjPA@mail.gmail.com>

On Sat, Sep 06, 2025 at 09:31:02PM -0700, Elijah Newren wrote:
> On Fri, Sep 5, 2025 at 7:29 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > It looks like this version does include the necessary Makefile changes which
> > > is great. I do think though, that for the test balloon to be valuable, we
> > > need make building with rust the default with an error message that tells
> > > people how to build without rust if that fails. Otherwise it is easy for
> > > people building on platforms without rust support to miss that we're going
> > > to be making it mandatory soon.
> >
> > I have a plan layed out in the BreakingChanges document that mentions
> > how I'm proposing to do the transition:
> >
> >   1. We introduce it with auto-detection for Meson and default-disabled
> >      for our Makefile in Git 2.52.
> >
> >   2. We enable Rust by default in case WITH_BREAKING_CHANGES is enabled
> >      in Git 2.53.
> >
> >   3. We always enable Rust by default in Git 2.54.
> 
> I don't see how steps 1 & 2 help at all.  We now know we want to make
> Rust mandatory eventually, and should provide distributors and
> platforms as much notice as possible so they are aware.  But what
> you've proposed is another libgit-rs or libgit-sys -- an optional
> component that no one will know about unless they go looking for it.
> I don't see how those two steps provide any incremental help to
> anybody over what libgit-rs and libgit-sys have done.  From my point
> of view, Rust should be enabled by default in Git 2.52, with a simple
> knob provided to let distributors/platforms/users turn it off and
> build without it.

It helps because it allows us to slowly build out the infrastructure. We
don't yet need answers to every question that we currently have if we
initially have the Rust infra default-disabled.

I very much expect that there'll be some issues with our initial first
steps. So I'd rather want to avoid to expose developers or distros to
these issues directly, because that might train them to immediately
disable Rust right from the start.

> >   4. We unconditionally enable Rust in Git 3.0.
> >
> > This is basically gradually tightening the screws, which both gives us
> > time to build the infra and gives downstream time to become aware of the
> > change and adapt.
> >
> > I think making it mandatory in Git 3.0 makes sense because I also
> > propose to make the last version without mandatory Rust be an LTS
> > version. And if we connect that with it being the last version before
> > 3.0 I think that's an additional benefit, as there will be other
> > breaking changes in 3.0.
> >
> > In the end it kind of hinges on when we think we want to release Git
> > 3.0. If we can agree on the above plan, we could also think about making
> > Git 2.55 become 3.0 instead. That'd be in a bit less than a year from
> > now, which I think is a good timeframe for that breaking release. I
> > personally don't see a reason to push it out into the future for way
> > longer than that, and it would be good anyway if we built some consensus
> > around its release date.
> 
> I see your plan, but I agree with Phillip that I don't see why it
> makes sense to lump the Rust transition with the 3.0 transition.

I don't necessarily think we need to do it with 3.0, agreed. But as
Junio mentioned [1], 6 months feels too short for him to make Rust
mandatory, so we're realistically looking at a period of at least one
year to make this happen.

So it felt like a good match to tie these two together. The primary
motivation is that other breaking changes that we introduce with 3.0 may
cause minor inconveniences, as well. So that means that we help not only
non-Rust platforms with the proposed LTS release, but also potentially
others.

That being said, I really hope that most of the other changes should be
rather uneventful. I don't want to create a Python 3-style split.

> Setting that aside for a moment, the idea of Git 2.55 becoming 3.0
> seems like a good idea to me, assuming that doesn't rush brian on the
> sha1/sha256 interop (since I think that's probably the paramount
> feature of 3.0).

Yeah, the interop is definitely an important factor and the last part
that I think is still missing for Git 3.0 to become viable.

Patrick
