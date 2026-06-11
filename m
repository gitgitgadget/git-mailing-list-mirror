Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D134EF0D
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159796; cv=none; b=NmG9nqZ0mmZeT+eSQdeKsg6jDJdrWiLj6O/YDskkminZQoDFAYk9K2xl6GVOvoXZhMN0yAZoPiGCeEOG/opwkWkrB6Q7LxdDn3AaPVQsqiZPk+d2rgONN6RLkqCUHOighWZoN56ltJzuN1PnYIElTfJTjq10xHjl9f5kIvIpN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159796; c=relaxed/simple;
	bh=RivQvZvRCqVUVMkQ+If3q90ymPIpX1NqAVNA9YYHoIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHwjq2/AgQfSyJwPrN/bpU1gtmoHV/IYKPPP+sYlrW25Nh5FgBz2OQgO+DhmEdV92Nd3Rj0rFsrBQSDPcHsonmKFAdHwRM/FGYkgdv05WuGkWO+x17TwCAXGmnahML7UcP6Hy9gYEZjmGTHmcdVeZluSWdwF/oFL243AISl4GA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KZsdRuEG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jy1XcSfQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KZsdRuEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jy1XcSfQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA8D87A0183;
	Thu, 11 Jun 2026 02:36:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 02:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781159792; x=1781246192; bh=kK0DXNRill
	HF6qEYr6VwuZc+6/odrajWDvnSbfi5Qis=; b=KZsdRuEGMdsSPnrmmZxWFAnMp1
	sZkwoJJ4cEAn//ANRTRhpcoXD8Jb1Iu7fW4rZimNgTzy+LFV0bVIn/hmi+EJlc0C
	P9fbo37f4M9PLCc/aoVKgGC8kMTOjVDlooJPF3Nae7ARDDlVUuT0QTHwDknLU1ba
	ZfHYjmrzytgqlCZrw2t4xNStDVL+zEZZt1wNJ+JASzV9Hc/gMqXRZIADLXghguAW
	5cotO6FW04mkHGtjs4YD+Zcffqgv/3CE14d9s8bgugeVElYEPAvKea9ejPOx9pXq
	zC1Tm/Ml4DJksSgmeUxh8Y5/tnzU6ZlAdmMH1y+fgVFP1pQugseEZKJSJu5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781159792; x=1781246192; bh=kK0DXNRillHF6qEYr6VwuZc+6/odrajWDvn
	Sbfi5Qis=; b=jy1XcSfQnGImATBr5UrftGjfH0sf5s8w7SKH4y7dMQQimdx5B3m
	T+zqROyox098vn1dQK4Z4ZX8SnhdH1tGqgHzmB1e3MpDd+ipEuUrw+rDinPibIHx
	1Wuqb024hvKNQwuCWuwJFThbkQoPW3KH5saJdrRK0Kg6eOOKVuRN9vNmTGlBqdsP
	O8inffpKQwOCRRJ5Gk3pgwndCnfD1wVj3dN1Wp9zqv4ltn3QAAfJGPZvOHwxbhJR
	ciFQ5ki07rnlfpniDFDFtWUhQJj2ctzuD2jE/EykJZ0gyw22tDjgQzio8qnn/As/
	cX5XbCmbbInF0lxJrtVZ3y7g072rVxS0dBg==
X-ME-Sender: <xms:cFcqahPY4JqgwgaVMUV7NJin8JD9v4XoxKRnIi1miMJ2WVUFJfghhA>
    <xme:cFcqap-x9HeM2JQX8SkL_1CD9A8ZXz_cpQk_gcnDvM2ndyswpiPhWPk9xrx62NKlj
    ns2gz143gsOESkF1moRafE9WqFfajNKtVdXmqQyAtGXT-h5lSSh>
