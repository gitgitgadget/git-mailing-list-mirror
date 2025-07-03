Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934052DE70E
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540352; cv=none; b=UMK4tg5X/4H4itbZJXQ9T1SjV2efdp2R/YG5zWzA2SIt6DHWUr6V+zvQPT4SSnVY2Se3xK1wjVQXL57I+K9h38pv2CRUvfES/ZT0/lY4OExvfS1czMtcBlIgSqBZlYHcZzj9jEhGKZhaoUYhlpNmSlGXnl5kZxJws92eDGv7DOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540352; c=relaxed/simple;
	bh=JiQmSZ0cXVV9C1zCzm+27vZNti4kbrKNoj7Mrpm+nfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6IFIECZTGl2YxlsXLTXsj6kqBbAoAOb+enkQvwdQ+pMElEhAU8cb3HxWGK9jfNnOByw8ucARYeieTzTuL9/ygWNf5WbefWmkcfd6bogRry5D582LQp8kpC90YFDCSEIYkGiorS1rcTBZVh+0uDh/sm/dxZU7qyf3yuY4VF4zMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dTPHFUcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZNuEqlD; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dTPHFUcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZNuEqlD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A18DA1D002BC;
	Thu,  3 Jul 2025 06:59:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 03 Jul 2025 06:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751540349; x=1751626749; bh=bhshKd5RSq
	gQZq7aHpAmAQRByk5m++wGsPQlqVrfYXA=; b=dTPHFUcMuE1KkgJl2mjsLytaFr
	mEb8TKt4aXnssuFgMn6Jl+2+l3799xSStYFWH4EuZDmOK4TP3KJTWoxn4ykyGRSI
	B/dP4oA/eoffW1nQJUbKyIAViAqwRUk9wJ7EjJpGDD8KfvUrunt78BI45yOTdlld
	q9rjzWtQQvgWVVadqYBXpemWJs4SZmKW6TzUKBJbQqwj+4RFGyo/IQE4UzlaBRx/
	7kudRa7MhFsd2UUvIZFBvHcdV027M9nmNMf69dWL5U5DXqP2n9G5gtGn1tX8BWoS
	9MkbHEuh/dSqH+VdLug9bpWiU26KpvvcCbE6017B1xYynWdeTDk0BTXSjxWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751540349; x=1751626749; bh=bhshKd5RSqgQZq7aHpAmAQRByk5m++wGsPQ
	lqVrfYXA=; b=LZNuEqlDSnKJ38YsKOnIKXl7j0Em34y4dSCE1wQeV+QkttrB7OA
	S7oznUOw3M3eM1XFEVQ5nB23Yn4yFdu7Q8GeUcJCRH6J2TP/pfrUqZnil0HoAUIB
	URFkQK+R/oymdF+lUhcoMHe7+vA3HY3DcXCtAznlLPVO+8W6YLpM3YkY+HpRlEsA
	rgpJgkeE1ntLXyWo0LbMJ54CqAEbDpgfy18kWzNU9zyccKhDc3wXAaPI322k0/+u
	/Qw3DgyAuurmadBdO9fyPnlF+Gm7+sMAgpPkAsSzdW17UTplWEVgvIdr7T1rbJ6t
	fs/Wrq+zUTjRSiDwE0mzVTR8owlKNZfwC7w==
X-ME-Sender: <xms:fWJmaF852OZZiOzaK957jiMyTzy1dvOa1pvJRAFHwpqpwD6wOi423w>
    <xme:fWJmaJvjJRtHMiKMEicrOrJ-iQSWj3gSwGnJwdctX_KDUxWrqOXozhzUUmDp_jYfu
    TkMDad3yeYAp2O9Vw>
X-ME-Received: <xmr:fWJmaDCD481MJUfEjumLMq4cjtYvjwBFrtrYM-ZVg5wZ__i_I5PlmscGFuPDR3cevD7cbkp3Bcbq0qjf0OJYv5CAenY1fVm_qbNNhjSOBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fWJmaJdn3-ZlGDbE2pymQ3aYd1Xg4m2wTdqNCLT6EWWIfE0Q9bbhAQ>
    <xmx:fWJmaKOJqLHFMToA8SQq7kAwiI9soRvb10OcH1ah-o5Q0U191oxygw>
    <xmx:fWJmaLmolc2VOfJFHzhs4itUx33TFR7X6XvAJq8iUKKk662WC9BOlw>
    <xmx:fWJmaEueeGm3Czu2xRSbEnL73jBsM-LPi_sPKniCIOtEtiQT8CEYnQ>
    <xmx:fWJmaBpNriGOHGGGmSGyh59UHi2yYC3dUSZvMmvvy2AnKIrave7hFyzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 06:59:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5eec72e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 10:59:06 +0000 (UTC)
Date: Thu, 3 Jul 2025 12:59:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] for-each-ref: introduce a '--skip-until' option
Message-ID: <aGZidwwlToWThkn8@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250701-306-git-for-each-ref-pagination-v1-4-4f0ae7c0688f@gmail.com>
 <aGYbZcXP2voT2IYE@pks.im>
 <CAOLa=ZQvY6+fU-xDTH5jnrZxAsx2LxB2t-2QDu-8WpNrFpwjHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQvY6+fU-xDTH5jnrZxAsx2LxB2t-2QDu-8WpNrFpwjHQ@mail.gmail.com>

On Thu, Jul 03, 2025 at 03:02:03AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Tue, Jul 01, 2025 at 05:03:30PM +0200, Karthik Nayak wrote:
> >> diff --git a/ref-filter.c b/ref-filter.c
> >> index 7a274633cf..9d0255d5db 100644
> >> --- a/ref-filter.c
> >> +++ b/ref-filter.c
> >> @@ -2714,20 +2716,28 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
> >>  		 * so just return everything and let the caller
> >>  		 * sort it out.
> >>  		 */
> >> -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
> >> -						"", NULL, cb, cb_data);
> >> +		goto non_prefix_iter;
> >>  	}
> >>
> >>  	if (!filter->name_patterns[0]) {
> >>  		/* no patterns; we have to look at everything */
> >> -		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
> >> -						 "", filter->exclude.v, cb, cb_data);
> >> +		goto non_prefix_iter;
> >>  	}
> >>
> >>  	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
> >>  						 NULL, filter->name_patterns,
> >>  						 filter->exclude.v,
> >>  						 cb, cb_data);
> >> +
> >> +non_prefix_iter:
> >> +	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
> >> +				       NULL, 0, flags);
> >> +	if (filter->seek)
> >> +		ret = ref_iterator_seek(iter, filter->seek, 0);
> >
> > Hm, this interface is somewhat weird now, as we have a split in what the
> > prefix-string meeks when creating the iterator and seeking it. I think
> > we should align those two functions.
> >
> 
> The `refs_ref_iterator_begin()` takes in a `prefix` string, which sets
> the prefix.
> 
> The `ref_iterator_seek()` takes in a `seek` string, but a flag allows it
> also set the prefix.
> 
> I think this is okay since the naming matches what it does.
> 
> The alternate would be to `refs_ref_iterator_begin()` to also take in a
> `seek` string with a flag to also set the prefix. What do you think? I'm
> okay either ways.

I just think that the interface is a bit confusing. It's weird that the
needle that we're seeking for may or may not be used to update internal
state, and that this is inconsistent with the similar fields that you
pass to the iterator when creating it. So after seeking it sometimes
acts like you have created a new iterator with the needle, sometimes it
does not becaus we retain internal state. This kind of inconsistency
invites mistakes.

Patrick
