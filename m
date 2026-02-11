Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC53191A9
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846829; cv=none; b=gY952KEGFv05KmRuwAdt2Gvl+xyke0pCh0BgE2W+AkIsHvX8rdTJXxbRDBkj2mKqsZvrCf+SmfCkHQ9jRFx7Jbd00mE/Cedt33C2T5YyEcNxpBbrAZMyMiQq3KQgtGoh86EQfBV0RyDWQ3zC0fECBaLrXqo4WIM2fyW2MzcUkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846829; c=relaxed/simple;
	bh=hIbQjTlACIDnnH7TfrY5pLjHyFR3y89OLSuc95f9DLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cx22MyeMPJadq4hTy/NC4RZF/ZD58oMWd33a/ZHLJJ2ypstTmp8woBWR0jPpHU9OjuF1SoFK5l4b5Qam76NZLL2UYfwnD9objW//HQo1lVIANPFTWk0FNJY0cl0x5PpeK5Li/LhMZSc2/Yrac9Rt4BGATtZ81ODpK5KepgAErC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HkZ0p+aF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tb5uJcrN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HkZ0p+aF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tb5uJcrN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B35E1D000B7;
	Wed, 11 Feb 2026 16:53:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 11 Feb 2026 16:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770846827; x=1770933227; bh=fzpKMUwKHo
	qwSKweBoLD6ZtZsKt3khnBKySB5sVFTBY=; b=HkZ0p+aF3jZYQqgTAB2o4knoiy
	K5dIGQv6kA6/1f4odbewASG9ot/TWh1qU+X6dpKqLOsFN0NT6KhSlgUo9o+/DOyD
	/swPGlb0xv2wW7QEljCWz7ONrbs4CRTBoMyhumQJMM3AbkLl6n8ZZWkGuStFXLx8
	b10icfBptME0ULLDVHwGAmwtk36h3JHkYhaMQK3z0wVLJQ5y6LTDqxHEJ6RMiTdj
	Ealp4gXuxdi5eIGU6911b8koz7yh52caAZkNxlIWcg1qsRRRQIeMEqMQ0bxKsVUN
	9Avex1pH3YODhFSdeVMi0KxaCbVn2VjXga7zbaSr9lGU9MMi4AJK/Ihmg+4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770846827; x=1770933227; bh=fzpKMUwKHoqwSKweBoLD6ZtZsKt3khnBKyS
	B5sVFTBY=; b=tb5uJcrNMxOvyb/hUtK7EXR6fmvp4ERbRV41P/eqP0JCDeAfcV5
	Bjv6dbPiesiZv/wjeDSPylWv/k4HaEuZgWTLxJlhRa45+d7XgcOomwCDXz1FxqB0
	67AJgakcme+a+zIkgK/raF2539w5RjgygDM6i0OX5xp140FNlnh4kJGltYFHGkqk
	gl55zm1gDT9Qa4bLZ9vXN+rzY/abau8RH4XOh1j7gNImwEuB+7uLTbq9sge2Y7WH
	VjXVtfiWVo6JogUq3/b/mHsycyzkgfuvA/rve48ywQtYeQhITiw9O7K5OANdEFSm
	xfDBUVucPzAws08phNxndR7P9YKEfs+TzuQ==
X-ME-Sender: <xms:a_qMaYOlJrfr6UNYzixKlj7zBpv01c7iort6eUYxMXMZWYE2gvA7iw>
    <xme:a_qMaSpsXdpefPyzK9LmHF2MULBjAvUKoXeaprqhJFE4_HrWCw2E9xty_AjNX-JUy
    DDiHFJTeEEaLJbRf3lUB0Ukp1L2FYYNZVaOD3Ls6Kz0NJy6q0tqXw>
X-ME-Received: <xmr:a_qMaZEkcFStn4fysPEhNlCL3hpk5PlWUB0pHSDE0YEYV5IrhLypRhRM7EkX2MquX2ALm7vPpuV2K0xvfpzMJkP_895Vcbck5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:a_qMaXpHMwxb4FRhuujjbj-3bbZwCFhT-Rt15IzSF_4zL47OMRd1rA>
    <xmx:a_qMaSba-loUe958PqCnF5AQ2DpAkkXhC7TJu_GDMeCDI9thWA8NMQ>
    <xmx:a_qMaQUlBbtJKiJV26KN6jyQUvgGfin1n46wHe8j889pGiph80spmg>
    <xmx:a_qMab-3F8XdAk3hTP6GPkRUmxeTTkYdXMPC0nEBFlB2n_DB2217GQ>
    <xmx:a_qMaZKOfZZZjndJ-QXJu0QfVOB_9XCALm-z_gjAD2zHztNFddAR5UrD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 16:53:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/3] alias: prepare for subsection aliases
In-Reply-To: <20260211211810.278806-3-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Wed, 11 Feb 2026 22:18:09 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260211211810.278806-1-jonatan@jontes.page>
	<20260211211810.278806-3-jonatan@jontes.page>
Date: Wed, 11 Feb 2026 13:53:45 -0800
Message-ID: <xmqq5x83rlp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> Switch git_unknown_cmd_config() from skip_prefix() to
> parse_config_key() for alias parsing. This properly handles the
> three-level config key structure and prepares for the new
> alias.*.command subsection syntax in the next commit.
>
> This is a compatibility break: the alias configuration parser used
> to be overly permissive and accepted "alias.<subsection>.<key>" as
> defining an alias "<subsection>.<key>". With this change,
> alias.<subsection>.<key> entries are silently ignored (unless <key>
> is "command", which will be given meaning in the next commit).
>
> This behavior was arguably a bug, since config subsections were never
> intended to work this way for aliases, and aliases with dots in their
> names have never been documented or intentionally supported.
>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  help.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Very well explained.

>
> diff --git a/help.c b/help.c
> index 0bdb7ca10f..eccd0c22f8 100644
> --- a/help.c
> +++ b/help.c
> @@ -573,7 +573,8 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  				  void *cb)
>  {
>  	struct help_unknown_cmd_config *cfg = cb;
> -	const char *p;
> +	const char *subsection, *key;
> +	size_t subsection_len;
>  
>  	if (!strcmp(var, "help.autocorrect")) {
>  		int v = parse_autocorrect(value);
> @@ -588,8 +589,11 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  	}
>  
>  	/* Also use aliases for command lookup */
> -	if (skip_prefix(var, "alias.", &p))
> -		add_cmdname(&cfg->aliases, p, strlen(p));
> +	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
> +			      &key)) {
> +		if (!subsection)
> +			add_cmdname(&cfg->aliases, key, strlen(key));
> +	}
>  
>  	return 0;
>  }
