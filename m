Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9AB346FA0
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169553; cv=none; b=G2cpjYtE26nAQ7yfsU3IMqfINEsR2pn1FBIvQiCu7fPX6SG+RS8/ehxkoJJP7bGNYLws7rC8L6Nb34hp9GcwBQwjQEEL4+euJ3J5m5riE9dOPcJZZ3+Z6fBab5+6Et5z/KEsnZMYChCgducrwDGceOM8WL/zhBauVITWkXwx1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169553; c=relaxed/simple;
	bh=V4uxX8EsWfLsx9+p2/JZq7roD9+f/MaB7NTh6250taU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXOL+KdkKfKOhZwkRcDpQ2Xg9QHoXURVxDOYotHoG+/uruf+CMhP9k+4KdWRTc5hfBjA57R6rMJjpdBrZwmGuR/ug0a/TlRa40RP+LMBf6JU77Z4rh4iCpA2V+frhPGAtOwV1JJ493LIvN1jHAzsZg6Gk03XfXw0TUvay58Km6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rKXHPQBy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZA/uRxpb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rKXHPQBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZA/uRxpb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E0A61D0011D;
	Thu, 11 Jun 2026 05:19:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 05:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781169551; x=1781255951; bh=qC1SXADlVM
	LbbmTswOX7s+G4wzfWvboxVTALUz/kF9E=; b=rKXHPQByN0ZwVBkKshm2prCoie
	83fQEFCqnswGoKHAW55jjcrSL9dSHINDkeN4KcVqxzSA+mV4BM4Hz3wXWmWnrEEX
	9OobiMbYsfLFWoyPqVyxVPR3AaACm8YCWkfgCYNnJ40t4iRUR3m9x4QF6LkMlB0H
	1Fh7ybTBkMzj2EVNyKqoQvjo4yjzCnfeWfYD+QL4E+RYAt6sUszEgG9MKMT37kOI
	1zqei3OmXPr/6/uxphHJgc+Z+aTEvyRLWzVbKjWTMx5qt7uMksnCKPOBmDgUod3l
	pGgs0bfnpa++ElrN9IzKe//5oQ2RTzlalCzPFOFnj2f+wjcKArkyOF4i2zSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781169551; x=1781255951; bh=qC1SXADlVMLbbmTswOX7s+G4wzfWvboxVTA
	LUz/kF9E=; b=ZA/uRxpbFDGsjjLB6ahbmwfjXpJmD4C+pJxG3LuKItm5hZNFY/1
	tZ2JAfrFYxakhE+FJzX1KizoGieeR4XeYz+mJveNKBC9XnhHfLqTBue5EL8L5Up1
	UycjlfId7t1XttV0FmL/hxcUZooGB9EWiOzM5LgrY9zCKiIUTDlymFEE7LF7NOdq
	dbHn3iHxzTBOh6LBKWxKLWxI0q5qdDWMil9wP5flQK1HQZEl79OAZex6Gx2ZD2Ji
	Mqcra1WY02+HcE9Q1ZR6RhjeQUva2tzxf4XBEdfdl2qHMCGlPAF+KVzyHjcwItLt
	pESlkmw5y3tAIAYLdEyljL8X5piTHx0E7ag==
X-ME-Sender: <xms:j30qaiXSVlQyJvSuDeYe-exuu1_uFoV3lLXkmeeHVhfsriIGea1vJA>
    <xme:j30qaklXdJLAq8Ebl-Jx2zf9Wb97Y_3WzYPs1F-E0Mwan8F4ilxXw9XXsI1lUOt6v
    R6lJ1b04i_2K3C1yLxqG5I2FBzIFHHkQZPh9UmqmTIIi0B0NovZ>
