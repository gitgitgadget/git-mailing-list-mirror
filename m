Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E7C433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34672207F7
	for <git@archiver.kernel.org>; Sat, 23 May 2020 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwTGCAt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgEWStr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387587AbgEWStq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 14:49:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2725C061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 11:49:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so5748381plo.7
        for <git@vger.kernel.org>; Sat, 23 May 2020 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sOt/nkgwcChelVhyMZMmffRaMzfECzkFvFV7gdFmpmo=;
        b=JwTGCAt/TU9Af+vV+I8AeISdL6uiOiKbQphmJP4/toi8oVaKQWph/Bod3W9bAuFHGK
         fWA8M/AxLayBr3Z3luD96eKnpgabQkT/uMQ32iwym5z4D0panvY1tMNXcNAZnQFtIlKJ
         CbIkWAVxkcOHipcxFVyG9z/XgafJOU4kFKQYETC4jfwfQn/2FYYyAWq+a+oEpf5deFiF
         /ufj9fPGj2a73ec6LVImC3w788wIdfO6rR65KHAkgflc/mm/bUtXZqszsIrI61QMzfr6
         8pJH+ggZcpFeBjjtceTdGfIIiBGMlvdIPHT3cnymUxI/jc8VvziKDhsxufrr0Lgh1QAM
         8/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sOt/nkgwcChelVhyMZMmffRaMzfECzkFvFV7gdFmpmo=;
        b=Al8TwzMg0YWqu6sHg/IK4PF8YztyalRrRNV0PgMQINp7OHCf4fNe/h8eKUJe0NcnNI
         j5CIdyMs8oqIKWiUcsnG6KXefFL/hX9bKX3jDYpG9Lcg4cjUn5YOHSJpe9Rkd0oJQhuB
         6bP47MhzDOghKrubBdb+D59xLNk9oFWHHHB7VNYyoAEs+4BCL9x2Qvb20yyEKdW5Fsky
         +8ZCK8lNBLy3BaFP/E8RDzUl8WvVKhta2//h6c0F4rmL5YXMuQm/XTovnAYrW1yMAuBp
         3TU0dRspoeciP3uSzXXQgozpZzhap7B1HOxJCg+a3wlr99yoxhGtkiSYzKCMQeZdlZGM
         JxOg==
X-Gm-Message-State: AOAM532VcHSEPQyFFq21PgjC+lleBRfmzflu/RWkYT5YbWwenPnrr2Er
        EnGVTNcuhfhWYG6Wm56Ngvg=
X-Google-Smtp-Source: ABdhPJyoY3txD18ExyrFBmOEiov961gOQ1H3znib+qB1sQSvRc0kTqNR6p/nFFLwbMFHiGZi8ij+eA==
X-Received: by 2002:a17:902:328:: with SMTP id 37mr21881087pld.35.1590259786029;
        Sat, 23 May 2020 11:49:46 -0700 (PDT)
Received: from [192.168.43.191] ([106.198.14.49])
        by smtp.gmail.com with ESMTPSA id gt10sm9454054pjb.30.2020.05.23.11.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 11:49:45 -0700 (PDT)
Subject: Re: [PATCH v4] submodule: port subcommand 'set-branch' from shell to
 C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, liu.denton@gmail.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <20200523163929.7040-1-shouryashukla.oo@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
Date:   Sun, 24 May 2020 00:19:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

I believe you missed Danh's v3 comments[1]. I'm mentioning them inline 
with some additional comments.

On 23-05-2020 22:09, Shourya Shukla wrote:
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f50745a03f..7e844e8971 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2284,6 +2284,50 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
>   	return 0;
>   }
>   
> +static int module_set_branch(int argc, const char **argv, const char *prefix)
> +{
> +	/*
> +	 * We accept the `quiet` option for uniformity across subcommands,
> +	 * though there is nothing to make less verbose in this subcommand.
> +	 */
> +	int quiet = 0, opt_default = 0, ret;
> +	const char *opt_branch = NULL;
> +	const char *path;
> +	char *config_name;
> +
> +	struct option options[] = {
> +		OPT__QUIET(&quiet,
> +			N_("suppress output for setting default tracking branch")),

As '--quiet' in 'set-branch' is a no-op and is being accepted only for 
uniformity, I think it makes sense to use OPT_NOOP_NOARG instead of 
OPT__QUIET for specifying it, as suggested by Danh.

Also, the description "suppress output for setting default tracking 
branch" doesn't seem to be valid anymore as we don't print anything when 
set-branch succeeds.

> +		OPT_BOOL(0, "default", &opt_default,
> +			N_("set the default tracking branch to master")),
> +		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
> +			N_("set the default tracking branch")),
> +		OPT_END()
> +	};
> +	const char *const usage[] = {
> +		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
> +		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
> +		NULL
> +	};
> +

I also agree with the Danh here that '--quiet' could be removed from 
usage. There's no point in mentioning '--quiet' in the usage when it has 
no effect.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 39ebdf25b5..8c56191f77 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -750,33 +750,7 @@ cmd_set_branch() {
>   		shift
>   	done
>   
> -	if test $# -ne 1
> -	then
> -		usage
> -	fi
> -
> -	# we can't use `git submodule--helper name` here because internally, it
> -	# hashes the path so a trailing slash could lead to an unintentional no match
> -	name="$(git submodule--helper list "$1" | cut -f2)"
> -	if test -z "$name"
> -	then
> -		exit 1
> -	fi
> -
> -	test -n "$branch"; has_branch=$?
> -	test "$unset_branch" = true; has_unset_branch=$?
> -
> -	if test $((!$has_branch != !$has_unset_branch)) -eq 0
> -	then
> -		usage
> -	fi
> -
> -	if test $has_branch -eq 0
> -	then
> -		git submodule--helper config submodule."$name".branch "$branch"
> -	else
> -		git submodule--helper config --unset submodule."$name".branch
> -	fi
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"
>   }
>

Danh questioned whether '$branch' needs to be quoted here. I too think 
it needs to be quoted unless I'm missing something.


---
Footnotes:
[1]: 
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2005230012090.56@tvgsbejvaqbjf.bet/T/#maf26182b084087ed08a2a72d3da2ee2026b1618e

Thanks,
Sivaraam
