Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037E21D3CC
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908553; cv=none; b=rNDuwkm5mKorU80+HpjqW9W4rAOI35pYwjppuWTSv/QqjXWSVy7u0do8ygSaX4PCarXw4fJ8MmOneVplXleGnOcoMPdxgoecEjNAwHN35gkU92lhjXICnFn0yqEc6KCO2uXUYYXtqCTeKlb4NxJJz9RLtWFgE2NfloKJy7OHlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908553; c=relaxed/simple;
	bh=mitUPD7OpKoM2OTfKnCCCl6vo2USkYHcg6uSO8Y5id4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSc4HCMERC1atJKeHYuJ0ELQA2zzBGuxT/D368Teu2vaE+So86LllbJGL1SqztxN/D9YVcrjpjLm/c+aEaNZUTmBlJ+Bsoty+PEfLI3Y1SYlwUmeJPCKSwAI3e1oDAYh/SJlMw6qG4nxlGYZAackgJJog8sHTGyyWQ2t3l0WVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IKO/1vp4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IKO/1vp4"
Received: (qmail 27208 invoked by uid 109); 19 Jul 2025 07:02:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=mitUPD7OpKoM2OTfKnCCCl6vo2USkYHcg6uSO8Y5id4=; b=IKO/1vp4BnccuQmRK3Mj+eIrv4YllfVjW/+LxwPtyaVo+DCnjKjCTtJIcb+B+f98nA5M2yULsD3FoFOxPkpvcHgRii7h7ijNiXJfHdf1b+265c0E2QA+FbfpHK+D0qgVrEeHd5NCwWSBkOZZouZ+DpWrdzSe9BfyqXqSDpxuxkWVoUGyGldPdWblLxqIxGhVXyGL/FuP4MKgoMpFuaLfSCHbh6sX5Uuyc901pyTopJ954B61kZkgADR9kCqyGGQRxgQjUddllD9M+nDvTRyM+6oD2orAnYPlEIesocIKcHJs7HNkIIFAZ/1x+hnhGyjU3oC461gtmfUgACKLcfbDmw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 07:02:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4652 invoked by uid 111); 19 Jul 2025 07:02:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 03:02:34 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 03:02:29 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] prio-queue: add prio_queue_replace()
Message-ID: <20250719070229.GF705356@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <cbabed69-b44a-4920-9a56-e81b404be2de@web.de>
 <20250716050933.GC1396022@coredump.intra.peff.net>
 <298dd1d6-7756-4ecb-9202-d77491541253@web.de>
 <4ed087c9-0229-4219-8cbd-55f9ee79ca35@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ed087c9-0229-4219-8cbd-55f9ee79ca35@web.de>

On Thu, Jul 17, 2025 at 11:20:53AM +0200, René Scharfe wrote:

> > I thought about building this optimization into prio_queue_get(), but
> > that would require prio_queue_peek() and prio_queue_put() to be adjusted
> > as well and all prio_queue users would have to be either made aware of
> > the not-fully-heapified state, or prevented from accessing prio_queue
> > properties like .nr and .array.
> 
> Here's what that would like like.  .nr and .array elements are kept
> consistent at all times, but the root item is not in heap order after a
> prio_queue_get().  That's good enough to enumerate all prio_queue items
> like commit-reach.c::queue_has_nonstale() or
> negotiator/skipping.c::push_parent() do.

Hmm, I agree that _probably_ we'd be fine as long as .nr and .array were
always consistent. It does make me feel a bit dirty to violate the heap
property in a way that callers can see. I guess the argument in favor of
it would be:

  - if you are directly walking over all elements, then almost all
    ordering is out the window. Yes, the root item is supposed to be the
    min, but in a heap the rest of the elements won't be sorted.

  - if you really want things in order from a heap, you'll be calling
    the get() or peek() accessors. And that gives us an opportunity to
    lazily put things in order.

I guess one alternative would be to make the array private and require
some kind of foreach accessor. True struct-field privacy in C sucks.
You have to hide behind a pointer, so there's runtime cost, plus
iteration requires a clunky callback rather than a loop. I guess we
could call it "array_" or something, and provide a foreach macro.

I dunno. I'm on the fence.

-Peff
