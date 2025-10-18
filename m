Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BB944F
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781413; cv=none; b=Ar+/nYTqgWGF7an/slJXRwJcHBbZTJ7+awiSd4I0iaWFBusJbb+c0Mj6E782s+Q//u2CM8J5+7U6Rl/OJd2QDKLiP4UBi8fsYejtYmW/zKNji4SyXwIQapeJ0TSLnMawcVfv2Vw3nZ3DkysOztuDWsfqCBtEJ3V+JAZ6QMPOgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781413; c=relaxed/simple;
	bh=r3hWBffaBMacOqIhhEHCbVFoBKtEHKPrz9B8lhGBoD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUl9CvWV7sQpVtlwATXZt4d/H5ID8zIEANHu2CFtQSQgGEgI5PY4L1pqVSdwCz+b5fIXnVtKoACEAmpD67MWkSDEYVzVHTETc/glWyzXwfJ9mgM1G8POSDJFPfWo502DTRzWqoVW6ofhXQMdfmGLO+baLrUPiY/A8Iuutti0f9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GtgTjDYM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GtgTjDYM"
Received: (qmail 261299 invoked by uid 109); 18 Oct 2025 09:56:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=r3hWBffaBMacOqIhhEHCbVFoBKtEHKPrz9B8lhGBoD4=; b=GtgTjDYMktOtPLZih9GMnM5zTKtEeUehCpUwYk+8i99KUVbI36YQGmzYiCANPhk/TAsGxwH9RR8bWL+wJXLOIL8jcvq9rbdEOkTI/Wag46yEhnggrvVs3LWsvHbGicRtt4dHsXaPyTDk6aVOTfcRkLSvAyUw5VIqWD726DVMQlzXJpAm+C9WgpeNDNTHtRjqtE9gAOvkE0kHgvIQYIhpP4Zk/EdM1KX2tiy3WKccRwmQh8Cq43YTUjFZsFnrq5oJCmPfKJ0ydqdZeexnFcW1xlkOJWegTKqOwhHcEQuClXqlikGlnkC1DXZBC5pW6LTHt7NT1LKkHcjCenyJ8dBTnQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 09:56:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 409887 invoked by uid 111); 18 Oct 2025 09:56:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 05:56:50 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 05:56:50 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
Message-ID: <20251018095650.GG1060824@coredump.intra.peff.net>
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
 <xmqqh5vx1p0q.fsf@gitster.g>
 <6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
 <20251018094722.GC1060824@coredump.intra.peff.net>
 <FE99A260-ECD9-4B39-9E31-B4E842DC7D04@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FE99A260-ECD9-4B39-9E31-B4E842DC7D04@gmail.com>

On Sat, Oct 18, 2025 at 05:50:56PM +0800, Lidong Yan wrote:

> Jeff King <peff@peff.net> writes:
> > 
> > On Sat, Oct 18, 2025 at 09:11:34AM +0800, Lidong Yan wrote:
> > 
> >>> Test that exercises "git diff -I<regex>" is in line with what the
> >>> original b55e6d36eb wanted to address, but given that we saw a
> >>> recent regression report like [*], I would have liked to see "git
> >>> diff --quiet" in the test as well.
> >> 
> >> I will read Peff’s test and see if I should also add some similar tests
> > 
> > What I was hoping was that we'd apply my patch, as a matter of release
> > engineering (backing out the regression-causing bit of b55e6d36eb). And
> > then you could make more-specific fixes on top (since -I would still
> > have potential problems). And then you don't need to add a test for the
> > regression case, since it's already there.
> > 
> > -Peff
> 
> Sorry I sent my patch before I noticed this message.

No worries. I just saw it, and it looks reasonable to me. So while what
I wrote above was my preferred outcome, I am OK with doing it all as one
patch, too.

-Peff
