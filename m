Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19143DA7DC
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343269; cv=none; b=PTphDlK1hXYTgwB+uJd4d8ulJbNflkUpV8DK4PZ/w1Px0YxGpd3hGPw4rRp/hf3tNXUwBEw018qobYq4jLyToKDYKfg+8VzyO+dmZMGg8WneMkbT/WeyOrnuh1RLuBNHNy1MPaS2yTTebl2T+VfCR/QS7jDDK63QEKAUNGv2HV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343269; c=relaxed/simple;
	bh=N+1s6Yd2EUPD4ASBnn91RuBAGAclvxgBWXPOgLFzdwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2WmzmPdCaYOOgZ/FbFgpyf/csO3C+vSXS5t5gpHqLIjlHuVwOx9G236dEUl3u1n2qVTmJXFnLg2RMZA83c8WdWk2ChrewVJPg20fMVWTZjF5Qz6nbnrexZd5Saa3HfmEQsmpyEqLhWg5xg+py8QkzWuL9xM5fQZwUYuF3hl8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dosj3sTS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yUCowb/h; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dosj3sTS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yUCowb/h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC89A1400213;
	Tue, 24 Mar 2026 05:07:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Mar 2026 05:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774343263; x=1774429663; bh=Oqcc+z1qnF
	K056K7p6/ciRaVx8DIDKaL3nq+lfJYx2o=; b=Dosj3sTSyFngvQzoe0B97QqtEc
	OASiSGXp6CGAWc7qGnCie0X72rydlwFN4GSGv6Jy2wu1WWcE+/BfYcpS3zvllqky
	qGnYRlB5x3VH8eGdyZhiZuJvPFPtwDN2CZHUZJ8q/5PQzp+/bPELRoDAuUiiAl08
	V21tVP6qxxjik6uIVWtL60OGbRHb4cuTAF/f7/1LU6AjxN2vYjhQ4cKpnkMxTzwV
	IwodnHNftTtcXfhF6nztkl1HGoizQV67Q18EtCV8wmEcL2VAAWlKhyE969La9HOF
	5VCMHOXlqhTKCKZFLBzPAHtFy1JZDS+3R2YXyQXNMyJyrS47/Sli1IU/ZWFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774343263; x=1774429663; bh=Oqcc+z1qnFK056K7p6/ciRaVx8DIDKaL3nq
	+lfJYx2o=; b=yUCowb/hA8bjYPEKSuEDNY3XI/unyu3fGdAKpWBwlmMvjM0JLLD
	BWIYSL4anCKVvnWXDQhjdjKX03rJG1RVi6sxftWTt3xGvqT5YsRvRCV50lJZfPSv
	Jd1UfroWOnf6SxHW3WUQ90bbFDGFX0JTumCWxdkp5tsqwbe5iQSvjPtRszpC059B
	BKajrCdgwizXUHF6fd3TvS5g4gj0ZEvru8VzNKRUdttIHBV6xNKwmqs2OpLmE6D/
	vRxYj1o0sskHeMbv7OS1avehE6pj3XZTJDX4wnt0q0EaOgyA7TZkKFCEZa/HdqJt
	w9SEdEwgi3Nup+XmO/0iLrPluJ5scf9hIuA==
X-ME-Sender: <xms:X1TCabQ4yOQqCgLjhBtDHGIQUAncGgYfv5GJF370LYmDx9WPgjovNg>
    <xme:X1TCab3XijiKXTaEeWnngvTObDDSrlH_xM5omKPVbGVik3AtUTqtpC2hIdxVZmCr8
    2h3B5u-w4VL7ceVz6MqStHaCaatPdV-Bg14r980OyTOIUawZjHT7A>
X-ME-Received: <xmr:X1TCaXBnuiznDzD1viQ_6NIyXaTUHg5XfIOIFvFRZrvtvqWEdoMKQlBkTDOL0FpMDHLMsZBHmm1_tS0hYtXF9NMQrr92IQCuWjvZ_aGIeIWvwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumh
    honhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghmih
    hlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnhdr
    rhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:X1TCaXjIdXSYcd8RanwkYLqrjztzQkuzgj9hkeCFOuXwHfRDGV9sGw>
    <xmx:X1TCaZO5IG-Qtpmr6qEoqnuNvN2y3V1A-ci1VBZNRH25evNzdkqZqA>
    <xmx:X1TCaX8T5SVgP9GGKWYHIjW2tc9_eps55_BVa4y7li5qyTAaB41nEA>
    <xmx:X1TCaae35I_8nsMZUG4kwSv5BbGcEdqKq_K4xy2N9rVBw5y4q96iFQ>
    <xmx:X1TCaQnSZmHyvt1ajOZKoYnBt4WNLff_qfl0TPq08P70TT_-IJtpvIeU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:07:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f595d18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 09:07:40 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:07:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 0/9] Run hooks in parallel
Message-ID: <acJUWcNwNOIFDL9B@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <xmqqtsuae7nt.fsf@gitster.g>
 <87h5q660un.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5q660un.fsf@gentoo.mail-host-address-is-not-set>

On Mon, Mar 23, 2026 at 05:07:28PM +0200, Adrian Ratiu wrote:
> On Fri, 20 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> > Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> >
> >> Range-diff v3 -> v4:
> >>  1:  6686d92867 =  1:  ec274c24e5 repository: fix repo_init() memleak due to missing _clear()
> >
> > This one is not included in the set.  This cover letter identifies
> > itself as [0/9], but the range-diff implies it should have 10
> > patches.
> >
> > Curious.
> >
> > In the meantime, let me resurrect the corresponding patch from the
> > previous, trusting that range-diff deems them identical.
> 
> Yes, it's identical. Sorry for missing that 1 patch.
> 
> I mis-typed git format-patch HEAD~9 instead of HEAD~10. :)

I can only recommend the use of b4. It will make your life a ton easier
with mailing list based workflows as you don't have to manually keep
track of shenanigans like that.

Patrick
