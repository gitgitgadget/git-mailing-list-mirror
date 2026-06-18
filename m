Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87722E266C
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765685; cv=none; b=gtJblWSwhZ5EXqhQArtFl1w73Y0Co6OkTdvDgbrpd1oDQG2T3IqV+D77AcaN2PaBYJweRklOrrOX4EX/ESJmZJSV8aHx3W07jBwf405tCkUPtbX5XgOtHhsS4mu2mMBF5b0MKfXKquInderNuYJZWlkZRtEFVngACf4jhg3hMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765685; c=relaxed/simple;
	bh=qR3Q+8FU7k3pUe0ty76U2Pc3dB05TxjXWdfOI7Xwa2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7K4+AVhjqUFqSadJq8QtmtDCPPpmecHRVvFbKafDJ632Pja1D0YZeoOQCIbZ+9k9mAX5SHI2OQJ6A7Nzv4ZrRM57ZnDEa4nsv8gchQkvDlDA0oRZJlm5v0Y78cKMXM5AhnYTEwrGOEUBPn2n/mvz11wQ+Eq3a+L0OmJ3q9Big0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G7pJvUzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HE9D8oo2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G7pJvUzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HE9D8oo2"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ADE01D000D1;
	Thu, 18 Jun 2026 02:54:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 18 Jun 2026 02:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781765683; x=1781852083; bh=f3EsRUegDG
	9UhriknII828L9JMfWKYJ7IwZLtkknG1M=; b=G7pJvUzE1IMVEbdG4N4JyXrnof
	t9RTfDaobMRaGyqameYFN6Gznse22Q3MypW5sCdL4nLHCxqxsOLAhzsypVvlZHy3
	Oq+yO+hjI3+UsHccGaEAPtNDCLbKUKqdSR705GFcSFTzo+qTqI5HfJXdM6BCVxnQ
	mgD8lPowfoT7FJiIPNhrf0GB5zLTQNrbBuyntFWFb5JoygmCnU91NbcSgXzM/5mg
	l+O2XNWxBFnOkUi5MV12jGLJEDChfLgvhHszVfZxwtHxWRRy5KLdNdt0a4gxChyW
	K4D/LzLFS0CDjFc8Kz1sa2+iWtQbHKuNvU+DVlx25pbuADAn3jS/lBNoaqKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781765683; x=1781852083; bh=f3EsRUegDG9UhriknII828L9JMfWKYJ7IwZ
	LtkknG1M=; b=HE9D8oo2AySThmL/odcBgU9MHlt2zZRTJPkGBT0xIK0BcIzWKVA
	rZJKBXzI52ul7jn6uAcn3I9EseVM9QhsijRJimwytzWFz0eyvJ8AM+ca51HCnsgy
	duIxmKy/8JTRfKorMZtYCrydXoHlUWhOXCarn54fPvdMrLsAYceU6mWW8zqbw8MT
	YnSTGYtE0cVCPaiLJ1bflj5M04riJPILFWZCOnRC/hAV7bGVLaFh8OOhPUEu4t3N
	dA0MniwgFtlcHYrnFO52CpLBSkhvOPhU5Yb6yAXNWRs7YDBh/RZVcUCCP7V+bkT5
	O0zryaxW7imoiOrGFYmCMzXEfl9Q+7U93yg==
X-ME-Sender: <xms:M5YzaouYNMBnB96O3W6pbJAVa_4z-irKEivkLjD-5IIYuRrubpc2uw>
    <xme:M5YzaseVxKQgl9r6jdYvkt2nWUOuISlehSAf3ueJbSwnUN131xlQ9kJx8yut1T4fq
    MUr8IIP-qkQuVMUCGyf1uPshAB3Ia6IR02hEK_N3FGcx66Y40D4VU0>
