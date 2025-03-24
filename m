Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D7157A46
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847228; cv=none; b=cQFwUbl9I2YSmDSupZxX2oSdpiHiNrLwFWojypfR+uLTcZ5/4KuBnPrvPCN3Eid9YRUaDGk/O2ynKFnmlpAV/X8ShjG4K16zgKJWEG74IPUaS2cHNoKsv0MHeNdHZodP9KEs6Ic842Hf/zQ/ABbkEZ938/6/joeHBua5Q2Hk4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847228; c=relaxed/simple;
	bh=xHdn0rH7bl5oLjKgAIR85IGD9jFKZ9lRDO4yPULvjYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXllMlKFbdHIZHGFg9A8GDWVQujrQG0k7hnbl0+RFpGFtyb1ZnPzJLJ3dgQZfjnRyK2LoM6qP5cZcCs/wSyDNtif1FAoThm2WrcX9sdW1kA/dSnloncd+aLwyeIjpK3PrS7dM3bgMoZG2JV9w2ftwjpazm+xSeWpvKKXbScSTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iTDF0D9Y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iTDF0D9Y"
Received: (qmail 22827 invoked by uid 109); 24 Mar 2025 20:13:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xHdn0rH7bl5oLjKgAIR85IGD9jFKZ9lRDO4yPULvjYw=; b=iTDF0D9YUXgTZDz57eq+9OWqDxlTGGoVbVSiO4Gb+LuLSzqvo/nauMua8WRDBxop/NWCQ6pNsxIST9eTWhsvDnK5v+/T0Jbno+btA/6tU6u0GzkLDwHBTCrag+yeqOYDtr863Dq/ju6sVBoI10FmQSIgRKSHHHfjYFe+jH0C3VXNgzcJ4WBdLlBNAB9+2Q7dV05cebvBnQxTA7LfRtjNxbWYXN9fVlOa+SQ5NrpPOo3NeMPLMeXlypCjgVm0Cg1XOrz+IM3y+9myms4v6yAqalCZk6BdWLSJBpTXi4TAOy7wR1GDnFYqxajxLNy9uRENac1TrschYoEjzuxKc4tSbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Mar 2025 20:13:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4537 invoked by uid 111); 24 Mar 2025 20:13:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Mar 2025 16:13:44 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Mar 2025 16:13:43 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org
Subject: Re: [PATCH] bulk-checkin: fix sign compare warnings
Message-ID: <20250324201343.GA777700@coredump.intra.peff.net>
References: <20250321200715.3338-1-taahol@utu.fi>
 <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>
 <20250324025300.GA690113@coredump.intra.peff.net>
 <CAOLa=ZRkzp6A+S-bqbUMnkovazrczFi=B8tG06xqTzsNQB2enA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRkzp6A+S-bqbUMnkovazrczFi=B8tG06xqTzsNQB2enA@mail.gmail.com>

On Mon, Mar 24, 2025 at 07:48:59PM +0000, Karthik Nayak wrote:

> > However, if you switch it, then we get a different -Wsign-compare
> > problem: we compare "rsize" and "read_result". So you still have to
> > cast, but at a different spot.
> 
> True. But this would be better in my regards, since this would directly
> follow the
> 
>   if (read_result < 0)
>      die_errno("failed to read from '%s'", path);
> 
> code, so a `if ((size_t)read_result != rsize)` here makes logical sense
> since we can clearly see that this section is only reached when
> `read_result` has a positive value.

Yeah, agreed. And after doing that, it's probably the right stopping
point for this patch.

I do think the safe_scast() thing could be a good general tool for this
kind of case, but I'd rather not hold up an immediate fix for it.

-Peff
