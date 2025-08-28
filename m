Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13713002BC
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422503; cv=none; b=O3xlBxhVOC9K9+gXVIIpWNWXe9uFBRMwYRjljnPMGeR8MQbKZ5AZyjKBE2ffaRSjYEpW8fiQoNwoRNoH3DUYBr/VBvn30GGqFffmwFc4nmnGyqcC0tQ8JvpjoRigYfqxxv9cg71r5Wvf1NOz8XBUL2WU3c+5PwS7/6HyuDgzLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422503; c=relaxed/simple;
	bh=84V+rkXAoQAKSoPzX9UQRm0vrztOHevskb+j/GwWiuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cK8RrYV7Pe91lRy/FkZF99eT2mLjy7I9Dtt0ZQcmhvpofbYSnJ11IhLr2KEPhD3ZYnoFBpSsrksngYoPGDxzEGOy47Qs8MC4cqBUYTmSLrhbFgcy2/OAGEEX7BgBPht/WeFTd1QrnjEy41v/WyEfFeEfSkn7jycy2G4hmisR4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aLCMvhu0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C5yCuq4r; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aLCMvhu0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5yCuq4r"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B7227A01B0;
	Thu, 28 Aug 2025 19:08:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 28 Aug 2025 19:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756422499; x=1756508899; bh=iSegT11gwR
	Qq8fqSw0G35qJTdHk/D2Hv9QfZdf1AFqo=; b=aLCMvhu0XMkk7ZUOl5bHJ86SlI
	Nn2qPXo0iaS2qCaqVWLglTIwZK7OA3/L2RF6iAlADxFe7yUpIDEJ+oT7JDGCVCNf
	7J4k3ncN7SSM4O03DHHNgZI1XQDAWNIQK3FSKzwtECTuGJYlaEujLnnXqJC6EEu3
	DSz6hRdFOoL1NMLTYST71qnVTADFUwDmIdqVwyE6m83tKYrBjHY/6hkM3mA220jX
	vJhAxrcsZ7oX9IFw530220ZdogrOfbrS7J27kLkfQ8QRAYgajTGE5ZxUuTMz/XQX
	Y1kzS3vwFG7RNaSWT6ozK+yw93iQ8wxkHe3DSdK4Yo+u688wJyNkwy2Xu+wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756422499; x=1756508899; bh=iSegT11gwRQq8fqSw0G35qJTdHk/D2Hv9Qf
	Zdf1AFqo=; b=C5yCuq4rDAyLuBcm/X8SmQlaZdqQZ7uHJWyfna+WovgXG4Oy/51
	j5ZgjtVzcBKblbTzXAmZn4pfiLWSm8HNFqdmrabDghEmr8F3FoM+teHpVhMjLZNq
	796EMrbOdjtnx3ID2YK7JU2BBHh8d6osdO181d5Y+3XOwkzyS6ToGe/KwHddjLK/
	GSAofTLtfQHr8UF09CeQR4KO1ee6h8Pol6zi9pEIKNpC73ASjy9MHQ6eo04Ww2EV
	Bf+IKtar56xjia3F3M4QZ+vZmq/Kuz4+rduNN+qp8fgAnnxql2csY8oyCwEdJSE1
	orHoh2292OMFcPWn/0KUjMMrpDVUa/QtLtw==
X-ME-Sender: <xms:Y-GwaCu3OKIEeBPcLjN3oZMdIDY94qoZkNcpiID-BehPOi1Bsl1waw>
    <xme:Y-GwaC8ybc-N_7JhydeKZNcA68NGHtWadIm94Rkdkk18IZiKY7Y1XmoFFi539qrn6
    zkLWZxZwk26GHMUbA>
X-ME-Received: <xmr:Y-GwaEPCifclwbkDNkWKzFTTTVZzwqL2EOcnev-Z5011DywXnLYwDUdceDRqwfxwmR8m8BmoU2MKDklkS-7AGrJyL0P0f04ijpioLvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Y-GwaIGlCY_0U7QJd2q1uEBW3xlf5r8Y_G0Uvezoxtnjl1WL8Yi93g>
    <xmx:Y-GwaKS3tQaU0SCSR7c7awjN5hNjem8V0phhUDUeQ84ILp9VqEvXLA>
    <xmx:Y-GwaNvQxffd9LliAQCgyEB-KCnyZIgkrOsHGCMYXw2l70ihAg23yQ>
    <xmx:Y-GwaKLwM6QCrgHvGN-uF28RaP4AM1RL-K6iPC9ErvcqHZjifdKsfw>
    <xmx:Y-GwaDdyrJQrnn1k2y7-V5qXTTcbqo5UP63bP0b9v_408UwPu3a4AvmE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:08:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH v2 1/2] repo: add the flag -z as an alias for
 --format=nul
