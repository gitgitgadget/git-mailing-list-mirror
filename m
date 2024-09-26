Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151A12BEBB
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351532; cv=none; b=sYB/RJxfhRPbijlwvRCIyteKC9kkPewqSQzBbWV27Yf+kucUFzKLLYkiMrnfQwuZCgX0YctBPS+YKrivkcR5z3tdjZgp8nr8AvEO46aHSKC8kyS8fzn/DF+me3X8dJstXDPyUdqefgojdUP0YJrj7BnLt0OgNW05XKFH+EkC/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351532; c=relaxed/simple;
	bh=zOxxvrsxrv05xV0VArKhPbK1a1/Y15WyMsCkJCJoE6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7LHUvR2zFbGadS2qTmHHsXL4scmnmdDoSWgtxdtjcRBXzf0auaP4G4Eo0p/NLoCjmGtnqm2XpQiUZQXM3UDcpZrTQHeyKpthOMpUqb7uuXe493KcsDba64DSa3ce0mpncjo3EJ4M8D1ZKNBV9hgC2D3TDchkMg8LT7hoDjG/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jf07rdrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S71nELqg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jf07rdrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S71nELqg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 106B611401C2;
	Thu, 26 Sep 2024 07:52:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 07:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727351530;
	 x=1727437930; bh=1D9RKckVLI1FVT5lJdAl80mmEIT8fTVGS+QcRmc4Zpc=; b=
	Jf07rdrL+Lq5ik8LtGIWk2rD/nfv3gw2zjBbPxn9yjpfddnzw/R48L1LlneuP0zo
	kQJyWzjky/RJw84BjJ9HmEqoThkccs3A0KZgYlyyvXnzZc0pvhpObPkZhT2kj0tB
	B+E9rbUnl11gFiV3IJLEkgAJhCCj16jnDyKcdB7WMV4NAA+8jg4sfXO5CIAFnzMm
	I/UDBTi0cj0MmQcz5OTfLIJKF37zR8iY7iC9Pni6sPykdq1eM9SujNW8kpGjDB/d
	Z3UDft10C6eOM19NFBfFejGDWoYjXaxf6n7/r46rKw3PcY0+DrvURUIcfzCVEKzV
	9LKlsifP5Uuwc+/1DAcQIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727351530; x=
	1727437930; bh=1D9RKckVLI1FVT5lJdAl80mmEIT8fTVGS+QcRmc4Zpc=; b=S
	71nELqg0+pVW73+FmvCYB9GRkg6SWBQnSa+EYDz8pHlvhRoQPS92P9v/CWtsP25Z
	4z/x8YD7tuV20dLNdMir+YzE/Qi84mGS53o6V/bqipdvxvlydhFU4NizKq4yKCrv
	Mg9JZQ/HzCi1cUBSXMjRJECZPOQYF9r2CA2uQoU5QkxH/J7TEKkIkMfask5d5pF6
	FKAU5iTQa3JqfJoQAhHaFfkHmmZlXYktb9Sh991DUaT92Q/Vn0Rzu+qqi+X/SDDN
	xsgB5avGA22MGyIHO9cOtGm+MkK28zPcAQHqsyW5aWzCw4u+aDNdEw9QYU2+DqsP
	zIXEhjtBh07WAbcqd9+vA==
X-ME-Sender: <xms:6Ur1Zg95_Pm14RcjebzxDGSx804R4yLS-o9PFytyNKm4xHsW7JnelQ>
    <xme:6Ur1ZoshDSkfmkrNnz5t_IBk7BTQxDGK55nRjhMQRq9rMG_NygR0EtaSgNZtehXoP
    thto-73Fp6mBDsA9g>
X-ME-Received: <xmr:6Ur1ZmCCPrQ9Qv6i3RN47W3d0tOyUGKz5onmvZ4R7bziRFmhvvMA_JSL8-0uHIjo2e0cVdnf6hmE_0k1OE4fKO2JH3MtchekIBeEt0rAM3cqeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:6Ur1ZgcvI52IEmV1QABnC_9m8JCp1C_7NcRqgfLsV2qaVE4-MIpjrQ>
    <xmx:6Ur1ZlMU8yydNh8R_ys6V_6P8GuOZL4iiwpLhrVbk104Q6OG-WKqWg>
    <xmx:6Ur1ZqnVLL8qA6FqpJa8YMVmlXwi0kpRkeJoy2qHm44wPHvb3m_8SQ>
    <xmx:6Ur1ZntgdqbwmmoGo23NvDs0coygVAvDU61D-cvIW-s6xAZv4F87cA>
    <xmx:6kr1ZmrnkDs3LLxW-gTZSIAkeYstOfpF8iLy4MgLN3SDJlE4DILHqqUj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:52:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0409961c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:51:29 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:52:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 03/28] fetch-pack: fix leaking sought refs
Message-ID: <ZvVK2gEYaMosdLH8@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215103.GC1143820@coredump.intra.peff.net>
 <5914d021-722c-4188-806c-1633bba3d3ab@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5914d021-722c-4188-806c-1633bba3d3ab@web.de>

On Wed, Sep 25, 2024 at 07:17:24PM +0200, René Scharfe wrote:
> Am 24.09.24 um 23:51 schrieb Jeff King:
> > From: Patrick Steinhardt <ps@pks.im>
> > diff --git a/transport.c b/transport.c
> > index 3c4714581f..1098bbd60e 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -414,7 +414,7 @@ static int fetch_refs_via_pack(struct transport *transport,
> >  	struct git_transport_data *data = transport->data;
> >  	struct ref *refs = NULL;
> >  	struct fetch_pack_args args;
> > -	struct ref *refs_tmp = NULL;
> > +	struct ref *refs_tmp = NULL, **to_fetch_dup = NULL;
> >
> >  	memset(&args, 0, sizeof(args));
> >  	args.uploadpack = data->options.uploadpack;
> > @@ -477,6 +477,14 @@ static int fetch_refs_via_pack(struct transport *transport,
> >  		goto cleanup;
> >  	}
> >
> > +	/*
> > +	 * Create a shallow copy of `sought` so that we can free all of its entries.
> > +	 * This is because `fetch_pack()` will modify the array to evict some
> > +	 * entries, but won't free those.
> > +	 */
> > +	DUP_ARRAY(to_fetch_dup, to_fetch, nr_heads);
> > +	to_fetch = to_fetch_dup;
> > +
> >  	refs = fetch_pack(&args, data->fd,
> >  			  refs_tmp ? refs_tmp : transport->remote_refs,
> >  			  to_fetch, nr_heads, &data->shallow,
> > @@ -500,6 +508,7 @@ static int fetch_refs_via_pack(struct transport *transport,
> >  		ret = -1;
> >  	data->conn = NULL;
> >
> > +	free(to_fetch_dup);
> 
> This makes a shallow copy and passes it to fetch_pack() and later to
> report_unmatched_refs().  It shields callers of fetch_refs_via_pack()
> from the effect of fetch_pack()'s NULLification.  This is what the
> commit message says would not work.  What am I missing?

`fetch_refs_via_pack()` is called via `transport_fetch_refs()`, which
constructs the array of refs to fetch ad-hoc and then discards it
immediately. So it doesn't ever inspect the modified array in the first
place, and consequently we can guard against the NULLification here.

This code is quite intricate :/

Patrick
