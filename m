Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EF142E7C
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023070; cv=none; b=aSnnXHtrq3URKzxHADD6GusXykVqyvLkqsHuP91LxmDkOVjhSAixNYtISgEmfLL0eZk4SqJJy4zJ7jIem8MBmFkoNJwLkDVE/ifbzGIDIw9pt/usIIVycPpxA2H0+LNGYqb5oAmP6yebktxGYgmbdWlAq6zy7Tg/EhAmPx3ccEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023070; c=relaxed/simple;
	bh=EaEvh0+5KCGoN8cURV2RyF1eD9ylmNx7d66qtUxlYi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND9MnIwKVK3RhZ2ix3Z36/ieQvcPSj9GMHK0db9rtNWR0dd3PvCVQjPbPG43nA347qgBposODt8yHxtLX6M/OR71yd6ByCJCiAQ+P8VdsQ3g8kw73CJ6ju9dvaI/BWND0RhwcjJ1KzVZRWYtOBUmlog0yCBaCd/F0UGWRjhOCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WRAjkQvN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WRAjkQvN"
Received: (qmail 12289 invoked by uid 109); 16 Jan 2025 10:24:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EaEvh0+5KCGoN8cURV2RyF1eD9ylmNx7d66qtUxlYi0=; b=WRAjkQvNrGEaZW3ulqY7OLT2hMEQxipghyMeBDJYX8A6nf8/Nn+rBr2XTBdi/fdz7XrctfcEQd66XQpcZdLk0hpA7HTHYPRM+WQKJwMMup6DfpV0/pEbZameBUWxPFYN3LOLRbMCmMyN2+zXt7/zG+Pb3NiGgSVIK+HfZNuwaK0fOoXhJqHxxVujf4elLSx/XRcsePB2vDvB7xH4HaZkkEkVgbrFguQOg4+LXjNoKIi/kJ/cbSFAcN/3x8DrPNZ5v2XWmiN6Yj1VsxiyID0B6BqmjxXoJhLIHZiyPE2TiS/47bvWh8YXsW1LysoVDOrHMP8bXegYk9FJSSfy0e6RAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:24:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23978 invoked by uid 111); 16 Jan 2025 10:24:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:24:31 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:24:26 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>,
	Jonas Konrad <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
Message-ID: <20250116102426.GA773990@coredump.intra.peff.net>
References: <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <20250115171423.GB57018@coredump.intra.peff.net>
 <xmqqmsfsx8oo.fsf@gitster.g>
 <20250115182419.GA86610@coredump.intra.peff.net>
 <xmqqa5brydz1.fsf@gitster.g>
 <20250115212952.GA96537@coredump.intra.peff.net>
 <xmqq5xmfyc4w.fsf@gitster.g>
 <20250115222728.GA132248@coredump.intra.peff.net>
 <xmqqplknvek2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplknvek2.fsf@gitster.g>

On Wed, Jan 15, 2025 at 03:32:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't know if we'd want something like this on top. If somebody is
> > interested in just doing all the conversions in the near-term, we could
> > do without the optional flag.
> 
> Ah, you are much more practical than I am ;-)  I was wondering if we
> want a list of "these commands have already been updated" and behave
> differently.

Heh, I started writing it that way but then got turned off by how
annoying it is to look up in a list of strings in bash. ;)

> It is a tangent, but I wonder how many among the 40 really needed to
> use usage_with_options() to react to "-h" in the first place.  In
> other words, these manual checks for "-h" are done only because the
> code _wants_ to react to "-h" before it calls parse_options(), but
> does everybody who _wants_ to do so really _needs_ to do so?  You
> already have shown that "gir branch" did not have to, and to me, 40
> among 100+ felt way too many.

Yes, I had the same thought. Unfortunately it is a lot of brain-power to
examine each one, with relatively little gain.

> > -		test_grep usage output
> > +		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
> > +		then
> > +			test_must_be_empty err &&
> 
> This may be a bit stricter than needed (things other than usage may
> need to be spitted out), but it is sufficent to declare that we will
> deal with any potential fallout only after it becomes necessary ;-).

Yep. I'd hope for the most part that "-h" would spew help and nothing
else, but I guess we could get hit with a deprecation notice or
something. I agree on crossing that bridge when we come to it.

-Peff
