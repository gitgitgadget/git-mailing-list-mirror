Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B3C6379F
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 10:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjBUKzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 05:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjBUKzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 05:55:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B4E22DDB
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 02:55:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bo30so3380936wrb.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAnad2NS5fFlpq2ckXQHLqfDMS3JPtYi0W3ikPN0QLo=;
        b=SyQ9KIp8RWOJJs4MW13UxbNV80ZN1nANU0DkjFPiLEwnGLjrKqqKKyYWNO2/ngy2l6
         dEa/ZPU2AqaM0BzVQo+5v9Ta74GN6R2Xs4l4f/5yeHJCS/TqE1Npe9UhdBeCDqGYddY0
         XGzTn/dW22xiMvfq4lpdgx6XrV/nKrGBdUSkqo5MhYHfommnArZcNP+ouYf75GKGImm8
         7xsb+QNZbKTuwNFpuazyvk1zSk1aqV0AaIDaJfHz9qJFZQ0dfTet1cGHmvSWtksfapoh
         eqzI5DV9Zq76IJr8yj0iVtVULN99dlAPygJ5qZo7BG0JHccLi4EeUywQvDRIOb7ttp/8
         fUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAnad2NS5fFlpq2ckXQHLqfDMS3JPtYi0W3ikPN0QLo=;
        b=IxSBvnGZtNbkF1tCkFTq2S0poTPXP0tGilHfGHEwth+A6Er7ElQy21xA1C6yyWsNOS
         vxvJyhGMVfHBfR1KnfW5b7C2PIRxuEBlPfYIeO48e6kojVkeVE9engUedoN+Gl+2J+CD
         Q0swRCRd+fKGZamNiIDdx+UNUGu14C2U5f5znkgNqAkioAx1b+B5g6YmEhi5PFyQBcPs
         eUQ/qZZJhGzytj66BKPl6WKTvzRFCeN6PAbZfmOdaclbFrWttkd/7dOu321L5Fe7Kw25
         s6OfvMy8vg7TSRUmN8V9jiOJOaGiH6TXjehlE+DNFFtD08nCesZga0QfrG5tItv7I/Ax
         oWHA==
X-Gm-Message-State: AO0yUKVfOjqVNkpZtbzH/UN6I7l4HC4wPoipl/5MJXxqbrfSuTwbNbUZ
        Y4kE2/QkPMwHqSv9D4m3gipian9mh1A=
X-Google-Smtp-Source: AK7set/El0BFNiV4w0xO0UTLU9+ez+K6ANxILue2OjyEvv1Xv4ZQCnogcOvsxGUXa4yyp8Qg7KDGxQ==
X-Received: by 2002:adf:e805:0:b0:2c6:e670:8867 with SMTP id o5-20020adfe805000000b002c6e6708867mr4039703wrm.0.1676976934703;
        Tue, 21 Feb 2023 02:55:34 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d65cd000000b002c5640f9bf9sm2890420wrw.85.2023.02.21.02.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:55:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <852c6efd-49a7-f6f0-dd6a-b28cb0909784@dunelm.org.uk>
Date:   Tue, 21 Feb 2023 10:55:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] rebase: stop accepting --rebase-merges=""
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-3-alexhenrie24@gmail.com>
In-Reply-To: <20230221055805.210951-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 21/02/2023 05:58, Alex Henrie wrote:
> The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
> empty string argument) has been an undocumented synonym of
> --rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
> confusion when a rebase.merges config option is introduced, where
> rebase.merges="" will be equivalent to not passing --rebase-merges.

I think this is sensible in the context of adding a config option. It is 
a backwards incompatible change though, lets hope no one was relying on 
it. Is there a particular reason you decided to redo the option parsing 
rather than just calling parse_merges_value() from the existing "if 
(rebase_merges)" block? I don't think it really matters, I'm just curious.

Best Wishes

Phillip

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   builtin/rebase.c         | 42 +++++++++++++++++++++++++++-------------
>   t/t3430-rebase-merges.sh |  6 ++++++
>   2 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6635f10d52..0a8366f30f 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -771,6 +771,20 @@ static int run_specific_rebase(struct rebase_options *opts)
>   	return status ? -1 : 0;
>   }
>   
> +static void parse_merges_value(struct rebase_options *options, const char *value)
> +{
> +	if (value) {
> +		if (!strcmp("no-rebase-cousins", value))
> +			options->rebase_cousins = 0;
> +		else if (!strcmp("rebase-cousins", value))
> +			options->rebase_cousins = 1;
> +		else
> +			die(_("Unknown mode: %s"), value);
> +	}
> +
> +	options->rebase_merges = 1;
> +}
> +
>   static int rebase_config(const char *var, const char *value, void *data)
>   {
>   	struct rebase_options *opts = data;
> @@ -980,6 +994,18 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
>   	return 0;
>   }
>   
> +static int parse_opt_merges(const struct option *opt, const char *arg, int unset)
> +{
> +	struct rebase_options *options = opt->value;
> +
> +	if (unset)
> +		options->rebase_merges = 0;
> +	else
> +		parse_merges_value(options, arg);
> +
> +	return 0;
> +}
> +
>   static void NORETURN error_on_missing_default_upstream(void)
>   {
>   	struct branch *current_branch = branch_get(NULL);
> @@ -1035,7 +1061,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	struct object_id branch_base;
>   	int ignore_whitespace = 0;
>   	const char *gpg_sign = NULL;
> -	const char *rebase_merges = NULL;
>   	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>   	struct object_id squash_onto;
>   	char *squash_onto_name = NULL;
> @@ -1137,10 +1162,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			   &options.allow_empty_message,
>   			   N_("allow rebasing commits with empty messages"),
>   			   PARSE_OPT_HIDDEN),
> -		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
> -			N_("mode"),
> +		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
>   			N_("try to rebase merges instead of skipping them"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
> +			PARSE_OPT_OPTARG, parse_opt_merges),
>   		OPT_BOOL(0, "fork-point", &options.fork_point,
>   			 N_("use 'merge-base --fork-point' to refine upstream")),
>   		OPT_STRING('s', "strategy", &options.strategy,
> @@ -1436,16 +1460,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.exec.nr)
>   		imply_merge(&options, "--exec");
>   
> -	if (rebase_merges) {
> -		if (!*rebase_merges)
> -			; /* default mode; do nothing */
> -		else if (!strcmp("rebase-cousins", rebase_merges))
> -			options.rebase_cousins = 1;
> -		else if (strcmp("no-rebase-cousins", rebase_merges))
> -			die(_("Unknown mode: %s"), rebase_merges);
> -		options.rebase_merges = 1;
> +	if (options.rebase_merges)
>   		imply_merge(&options, "--rebase-merges");
> -	}
>   
>   	if (options.type == REBASE_APPLY) {
>   		if (ignore_whitespace)
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index e0d910c229..b8ba323dbc 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -293,6 +293,12 @@ test_expect_success 'do not rebase cousins unless asked for' '
>   	EOF
>   '
>   
> +test_expect_success '--rebase-merges="" is invalid syntax' '
> +	echo "fatal: Unknown mode: " >expect &&
> +	! git rebase --rebase-merges="" HEAD^ 2>actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'refs/rewritten/* is worktree-local' '
>   	git worktree add wt &&
>   	cat >wt/script-from-scratch <<-\EOF &&
