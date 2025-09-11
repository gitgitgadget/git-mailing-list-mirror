Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDD2C2ABF
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623447; cv=none; b=XNpa5SpeG9a6JYtl7aPIpwBX1wHOkaTtCCnegMK3H+BL2g8b5b1ZjTD+NmGg2TtlEYmH7StpxIJ9c6gFaNQGY8NllTRF/V+tySXg4dsVqwmMhxTc2xSBXDCxEV0uDm1k4CVnuByXo6NAQnuuBux/KX+vWPBC0X6XZpIsRiI3OO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623447; c=relaxed/simple;
	bh=5RQ5O6fRGlyKgGDk/d5Uqf6FAmsv5NDtq7C0yCut9J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYxB0CCO7o5hxHq3Fov5iY4YKwqhliWdZbupNtcWhg5PINnPKpcCobva+gr7GspUd6Ob5XRKUvArYvg/8XrTNNA1cue1bZA2r8jgLEE/uVSfOXuJDsdhmhIF2Pjif0BVtdo2L0WvkaAY9b7s7uYBWcEoD+5T7qNFT4tg974tKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fuoP4ozg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fuoP4ozg"
Received: (qmail 57101 invoked by uid 109); 11 Sep 2025 20:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5RQ5O6fRGlyKgGDk/d5Uqf6FAmsv5NDtq7C0yCut9J4=; b=fuoP4ozgLLeLQjFnybJFLXQKInVdEdWSh3vsWMc0RFWXjSvf5U/Yk+LYDdp2ze+7D6wzESw1bJKyXit1HBQGEuGjIDC56BsK/+z0Uu6s2cqH40rq7zeqfGLg+zVZGPodrpoXkENln3EJEpljnpVw9X2gMcxrjCxGftYUDtQtJC99wgFy2QPfWqcTSM3IMKzFjg2nIcoI7wn/LI4t57kmmUkYoCMQQdWg5ZjxkPUj/9H6bovn5hvxNlJM88PYNicQ6RIZw0zY/J0DiaUkzGfllOMqL/tHQCZ2sG6meO334MTThgEfx9rOQTID1CW4uws97mULnvF3dMOfAV+1acnwhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Sep 2025 20:44:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 90862 invoked by uid 111); 11 Sep 2025 20:44:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Sep 2025 16:44:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Sep 2025 16:44:04 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250911204404.GA1907215@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
 <20250910154859.GB562601@coredump.intra.peff.net>
 <b39ba543-24ad-4bd6-be6e-dc1b8a416eb0@app.fastmail.com>
 <20250910183418.GA1157772@coredump.intra.peff.net>
 <eefc3524-9ecf-44e5-a6ba-1b4a0aff3158@app.fastmail.com>
 <20250911203256.GA1894340@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911203256.GA1894340@coredump.intra.peff.net>

On Thu, Sep 11, 2025 at 04:32:56PM -0400, Jeff King wrote:

> On Thu, Sep 11, 2025 at 07:31:04PM +0200, Kristoffer Haugsbakk wrote:
> 
> > But it turns out there is a regression in my code with the recursion
> > detection.  Compare:
> > 
> >     $ ./git -c alias.one=two -c alias.two=two one -h
> >     'one' is aliased to 'two'
> >     'two' is aliased to 'two'
> >     fatal: recursive alias: two
> 
> Your example there is a little funny; "two" is recursive to itself, even
> without "one". We detect that case in handle_alias(), and we would still
> detect:

Also, I meant to say: good catch. :) I did not even think about loop
detection at all in my suggestions.

-Peff