X-ME-Received: <xmr:M5Yzaoydotm2Rulbc7rAo6m4nZkuW4Mg2u4LVZJCOwH42FdznOum_bpsy1lFF71US57pGVQpQqCq_QoBaYNfYhB2ydxY00EQnF15EjKCgw>
X-ME-Proxy-Cause: dmFkZTFJvsQ/e1JuJmviG9AB3wvQkoteeJ8ofAiJeiXOryqiLBKPFIerKjRNUtZ9CpAwXY
    SEaHO+JaMNVlGPmzgA08HsBQTskgYvrF2Vq9I5dmdr/UdlJ/Fm8kC6CgVpnyVbDmulINFG
    KZH49m5HSpl2tX3KfQLf4WxnrfBw8wHKygroHJZaqkCLjkHOJ6sxjkNUyD12comYHi6QYS
    /g4QCruM5J7YxIAG3Mg8d+oOsnc6LIwrUT84WFRjCY1RkJbnHS6TxOXlEI8+JRvbvB/C95
    Q6FpUBqETAhgRgIXJQfjnWAXQuXIdecvB2B9bRN9VSOfoebBHvvelsCOSNz7JfxnPC+SUK
    eTG4F5KRHTxuDksmv8KL0LepcjrU1jSUoVAvnYXORIuzCkHGpfs33prDXmjl8SHzgvZNcD
    iEemS+D1WNe163pnMm4YSbh3wNA/IqHk0scsg85XTf7adnv0VMJcBOjosftFwvIS5w3SbQ
    +PBDkeQqmCsTFiLvH31BgqaJRwFywANHoRygxNAGYSrpGsijDbBiiiEV4S+Jb2bbsv9ZzS
    MPPJKcBO0M3o99W8hOOOxo4jLo9yhJZ51OFCiIJX7huTtiO3Gs+620DE4raYMfTc0H75uj
    6By5mU/pY5+L3wEDk6TKjhvxOjoufpNDqB6HjxMmX4/NObP5/UaBgAAOSXpA
X-ME-Proxy: <xmx:M5YzaqHq-EGAhuCbv1zUrWjnEIhL5yHOs6rjU6fehdNgGWO1_h3EFw>
    <xmx:M5YzakzCdVFabWFVxlreixCk3z656j5ZL9HcpOVqY0R8vCVTHkubkA>
    <xmx:M5YzajtQWtAfLFYk2WclpI0xiS11CXra6UUGbYtwg_PY6VPObtf_Bw>
    <xmx:M5Yzap0-2IIBFuh26k1o62WxZE2EB1kj_BYKGtgLh-0HrTdWSZiwuQ>
    <xmx:M5Yzah0MCCm8jvvoGXBCqm8tzyh1_CbPwhSANDvVaN3qVBf-UvzI5Qwy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43a7abf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:41 +0000 (UTC)
Date: Thu, 18 Jun 2026 08:54:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/8] refs: unregister reference stores from
 "chdir_notify"
Message-ID: <ajOWLlNckbLfSC0t@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-4-f4854aa99859@pks.im>
 <ajLdIY_fxkKDTBaW@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajLdIY_fxkKDTBaW@denethor>

On Wed, Jun 17, 2026 at 01:02:23PM -0500, Justin Tobler wrote:
> On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> > When creating reference stores we register them with the "chdir_notify"
> > subsystem. This is required because some of the paths we track may be
> > relative paths, so we have to reparent them in case the current working
> > directory changes.
> > 
> > But while we register the reference stores, we never unregister them.
> > This can have multiple outcomes:
> > 
> >   - For a repository's main reference database we essentially keep the
> >     pointer alive. We never free that database, either, and our leak
> >     checker doesn't notice because it's still registered.
> > 
> >   - For submodule and worktree reference databases we do eventually free
> >     them in `repo_clear()`, so we may keep pointers to free'd memory
> >     registered. We never notice though as we don't tend to chdir around
> >     in the middle of the process.
> > 
> > We never noticed either of these symptoms, but they are obviously bad.
> > 
> > Partially fix those issues by unregistering the reference stores when
> > releasing them. The leak of the main reference database will be fixed in
> > a subsequent commit.
> > 
> > Note that this requires us to use `chdir_notify_register()` instead of
> > `chdir_notify_reparent()`, as there is no infrastructure to unregister the
> > latter. It ultimately doesn't matter much though: in a subsequent commit
> > we'll drop this infrastructure completely. We merely require this step
> > here so that we can fix the memory leaks ahead of time.
> 
> Since this version of the series dropped the last patch which stopped
> using `chdir_notify_reparent()`, does the log message here need to be
> updated?

True, will do.

Patrick
