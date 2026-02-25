Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60313B8BBE
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025809; cv=none; b=ZdwELeofv5EwY3augJjLOAptkiMhv+14JFCUQRfkiQEz0PjqVp+QF/ExymSATHgqeip9loyQpGvdyel/vI8zWXYyUXNGWAqJlAzRrRlbQ50J3DnGLtQCMaU5l2breC1Q02jo/lto06bdbte36immtVl8JKWv4HB7o015ySvMw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025809; c=relaxed/simple;
	bh=cEddnNdT7FZ9pvKiF7/7NOf7No5vs8gooxtyrJBuY1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHXw2K5PWdthMQljnfE1MgV6AXTI+gcEWDcvQFsXgRYkkfIXlWKaxp04SrB0lUvPxBrZTs+NEt65AHnqqDsr3MtRwMzHoarLF6U+Hrtc3m4EcjXBvG4md6pVEv+5/Mcfem4/nJVYkGesh7t+a7ne7swZohnI2FB2zcEuJKM7aL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PpuI8pkm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PpuI8pkm"
Received: (qmail 66960 invoked by uid 109); 25 Feb 2026 13:23:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cEddnNdT7FZ9pvKiF7/7NOf7No5vs8gooxtyrJBuY1k=; b=PpuI8pkmtVPWVqHPOK/9uXMHFepK2yzX5xs5S+W9W8j3wgpnf892A4KFxBgSIcSAiAyWdfNQfGGfWQn6SScU0OOM1NePZcwyj/huTVklM9Dty82MepF+smagJNFSvyDoPBhprZzoi3lPFiQekPFW+j7wiosEYgUBJ3W898HrHpGRLpap/CACBwuVtWMu8tT3CipYZKYw/aNCVJk1rblZAt8Ex2G70l5f+8IW97sziM/Mkygi+JLp82M1rkskc/5/TJH/07h+8UXifOjnaEl0Lh398Ev7ZFbUb1FnckjRi/ALi6brxzmy6igUG2GKXt66/fdSSwUxA2rrK+OpARJ/2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Feb 2026 13:23:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 199244 invoked by uid 111); 25 Feb 2026 13:23:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Feb 2026 08:23:26 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Feb 2026 08:23:26 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com
Subject: Re: [PATCH 2/2] for-each-repo: work correctly in a worktree
Message-ID: <20260225132326.GB2139176@coredump.intra.peff.net>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <a47f9e9386badd83f0f5820f33f5eed68ca5fd82.1771903950.git.gitgitgadget@gmail.com>
 <CAPig+cQcpJu_Z6VXbn5cee2AHmPHQaOLG39HFRG1SGnnY1cWFA@mail.gmail.com>
 <20260224091806.GC986367@coredump.intra.peff.net>
 <fce7662f-d741-41e1-93dd-f82e65e04f41@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fce7662f-d741-41e1-93dd-f82e65e04f41@gmail.com>

On Tue, Feb 24, 2026 at 07:11:13AM -0500, Derrick Stolee wrote:

> > it is passed, before calling sub-programs. That's a bigger change, but
> > possibly it could or should be flagging an error for some cases? I
> > dunno.
> I'm surprised that passing '-C <repo>' doesn't already overwrite these
> variables but I suppose environment variables override arguments in this
> case. (This is the root of the bug.)

I can see why you'd be surprised if you think of "-C" as "change to this
git repo". But it really is "change to this directory". It is perfectly
OK to "git -C" into a non-toplevel directory of a repo (and continue
respecting any repo discovery that happened already and is in the
environment), or even weird stuff like:

  GIT_DIR=/some/repo.git git -C /some/worktree add foo

What you almost kind-of want is "--git-dir", except it puts the onus on
the caller to find the actual repo directory (so detecting bare vs
discovering the .git). Part of the point of introducing -C long ago was
because --git-dir was so annoying to use.

Probably there is room for some middle-ground option, which is "do repo
detection starting in this directory and use that as the --git-dir" (and
I guess also do worktree discovery in the same way). But I don't think
we would ever switch -C to that. It would almost certainly break lots of
people if we changed it now.

-Peff
