Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321234AB01
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565963; cv=none; b=sbteCbUgI+k1Eho7/ZNycGHhB+wSIUrEIShgQeUyDI5fXgUt3AqLE3CjgZavuyv8eKYdWh4BfaejEO3ZK/zNjgmywd4LCvI4GLFOoH5D7x+cY0WhY19TjkSXh3/WNR6DOyKnlTwNPeOXtseWIQO/w3rVsmaTQMea+hkyxgZuESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565963; c=relaxed/simple;
	bh=QrkhUBZr4grhdC0P2QP5djbaNbYvzLBIY6nenuUnn38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB+BpOf/TpEcLLqyWysUXjtGH+J6nuvFNubrVIjG3u1H7KZKIa+HLc+B6tcwpwWnL9CVoF+zGeNkg4BD6RkGMZYhBO4nlYOSmec8llJYmM3rYlXqSR/85XiOeNk1sNNlzuh1em+RlGN3tWFTJCBTFjsAmO52MARs3J7pz/CCDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BYUh32Mb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BYUh32Mb"
Received: (qmail 63658 invoked by uid 106); 28 Sep 2026 03:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=QrkhUBZr4grhdC0P2QP5djbaNbYvzLBIY6nenuUnn38=; b=BYUh32MbyXAmspsnKhHqyKTs3WBaR5RlsP3ugY4Xcfv7PT1P08epi/z+q71Ujdgib/phu0S29Nd1m0dG+Oo2ZvSsI7jFjFuc1DjDjnS8X4K8ugSN91lXIeDBhv8IoW6oQ5ujCX3/a2lPaZBDm6a7nCqRiNeWEd5OZl23v4/H1LGKRiamv1npPbzQkcWGORoKfs1yRJbimWMXIDPAQCqKhySzhgJ8/jKbZCXYYHkfZ4YrQUYS4D2n98/Gw9GQUjJXKwFf/aqFwrikV6YQOfaE+R0zCqVn+V5tEl8eocHPfjef4bzr/39lMY/IZ484orH3HJzM7sFMvMJ000b8WPMW7g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2026 03:25:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 237773 invoked by uid 111); 28 Sep 2026 03:25:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2026 23:25:53 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 27 Sep 2026 23:25:53 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] revision: handle argv movement in
 parse_revision_opt()
Message-ID: <20260928032553.GA493672@coredump.intra.peff.net>
References: <20260925203359.GA1506705@coredump.intra.peff.net>
 <20260925203958.GB1544493@coredump.intra.peff.net>
 <add1abaa-5d51-43dc-9907-d6d3851004f5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <add1abaa-5d51-43dc-9907-d6d3851004f5@app.fastmail.com>

On Sat, Sep 26, 2026 at 11:00:05AM +0200, Kristoffer Haugsbakk wrote:

> > Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> 
> I personally prefer the email that I use for commits:
> 
> <code@khaugsbakk.name>
> 
> (Which has always been the case. But I didn’t want to disrupt the
> process previously.)

OK. I pulled it from your From header, of course. :)

> I ought to send in a `.mailmap` change with my canonical email address.

We don't mailmap trailers, though. I have a patch to let you do so with
%(trailers:mailmap), but you'd still see the original most of the time
(since git-log, etc, just dump the raw contents and expect the trailers
to be readable).

> > +test_expect_success 'unknown revision options are reported correctly' '
> > +	test_must_fail git shortlog -n --no-such-option 2>err &&
> > +	test_grep "unknown option .*--no-such-option" err
> > +'
> 
> Just thinking this through. This is a regression test indirectly related
> to git-shortlog(1). So the test does not name `shortlog`, so that’s good.
> The subtlety of the previously discussed:
> 
>     Making things even more confusing, it only happens if there's
>     another option before the unknown one!
> 
> is not obvious from the test description, but one can surmise that it is
> needed since it’s there in the first place.

Yeah. I sort of assume that anybody wondering about the details of a
line of code in this project will be able to dig around with blame or
pickaxe. Perhaps a comment could help, but I think anything beyond "it
is important that there are two options here" would end up re-hashing
the whole explanation in the commit message.

> For the next readers of this test suite that come along, it might seem
> strange that this specific sequence is tested for, and on a shortlog
> test suite. But it seems normal in this project to add tests that, in
> the context of the file alone, might not be obvious why they are there
> (because they are regression tests for very specific bugs). I could
> imagine some system where regression tests are marked with some
> identifier that however indirectly links back to whatever triggered the
> fix. But for one, this would be a new system/convention and wouldn’t
> make sense to use on just one test. And second, this would just make it
> more directly accessible; it is still directly accessible for people who
> know how to query git(1). Well, maybe more indirectly as time goes on if
> the test is changed and you use the “pickaxe” technique.

Yeah, exactly. Both patches are really bugs in the revision /
parse-options integration function that just happens to be triggerable
by shortlog. Possibly something like t0040 would make sense, but it
feels weird to be sticking a shortlog invocation there. I dunno. Again,
I sort of rely on people to find the relevant commits.

> This is all to say that this test makes sense as it is written now.

Thanks!

-Peff
