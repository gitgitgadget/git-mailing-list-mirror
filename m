Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2F30C37E
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256507; cv=none; b=o2QoqvWUfRBUJlajxtZAYcqKtJn0uPuUVV1YHrDaIBMn0PacDQwXXo67GfCfAxeLIhOTJbZrK3yVcR5rl89XJP8oP/4wl4SVwWZFDfPccBzVRRZFB1Rupfc8c1jEPy/l35UP3zwkWZHeYcbYzmBMqoYAI5KwHEfuKKXPcY06SWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256507; c=relaxed/simple;
	bh=ZBS+BuKt0nNfD5k+P9ac7KM7QWOcOODpwqSkgy/c590=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5SBO1l5PWwIlCjaFY6TlYwSH0+NvYPBxuZnU9jUXLxY9vtDWys+K2zdUgGnjvttc3laORPyymiJNjOZ4eEDs2D7RRz+BBS8K6WNr0+PuvxDCkzSzH3Wb7suuAOghsru6kPel943Gyj9S+7uspjdzASCDbWDx4+qaSRwCiWMgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lethkTu0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+L8V6ey; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lethkTu0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+L8V6ey"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 90422EC0139;
	Fri, 12 Jun 2026 05:28:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 05:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781256505; x=1781342905; bh=Hn9ie4Gxz/
	FHo0gHrdxN4Mg2kB3zlTe3ZMVaN4QEkXo=; b=lethkTu0qDGvI/YYIl1gidgs6n
	bd2goZ63qHRjzuI2RO9LSEK+FEA/kVudWUCmeRdeJNWvYVageAVfecJRj3wwnJDq
	uDGpmJi7hqgBEU1SpXXW4LSOfDKyDqCjfEvEIwOju+kjKPP+0u0LR2YFO1pEdynO
	obY9Z60uTQfhOf0cZ5a7qzLM9+Mbn+a1DOhY1lz/HuwS7WvoWwRLKTE8Sp7FdJe6
	KBd1PjQPVWc3QpFdaabt0WmOJMU/LgIspYRR0+1xm3kV1G/XWT/LXMXH7m4cTstB
	+qofGFxAbbsJig82vkNPb1Y20hw/9ULM1Nhky/VgvaEjahAcTEntN19zCdJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781256505; x=1781342905; bh=Hn9ie4Gxz/FHo0gHrdxN4Mg2kB3zlTe3ZMV
	aN4QEkXo=; b=Y+L8V6eyoZmqaAehBQutViVdjEddSf4bJkWE1iLnsurm81CycnO
	7TEHHInBHLm3ZDSdKGklAAEVggDJfattnGHjmL131JvONWRo6OzJY/vUDPrdqp3I
	Uc/N9lRmr7SOKGASviFtB58OuKq72Vy+qlDscmRvRTpuGboBraSLGjGBpDUef4TG
	SEt0lOS/JILXoZd/aiODOdqZ8FGFLhP95xpVywIVHigJZxhaxd5v/uecccnvrmXC
	/stq4vU/FbIz8mm5QSwUuQcDc+k5jf+aFYVbSB9kZErH2sV2hL2Db8m9j04Vjx7F
	jqQoQtbhQeVpa4vQ2E0qXGo93F+tMpxuo7g==
X-ME-Sender: <xms:OdEravpGjBb73ph9p2XXqBZ0naT0XYL4O07SI5eLBLhnuMuoyrZ4yg>
    <xme:OdEras7cdBB_ODVDk3W4kipItTFQrhfsmUEdQzjHBWkAxpbaZySoP140_oEsdBfM3
    hXxGhT_vFY5r0v5jBSCNx3WmeD-KqH8RECZCKw-swrQMHes-mjL>
