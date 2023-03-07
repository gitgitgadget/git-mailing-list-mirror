Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8BC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 15:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCGPFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCGPEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 10:04:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068D9984D8
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 06:57:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f11so12397354wrv.8
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 06:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678201019;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M51Jyr463YaTXAhWav3yZ3hitttzkU6nKYUwyrdw9Dw=;
        b=S/AHpGxNTSVr76JMGTnu68UR5bIX0TAibkiLoGIyFSrkj6SZ0zPikRaL6T/vpbs7+p
         HKj4q3YrDJX1UFmINOP31pFm6YREsHaOP26Y7y+apsfVPqhHapn/Ii+kN2PupxlDAB+8
         11EU3z5QLB1yJ2pd+DmiYrze+xg8b+RoDmryB6KyW/PakaHsbBgWNFS8DCZhuRkAFIvX
         y5U3r7Cu9WFGsYUEwl9A3sPV9a23jnHnczgaII3fImH0Jo19odknaq2PBuEoQm3jr8O8
         1HqkJfGPv0K3s4KOiuv/0gLImHZTEcM4yr2oX5ak1HxudKMGJYhfsWpz5eHbpKJBkP2S
         TwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201019;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M51Jyr463YaTXAhWav3yZ3hitttzkU6nKYUwyrdw9Dw=;
        b=sJwiCadVCV4+RR5yLu6/wtCx45o3MXJdlJl0FnMG7203z4PSMlhGyKXDp9IjIy+ZoV
         mRCs8Eo1wJDw6UxVEx+cDL+7mg7M+BOdwQggfNj7dUcP4cC/DzYlhgz3DkgV+kJUqW7Z
         RGQtqoXHjdC0t8gfVBxTcp1SDDY+yqdFVXlzdpIsEXEvsr7YYeXVwwkUbnXUuEUPmQIF
         F6qoFVgw/HCzTnpf95jOuof8VxGvfdEPzPJg53C+6nsc4lb+XZ6jmZviR6GRwEEyila+
         J5gCa+bluJn7Lbdf7vmNObUcCbglnDzVOn3XucOZICkUx14bP/8N2Z6j0R0HZ0PVYWFF
         hpjw==
X-Gm-Message-State: AO0yUKXtcPvo3Pshrbw4EeCS0d0eRhPy+aESsrHRMt7rFAzQDQD66XdP
        ub2CTCebo0HtjHNtXozv+As=
X-Google-Smtp-Source: AK7set9Es1I/UNhPrzwS0ggWEZO3FwZcPxUospOobb1V1xttBroTFHnAomPHZI6roMNd+qbje79kzg==
X-Received: by 2002:adf:e30d:0:b0:2ca:f86a:9643 with SMTP id b13-20020adfe30d000000b002caf86a9643mr10232274wrj.0.1678201019271;
        Tue, 07 Mar 2023 06:56:59 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id q10-20020a5d658a000000b002c70851fdd8sm12794589wru.75.2023.03.07.06.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:56:58 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7cf19017-518b-245e-aea2-5dee55f88276@dunelm.org.uk>
Date:   Tue, 7 Mar 2023 14:56:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com>
 <20230305050709.68736-4-alexhenrie24@gmail.com>
In-Reply-To: <20230305050709.68736-4-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 05/03/2023 05:07, Alex Henrie wrote:
> The purpose of the new option is to accommodate users who would like
> --rebase-merges to be on by default and to facilitate turning on
> --rebase-merges by default without configuration in a future version of
> Git.
> 
> Name the new option rebase.rebaseMerges, even though it is a little
> redundant, for consistency with the name of the command line option and
> to be clear when scrolling through values in the [rebase] section of
> .gitconfig.
> 
> In the future, the default rebase-merges mode may change from
> no-rebase-cousins to rebase-cousins. Support setting rebase.rebaseMerges
> to the nonspecific value "true" for users who do not need or want to
> care about the default changing in the future. Similarly, for users who
> have --rebase-merges in an alias and want to get the future behavior
> now, use the specific rebase-merges mode from the config if a specific
> mode is not given on the command line.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/config/rebase.txt        | 11 ++++
>   Documentation/git-rebase.txt           | 17 +++---
>   builtin/rebase.c                       | 79 ++++++++++++++++++--------
>   t/t3422-rebase-incompatible-options.sh | 17 ++++++
>   t/t3430-rebase-merges.sh               | 68 ++++++++++++++++++++++
>   5 files changed, 161 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index f19bd0e040..f7d3218b1d 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -67,3 +67,14 @@ rebase.rescheduleFailedExec::
>   
>   rebase.forkPoint::
>   	If set to false set `--no-fork-point` option by default.
> +
> +rebase.rebaseMerges::
> +	Whether and how to set the `--rebase-merges` option by default. Can
> +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
> +	true is equivalent to `--rebase-merges` without an argument,

