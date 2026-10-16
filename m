Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE7242D67
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187265; cv=none; b=uBQrgIR6p552x7GV9EXWIzdx7jEvf8GJ9gdJIJ4lPL2SaHRBBEB9BuXKBDA+BCfBX+qxrbMVseSQEXOZV5XGxevb2/UiMVXEGFTc2w6XD0fH0B2DtoXULzw4JnrBS/Tk8hGhj1IAKdmZy9AVHak6okyd40hGWFTp3n75nj6fEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187265; c=relaxed/simple;
	bh=TbdUOvnIyHqW8pIb6Nx542pPCFQBYSAT1E+rPlngTVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUyn3AzdWnOkItALVrt0iskqbjAoKk+JqJ7NA+5vMTd+MPEhuL3hRH+JGldVjG+/1Bq/y9mKBJpZARrnOuBmzxzbsnh5+GsYi+l+gxg69knks78qFoZG49+lTHWn0t9XFqRPWmGr3JHkDJEoSk0pwG/hZRREwyc4WucM8ywscbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o9FO7KPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dDY+0bvd; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o9FO7KPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dDY+0bvd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BDA2140010D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:47:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 16 Oct 2026 17:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792187262; x=1792273662; bh=fvwtIo1uk6
	LZK2PtG5W2It5Kkf4UNlhaRcBZdiIxWHI=; b=o9FO7KPoyxkLk+2dmFHk+MCRn5
	yEguGcg4XVEGXa6qSFvPzq4YKY54DRATEogO5TF6axu/j6tCP1eUh+XZKGJUvpNm
	p9rXg+fStl8LCkKpZh9sOMt0Y+xPIlbbnhRkIhlyLKatix0QowZ0XN6qwBRM07ap
	qYtp5XLqC34KMFO1/vKVztzBipQUqMvupbGCzC1OKWnrCtKPOVan0Xk774DlnoHt
	yQd5NrqBCYyLjBy8NjpylHkwk3mQpnTnR41hyyP4/hhE0JTaFvRWOVUJs8RuVeZx
	+ceWAYZ8+QOlpJVdnsT6qtCxd1iQOFRGJ8A2zV9GoGsKE9n7ZFjmYrW1hw9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792187262; x=1792273662; bh=fvwtIo1uk6LZK2PtG5W2It5Kkf4UNlhaRcB
	ZdiIxWHI=; b=dDY+0bvdhsAauJ9GvLcRRrS244JdPEienI4YmoZP6nCjwXOR45Y
	+iFORgTWKakcP2TSOhXtRfW7REdFGYYs25FBx+KBNSVI/iJofzvEEooAGPzANzaA
	RA5y4N0zFUHwSNnwV9kEHjx0JIjVXVTYS3YO5jX6D837gFcLWsNaEyuUAN7xTb4g
	lPOakXnTMz9FCiPSOyA71Ye/Tr2vCwUjoOTbo3FHeN6lcT7vypzZAWtqj4bJ5RNr
	cLscmRDk5NolYdsyeJMIa+z/UKlHRQtzwF1uvMwq64RIL/2c4GpnkSCVHBamUsXi
	PKyxQHdJunKJBSxPiTmAtp1LHmM+5MUdTBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792187262; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aOvmqT9V/EzsRDQt6t2r2I3h83kPgzIZs0ABswvwifQayF0
	6NzR/TtNfyXtAYWGyMypmZDecEAT1xTLa+ZviMRHlFnFPeoePl73O5y4o/9jOVkl
	HIKslK+7xxDe6FeAbwH3OhooIRq4rBhYaZ7C3XSHp/u/zqLnFX2SqW1zjDYBj63q
	EH/ad7iFKPEn9a5ySvD/nKrW3nBtn0vwPNO9SRNtJKQBF7EHD0CLczky/vM1aql4
	sMqTNazZzjfyBJ3poITpuTKZpCMOpp52IVDjdTEOF9aKmK5FKFy9JMsBBzV9BrLL
	buXJTkfI5tL0DZ+vHPpW4z+smYlnm0/aMyXyndg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+Ge6dB3lMzGHr0HDvk4/rRhqosp4BcRKFk8XQc7ynjo=:TbdUOvnIyHqW8pIb6Nx542pPCFQBYSAT1E+rPlngTVo=;
X-ME-Sender: <xms:fpvSan76O8V7Tr8yXYw4pA6daTmq1OzKq0P7GMq_SvakQqnAiKavGg>
    <xme:fpvSajzC6ygydLYSgYx6-Q6L2YbRi5PVRvdzskrwdo_44XhGwEP0tuhKC2mjQ45mH
    Cu3JnQYkFleAiHzFyqICsnsA97LsLvewCloSloD2b5AwOKDsmmJRA>
X-ME-Received: <xmr:fpvSamwuRvdlzMAIiN0vGk11qhZxmFjinMc1WcRARxw9h3lm10K9-cqVh_wW-y3P06eKLycvjNOu4B-yNSkzGs6x1lJJYKVd_lEo>
X-ME-Proxy-Cause: dmFkZTEk0ZTLzdrBxua++GYI9SsToEopZPyRMacC8dQSwIXy551p6563G3xnBZBtBedF6z
    dipt7Hju1x6TZDdDCx/Wi4F1l9HusvcvHMMaw0IKxTp2Nl2xRgxrVBZcWWteHI4QTcy8K1
    oVtKlTSV80pzuV2fb7ahC4ukc0YsAf6WFrePI6zH9nZ7NV6VqSLq9FCsKZvRxBfWtE3EvD
    sTTg1jzPjQsxgoUufbPBSegz3WDrq6IH5vBT8Ze4Fo+2zJD7cEyqi4lj6JVFVysQ1blJSw
    bdpTGmSRsbRfyylDlsensQ9M20555yo2Cv8pg4avz6s2xWq5f6Jj1SSyG+kl2U+5H5uxFl
    qKDGy+LYvocGYctoZSEZ+wWs3AQHHESu6nD778MlOThdDsZqjw4TOVCjYkqFypGSaPs6rc
    sPbNrZgwViB2J2aWGJuaeXULMMJvGe0hrnwua6V63HemLx63fkiTz1q1mQdYT7/qHxxMn9
    w1YwA0yoxnm1iUid8vJ6DHxpgWTGZdyBk89ybjaI/LOZCrqEMRogYFvBbg3IX/owDe9NAm
    u+Fp6d0ZLtNcCxohdTziPxUROFoT6FduX+cIxkKDOrix5qtJ7o/Elu6Wh0etUo/Q3byS67
    JFV2CgcZGmFkfp3cBYnwH77yrUwX9AhHiyqSXvJJ+G/nsO62BmYybKSsfzQg
