Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FA39879
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611719; cv=none; b=pxdy3clExXMaMPmb1RBBMIGdOVeyqvnqaKUnN4LQYLjNISVver1bUATNCstFfQrlwi79HYYQiiJc8YteKed860GRUh2JH2tGIsHP0WSNSemhwF9naT+mt75mZ+6a8D1ua+b2BmDdgUUaCQSMwS4GJgXY5NZsz0WJIPn9zvlBo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611719; c=relaxed/simple;
	bh=gbhe90uHxXsRcPCQsuNS0DfGeh5V3SBp5uwmDvJ13JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj0XqzSGGtnjifSsHgMO+jjC+hQrmb9S6RXfXKnJKlDf2+aBYJ8xXtNcCb7dqyAFrSEj6t0CnmKZuel+kzkjpgZoy1Qj48UEGZWWosp8Wl8ULmk2uxXO74p/ipojVjmvJfAfs5Rroo7pvY3LNCrHVDZ2Ylv7N/myBUSHt6M7Uek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i0zkFLwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UyGPq3Q3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i0zkFLwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UyGPq3Q3"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id EDC32138FCB2;
	Wed, 14 Aug 2024 01:01:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 01:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723611712; x=1723698112; bh=LW+SB9/O1u
	TGNlx9nvpP3KXljB4iOOsSVyod8XL+B10=; b=i0zkFLwCjPWJJvUNgU7RIyybXw
	qzmd43KNBhfd3VyMGSfvsCtbE6GZxxa+vPc9qQa1fGxGPLM58NbaCYUDfdEE8wrK
	5hezX8d0try3kQJ3RFpbG1vx3xcjRifCbFxNENXtWVKtyECi1/O2n+EkTJVLeRtd
	Ky+1s2ifOMVF4HybGay/wxt3e27kYNcNDW4FUjw2ORJ9W8z0b8yCNck/g+YMqug6
	LwpY3dryMsPuAVM1IAKAMtNEhZ0gato48e/gE7aaApqMKw+Sdrp/PWE01/odCowM
	e/OVqACIC2hfz/6a4r+wcsYvLeon1b3gYVsleUNY16BMIGL96yxhamkbXiWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723611712; x=1723698112; bh=LW+SB9/O1uTGNlx9nvpP3KXljB4i
	OOsSVyod8XL+B10=; b=UyGPq3Q3PpCTeLl9FcnBD9zBexjskEGMxw6eCWO24DMW
	AJ/QEqEE0qbTzudaRUZByhBVptG6Wj4nVkp6W8XhACI16iHa7WoXRPIzisfFZST0
	dEFPxJFrk9v13xaulA7LAAKxpTVdd0FrRJn39IM81JImArVZ3otUOj4pTqYKqZ83
	ZhomE3V69nyQimQBtfrg/7XXpV1CffnFZMC1BmTO/9qKGamyhfotuxwNa8r1lymo
	+MMHKxbRSENhM9rT4h/9ilvIx3HjTzdXobpxWKS9l1rwxrEXA4yzsQrDHPufNTRD
	i5tI88x5mShWq0agl5mDYG5ZuDtPfTq1TJ5TB8u2Rg==
X-ME-Sender: <xms:QDq8ZpvSycrRgIiUeXr1RsKnJ30y-WiOsCwBfktNkuQk_K6whX_mHA>
    <xme:QDq8ZicKAIQhMvAIkmdiqcym3gm0ZyfPQIum88v1wgpV898lx7mx1ezVQeQHo8Umo
    6aJXmbF8N0c9tDDSg>
X-ME-Received: <xmr:QDq8Zsy0d2LaAleXAKQ-ywrmPUYBzAT4uWY3yfM2XJsSvJAX3OYCZ4QXv3romMM3a4QxcTw2S6IZDgWhuqsZk1TlKPLD6X3ZuMXg7UKMOfEZrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QDq8ZgOvWlLR2_niX1n0IOKXvncZc8sGrE07cUtlrBANfWbDb0ST7A>
    <xmx:QDq8Zp_64Lat-raSt_jNPVwbnffkuP2gTyPgxYFgQLfDXB1NFLkt-Q>
    <xmx:QDq8ZgUscGwFUq6QZSwrXGOgxYXlWHHwFf8HhX5Mc7UJu3bEP8vUiw>
    <xmx:QDq8ZqfNiFBS89aVAqu4kLjV4XrQcLFk6ryWl8IXWMKdEOXSKR1M9w>
    <xmx:QDq8ZpwUjUoPftOGB4EW8Gi2NibyfJopYLEFy5yY2CQLkUzn_QaseXto>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 01:01:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8fcc75fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 05:01:31 +0000 (UTC)
Date: Wed, 14 Aug 2024 07:01:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 22/22] builtin/diff: free symmetric diff members
Message-ID: <Zrw6M7wvPFfzv3fO@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
 <31e38ba4e150c9bc9e3aa1073869881ccba9035e.1723540931.git.ps@pks.im>
 <xmqq1q2s8k56.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1q2s8k56.fsf@gitster.g>

On Tue, Aug 13, 2024 at 09:25:41AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We populate a `struct symdiff` in case the user has requested a
> > symmetric diff. Part of this is to populate a `skip` bitmap that
> > indicates which commits shall be ignored in the diff. But while this
> > bitmap is dynamically allocated, we never free it.
> >
> > Fix this by introducing and calling a new `symdiff_release()` function
> > that does this for us.
> 
> OK.
> 
> > +static void symdiff_release(struct symdiff *sdiff)
> > +{
> > +	if (!sdiff)
> > +		return;
> > +	bitmap_free(sdiff->skip);
> > +}
> 
> Hmph, wouldn't it be a BUG if any caller feeds a NULL pointer to it,
> though?  When symdiff was prepared but not used, sdiff->skip will be
> NULL but sdiff is never NULL even in such a case.

Good point. It does make sense for `_free()` functions to handle NULL
pointers, but doesn't quite for `_release()` ones.

> > @@ -398,7 +405,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> >  	struct object_array_entry *blob[2];
> >  	int nongit = 0, no_index = 0;
> >  	int result;
> > -	struct symdiff sdiff;
> > +	struct symdiff sdiff = {0};
> 
> And symdiff_prepare() at least clears its .skip member to NULL, so
> this pre-initialization is probably not needed.  If we are preparing
> ourselves for future changes of the flow in this function (e.g.
> goto's that jump to the clean-up label from which symdiff_release()
> is always called, even when we did not call symdiff_prepare() on
> this thing), this is probably not sufficient to convey that
> intention (instead I'd use an explicit ".skip = NULL" to say "we
> might not even call _prepare() but this one is prepared to be passed
> to _release() even in such a case").
> 
> Given that there is no such goto exists, and that _prepare() always
> sets up the .skip member appropriately, I wonder if we are much
> better off leaving sdiff uninitialized at the declaration site here.
> If we add such a goto that bypasses _prepare() in the future, the
> compiler will notice that we are passing an uninitialized sdiff to
> _release(), no?

You'd hope it does, but it certainly depends on your compiler flags.
Various hardening flags for example implicitly initialize variables, and
I have a feeling that this also causes them to not emit any warnings
anymore. At least I only spot such warnings in CI.

In any case, yes, we can drop the initialization here.

Patrick