This is a bit picky but how can rebase.rebaseMerges=true be equivalent 
to --rebase-merges without an argument when the behavior of 
--rebase-merges without an argument depends on the value of 
rebase.rebaseMerges?

> setting to
> +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
> +	`--rebase-merges` with that value as its argument, and setting to false
> +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
> +	command line without an argument overrides a `rebase.rebaseMerges=false`
> +	configuration, but the absence of a specific rebase-merges mode on the
> +	command line does not counteract a specific mode set in the configuration.

I may not agree the with the design choice but the documentation here 
and below is very clear about the behavior of --rebase-merges without an 
argument which is good.

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 4e57a87624..6ec86c9c6e 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -537,16 +537,17 @@ See also INCOMPATIBLE OPTIONS below.
>   	by recreating the merge commits. Any resolved merge conflicts or
>   	manual amendments in these merge commits will have to be
>   	resolved/re-applied manually. `--no-rebase-merges` can be used to
> -	countermand a previous `--rebase-merges`.
> +	countermand both the `rebase.rebaseMerges` config option and a previous
> +	`--rebase-merges`.
>   +
>   When rebasing merges, there are two modes: `rebase-cousins` and
> -`no-rebase-cousins`. If the mode is not specified, it defaults to
> -`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
> -`<upstream>` as direct ancestor will keep their original branch point, i.e.
> -commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
> -option will keep their original ancestry by default. In `rebase-cousins` mode,
> -such commits are instead rebased onto `<upstream>` (or `<onto>`, if
> -specified).
> +`no-rebase-cousins`. If the mode is not specified on the command line or in
> +the `rebase.rebaseMerges` config option, it defaults to `no-rebase-cousins`.
> +In `no-rebase-cousins` mode, commits which do not have `<upstream>` as direct
> +ancestor will keep their original branch point, i.e. commits that would be
> +excluded by linkgit:git-log[1]'s `--ancestry-path` option will keep their
> +original ancestry by default. In `rebase-cousins` mode, such commits are
> +instead rebased onto `<upstream>` (or `<onto>`, if specified).
 >[...]
>   static int rebase_config(const char *var, const char *value, void *data)
>   {
>   	struct rebase_options *opts = data;
> @@ -800,6 +813,15 @@ static int rebase_config(const char *var, const char *value, void *data)
>   		return 0;
>   	}
>   
> +	if (!strcmp(var, "rebase.rebasemerges")) {
> +		opts->config_rebase_merges = git_parse_maybe_bool(value);
> +		if (opts->config_rebase_merges < 0) {
> +			opts->config_rebase_merges = 1;
> +			parse_rebase_merges_value(opts, value);
> +		}

I think we need

	} else {
		opts->rebase_cousins = 0;
	}

here. Otherwise if rebase.rebaseMerges is set twice we wont follow the 
usual "last config wins" convention. For example

	[rebase]
		rebaseMerges=rebase-cousins
		rebaseMerges=true

will result in us unexpectedly rebasing cousins

The rest of the patch looks fine

Best Wishes

Phillip

> +		return 0;
> +	}
> +
>   	if (!strcmp(var, "rebase.updaterefs")) {
>   		opts->config_update_refs = git_config_bool(var, value);
>   		return 0;
> @@ -980,6 +1002,27 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
>   	return 0;
>   }
>   
> +static int parse_opt_rebase_merges(const struct option *opt, const char *arg, int unset)
> +{
> +	struct rebase_options *options = opt->value;
> +
> +	options->rebase_merges = !unset;
> +
> +	if (arg) {
> +		if (!*arg) {
> +			warning(_("--rebase-merges with an empty string "
> +				  "argument is deprecated and will stop "
> +				  "working in a future version of Git. Use "
> +				  "--rebase-merges without an argument "
> +				  "instead, which does the same thing."));
> +			return 0;
> +		}
> +		parse_rebase_merges_value(options, arg);
> +	}
> +
> +	return 0;
> +}
> +
>   static void NORETURN error_on_missing_default_upstream(void)
>   {
>   	struct branch *current_branch = branch_get(NULL);
> @@ -1035,7 +1078,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	struct object_id branch_base;
>   	int ignore_whitespace = 0;
>   	const char *gpg_sign = NULL;
> -	const char *rebase_merges = NULL;
>   	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>   	struct object_id squash_onto;
>   	char *squash_onto_name = NULL;
> @@ -1137,10 +1179,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			   &options.allow_empty_message,
>   			   N_("allow rebasing commits with empty messages"),
>   			   PARSE_OPT_HIDDEN),
> -		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
> -			N_("mode"),
> +		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
>   			N_("try to rebase merges instead of skipping them"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
> +			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
>   		OPT_BOOL(0, "fork-point", &options.fork_point,
>   			 N_("use 'merge-base --fork-point' to refine upstream")),
>   		OPT_STRING('s', "strategy", &options.strategy,
> @@ -1436,21 +1477,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.exec.nr)
>   		imply_merge(&options, "--exec");
>   
> -	if (rebase_merges) {
> -		if (!*rebase_merges)
> -			warning(_("--rebase-merges with an empty string "
> -				  "argument is deprecated and will stop "
> -				  "working in a future version of Git. Use "
> -				  "--rebase-merges without an argument "
> -				  "instead, which does the same thing."));
> -		else if (!strcmp("rebase-cousins", rebase_merges))
> -			options.rebase_cousins = 1;
> -		else if (strcmp("no-rebase-cousins", rebase_merges))
> -			die(_("Unknown mode: %s"), rebase_merges);
> -		options.rebase_merges = 1;
> -		imply_merge(&options, "--rebase-merges");
> -	}
> -
>   	if (options.type == REBASE_APPLY) {
>   		if (ignore_whitespace)
>   			strvec_push(&options.git_am_opts,
> @@ -1513,13 +1539,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				break;
>   
>   		if (i >= 0 || options.type == REBASE_APPLY) {
> -			if (is_merge(&options))
> -				die(_("apply options and merge options "
> -					  "cannot be used together"));
> -			else if (options.autosquash == -1 && options.config_autosquash == 1)
> +			if (options.autosquash == -1 && options.config_autosquash == 1)
>   				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
> +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
> +				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
>   			else if (options.update_refs == -1 && options.config_update_refs == 1)
>   				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
> +			else if (is_merge(&options))
> +				die(_("apply options and merge options "
> +					  "cannot be used together"));
>   			else
>   				options.type = REBASE_APPLY;
>   		}
> @@ -1530,6 +1558,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	options.update_refs = (options.update_refs >= 0) ? options.update_refs :
>   			     ((options.config_update_refs >= 0) ? options.config_update_refs : 0);
>   
> +	if (options.rebase_merges == 1)
> +		imply_merge(&options, "--rebase-merges");
> +	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
> +				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
> +
>   	if (options.autosquash == 1)
>   		imply_merge(&options, "--autosquash");
>   	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 4711b37a28..2eba00bdf5 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -85,6 +85,11 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --reapply-cherry-picks A
>   	"
>   
> +	test_expect_success "$opt incompatible with --rebase-merges" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --rebase-merges A
> +	"
> +
>   	test_expect_success "$opt incompatible with --update-refs" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --update-refs A
> @@ -101,6 +106,12 @@ test_rebase_am_only () {
>   		grep -e --no-autosquash err
>   	"
>   
> +	test_expect_success "$opt incompatible with rebase.rebaseMerges" "
> +		git checkout B^0 &&
> +		test_must_fail git -c rebase.rebaseMerges=true rebase $opt A 2>err &&
> +		grep -e --no-rebase-merges err
> +	"
> +
>   	test_expect_success "$opt incompatible with rebase.updateRefs" "
>   		git checkout B^0 &&
>   		test_must_fail git -c rebase.updateRefs=true rebase $opt A 2>err &&
> @@ -113,6 +124,12 @@ test_rebase_am_only () {
>   		git -c rebase.autosquash=true rebase --no-autosquash $opt A
>   	"
>   
> +	test_expect_success "$opt okay with overridden rebase.rebaseMerges" "
> +		test_when_finished \"git reset --hard B^0\" &&
> +		git checkout B^0 &&
> +		git -c rebase.rebaseMerges=true rebase --no-rebase-merges $opt A
> +	"
> +
>   	test_expect_success "$opt okay with overridden rebase.updateRefs" "
>   		test_when_finished \"git reset --hard B^0\" &&
>   		git checkout B^0 &&
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index d46d9545f2..aa75e192d1 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -278,6 +278,74 @@ test_expect_success 'do not rebase cousins unless asked for' '
>   	EOF
>   '
>   
> +test_expect_success '--rebase-merges="" is deprecated' '
> +	git rebase --rebase-merges="" HEAD^ 2>actual &&
> +	grep deprecated actual
> +'
> +
> +test_expect_success 'rebase.rebaseMerges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
> +	test_config rebase.rebaseMerges rebase-cousins &&
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
> +test_expect_success '--no-rebase-merges overrides rebase.rebaseMerges=no-rebase-cousins' '
> +	test_config rebase.rebaseMerges no-rebase-cousins &&
> +	git checkout -b override-config-no-rebase-cousins E &&
> +	git rebase --no-rebase-merges C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.rebaseMerges=rebase-cousins' '
> +	test_config rebase.rebaseMerges rebase-cousins &&
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
> +test_expect_success '--rebase-merges overrides rebase.rebaseMerges=false' '
> +	test_config rebase.rebaseMerges false &&
> +	git checkout -b override-config-merges-false E &&
> +	before="$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase --rebase-merges C &&
> +	test_cmp_rev HEAD $before
> +'
> +
> +test_expect_success '--rebase-merges does not override rebase.rebaseMerges=rebase-cousins' '
> +	test_config rebase.rebaseMerges rebase-cousins &&
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
