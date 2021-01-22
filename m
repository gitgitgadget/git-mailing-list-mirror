Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A46C4332E
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E839C23B01
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbhAVTUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbhAVTNk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:13:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B1C06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:12:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m1so5397277wrq.12
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0IzelV122xQ1gzt+CZcs0p0WwZG3XSUvzkj135i3wZM=;
        b=o3myZ1lGFteb9At73XVp61shwqhy1yXPnx7NUlPGfFEnPWjC1JJTgFvfWZhBw9TO89
         X7pmiBgRe1rwDjPG/vZsGR/axL7hqxVFO3s3Pb1XCnMBrDpXsec0Zh6WbxvcxR+as0Q1
         wX94h+PtZBPoQ9iWx/nECvcwgNGFKyeTkLJAGchvoUlrhjPB1MhkisMmcVFbagwITVXS
         RssBKCwLj9/QIVqm4+jUWYIjc1bULHp3qA9wjqYzrOdIBD5B/i8UqiwtXrLV56BZvE7e
         +2ubi7rk2w/kCHF78400NKJxj2u1/jHckMImQBGJsxOSG6xvGszGN53qtt9HNR7gBvPG
         CmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0IzelV122xQ1gzt+CZcs0p0WwZG3XSUvzkj135i3wZM=;
        b=DbEls25DX3FVIAOAfEsTdBqh7mvrXLeXev6SFsrktHx4NUdsSYYXG5D/Z8wSxq+779
         WTglPFo7g7XjtzNncWsB7VdRHQH6QfoLfTonSENJ5HBT8Cb4385ucU+QSC4O0O5JBLge
         olD1aiQX6zjdIbzVXThrYUqiu44b2I7pRy/EwU4te08h7Sd8o5K+O2MGEf9H/miaRJyS
         KXWtveC1Of9EHIXJCKQiDx7/Eli6i4Ofju8m672lTTuJ+gNu7iiTLstw8YQZYe64g8Yn
         7MGIWrwVkHsXACq5yYIpVxPzWhX/AO0TQFQJYmUJ754DHlA/ZhjQ4Pa6dIBQnHAyAdeq
         wtyA==
X-Gm-Message-State: AOAM530pprVmN3I58eSPlGYGt/FCxj00PjsX/2DGcoAWUmkz3U1RmXI0
        evkOVd6biS/o6ESO46D4gsE=
X-Google-Smtp-Source: ABdhPJwXJCnzcceTk7tMa8ylbwzBd6U8LwUzezLMbYl2G8pDPU7MJl48nwgwAxzsFzaMu81KbOfgpw==
X-Received: by 2002:adf:eec6:: with SMTP id a6mr5831913wrp.239.1611342776524;
        Fri, 22 Jan 2021 11:12:56 -0800 (PST)
Received: from [192.168.1.201] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.googlemail.com with ESMTPSA id u14sm11793467wml.19.2021.01.22.11.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 11:12:55 -0800 (PST)
Subject: Re: [PATCH 1/3] range-diff: refactor check for commit range
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
 <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0ce0953a-92b2-2ce6-1e13-6f6240933ce1@gmail.com>
Date:   Fri, 22 Jan 2021 19:12:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 21/01/2021 22:20, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Currently, when called with exactly two arguments, we test for a literal
> `..` in each of the two.
> 
> However, `<commit>^!` is a perfectly valid commit range, equivalent to
> `<commit>^..<commit>` according to the `SPECIFYING RANGES` section of
> gitrevisions[7].
> 
> In preparation for allowing more sophisticated ways to specify commit
> ranges, let's refactor the conditional into its own function.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   builtin/range-diff.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 24c4162f744..551d3e689cb 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -11,6 +11,11 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
>   NULL
>   };
>   
> +static int is_range(const char *range)
> +{
> +	return !!strstr(range, "..");
> +}

If the user wrongly passes two arguments referring to single commits 
with `:/<text>` or `@{/<text>}` where text contains ".." this will give 
a false positive.

Best Wishes

Phillip

>   int cmd_range_diff(int argc, const char **argv, const char *prefix)
>   {
>   	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
> @@ -46,12 +51,12 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>   		diffopt.use_color = 1;
>   
>   	if (argc == 2) {
> -		if (!strstr(argv[0], ".."))
> -			die(_("no .. in range: '%s'"), argv[0]);
> +		if (!is_range(argv[0]))
> +			die(_("not a commit range: '%s'"), argv[0]);
>   		strbuf_addstr(&range1, argv[0]);
>   
> -		if (!strstr(argv[1], ".."))
> -			die(_("no .. in range: '%s'"), argv[1]);
> +		if (!is_range(argv[1]))
> +			die(_("not a commit range: '%s'"), argv[1]);
>   		strbuf_addstr(&range2, argv[1]);
>   	} else if (argc == 3) {
>   		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
> 

