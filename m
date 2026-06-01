Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B3273D6D
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293366; cv=none; b=BYYWN7FyLCT6a832252jlqFaZdfLMM8ns/KtK5n4K8XRhKD3rOWctsRxQrhRSUsaFRj4GImFyDRveUtNJbM5O+fQ/AX0+fVTJg7Jy5PnpQrZQpFRVvSY7XjJQdNVlxL2u0Ck1sG3a8MFyjpDTv4OxrmRM3P7XYyzPtoZzadiU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293366; c=relaxed/simple;
	bh=+WayiHI66HO7dMUfCWyVSgoolMcVOKpqjiA+Bpk5qVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAc8/WaEw9i/Xgwmz8Y1DIHtqyfkf+X2eVi3QzL3qq0rMn7kadlnXMs5Ka3eJ+KCw1JCvpYvtumYmwXxoladIHJWz9EHas7S5rZ06HN0N8HqnxEP+qrQSAFsgT8b4eMSeT3FJx6uCvEE/tgakIQLPjZ98MKKnvFi+6hMleVhaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=boKBkaQG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="boKBkaQG"
Received: (qmail 24972 invoked by uid 106); 1 Jun 2026 05:55:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+WayiHI66HO7dMUfCWyVSgoolMcVOKpqjiA+Bpk5qVo=; b=boKBkaQGWxYO82wfXJNcwOAMP8ZXhP2Er6xNBPxXPKsTPN01aKL5+aR9K7xz19y7LiZL1xgMjYRch27IgwY44YXK51jnFOY4PcOfb9F/1gIyplaSgTXOubrGny8LC7k21hpj5xkFG7ItL0PQnhNk7vbqhPSmtD+h7hiNV1vB3Gn/+ficNhfJX2FFe7BJ2zVlGTXd8Y1TzUAuwP0QmCYUPWwmMxUlLg7IxC97kBOqv9gqmdQwkgjNdBtoIgjxGJdYD37CcLFqlrRbarS139WT30yVJkLIisS8NJQQE7DX1Pvhw8q8zWpPwkhdNSEy9qc8AIfK6PpEDqQ6y0WgQiuzhQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jun 2026 05:55:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 56434 invoked by uid 111); 1 Jun 2026 05:56:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jun 2026 01:56:00 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jun 2026 01:55:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wesley Schwengle <wesleys@opperschaap.net>,
	Git maillinglist <git@vger.kernel.org>
Subject: Re: git hook question
Message-ID: <20260601055555.GA16637@coredump.intra.peff.net>
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
 <20260529052141.GA1099450@coredump.intra.peff.net>
 <xmqqcxyaakpy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxyaakpy.fsf@gitster.g>

On Mon, Jun 01, 2026 at 02:33:13PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think so; the command is expected to handle (or ignore) the
> > arguments as appropriate.
> 
> We should also caution that the command is expected to handle not
> just the arguments but its standard input.  Not reading any and
> exiting may be a no-no for some hooks.

Perhaps. I think we've tried to make Git resilient to hooks which do not
read all of their input (by ignoring SIGPIPE). It may be a bug for a
hook to ignore stdin, but depending on what the hook is trying to do,
that information might or might not be relevant.

I do think there is a gotcha for hooks that expect the stdin of their
commands to be hooked up to a terminal to interact with the user.

I certainly don't have any objection to calling more of this out in the
docs, though.

-Peff
