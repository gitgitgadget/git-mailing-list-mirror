Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04009202C48
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398442; cv=none; b=Zo/k5hZqAFv0B2l4trM+vQc9EYcbckvFqyquCHpMzNJkefeDyGv5BWZ0EiF7xXGgRe3vIJ+RyCk3RdjGXpSOCFR5AZtg9rxHgWpCCDYZF42mwLQeoTIC/5xMHxLUPtWutax4mnlwd6dv2c6bq01u1jjpT/OzrvQKtBygkhcmnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398442; c=relaxed/simple;
	bh=62tx+1wiG6QWUUHSB+/QAHuQ+xR9uHTsxeSy32BCOtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtV9w8FBwovtkULjSUP8py9SrYpjWd5IcjYxunQq3iu2ofuRhneeBpSmiGux4bl/B25m4SINPlwcFzK0+zTjtX57MqmVR8qFKm3fepqYdqTLYbt9IJ4l7HVdfjqZ04PmTQzPvLjYTWFW1OtElvLuInApIgAQAK5+Ami4hLEUZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KmG24b+x; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KmG24b+x"
Received: (qmail 17109 invoked by uid 106); 7 Jul 2026 04:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=62tx+1wiG6QWUUHSB+/QAHuQ+xR9uHTsxeSy32BCOtA=; b=KmG24b+xhQ1keLOLTAerkZ+2GlJzOmwh8lze/6MBqdstVDXaADHL478WTZHuxWg5stE5HmZLJCC2WYsHV5unVoanmfr121oKUGfb23Mg0r1uRVZKIFDKimglc/KS6kHg99ZeEI9uVb3Lt5xGGDsn1Kcd261ID6O8Ai1XZNbLS0vkzy3OLO9chJxLG3Vo76AllqeeFU4l4js1+jHsDl70pPd/sfFOPc81oULaQ22T7gDaMyagFJQCVC/0WHtKfGOXGjiBbZmRPy0gbjd4G6ff3WayxMJu2joMADicB4xkO/gPT7KA5DoKAlXe0nwlBdRyfs47cpSa0HHnKcXw9MjV8g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 04:27:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21913 invoked by uid 111); 7 Jul 2026 04:27:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 00:27:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 00:27:12 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Trevor Gross <tg@trevorgross.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Haller <lists@haller-berlin.de>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked
 from commit ..."
Message-ID: <20260707042712.GA677056@coredump.intra.peff.net>
References: <20260705140931.98262-2-tg@trevorgross.com>
 <20260706002415.GC2301945@coredump.intra.peff.net>
 <5d238e0d-18ba-429a-a9a4-a3988b00e1e1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d238e0d-18ba-429a-a9a4-a3988b00e1e1@gmail.com>

On Mon, Jul 06, 2026 at 11:08:18AM +0100, Phillip Wood wrote:

> > To be clear, I don't know the answer. It's been ages since I've looked
> > at sequencer code, so there might be more gotchas. That's just my gut
> > feeling from a high level after reading your message.
> 
> I don't think it would be much work. The code that edits the todo list is
> rebase specific because it deals with rebase.missingCommitsCheck but it
> shouldn't be too difficult to generalize it. I do wonder though if it makes
> sense to support all of the usual commands when cherry-picking especially
> with `-x`. In particular I'm not sure about adding support for `edit -x`, or
> for `pick -x` followed by `fixup` - what does the trailer mean when the
> commit has been edited or fixed up? (though if you're back-porting bug fixes
> I guess some degree of editing is inevitable)

I'd probably err on the side of assuming the user knows what they're
doing, and will mention any edits in the commit message as appropriate.
Maybe that's being too optimistic. :)

> On a slight tangent I've sometimes wanted to be able to do
> 
> 	git cherry-pick --exec 'make test' some commits

Yeah, though in that case I'd usually cherry-pick and then just do an
in-place "rebase -x 'make test'". You could really do _almost_ any
cherry-pick sequencer operation like that, which is perhaps why we
haven't see a huge number of requests for it.

This "-x" thing is special because it's inherently about looking at the
original commit id, as opposed to fiddling with our rebased version. But
I guess you could "cherry-pick -x" and then rebase (doing whatever
rearranging and markup you wanted) the result.

-Peff
