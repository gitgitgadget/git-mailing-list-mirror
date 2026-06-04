Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D83DD869
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556939; cv=none; b=t4P2xC3gqd/bMb+XpbEf+gzV3V5GEIofd1B6B23X91hsl98Z67/JCEYSIx/Nq2Nwk+r0tesfDVH0BC05Ce93022mpg1LHRdPO6pWnqEdAfbE3U/hibpuRL9YubYG+jWG7ktPfN/ERbbOByhclCOxsMa8J0+SPBS+T15MMAyGX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556939; c=relaxed/simple;
	bh=ZZyph9q+h2SyWux6O8dFBrAnTqVEoKRqU9bDUu4hEns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe60MvX4+JDLq3pNCqFk4vK+lxYdxPJkxU2NtObof49sIHhWUYlDFlLIw85MoVCgm0UIC1QjOx3fzEgtELeEwA/nGax+yss6H6+s8tcXwAbA7uzX1Fcab8c3tUBzBbkHhmGS0BgNsw4ydfn9hKCIWqYVU/b+3PfsBF0U608rUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LTyD4pOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4HmurZG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LTyD4pOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4HmurZG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04C2714000FB;
	Thu,  4 Jun 2026 03:08:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 03:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780556936; x=1780643336; bh=Cg69XsqKuP
	bPNzTj9gnFaMo4+CX+c/Z8aJhb6kxQF9Q=; b=LTyD4pOb+zbYV2QXKl3uL4nu1P
	veoC/PMO8mKQdsOM/3SO5L6Zi6k9bW83Ks6ks+3Z9TgHqzrgj+45NZ1jzk+B12as
	47rN7bIZiDaEA62WldiLP5pDqVTLXBXOhOW3VE7lS4cczy++UGFq7Dg5+2kCpg4I
	pchF13WFXS52osyxCjltqCumQvxk3GaXJxRv2SEq6EOjgSrS58cFRiejT3RKGSHo
	ghkg8Gl814XofG2nHfI8s0+sJSAcqMqtHFj8lUxEfpkQaI3q+Pk3hQVqGVOIyvkZ
	/OADfNHdy0XwnWxCJLkOxjQ58Y76KWijwlpbGvCpwqrNeAu1wqRQkuZWgryg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780556936; x=1780643336; bh=Cg69XsqKuPbPNzTj9gnFaMo4+CX+c/Z8aJh
	b6kxQF9Q=; b=B4HmurZGDY5iZd7zgJ3s1vO93WBv2BodHpt8R3Ahqs4NPTA18tD
	Ds4TLDkN2IqVnkqUBUPB0j6mXcmYxUep8rxJeRqJHmqPWHHxTmUNCBXXzCSqGmwQ
	B6vQYfgolt55fL3Uxnsd3VTbjwS/Mg2qaqyWeK6BH/azUNzvi1ZzZPme8ukPP4kN
	OUfXawiFKlMJjidrTgKXTeTY6zPwRi8mxROrMc9e2YXM5orX1VCTN8CPLce3X5Op
	0QsjtjMdHKu8j+qQDYU7DgoGcIpYpbEXfhPJxcmTTxv7fCBASuHONNi7qBSMIaTU
	ndvI5D/qs0VnH/D2NWuQzoPhn9ddws+ak2w==
X-ME-Sender: <xms:iCQhasVFZJ2cEKDvLprmrhkyJM9Emj_A6bJV7vtK0Ahu-wkiL6qU7w>
    <xme:iCQhaj27enbP6cN12efXMbd37TsrF7GWyNillUKwDuH3yYIrzXeM5qV48LAe7ls_H
    AtOz5CDvR3s3IUP8_AZXVgI4BZU4UdLWQ6Dd8RiTzbjxNYUkXnNnQ>