X-ME-Received: <xmr:cFcqat5wob_td5dztcoTj_PN4josbdb590bo_BwVTyjmrcBt1QlDJT5z_ilI5KPF7WEvwP4iv7WHQRKe3w_Cc92w8oW5DOETLzq3paed6y2v>
X-ME-Proxy-Cause: dmFkZTEj7RZp6u4ucLs3Ybdom9lg503EWco9CpeEfGvT45ayiuwytRZqtbCWftRye17VYp
    +R+JBO9FACExFElzzZ8sokQHGoEtesdZ/oVfAHs4pSvCrFOdVu9vt2p0eYPEE8/+No26f/
    /GH2ATLvR0E1mURcHixjK3zXvP4Dh6EWL/s/IzoPgEqH2NTJo30sk3TSwv2CqJtmOq6c8k
    A6QHkUxY3b8eoFg+Xxro1oH8b+zGUT4kSCFo1uG6fDyjU2tR36Fp6Qo0DhZBby9nMT9MFa
    aVn+QROfNk2A7vaEqdWnGeec60IKIU9yL14NqfYDr9Az5r4p6DyuC92yd4kCyJ94WlS0Rt
    Am28CkTbZNO5ZLBtFg6zqODKQyYiqYxIBb0Pz8nCSkUCwlKDp2PgecYBh9vB9v1xBuyjgj
    PnfUq2n3WnxTFLBNQskM4Q13XfayNCBIeVPSy1vcayknR1dUUKlvfVBUkVZj9FKAxAboWw
    AALl3GWYCHYwaDailXw1GAeTSUBZkEhC5zuQZc/v/D8EfprWQDuvD26VRihxKCJoB5rLtZ
    6TEiuin4C4hBAeWxLdS/3HJFFspSy2tDpJSYpnrcez2zS/hd7bEvIURotMz03EvsDdVp1R
    2N7BXOzXed88/tofC5u8obX6yD69lXSGXtDcRlpeqnxnB4KBZVCtpVC3TlHg
X-ME-Proxy: <xmx:cFcqao3LplvSEkgRS0EMQQ9_tQCgIa-HiwZgQGAJoepc1XUxkRIwQw>
    <xmx:cFcqasDWp7ZZQKcMpBlcYnyWFmMxjBbDm8TGt42YlLvEBUTsrZBfHw>
    <xmx:cFcqai3b_qYeuzboWzuXnJCeaIFhRThx5N5_fcWdxSeQuwsLlU5vIQ>
    <xmx:cFcqautyfgKt_kX7QReiD7gu9DrLmBrx3JQU_8SLtg08eMDG3ocB2w>
    <xmx:cFcqaj_cY6jOff1GkloKZhJqrdy9V7reYLhX1ow2WhaArRgAfdoBTmD9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:36:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f51f42bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:36:28 +0000 (UTC)
Date: Thu, 11 Jun 2026 08:36:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] setup: remove global `git_work_tree_cfg` variable
Message-ID: <aipXZUrDcM1gOLsz@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-3-5dff3eec8f06@pks.im>
 <ainXM84fGggtEZzM@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainXM84fGggtEZzM@denethor>

On Wed, Jun 10, 2026 at 04:52:12PM -0500, Justin Tobler wrote:
> On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> > diff --git a/setup.c b/setup.c
> > index 52228b42a1..71fc6b33da 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -31,9 +31,6 @@ enum allowed_bare_repo {
> >  	ALLOWED_BARE_REPO_ALL,
> >  };
> >  
> > -/* This is set by setup_git_directory_gently() and/or git_default_config() */
> > -static char *git_work_tree_cfg;
> > -
> >  static struct startup_info the_startup_info;
> >  struct startup_info *startup_info = &the_startup_info;
> >  const char *tmp_original_cwd;
> > @@ -799,13 +796,10 @@ static int check_repository_format_gently(const char *gitdir,
> >  	}
> >  
> >  	if (!has_common) {
> > -		if (candidate->is_bare != -1) {
> > +		if (candidate->is_bare != -1)
> >  			is_bare_repository_cfg = candidate->is_bare;
> > -		}
> > -		if (candidate->work_tree) {
> > -			free(git_work_tree_cfg);
> > -			git_work_tree_cfg = xstrdup(candidate->work_tree);
> 
> Ok, we no longer set `git_work_tree_cfg` in favor of just relying on the
> worktree specified in the repository format.
> 
> > -		}
> > +	} else {
> > +		FREE_AND_NULL(candidate->work_tree);
> 
> Huh, we were not previously freeing the worktree here, but I assume this
> to avoid a resource leak?

This is in fact a required change. Before this patch this here was the
place where we populated `git_work_tree_cfg`, and that variable was then
later on applied to the repository. So the implicit `else` branch was
basically just `git_work_tree_cfg = NULL`, but we didn't have to do that
as it already was set to `NULL`.

With the new code though we're not setting `git_work_tree_cfg` anymore
and instead directly populate from `candidate->work_tree`. But that also
means that we now have to clear that variable to retain previous
semantics.

I'll add an explanation to the commit message.

Patrick
