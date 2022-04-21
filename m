Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D6C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiDUQdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiDUQcb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 12:32:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23E24B1CE
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 09:26:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x18so7474260wrc.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bR5cyTW0ehdjC274BWnZFgf15WMLFpvVhMhn0f21F4Y=;
        b=QKdXWQXwFLWvpOoApwH1+2wGMnvDg5yEjdgW6ilTHrKMIA/oVHj9pUzYzBrsDJS+ca
         hrT9WINSy8RnF530nUJGCE7Pfyf2WV7vPsgwl4fVJVsSklmPpwGOxXnVJzeV/2zafZOO
         05YKgm1SHkI6Jc5pxMKlcU0IGCzrXcLxJmesOkwA4zux7GrcNVPkCIWKtU5mcBm8/hiY
         uwBHXLxE233ndz5jCCk+uIwy3DuZfPXCpTVUzWa5YqIyTkwbBUFvQ1CrGNqStGyJCAIs
         hPIbleuvMxywvd8W6i+vNfYn6SEoP4HbNcXtGT4Jx1aTGVlT1K5C4CO1IaZxsZKzTC03
         mIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bR5cyTW0ehdjC274BWnZFgf15WMLFpvVhMhn0f21F4Y=;
        b=PiSYe7SR3vj+9T0jDFo3VXeuDdaEBnaGn5iCYixUsJI9vBUeQXMdR7xyhuGONWvfDe
         ZmvfxyM5h9gpsS0h4rPi+YqNDpvTgwO2kLXfMCxVPYHcEuORkei7D8KM4zbFYjY22ZRx
         50T6QzuGx9MeysauCsI8E2L50GY4yN/m0ZAGzETDcPq3h6pVue8Z+0RZMVhhIf8Lb0jP
         9+4Aoj54x0tHEk1Nlvwz0fgPviK2MjN8pYoUi/hGGM2pUa0tK2r8qKeRjlHDk4xaw1De
         NgppwWkUmEAdAvxS5ptCic7fTANFIturS4bpPU5mi2ynq4uO+NxlWiYmqaOOcvytLyBK
         oOQA==
X-Gm-Message-State: AOAM533Qh+tgF7LOx86KSyioEvSB1pwEqFPDEgvJf1yLinA3NbfYIcgp
        pnTEu61dIZYICdhPZqurZrU=
X-Google-Smtp-Source: ABdhPJxtUx6bXMaqjQg5IwUNeJoPJPV+O8grYUnB/Tejl51IMA8Jbl/gF5F9MVw2iXf9D2R0EqqSGQ==
X-Received: by 2002:adf:ea4d:0:b0:20a:9051:7435 with SMTP id j13-20020adfea4d000000b0020a90517435mr430011wrn.200.1650558395616;
        Thu, 21 Apr 2022 09:26:35 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c320900b0038f0894d80csm2314476wmp.7.2022.04.21.09.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:26:35 -0700 (PDT)
Message-ID: <db2dfab3-205e-036e-e9b5-f64bcf3650f6@gmail.com>
Date:   Thu, 21 Apr 2022 17:26:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] CI: select CC based on CC_PACKAGE (again)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/04/2022 14:03, Ævar Arnfjörð Bjarmason wrote:
> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
> "$jobname" to select packages & config, 2021-11-23).
> 
> In that commit I changed CC=gcc from CC=gcc-9, but on OSX the "gcc" in
> $PATH points to clang, we need to use gcc-9 instead. Likewise for the
> linux-gcc job CC=gcc-8 was changed to the implicit CC=gcc, which would
> select GCC 9.4.0 instead of GCC 8.4.0.
> 
> Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
> job, 2021-11-23) when the "linux-TEST-vars" job was split off from
> "linux-gcc" the "cc_package: gcc-8" line was copied along with
> it.
> 
> That wasn't a bug per-se, as that "make test" would have run under GCC
> 8 before the split into two jobs, but the point of selecting different
> compiler for these jobs is to get better coverage, and to narrow down
> any issues with a given compiler to the job that runs it. Since the
> "linux-TEST-vars" job is already special in other ways (in running
> with various GIT_TEST_* variables), and we've got the "linux-gcc" job
> covering gcc-8 let's have it used the default system compiler instead.
> 
> Reported-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> Range-diff:
> 1:  94abb826627 < -:  ----------- CI: have osx-gcc use gcc, not clang
> -:  ----------- > 1:  d89ad4d5b7c CI: select CC based on CC_PACKAGE (again)
> 
> The range-diff is against a relevant patch in v4 of a larger CI series
> of mine[1]. This fix is independent of that, and on top of master. See
> [2] for the original fix and discussion.
> 
> As noted in the updated commit message not only the OSX jobs were
> affected, but also the linux-gcc job. This fixes both, along with a
> small fix to the related linux-TEST-vars recipe.
> 
> 1. https://lore.kernel.org/git/cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com/
> 2. https://lore.kernel.org/git/patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com/
> 
>   .github/workflows/main.yml | 1 -
>   ci/lib.sh                  | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index c35200defb9..f12819a00d7 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -236,7 +236,6 @@ jobs:
>             - jobname: linux-TEST-vars
>               cc: gcc
>               os: ubuntu
> -            cc_package: gcc-8
>               pool: ubuntu-latest
>             - jobname: osx-clang
>               cc: clang
> diff --git a/ci/lib.sh b/ci/lib.sh
> index cbc2f8f1caa..44007dcf93b 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -122,7 +122,7 @@ then
>   	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
>   	CI_REPO_SLUG="$GITHUB_REPOSITORY"
>   	CI_JOB_ID="$GITHUB_RUN_ID"
> -	CC="${CC:-gcc}"
> +	CC="${CC:-${CC_PACKAGE:-gcc}}"

CC is set in .github/workflows/main.yaml for the ubuntu and macos jobs 
so I think they will not fallback to using CC_PACKAGE and therefore not 
pick up the correct compiler.

Best Wishes

Phillip

>   	DONT_SKIP_TAGS=t
>   
>   	cache_dir="$HOME/none"