X-ME-Received: <xmr:j30qakC2idsN-fnFLdR7Iee71Pe9ty194D59Q6cSBLRdS2Sd3fg6THhpwgceqSB5ID5YmYapbmTnFOOxjKYfUGHneOp0bqQm-os5saVd4hAW>
X-ME-Proxy-Cause: dmFkZTFXzyTzErB7zzttV7UdPh98Dp+i7JWcbVI0tMUPmgleOrCdsplzpaTFm73LJhnJix
    CPtf9BykmbzFBLFx3/AbPnw+kba4FZk8qtO+zgLTffSupRsj1x1rfBxS0c+4U2eEJt/T9L
    ZGCKDgZkHt51c23v8msNJDglOuhwiHMEFGMMQ07Lt9DkYpfCaWtzMkcFV/kC1KgakZBBFh
    gjaKsDMlKK/BcLYuEkaL39+btbNnc/OzrlWKoFZAtRdqdLNGMb3tcNeFJhspWpDzZbAgds
    IDiILnRtUYPDdcsrWvpagudqVX9rNQo0DIxJSacFEPiMEFHU68CEi40f1uTHJ5RLYL0zML
    HxJA3cQQA3vVKNISwfEvNbNaQgmjYa9/dmMqje7D1aOoKPWiW0yw5VmSZD9mn3ajnVOnjq
    VovXyEKlgcatCgnS34v/juLpvuYxQzu/pKVKSF3UghSwJ/oNptwXDQNFTSQbrguLPVBxI6
    Dt3u8b4vneEaPY/Hb281zI7Y22YVbYe8ITGBTld/AnZnQCPI47+pFsnaFda45vdJ0dAErN
    MQ8wsG2JJWjHhASD4IliuxbHqF0jvwr3Xq+cOEU1plpqDmWOPiagkRIzE2RHXteQ4JLiMx
    6T8V9TpTLzU6o86nqBfDUIj5z70yfpiXPcAVQdaKemESSfMf8Mo/Cnbl/4Xg
X-ME-Proxy: <xmx:j30qakdiOt7LEjlhJW381RCqyOl_HefWOHgxQWnvATAE5niQO9gB0w>
    <xmx:j30qavIfYihuzJurKE1JGEY5gLWo32g0n39nSMUUjyD0I_VWrYzOCA>
    <xmx:j30qanfxKkdUJCRZTw5msyBFvin85Lo67QXBS7yf74uLl5d8zt2SVQ>
    <xmx:j30qam1sgonGYi_VhHPkEKKyl9ivit-RKBGdu2U2p87s-K5yHs8Bsw>
    <xmx:j30qanGnv-D2qyFi5TVrmmCWGVUwgNCC5id5IvP4Hkw4b5aK8ZRikC3k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 05:19:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6bae56d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 09:19:08 +0000 (UTC)
Date: Thu, 11 Jun 2026 11:19:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] environment: split up concerns of
 `is_bare_repository_cfg`
Message-ID: <aip9irJ7WBaICxDa@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-5-5dff3eec8f06@pks.im>
 <ainesoUOuhspKxHF@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainesoUOuhspKxHF@denethor>

On Wed, Jun 10, 2026 at 05:22:04PM -0500, Justin Tobler wrote:
> On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 52aa92fb0a..566732c9f4 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -81,7 +81,7 @@ int cmd_init_db(int argc,
> >  	const char *template_dir = NULL;
> >  	char *template_dir_to_free = NULL;
> >  	unsigned int flags = 0;
> > -	int bare = is_bare_repository_cfg;
> > +	int bare = startup_info->force_bare_repository ? 1 : -1;
> 
> Any particular reason to continue mapping `force_bare_repository=false`
> to -1? Or was this to just minimize changes?

The `-1` value doesn't mean "false", but it rather means "undecided".
The effect of this is that "core.bare" will eventually override this.

> > diff --git a/setup.c b/setup.c
> > index 71fc6b33da..2b690da8ca 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -795,10 +795,16 @@ static int check_repository_format_gently(const char *gitdir,
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
> >  		FREE_AND_NULL(candidate->work_tree);
> 
> Previously, when there was a common dir, `candidate->work_tree` was left
> untouched, but now we are expclicitly setting it. I'm not sure I fully
> understand this change.

I cannot blame you. All of this logic is so unbelievably tangled and
hard to follow.

In any case, I think you might have missed the fact that we `else if`
branch is now `has_common` as compared to `!has_common`? To explain the
different cases a bit:

  - When we have `force_bare_repository` we are being told that the
    repository should be treated as bare. So we set `is_bare` and also
    clear the work tree that may have been discovered.

  - When we have a commondir we know that we're in a worktree.
    Previously we did nothing in this case, and that had the implicit
    effect that `is_bare_repository_cfg` would remain at `-1`. So to
    match that behaviour we have to also reset the candidate's bareness
    to `-1`, so that we parse it via the repository's configuration at a
    later point in time.

    The other part here is that we also reset `candidate->work_tree`.
    This is because the expectation is that `$GIT_DIR/common` should
    override any "core.worktree" settings. Quoting git-config(1):

        If GIT_COMMON_DIR environment variable is set, core.worktree is
        ignored and not used for determining the root of working tree.

  - When we don't have a commondir we previosuly had to also adapt the
    global `is_bare_repository_cfg` variable. This part is not necessary
    anymore, so we basically just drop this case altogether.

Patrick
