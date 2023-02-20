Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765EFC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 09:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjBTJil (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 04:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBTJik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 04:38:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC761A0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:38:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c17so1947761wrx.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTOi8qdBB9OMOFDqsqnL0cWpIA0oMNVDyiWOWm6PZHg=;
        b=AaqhrcgxMIs1QnOHh3rIlLiKOneeCUw4V8qaVxLOWZghJdAVRyvnSFwmzjnIjovsim
         7tpH6bfpI16TsfMpdwj/s/PruuJuEn7VBqiemfvx44qxaBnoIBgJF0XM89MD7qTBzY+m
         wESPX+mBG7GfzV3Rc8pZVIzYyKrHO1gVCTzwMzqbF1SrtGtpFP4rHVl8J3+Jg8fazKsW
         5hqFRPPNEuhOJablWF3HsTkjqvDpm+4jDYfzNfKsHQ0n8piWDYWHk7irtzcoDt1vd8R6
         rpsmLQgJVCSJSFubcKZYQ6ZEbCeRd3uM8XuSHuYafvYWck1gWtVXNu82E8ngL9jiwgI6
         zFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTOi8qdBB9OMOFDqsqnL0cWpIA0oMNVDyiWOWm6PZHg=;
        b=PMErF/VZ0bdex+trTJx0S3xs8L9VnNnHJas0+2TXd/HbQnhamnIL2NT7KDagWb07fb
         eMWFYsWAfbwgkRdNeBMhUtWfv3vIuVaalmxjTwLJ5pVKZC3naTTOHpvNgClh/A8wtiSC
         tU6puElnzCpVxosLToLsJuLR8eBlJIdNM/fxZ0luUFtJBp7ou7OU8I6rElYAEcw96Spe
         mBmR7l01Sy0mZ1NqKp8HQssLJTYM2Mj7haNG88zvz3IvYMgAN8OQAswI4s088P8QZWpT
         p3bMyrLGkGxXkjuYhJbZv26gKmpPmmN4QkucG+KNJ5qN76qpXAy7wptX9BL3knG7n5Xq
         /D5Q==
X-Gm-Message-State: AO0yUKXOlp3UOU1bT/VOaoNSzqif979t5lvXkXiuqzsX1Ygloj0IlYdE
        la5zMurPtB9r6nsbmRl00xo=
X-Google-Smtp-Source: AK7set8ZInu0yXFw9jWf9fY0p1cxm+pu/5N4Jrm42Go0DrPMHyVNX5S4pHbNH3Ngmw3HYyjXEyVTuw==
X-Received: by 2002:a05:6000:188b:b0:2c5:4e06:b689 with SMTP id a11-20020a056000188b00b002c54e06b689mr2178573wri.28.1676885907063;
        Mon, 20 Feb 2023 01:38:27 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d6a0b000000b002c558228b6dsm11638404wru.12.2023.02.20.01.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 01:38:26 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <fe9a3c86-0169-588f-2b12-e124d9d138d9@dunelm.org.uk>
Date:   Mon, 20 Feb 2023 09:38:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
References: <20230220033224.10400-1-alexhenrie24@gmail.com>
 <20230220033224.10400-2-alexhenrie24@gmail.com>
In-Reply-To: <20230220033224.10400-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 20/02/2023 03:32, Alex Henrie wrote:

I think the commit message could benefit from some justification for why 
this config option is useful. I don't object to it being added but you 
need to make the case for why it is a good idea.

> At the same time, stop accepting --rebase-merges="" as a synonym of
> --rebase-merges=no-rebase-cousins.

Please try to avoid combining unrelated changes in the same patch. I 
agree that accepting an empty argument to mean "no-rebase-cousins" is 
slightly odd but as that is the default I'm not sure it is doing any harm.

Best Wishes

Phillip

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/config/rebase.txt |  3 ++
>   builtin/rebase.c                | 50 ++++++++++++++-----
>   t/t3430-rebase-merges.sh        | 87 +++++++++++++++++++++++++++++++++
>   3 files changed, 127 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index f19bd0e040..d956ec4441 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -67,3 +67,6 @@ rebase.rescheduleFailedExec::
>   
>   rebase.forkPoint::
>   	If set to false set `--no-fork-point` option by default.
> +
> +rebase.merges::
> +	Default value of `--rebase-merges` option.
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 96c0474379..ab4c3b2870 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -771,6 +771,25 @@ static int run_specific_rebase(struct rebase_options *opts)
>   	return status ? -1 : 0;
>   }
>   
> +static void parse_merges_value(struct rebase_options *options, const char *value)
> +{
> +	if (value) {
> +		if (!strcmp("drop", value)) {
> +			options->rebase_merges = 0;
> +			return;
> +		}
> +
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
> @@ -815,6 +834,14 @@ static int rebase_config(const char *var, const char *value, void *data)
>   		return 0;
>   	}
>   
> +	if (!strcmp(var, "rebase.merges")) {
> +		const char *rebase_merges;
> +		if (!git_config_string(&rebase_merges, var, value) &&
> +		    rebase_merges && *rebase_merges)
> +			parse_merges_value(opts, rebase_merges);
> +		return 0;
> +	}
> +
>   	if (!strcmp(var, "rebase.backend")) {
>   		return git_config_string(&opts->default_backend, var, value);
>   	}
> @@ -980,6 +1007,13 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
>   	return 0;
>   }
>   
> +static int parse_opt_merges(const struct option *opt, const char *arg, int unset)
> +{
> +	BUG_ON_OPT_NEG(unset);
> +	parse_merges_value(opt->value, arg);
> +	return 0;
> +}
> +
>   static void NORETURN error_on_missing_default_upstream(void)
>   {
>   	struct branch *current_branch = branch_get(NULL);
> @@ -1035,7 +1069,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	struct object_id branch_base;
>   	int ignore_whitespace = 0;
>   	const char *gpg_sign = NULL;
> -	const char *rebase_merges = NULL;
>   	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>   	struct object_id squash_onto;
>   	char *squash_onto_name = NULL;
> @@ -1137,10 +1170,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
> @@ -1436,16 +1468,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.exec.nr)
>   		imply_merge(&options, "--exec");
>   
> -	if (rebase_merges && strcmp("drop", rebase_merges)) {
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
> index 861c8405f2..9be07249cc 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -298,6 +298,92 @@ test_expect_success 'do not rebase cousins unless asked for' '
>   	EOF
>   '
>   
> +test_expect_success '--rebase-merges="" is invalid syntax' '
> +	echo "fatal: Unknown mode: " >expect &&
> +	! git rebase --rebase-merges="" HEAD^ 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase.merges="" is equivalent to not passing --rebase-merges' '
> +	git config rebase.merges "" &&
> +	git checkout -b config-merges-blank E &&
> +	git rebase C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
> +	git config rebase.merges rebase-cousins &&
> +	git checkout -b config-rebase-cousins main &&
> +	git rebase HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges=drop overrides rebase.merges=no-rebase-cousins' '
> +	git config rebase.merges no-rebase-cousins &&
> +	git checkout -b override-config-no-rebase-cousins E &&
> +	git rebase --rebase-merges=drop C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
> +	git config rebase.merges rebase-cousins &&
> +	git checkout -b override-config-rebase-cousins main &&
> +	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	o | H
> +	|/
> +	o A
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges overrides rebase.merges=drop' '
> +	git config rebase.merges drop &&
> +	git checkout -b override-config-merges-drop main &&
> +	git rebase --rebase-merges HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	o | H
> +	|/
> +	o A
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
> +	git config rebase.merges rebase-cousins &&
> +	git checkout -b no-override-config-rebase-cousins main &&
> +	git rebase --rebase-merges HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
>   test_expect_success 'refs/rewritten/* is worktree-local' '
>   	git worktree add wt &&
>   	cat >wt/script-from-scratch <<-\EOF &&
> @@ -408,6 +494,7 @@ test_expect_success 'a "merge" into a root commit is a fast-forward' '
>   '
>   
>   test_expect_success 'A root commit can be a cousin, treat it that way' '
> +	git config --unset rebase.merges &&
>   	git checkout --orphan khnum &&
>   	test_commit yama &&
>   	git checkout -b asherah main &&
