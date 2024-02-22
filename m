Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3D3F9E1
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619668; cv=none; b=tKMsV7dJFOFwpWchQS3MksPm1/W4DTM9+NiKoIq46fM6kMPsDAdTInyzs05U4xbtOxkJHJnNYrdx4JaVWbDR7H1THvB+EsrpFQrvR+kNICftLDYgGDVfFnADjZZ1jLRyg58WoXg1HtxoW99ccPFGCq3jsYd3Mjx7wpr9dKJ/MT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619668; c=relaxed/simple;
	bh=Ef9MxOFhorpPJX63NulKbYZHaM3vFYw+Sc7sQceSOY4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=suonWzbrFQ39csaKn5A+go9LP4SGcsyq8mNvC2agDMhoai6C+qDq84k3ku0pYDG71xrUwHxsYKcJui7qgPT8sFLd316q/yE8yXgr1nXkmChXP3jHhTqOz9uO2P2RGanvkCaB2vTUsUHMrCofR3A2QoJStWkXZ1rVyxRayMLRJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFGQl28Q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFGQl28Q"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41273f53c71so15926875e9.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619664; x=1709224464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gt6ziBBcCbgV6iWfojHW4gbhiC0XOC1cApsoEgq7ehk=;
        b=ZFGQl28QzD3fCbPaWlR7iGzKRElIFJjnYu/MTQXrhiUwhjFgwiOUcjVH2l6y/ydkc7
         3dUxm7wKo4XMY6Aahz2cPyAMibB7TOyQBT44qQMRagxcXLnK4bRzrnGX96b+em8spL9W
         3cU1BLv32Orky/Yy4gyKtCwLzeK98m/lfYVklCSqjTOjxgzLnu3Q7g+HeUfq6UBMoydu
         WJBf8IlYquJaTPeDumrt1JtAUdyz4xDUAZUmn2Xh5yBdMZKEROpm4gF9sOgRuWuh2hwe
         D/U426OErZnxIWgKbNQSXWA1FbgNjfHZFT7sAvvDLzQlgbgiXK/K3DGhdRZ+2eISoOks
         v4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619664; x=1709224464;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt6ziBBcCbgV6iWfojHW4gbhiC0XOC1cApsoEgq7ehk=;
        b=ZMLBCkyhfPC6qRt2PwOQzZl7WR1jEuqcdhDQqGn+HCe798J8eesqCv5kTq6l3Ax+TP
         VwXoUe/wb1bOXwpidkplO4XDhCq1u+LKqLRucAM5h8hQUqQ5JNcz/FFcpkanS0zJjino
         TbHdtcjeudZOjXEpmXMW4XCQalGkKYBdMCref8nFdSAf/Milc7fkKPsuczFe09FAWCvi
         jKDlPCW950QEco1y1Dj+BtJrUp6q2n0MPfmVGscYjuK0l3sRHX3+gWt5xc9kGEUFCgBP
         zlYWJ/aq47gR9CuUJ3cSB/PCdXbXbaOPuIIUnEV1nQj68MCQUncsG5g0uE+hRmhTPg6f
         iBXw==
X-Forwarded-Encrypted: i=1; AJvYcCUnCK27vAt05ZHZyhNweZLwJcsCzh/0Bv7pVKHxUfvqifPCnxVk+afEJlxElHanvHq1K2CmtH253kKyuMbPZVl/Ga/Y
X-Gm-Message-State: AOJu0YzNM4MoJD19m8xQAk53Czs1mADg5SabQNMtT4U0xS7FSrkqWgv1
	qGw3mvY8teRI3hbuJum1YkDTXFqfzIf+u7lTYCuVqhatx6QMAP4D
X-Google-Smtp-Source: AGHT+IH9tyGBrQM9IzHOYCVdoUWnydI4uUOUuduhi3M0WGf19ERyqF/6eXdHk75CaueptvMTFEqzFw==
X-Received: by 2002:a05:600c:3ba6:b0:411:d89d:d7ba with SMTP id n38-20020a05600c3ba600b00411d89dd7bamr19718427wms.7.1708619663951;
        Thu, 22 Feb 2024 08:34:23 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm21901857wmb.42.2024.02.22.08.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:34:23 -0800 (PST)
Message-ID: <9f16544e-b6cc-414f-81e5-aac9e076f8df@gmail.com>
Date: Thu, 22 Feb 2024 16:34:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/8] rebase: update `--empty=ask` to `--empty=drop`
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-4-brianmlyles@gmail.com>
Content-Language: en-US
In-Reply-To: <20240210074859.552497-4-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/02/2024 07:43, Brian Lyles wrote:
> When git-am(1) got its own `--empty` option in 7c096b8d61 (am: support
> --empty=<option> to handle empty patches, 2021-12-09), `stop` was used
> instead of `ask`. `stop` is a more accurate term for describing what
> really happens, and consistency is good.
> 
> Update git-rebase(1) to also use `stop`, while keeping `ask` as a
> deprecated synonym. Update the tests to primarily use `stop`, but also
> ensure that `ask` is still allowed.
> 
> In a future commit, we'll be adding a new `--empty` option for
> git-cherry-pick(1) as well, making the consistency even more relevant.

I'm sightly nervous of deprecating "ask" as the warnings have the 
potential to annoy users but it would be good to use consistent 
terminology so it may well be worth it. This patch the previous ones 
look good apart from one minor issue ...

> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> Reported-by: Elijah Newren <newren@gmail.com>

I think we normally put Reported-by: and Helped-by: etc above the patch 
authors Signed-off-by: trailer.

Best Wishes

