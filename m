Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700315574C
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530311; cv=none; b=Dzl5NFURlctYSjgE0SZTHDKsBiheRZNU+Wv7Zw7Sg4IESlWX22vOwMZAUIDaEy7+SJZd9uRzrGBUl2tuXPGMOPXpgUvTmKywBth6S6K3QJ2X/jVGkGlEBvxgTYx3nqzUYGPHgkYyM+ej0eqGdeGZG8+l1G01/AB2KPQfn1qzfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530311; c=relaxed/simple;
	bh=lgP/P3fecoS2hvGBRQ1L8wHmN2llbF1z5CVcm+34xoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK9E0LqZ8vv7tlROGY0+95Mo72Se3CRULpRWNVg0cTJ7yaPl965KxPTMjz0PKnmjJG814TaDuIN1EtoyrYP60xdFrDECa/j7GZ61gq7Dwfm7Y+RHiGzeiYmPnwY/L+piYV0hm/BIU0TKKeCRjKB5ucIeJE6TjTeKA721GUqLZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kez9IkSK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iblqeqGW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kez9IkSK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iblqeqGW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7200114023B;
	Thu,  5 Sep 2024 05:58:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Sep 2024 05:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530308; x=1725616708; bh=8yV0UWJbYy
	yGSSopqX73X9N8GOa29dUXCB2a1TRvq7Y=; b=Kez9IkSK4sjbhJP7KSbbmr8wEs
	4C6hyambc8bfWpABtQhfBy6EcFAzc6mSKE6XCbqzTjlQnf4YaibVUnegNwvQFlJo
	694OlI2j6jEpeTmL1MTQ5Ahvl3zagzBaEUz4F+Vgj/pd+X/vj4FQ9Vxf9Jmr63S7
	O60bxYvfuGPdEy3JjUmIkyRLJfPhDpeebfW3VVSKvRsL3Ydd3dGRRT0YJzI5Gjc+
	k1wJo7YpJMNzduOAX0Gk/1juqRFhkSImng9aYJxocZL1yPm813y6lNPiVV5vhxlm
	qDfqLEwNorZ/kD2KT13SCHBUIoau2C+nsT8hzMvZId4+ixqUG0v8ExFtGa4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530308; x=1725616708; bh=8yV0UWJbYyyGSSopqX73X9N8GOa2
	9dUXCB2a1TRvq7Y=; b=iblqeqGWZaSUMTIhbrIBasrB2lGZ0jAM5L24VRmNpXvA
	SyfrKJrmtAeQcm+pou3R/MuDuhwDR8t0LU4SZhc/Fm/m41YJp7YLd9g3JCyvwp6y
	eicHEb2S/G8sCDWSDnAK31givz24AOIJGU27LBcRCL/jwyt7AtWeyGTJ7hYfKOV5
	8z/Ond7lrEuwahiItclySrfwWyeAxRHT8ciBwhmsTY6lYtps9yZIsjc0/069iL/E
	V3L8OpVuwoTpGHiidYz0GtpRp/WUu035kZPWsKVgfvzKzg99+p6SX2B9hCdpXm0P
	ekmASksA95uCPkfrpEP1IvLML84BwIf9WcNyKyQfYA==
X-ME-Sender: <xms:xIDZZshdMzaKebqDHAyeqb-hkHtOgzDnmmGjeME0te9dyhveIsRJyA>
    <xme:xIDZZlC6dmaL7chBTLzz5nUZiKVrg0wvoWyGboDeUPd7AdABmSaNjlQcoCcFJN-fq
    ibhP8p_j711Htz0sg>
X-ME-Received: <xmr:xIDZZkGMEWXtoRAsEDiqZdE-1gKUYD6pG3zPLf3di4K1iiyHTXO52Ed7zPqWc_VenWhYW-7NiAoB6Jgdf4LtpmeRDLflk0OUXfsNBcODvPqc2vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xIDZZtSJSrssYC1cskhIz10acCiYV_bT_dN1DEjQ9WlkFDPPxpQZSQ>
    <xmx:xIDZZpzrRNq-jO-J9zOtyIqrWbNfxJ-nzde5hYKqkuoc8woM1XCvig>
    <xmx:xIDZZr4VvdcgvJtb5VzqXS1JHnllkNJHQpQuZ9oDRsGHofSR8drb5Q>
    <xmx:xIDZZmyH0P7AZz6t0S_QdCjj_MBDLqn5V3kuvdhjEo4gAPeHHU415g>
    <xmx:xIDZZh81_0udxQ3cviKpADN6BNHGehuB5HRs4dHVz7fPBZPeYICdyi2X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 05:58:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92d4ff9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 09:58:14 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:58:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/3] refs/files: use heuristic to decide whether to
 repack with `--auto`
Message-ID: <ZtmAvvSJC2fMoXSz@pks.im>
References: <cover.1725280479.git.ps@pks.im>
 <cover.1725439407.git.ps@pks.im>
 <49f953142b1b20a63102b87a1d96f5bc1f79da82.1725439407.git.ps@pks.im>
 <xmqqmskncugz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmskncugz.fsf@gitster.g>

On Wed, Sep 04, 2024 at 08:24:44AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Introduce a heuristic that decides whether or not it is worth to pack
> > loose references. The important factors to decide here are the number of
> > loose references in comparison to the overall size of the "packed-refs"
> > file. The bigger the "packed-refs" file, the longer it takes to rewrite
> > it and thus we scale up the limit of allowed loose references before we
> > repack.
> >
> > As is the nature of heuristics, this mechansim isn't obviously
> > "correct", but should rather be seen as a tradeoff between how much
> > resources we spend packing refs and how inefficient the ref store
> > becomes. For all I can say, we have successfully been using the exact
> > same heuristic in Gitaly for several years by now.
> 
> This seems to hit the balance between the thoroughness of repack
> (leaving fewer loose refs is good) and the frequencey (doing repack
> less often is good) in a quite sensible way.
> 
> I also have to wonder if it adds a good component to the heuristics
> to leave younger loose refs (wrt mtime) out of packed-refs, with the
> expectation that they are more likely to be updated again soon than
> refs that were written long time ago and stayed the same value.

Maybe.

In general, I expect that most users typically only touch a very small
set of refs, e.g. the four or five feature branches that they have. So
even without such an additional component we would not end up repacking
all that often.

That picture changes once you consider remotes, because with bigger
teams it's quite likely that you'll get many ref updates there. I'm not
sure a time-based heuristic would be a good fit for this usecase,
because I'd think that repacking those right away is sensible most of
the time.

We also have to consider that an mtime-based component makes the overall
system harder to understand and indeterministic. Which isn't to say that
it doesn't make sense.  But I rather think we should land the simple and
stupid solution first, and in case we see that it's insufficient we can
iterate and improve it in the future.

Patrick
