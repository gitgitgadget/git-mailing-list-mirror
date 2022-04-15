Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F831C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354209AbiDOOBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiDOOBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 10:01:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4CBE9F5
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:58:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so7793457wmb.4
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JlnwVFkZklMKV6qcKFBdgTSIyZNJLAFAKqrTI8+D4qU=;
        b=dKywQ/EpGHz7VXsZXK8z5UZUBiV3dox9jK81rG2UnPz6EyKnUyvY5gFi52JwwnDfKx
         DFFgzkHmDgkrYzm4DDLWmZ82aNDtoE61FSlm+wYkbQ0dOj/dBNhrjlxj2ZSA+7H7pv44
         qhYghxQcawglKqxJiCAGnwFvFABRKmfCxE64EALvwC0W5KDTwUbPh42JV/nRgoCaJApS
         HP1CB3+uRjb/pPRru7m3C/RdKSJyih1PvG68URKspJm71+jyo8LG3ULWiP/dZRn6ayRw
         mhVELztm1w+r4sVKgk0AVboMZ3+UYMs/i/UV5ZsIHx5fou37T0iJ6va+jFoF4QF4pmP6
         okvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JlnwVFkZklMKV6qcKFBdgTSIyZNJLAFAKqrTI8+D4qU=;
        b=yldjSDNoMiE9YPGvA8Hd1P2BhPleiVbbbCh3n5BtK3b4UUxoP10gmKPlLfFRpOr1As
         gkPieUEY66S184Yo+48f2MlYbNM9IZzneJuBdC5wLsxg3I8BdUrrR8WpMozFbgIXTu1v
         DW2CbrxmP4RpWe246P3TeWwdXP5JxVYcj4dBjIlbEgH31npa4pm6vRM+4g12p3uS7w6T
         4PYF8uP5AnLd6krAH8AST9lujhz1DJUXIe3olYxwVDKt2GdPJ/nD0z7EiB44/NdsweI4
         A8hJq/B5PFK1NexW4y4tz8tnOcfovKu5xgAI+zOg3d7r7GT3FVsE8sxrddEPmKdx5LiV
         Sw/w==
X-Gm-Message-State: AOAM532Y5FAlCHtMwLf8TsJhWOUFU0OcPscGAid5eJr6G/l73UUhoukG
        t/ELLFQQpd36PGQ+DToHy0E=
X-Google-Smtp-Source: ABdhPJzLP8pK92c8p4/Ip3qrGXKg2rguFnoWlQYLwfXLp7z6xxzhDnGPjsooa/kG/Cnawn3w9Oj0tA==
X-Received: by 2002:a05:600c:3b93:b0:38e:b82a:9abe with SMTP id n19-20020a05600c3b9300b0038eb82a9abemr3416449wms.108.1650031119027;
        Fri, 15 Apr 2022 06:58:39 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b0038eca3cdbb3sm5096681wmr.13.2022.04.15.06.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 06:58:38 -0700 (PDT)
Message-ID: <2cc2d026-1496-1ed9-838b-6fdf8cfba285@gmail.com>
Date:   Fri, 15 Apr 2022 14:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 14/27] revisions API users: use release_revisions()
 with UNLEAK()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
 <patch-v6-14.27-31ce58da43d-20220413T195935Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v6-14.27-31ce58da43d-20220413T195935Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 13/04/2022 21:01, Ævar Arnfjörð Bjarmason wrote:
> Use a release_revisions() with those "struct rev_list" users which
> already "UNLEAK" the struct. It may seem odd to simultaneously attempt
> to free() memory, but also to explicitly ignore whether we have memory
> leaks in the same.
> 
> As explained in preceding commits this is being done to use the
> built-in commands as a guinea pig for whether the release_revisions()
> function works as expected, we'd like to test e.g. whether we segfault
> as we change it. In subsequent commits we'll then remove these
> UNLEAK() as the function is made to free the memory that caused us to
> add them in the first place.

It would have been nice to reword this to avoid the confusion that 
prompted my comments on the previous version. Saying "As explained in 
the preceding commits" is confusing when those commits remove UNLEAK() 
and this commit leaves it in. I now understand why you are leaving 
UNLEAK() here thanks to your explanation on the previous series and I 
think it makes sense to do so but I don't think this message does a good 
job of explaining it.

The rest of the series looks good

Best Wishes

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/diff-index.c | 4 +++-
>   builtin/diff.c       | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index 5fd23ab5b6c..3a83183c312 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -71,5 +71,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>   	}
>   	result = run_diff_index(&rev, option);
>   	UNLEAK(rev);
> -	return diff_result_code(&rev.diffopt, result);
> +	result = diff_result_code(&rev.diffopt, result);
> +	release_revisions(&rev);
> +	return result;
>   }
> diff --git a/builtin/diff.c b/builtin/diff.c
> index bb7fafca618..dd48336da56 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -595,6 +595,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>   	if (1 < rev.diffopt.skip_stat_unmatch)
>   		refresh_index_quietly();
>   	UNLEAK(rev);
> +	release_revisions(&rev);
>   	UNLEAK(ent);
>   	UNLEAK(blob);
>   	return result;
