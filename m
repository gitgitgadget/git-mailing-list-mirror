Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF7CC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCVQzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCVQy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:54:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95E5257
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:54:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p16so11947568wmq.5
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679504091;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3mKrNXQZM1YB3/aAFx1WA6WV0tHOeOPEnruLgWatXg=;
        b=S35nObwQIk5P4UMSCJiQwThJTnOpwpylf2I7R20RV2MZgUud9dcmf3Flgo2u5CvX0b
         /yAIMMr+p1/R1aBzTJN2bqPg5Sm0BAj2Zvc10cdL1RBENMHbP7C/C5f3/H5ye59W+ASh
         CRSX1829eSyNU5FRn2gDq6gvU5RTDGIEAwUKedw7kxPwu8HhCElPlYfSz7CJlgrmDMtk
         V5NjTdKKHx0Qmhi3vW/TckHslVNRm1Glrqvcxzu/gJ1nPAffOTeIuVQFPFP19K/Gnbpb
         HcLABiEUxghc8Nt5iyZRI6gNDQ4Ora7k2CQuLE64Xpy3wdSFsaoT3dVJh/5WxMlEvneb
         JVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504091;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3mKrNXQZM1YB3/aAFx1WA6WV0tHOeOPEnruLgWatXg=;
        b=USuzuM6HgvMSqcnvA8skttdeUFpw39qheXRzZWw/fLbORrfsaXSStE3b+3oeXZPXDJ
         t332McfvxMe0pzhf9VxKO5x3ysjO3kfmKUqhhxSNdDg/tgV0DemIADH/ZYhIYdZYq2Fg
         Vf/iGcTc52t1mpijC3cxKct6fFd3SrnnLlD96033jb++hu6qGCTIiMj2c1AW7PedsFSi
         RAYLaXdRw7ExmSpS1tbdKwNi78opbiCoCF0bxdVTTJY8KepxSv7Gbca6e9zhRihgLFZz
         EuWQEue7vLV0ihpW8UU/HotXKfQ7DItY7ZevrKURMsR3RLDjIcyt4BeXr23+OFKP1KMq
         z3QA==
X-Gm-Message-State: AO0yUKV2yv27IVTPwdy1vgdKQ4ZG2DuZd2pL/S5HY7XpzIMUNDCyGw6v
        QJRjFxQOBJGg8/q+xUnhvEE=
X-Google-Smtp-Source: AK7set/jaZoLp/n1hxAhGso8LDaFxGLWlUi3xGhaNNr+Aoht7PSpK3CTVH/A83+RNMlIuYeubmActQ==
X-Received: by 2002:a1c:7c18:0:b0:3ed:8bef:6a04 with SMTP id x24-20020a1c7c18000000b003ed8bef6a04mr151510wmc.27.1679504091275;
        Wed, 22 Mar 2023 09:54:51 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003ee5cc90fa3sm2619926wms.8.2023.03.22.09.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:54:50 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f062165f-2e59-67b5-ebff-b029c29dd4d6@dunelm.org.uk>
Date:   Wed, 22 Mar 2023 16:54:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 3/3] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
 <20230320055955.461138-1-alexhenrie24@gmail.com>
 <20230320055955.461138-4-alexhenrie24@gmail.com>
In-Reply-To: <20230320055955.461138-4-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 20/03/2023 05:59, Alex Henrie wrote:
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
> Support setting rebase.rebaseMerges to the nonspecific value "true" for
> users who don't need to or don't want to learn about the difference
> between rebase-cousins and no-rebase-cousins.
> 
> Make --rebase-merges without an argument on the command line override
> any value of rebase.rebaseMerges in the configuration, for consistency
> with other command line flags with optional arguments that have an
> associated config option.

Hurray! Thanks for re-rolling. I've left a couple of comments below, I 
had hoped this would be the final version but I've realized that the way 
you've rearranged the error handling for apply and merge options is not 
a good idea (see below). Apart from that I'm happy.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/config/rebase.txt        | 10 ++++
>   Documentation/git-rebase.txt           |  3 +-
>   builtin/rebase.c                       | 81 ++++++++++++++++++--------
>   t/t3422-rebase-incompatible-options.sh | 17 ++++++
>   t/t3430-rebase-merges.sh               | 34 +++++++++++
>   5 files changed, 121 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index f19bd0e040..afaf6dad99 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -67,3 +67,13 @@ rebase.rescheduleFailedExec::
>   
>   rebase.forkPoint::
>   	If set to false set `--no-fork-point` option by default.
> +
> +rebase.rebaseMerges::
> +	Whether and how to set the `--rebase-merges` option by default. Can
> +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
> +	true or to `no-rebase-cousins` is equivalent to
> +	`--rebase-merges=no-rebase-cousins`, setting to `rebase-cousins` is
> +	equivalent to `--rebase-merges=rebase-cousins`, and setting to false is
> +	equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
> +	command line, with or without an argument, overrides any
> +	`rebase.rebaseMerges` configuration.

Sounds good

> [...]   
> +	if (!strcmp(var, "rebase.rebasemerges")) {
> +		opts->config_rebase_merges = git_parse_maybe_bool(value);
> +		if (opts->config_rebase_merges < 0) {
> +			opts->config_rebase_merges = 1;
> +			parse_rebase_merges_value(opts, value);
> +		} else
> +			opts->rebase_cousins = 0;

The "else" clause should have braces because the "if" cause requires 
them (see Documentation/CodingGuidelines). I don't think it is worth 
re-rolling just for this though.

> [...]   
> +static int parse_opt_rebase_merges(const struct option *opt, const char *arg, int unset)
> +{
> +	struct rebase_options *options = opt->value;
> +
> +	options->rebase_merges = !unset;
> +	options->rebase_cousins = 0;

This makes --rebase-merges without an option override 
rebase.rebaseMerges - good.

 > [...]
> @@ -1514,13 +1542,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				break;
>   
>   		if (i >= 0 || options.type == REBASE_APPLY) {
> -			if (is_merge(&options))
> -				die(_("apply options and merge options "
> -					  "cannot be used together"));

This isn't a new change but having thought about it I'm not sure moving 
this code is a good idea. If the user runs

	git -c rebase.updateRefs=true rebase --whitespace=fix --exec "make test"

then instead of getting an message saying that they cannot use apply and 
merge options together they'll get a message suggesting they pass 
--no-update-refs which wont fix the problem for them.

> -			else if (options.autosquash == -1 && options.config_autosquash == 1)
> +			if (options.autosquash == -1 && options.config_autosquash == 1)
>   				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
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

Best Wishes

Phillip
