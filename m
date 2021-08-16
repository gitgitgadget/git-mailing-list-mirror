Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F6FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CC060F4B
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhHPQHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHPQHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:07:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B83AC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 09:06:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id n11so14763271qkk.1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qcluSLUYP0sy5UJIqjebOCPhXp7E1hKV14nggrfo8rI=;
        b=phck8pBnGSPmv+rNjUuEmTKAGpsDYX6OSA3iESLpZ0gMTFvdMqgpx55TgS9cWWyiFN
         OtzMGkUztyauurDdW/MmC1y+iHriiEyuc2cYVbptRA8PDYHBCG1Mm2wgwKGeNdxpTBCr
         WW0wU+hdPzQNO8IjoxN2jGc5fOxXafr3zpkh9wbgryy6/CSfx52Tkm3XZI8jE/OvC672
         haX9C01GnvuzNV7Mm6os0BM6Z4Nq3aNw0/pJy/xJId4A7jXTIvXCMEnrjYr6MqHE+mXX
         4WdDwVdHCLIuL0tQcAFpHwboy82RxQi6/6Jvbv0pDojQc0zMMctMEqJz8RUzaXWk3Pj0
         32NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qcluSLUYP0sy5UJIqjebOCPhXp7E1hKV14nggrfo8rI=;
        b=ZophD5nhJw5kWaa0sxxYvC1m1asC5/DnZlz+NM1Ck+AnwCEmfxfsZieevmXH+w9C66
         VVQUJYGpsstN4eyTrK23qtvhPWXC3hoxIr4zo8UzAUQYUFt6MQ4/yj+KOlEs7isht8NE
         LHbsJ07wG7x2dtUuO6rul5DfZF3H9aARncs8WIHpio2DIsZMjSyurkR/qep58sTD8v9a
         BDXltFkUTVw7QLYkSmT90/uvh1/czEhBvxNWLVBusBXIeFThdyFA0Zwo8avadWLtwF3u
         X9HZ9RqtXG8nxqUH1/FTtZpr/DTguPC+2VppjnYNN4AkwKJusaNvnKYVyZ3pFE/kr50m
         CQIg==
X-Gm-Message-State: AOAM533svOpCP+mWjn3HT5OwzwkR8PUStqCL3/nl3dYYPMaDZbgUTQRL
        yOlay5D8XeZ2vp0LL8ns/kqaK8FixR1O8A==
X-Google-Smtp-Source: ABdhPJz4iWmgpnt9h7g7cwQKespnOPpC0oDpz50+rs99O5NFO6JK0v+ORCaBprCs5l4WSF+P1lvHBg==
X-Received: by 2002:a37:2cc4:: with SMTP id s187mr16435761qkh.407.1629130007956;
        Mon, 16 Aug 2021 09:06:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2591:e785:5de6:53be? ([2600:1700:e72:80a0:2591:e785:5de6:53be])
        by smtp.gmail.com with ESMTPSA id s69sm6374490qka.102.2021.08.16.09.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:06:47 -0700 (PDT)
Subject: Re: [PATCH] ci: add job for gcc-4.8 to GitHub Actions
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
References: <20210816045750.36499-1-carenas@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
Date:   Mon, 16 Aug 2021 12:06:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210816045750.36499-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/2021 12:57 AM, Carlo Marcelo Arenas Belón wrote:
> unlike the other jobs; using an older ubuntu base image that provides
> that compiler as an option.
> 
> note the obsoleted travis job used an image of the OS that is EOL and
> therefore not available, but the compiler used will be the same, and
> more importantly will fail in the same (C89 compatibility) issues.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> based on top of my tip for cb/reftable-fixes, but applies cleanly all
> the way to maint.
> 
> a succesful run can be seen in:
> 
>   https://github.com/carenas/git/runs/3336674183
> 
> it adds 2m to the current setup, but gcc 4.8 is hard to find in modern
> developer workstations (or even non EOL enterprise systems)

Forgive me, I probably missed a discussion about this
somewhere else on the list, but...

Could you describe why we want GCC 4.8 in our CI? Is that a
compiler version that we officially support? What kind of
syntax triggers a problem on 4.8 versus latest?

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 73856bafc9..0f211173fc 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -297,6 +297,9 @@ jobs:
>            - jobname: linux-gcc-default
>              cc: gcc
>              pool: ubuntu-latest
> +          - jobname: linux-gcc-4.8
> +            cc: gcc-4.8
> +            pool: ubuntu-18.04

Makes sense.

>      env:
>        CC: ${{matrix.vector.cc}}
>        jobname: ${{matrix.vector.jobname}}
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 67852d0d37..950bc39129 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -72,10 +72,14 @@ Documentation)
>  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>  	sudo gem install --version 1.5.8 asciidoctor
>  	;;
> -linux-gcc-default|linux-gcc-4.8)
> +linux-gcc-default)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
>  	;;
> +linux-gcc-4.8)
> +	sudo apt-get -q update
> +	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS gcc-4.8
> +	;;

Interesting that we already had a case here. Is there interesting
history about this prior-existing case that might be illuminating
to the current need?

Thanks,
-Stolee
