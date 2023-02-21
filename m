Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D42C6379F
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 10:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjBUKrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 05:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUKq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 05:46:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E370222DD
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 02:46:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bo30so3347534wrb.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 02:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAwxTknEmcSD6GqZkPbFJMYAfiHcsQNAwgWZaya7zx4=;
        b=ZnDS5EcacNcLPMIoYXYKKIH+zagYsrcFeSLkC63mDRFFQreohCAt2ttG2cmyyz4tRC
         64jeA3cCYojDE2JI96DolT7T0gFHzXA3aq5WLu5ogXn1WEPoAXZmjhnDPeNQSBEAjZk5
         Q1DFCOGWzTVDjio9xyuQy3Udby000/zRXGXEG6NZO6P9BWfqcyWrbmYbfgkP2Np0urZs
         x8O79u2RVXhCjXeF+pezdoDu8VOK193DZG1A1tt1mrg+/HD3/97caWSVtJ7uL1Vl6Juk
         gHHZJG31xYqGfEp+gb1LxH2eH0IiSpWq7s+dHGtlaibzzgRDahl/gznX6l5yfrgoqMiv
         Rryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAwxTknEmcSD6GqZkPbFJMYAfiHcsQNAwgWZaya7zx4=;
        b=raL1U2/jucxfQEMylsXwvX1yJUqrQTN1980NlQAYaeLk8E+astEBRE+5PTWpQn6Wsv
         /giV9Z9OlmN+XbCtfs7dGgPcOQCZEMSlB4IeRZPJVe4WddfeAJ7xpv2gSNQUdzNluB74
         S0fJEVWc5wu7a8yfxXLyC2kEua314DTJOHl5794PrhFx9Oz7BbF0t/DNV/zCMDu0l7Gs
         KuRQN4fgqnr8AuZBtPHOsL/HWevmC8myQpefaD2Z8C2K1Q7xOXa+UKMWzaKt7t6M8P6W
         f2fRtsj7tl1S3j1f9JRx0J2saM1CJoAkbJe45dPIPjn2G61o8TUbm79uN8aeSd0j2D97
         gAaw==
X-Gm-Message-State: AO0yUKX9yvP6sX8CzVBDlUpdkzLQNytIT2m7n6uaHzJgPZLvKULdMW+B
        MU3TCH2tLBeDwWizLGK2jYc=
X-Google-Smtp-Source: AK7set/RwXlqJLvSqhanTqnK/Utl6YwOxUExwUtJVRcH1ztckfqYFluR1AtgPtAEGhUbMI99DLFh/g==
X-Received: by 2002:a5d:6284:0:b0:2bd:d34e:5355 with SMTP id k4-20020a5d6284000000b002bdd34e5355mr3337957wru.20.1676976415827;
        Tue, 21 Feb 2023 02:46:55 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id w18-20020a05600c475200b003e220998b6bsm5249693wmo.17.2023.02.21.02.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:46:55 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d1f10c52-9cfb-8e6a-cbd6-cd81b778b8cc@dunelm.org.uk>
Date:   Tue, 21 Feb 2023 10:46:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-4-alexhenrie24@gmail.com>
In-Reply-To: <20230221055805.210951-4-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 21/02/2023 05:58, Alex Henrie wrote:
> The purpose of the new option is to accommodate users who would like
> --rebase-merges to be on by default and to facilitate possibly turning
> on --rebase-merges by default without configuration in a future version
> of Git.

Thanks for improving the commit message, this seems like a reasonable 
change.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/config/rebase.txt |  3 ++
>   Documentation/git-rebase.txt    |  3 +-
>   builtin/rebase.c                | 11 +++++
>   t/t3430-rebase-merges.sh        | 81 +++++++++++++++++++++++++++++++++
>   4 files changed, 97 insertions(+), 1 deletion(-)
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

Below I see this takes a boolean in addition to [no-]rebase-cousins, it 
would be nice to document that, especially what "true" means.

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index c98784a0d2..b02f9cbb8c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -537,7 +537,8 @@ See also INCOMPATIBLE OPTIONS below.
>   	by recreating the merge commits. Any resolved merge conflicts or
>   	manual amendments in these merge commits will have to be
>   	resolved/re-applied manually. `--no-rebase-merges` can be used to
> -	countermand a previous `--rebase-merges`.
> +	countermand both the `rebase.merges` config option and a previous
> +	`--rebase-merges`.
>   +
>   By default, or when `no-rebase-cousins` was specified, commits which do not
>   have `<upstream>` as direct ancestor will keep their original branch point,
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0a8366f30f..35f3837f43 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -829,6 +829,17 @@ static int rebase_config(const char *var, const char *value, void *data)
>   		return 0;
>   	}
>   
> +	if (!strcmp(var, "rebase.merges")) {
> +		const char *rebase_merges;
> +		if (!git_config_string(&rebase_merges, var, value) &&
> +		    rebase_merges && *rebase_merges) {

rebase_merges is guaranteed to be non-NULL if git_config_string returns 0.

> +			opts->rebase_merges = git_parse_maybe_bool(rebase_merges);
> +			if (opts->rebase_merges < 0)
> +				parse_merges_value(opts, rebase_merges);
> +		}
> +		return 0;
> +	}

I think this leaks rebase_merges as git_config_string() returns a copy 
despite taking a "const char*".

If we're adding a new config option that is incompatible with the apply 
backend we should add some logic to error out if the config is set and 
any of the apply options are given - see eddfcd8ece (rebase: provide 
better error message for apply options vs. merge config, 2023-01-25)

>   	if (!strcmp(var, "rebase.backend")) {
>   		return git_config_string(&opts->default_backend, var, value);
>   	}
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index b8ba323dbc..4a7193d501 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -299,6 +299,86 @@ test_expect_success '--rebase-merges="" is invalid syntax' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'rebase.merges="" is equivalent to not passing --rebase-merges' '
> +	git config rebase.merges "" &&

test_config is generally preferred as it clears the value at the end of 
the test. Then you don't need the final hunk of this patch.

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
> +test_expect_success '--no-rebase-merges overrides rebase.merges=no-rebase-cousins' '
> +	git config rebase.merges no-rebase-cousins &&
> +	git checkout -b override-config-no-rebase-cousins E &&
> +	git rebase --no-rebase-merges C &&
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
> +test_expect_success '--rebase-merges overrides rebase.merges=false' '
> +	git config rebase.merges false &&
> +	git checkout -b override-config-merges-false main &&
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

Thanks for the tests, I think they provide good coverage of the various 
combinations of config and commandline settings

Best Wishes

Phillip

>   test_expect_success 'refs/rewritten/* is worktree-local' '
>   	git worktree add wt &&
>   	cat >wt/script-from-scratch <<-\EOF &&
> @@ -409,6 +489,7 @@ test_expect_success 'a "merge" into a root commit is a fast-forward' '
>   '
>   
>   test_expect_success 'A root commit can be a cousin, treat it that way' '
> +	git config --unset rebase.merges &&
>   	git checkout --orphan khnum &&
>   	test_commit yama &&
>   	git checkout -b asherah main &&
