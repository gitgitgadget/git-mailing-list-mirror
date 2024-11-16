Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220718FDD2
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731727150; cv=none; b=SWniaBuwUJv1pH0RIn7rbNw83OqWJcsWnsWTxxn1aIeEq4XJMkTnQRuPRFi+1mMYg1sfw8xyPMYGfBhSEWdojkpa9r3Qm4HqYryFDFXxt0SLVNnZc3mHizhJDSC6WYoAVRWNRvOPPZoyKIl+hWBZ0JNQ1wuh6DVCDMtrC51l66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731727150; c=relaxed/simple;
	bh=z8TTzzEOJsjtkVQuRW58MEMdZ+WWgu9TIozqUSaHEQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtFnVoVzAK9sMSvX6grNxURPehBwiWEaeCDGnNrENpkW65zd/htLGOWm6A6/FfO1q/bzflIJiIDXYm3qyqB3JsmEqTq7WXtQFYQaoA+qTZQ3Cmjh4B1uMAFB21y3BlbwiPge4hQToGICWd8rZomXDPMUKYjs/zCEhvaBk0EOjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y/B+mFMj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y/B+mFMj"
Received: (qmail 24862 invoked by uid 109); 16 Nov 2024 03:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=z8TTzzEOJsjtkVQuRW58MEMdZ+WWgu9TIozqUSaHEQg=; b=Y/B+mFMj6LHReFyTD6+Mw/SmBeA7hnpQPwt/6O87TLKPrmPe3TDo1N9kM+vJflttlXCuFz9QdKm5dmat+kicy/bwn7daTASFfAC49jmMEbglbgGN0mYyrrXqr+3os7PyzozqmTfYYxwSRbuLabDzEyqqbqvbSJ6sHC5iDwoVHbgIepQOLSz0ZF+v724xdOmDDwlcq3gf7FopgvNXm2eP5YkX7SUD+fbXm/B+F9U/pGIqqm13eRVhJ9el34qQBnijGY5IS7C/frRdjf87+X0Iwh6sn1/lPbZlTdHpEvmWnIz+YdKgyU6eCCHiMJw7YSrYji2snPlkcIoc6GxbMcYHeg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Nov 2024 03:19:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16245 invoked by uid 111); 16 Nov 2024 03:19:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2024 22:19:08 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Nov 2024 22:19:04 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #06; Thu, 14)
Message-ID: <20241116031904.GA1782074@coredump.intra.peff.net>
References: <xmqqy11kys9z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy11kys9z.fsf@gitster.g>

On Sat, Nov 16, 2024 at 08:46:32AM +0900, Junio C Hamano wrote:

> * jk/describe-perf (2024-11-07) 4 commits
>  - describe: stop traversing when we run out of names
>  - describe: stop digging for max_candidates+1
>  - t/perf: add tests for git-describe
>  - t6120: demonstrate weakness in disjoint-root handling
> 
>  "git describe" optimization.
> 
>  Expecting a reroll.
>  cf <20241106192650.GA912471@coredump.intra.peff.net>
>  source: <20241106192236.GC880133@coredump.intra.peff.net>

I wasn't planning on any re-roll here. I think I may have confused you
when I sent out the cover letter, followed up with a "oops there's a
small fixup I need, I'll send out the patches later today" message, and
then later sent out the patches. That "v1" that hit the list (and what
you picked up) is the fixed version.

So there is nothing to re-roll, as there haven't been any comments on
it. Possibly "needs review" would be a better label. :)

-Peff
