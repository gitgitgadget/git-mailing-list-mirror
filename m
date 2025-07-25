Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BE239E6B
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441992; cv=none; b=ku54LlHPAI38ri/J0dtXD8L3INDbMsH+TmyMIMlsDwMAWaDqBPneZH61MRiS9cY2ZuJas0UESZFRlzwBRSUcJYp6AtN3+byzTq8pt2M988HA0slc0RSVkqZC4N1Z261GWxGzdzPly4I+0nL9w4lcmmsONfHQKGXJXXTJdhpJDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441992; c=relaxed/simple;
	bh=AhCFWahz2Yc7QrIbId3iNm0h4mKKi1orI8pzwcnfNOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw5Zj3Hy8jEanhmFZf1ctnwyx8AW6LeLIxC4w0ye5+S7WfcscYrQJj3yYyHr0Hzz3KAwn2qZdSEbnmLBicuypqaGxqUXfJu0hoT6AauuHNH91F3LgspIqsPAhv+XwF3s9pG2EfJ30KsT6ENYUgxqI0MGvWKM2kSClIALfpq75Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EJBh4gP5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EJBh4gP5"
Received: (qmail 26198 invoked by uid 109); 25 Jul 2025 11:13:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AhCFWahz2Yc7QrIbId3iNm0h4mKKi1orI8pzwcnfNOs=; b=EJBh4gP5AxEBO0Bvn3wID5e3M/mFSUUvXuX4ZVYzIbA3Ad0/wmaL1gneTbic61ZeJr8pe3cySZFQlF3mQ6H8X+0AkmGiGQCxzqmUwn/fSIwoZtqc3HZG7meQVnDe7BHWrjQxIkqos9U8f8cXyNPk2DpzcmICy41YQzJyMyM55bM0G0eqtXiHFuAIY/pTXzBwmDM/08wYFAEemFpRxPd9brP14T0q5W+3VPrltdjr3rqmk5liUjxQzSBA5SEvmByl75gfBPlu78SbkBg+W71dOutI5xfPX2dB7Xvd/RAT9MdpDilUyw7tMUJ19bcKOAK5keTzpaVhFKh85PsyQl0PNQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 11:13:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21145 invoked by uid 111); 25 Jul 2025 11:13:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 07:13:09 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 07:13:08 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <20250725111308.GC3014187@coredump.intra.peff.net>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
 <20250724104536.GA1316505@coredump.intra.peff.net>
 <aIIf7S5iPspktxdw@pks.im>
 <aIIvHxR8wXLTCgMW@pks.im>
 <20250725110243.GA3014187@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725110243.GA3014187@coredump.intra.peff.net>

On Fri, Jul 25, 2025 at 07:02:43AM -0400, Jeff King wrote:

> On Thu, Jul 24, 2025 at 03:03:27PM +0200, Patrick Steinhardt wrote:
> 
> > I've quickly hacked something together now, see the work-in-progress
> > patch below. The patch does not yet handle reflogs, but that isn't too
> > hard to implement.
> > 
> > And these changes indeed speed up things by quite a lot: instead of
> > hours it now takes 7 seconds :) I'll polish this patch series and will
> > likely send it in tomorrow.
> 
> Cool. I agree with all of the pain points you outlined, and the general
> direction. There was one other sub-optimal thing I noticed, which was...

Oh, and I meant to say: I am very happy if you want to pick up this bug
and fix it. In the original I mentioned also that the new
remote.*.followRemoteHEAD=create logic was kicking in for an unborn
branch. And I've verified that this is the case and am working on a fix.
But I think the two are orthogonal and we can fix them independently.

-Peff
