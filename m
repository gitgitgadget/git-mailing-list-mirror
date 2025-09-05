Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2D2F60CD
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058855; cv=none; b=jICrdOHsYrHDr1mOm5hqwWwPKBTrABeMhkTrDkkNTKfN+NbcZvMjATkzbXiADzM9PcEeCVtWBnyjE2eb1RFqZaokZ8H3g4JFUnAUINsAKCPSEUNWPKklpMJUOD9DOiMMS1YIE71QXnwF5tyxvhm86TywbOBABxAAQs7qDsLx8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058855; c=relaxed/simple;
	bh=BCrITP8RLxZ1L/QnUnOs/4YtuY0aKtJ1P8hpc1v4sTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON/vDm6mV0THw1Twvdlf4c5I65otABycfKs8fTFGReSXwmKfcERjISVudpqF9xLwZUyJeQvi2+8QBPPscA/dEPSi9z8YecXoYEl2/QaTqUjpiAJgDOcGOv0/IWbyHWFBaXgXfYM4Mod5Dh7vY6uvsfBZTl17sIivJMDcWODHg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B+6WJwgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k68u6JoK; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B+6WJwgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k68u6JoK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 795457A017A;
	Fri,  5 Sep 2025 03:54:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 05 Sep 2025 03:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757058852;
	 x=1757145252; bh=xTjZAFZW74KXGrH+ShOYQ4KuMRrery6YlnP1fcIsBh8=; b=
	B+6WJwgB8nLqE49l0wHHFM86YCq4K8MlJmFfJarCfOgb+i5hiXZ0St7SOr3khDUH
	aMmvEfOjjZT7I8Jd42+H7b5B+sFdNlJMuFnnhOx+Uue01KzlJ53uQSS0Xh/V5mce
	5KabEFm+KY5zxiL3r451zu8EQo1nASlkKSGRHrMHUt5JnyMvsc6iQUZooKI3CK5U
	3/JhbtQ66N3iFTXPbNOMTw8xcC4V3XfxM456d9gMBEx2p5IRzI2L/nOWrzpWL3Rg
	PWGuOlsOcOP9H+EHy+fofy2UwmBlfkJDdx/uPzPXhu4nTTOfco+lMCAgEGYLxCZ2
	krGYi+pk1Ogu83TSQBmrwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757058852; x=
	1757145252; bh=xTjZAFZW74KXGrH+ShOYQ4KuMRrery6YlnP1fcIsBh8=; b=k
	68u6JoKxcN2yPgLRHJJn2CyLcdK84bhYCHOKidtJiPJPtS8r0Pqy8eyb6Z/buKgG
	eMZtMiXy2YYHsCIkJ2fAqkAIPOYu7Vm3KXpnWJud87gEFCxRK9uaEcQMGf1O7i50
	of+aBh2loagXnrvy73tftBKGYXfdQjtZSVKSe1FOJhyZwcPccczJQ+ybJ1chyCHR
	F50M9o7yRvRw/TuCDDVCtGYZvj/ALDTfsq5GS2D5b3wZW2xaOUMTWM2/ESu1vnC9
	3EXVzmcR6zPc4OxExyevwYhwjReMIBmffnGpsxk658iW5bOpBfSqdPJj8+8JfOnG
	vugKGQcYKrW917ugan0Rw==
X-ME-Sender: <xms:I5e6aBq7YYxTi73n121efigmoGTKa3MkCNsRYXcx1YhRF9HdQrvAEA>
    <xme:I5e6aDyXad7wl3XdUPmzSAcZFTpXQi5KeEiAhtXfsC7bpPpJ5lXbL7ct8yl5UYdl-
    Ss8RHPJhpKfYfsz4A>
X-ME-Received: <xmr:I5e6aFphWovexGA9uEZkbbYhphCOmiv5pTWzCJsrdtZU3GENr8dgw0HLL37sc4DB2QE-XqF1gfRTvxOslSCoDXWDYyqkz2ra-8xN-G76tzti>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsrghm
    sehgvghnthhoohdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhope
    gtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:I5e6aDfvsACNay-vQRmvqQJAuVkw99sqMGVr6nXwV3dCQO4nUPwOuw>
    <xmx:I5e6aIpoXJZgRy9odoJ1bLkeSCpzsxWImug-7QFToX7Yb1v7ayv6fA>
    <xmx:I5e6aNmDp6pTEL0cbQtsyDt9WS-ybMFSWjLHMcL_I5795xXNAgvz9Q>
    <xmx:I5e6aJSMfhczxV1Kd0GEABlTzc4M-Mar8H6cCGYvVuGdLL1HoRMEWw>
    <xmx:JJe6aC89naTuy-B0hCxbcedReV9O_Kgzr1etto2BO3rXQWWu5fmcfOfo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:54:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e4e3e1f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 07:54:09 +0000 (UTC)
Date: Fri, 5 Sep 2025 09:54:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
Message-ID: <aLqXHYb2jZpCKzp7@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
 <CAH=ZcbANoa8Qjbz4OmdZatBi5b+RQVnatF+7pmffA4SQh=EFCw@mail.gmail.com>
 <85b9def3-ae1c-4535-9d56-be6f08eaa8d7@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85b9def3-ae1c-4535-9d56-be6f08eaa8d7@gentoo.org>

On Thu, Sep 04, 2025 at 10:00:45PM -0400, Eli Schwartz wrote:
> On 9/4/25 7:39 PM, Ezekiel Newren wrote:
> > On Thu, Sep 4, 2025 at 8:27 AM Patrick Steinhardt <ps@pks.im> wrote:
> >> Implement a trivial test balloon for our Rust build infrastructure by
> >> reimplementing the "varint.c" subsystem in Rust. This subsystem is
> >> chosen because it is trivial to convert and because it doesn't have any
> >> dependencies to other components of Git.
> > 
> > Huh, I thought Meson couldn't run Rust tests. It's refreshing to see
> > someone else try a different approach on bringing Rust to Git.
> > 
> > There are a few reasons why I picked Cargo instead of Meson to build Rust:
> >   1. Needs to work with make.
> 
> 
> If the rust code is defined as a crate, meson can auto-import that crate
> via parsing Cargo.toml, so perhaps this can simply be done by creating a
> 
> [lib]
> crate-type = 'cdylib'
> 
> and... importing it as a meson subproject. You'd be able to build it
> with cargo build, if you really want to (and the Makefile may have to)
> but Meson would not be limited to this.

That sounds like a sensible thing to do. Just to clarify, this doesn't
need the experimental Cargo wraps, right? Is there any documentation for
how to set this up?

Patrick