X-ME-Proxy: <xmx:fpvSajz2x08nL_qviGrrJgSL6zwrtR8lRZ_c_RoSWdUF1t2KKbdsYg>
    <xmx:fpvSaoZ8w9t3FBOI0NTTqgr_5SJ1FYfWe5_lp0kz5jhAFIdsVoJYmA>
    <xmx:fpvSasXCoDc6j7arfQvA901_N2s0Imz3_FSXAbGpC6dlLDxl3k49WA>
    <xmx:fpvSaugzRdiOL4Egidok6KqPma2yN08_awl1O4EUdstn6n7gPVyhQA>
    <xmx:fpvSanD7ZcQVB7V5npauiG0tOZIrCOh5tQjTxizZEx-dAcU9uy7Ioz6s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 17:47:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kerylefondji7@gmail.com
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [Outreachy PATCH] var: refactor to use parse-options API
In-Reply-To: <20261016205659.4417-1-kerylefondji7@gmail.com>
	(kerylefondji7@gmail.com's message of "Fri, 16 Oct 2026 21:56:59
	+0100")
References: <20261016205659.4417-1-kerylefondji7@gmail.com>
Date: Fri, 16 Oct 2026 14:47:40 -0700
Message-ID: <xmqq1p9pe2rn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kerylefondji7@gmail.com writes:

> From: kerylefondji <kerylefondji7@gmail.com>
>
> Refactor 'git var' command handling to use an existing API (parse-options API)
> instead of ad hoc code for argument parsing.
>
> Previously, the ad hoc code lacked proper validation for option
> combinations. Specifically, listing all variables (-l) and requesting a
> specific variable name are mutually exclusive operations, but the code
> did not enforce this restriction, causing test failures.

Everything below this line up to the three-dash line should be moved
below the three-dash line, and replaced with your sign-off, I think

> This change:
> - Includes the parse-options.h header and defines builtin_var_options.
> - Adds an explicit check to ensure that combining '-l' with additional
>   positional arguments correctly triggers a usage error.
>
> All 27 automated tests in t0007-git-var.sh pass successfully.
> ---
>  builtin/var.c | 50 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/var.c b/builtin/var.c
> index cc3a43cde2..20ea4e0489 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -18,8 +18,11 @@
>  #include "path.h"
>  #include "strbuf.h"
>  #include "run-command.h"
> -
> -static const char var_usage[] = "git var (-l | <variable>)";
> +#include "parse-options.h"
> +static const char * const var_usage[] = {
> +	N_("git var (-l | <variable>)"),
> +	NULL
> +};
>  
>  static char *committer(int ident_flag)
>  {
> @@ -220,22 +223,39 @@ int cmd_var(int argc,
>  	    struct repository *repo UNUSED)
>  {
>  	const struct git_var *git_var;
> -	char *val;
> +        char *val;
> +        int list = 0; /* Flag to track if -l/--list option is used */

Useless comment that is too obvious from a properly named variable
with its use in a "struct option" array.

Either the patch is heavily whitespace damaged, or you indented
incorrectly with spaces, or perhaps little bit of both?

> -	show_usage_if_asked(argc, argv, var_usage);
> -	if (argc != 2)
> -		usage(var_usage);
> +        /* Define the accepted command-line options */
> +        struct option builtin_var_options[] = {
> +                OPT_BOOL('l', "list", &list, N_("list builtin variables")),
> +                OPT_END()
> +        };

We did not take "git var --list", now we do and in addition we
probably take "git var --lis".  That is notable enough change.

> -	if (strcmp(argv[1], "-l") == 0) {
> -		repo_config(the_repository, show_config, NULL);
> -		list_vars();
> -		return 0;
> -	}
> -	repo_config(the_repository, git_default_config, NULL);
> +        /* Parse options using the standard API */
> +        argc = parse_options(argc, argv, prefix, builtin_var_options,
> +                             var_usage, 0);
> +
> +        /* If the user requested to list all variables (-l) */
> +       
> +if (list) {
> +    if (argc > 0)
> +        usage(var_usage[0]);
> +    repo_config(the_repository, show_config, NULL);
> +    list_vars();
> +    return 0;
> +}

Again, the indentation, or lack thereof in this case, is
problematic.

> +        /* Ensure only one positional argument (the variable name) remains */
> +        if (argc != 1)
> +                usage(var_usage[0]);
> +
> +        repo_config(the_repository, git_default_config, NULL);
>  
> -	git_var = get_git_var(argv[1]);
> -	if (!git_var)
> -		usage(var_usage);
> +        /* Retrieve the specific git variable (note: now at argv[0] after parsing) */
> +        git_var = get_git_var(argv[0]);
> +        if (!git_var)
> +                usage(var_usage[0]);
>  
>  	val = git_var->read(IDENT_STRICT);
>  	if (!val)
