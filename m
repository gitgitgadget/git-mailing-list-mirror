Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC1C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EA660FDA
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 10:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGLKX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhGLKXz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 06:23:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAEC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 03:21:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r11so19595912wro.9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sZqqNXx9mJrf6LY4oLs2fCD/2zrkJAbZeV0DAZPirs4=;
        b=sJk/pOYukN84743hbGl7qWnKxzhdMazXaVXPAfUSdwDCwO3v9RHjzTcpA+q38PPpuH
         r7u44Ds8Q4KNSpCe5pGgoZAh+eMucUkKx/M3OjmG7PVmAvIy1k2uPeEkVyy64hNfaOJS
         YV3J8Ex/meNap7mA4ExFIvmM0Wp5sT0ZnTHHSWe1vSNcl7sOp1dx9iM6UGOYEyVn8Dx+
         J/oxNvz3dGL7uyN74SsyvRaEStTQLdq0h+iOkdc6g1jpRIVfXy5s7bCPVJGt8Xf+BXp2
         0ia/M41aeObpRzFZS+rHSFJHaBOejr4oR+xUKxHOdqGshcdAtG18aI0HcswWRhK6tULT
         bbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZqqNXx9mJrf6LY4oLs2fCD/2zrkJAbZeV0DAZPirs4=;
        b=pnZXLQRHJj/KcDEhF9sAbk+lVC2T8wI3lg7SmMNQ6NVORBtNe5smpauh0of/mVXLJn
         v8vxn1FhDVRMKFuZrJGbbkRHpOF84ewIY7ZeymzEQ1v441Bv/JVrej3ubwZHwZJz6fXL
         fPYKn+7UR9XyCASVD/qpFBtVc1jqKy3h2o3tMfXfqKO8CRNCWJOlMjAH0xyY+SqwNisa
         RKELpgDj4pvNR+qQZqbhJPaLnOrIhJglYTf4B0vseOdKbFR23i+u/2Co39PHb43bhh/b
         cjw31TUTIFEJuB7JW240R5GbV7nHudkLbaSARuaAcoS0aGjb8ZY/76zE+o29wGc8qbBT
         pmFw==
X-Gm-Message-State: AOAM533JFeTZ7t1mO51yh3aE3wFM8yY4H8asH/rnwv6GwAbBQiwoFxLH
        TcYik3SUscW8zsarwN4HTRQ=
X-Google-Smtp-Source: ABdhPJxLVcVSV5eqHDaJOHW9nQz926ain5CCmULkp19DCNigsloD55QxPo/6VF1YWQVq4kIvOGKi9Q==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr31592878wrn.320.1626085265575;
        Mon, 12 Jul 2021 03:21:05 -0700 (PDT)
Received: from [192.168.1.201] (136.2.7.51.dyn.plus.net. [51.7.2.136])
        by smtp.googlemail.com with ESMTPSA id s13sm9973817wrm.13.2021.07.12.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 03:21:05 -0700 (PDT)
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com, felipe.contreras@gmail.com,
        newren@gmail.com
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
Date:   Mon, 12 Jul 2021 11:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711012604.947321-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex


On 11/07/2021 02:26, Alex Henrie wrote:
> The warning about pulling without specifying how to reconcile divergent
> branches says that after setting pull.rebase to true, --ff-only can
> still be passed on the command line to require a fast-forward. Make that
> actually work.

Thanks for revising this patch, I like this approach much better. I do 
however have some concerns about the interaction of pull.ff with the 
rebase config and command line options. I'd naively expect the following 
behavior (where rebase can fast-forward if possible)

   pull.ff  pull.rebase  commandline  action
    only     not false                rebase
    only     not false   --no-rebase  fast-forward only
     *       not false    --ff-only   fast-forward only
    only     not false    --ff        merge --ff
    only     not false    --no-ff     merge --no-ff
    only       false                  fast-forward only
    only       false      --rebase    rebase
    only       false      --ff        merge --ff
    only       false      --no-ff     merge --no-ff

I don't think enforcing fast-forward only for rebases makes sense unless 
it is given on the command line. If the user gives `--rebase` 
`--ff-only` on the command line then we should either error out or take 
the last one in which case `pull --rebase --ff-only` would fast-forward 
only but `pull --ff-only --rebase` would rebase. We should also decide 
what to do when the user has pull.ff set to something other than only 
and also has pull.rebase to something other than false set - I'd guess 
we'd want to rebase unless there is a merge option on the command line 
but I haven't thought about those cases.

Best Wishes

Phillip

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   advice.c                     |  5 +++++
>   advice.h                     |  1 +
>   builtin/merge.c              |  2 +-
>   builtin/pull.c               | 11 ++++++++---
>   t/t7601-merge-pull-config.sh | 24 ++++++++++++++++++++++++
>   5 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/advice.c b/advice.c
> index 0b9c89c48a..337e8f342b 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -286,6 +286,11 @@ void NORETURN die_conclude_merge(void)
>   	die(_("Exiting because of unfinished merge."));
>   }
>   
> +void NORETURN die_ff_impossible(void)
> +{
> +	die(_("Not possible to fast-forward, aborting."));
> +}
> +
>   void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
>   {
>   	struct string_list_item *item;
> diff --git a/advice.h b/advice.h
> index bd26c385d0..1624043838 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -95,6 +95,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...);
>   int error_resolve_conflict(const char *me);
>   void NORETURN die_resolve_conflict(const char *me);
>   void NORETURN die_conclude_merge(void);
> +void NORETURN die_ff_impossible(void);
>   void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
>   void detach_advice(const char *new_name);
>   
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8a843b1f5..aa920ac524 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	if (fast_forward == FF_ONLY)
> -		die(_("Not possible to fast-forward, aborting."));
> +		die_ff_impossible();
>   
>   	if (autostash)
>   		create_autostash(the_repository,
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 3e13f81084..d979660482 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1046,9 +1046,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>   
>   	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
>   
> -	if (rebase_unspecified && !opt_ff && !can_ff) {
> -		if (opt_verbosity >= 0)
> -			show_advice_pull_non_ff();
> +	if (!can_ff) {
> +		if (opt_ff) {
> +			if (!strcmp(opt_ff, "--ff-only"))
> +				die_ff_impossible();
> +		} else {
> +			if (rebase_unspecified && opt_verbosity >= 0)
> +				show_advice_pull_non_ff();
> +		}
>   	}
>   
>   	if (opt_rebase) {
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 52e8ccc933..b5a09a60f9 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -183,6 +183,30 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
>   	test_must_fail git pull . c3
>   '
>   
> +test_expect_success 'pull prevents non-fast-forward with pull.ff=only and pull.rebase=true' '
> +	git reset --hard c1 &&
> +	test_config pull.ff only &&
> +	test_config pull.rebase true &&
> +	test_must_fail git pull . c3
> +'
> +
> +test_expect_success 'pull prevents non-fast-forward with pull.ff=only and pull.rebase=false' '
> +	git reset --hard c1 &&
> +	test_config pull.ff only &&
> +	test_config pull.rebase false &&
> +	test_must_fail git pull . c3
> +'
> +
> +test_expect_success 'pull prevents non-fast-forward with --rebase --ff-only' '
> +	git reset --hard c1 &&
> +	test_must_fail git pull --rebase --ff-only . c3
> +'
> +
> +test_expect_success 'pull prevents non-fast-forward with --no-rebase --ff-only' '
> +	git reset --hard c1 &&
> +	test_must_fail git pull --no-rebase --ff-only . c3
> +'
> +
>   test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
>   	git reset --hard c1 &&
>   	git config pull.twohead ours &&
> 

