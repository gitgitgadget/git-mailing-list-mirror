Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A74B04B7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513161; cv=none; b=H/8iVYphlP7kJnDFIX1wwBKUftTfZRdW4s+GNrWBSGKKRMYfvzOvYMQmL3Y0ZAjFInuJy4FUM4Z8274d7ZB+1RGwMevQzocwUrESvRSQYKu2zE1wG9HdE40fRTBAN5g9LAXHQlb9EIJAfyiOajxWww17NZ6eyyuog2KALKNAItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513161; c=relaxed/simple;
	bh=OwdP2b+2rR338807fA46TxFinbZ4DVH6/ekKiWYjn9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMIIwy/TigMleS1DJzdW3QGgmboS4v52uStL3Vtt5MN+21BGH6rnHTaHfDpCgqnhAHMXsLRWP/BG1jZ2gcEKRt0g54Q5mnV8oHxw7UyO5OfYO/5+32ZdIYongLtxTebTUVep7vJ7s1jOhNwl6juLUsbAycER0YHT5dyeV+M+uDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EIX3+mYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CMCHEojo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EIX3+mYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CMCHEojo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D03C3EC01C6;
	Wed, 12 Aug 2026 01:39:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 01:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786513158; x=1786599558; bh=wQTuV0Husn
	sJ+snA1uZtp+VvBwTgV47n8fV0ZVYGkwY=; b=EIX3+mYtNpiOnvQ21SjYpCtX/Q
	9aody/WCdM1hFTi07RjxnorlJhBP4JE3qAl9DMkzm9y0WB5S2IQMs7jPv73X7MBs
	FsVo9rqH0CL4mMECIZAaK9Y4i+p5zLTaovKoLT5EwE+cHYrUuZh8i9xCQBIRJZ2E
	GGSeCzFvEWoRiWgbc1pHjlHskHD1OuqsbcSguaSwBRTvbLqdQRVtrnWLG8skdd7Y
	vuOfw+ZKMEkZUENMPgQWEJUeI/KrwFdNe93JXedrfAbjyWg1f3ugdnaTi6LQMcbN
	avI7WthlwRbVqCswHRDzOwh5Wg64gY5OQEx6j6akbc6KGk8IOGjoZLfpY9vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786513158; x=1786599558; bh=wQTuV0HusnsJ+snA1uZtp+VvBwTgV47n8fV
	0ZVYGkwY=; b=CMCHEojo4lsh7bZDXo8BarlGuoGIRNYS4vv+CdBKC1buCcw20ZD
	7COfL5MZmSQIQAlFcC+3O2asqOh2OjtdvS4bvA0bm0d/5t6oQ7WzQNt18ubK34iP
	hTCPd9v6msde2nV0mLrC4MCvNPSLCQ6cjfGyLoSEdzEtVdlKjCabm+qLlJwpvknT
	ZfavP5i7jPmFYKJ3TDIowbrz7xtnuqEsQbteJ6dZvcZnTQRd2VZ4Bd1W1Ou/FUXU
	iA+YQxvGYr1yDRxLZDOTQ0i3uW4WFUi5TUGsHPJyObLVPhkfbvi4n8Ri7oGCIG4y
	W86W+kMTiBCxpWhXTF4PY+Nly3wXruhpYHQ==
X-ME-Sender: <xms:Bgd8am_g60y-TohYzLhxC29-UV0eAwWcPKZKQce3qmiMGV1e2vZMyg>
    <xme:Bgd8asvo-awrzmB8wHy9dei53FTZyQNzZBfvIKzgSeRy76fW3zK0KLDG_ZYYS8dv4
    4k8ud5sN0-0ph7ZroUk-hgTHfLB891SqznUAJPGsMD7VrrjzpaSC1g>
