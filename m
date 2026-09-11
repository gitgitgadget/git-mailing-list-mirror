Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6814351C11
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112078; cv=none; b=g9s/2Sqyw7I8L7xtIqNunPZ47tOhR8p4SqH80x+6t+KKluuydxanmz5hUzsqIGardnLhPiKy2IQoz8fo5umri4qoM7RAa8RdvxcALH91eyY3cUZNXFwM6xJvCxX/oweAzB1AC2mKtXV+H7c72tlW+NLKverWC7teozgh9DzuYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112078; c=relaxed/simple;
	bh=JtMqBo1idz0Bj7dsny4Yv2AcV+uCaAsGysCwr/gVFs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhXUCry34IbdwrILBC36BZv2Ml4p4jM8uj55D9gIB/dsrQ1ynVXWmVzWC5ALFibCdqIf+YgziYjgnLPmryaKNEkubgvbuc+wMpXUtx8h0PJZmaHtTpkE8SV9kS+5AINhCZBXsQambg7BJP+9jLezJCD/wYh74KRxXSvtOxahhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FqmpWqUX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZIFtNEe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FqmpWqUX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZIFtNEe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 706EA1D000FF;
	Fri, 11 Sep 2026 03:34:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 03:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789112071; x=1789198471; bh=Y5WSWgUWAK
	FvRge6qmJ36bUvnrq+zM3rJ7mhXnsWW9w=; b=FqmpWqUXpz+RnwhQOTSDNxF7y1
	eWs6R/PexXYO1LMkHubkZbO1/nCnBMf22Kw+syAMtx7XxiuBlL8m4XmxBJavI9P5
	ELAaZOyPj7sLpJ6MJBaRBvfY/surQgDFizEAjGaw3+ajjpoYlmgGLmpomRJXebLA
	9BtL31g843xHhIzpVCorcpe6JkQsSHqrGj3CW15EWwAeaokTbWqsbEW3JBIg4OWJ
	lAVuhhuNlWmVKvGtWAi6GJ+VwjpIV8AhP9pHWWD8fz0Spyy6/ZHZRfsE2WQyjsxE
	TjYtQEN2ItO8CtLGQlOOC+AlPv/M70l+NQfDsO+Ct1U9rAV8qG/471Z+tt8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789112071; x=1789198471; bh=Y5WSWgUWAKFvRge6qmJ36bUvnrq+zM3rJ7m
	hXnsWW9w=; b=PZIFtNEeGbR1lmCMSyXyRguV3z2PaCZiS/sNeFeRfRW+etxr6Kb
	c/pZ2kDfYUv51uymgCKNlxgR5OMqpFjVJPSKXiCx1uoVbgn2qN7nyFYcKQNZhXBm
	+kxZxqkCfnDtrxoB17ENbIKKSZxa4YvjvBaWiTSM5XradNuEDeOw7UoIskRk+9o4
	iIXW684gHe4nazrAGpMGZDNFAT3oT1VB+jdGrBihRA0hsuUZ1Vav7ddrvaUD1r4O
	NGQMiebLPIK5O1l7KDG7wjLscIZhchwy5QLydyOBUct4BQJ3kb6LKu7bbWjBKIwK
	8k1m8sPwaQR2WJsWSs/O7vvUDzrDu+vPykw==
X-ME-Sender: <xms:B6-jalCAK9q6qdMCHINsr2VE7gIn8-HJ56M3MIl-Jz7wa67etTHjfg>
    <xme:B6-jaosQzMsL8IEUiEuHVoQI2e2yxDnpbHsNAJpmj_czog2-ZkM3xh3iyW0q3KoNe
    m2tpeosh94MbTK2b6P5ueUGbvWa9gmCf3zUDsXcpFYPejlh66TNls-c>
X-ME-Received: <xmr:B6-jahfrm8f9N8jtNJ__3oFZst1bNupx0YGbdzfZmtDV-WDmp4QjMmXX2Ps2rKF0jvK4MA>
X-ME-Proxy-Cause: dmFkZTE4V8SodkG/fUbJMIGgsv5LKmNcFE9Osgf07ttGEJRf55wMH5HdqAYF/EpYEyKjqs
    3sYzQoG/cEFbSp1zJtsroWxhYfy5UwIpnmvpSfD30IYJreLpWJIUd8FjnV74Z4J980903L
    B1/OVvGbKQThZ7yK70EEsxBj8b8VEC83qEHFMykmYNE+12a1I5iLhLVzH+JHuQQvCYMG+1
    /4mT907v3VcjjexYMkTlNsqMad8GBJboSZN0ZwUmCe0ZxDq/VEjZ8/XUN5zeBECX5+B/LV
    yDHaRUwnTH7mdn6xOaS25Lmza6NjxWiszQImWDrwZ+7LJ5K8M91CnvJUKtVXQ5f6yXg/LC
    PkhZ3mP9uOoof5qnH8bSAw9SGeaOmsSPTvXdfoIsvcD/yRECXYn/wDQ2CEcdLrGtTY/oAj
    iwBWmnGx+SwcZfDG0V7bRqy164uZ30kYpr6GmO5yNDQh0/aeAO3fdCf3fOXkgxusqwl4St
    KwxfI2UREuntFp3DveEbM/w9hw0iao50hOwivy95gU/B1PZoceT2lJToOLdgSmq9yMo1cL
    jd8/cyq8uNYHJ7Fvh6JWBFi87flyHANFsY40+UjmdedO8tGM4axHlbJ7Dgee3pX/JI+hbN
    Vv6BUtHeMzmQM6HxfUTIG+FVd4aqeIpxidHKraQzouE/ujkqZ/A6W8/SKibg
