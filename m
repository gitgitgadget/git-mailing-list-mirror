Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C0520B81B
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935799; cv=none; b=SU5PGLBqGD3tkDWbWuU6pNrwnI4x6mn6vau9B40oG5kdnL4kgpwWzRIgT0TYUPXLHl36CYB/RWPTbSoSh4pNjPlVaOTWh8udwQFHB0qKRGxmwSv8T6LmblfHkHZhSH3QcwAK6mcGZPDUqin1pPlz8uycf1gSVE0nFZi2ERh1is0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935799; c=relaxed/simple;
	bh=nghEkgX24UPI1pmqzl8ReSjw+Z6Mc7CZpQKnKKOd8xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbYi3asckXanHY6oA0FQquv8fqoTCUZMhGQuLekPDbQi0CtGoJ+qxLJSCPt9E77ygltt1lb81quqlUAnVer91MVXni8tr5CrfbKvkgsaEeHjjthUeLzu/2ErPiG1d5G0+/pwZRdzpd5BdDsM9gWRB6NrAWQle/EmC8fGDgnvb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RydzHSyq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kfL+w3wi; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RydzHSyq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kfL+w3wi"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89EF87A010F;
	Wed,  8 Oct 2025 11:03:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 08 Oct 2025 11:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759935796; x=1760022196; bh=Bd/4cehYc8
	SNX3qh6E6IWdkpfrf5XBqnoMWzIe9NQyI=; b=RydzHSyqA3VcQXrgi0sSmdBynU
	6oSDeLWoE6M3tR5REq+16ExEY63W8MnMjSeRwUSD5NXQ3zxe2x1Hmu8G3NsmT4/6
	7zE7tyAUMtqxTHg4bHtF4lfFGKut1rRSmtSo3hg5mPRrSFeMA3JYgzIKj2zJG1yr
	A1MuUxGi1T+5ttHlybI6Ox5WDkz66uD6IbrS+/+J3htVMCCBRMuBl9n+F01hKs0y
	VyMRQ44XtTvD2Qwo5sBt2kof3IJ7+LEtBoL3jteSEJ4pPkDKDNph84QIA89k1IZq
	nLtk6yIgxe9N95wt/VR1YRTeJTqB0ZEjizD/7iaC2U/AuxUrYHTYye1RCsVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759935796; x=1760022196; bh=Bd/4cehYc8SNX3qh6E6IWdkpfrf5XBqnoMW
	zIe9NQyI=; b=kfL+w3wiJDZsG/6CC7m0zx9hVhaOldOFHX6IZe3X8pu/e7XPksh
	ec8+epDB4qYcIFFgdIKMA538CHsvYMLgWX/vroWZCYT13QXb2cHa6WDmpSp3G0Dn
	KSsp+EtQwamAWdVdnY37cfK9+z+pYLSXOGkp5xFY/UigZfnUD6bVOko/EPPUbsrh
	tAzvd8eehlB+hZmWK9GqMV4SXUaUJYdRzYeO7rCwBicpIokn8KBYU1aW99Y5sfMV
	ZV/MegJLZVAIIJO3kc8m/MlInCNfmLZNlnkKT74sX94iYnpQpZVTc9Yb+4KrxevQ
	t2ctRGZG2Gir7MZpE16fGaoKCbFSG3JL6+w==
X-ME-Sender: <xms:M33maGAn5k3HJXEwPj17bjB79EaMDu8coW9e_7b_UPbyBah9_u1WFg>
    <xme:M33maGijcldZSQPDePtUhavlX5olYx8W7dNQEyJNXTH31-wLD2YvdGWEDUw01pnPA
    eVPdX_7xICEWuwfp-hT0HB5rHk4ZGB9LwscrcNJz43-AMXVMd2t>
X-ME-Received: <xmr:M33maHP5x0LLm6-9b-iq6S03xXPw13T_HgTuGPSqy45gl1sGD_NP3vZZMS9h3IjFk0QUPpvLWNDThXBD3uZIhzUPhIybCC2mnWVFrP9u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NH3maP7QIPEwAbb4zvXpS5iFGzGpXLy_b5KvUvUAZr9PYv4UtSXApA>
    <xmx:NH3maN2tq_6E7D36e2RRm9Km_mZ4CHsoT_pbJF-ujDrf3erFB5ZOMw>
    <xmx:NH3maIaAoTh88GJ5d1pHdxd_dYmIFXgRLyNAPa52qb-eFGSrf-6--Q>
    <xmx:NH3maNDPWMG1vI9ONtRmud8Iz93vTLV5bKnVWfDlnNYoP-_3MUuN7w>
    <xmx:NH3maFyY6D9IdJGp49HU_ONCur9yFIGhVYyRhBtbMOPhleTnBbYHuREu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:03:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7556e64 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:03:13 +0000 (UTC)
Date: Wed, 8 Oct 2025 17:03:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] refs: introduce `.ref` field for the base iterator
Message-ID: <aOZ9Lhjo1n3B70kF@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>
 <CAOLa=ZR0KWkpB4kjFm2g8F-PK_LWpE20P21rmJGOLONCkfN7yA@mail.gmail.com>
 <aOZqsM2TKv3g8lJ3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOZqsM2TKv3g8lJ3@pks.im>

On Wed, Oct 08, 2025 at 03:44:16PM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 07, 2025 at 07:24:01AM -0700, Karthik Nayak wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > The base iterator has a couple of fields that tracks the name, target,
> > > object ID and flags for the current reference. Due do this design we
> > > have to create a new `struct reference` whenever we want to hand over
> > > that reference to the callback function, which is tedious and not very
> > > efficient.
> > >
> > > Convert the structure to instead contain a `stuct reference` as member.
> > 
> > s/stuct/struct
> > 
> > > This member is expected to be populated by the implementations of the
> > > iterator and is handed over to the callback directly.
> > >
> > 
> > Wouldn't this also add the burden on each backend to ensure we don't
> > serve stale data for each '_advance()' call?
> > 
> > Would it make sense to reset this data in `ref_iterator_advance()`?
> 
> Yeah, that's true indeed. I was a bit hesitant to do such a change
> though because the ref iterator is part of a bunch of hot loops. I'll do
> some benchmarking here to figure out whether a memset(3p) would have a
> negative impact on performance.

Okay, I've measured this and it doesn't make any difference. I'll add
another patch to do this.

Patrick
