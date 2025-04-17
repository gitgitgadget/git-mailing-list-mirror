Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0BC22E3E8
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877707; cv=none; b=kc4jJNKLx3PCFEmZlUooYIvfGdb8SBVFXZml4wfb4SQFRIjAgt3RY8LwHhbJ8GFUhRZjorWz3DsGR82FromOcz/fcGm4dwFoln9vHSQ3BNWgeYwABVbYLpQrhaQIoMpS2T31USxhKkZPjPesOekMBuuRAbGDL9QldB2BVKH9+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877707; c=relaxed/simple;
	bh=KHEYgcbSnNHVSDcTKVbRiO13OxzcE1rt9voEQ1KOI+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+o7ZQbI8tmxVdYB7ne2gVDslpuWySZXcw+A+yq1CGD+p9OyHE9UGzjtsw8dVzl87jJ4svU6bDjlXCP6GHl7kccrWNpD1+m/IXMUV4p3ooed6Iv+PCheeTG7l0roJGkxUeAy7nb0RIiijDYTAlijQ+ql4fBkGPTCBgqxaBOAivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BZMQ4sCM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQXRDjvQ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BZMQ4sCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQXRDjvQ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F0F21140158;
	Thu, 17 Apr 2025 04:15:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 17 Apr 2025 04:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744877704; x=1744964104; bh=7yH71N8ksH
	8Gcw3L9HR8zMyeHNmsBVzZ9oSUWuC/hj0=; b=BZMQ4sCMhWl+oP2bLN0ispR6j5
	3ZhLSZIt5MCwYRCv091KBez8bPbJzR8x0IeHZeCbo2FSGF08gunBu82K3HPJzc1p
	B+1phzz9EzieEQjUtZyApo51c4QuyWxTpYVGKyjHNgsv+hAmwB1DGo1fpaBRPBI4
	t2fheNOmMzllyU23Dln6WBuhO2Gz/wTMTVTU/1k46o+QSmacIXq42Oc6fXmqJrLw
	ShMkgLtA3MIyaS7Wt90mrwM81PJ7cYyOMHpTpTeYfKEk1fDp6uItZwT1Rh9kpQuL
	Ha/HLs847KmcKToVOIpuXWoQIFHkmfKe+KMXL2sibcnKChlNBZfjSyntEINg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744877704; x=1744964104; bh=7yH71N8ksH8Gcw3L9HR8zMyeHNmsBVzZ9oS
	UWuC/hj0=; b=WQXRDjvQe5lDMGMuBGId1MAbnsVSkz2KqIuK+MsjAdu2mjMtYhq
	GfQMXWtSS0wg2b/DW7BJs2ePDrmmQEtXuq7BophEKJDZYGFX5YsdkL9fcKTgjS6i
	sUyreMMaSzC4w4u5XAFjqvUdYtPbg+gqAFGIHZiFSixHz8SPhGLbSF0BGjmI2N/H
	0BaB0AXg4T/4hkBTKGRBCO7JJ6KYlGEDqMb4zs2FWw09qYjPalTzRVfaXMFk/Kq1
	0FShm2bLk8ZMQ+4Ql5+rRLjoe2zUt4u9FoL+KV4AseOATOlXiyW7R12AHd6/r+Le
	jNDwEW3DUs+S1RRutzcFWB0+oXx/BDb1yLA==
X-ME-Sender: <xms:iLgAaJxvnAE7HO6UQ8lKtOTFG6_od5jEu-wArs1FqZTQG2cp1xsitg>
    <xme:iLgAaJTJp69FG6xYD7DHC6ex4wfdmMnRpFiKx8PLz7WnHejBCZ-lxEGqJ2t013fhc
    WotpAjoHIzZF_S8lg>
X-ME-Received: <xmr:iLgAaDUkXK37H8aPv3Vsrf84KCIscalZg3kCdlYUGKfUpqNaRwU538QAO5y8jywgfuqXTquSsSPbGFcKVMnQ6dzCbl7GOnTCLWv6WE7kW7Bso2P2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggv
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iLgAaLh0gjT4F3Fps5KS6ol4ubrokW8D43VMfrufLAvobh98G2tYnw>
    <xmx:iLgAaLDGTPYszXTDmO-6A4zdtO0ynB0hDWtrFsqNJ2XXnmU6lsATFA>
    <xmx:iLgAaEJVWSTZ5My0OUgrfxiQ4K1XAsFteD-0GSFuVQ4hod0UuKxrsQ>
    <xmx:iLgAaKAqGAQAUvKkQ9m1qPAOyPvCV8BLc8nprnYRrs6l3wONm1G_Kw>
    <xmx:iLgAaBHcMhDrfqTXR_xBx8EkDA2INkI_3-eqRUa1sy5hVJFOqO6NMFvb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 04:15:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 308c59b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 08:14:58 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:15:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Todd Zullinger <tmz@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/7] parse-options: introduce `OPTION_UNSIGNED`
Message-ID: <aAC4hMDS8gIwi7ku@pks.im>
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
 <20250416-b4-pks-parse-options-integers-v3-5-d390746bea79@pks.im>
 <xmqqwmbkgcu5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmbkgcu5.fsf@gitster.g>

On Wed, Apr 16, 2025 at 11:50:42AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We have two generic ways to parse integers in the "parse-options"
> > subsystem:
> >
> >   - `OPTION_INTEGER` parses a signed integer.
> >
> >   - `OPTION_MAGNITUDE` parses an unsigned integer, but it also
> >     interprets suffixes like "k" or "g".
> >
> > Notably missing is a middle ground that parses unsigned integers without
> > interpreting suffixes. Introduce a new `OPTION_UNSIGNED` option type to
> > plug this gap. This option type will be used in subsequent commits.
> 
> This takes a turn in a bit unexpected direction.  Because the way to
> spell a scaled quantity is unambiguous in the sense that anything
> that used to be parsed with OPT_INTEGER() couldn't have had anything
> but "^-?[0-9]+$", an obvious alternative is to teach OPTION_INTEGER
> to always allow the scaling suffix if the user wants to use one,
> without adding a new "only numbers but this one does not even allow
> a sign" variant.

Yes, that would be the alternative indeed. I wanted to have this patch
so that I can adapt callsites that accidentally pass unsigned integers
to the signed option without introducing any kind of incompatibility. So
I was mostly aiming for 1:1 compatibility.

But I'm equally fine with extending `OPT_INTEGER()` to support parsing
magnitudes. I guess it's even preferable: less overhead on our side, and
more consistency for our users.

> Seriously, are there good candidates for an option where we want to
> absolutely refuse to take scaling suffix and insist only on a bare
> number?

I cannot think of any specific reason.

Patrick
