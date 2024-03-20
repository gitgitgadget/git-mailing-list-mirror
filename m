Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A773D0A3
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928955; cv=none; b=MomTMxZJ4g870T/76Om+tV+5pdaj+toVKTuVXFQ9qeCVllk+oXhgGT5YZm50Z9its+n3yltFSJVtK+iWw+hGQ9KsVErt2Wu7zocrV8acm3TyAQOGDiEZuBSclm3Co+an0EXMfRFTnD2gbrdlCiYBZIGrWHIWjCBTQVvNMK1mGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928955; c=relaxed/simple;
	bh=fbFFEk0IbobEC7o1LK+xd5oxIYONQ3L0VTOKjfEm8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or7uh6OTYFIa4HX/9qtxyINaIlBpCC7XA7NWoD3ZtWziZFdP1fyvVH4kbyR2defc4a70vxVstoM6bcv33ePVNjkFsFivXJGxjIuLpx9+LcdC+IM1W9RcTe1U6wuykrviSfgDGMJRHR8NH+OmzqgYxX5/vBcrjIbtqARv5n/bvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11330 invoked by uid 109); 20 Mar 2024 10:02:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 10:02:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17068 invoked by uid 111); 20 Mar 2024 10:02:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 06:02:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 06:02:32 -0400
From: Jeff King <peff@peff.net>
To: Matt Hickford <matt.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: highlight local worktree in `worktree list`
Message-ID: <20240320100232.GB2446185@coredump.intra.peff.net>
References: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>

On Wed, Mar 20, 2024 at 08:00:00AM +0000, Matt Hickford wrote:

> Hi. `git branch` lists branches. It highlights the current branch with
> an asterisk and (for me) the colour green. This is handy for quick
> reading.
> 
> `git worktree list` lists worktrees. It would be neat to highlight the
> local worktree.
> 
> Another idea: `git branch -v` shows the commit subject and
> ahead/behind counts for each branch, eg. "[ahead 1, behind 1] avoid
> RegexReplace". It would be neat for `git worktree list -v` (or
> similar) to show the commit subject and ahead/behind counts.

I'm not sure if this is a dumb idea or not, but: what if git-branch
learned to display branches associated with worktrees (just like "-r"
lists remote branches, etc).

Then you'd get the all of the display niceties you want, along with
other features like sorting, limiting by merge, etc. You can even show
the worktree paths with a custom format that uses %(worktreepath).

I think the only thing it wouldn't do is show worktrees that are
detached from any branch at all. I'm not sure if that's important to
your workflow or not.

-Peff
