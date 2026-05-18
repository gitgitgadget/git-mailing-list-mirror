Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EDB17A2F6
	for <git@vger.kernel.org>; Mon, 18 May 2026 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779065169; cv=none; b=jEzdmodl3GNME6F84vIwwGXYQO66qVP4NTCcWwR6ctFogwE2whD2YQVwePh86fthks0CFunxr3sxVKMQHW1vtSkwZzOISx456lRpTVy35NlE3pMZL4ZjPRyTE/bLSdOZPBUuGMmiLrNVh/sqe2KiHt0/oEqdyd57wIN0h9gtLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779065169; c=relaxed/simple;
	bh=0cCayOs/NOcf7H1jtx6cZTrGpkWmBdUyYwrc0krfh7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TYbETAE1+iWA275+LDPFoMUsKmkruqBAYeoKeKX7DgXVeV4QCwmH0y3ygxcRJk8e8HkK/iYjWwkcRsVNfkpdeT03VaxDd524q+UI0rSdx+i/nhQ0vASUzHkwpSi6FQXwAsY5uDFiNFQUE6DZv4r27vPmPOMhWeksWmvDupQyDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JLaSUNvo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d42njdCD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JLaSUNvo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d42njdCD"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F212EC0081;
	Sun, 17 May 2026 20:46:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 17 May 2026 20:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779065167; x=1779151567; bh=Bz68VFlGz5
	lB0DE15lmTvkEZsCScSpTJNWk0Mq/Z2Os=; b=JLaSUNvoEaZsPnwxsltMnK4IMp
	WCraz2b9/ugDDNdvwrXlIsuH45m4RIfa2TiBHBRzfLzoc7pTF5tae0jrlOpS27pp
	T8YHBfJZKDmnEgtyh+Hq7YNYviUWlqXlT2VYjzDDc/45U4Fdu9IA8Z+DrgqNpQa8
	mMHjLc5CthKUxYIuIOUaAReBlcjKjr0kBCyP5kUGP/mFLC0SCyYQT8croalFrB+y
	SswxxOb0P2XArTqN9YxLKEA7fX7KFWwSulLb1ec5bD2zxtnNhOszAquS7nO4D8lp
	1qoUU4UsGLKkTGNiRhcW1ME0FnW9whMU7fpZgrzEuF80OMzo5TzW17EqQ3IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779065167; x=1779151567; bh=Bz68VFlGz5lB0DE15lmTvkEZsCScSpTJNWk
	0Mq/Z2Os=; b=d42njdCDhbdJCDhlY7cxPJFWYbZVpU+PnzFtL/MUt8rUUbJzfT2
	quj4y7kX+nvYUG5gtWZdkHLgt8HV32n85IlUTufpFTeGd45C98Vli3DtkVdzAKlY
	ccLzUeOvFqO4HSdKNkana5SgK2hBZ74Wgc4Zm/xr5qLsZbhvQsEw90z3zaR2QWYb
	Fq8gDsZEPWda6tA82Wp5MayYzwtMWxMzgr7sD8zloSxgwImREg2bEgm4AN/hm+ev
	TOWJIbSMp7cr6xPCt+1u+kUQGCkgassWkAvwOrbKqJXVTbOok3stpP/0MpdOLWnn
	uN3pTrQpgGyhAMgk6hBPLZOgr1CJr5fxoEQ==
X-ME-Sender: <xms:T2EKarKQpQJ_Rii46fKYWuxadLX5uB0x1wDrSk_dBZCwJtMNYcU3Jg>
    <xme:T2EKamBuw7vezoZ3Gt6CFE_xp_98fIjjq9aa20AbHsBFcCgsyMNhuKKWhJdhTAKM9
    duks81U_uWn23Zc2QqXfyFsZuYEandJbhc4CPsDnDag0ng4iLiv-Kc>
X-ME-Received: <xmr:T2EKasDR8irMxWkJYSjlc2xqu8ploS7NAe7o1riC3bPBKSF6bbXc7_cGW1ZaHdKDvBV3-IC81LcZxmi55VFJkni9DLFF5SN5cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhovghrghesthhhrghlhhgvihhmrdhiohdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:T2EKagD5dtRQwEZPKmeDRMkdDUHqJfxe3HwYSvHQQ6b3ilXXt6L_wQ>
    <xmx:T2EKavrBcxvwPZsobQQkcZPjrwHiN5GimIBT8ZN4sApzSdNvIc-VWA>
    <xmx:T2EKaimNBFOC9LycwQuwiYpGYRq2Sqqjf4WlyTFbWgy1FIJE6CvwDw>
    <xmx:T2EKanw4yHWw6C_lUjY_8Ju-tK4S8MakdlJrezNXeViil4weHaKGkw>
    <xmx:T2EKaimr52QVEJMJYXezJgwdFIfboaFs4qUDcgZxN3lilY6WJI2Q6Nnn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 20:46:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Joerg Thalheim <joerg@thalheim.io>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
In-Reply-To: <20260517132111.1014901-1-joerg@thalheim.io> (Joerg Thalheim's
	message of "Sun, 17 May 2026 15:21:11 +0200")
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
	<20260517132111.1014901-1-joerg@thalheim.io>
Date: Mon, 18 May 2026 09:46:05 +0900
Message-ID: <xmqqzf1xbl4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joerg Thalheim <joerg@thalheim.io> writes:

> +/*
> + * How long to retry acquiring config.lock when another process holds
> + * it. Default matches core.packedRefsTimeout; override via
> + * core.configLockTimeout.
> + */
> +static long config_lock_timeout_ms(struct repository *r)
> +{
> +	static int configured;
> +	static int timeout_ms = 1000;
> +
> +	if (!configured) {
> +		repo_config_get_int(r, "core.configlocktimeout", &timeout_ms);
> +		configured = 1;
> +	}
> +
> +	return timeout_ms;
> +}

The above design means whichever repository happens to be passed for
the first time as "r" to this call will fix the return value from
the function for the rest of the system, meaning that the lock timeout
is a per-process property and the repository parameter passed to the
function does not matter all that much.

It may make sense to admit that this is not a per-repository
property (due to the use of local caching), have the function take
no parameter and use the_repository to the config_get call.  That
would make the intention more clear.

Of course the other end of the spectrum is to get rid of the
"configured" caching here, and ask the config system to make a
hashtable look-up every time the function is called.  That will keep
the lock timeout per-repository, which is closer to what the current
function signature suggests.

I dunno.  My gut feeling is that there aren't valid reasons why you
would want to specifically set different timeout values per
repository, so the simplicity of using the_repository (i.e. the
primary repository instance this process deals with) sounds like a
better way to go.

Thanks.
