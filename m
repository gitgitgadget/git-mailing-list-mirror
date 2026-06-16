Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92A3D8138
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588753; cv=none; b=BPUFMsUKqmvUvjLIBTUl7lR+yOhOsMjvEecf85kUR9Emt/6zAeIBRo1aPsM5NxxExvyZai3dz9juE5bk+O34EiIxoe5Md5gmEWfnf91LnE0Atg2/WYu6DVY0YWNfFvKlLkaZrBw2xzd9FHHFzMd6Qmof7vsMl1rqwqM13UiXVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588753; c=relaxed/simple;
	bh=CwpFYi3EV+OaQjNdKImdrW1AUEkZGMxiTD09Kc0gTW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGb7A1Cq5gTxYldJbIe4mInAO2FUO1bi2PmiIx+QK8QtI+QZZI2Lu+t9QWkWYP9JWWIQ5VQKHTS0B8Nu2Gs4qC+R4vpH2V7auXT9+AR459GEBqShvhbCYRER9y4QYsEmnLzXjbbnY95wEmKQNjHkOrFVzNRoXocWlGsYa8GbgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nYYXsRqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4eNx891; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nYYXsRqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4eNx891"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B08461D000D7;
	Tue, 16 Jun 2026 01:45:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 16 Jun 2026 01:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781588750; x=1781675150; bh=SwnQzJ/ggi
	VF9kv3WpLHnAxJTPnffGsYs923mAdajXI=; b=nYYXsRqIQ7T2Pn9Yo80rwZHxGh
	afhoDkTm50Bk929kt8w/cFy0f33bDNyY1ZTvJSvpNa/bf2PSenw8BK842I3+GJO2
	W1QjGTOhK0fX3OA4tBUkmN/Aigl8yF6tI9hzwcI1tPxgDvBRYu3dFf31G+vfHa1M
	3Gi0VrG2X/NCzqmtuZs1b42VWdb9aFI+TTJ07m8/G7CW6Vn0IHwC9/1OMruFMDHb
	OeFPTjUyg0f/Xd3uK3CzU3dTD+I4xhGLAaBQbSSAZWgXs1vX3Aq/BxAKgd9E/A/t
	bBVI8m/XoN4xDoUj09F6Gve2X/w3LkBQaMaxiiYJclBDphWR/uXxOQ6EIRPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781588750; x=1781675150; bh=SwnQzJ/ggiVF9kv3WpLHnAxJTPnffGsYs92
	3mAdajXI=; b=I4eNx891/gqIMPXAYMPA8oHg9Tbg+AgIO00uAfMpspJKSSuIr3w
	FbFA7MSiB4VbKVYVcicYLDgSIVcOLKXXD96+hiiyNPSB9HTftgnATm3aZjjQFyLC
	b1BcSJGhfgHfsiM3zWXASht8sFOwKgPykMjmALSBwQrvapMvkwwY2EemtrmRLsE5
	xylIxwS7+7vUlFgYzDJY20l1/moIW7aGSgrdAOsANs/oJq/VSXcdWFPR+cGgJ73V
	/3LUXYOBH38QKparGB0EJBiFYb5D2DDeyWTkiB/0czrJepb8gUakrMDiKhQTUma5
	2mdSeP2GfB7P83SKP/bsbfzvDt3V00x5PhQ==
X-ME-Sender: <xms:DuMwanusMQDb22KmAbZcqXKH9s6oj7gva5pRoWhivElJuiItv-xQTA>
    <xme:DuMwav7pUhNZuEgAKLWVcSi9CoG84d8Vyo69R5j4sIPI_otqHGu9CSA6VlEcqMGwY
    Ibw0ng3Ux_s_N4IrqMtBL1YNYDRXH-L5OGEiBX5gLhzUofFSs8N7Z8>
X-ME-Received: <xmr:DuMwaoLdLeegmxpA4axz8NqyUzM4ZytrKkwvv7g3RBlE63xevy_Xr9vFzraC67r3WDYzNwpgcczaI7j6uFwEQG-VxP0rDkmfXbYCik1G50NpIQ>
X-ME-Proxy-Cause: dmFkZTGpRFvDgf59vIwlJGQFzuzPz9u7UELlzHFPHw2/XYjE+uuwJuD1aVvpnyBS3kzi8q
    GgkCI8cryym/u1hvrSZkzrinr/5LbFjmhqOaAf6q5SUAvsuJ7V1bv0O6pOiR+P0HIUCJqC
    2ZgjrvW9NjxgpvQopWcT9ff+07wfESaKTYoqyBtAWoRCMFJUN23CTfm4WituYb/7j9hWD+
    YQ/HNj27wLAjnjgK0Oy8rMPrgyTqO7JF58R7gH2Gmh0b0pOKkA7cqiMu7uhhf1lEy0IlHc
    +hAOc82zeAY9Fz3SvliZA8E+ADYVmOYHJL+g7yU0ubgD7hzmdpCxLimF9QSnaQfSSYc2Un
    HhLL9YsrXmFvRCRZxLvUGfcIp7hHVRMmKN/7k5XV3yGK3z2tfKzBM4KftL+GlWS5NrAgP/
    z2CpO/z/wDTYnNsIJ2SzBzcoDC8126ePC6Z5iJ+muWXDEbWdxvAsbE0oAVNaY+q8XhD+aZ
    DLo9YnegeSct5l4HKVOVYt1SNLxjr4oKz6cOtUeB0TAVpOTVT5N6V4gGsYGMPGcVz+q4UY
    3Rl/wNTJlPRMKDIl4C/ixnwISd7SKE42AmJvrj0nPg9etTdmfFw1B9tryhMI+qCJHa9qW4
    SdDP+MWQiBp8cf5POHLZ1MF9gwya3uQEjoaqKlpMTAdDDQkkvc1JORGKwU9g