X-ME-Received: <xmr:OdEralqb1RqVUUnkqNIkSSlyjnxqXRsh4t-6qNRUO7O40vUmLo4qxZ0grpYeYKnDa986bvyxITEXrRsApFLK2wmelYU9W9rwxWpNom0Nd5s>
X-ME-Proxy-Cause: dmFkZTE9i9VGTQ4eyt6z/ZoJ2AL9bQMI/8CjXPD/vqG5r5eUcowDsMWpPRmCMt5oa2nA2W
    QC3dHLPiLVFp26s5IlBkziPeyAVj0Btp0Sw6tutT1XeZGb8EvuDX3rxPvZDC/dYUuXf2ip
    dd4Go0SHURUwR/MTXrm75UQgX5Gu9g+Lso+yxuxPSNScIRmT96MYRRc77dYV+twvM1HDgT
    bBHvksfKgceicy+A6sMf7n1iEPnZUQ/fdOG7HUkRCSPdaJ3oMfd2biiqMdreZQrTgD3Dcw
    OcGCiM3xfdEC2UGybWECDneKBRxujwUblLHtkTn5mcRVmGT7OGXhjaBDzLnz+VZmaRn/XC
    mihHqeIpJox+umnuf+Hpe6etT4pL1zeHsus936mIyB163gTxp0V9toIBH/CUOPyJAsMCx7
    1k7nz/PYjtYIpIig4gDheqDLn7DWGyACdztb8X1KwEkZvN3FMIdkOdR0GO5A0JAm4TCTUq
    uP7PrqfX8o4g3F1GaSQ4KYQzZCYLJx0AhgkoImoXZSF8HujssRToiTUh+408MucojtSQRd
    e+mf9qjn5XE4citm4ItwSXzzpC5n5jLWAc32E+cB93otC+BHMgJx5MPCT7lf/ZeXX4gyFa
    zxGuhmYEgBN7QVxUh6crMu/M2d25isB6gmxrQUCiOFK3yXSCpOrNBekqIRXA
X-ME-Proxy: <xmx:OdErauh83wOMm1thaTS_hvH-fDS96x43UEaopyA5TBSGAsovOAhugA>
    <xmx:OdEravIf0tANhDeUEvf3FaFPg_RZq8lwQFxG35aWZnc0KBlZg0Fbzw>
    <xmx:OdErauAPFm-J6HxIMA1n4m19O-AkVul0L4gy3_TqdL2A10WMmqN4yQ>
    <xmx:OdEravjCVmQ9sK5KU0_tnYQcFcmtrA9JlVceihppGKUVART2Bvlj2A>
    <xmx:OdEratgegrdHpYmEZoUF76ogTuj1PNqC92s3S4QxHLA0gqotxj8G8S_G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 05:28:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1d8eef3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 09:28:23 +0000 (UTC)
Date: Fri, 12 Jun 2026 11:28:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 5/7] environment: split up concerns of
 `is_bare_repository_cfg`
Message-ID: <aivRNR-Xss3JTNkc@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-5-a6f7269c841d@pks.im>
 <87wlw4yys1.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlw4yys1.fsf@emacs.iotcl.com>

On Fri, Jun 12, 2026 at 09:59:42AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/setup.c b/setup.c
> > index 71fc6b33da..32f14a8688 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -795,10 +795,22 @@ static int check_repository_format_gently(const char *gitdir,
> >  		has_common = 0;
> >  	}
> >  
> > -	if (!has_common) {
> > -		if (candidate->is_bare != -1)
> > -			is_bare_repository_cfg = candidate->is_bare;
> > -	} else {
> > +	if (startup_info->force_bare_repository) {
> > +		candidate->is_bare = 1;
> > +		FREE_AND_NULL(candidate->work_tree);
> > +	} else if (has_common) {
> > +		/*
> > +		 * When sharing a common dir with another repository (e.g. a
> > +		 * linked worktree), do not let this repository's config
> > +		 * dictate bareness; it is inherited from the main worktree.
> > +		 */
> > +		candidate->is_bare = -1;
> > +
> > +		/*
> > +		 * Furthermore, "core.worktree" is supposed to be ignored when
> > +		 * we have a commondir configured, unless it comes from the
> > +		 * per-worktree configuration.
> > +		 */
> >  		FREE_AND_NULL(candidate->work_tree);
> >  	}
> 
> Looking at the diff, this is really hard to understand. But your
> refactor makes sense and the after state is easier to comprehend.

Yeah, I'm in the same boat. Honestly, I really hope that our test suite
has enough coverage so that this refactoring won't cause any significant
regressions. Which isn't exactly a statement of confidence, but rather a
statement of "oh boy, this is awfully complex and has lots of weird edge
cases".

> > @@ -2571,7 +2584,7 @@ static int create_default_files(struct repository *repo,
> >  		repo_settings_set_shared_repository(repo,
> >  						    init_shared_repository);
> >  
> > -	is_bare_repository_cfg = !work_tree;
> > +	repo->bare_cfg = !work_tree;
> 
> I'm curious, do we still need this? If I'm not mistaken, this function
> is called after check_and_apply_repository_format(), which calls
> apply_repository_format() and sets repo->bare_cfg too (see the diff
> above). Or is it explained by what Justin said[1]?

We can't drop this because after we've applied the format we call
`repo_config()` with `git_default_core_config()`, which will potentially
set the `bare_cfg` variable if "core.bare" is set.

Patrick
