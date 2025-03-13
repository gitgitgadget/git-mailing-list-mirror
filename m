Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5F2AE77
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843504; cv=none; b=ehIWfVVtC6E3iCVS89VFytAbC0r0NOI8BGYPnph2lPWhM44gA+t0DFKCKEkQ77ii2vsPQhtF3W/ruJZJMxAQoT+zESdp1xx00PIpHy7wc9fDB3qVLRdhTwnJ7JGkL0mDJdRmA1glY9c53yUVANn9gvXDzuhlzo8w80i0HNWq/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843504; c=relaxed/simple;
	bh=65jamV6YVqwUU2I8Sl4qjbVXbSw4dYOvNdFFsl6ObNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBiGgu6UyaWRC4lMmTD+uTpB7pFo/xJ/JeH1yB07Y79RqzIWO/kzlLsOZG2UJevB3GEbZTA4f4IMh9MT+WE5YWbWsDKV9/pgXTQhquwWQV8SaIZDVQj/E0h8pMdAAQN8lo20Xj4/5zDxRlnXs++shi0AmjYnKsmL6ZtSw1d7uYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F8HPzENe; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F8HPzENe"
Received: (qmail 20668 invoked by uid 109); 13 Mar 2025 05:25:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=65jamV6YVqwUU2I8Sl4qjbVXbSw4dYOvNdFFsl6ObNs=; b=F8HPzENePz2sj9NgyPU8ZnvUn9ngcf4PlIvXCpocCE6t5uMuM+yAnKGxBMpojnT8EhZcKu1u20KvMMJrzJ+6bcL2Imqpc2GJw1AyttQozqonNrSc56Xh9X3CtJN9RsYbnGSPkC+DSbktaPoABIuR4T/mY73sFduDLOIbh6olDvvE2aDcpgKnCWHxx+8MmtGhIf5toowtZG8VZrdrJ/6BKji1gFElLw4FzOQeaZd8dPOosfTd4Dv4j6gBZKYT3SmC05ePriXKvA7cU7AdujTkseNl4L+LesBdJlDiaFBUwdSGJV50OasGFrVEU9Cy+9G3Y0R6kgi7qyEmyJE/AZ/adQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 05:25:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11427 invoked by uid 111); 13 Mar 2025 05:25:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 01:25:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 01:25:00 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] merge-ort: allow rename detection to be disabled
Message-ID: <20250313052500.GB94015@coredump.intra.peff.net>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <4292b22723f759c3e0f84ac1000992187a9c7f7c.1741362522.git.gitgitgadget@gmail.com>
 <Z9FAix-VKGte8UKk@pks.im>
 <Z9Hobtp+9esKkY/O@nand.local>
 <CABPp-BFj08mpXGiSoZ3xZ4KamwTJ4k5wPLTCJh6hUtKSxWE52Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFj08mpXGiSoZ3xZ4KamwTJ4k5wPLTCJh6hUtKSxWE52Q@mail.gmail.com>

On Wed, Mar 12, 2025 at 02:40:35PM -0700, Elijah Newren wrote:

> > But I am almost certain that the behavior requested here is to disable
> > rename detection to match the behavior of GitHub's prior use of libgit2
> > to perform merges, where we also had rename detection disabled (for
> > reasons that are unclear to me, but Peff might know).
> 
> No, if that were the sole reason, I'd say it probably only belongs in
> our internal fork.  Disabling of rename detection within GitHub was a
> temporary internal migration measure, not a desired end state -- at
> least that's the way Johannes portrayed it to me.  I know that
> "temporary" sometimes lasts longer than we want, but now that I've
> become internal to GitHub, one of the things I want to do is add some
> weight to that "temporary" modifier.

Yes, I think it was a series of hysterical raisins. The original PR
merge test at GitHub was done using a shell script around git-merge-file
(because git-merge insisted on a working tree). And naturally that did
not support renames. (I think I probably wrote that script, but it's so
long ago I could be wrong, and I don't have access to the repo anymore).

And then we switched from that to libgit2, after Ed Thomson implemented
merge support there (mostly for performance). And the decision was made
to disable renames there at first, to confirm that it otherwise
performed identically to the existing shell script (to confirm the
results, but also because it was unclear if rename detection for
automated merges would always produce what the user wanted, or have bad
corner cases). So it was mostly temporary, with the idea that somebody
would explore turning it on later. But I don't think that ever happened.
Those with access to the correct repositories can probably find the
arguments in the issue tracker. ;)

I don't think I was around for switching from libgit2 to merge-tree, but
I'd guess the same "only change one thing at a time" logic applied.

So yes, mostly temporary-but-never-revisited, with a dash of
conservatism.

I don't have any real opinion on what should happen in the future,
except that renames on GitHub are probably reasonable, and having an
option to disable renames for everyone is probably also a reasonable
feature. ;)

-Peff
