Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0424DFF9
	for <git@vger.kernel.org>; Mon, 18 May 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091635; cv=none; b=mbRORvAuhiYCu5tFrkpa9SVqq1h71K2w54zHblcl6oN7BAzWGUfqMQw29DqBOIk49ROtAnV2k30AliWuH3KkBKBkuVnlS4dNW4ZbgZ+xMwct7FqK+96qnJXj5BKN4SFeU0eUZD/z4aeeCjNSedQZIi4d6Bm0DYF/qBHxAJonJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091635; c=relaxed/simple;
	bh=H8myXRdaPLzM/4KJortGlUibCngh1dXxMNu9kc5K7N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgXsfWjF9DHkyrAK1PDyzPLp3UOpOheHV2HysqxPvUfTBDgljCsJ8/l3pLoWL9ZBhi8czJpcp3G3fc/F9Dddvceb70IeUoa3RQRsTTZ+iAE4w3vVOqsbjZ0C3+e5dlecHwyJ5MBqAUmdT8R1AghDxmk/giK1yaP50WOrokPo7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lZS8q1Pw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPpyDdEF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lZS8q1Pw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPpyDdEF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 965EF1D0011E;
	Mon, 18 May 2026 04:07:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 18 May 2026 04:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779091633; x=1779178033; bh=cQeT19kx6o
	l2mnbOSEKR1iInVtrjkWCw9HOzBVNIOFA=; b=lZS8q1Pwif8TAXkrmVbPlYl+xs
	zXsqorbdadbt7ngyXJ6OwnSUbcudgBg3A7uNPbfz9/KQMJw4BD5G3TlbyuzqKC5O
	V86FCReLxin1Pq++fdSF88Ea6f8HcxqkLowSQQ8EeoXGMQxUze6P96F1y16TQPdx
	DjtfklPG9o+WpmoNJtLMfzDZ77Pfs3zLiJinWPiM3lwlQ5WnAt9hMLCNn7drjX1v
	4s/jEMNal0rN8zzaIKHOCYxQGL5cm7PBMpq/YJMYD7VoeH0TLNSeGMsrMWOy2rFp
	Y51iSpqZNq/aTeNqosWwbSZCsEiK+F4B9O8WY3Xr0R9IbSx+h5RD2u7HVGpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779091633; x=1779178033; bh=cQeT19kx6ol2mnbOSEKR1iInVtrjkWCw9HO
	zBVNIOFA=; b=XPpyDdEFMm0Vyy0fyOKkUcfZCxvBE0xy1hdv6DDfhH862wa4j5E
	kviLLUPaTeuejxTxhAfKuQ9tI2yAP0ICJyME0ht78+UCB6N1bVkfbHk3fNPwovTr
	wwLe5ctqQw2t+/6h7ng63dHm4FZ8JmZi1uYLPFc4aWYbC/kTVkw+SGi9RgByBOzw
	egJiRJg5KPqKtvhSGYacTcB4AJtPem8WBo8W4Ae0G0Ai8cm+kaFr/ZtieFepYFFV
	4ZeHYjy8YLt1/LttOhr2S0NuiIRAIgJGuTMl14kdUr7i77FldkooCEHGBdSLdwC8
	b3muvdNfGdqQEfpFTRlkf3c75lzRCHCMEUQ==
X-ME-Sender: <xms:scgKai59aEapEqi6wMOL5Z4DSYasWDeQcyUGZhEuuZ_SoMLWdYdstA>
    <xme:scgKai5hi4jiQnZM1v59m7-citzokyuBCvPpCtl0ug1_4k2KrVwt1HKloZsx9ouFE
    VdVLpt1JT4zcnW4erhq-rDudCOeBg_Le4A4csEV3AcQEBR8nxVKPA>
X-ME-Received: <xmr:scgKamfC-UTs6Q9LSv2CVr5SE32sUppT-44ijQH2r1QQFup_M5gehDmc2tznLzgqplNP60lf7xJQ1vNgCJ3IOkdD-z031UJUfXqJUEGVvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghrghesthhhrghlhhgvihhmrdhioh
X-ME-Proxy: <xmx:scgKauBdFCWHNpe5A7bcs-0oqu_mQLxntg2iXHcUSmCps1Va8eiHqg>
    <xmx:scgKah9uxI3V8t8sA-rutaD8OUAJD0gtrqVdc9GqGm3B4WZXM_1DTw>
    <xmx:scgKahILvYzJsVqU60rs6X_bmWfA-aTVYL6Il4V8QG7sxllJ7FLQxA>
    <xmx:scgKaij28hzOfO9FTJ9Fx-X_XtN0XUoFiMLpIYc5uPNeaTEVfVc5pQ>
    <xmx:scgKammdMEC1O_tbmvIA8znS470JfpLuI7eH7vlLiSpJVEYPxNnnJr1T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 04:07:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed75988c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 08:07:10 +0000 (UTC)
Date: Mon, 18 May 2026 10:07:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Joerg Thalheim <joerg@thalheim.io>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable via
 core.configLockTimeout
Message-ID: <agrIrGwSMFlKTx9x@pks.im>
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
 <20260517132111.1014901-1-joerg@thalheim.io>
 <xmqqzf1xbl4i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf1xbl4i.fsf@gitster.g>

On Mon, May 18, 2026 at 09:46:05AM +0900, Junio C Hamano wrote:
> Joerg Thalheim <joerg@thalheim.io> writes:
> 
> > +/*
> > + * How long to retry acquiring config.lock when another process holds
> > + * it. Default matches core.packedRefsTimeout; override via
> > + * core.configLockTimeout.
> > + */
> > +static long config_lock_timeout_ms(struct repository *r)
> > +{
> > +	static int configured;
> > +	static int timeout_ms = 1000;
> > +
> > +	if (!configured) {
> > +		repo_config_get_int(r, "core.configlocktimeout", &timeout_ms);
> > +		configured = 1;
> > +	}
> > +
> > +	return timeout_ms;
> > +}
> 
> The above design means whichever repository happens to be passed for
> the first time as "r" to this call will fix the return value from
> the function for the rest of the system, meaning that the lock timeout
> is a per-process property and the repository parameter passed to the
> function does not matter all that much.
> 
> It may make sense to admit that this is not a per-repository
> property (due to the use of local caching), have the function take
> no parameter and use the_repository to the config_get call.  That
> would make the intention more clear.
> 
> Of course the other end of the spectrum is to get rid of the
> "configured" caching here, and ask the config system to make a
> hashtable look-up every time the function is called.  That will keep
> the lock timeout per-repository, which is closer to what the current
> function signature suggests.
> 
> I dunno.  My gut feeling is that there aren't valid reasons why you
> would want to specifically set different timeout values per
> repository, so the simplicity of using the_repository (i.e. the
> primary repository instance this process deals with) sounds like a
> better way to go.

There probably is no reason to have different values per repo. But to
me the question is whether there even are any use cases where we have to
lock the config file so often in quick succession that the caching
mechanism even matters. My gut feeling says no, also because parsing the
value from the configuration is going to be drowned out by actually
writing the lockfile and renaming it into place.

So I'd rather lean towards dropping the cache and keeping the repository
parameter.

Patrick