In-Reply-To: <20250826183205.19566-2-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 26 Aug 2025 15:32:04 -0300")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250826183205.19566-1-lucasseikioshiro@gmail.com>
	<20250826183205.19566-2-lucasseikioshiro@gmail.com>
Date: Thu, 28 Aug 2025 16:08:17 -0700
Message-ID: <xmqqcy8frqn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Other Git commands that have nul-terminated output (e.g. git-config,
> git-status, git-ls-files) have a flag `-z` for using the null character
> as the record separator.

Putting the devil's advocate hat on, "--format=<plain,nul>" was an
attempt to avoid needless proliferation of options (e.g. presense of
"-z" would tempt people into add "--json" when they introduce
"--format=json"), so it may not be unconditionally a good idea to
mimic these older commands where there are only two output formats.

But assuming that the short-and-sweet "-z" is something we want to
add, the patch itself looks pretty well done, but not quite.

> Add the `-z` flag to git-repo-info as an alias for `--format=nul`,
> making it consistent with the behavior of the other commands.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 8c6e7f42ab..5df33de42e 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -115,20 +115,27 @@ static int print_fields(int argc, const char **argv,
>  static int repo_info(int argc, const char **argv, const char *prefix,
>  		     struct repository *repo)
>  {
> -	const char *format_str = "keyvalue";
> +	const char *format_str = NULL;
>  	enum output_format format;
> +	int format_nul = 0;
>  	struct option options[] = {
>  		OPT_STRING(0, "format", &format_str, N_("format"),
>  			   N_("output format")),
> +		OPT_BOOL('z', NULL, &format_nul, N_("alias for --format=nul")),
>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
>  
> -	if (!strcmp(format_str, "keyvalue"))
> -		format = FORMAT_KEYVALUE;
> -	else if (!strcmp(format_str, "nul"))


> +	die_for_incompatible_opt2(!!format_nul, "-z",
> +				  !!format_str, "--format");

Hmph, so "git repo info --format=nul -z" is now forbidden?  That
does not make much sense to me.

> +	format_str = format_str ? format_str : "keyvalue";

	if (!format_str)
		format_str = "keyvalue";

is probably easier to follow, but I suspect this becomes a bit of
moot point as the general structure of this command line parsing may
have to change when you fix the "-z is --format=nul so why are they
incompatible?" problem.

> +	if (format_nul || !strcmp(format_str, "nul"))
>  		format = FORMAT_NUL_TERMINATED;
> +	else if (!strcmp(format_str, "keyvalue"))
> +		format = FORMAT_KEYVALUE;
>  	else
>  		die(_("invalid format '%s'"), format_str);

You'd probably need to define a parseopt callback function for
"format" and "-z", and remember the one that you saw the last.  So
giving "-z --format=nul --format=text" would first set an internal
"format" to FORMAT_NUL_TERMINATED (due to "-z"), and then to the
same FORMAT_NUL_TERMINATED again (due to "--format=nul"), and then
finally to FORMAT_TEXT (due to "--format=text"), or something like
that, which would give the familiar "the last one wins" semantics.

Something like (not even compile tested):

	static int parse_format_cb(const struct option *opt,
        			   const char *arg, int unset)
	{
		enum otuput_format *format = opt->value;

                if (opt->short_name == 'z')
                	*format = FORMAT_NUL_TERMINATED;
		else if (!strcmp(arg, "nul"))
                	*format = FORMAT_NUL_TERMINATED;
		else if (!strcmp(arg, "keyvalue"))
                	*format = FORMAT_KEYVALUE;
		else
			die(_("invalid format '--format=%s'", arg));
		return 0;
	}

with

	enum output_format format = FORMAT_KEYVALUE;
	struct option opt[] = {
		OPT_CALLBACK_F(0, "format", &format, N_("format"),
			       N_("output format"),
			       PARSE_OPT_NONEG, parse_format_cb),
		OPT_CALLBACK_F('z', NULL, &format, NULL,
			       N_("synonym for --format=nul"),
			       PARSE_OPT_NONEG|PARSE_OPT_NOARG,
			        parse_format_cb),
	};

perhaps?
