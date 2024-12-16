Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DF1CEAB3
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339658; cv=none; b=GwfuLZHsRJGUFTrjXrHa9rdrZEqnV2/JbvN7pkdwKdBvNOO9VpeZZmAJd9rIu9ssV1vlKP65ME46GGR3+38s755ICsy3L5+eq1h7A1g1Jkyc5twUZjyFMIV4kJE5qrfki73NHXOEHLTIcLD1KpA8Cfo2JYf4FCtFZjinGYofKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339658; c=relaxed/simple;
	bh=36VcqLlE/JqWdm74Mj+0AVKDfBVpZFdBJgpesqI9slE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1PKQm34sWNrlEpMpUrx9UuQpvh8Pmt66vPLUQP02p9iC1NF2rJ2prncxv/Cbfg7Ofbu6tYuoeGwfjMriTpIxf6/QpVkXupZ9kggjk39smIjY2SbDcgY5LCIE2D2/Hbb8TL6uOUCzIYVH9k83OVJCpf9P4NzELeG+1NneFQVp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fr9H0a9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bE7VMIbY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fr9H0a9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bE7VMIbY"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6027A1140159;
	Mon, 16 Dec 2024 04:00:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Dec 2024 04:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734339655; x=1734426055; bh=RX5aDn0L/c
	rZO79Rr9C5gwm990MqtuPSWtrbY18KfzE=; b=Fr9H0a9ynjoXd/2KF0bllEzL+O
	fSFLdzVnv4j2uvRgUPvznqzFY/PLVACw49fTkZxfmdSFbZrp+dVwE2IWyPDdt2e1
	JDEhQreWnbw77uwf6SXaSgD+lhiEfXhXFq5tXjVMpPU5/O4wixugdbkx8MAC+O9D
	m1KGVWUUgximQVU4CdNCmVaPd1b3Vun6rpn6FW8+RsdjYBpZW3ftcosAwEpStp/q
	NKT0QNQJWLFySCI180RG+0mSOZcOki+IBEzkpQ5d4Vr6redviyF0qAOztlG/SnMt
	D/QPzA0ZrGtjJ4vltyIBWEodNwCFMq2pVt3+xy2kgix9N0oAOSf49bwc0IYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734339655; x=1734426055; bh=RX5aDn0L/crZO79Rr9C5gwm990MqtuPSWtr
	bY18KfzE=; b=bE7VMIbYJKWd7FLjnWjMbwLmFZzbxJh777l4njnWLBjpUZRFyhY
	gt1KaZ9C+rF18Pd3KmMZ8zkC7sw882JLM9AAGI4y8EZ3eHcLV8SvVRkUBFfJc0ZJ
	Bfa4OooS6gM81TdpzUJN/PGAae/XfhWCvEXRztxldazCjpD8O5qnrtx6g6DeMKIv
	SQP4SAW7vdVhN2l0FEzKaXr8beOAPwZUv33GBA83TTA961klFKViS9uFGdMJ8QTD
	O6cWK956M+5l1Z2PLYIKJhZMMbSK+Merypj68RbajTgRC9a+tUTxlPCHO5kiXNcl
	eRiCS2coLpEpXRYY1ozMO9GriDFovGiY6Cw==
X-ME-Sender: <xms:RuxfZ0Go7ed6rh6x-Qgb2p8cP0gZBsI6N4fRBWVOuhhw11l19CspIA>
    <xme:RuxfZ9UlPQfQbB26cj0mJovbKTERf5D439g5RLaTOOlnTSOP3m23RendH1x1lMCAu
    zUudSny9alcFJqwKg>
X-ME-Received: <xmr:RuxfZ-LRwpIL17SiKlHnYaoMb810PoZ2-ZpjcMRIyPYCxwnCrZoO9DyEhCDQcKT1FNwhmVJ07kV42MpIw496LkQi3v2fxesrb1igfDHW9LWPyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RuxfZ2HVv0KbVIVAfdDNyynrE-gIxju8MYD-2SrAR4pQsIZY0xiWrQ>
    <xmx:R-xfZ6XEEtUZNybvA7p83Paoq_t7NQ7U8Zgc0cfzBzigS2Uql6l-pQ>
    <xmx:R-xfZ5OUrHSBf-Hw6WY82U5Mpjjn0oS4rl2Jl-bYiqYxUdqUvugx-A>
    <xmx:R-xfZx3mGJ-CuMQDI8gkjlUfqYqAz8sX2S4DyQXLjXzKTqoIIn2c-Q>
    <xmx:R-xfZ1HPv0dBtn90pIKQYcKCTvV6fCjUxsKJdsGg-4MHHWPBHNzql6Gq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 04:00:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 073efd06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 08:59:09 +0000 (UTC)
Date: Mon, 16 Dec 2024 10:00:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/5] doc: add technical design doc for large object
 promisors
Message-ID: <Z1_sNJoYHVfVsn51@pks.im>
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com>
 <20241206124248.160494-6-christian.couder@gmail.com>
 <xmqqjzc7lq60.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzc7lq60.fsf@gitster.g>

On Tue, Dec 10, 2024 at 08:43:03PM +0900, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> > +In other words, the goal of this document is not to talk about all the
> > +possible ways to optimize how Git could handle large blobs, but to
> > +describe how a LOP based solution could work well and alleviate a
> > +number of current issues in the context of Git clients and servers
> > +sharing Git objects.
> 
> But if you do not discuss even a single way, and handwave "we'll
> have this magical object storage that would solve all the problems
> for us", then we cannot really tell if the problem is solved by us,
> or by handwaved away by assuming the magical object storage.  We'd
> need at least one working example.

It's something we're working on in parallel with the effort to slowly
move towards pluggable object databases. We aren't yet totally clear
on how exactly to store such objects, but there are a couple of ideas:

  - Store large objects verbatim in a separate path without any kind of
    compression at all. It solves the problem of wasting compute time
    during compression, but does not solve the problem of having to
    store blobs multiple times even if only a tiny part of them change.

  - Use a rolling hash function to split up large objects into smaller
    hunks that can be deduplicated. This solves the issue of only small
    parts of the binary file changing as we'd only have to store the
    hunk that has changed.

This has been discussed e.g. in [1], and I've been talking with some
people about rolling hash functions.

In any case, getting to pluggale ODBs is likely a multi-year effort, so
I wonder how detailed we should be in the context of the document here.
We might want to mention that there are ideas and maybe even provide
some pointers, but I think it makes sense to defer the technical
discussion of how exactly this could look like to the future. Mostly
because I think it's going to be a rather big discussion on its own.

Patrick

[1]: https://lore.kernel.org/git/xmqqbkdometi.fsf@gitster.g/