X-ME-Proxy: <xmx:DuMwav6fLHx9aa9y9N_SB9NEx4x1bfZonXKQgcmsJ7upnniChe1e3A>
    <xmx:DuMwarzORyPrLYg0Aqz2qaS6NSq1crWgFHEDFU7F2F52VV3K74Bn5A>
    <xmx:DuMwajZvMTEvlEOeBc1m8P_jYt9Hl9H-SEY0E__Stod4kK5MbK1TbQ>
    <xmx:DuMwatTnkSOquKqsOLiI1L-W9wS4KRtZAys_memx8aDPJPBZ6qzFig>
    <xmx:DuMwarlAyqTARk9X3hOne20YMDWZvJLY1vM_-cFwoewPzPhactp6-0ct>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 01:45:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51e4db7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 05:45:46 +0000 (UTC)
Date: Tue, 16 Jun 2026 07:45:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
Message-ID: <ajDjB67HvbdgjYSa@pks.im>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im>
 <20260615172946.GD91269@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615172946.GD91269@coredump.intra.peff.net>

On Mon, Jun 15, 2026 at 01:29:46PM -0400, Jeff King wrote:
> On Mon, Jun 15, 2026 at 11:48:10AM +0200, Patrick Steinhardt wrote:
> 
> > On Sun, Jun 14, 2026 at 02:15:40PM +0000, Kaartic Sivaraam wrote:
> > > While running `git history reword` using a Git built with `SANITIZE` flag set
> > > to `address,leak`, we could observe the following leak being reported:
> > 
> > Huh, curious. That seems to hint that we're missing test coverage for
> > this specific scenario, as our test suite doesn't detect this leak.
> 
> I think it will only leak when the commit object has an "encoding"
> header. See below.
> 
> > > As part of rewording a commit in `git history`, we get the commit message
> > > buffer in the `commit_tree_ext` function. This in turn obtains the buffer
> > > from `repo_logmsg_reencode`. Given how `commit_tree_ext` is invoking the
> > > function with the last two parameters as NULL, we are clearly not expecting
> > > a reencode to happen. In this case, the buffer that we receive from
> > > `repo_logmsg_reencode` ends up always being obtained from a call to
> > > `repo_get_commit_buffer`.
> > > 
> > > This buffer is expected to be released with an accompanying call to
> > > `repo_unuse_commit_buffer` which takes care of freeing it. This call
> > > is missing in the `commit_tree_ext` flow thus resulting in the leak.
> > 
> > So this doesn't really read specific at all, and I would have expected
> > us to hit this leak. Puzzling.
> 
> The first paragraph is accurate here. We'd generally just get a pointer
> to the buffer cached in the slab, because no re-encoding occurs. And in
> that case you _don't_ need to call unuse_commit_buffer(), because you
> have a read-only copy, and the slab cache will hold it forever[1].
> Calling the unuse function will be a noop.
> 
> But when we _do_ re-encode, then you get a new buffer which must be
> freed. And that is when you have to call the unuse function. And the
> reason it is "unuse" and not just "free" is that you don't necessarily
> know which you have, but that function figures it out (and frees it only
> if necessary).
> 
> So what the patch is doing is correct, but the explanation is a little
> confused. We see the leak only when re-encoding, so we'd probably want a
> test case that triggers that. Which I assume implies rewriting a commit
> that was previously generated with an encoding header.
> 
> Now back to that [1] note. Even if we didn't re-encode, we'll still hold
> onto that buffer forever. It's not a "leak" in the traditional sense
> because it's still referenced in the commit slab cache. But if you are
> going to walk over a million commits (like git-log does), you probably
> don't want to hold a million commit messages in memory at once.
> 
> For that you'd want to call free_commit_buffer() when you know you're
> totally done with it (again, like git-log does after it finishes showing
> the commit). That might be the case here in commit_tree_ext(), or it
> might happen later (I'm not familiar with the git-history code).
> 
> But note that you need to do _both_ the unuse and free calls. If we did
> re-encode, the former is needed to free the newly allocated buffer. The
> latter only drops the original buffer in the cache.

Thanks for the explanation!

Patrick