X-ME-Proxy: <xmx:B6-jal8TkUDlB2I0ZKCEy8H_V4vv_5X3gC12MmGbZxj8zmusUNB4PQ>
    <xmx:B6-jasR5dEVugt7Jw_UAkzLZ8hw2nXHnyGu5PYVOT3xfuArAElWr0A>
    <xmx:B6-jamrFy_e8PZkUmZVN-GThMTrivyCuT8GglZLFW4P3zRLKWU6p-A>
    <xmx:B6-japn_ZIybkLd0ewg99fw6dOmfvQCQPMzLK-FDI9VGxM9MYLYKEQ>
    <xmx:B6-japTikNCudSPL84DJ2wVdz6XAesvEJHLB-THK28eDfKna-XnNWzzC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 03:34:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 535ed0ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 07:34:29 +0000 (UTC)
Date: Fri, 11 Sep 2026 09:34:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v4 2/3] rebase, cherry-pick, revert: run auto maintenance
 when done
Message-ID: <aqOvAttPrhUIP_7U@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
 <b7b97262f27782f3271369115496c67f9774b8b2.1788942331.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b97262f27782f3271369115496c67f9774b8b2.1788942331.git.gitgitgadget@gmail.com>

On Wed, Sep 09, 2026 at 08:25:30AM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> "git cherry-pick", "git revert" and the merge backend of "git rebase"
> create their commits in process, so auto maintenance runs only when
> they spawn a command that runs it, like the "git commit" for a
> resolved conflict. A sequence thus runs it in the middle, after each
> resolution, or never.

This paragraph still doesn't make a lot of sense. How about:

  Commands that use the sequencer with the "merge" backend, like
  git-cherry-pick(1) or git-rebase(1) with "--merge", create their
  commits in-process. Consequently, these commands typically don't
  execute auto-maintenance at all. The only exception is when a conflict
  happens, as the user would have to manually commit the result via
  git-commit(1), and that command triggers auto-maintenance for us.

  In contrast to that, the "apply" backend of the sequencer _does_ run
  auto-maintenance after it has processed the sequence of commits. And
  this is a sensible thing to do: after all, we may just have written
  lots of objects, so chances are high that we have something to clean
  up now.

  Adapt users of the "merge" backend to do the same.

  Unfortunately, there is no single exit point for this backend where we
  could add a call to `run_auto_maintenance()`. While one might expect
  that we could simply trigger auto-maintenance in `pick_commits()` and
  call it a day, a single pick as it is performed by e.g. git-revert(1)
  never executes that function. So instead, manually trigger
  auto-maintenance at several sites.

This last paragraph though...

> Run it once when the sequence is done, like the apply backend does.
> 
> The sequencer has no single place where every sequence ends: a
> sequence of several commits ends in pick_commits(), a single pick
> returns as soon as its commit is made, and "--continue" and "--skip"
> have entry points of their own. Run it from the two builtins that
> start or continue a sequence instead: run_specific_rebase() once the
> sequencer has returned and removed its state directory, and
> run_sequencer() after a successful pick, "--continue" or "--skip".

... is still kind of dubious. As far as I can see, almost everything
does end up in `pick_commits()` eventually:

  - git-revert(1) does via `run_sequencer()`, which calls
    `sequencer_pick_revisions()`, and that calls `pick_commits()`.

  - git-cherry-pick(1) does via the same call chain.

  - git-rebase(1) does so via `do_interactive_rebase()`, which calls
    `complete_action()`, and that function calls `pick_commits()`. Or
    alternatively via `sequencer_continue()`, which again calls it.

  - Skipping commits via "--skip" eventually ends up in
    `sequencer_continue()`, and that calls `pick_commits()`.

The only exception that I could spot is when we abort the sequencer. But
I'd rather have us call auto-maintenance when `pick_commits()` is done
and when we abort rather than having every user of the sequencer do it
manually.

Or am I missing something here?

Patrick
