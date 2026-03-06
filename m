Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F833E34C
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833143; cv=none; b=bb9YQJj8AGTvWXPVbzrq75hIDfFSKketC6KXmRjcPIoxbe2YlmMg+kZ0zHaWGXLgfSIwb92aNSpYzqrF/RFhSymN06jEpXRMAq6yxpO9o6VO6zXco/Xf27UFgKl6UTT0iMj374jJERYA7fpqPKNk3p+DuXwC9h1hNyhhy0nh8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833143; c=relaxed/simple;
	bh=4rpRf+l11GiK4zJQf6AknIH404WtVjvMyo2pAb1KIvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLQpvsFCSGdxAPwBZonuvaqoKeOgi8iMxX3zfgC64lB2CvNYdyYIEYc6vRcXiQ/7Hb0Ptad2UlhDXy/IVf8Jztcbvb7Hbjt8/ekOI40tQniUxb5F+pZj/6Ur8a+qxCDazMhaXHzqo3bxANos5ugYvaLoZmRWA+h7iJaYu39yBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MN4/NhJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WA9zFQDg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MN4/NhJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WA9zFQDg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BCA99EC055F;
	Fri,  6 Mar 2026 16:38:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 06 Mar 2026 16:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772833138; x=1772919538; bh=Q0wRYm+ZX+
	W7Uf4DZl+WcDaktDBe7sZBYIsSftipXPQ=; b=MN4/NhJwOfCLkiEICd7goU7aUB
	34RUFvwZ0uO5JDBUfuS5T/Jl92v68cOwJjBNccTo3mbFNamUJGYEnHXh3pUEnNsx
	G1Bi9EBd5KQKIcbtNUzkTGfYWWIQSOIp9jDTVDIbPUF6nTEqMIijpzw5LHlXpkom
	JYaEUUk6/WVliDIR6Eic8vR1M1GW/ouZ1MPX2bzDSp1Npdo5GJF/EPvi4aZJX8m9
	Nllz9vpzxMG1IOIf6vZDH1D/lgM/WVyCCp0PpIk9GL1oxC9nj+TNNRs2GBbCxWn3
	oNfF+WWo60vhFeCMDMbhln4HyW/n+s95boLipQkd5FA7gdZXwa+FZXiidgOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772833138; x=1772919538; bh=Q0wRYm+ZX+W7Uf4DZl+WcDaktDBe7sZBYIs
	SftipXPQ=; b=WA9zFQDgnptyXrf68crJpuxOMRXex8+vu62BjnYysQR4E7uzfBA
	ocKtOI/Des9zmW3BsYxeGlYIbuNUXb1jUGJTh/V2/FaaBscvzO3iM50WNZLCy4yr
	/gm7z9LbV38zgkAH6JZusastmmxx5RxZMJNfOAoR0/XoNjAS1FvidSmsa375XWP6
	TyPaF5hAapPc/Jn0i2q/4lGH9SLJ5JkI/cZe19M8oYTmLr4E14ngAO26zJ3CBSFz
	jDORs+Krcr0zWCw9k5I6W3ij0nZYOO+QfjpV7O7CRq/iPFMstN/wEJauakhQHGCg
	kBgdXPbzamLgI+PBQ2tWlhfM5Quhp9/PNlA==
X-ME-Sender: <xms:ckmraWW0jrEOdS2e7v0Ig7nqHN2BAFdAY0xI9k1M-AUJOWKfF6_Z8g>
    <xme:ckmraZdzHs4fbHjL242GQEPAV52jN9UP5-zqoBLcdAwAGNfr1WKpGRC7BaCW2l0gD
    QoyJXG5ihCJ3dU_Uf_9nbf8itkoh0PrzK0HO2NsO9NX26VGVEUmSA>
X-ME-Received: <xmr:ckmraSt0F0PfDHSh2lbA42FVMYr9RtaC9fzz5LGRF92enCnEllAT74AtXjp0lA5veRAX8VlTH0sITdEyijp6RTUeiTjt2bxuSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohephihorghnnhdrvhgrlhgvrhhisegtvggrrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ckmraY9CoIonkipeH34pZCDrH-K26XcfPnsjzAzFREf1o9zKxOnQ9A>
    <xmx:ckmrad2N8pRSNd-n7dEj4LgkkfGTveMaU5Vbx219gKxVmWtojhV_Gg>
    <xmx:ckmradBOc8igGogJVeEccy34KkJuOFQF920epnGVbok57n61ZWz-rw>
    <xmx:ckmraZe24E93-YR32f0MWOFkbYno5l6X3b2YB7jlPTpxHww6yHQLyg>
    <xmx:ckmraaYsNOx7Pl0fXTsDPBTLRdXk2AjzHZPelPRZrgrzzabYC3ibnzCP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:38:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>
Subject: Re: [PATCH v3 3/3] branch: add '--no-name-prefix' option
In-Reply-To: <8f45374007fddfa4cc81e536ae6e095b0d67d5e6.1772802872.git.gitgitgadget@gmail.com>
	(VALERI Yoann via GitGitGadget's message of "Fri, 06 Mar 2026 13:14:32
	+0000")
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
	<8f45374007fddfa4cc81e536ae6e095b0d67d5e6.1772802872.git.gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 13:38:56 -0800
Message-ID: <xmqqzf4ky6xb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -		OPT_STRING(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create")),
> +		OPT_STRING_F(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create"), PARSE_OPT_NONEG),
> +		OPT_BOOL(0, "no-name-prefix", &no_name_prefix, N_("do not use any prefix for the branch to create")),

You do not want a separate "no-*" entry in the options[] table.
If we look at parse-options.c to see how OPTION_STRING is handled,
we find:

	case OPTION_STRING:
		if (unset)
			*(const char **)opt->value = NULL;
		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
			*(const char **)opt->value = (const char *)opt->defval;
		else
			return get_arg(p, opt, flags, (const char **)opt->value);
		return 0;

which tells us

 * "--no-name-prefix" is caught by "if (unset)" and causes the
   name_prefix variable set to NULL.

 * if we give OPT_OPTARG, we can allow "--name-prefix" (with no
   parameter) to default to opt->defval value; this feature is not
   very useful in our application.

 * Otherwise we get the string after "--name-prefix=".

So you do not need to do anything strange.  To correctly implement
the order of handling configuration and command line, you would do:

 * initialize name_prefix to NULL.  By default no name_prefix is
   used.

 * early in the cmd_branch() before you call parse_options(),
   consult the configuration and pick up branch.nameprefix
   and set it to name_prefix variable.

 * then you call parse_options().  If the command line has
   "--no-name-prefix", "if (unset)" kicks in and clears the
   name_prefix variable pointed at by the opt->value.  If the
   command line has "--name-prefix=blah", the name_prefix variable,
   which may have obtained a value from the configuration, is
   overwritten with "blah".  If the command line does not do
   anything, then the name_prefix variable will retain whatever
   value it got from the configuration.




