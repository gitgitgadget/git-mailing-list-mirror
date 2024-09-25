Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F541876
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727238978; cv=none; b=QN2nlDFDSYgxpqT9SAgdKo7Ggv5ESHPLPawMJvuha/VORJhVqNmhY+O6gJbSPgnxgcYULvuTGOI7QhFieoXjHZJbpCDh4RcuZ2dNgXGIGE2A7NTUBW8deLc7h0657OXPbi91uW4Q5jl2WrcteG4YG9CKHmjkYOOEavcrU/K7mtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727238978; c=relaxed/simple;
	bh=nYM4PfEb/kdShoi6U2pWZ8ZlAipp+78AdSny6TNmOnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6TfgU/wGWp8fFicARAUnKMdbak+ntheTvSV/Ae5tUykw8TdeydJM5F5kN5KPBf4Jhf2pvGTQlQxlvk8L5sM+w5Uw8Lva0UuWI/QJwcV8szACgxzlRgabgfUhlAUy1j4Zf7+NnUTZXuQwToayWE9b07AiZXQUkq5Nb3oTvWcddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qFsmbqrp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7lQKfxA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFsmbqrp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7lQKfxA"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2418A1140336;
	Wed, 25 Sep 2024 00:36:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 25 Sep 2024 00:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727238974;
	 x=1727325374; bh=dpLvpZyEquUiprnGhnK4Nmm0WGSR0xfGGiVXyLP9w0U=; b=
	qFsmbqrpvVKBb3Pfa5VhQ0K4hK6rjPCFtfFBlTZsjpZF5D4zPTI+ACMCx6+XEAYU
	ArYO7Wjaa+rNl57VZxhXSV6H8kXtM/GWpsjJjKK5i3XHyryvqdhyDI2v1d1Z+Uep
	2C7TBvXdwmXrLigSY7tt+R85+891nPX0AJ/azEpfhicYePT4cpjrceQr4edAu4eG
	Z9lyXIJJEctIR9G23Y6NAv1DaO+a6EeRI5DlWEcEpo16uq4kTkJyde693/zTVczg
	/CThSlljV9EJ80SkUsxM6TEAdXRHujJ/r6E+823elmDcWyEIOTFf9hM8yP9lq9oi
	98dVSiSh0/a5ov7s2ckSUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727238974; x=
	1727325374; bh=dpLvpZyEquUiprnGhnK4Nmm0WGSR0xfGGiVXyLP9w0U=; b=W
	7lQKfxAb3s+Iu9LKXRdBduKwrdZ9h2mqQvaG+KXfODYIKuL+KjS18DLf61N0MHWk
	8pDQrVBbmwJatvmRR7kvCXSKRbNnKS5mlzUALoQim9MLcsd2L91QhbiAAUy0HymB
	jm0EXEpk7qjjBn9vhIPIheyWvjYsS7XqotYbvXrhEzxA+Otg0PMlhjBx9pmu/kMN
	6AwKRPfSW/ez/ww9nlBjm52/j5tU5XkDYTC09nr5CRqhLV10VsVtu3tosP85gggu
	eofnH0pPb8VjClMcdrTONcm6jxIOWCfZn/vDRsWiHk8pCa6zhSp6uIrFemG9fNTM
	9J2VtZ4mOGQwvX6rF4xAw==
X-ME-Sender: <xms:PZPzZjKZOkGpo1BgF6qYZeElvVqqT5ajT4pHietsp-vp2SAVqCvq2A>
    <xme:PZPzZnJCpEmfpYoqfANLWQtT5R3zjqPWjdjodKxmAMyAskNxNCtutWY4O1i776M0C
    lBs9-Sw1Kt_fBjsDg>
X-ME-Received: <xmr:PZPzZrsOGwO3LNYSc70pFXL7BfBa9WezAdFlpOJKcSGHIHNAtDZHWDdWicL2MtAj6z0XtY37-l34KqzdkvYtDMbjiMFXRaoCAkTBYl_snedq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhvghnrhhikhdrhhholhhsthesohhuthhlohhokh
    drtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggv
X-ME-Proxy: <xmx:PZPzZsazCKVDJ9AfEJw9YqdG7Uph5wZcvE_3t0NJt3k74owidu09Vw>
    <xmx:PZPzZqYzBMGV1e4Avra3xquGKoB5WibVddTGTrOkY5QdF0Pd3Nhamg>
    <xmx:PZPzZgC-HweOtPz9VCOXORZQyv3OElRnjE0DC6CBbpO8BVGrh25TVQ>
    <xmx:PZPzZoZ31SdilGoWnE1mzRDEp4_bh2cNY4u0rj3X-Oa4ov2KuzkTeA>
    <xmx:PpPzZi5NS8kn4mXrKloagzbs4x0woplGF04E3Cl4UNW5h85ORERXjOlK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 00:36:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5387411b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Sep 2024 04:35:35 +0000 (UTC)
Date: Wed, 25 Sep 2024 06:36:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZvOTL0cG8qRY8OXe@pks.im>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
 <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
 <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im>
 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>

On Tue, Sep 24, 2024 at 09:59:52AM -0400, Eli Schwartz wrote:
> On 9/24/24 8:10 AM, Patrick Steinhardt wrote:
> Still I would prefer meson over autotools any day of the week. I'd also
> prefer autotools over cmake, mind you.

Is that a typo or do you really prefer autotools over CMake? :)

> > Eli makes a couple of good remarks in [1] about things that both CMake
> > and Meson bring to the table in addition to that, while also mentioning
> > some of the benefits of Meson over CMake.
> > 
> > I would be okay to make Git work with such a build system myself. The
> > current CMake build instructions can be used to _build_ Git, but AFAIU
> > they cannot yet run the Git test suite. Dscho pointed me to a couple of
> > patches from Ævar that work into this direction, and I'd be happy to
> > revive them. I'd also be okay with picking Meson over CMake if that is
> > what people want. But my ultimate goal would then be that we have at
> > least one CI job build and test against such a build system and give it
> > the "official blessing" as an alternative way to build Git.
> 
> Like, erm, many people :D I spend vast portions of my day inside git. I
> am not very good at C, though -- and the likelihood of git being
> completely rewritten in python is quite low -- so I generally do not try
> very hard to repay that by getting involved in git development (I have
> some humble patches consisting of a single patch series, which I do feel
> pretty proud of since it enabled a very useful workflow, but still:
> ultimately amounts to a one-off event).
> 
> I do know build systems pretty well though! :) And I'd be happy to
> collaborate on Meson and help maintain the build system support in the
> long term, assuming the consensus is that people think it would be a
> neat idea to add meson support (regardless of whether it serves as a
> primary or secondary build system).

People with different skillsets can repay in different ways, and that's
not a bad thing. Not that anybody really has to repay anything. But in
any case, I would certainly appreciate a second pair of eyes from
somebody with expert knowledge on Meson once I have something to show.

I had a deeper look at the CMake build infra that we have and figured
that it does make a whole lot of assumptions that autoconf wouldn't
make. Those assumptions can of course be removed, and I'd be okay with
doing that eventually.

But for now I'm hacking up an initial iteration of Meson that is good
enough to build, install and hopefully test Git. The intent here isn't
quite to preclude us from using CMake as "official" build system, but
rather to make it possible to compare the different build systems with
actual code, where our choices will be plain Make, autoconf, Meson and
CMake.

That should hopefully lead to a more informed discussion.

> Although I'm uninterested in personally working on cmake, as you
> probably predicted.

Fair.

Patrick