X-ME-Received: <xmr:iCQhap0KgSGx8ysaIWtpAIGdcvOAShZs4rEEvg9OzUEC15xIUMvLCDl3-qbyNQcdG_76Lr-mjg6FBpw9PMLb-jxEzHdo9F6fzTVMlulWCAk>
X-ME-Proxy-Cause: dmFkZTEHaSfKmQgBJPXSEHIXKmTUWg1QowTrUWXfy3xeUgkayzw63VEbl7a1W9J62O/F98
    G12omABK/aqTMWDJyLkIZaiGW8oApac4toRpWui+5OqMwNyBqk64g7w9fAS8e3x23P6eJS
    yjemKa/gf/I8rl1vbxXcC1v1BUNOD8zmOefivRLgmpdRoaaUDuwzAU2t7aWxFkKULlYRCj
    TgOwHtkWFYYja4Y+X4PwRTaiGk6MwUV3FFkDMD7/Y77NbkuW/nn6ST5p4vovo3whm3c+ZE
    dr/xyD3UrVAR47JPHvSola7//JuLYs0wltXXqIu0PKYE/lPxK+hYUENiBQcsF9tW0vlmIp
    kg8GKeb3B/jZbdUUIjC2SjEzRZW2Gn5/yYjUsYTqxdxQs4k7KcM7cb3PUGgHOxzRCIk8ky
    2G+/+KnliIaYILqawK4R1VRqVvoCLeIfiIrTvm5+j9QQqXQHK/Hl0bca4/DS56mz6lCOPf
    J1BDPVsCwo9MtA+na9ul7gGy92lFkTLLmkAjPX88ucKsE/Fx2u9UC2j3FB1x0BwHPpA+is
    VacPmrQA7O29Ilge3XhoF6+WBr6dEi1jdpzIT1GWvgRDo2EggyXYa1PbtpwIy4Of0lOer3
    OeymXHx3G062wfVg/nB49zL9UeBWeDiPLKVJAuc43spF+/QkRSzGICRl6oOQ
X-ME-Proxy: <xmx:iCQham8OmIzbSLd67DcDWjCFwo9srrhKLVsXz7aR2NqjaVagojDM6A>
    <xmx:iCQham1gmxQnIROvHJbkxv5iA2HfvGwCS-d-vZCbbYh0Wly-QYqEyw>
    <xmx:iCQhaj8GGTdch4LNWmn1ZKyb_hX5LksdZA8f0Pu_8j_qBf6hrMy8dA>
    <xmx:iCQhamsDh7hGTHfNa64qPF_6H-kgX1u23TBE4RCFVSK1C-Jp2LuWPg>
    <xmx:iCQhagJrlUxsAAG1HDuktENu0gG1GRmGLzbpsLH0QukMyLr3vNczB7-1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:08:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a833cdd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:08:53 +0000 (UTC)
Date: Thu, 4 Jun 2026 09:08:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH] read_gitfile_gently(): return non-repo path on error
Message-ID: <aiEkgBZJjmntRdNt@pks.im>
References: <20260602061159.GA693928@coredump.intra.peff.net>
 <ah6WEtk2pXyViEQA@pks.im>
 <20260604062720.GA3195904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604062720.GA3195904@coredump.intra.peff.net>

On Thu, Jun 04, 2026 at 02:27:20AM -0400, Jeff King wrote:
> On Tue, Jun 02, 2026 at 10:36:34AM +0200, Patrick Steinhardt wrote:
> 
> > > The correct output (which this patch produces) is:
> > > 
> > >   fatal: not a git repository: /home/peff/compile/git/.git/worktrees/worktree3
> > > 
> > > And indeed, that path is missing. But why? I feel like I've run into
> > > this same problem occasionally over the last year or so, but never
> > > before. Did we get more aggressive about removing worktrees at some
> > > point? I haven't been able to reproduce whatever is killing off the
> > > worktree directory, and by the time I see the error it is long gone.
> > 
> > Both git-gc(1) and git-maintenance(1) prune orphaned worktrees that are
> > older than three months by default, which can be configured via
> > "gc.worktreePruneExpire". That logic has changed in 4dda60c9df (Merge
> > branch 'ps/maintenance-missing-tasks', 2025-05-15), which would kind of
> > match your timeline.
> > 
> > But rereading that patch series I cannot really see how it could result
> > in more aggressive pruning of worktrees. We used `git worktree prune
> > --expire <expiry>` before that series, and we still use that logic now.
> 
> Yeah, but this .git/worktrees/ directory shouldn't be pruned _at all_.
> The worktree itself is still there (which is why I'm getting the error).
> So perhaps there's a bug in checking that things are still there, or
> perhaps something is corrupting .git/worktrees/*/gitdir.

Oh, that sounds somewhat scary.

> Another option is "I moved my git checkout and the worktree prune
> couldn't find the directory as an absolute path", but I'm sure I didn't
> do that.
> 
> An even more exotic option is that I run Git's test suite a lot, and
> very occasionally bugs in the test suite cause the script to escape the
> trash directory. And some scripts do run "rm -r .git/worktrees". I find
> it pretty unlikely for that to be the culprit though.
> 
> Oh well. I don't have any good leads, so I guess I'll see if it happens
> again. But maybe now if somebody else sees it we can commiserate. :)

I'll certainly be on the watchout.

Patrick
