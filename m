Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FBA34EEF7
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028081; cv=none; b=usK6Tlv4Fo4LfypKPyuwUgmkHWFepvb2bSTYuePr4+AkMYIyjR+2HJH67+Y0J5frHho/Kg5AxhtCQlqkgZ0uYJ11oYByCTM16mgc5L1rmCTcT14n2jJn8Ei9KODbcNGCoYuUxvcj2FEbdhWNSvAiAZ4qgm+BQgy+RX4jwD8QSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028081; c=relaxed/simple;
	bh=O7cbE0FaTPkSfAU4GKvsNDHjNM0fDUdEh9an5Dl7eFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkAh2tcO65PDElOjx5av/mbxoKLD5K3EIrxKghleJxf0h0vi5ywkzXgLhvHUCDkVf/Jx+fGHoLohPk6XtboJ4Yv2kq87D1TwqAOixO6vBz1i6vWPb3O4IZvLoaaG1ILTlw1tw1vLYKdIK2BDgclOKRxHs02AIznsMx8jhsLqSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lqmBFqoD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzSbJyZR; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lqmBFqoD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzSbJyZR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B32C7A00E6;
	Thu,  6 Aug 2026 10:54:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 10:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786028078; x=1786114478; bh=6VxUc2mOA8
	C30e8peRCtC34jLAv3ZFfetAZW8+ezJTY=; b=lqmBFqoDdKzFAGB+5DcuLyjiV3
	o15IJlbbD90zBzvYBlSrxeBeefg6VQ8eDZCGzjpbAh76H3m/4sZPJ+TCbxdSrOU/
	5sZ5dEpAydPSRU1+xg+aLqjEfLM5mA5E1FZhv3WLx7NNWM6FIVfVq4dcOcoTdHTY
	x/fAk7rl7PzosTwcGK8IynhPWmlGZX4T+pT5MpnWB5aEjJVQi3NlGmwd5Y2GHUXP
	qV3+ipCS3hkaP9av9MQdVcEqMEqMo0N9LcH5gRFor0i61aXf49dQx84om9VGl2RS
	kRO51D0WezwsnosVSYDbtXa+0UQhwtlH/eSbN/S0AyYX1K7rNCSvO1oYTypQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786028078; x=1786114478; bh=6VxUc2mOA8C30e8peRCtC34jLAv3ZFfetAZ
	W8+ezJTY=; b=LzSbJyZRMiB4aMiAs5xm0c0rB96UeMPGt6AzjHQ9TVmPMvB5Q5g
	TFFaLMexSe+pRaR8laj21UijYMpgWKjfeKuw+XKk07LOVZcsFGs/I60dj+rfF/Yt
	5oLhJSdUTokx9G0erG4ZuB6BpDx1Yn3CrYkxGGqIck8W923YEAdfEYEPW5A37A1U
	gE6MIBqsTBG25JXAQwlSJsXwBWA+EHQnxFyLOaNw9dIuIAd6la+UTUI0yYly4TT1
	p4EG3uCK+CNhsN89XY8T47gje1qWqAt6t5RkC6JkLJYi5d7+8kS4W6jaU0uf4AwJ
	o2ILn4OdkticAWOnVYkpMA3Q/yfYa0r23tg==
X-ME-Sender: <xms:LqB0apsldjS3cbNkyQx2UNT_rrwSv4ik85FevnJMVOr2ay7zM_bHag>
    <xme:LqB0apcFKvSTOlsXiHomxw8v-n5heXuR2Uy1392RrRjEW0HErHE5Z-GncIBne36hH
    tpCLpI4tyuVSSZaddEgPvvxMstyeN_i5v4gY7SI46X9J-vtYkmp>
