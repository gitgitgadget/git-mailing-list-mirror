Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360544A406
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133698; cv=none; b=fjNhLympAj7jp6gVUbSa+h/fvRQ/ndbf8+uXKVg3jBmYMbm4p/7kb1zeBO1Tdf5QzFfsXuM0TSOyGHgKbg8VexiIESp6VSdtxLcRVi+UQFB/J34NXao6zOae3ksO7t4vBu4M8yf1n/vj+fBqzayLaduWcjyyYxcu0AHs15IfokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133698; c=relaxed/simple;
	bh=6Swq234DJZl7/pkCldzDaAuShiBXgyhImpZqOEZP/Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBqcloYvdtu4F6fkDcTuQrpa88JsAaFJY4LWufjvV8hGXvlSFnoWv13cGuvXHtoL+i2PlVy9brw77XYOYbBzw1fc+M4k+s0wK9lHIAEzx9AdHHEFTgNiwq4vabnW2+t4RXa9Vp/MMVu2Pr0Z77+/DvaJtwd3E05e8fkd6d1CtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ORlENBXO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iwhtTxB8; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ORlENBXO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwhtTxB8"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 189C37A0020;
	Wed, 19 Aug 2026 06:01:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 19 Aug 2026 06:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787133693; x=1787220093; bh=dXonHLGyy3
	f9tfYnZyuf6UZwwTXHeH1a4tQ5vLQTOys=; b=ORlENBXO+oZvSK45hfijrdL6cd
	iYjmVdeDvwPIGL8hpK84b2VEy+6GVUqhd1oFk8csa94HxWHz/PyJZ1vYp3p1Sqol
	IubZVHvADZ2YMeDqTNsoWuJblU8riX4jRHKhso9LNzoV+15HllGralUUelmhP7bO
	SIA2lmCrSWXTjO25CBjbdnCwetXCeMn4SNVGHFeFqMkOoyAR6jDexhO/f+pvT/xx
	PZA0cqbLu2xBQk23JtAzh3KjcrMIsl9nfO5tF2Dol9s0Zd6riV4JRRdoMCbVHmSD
	ESTuYGb6W9H90FwdA4g7UnTzTdyPiZPT1YxUmnOJ3f5Z9aefgq/H/1aZg07w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787133693; x=1787220093; bh=dXonHLGyy3f9tfYnZyuf6UZwwTXHeH1a4tQ
	5vLQTOys=; b=iwhtTxB8a24iolZrEsZI8hLmJnzO35HGNH6iVVZq8N+d3qqilH+
	dzo8Q5RT0jv1TdjMZRyXxdAoDXhEdXwtQbPblN1xlMOULqjlZzKkgu8N6duHftN7
	gTw8SQPpRCP7/bIS1nk/Mm20oSXoOCWb0OLK9w90DLyB1HjewAWktJFdebzk/fHV
	1F+Wm73RCCF/oj6FeUhjzCh/FGWe6DJgIBxzQu3KRBwRKzGWf4MD+4y5VDzaMQz0
	It1XVEgo+sbJMDNA2yLcoyy6wJl22hkWpN2rDkeGu+dZJZng/SRQe9ZLqzAgCa0U
	VSMwPbqrCJupE+7QV0YyIBV/PE7f9BfpOeQ==
X-ME-Sender: <xms:_X6FagpCPHVkHvQlbqyHvWSTD-8VVywtCaKjchr_iTRWcjUIeWdVEw>
    <xme:_X6Fasq5yHNRcIH4AHPD7UY3M134dXp2gEMIyemb-FL6vAD9l7FvmtnTNcJSk2gh0
    63Op_Ne2M5RqGB9zIggSFcB_8XYfHxQ8E8LPNzPMDLmuxi7W-QXNw>
