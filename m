Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbiCWQEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiCWQEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:04:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07097B577
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:02:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so5673582wmj.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iuuiOkEY4+crb35A1ob5gBzT7IeaVUHdmBF+vUdkus4=;
        b=BDdncv12eAi5+uSOIh7jdiIPTzHAdaGHHvRQl5ajpPaBVHyR7tOF30t9OtVayUKnVN
         tu0+azn6gC5oAHMWNYFCj74e6tb4/FKvVSH8dZ3V9ClW5GsB6simEhlYPH/SX0sAn9ku
         bGUwP3D3BPK5HcGKnTxFsGCPSIFXVfgNdZMCfIMlbHuMPBAVph9CIG1fF6O9xrAuWSUw
         bo68CKrc6DtzTd5XPphxr5kggTU7J1Ox2u/dpcqEgw+1RrxJTEVpBEFSxEliClfa0JsE
         vV0Ezg8updR/jNdeo9R7zyri0OKR55vGb4wFfGEMHVlYRcnF5pARTuxpBpad8p3VONcO
         y0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iuuiOkEY4+crb35A1ob5gBzT7IeaVUHdmBF+vUdkus4=;
        b=RTijnsKLR0XIi4LDU1Kpb3hKAPUynko3J8ors+XRgC44RUJj7CgoE/2VPxESvWe2et
         AUEYB1dq1TIVGoqFKLowkt88KRZ+Rg6FLMvQlXQyPGIHtMDJ3aaE730pM9+ZUhU2lyT5
         jdlooUI/PHBJJAeTHtzykUpH2sfXG1c2Z169FpqDmIrzJrK6D7QSZRtpvTQIlGy/aTYZ
         kQqCotdnFDJ5TrENydtvbq9Hjp1ONnX7fIM3L067PZs6xY7Rx+vnLXcEU0g2sUT8kK61
         oE2Fmhqy9+gl10W5gqry8p+6iOLwj6wG6J38vhHnZ0W4T/t9/2kmXimh0ftOGMeQF+Z1
         Xe3g==
X-Gm-Message-State: AOAM5310bP8Ev1bZgkEoLNgoQGjPK4ppPjAJZovjbYwGxpPHhmBV5VvN
        U9Q9bCn1NhV/SRxOC1k4vNo=
X-Google-Smtp-Source: ABdhPJy+ETVXnaO67mQLpYsF0OqCDPrz1icfuId+pqef/HJL0mMTjWixG8C6pnrYhw0QWm4iUyg6xA==
X-Received: by 2002:a05:600c:4f44:b0:38c:b270:f9a0 with SMTP id m4-20020a05600c4f4400b0038cb270f9a0mr624878wmq.16.1648051349328;
        Wed, 23 Mar 2022 09:02:29 -0700 (PDT)
Received: from [192.168.1.201] (203.2.7.51.dyn.plus.net. [51.7.2.203])
        by smtp.googlemail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm312154wrd.31.2022.03.23.09.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:02:29 -0700 (PDT)
Message-ID: <3f8c28c6-5f99-e9ac-e356-48182e269b5c@gmail.com>
Date:   Wed, 23 Mar 2022 16:02:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] reset: deprecate '--refresh', leaving only
 '--no-refresh'
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <dbb63c4caa83cc764535a739d20736b706ee44a5.1647894889.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <dbb63c4caa83cc764535a739d20736b706ee44a5.1647894889.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 21/03/2022 20:34, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> The explicit '--refresh' option was needed in the past when '--quiet',
> 'reset.quiet', and/or 'reset.refresh' disabled the index refresh in 'reset
> --mixed'. Those options have since either been deprecated or made to always
> refresh the index by default, leaving only '--[no-]refresh' determining
> whether the index is refreshed or not.
> 
> Because there is nothing other than '--no-refresh' to disable index refresh,
> we do not need a '--refresh' option to counteract some other refresh
> disabling.

'--refresh' could be used to countermand a previous '--no-refresh' 
(typically when using an alias that includes '--no-refresh'). Usually we 
have '--foo' even when it is enabled by default e.g. 'commit --verify'. 
I think the code below does actually support '--refresh' as 
parse_options() is smart enough to recognize option names beginning with 
'--no-' and creates an inverse option by removing the prefix rather than 
adding '--no-' as it normally does.

> To ensure users don't use what is effectively a no-op, remove '--refresh'
> from the set of 'reset' options, as well as its usage in 'git stash'.
> 
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>   Documentation/git-reset.txt | 3 +--
>   builtin/reset.c             | 6 +++---
>   builtin/stash.c             | 4 ++--
>   t/t7102-reset.sh            | 5 ++---
>   4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index df167eaa766..ba8dece0c03 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -107,9 +107,8 @@ OPTIONS
>   --quiet::
>   	Be quiet, only report errors.
>   
> ---refresh::
>   --no-refresh::
> -	Proactively refresh the index after a mixed reset. Enabled by default.
> +	Disable refreshing the index after a mixed reset.
>   
>   --pathspec-from-file=<file>::
>   	Pathspec is passed in `<file>` instead of commandline args. If
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 54324217f93..d9427abc483 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -392,7 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
>   int cmd_reset(int argc, const char **argv, const char *prefix)
>   {
>   	int reset_type = NONE, update_ref_status = 0, quiet = 0;
> -	int refresh = -1;
> +	int refresh = 1;
>   	int patch_mode = 0, pathspec_file_nul = 0, unborn;
>   	const char *rev, *pathspec_from_file = NULL;
>   	struct object_id oid;
> @@ -400,8 +400,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   	int intent_to_add = 0;
>   	const struct option options[] = {
>   		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> -		OPT_BOOL(0, "refresh", &refresh,
> -				N_("skip refreshing the index after reset")),
> +		OPT_SET_INT(0, "no-refresh", &refresh,
> +				N_("skip refreshing the index after reset"), 0),

I'm confused why we need to change the option type here - am I missing 
something?


Best Wishes

Phillip
