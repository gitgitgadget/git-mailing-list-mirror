Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43A1FFC59
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313767; cv=none; b=YEGp+o12xSGSrpDs7h2RuO4Qe9THp/SlRsjncqE90wGaRRTOsPeDLojBSGXkg5gJHMD99O+Q4yJqrl6aJQHdMp+mt5a5Z+JA22J6e7Km4CWpZSnOBinsMNZAbKTZYrerAjMhXvOgzuI8aJ+/G+pKC+DUz/1HtIHcBAVyAhnjM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313767; c=relaxed/simple;
	bh=BNHS1EOnp1zgvhUpxMt0IjfSIjT+3iNvH0i/U0ZRrHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ59o6v7FsoQv7rveJC07AGbxsfZ0KJ/D325C+TGnRwA+GLF8tR0kglGJIgIvCSe/nfdchfJAqluBFY9S5sDjeC1EPfE73xCVqmg7U6f4sUH79eoswks3iGBot/aSLKQ8dzGBc0uk38/TwHOybtnZ1HNDQYtdPAKmWx51w4s6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rMOmpO8O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjtHIsTi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rMOmpO8O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjtHIsTi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 313B91D0012C;
	Mon,  8 Sep 2025 02:42:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 02:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757313764;
	 x=1757400164; bh=z0xoRWJoPI7iay+iGxgiISO8RGA1Azc2OGxdAmi5Uvs=; b=
	rMOmpO8OTStjPSvOatCzRfOWCgdOmj4HUUM49S7tyvawdPFzmIW1RajaN3QF7D4K
	0NGjzHk+sCS265wYr9UegkhcU2WTAVNFhlkvPyTJe8k+wVezpm69Us5qo6h3DCLd
	reU3mJLV9Us+lCT+uZPSYK4w0A5Jog1/wqdmmo8aSaYtM8Z/vftHpn3FtjOaCItr
	hXVtoE1CK4JUGwPQvEsK+kFh4L+zxLkFKQwU0NZUIJrhm/WDMt6vzBRQoC3kK2gS
	u632FN/PWrAod0mQ2sIilT2R3AJpF+ozooDf3IV0xuFX0RqZohCWzWnO400ujOr1
	Q5FUBq9t4DP4HHSttYXxSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757313764; x=
	1757400164; bh=z0xoRWJoPI7iay+iGxgiISO8RGA1Azc2OGxdAmi5Uvs=; b=P
	jtHIsTiC0EuNHY6Yj7tnXOnOUhkBI1KFqiZJTqaKerf4d6Y9UrpRLuUoP4/pKDWq
	LP57MdJ4SstOzCbryVL+hiwsVEcXdxYrgaSkcKKL45XaTR4yshq4yJFPfnIc13S7
	evZcXIc8HqjGJ9o2GYoC3sQ+lFFpQhfWnFftSxLcAgxE9/4FW+1XZvXK9B7hfxVE
	tgGQaavoieWp+nJwlu6Iu2OwyoKmYlVWCfEKH23RYsSU+QVHDWoRGLdzz4d7pwkn
	z//A2AWo3A1nG8wS1JD+87XBYpHm2GC6AsO40TgNEUPk0AtQP+QIXb0NmZoGHP/l
	190V7o3JdaKjDncZDI42w==
X-ME-Sender: <xms:43q-aBeW79jO82k5IZICBrLy_j_mcMjIKKczvU-ZkRFzCNHHyMpRdQ>
    <xme:43q-aP0B805ASqq-29vBglvl8fpZoh9Ui1LyUeKOvcmNgvDzHoAv_HNvzfeg0WTRU
    a55bpAdmwYyF2sUtg>
X-ME-Received: <xmr:43q-aFr2DoN9xhhHWWuK5wuP1Zr-jEoetiuP1vGyJzvA8ZfaBGKPUabKZK7pNNUu49Gqh6oYJmVmo_uf1EWBzEFssb-FvTvbyZhhNKPEhVWLEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteehffdvtdeltedtteeuueekudegteetuddtgeeuueekteehfeeuvedviedttdevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhhhrgduleelfeeslhhivhgvrdguvgdprhgtphhtthhopegviigvkhhivghlnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhgpdhrtghpthhtoheptggssedvheeisghithdrohhrgh
X-ME-Proxy: <xmx:43q-aPjKVoCtZf9TP9eL06783z2oxFWBalHSsGWi_sli-LcAhQEjiw>
    <xmx:43q-aBmbon9HYXs7e-ibINjnivYZThAuKu-fz8YBFNx5beST8RyzBQ>
    <xmx:43q-aIoH8ix2QJDGRWdcKnkBudYSWPLlYwV8JNvIPc5aU5wdnm1BnQ>
    <xmx:43q-aNJvkRRvDekw-efpmDji1aiv-REGfkkH84gHCFCOw8qhkWCKKQ>
    <xmx:5Hq-aH3rPVbIBRaodjDghyZRP5P8CH9CamwsQqSrZZD6tU5tBbGEYEsC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:42:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01fa3cea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:42:41 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:42:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aL563ZzHK-43YeCi@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <aLrnwOGKaAjLj0Bo@pks.im>
 <CABPp-BFw-Oqp71jW5SYCKYOWtjWFSQPOsUVWdF7EnzftwAR2vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFw-Oqp71jW5SYCKYOWtjWFSQPOsUVWdF7EnzftwAR2vw@mail.gmail.com>

On Sat, Sep 06, 2025 at 10:31:07PM -0700, Elijah Newren wrote:
> On Fri, Sep 5, 2025 at 6:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Sep 05, 2025 at 02:45:46PM +0200, Matthias Aßhauer wrote:
> 
> > > Do we want to commit to promising support until gccrs is ready? What if
> > > gccrs ends up abandoned? Or takes an unexpectedly long time to reach a stage
> > > where it can build Git? It might make sense to give this LTS release a time
> > > limit instead, or in addidtion.
> >
> > Yeah, I wasn't quite clear on that one, either. An alternative:
> >
> >   - We will maintain the LTS release for 8 release cycles, which equates
> >     to roughly two years. It sounds like a lot, but recent security
> >     releases have stretched quite far into the past.
> >
> >   - If there are still dependents after these two years we will hand
> >     over maintainership of the LTS branch to dependents. So they will be
> >     responsible for the backporting.
> >
> > This really only is a suggestion though. I'm especially waiting for
> > Junio's feedback here to see whether he thinks that this is a reasonable
> > thing to do.
> 
> Over at https://lore.kernel.org/git/xmqqplc43o7c.fsf@gitster.g/, Junio
> said multiple years isn't something he's willing to promise, but
> suggests 18 months might be doable.
> 
> I have a suspicion that if you want a promised level of support,
> you'll not only get something less than what distributors want, but
> something far less than we'll provide in practice.  I'm curious if the
> alternative wording over at
> https://lore.kernel.org/git/CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com/
> is more likely to be realistic:
> 
> "We'll weigh the severity of each security issue and the cost to
> backport and give the last C-only version significant extra weight in
> our considerations"
> 
> I know it may not be what distributors want, but overpromising also
> has deleterious effects, so...

I think at least for the security releases we should promise to handle
those. I do not think it's sensible to have a release branch that is
still officially supported, but that contains known vulnerabilities.

Historically this wasn't too much of a problem, either. We always aim to
keep security fixes as minimal as possible, which also helps with the
backporting process. Our last security release for example even spanned
over 8 releases, so if that's anything to go by we even underpromise :)

Patrick
