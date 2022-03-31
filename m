Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E4C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 15:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiCaPlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiCaPjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 11:39:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F04AD3AC7
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:33:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h4so20822141edr.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=W8vTUH3gCm+bTmKZiR5UZNkcAqpKqgwExYsEwpp8TRE=;
        b=OBB1RG+JFu81bwLJl6DdMo5U23efIW9zvtJ09TEELvxrWC1+vFsH3tU7Rf5huUl3LX
         M4mwGH/fL6WJ1mdWhg6fU9iUsM1wYmDUZZ7n5Tdy6CHJzCaWx0k8JUHV6LJPkjGVV2yV
         cwUONVOzd/z10I4KqQjugWqfFTu7p5duExXE7eDqvLCOOcageXdtQj65OFyCAC/4K7Sz
         XBLaDSHOauUFpo7DyfyRwZBGpTT1PzeUvZGPWMgK+zqWRoNYggK2h6cIfTt3AEIYrMNU
         L6vCmJjWhwCX5zGaqPV6xn8wKc7YpV2aZS70tXMjl75SUCu0OjLNNEWXuElfHxnNF9lk
         sqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=W8vTUH3gCm+bTmKZiR5UZNkcAqpKqgwExYsEwpp8TRE=;
        b=fGOe/cJXen5+T4otg1/v5Z6SlYhHvfbNNV3Met2QUuG3x6TDhD+hfwoAFFnInpflO5
         Tjk18A2+GwCtzJfKlIgHg5uXXRvrnpONmxzzeBKM9Y95ypf3g95gD4eoyXQqqnOJfgV/
         PPGGiRlgONRmogqqnVnTl+EBxxtKsazr3RmtP7Syjb2gJVuNEYcvvPVFdKtruUxDKvgw
         zzmjC3jXTBE95TSEQGOnNyuZusA0SV513hYyolZVTJPV8gPitTSqRowdSnNlZN/gpub/
         EQ83oa6zNh+oVImD44JLrqyjEpiyDvyq80zjqi8v0K5ksYWjTB2OQEEHnA+XDAfvcwV/
         nCCA==
X-Gm-Message-State: AOAM530V8WwHwaQ0tE/2muEVDwMcCIb3ERPSpqonjJ9S/MJYPGcGMmkf
        mrbQI5ifC5f44aTyWL2iWiIX1h39Ajd4vA==
X-Google-Smtp-Source: ABdhPJxUnbB5tXrIykzlIRXiPmh0n0N5tiRJ7Ais3kzFA5t2BEkk1nByGcntBwCHWqLY3wthNwnj9g==
X-Received: by 2002:a05:6402:3553:b0:419:6552:11b7 with SMTP id f19-20020a056402355300b00419655211b7mr17229682edd.286.1648740825297;
        Thu, 31 Mar 2022 08:33:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006db0a78bde8sm9521221ejy.87.2022.03.31.08.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:33:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZwnv-000WJ2-Vx;
        Thu, 31 Mar 2022 17:33:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v4 6/7] fetch: after refetch, encourage auto gc repacking
Date:   Thu, 31 Mar 2022 17:22:52 +0200
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
 <28c07219fd830196af1171320b86bc2a58ba3d79.1648476132.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <28c07219fd830196af1171320b86bc2a58ba3d79.1648476132.git.gitgitgadget@gmail.com>
Message-ID: <220331.86bkxmp25k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Robert Coup via GitGitGadget wrote:

> From: Robert Coup <robert@coup.net.nz>
>
> After invoking `fetch --refetch`, the object db will likely contain many
> duplicate objects. If auto-maintenance is enabled, invoke it with
> appropriate settings to encourage repacking/consolidation.
>
> * gc.autoPackLimit: unless this is set to 0 (disabled), override the
>   value to 1 to force pack consolidation.
> * maintenance.incremental-repack.auto: unless this is set to 0, override
>   the value to -1 to force incremental repacking.
>
> Signed-off-by: Robert Coup <robert@coup.net.nz>
> ---
>  Documentation/fetch-options.txt |  3 ++-
>  builtin/fetch.c                 | 19 ++++++++++++++++++-
>  t/t5616-partial-clone.sh        | 29 +++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index d03fce5aae0..622bd84768b 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -169,7 +169,8 @@ ifndef::git-pull[]
>  	associated objects that are already present locally, this option fetches
>  	all objects as a fresh clone would. Use this to reapply a partial clone
>  	filter from configuration or using `--filter=` when the filter
> -	definition has changed.
> +	definition has changed. Automatic post-fetch maintenance will perform
> +	object database pack consolidation to remove any duplicate objects.
>  endif::git-pull[]
>  
>  --refmap=<refspec>::
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e391a5dbc55..e3791f09ed5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2306,8 +2306,25 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  					     NULL);
>  	}
>  
> -	if (enable_auto_gc)
> +	if (enable_auto_gc) {
> +		if (refetch) {
> +			/*
> +			 * Hint auto-maintenance strongly to encourage repacking,
> +			 * but respect config settings disabling it.
> +			 */
> +			int opt_val;

nit: add a \n after this.

> +			if (git_config_get_int("gc.autopacklimit", &opt_val))
> +				opt_val = -1;
> +			if (opt_val != 0)

nit: don't compare against 0 or null,  just !opt_val

Isn't this whole thing also clearer as:

	int &forget;

        if (git_conf...(..., &forget))
		git_config_push_parameter("gc.autoPackLimit=1");

Maybe I haven't eyeballed this enough, but aren't you ignoring explicit
gc.autoPackLimit=0 configuration? Whereas what you seem to want is "set
this config unlress the user has it set", for which we only need to
check the git_config...(...) return value, no?

> +				git_config_push_parameter("gc.autoPackLimit=1");
> +
> +			if (git_config_get_int("maintenance.incremental-repack.auto", &opt_val))
> +				opt_val = -1;
> +			if (opt_val != 0)
> +				git_config_push_parameter("maintenance.incremental-repack.auto=-1");

hrm, do we really need to set both of these these days (not saying we
don't, just surprised). I.e. both gc.* an maintenance.* config.

*skims the code*

Urgh, yes? too_many_packs() seems to check gc.* only, but
incremental_repack_auto_condition() check this variable... :(

> +test_expect_success 'fetch --refetch triggers repacking' '
> +	GIT_TRACE2_CONFIG_PARAMS=gc.autoPackLimit,maintenance.incremental-repack.auto &&

Nit: Can we use GIT_CONFIG_KEY_* et al for this these days, or do we
still need this trace2 thingy?

> +	export GIT_TRACE2_CONFIG_PARAMS &&
> +
