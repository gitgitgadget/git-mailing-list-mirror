Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F0C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 09:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiDCJ3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiDCJ3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 05:29:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01567252BE
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 02:27:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d29so4141749wra.10
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jhQVDKnHg1tC9Fg1yarBt2aRfbhukIU6nkwCPZ5ZprA=;
        b=ToGLSXjcaPQ1GthSqXilhkdC7aSg+oralfEq07y+SF5HQ7CaFx4u4rtnsATbEaOcv3
         cu3b/mVJOns5zHxAxFS1aprRj1EAO5v+OMQpNArH3xM4qCG8BEe18r5fcNn6w5k8Z1oh
         PPYhwGriFbZEiIQlZxdAzYaKI8fRHlcTY7SLYqwEhyVWdsrGGF6XKlQjqaT1ZkuD6Yxi
         C7l9opBXIH7vrm7yADUv2GEbUyGCd720bF2oU4yeAgdSv5StF+D9og7xsHKOiWTtEsw5
         tHtqhGi2jCEKyHyiVoTEetoBf8ubqP5drZzRm3kmE+j6NAPTKY5CO8zWUgd77r6OwFEh
         QjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jhQVDKnHg1tC9Fg1yarBt2aRfbhukIU6nkwCPZ5ZprA=;
        b=o034IXQr+1bsWc5jVubSgmmv0f/Tq0WDfj8CcIEd9WIr+eSq9z2nClDxMUnASImHeU
         mG+2z0nJIrcJ+jF8amXzslwNouSfQTYpxBRvUGiK7PuIjPR6jBdYqZIO4iTpyZ0vYjxc
         +id3NIN+5HslVGayG/0aV7a8vOG0blsgEIZHJ4zLGrEV+Gc+ShlpVfEo2UzvY3FKePc8
         rEvJVk7x0+sLznNYKEGyeyvPr/3G+1eRDDfrBov6rJ6L1FD/fdwV3YfaZ3lNAH65jbbU
         NMDUShBj/dblhoyjl28mBhWIrcjVAQZvdHKAJ2WnliswsYgbxLnYvG2AWk5VgYbek3oQ
         PMpg==
X-Gm-Message-State: AOAM532R7UJ2WRBynCnTPGoSdExAzGyNK3BugwAqJD4gzcQvaj/ctFsq
        AhvYQV7kWEaOLetaTFs7D+QOToKFHkY=
X-Google-Smtp-Source: ABdhPJyGtTaIDXXpOQ6Nl9UKCvRKPz0L4gaz0qACne3ADn9bzzy7RgG7n94sa2B9cbcZYRvSYJdkAw==
X-Received: by 2002:adf:ec04:0:b0:205:8537:af5c with SMTP id x4-20020adfec04000000b002058537af5cmr12998237wrn.357.1648978036447;
        Sun, 03 Apr 2022 02:27:16 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm6237630wrt.115.2022.04.03.02.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 02:27:15 -0700 (PDT)
Message-ID: <2e75adb7-e52d-62a9-0304-4076816f82e1@gmail.com>
Date:   Sun, 3 Apr 2022 10:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 14/27] revisions API users: use release_revisions()
 with UNLEAK()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-14.27-ddc7402b054-20220402T102002Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v5-14.27-ddc7402b054-20220402T102002Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

[continuing with v5 from where I left off with v4]

On 02/04/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
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

I'm a bit confused by this, the previous commit argued in favor of 
removing UNLEAK() so would could see the leaks and fix them, this is 
saying we should hide the leaks.

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
