Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3B28A72B
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620234; cv=none; b=buvP8qu7hJYHVH8146moWQ/xMUviJ1KRMGXewTCJdy/8gZaDWHMu4GQzMsf6sjVA7h0vjD3tDEOQ8XUeKfnlq69b4gy+vEaBjKWooRcXMDxyb6dcHcCPlMcABYb9XmaOTqj6K3Gh9/06az8r6JnKkVztDFbq8uMHJTnVmfVsr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620234; c=relaxed/simple;
	bh=1goK0/BX3dy9HZO57cBtZqutSZ+6iB7vCyP2/VzLrGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gApkdr4V7Fm2zcKYD3o7MxvCirveuYSJrUyrPwylsXT212/JVkBt2wfCRpIgGOMkhEHliZhIdQDmCe/ef6Z6o/i1FpgyUum9b+hPC/sIQ6Oxes+Ta8LEjU4EGnSvBx/sUVyAgtoK5AlL6/Imv3c/eXg9tXmx3Bwu1CksCzpmoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YGW8qfT6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YGW8qfT6"
Received: (qmail 339317 invoked by uid 109); 9 Feb 2026 06:57:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1goK0/BX3dy9HZO57cBtZqutSZ+6iB7vCyP2/VzLrGc=; b=YGW8qfT6aqGZpErQ6aiZX/MzieP8CRrCmHIxy8tZoLOLlU+PejWkE7qopSjUUMJ+QnBNdlowM+8vbdA/MzWSXjwOdwEnGnpsMbEOun7IzpmUKpoiKikobvEXG3FaoR2cA63yqTY3vUHGbFMwmJtJc8bG3DCpDQ1M5wtN+CwcC1f0hRwTUi/mPQ3Vbavr3T55CqBEbgsEp4/ocabh8KdPhFzgqM4Q35VkDGUGZNSqq8P0Xv7Hj3GtvJ+gj8VugP4aAUhWq9KhxfyDa11Z+nwqzrU0QiP5j8A5x3oYQQ+acbYMxsTNdFHv4Z+ZsTv+QxIPKW8uApbo+Nc/phdKk0AUIA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Feb 2026 06:57:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 669843 invoked by uid 111); 9 Feb 2026 06:57:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Feb 2026 01:57:07 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Feb 2026 01:57:03 -0500
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com
Subject: Re: [PATCH 0/3] commit-msg.sample: reject messages that would
 confuse "git am"
Message-ID: <20260209065703.GA585828@coredump.intra.peff.net>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1770476279.git.phillip.wood@dunelm.org.uk>

On Sat, Feb 07, 2026 at 02:57:59PM +0000, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> On 06/02/2026 09:03, Jeff King wrote:
> > I don't think there is a way to unambiguously parse the single-stream
> > output that format-patch produces. This is a reasonably well-known
> > gotcha (at least around here). E.g., some earlier discussions:
> >
> >    2024:https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
> >    2022:https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
> >    2015:https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
> 
> If we cannot improve "git am" perhaps we should update our sample
> "commit-msg" hook to reject messages that will cause problems. Here
> are some patches to do that.

I'm not entirely opposed to it, but my initial reaction was two bits of
skepticism:

  1. I imagine that hardly anybody runs commit-msg hooks in the first
     place, let alone our sample hook. So I doubt this will get the
     attention of many people.

  2. I'd guess that these days only a small minority of people care
     about sending patches by email. So for most people, a warning about
     their commit message containing a diff or "---" will be mostly
     useless, if not outright confusing.

I'd imagine that documentation updates would be more likely to get read
by users than the sample hook. And a warning in git-commit itself would
be even more obvious (but fall even more afoul of (2) above). Adding a
warning to format-patch would help with (2), but at that point it may be
too late to change the commit message.

> We could perhaps think about adding a more prominent warning to the
> "git am" and "git format-patch" documentation. The docs for "git am"
> mention that it splits the message on a line starting with "diff -"
> but maybe we should spell out what that means for commit messages that
> include a diff. In principle "git format-patch" could also warn or
> error out if it creates a mail that "git am" cannot import verbatim,
> I don't know how hard that would be in implement.

I think the patch from Matheus linked above added that format-patch
check.

-Peff