Phillip

> ---
>   Documentation/git-rebase.txt | 15 ++++++++-------
>   builtin/rebase.c             | 16 ++++++++++------
>   t/t3424-rebase-empty.sh      | 21 ++++++++++++++++-----
>   3 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 68cdebd2aa..6f64084a95 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -289,23 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> ---empty=(ask|drop|keep)::
> +--empty=(drop|keep|stop)::
>   	How to handle commits that are not empty to start and are not
>   	clean cherry-picks of any upstream commit, but which become
>   	empty after rebasing (because they contain a subset of already
>   	upstream changes):
>   +
>   --
> -`ask`;;
> -	The rebase will halt when the commit is applied, allowing you to
> -	choose whether to drop it, edit files more, or just commit the empty
> -	changes. This option is implied when `-i`/`--interactive` is
> -	specified.
>   `drop`;;
>   	The commit will be dropped. This is the default behavior.
>   `keep`;;
>   	The commit will be kept. This option is implied when `--exec` is
>   	specified unless `-i`/`--interactive` is also specified.
> +`stop`;;
> +`ask`;;
> +	The rebase will halt when the commit is applied, allowing you to
> +	choose whether to drop it, edit files more, or just commit the empty
> +	changes. This option is implied when `-i`/`--interactive` is
> +	specified. `ask` is a deprecated synonym of `stop`.
>   --
>   +
>   Note that commits which start empty are kept (unless `--no-keep-empty`
> @@ -705,7 +706,7 @@ be dropped automatically with `--no-keep-empty`).
>   Similar to the apply backend, by default the merge backend drops
>   commits that become empty unless `-i`/`--interactive` is specified (in
>   which case it stops and asks the user what to do).  The merge backend
> -also has an `--empty=(ask|drop|keep)` option for changing the behavior
> +also has an `--empty=(drop|keep|stop)` option for changing the behavior
>   of handling commits that become empty.
>   
>   Directory rename detection
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 4084a6abb8..3b9bb2fa06 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -58,7 +58,7 @@ enum empty_type {
>   	EMPTY_UNSPECIFIED = -1,
>   	EMPTY_DROP,
>   	EMPTY_KEEP,
> -	EMPTY_ASK
> +	EMPTY_STOP
>   };
>   
>   enum action {
> @@ -954,10 +954,14 @@ static enum empty_type parse_empty_value(const char *value)
>   		return EMPTY_DROP;
>   	else if (!strcasecmp(value, "keep"))
>   		return EMPTY_KEEP;
> -	else if (!strcasecmp(value, "ask"))
> -		return EMPTY_ASK;
> +	else if (!strcasecmp(value, "stop"))
> +		return EMPTY_STOP;
> +	else if (!strcasecmp(value, "ask")) {
> +		warning(_("--empty=ask is deprecated; use '--empty=stop' instead."));
> +		return EMPTY_STOP;
> +	}
>   
> -	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
> +	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"stop\"."), value);
>   }
>   
>   static int parse_opt_keep_empty(const struct option *opt, const char *arg,
> @@ -1136,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				 "instead of ignoring them"),
>   			      1, PARSE_OPT_HIDDEN),
>   		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> -		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|ask)",
> +		OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|stop)",
>   			       N_("how to handle commits that become empty"),
>   			       PARSE_OPT_NONEG, parse_opt_empty),
>   		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
> @@ -1553,7 +1557,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   
>   	if (options.empty == EMPTY_UNSPECIFIED) {
>   		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
> -			options.empty = EMPTY_ASK;
> +			options.empty = EMPTY_STOP;
>   		else if (options.exec.nr > 0)
>   			options.empty = EMPTY_KEEP;
>   		else
> diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
> index 73ff35ced2..1ee6b00fd5 100755
> --- a/t/t3424-rebase-empty.sh
> +++ b/t/t3424-rebase-empty.sh
> @@ -72,6 +72,17 @@ test_expect_success 'rebase --merge --empty=keep' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'rebase --merge --empty=stop' '
> +	git checkout -B testing localmods &&
> +	test_must_fail git rebase --merge --empty=stop upstream &&
> +
> +	git rebase --skip &&
> +
> +	test_write_lines D C B A >expect &&
> +	git log --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'rebase --merge --empty=ask' '
>   	git checkout -B testing localmods &&
>   	test_must_fail git rebase --merge --empty=ask upstream &&
> @@ -101,9 +112,9 @@ test_expect_success 'rebase --interactive --empty=keep' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'rebase --interactive --empty=ask' '
> +test_expect_success 'rebase --interactive --empty=stop' '
>   	git checkout -B testing localmods &&
> -	test_must_fail git rebase --interactive --empty=ask upstream &&
> +	test_must_fail git rebase --interactive --empty=stop upstream &&
>   
>   	git rebase --skip &&
>   
> @@ -112,7 +123,7 @@ test_expect_success 'rebase --interactive --empty=ask' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'rebase --interactive uses default of --empty=ask' '
> +test_expect_success 'rebase --interactive uses default of --empty=stop' '
>   	git checkout -B testing localmods &&
>   	test_must_fail git rebase --interactive upstream &&
>   
> @@ -194,9 +205,9 @@ test_expect_success 'rebase --exec uses default of --empty=keep' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'rebase --exec --empty=ask' '
> +test_expect_success 'rebase --exec --empty=stop' '
>   	git checkout -B testing localmods &&
> -	test_must_fail git rebase --exec "true" --empty=ask upstream &&
> +	test_must_fail git rebase --exec "true" --empty=stop upstream &&
>   
>   	git rebase --skip &&
>   