X-ME-Received: <xmr:LqB0ahwZCD6F7LGcbcTcsxbqORG5itW_rlSGNzs-UtQCj61zX65lFfRYu6eKpT2DbHBR-gfhQxflzio-joC9BXa20PlWnrxjdz7d0XnPcUM>
X-ME-Proxy-Cause: dmFkZTEBpqZP71tDXvlYEqXpq3vbOb4Tdr0tAL5dRoXLHzVQiXC5dIok1G6N+rC1SZmcVw
    kB9ZEnEgncoxErhxVPbQHQDZbtTo/b8F1e6Nnm21Xkyn1hqoYYaEteZQjYyRDf5lES5erU
    qRF2YULaWaXDwVuXk0ZVNIshAzLrwyQ0IEyZH4IOrbvOvWRLq5g5/drSquXbgfgjRJsS1r
    JGu2ojl2/aAyLJSnHA54RI03E+/xxI1qqhVQLbiw7OfFv52ZzfvyBC2MO4Xzl0B8WBAHSi
    XP2oWBC+43/gjiNbFCdAMKigDIb41YV+v2AwjewYvZFKIwm+EkUS7HIIjbN1J4mcQePWie
    KrBiLRFTFNdkXTtPldUkDb5PfMfHq5akTFUPaQw6aHa2bWHipIPKv3ArLga0XH+tMRV+GE
    xctp5tc38QZ/2Umpkj6+oRdXvlthWCAv3NFBnZFDhstmQVmIySo7wdjJArTU3gmAlUm1uY
    4Y5ilAKGPH4s0SMvkl6DYh/rK4C89cDXGkGE0CeRSCIXKQ6ej3f1hpnkZXlnB5nZDLcv8B
    9rK3Qfz7AlQbeuzVYLZoXrmpaJ62Ey7+eiSxwZfOTBIztQ/opIOFFEpKDwmmoI7ioc1SOR
    pIgNoQGmHlR7ZoTAe5r8vx+1DhSxO8X0mAq5d4MwmE2puEKvgsE22QN5wfsg
X-ME-Proxy: <xmx:LqB0avHm8fYHuSXgtZQtYJk9I9qnZfZ2HFK1mMgCkefuGKQ22-kvrw>
    <xmx:LqB0alwQ6QtAoqPM5vfZMSeVTFiibQpKcb4qYRPekvLk9TE7CoUbLA>
    <xmx:LqB0agvtVKKA5EPNH3DFPIQFL4Pn4n3w9eS2Uk9IcYtgiXnyibv6dw>
    <xmx:LqB0ai3jLwPm43uw1tT1_gMMIq1Md-AIB5OyST94nM3BjU_eyWlwog>
    <xmx:LqB0ahxAriXgZokQruH-muFUJs6Hs-GRNjK5TQABO8goyBFWnl6qVNnu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 10:54:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e4315081 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 14:54:34 +0000 (UTC)
Date: Thu, 6 Aug 2026 16:54:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 4/6] setup: defer object database creation
Message-ID: <anSgJ4pHuwJ5hylE@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
 <20260806-pks-odb-create-on-disk-v4-4-ba8b4fdd2e3c@pks.im>
 <87tsp749be.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsp749be.fsf@emacs.iotcl.com>

On Thu, Aug 06, 2026 at 04:23:17PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/setup.c b/setup.c
> > index 5dfab3e79e..e39a1646bb 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1765,8 +1765,6 @@ int apply_repository_format(struct repository *repo,
> >  			    enum apply_repository_format_flags flags,
> >  			    struct strbuf *err)
> 
> I've noticed the docs in setup.h say:
> 
>     /*
>      * Apply the given repository format to the repo. This initializes extensions
>      * and basic data structures required for normal operation. Returns 0 on
>      * success, a negative error code when the format is not valid as determined by
>      * `verify_repository_format()`.
>      */
> 
> I'm not sure that's still applicable, now odb_new() isn't called no
> more.

Fair enough.

> > @@ -2864,9 +2862,9 @@ int init_db(struct repository *repo,
> >  	 */
> >  	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
> >  	repository_format_configure(&repo_fmt, hash, ref_storage_format);
> > -	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
> > +	if (apply_repository_format(repo, &repo_fmt,
> > +				    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
> 
> Nit: Not sure why this formatting change was needed. I would have
> assumed to have all apply_repository_format() calls formatted the same,
> but I've noticed at line 1883 in enter_repo() it's still a single-line
> call.

It's an artifact from previous versions.

I'll send a (hopefully last) reroll in a bit. Thanks!

Patrick