X-ME-Received: <xmr:_X6Fai2N40kySo3mhT_R8CuyxJsFte13xHw9DM9d-c8O6GoNwOtqa5PQAuiHdr4SD13HqEWFOKTFoGaBLh5Dr-heKR2oDnmqm8fkzDwo>
X-ME-Proxy-Cause: dmFkZTGs3blP4mzt9HjZDWkXtm8IgGo5YvWrMaQ+pC4b7EqiOQCUQZJYpT0eoup5x5Vwnd
    hWlbm/rpaBoSKda6B8a/59rskcLhs2L5jmxkyxRpuF99FGnp2i7FWsZZy22vsRmaWksK4F
    lMxv1QAiaI3LI2fSoJejl7g4fSRVm6tr8MtOV2oKDP4KszdTyvRVLCsezPKQgN5rELlUv4
    3dT9PFlIZEUWg/lv9aadHIL+kkiWbTit1X00aMsqp+yOCq/ff242JBfvy6VrR58ALoXuFG
    9+Zf30eqgI/StW1U9UybYDjOyW8J0gK/wAuA6cqXQ5+1aeXG3WbmnQ6+yRR/ub4pKdWejC
    TTtNEj6uId79xdE3q6c4CwZKDU2vWO3S4w8TSeH+SbcKhuc0wfNkK+anlSOEnUbR1ktsht
    b8zX41Sx3WWNbOGtAK/3DRLlHbXflbBE/xHisjzDk+wmjsA3ATsEITcLmGAmCLRRxjbmZX
    IkvCoof2Kwyv1aOcR+z3KPkrnr++ZxnUrrVhnLr73SXVZmzp7t0pMF95USkqfyOA35VZFN
    jsNxK2nUcFD6evZynRh0HWgdxr4Or/NZbbADPn2LEb1TVyZHCU5KBXhcezhGjsEC1bheAj
    3B0kaXqTwM7uusYW4SPOV136x8kUSLb+UexalJ4xE3MEQ0sut/XaPZpU+4IQ
X-ME-Proxy: <xmx:_X6FajDTDzq6SZG9P6t5m5DtwsvzdwgiezmGves662ZhdLbJfRnsGw>
    <xmx:_X6FaieJgCrRe5PHImg8eAB5J1RHeAJgp9ojNUX7tmXNbIuXonCjxg>
    <xmx:_X6Faghbf3Nru6qnUToeIE_BRlnd1sIdSDm_3eCG7da8ykbRHXFamQ>
    <xmx:_X6Faiql90_Wb6tkq0LvHsfvNopW0NdcRZPr_cSBIvlwKuUPgdVz9A>
    <xmx:_X6FakAdHXY6OIVmlWfilTf7QTkeqIvfJ6ehewUWoh7V40kCWqAWdwaO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 06:01:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4386f174 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 10:01:32 +0000 (UTC)
Date: Wed, 19 Aug 2026 12:01:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] odb/source-packed: flag known-bad objects as corrupt
 and not missing
Message-ID: <aoV--DSQq8-Krg3M@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
 <20260818-pks-odb-generic-corrupt-objects-v1-3-ec234567510f@pks.im>
 <xmqq5x17z41g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x17z41g.fsf@gitster.g>

On Tue, Aug 18, 2026 at 11:17:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -618,8 +619,11 @@ int fill_midx_entry(struct multi_pack_index *m,
> >  		return 0;
> >  
> >  	if (oidset_size(&p->bad_objects) &&
> > -	    oidset_contains(&p->bad_objects, oid))
> > +	    oidset_contains(&p->bad_objects, oid)) {
> > +		if (bad_pack && !*bad_pack)
> > +			*bad_pack = p;
> >  		return 0;
> > +	}
> 
> Hmph, so the idea is that if you have even one bad thing, you are
> marked as bad, because who knows what other parts of you are broken?

No, not quite. We don't mark the whole pack itself as bad, we only mark
the objects that's contained in there as bad. The only reason why we
also bubble up the pack is so that we can provide a better error message
in a subsequent commit, where we can then tell the user which pack it
was specifically that contains the bad commit.

That's by itself not visible in this commit yet, but I do mention it as
part of the commit message.

Patrick