X-ME-Received: <xmr:Bgd8app2-waIohj1TSs4hj8gcPjugZfMZx-fhbrNq0qfBeuSWLRv63AyRaqbTLGO2488Kdr_m9UCoksEWMPISpzS7yf0cq-oQNu_OUylJw>
X-ME-Proxy-Cause: dmFkZTGr9ssf0/cMkN7fp9OZbDCNscLG3zZlA/yjmd+tbvzYvdMaKES5AdHFCYV4Ek7uYV
    9yDz+hADhEkZTT1WG8fBE3NgN+MScdedDTuF7WgTwHCFQ8+sB4kSGQSZSsxCIa1zipJne9
    /pPHNHBBKe/JI+o0/L3sqO77LwdN3Bdq/kl4HC8SasJ5RpaLc2AiBomdasGIuTPcFJo8oS
    eE7Y/1pkhfOLrxfdzAwiQziU1sY3JuRhv+pD2z3qNEy2M9dFISatkjuSvezbW/yG2u1iVp
    Egorg2Ca7lxPUfMrowWzWJzum06DVT1b9QPvYwwDdfFkp4LCXMY3ii2A8IKYhq7wUQNMdH
    QfBN2qPN9qZHYfQZNfihp8CkP36S7rLw+XAopexv/OMPmmomRLP09kOCF2BPw32LEdWJHs
    GS98caUdVu5EvxkkCDTrfbXvJTKTCOCEvcyYpi6CEKjPeX/LnwB1mG8mWlUedrJko9EyFm
    he1v4Wx3wsI4bFnRF2hsULeqEA/O/o4vvuUwae7pyQJRIuMKSPAD30SIrX2QLQiYp7YjDi
    O6ZunosYQHpUPoz0bpi8p/HyX+bbQpH7fwKF58SGqdGK5o5f+LweSH3S/Hf877ZbQo0PED
    8mV63kYQAutKzaHF0KLIKvfrTMjXYI9acSMobxFU+6sRiwUR6UIstSrbpVlA
X-ME-Proxy: <xmx:Bgd8apkkcu_oPtG4b0LHhb7m3rC7o6OhBNIeU42syTIkoQ2l47rjsw>
    <xmx:Bgd8atyITdVZ1gq41MVZX_iwJCoQ-3GMLdm4fERNcdexXvY_IjMdDA>
    <xmx:Bgd8ahnZYAt1UI2Ooi0VrEEnWDK2fxV_2JRndy4UFUs2EfsfacGrHQ>
    <xmx:Bgd8ameY6YeHQXahI3rrgTapb9Mdiu4mdNGc2tG9xB356UXK8PzLyw>
    <xmx:Bgd8alsK37bqnSa2IYBUUSAfIBXoqPSAGyl5r7B4Y2mXYDBzeFj0se__>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 01:39:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a95d6e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 05:39:14 +0000 (UTC)
Date: Wed, 12 Aug 2026 07:39:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <anwG_yIy0eNsZi2n@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260810-pks-odb-eagerly-prepare-alternates-v1-1-f0fa4a4004e1@pks.im>
 <anuP0Mh9aBz9VdBK@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anuP0Mh9aBz9VdBK@denethor>

On Tue, Aug 11, 2026 at 05:04:58PM -0500, Justin Tobler wrote:
> On 26/08/10 03:33PM, Patrick Steinhardt wrote:
> > When registering alternates we deduplicate object database sources by
> > their path so that the same source won't be added twice. Ever since
> > cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> > this duplicate check is backed by a map keyed by the source's path,
> > using `fspathhash()` and `fspatheq()` as hash and equality functions,
> > respectively.
> > 
> > These functions are problematic in this context for two reasons:
> > 
> >   - They implicitly depend on `the_repository` instead of the
> >     repository that owns the object database.
> > 
> >   - They derive case-sensitivity from `repo_ignore_case()`, which
> >     returns a default value in case the repository's configuration has
> >     not been parsed yet. Object database sources may be registered
> >     before that is the case, so the answer may flip depending on when a
> >     source gets registered.
> 
> Are alternates currently always registered after repository
> configuration has been parsed? Or is this an existing bug?

They are, because of the lazy-loading. So this is not a bug, we merely
have to ensure that we retain this behaviour.

> > Overall it's quite debatable whether all of this complexity really is
> > worth it, or whether we should just linearly search through all sources
> > to find duplicates. But the mentioned commit cares about cases with
> > thousands of alternates, and a linear search would of course regress
> > performance quite a bit. This doesn't really feel like a reasonable case
> > to care about though, but I don't feel comfortable regressing it anyway.
> 
> Ya, my first though here was also whether all of this song and dance is
> really needed for alternates. There may be someone out there with tons
> of alternates I guess though. Probably good to be on the safe side.

cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
mentions a repository with 100k alternates in total, but that's an
artificial testing setup. I doubt you can get any kind of reasonable
performance out of such a repository, regardless of whether on not
parsing the alternates is going to be fast.

For now though I didn't want to remove this infra. It feels overblown,
but it's not an unmaintainable mess, either.

Patrick
