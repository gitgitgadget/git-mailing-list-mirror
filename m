Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294935B150
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425016; cv=none; b=CCoWr2+8H+0eiMxAQ6wobEqPlRb/3oZbmu0vBARag5fTxPKHrSTf+n3p8xudYX4U0QZh9Vy/PfkA0VKVyfUrl5U+vo3mOloAAkAFPvQ8CpxqBOn6zgNo2y8O7jIyGDKu/KstxwqK0rFWqbp5r5cIZtMMtNTUaNl/zUgJd0Ekyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425016; c=relaxed/simple;
	bh=nVixjuPKcfM1kHDO8eIGAxD+VGMG9n/OTL7syS8BIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKAtgvT5y6PN+NC93f6BjS5FbLA6gLJGPuDibBAElEn9imM2LWoQOk67gwrsh+mZCtC6had2tJ0zbKFr0QuUOGKMuJa+1SGL3pTTOPgzRFC6zsYe+hHlRqOLQ8zNCvixdTh7giQSP3phT2xwnsAwL+9MslvPs/fMRbcnzNwTiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KTozjKDT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KTozjKDT"
Received: (qmail 41716 invoked by uid 109); 14 Jan 2026 21:10:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nVixjuPKcfM1kHDO8eIGAxD+VGMG9n/OTL7syS8BIbI=; b=KTozjKDTLVh9dfUt3pJrLVWcnrohBgMa8NbIwd/nbdz66EnURsz7ZusSn1qkCvCMYBfl4B6Ne270Ab1GWRdTyMIGVNr72/zKnzwl54xsjegi6BvM3EaGxRXI8JkTpojC0Wq/i2+BrzdEX3XKhJb3wsr9MzxlW1RoSy9E8kMCCn01gNgob5ttqowqh6IvQFlkrqTSiP2+iNFvkm9K6Hl+EIAkyg/w+tParEcBYf+y3R13Yr0pfMMqPAmTZ8uwIvClMtD5d+MVtTA26EFcV2nev/Z2O4oGkSLZ8MxyP15GTQTVC7YZfSnYo+8TFP2K/cbfJ2yof3Uq44pkyA/oB8rEUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 21:10:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 69926 invoked by uid 111); 14 Jan 2026 21:10:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 16:10:16 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 16:10:13 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
	gitgitgadget@gmail.com
Subject: Re: Triangular workflow
Message-ID: <20260114211013.GB1008851@coredump.intra.peff.net>
References: <20260113170321.GA265671@coredump.intra.peff.net>
 <20260113183557.7991-1-haraldnordgren@gmail.com>
 <20260113214059.GC288857@coredump.intra.peff.net>
 <xmqq8qe0f2iq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qe0f2iq.fsf@gitster.g>

On Wed, Jan 14, 2026 at 10:54:53AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And having the extra output from "git checkout" is just extra noise for
> > me, especially because it is easy to see only the second message (which
> > looks just like the upstream ahead/behind message, of course) and get
> > confused. The first time I saw it I thought I had misconfigured
> > something with my branch.
> 
> It now is clear to me that this should be _optional_, so that those
> who do really want extra output from the command should explicitly
> opt into the feature.  After all, any optional new feature that you
> must opt into by definition cannot regress end user experience for
> those who do not ;-)

True, but then it also cannot pleasantly surprise people who didn't
realize they wanted it.

Having your user experience regressed and then tweaking a config option
to fix it is not too bad. The deciding factor to me is whether more
people will be pleasantly surprised or annoyed. ;) I don't have a strong
sense there.

As a general principle, though, I think a reasonable path forward for
any behavior change is:

  1. Implement the new behavior, hidden behind a config option.

  2. Wait a while to see how people like the new option, and shake out
     any bugs.

  3. If people like the option and are puzzled why it isn't the default,
     then flip the default on.

In other words, let the utility of the feature be proven in practice by
people opting into it. There is a chicken-and-egg problem if they don't
know about it, but if it is truly solving a problem people have, then
hopefully some of them would look for a solution and find it.

End philosophical rambling. ;)

> At the same time, I suspect that extra comparison on top of what we
> already give against the @{upstream} may not be limited to what
> Harald implemented (is it essentially the same as specyfing @{push},
> or something else?).

I haven't been following the feature closely, but my understanding is
that yes, it's basically "also compare to @{push} if it is not the same
as @{upstream}".

> I wonder if we can come up with a flexible and extensible notation to
> specify what branch(es) to compare with, so that we can use it as the
> value of this opt-in configuration variable?  Something like
> 
> 	[status] compareBranches = @{upstream} @{push}
> 
> signals that the current branch is compared against these two
> branches, and not having the configuration (i.e., traditional
> behaviour, which is left the default) would be equivalent to have
> 
> 	[status] compareBranches = @{upstream}
> 
> or something like that, perhaps?

Interesting. That is more flexible, though I'm not sure how useful that
flexibility is. I guess you could imagine putting in a static branch.
E.g., if you base your branches off of "master", might you want to show
ahead/behind to "maint" or "next"? I have trouble imagining a workflow
where I would want to do that often enough for git-status (and checkout)
to do it automatically, though.

But assuming it suppresses duplicates, then yeah, this feels like a more
flexible superset of the functionality.

-Peff
