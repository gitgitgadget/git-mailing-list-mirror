Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75325C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 15:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiLSPEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiLSPEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 10:04:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D105B7C4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:04:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so6631546wml.4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+1VC/D/bJA0oqPR+/yHD1fgIeYL0mDAkH5dFfPTOK0=;
        b=Dh+9pFC6VWVaDhGlyOAlE4EA9B00cpYUmK4N3z2B5bmN4Qqhs3YxFXTcu9H1TWspYU
         lKt9rM20ONYgT7f3awhdl04eQYuf43Rp6oGi/pWPKkiuC2cNUVFLhHnHZ9o3vFrDe2LK
         9qfXZrG9fcG2gBY4lSVhiMc0juVGvD5zAIH3S1sc/YPUIPHie8h9GWM2F9bnyac2nF1K
         rdpWJRVEhYhp2GbSTW5zLV5nUTmJcqK125VCo5yHtPbGoPDkblKH91kOqha3Hq+np7N2
         q5L5c2zTcRkj5heNLGlJyJLi5D9+FYBsyrSng7so1iNAPK6CPnRSrS0/UYoaLmWkI1Wv
         f2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+1VC/D/bJA0oqPR+/yHD1fgIeYL0mDAkH5dFfPTOK0=;
        b=d4ZfI2Oo5zYYWVxCte+3qNx8TZk21Xo42VuiMBafrTqs4mH9eY5V8kN6NvQt1SChkZ
         edJ/uNlbsFY0HsDYu94kwUR58C3nKKZ5V1i0G8v0NDgRyPHPPax5Dpp6sA+cEEWUj8Dz
         Jlksi82vaB1EZOwo0fHT3OlDyzyKTrXsGuPxAqKoZNVJv4IXqfX1qymk2OTSJFJJCOZW
         UWSh0Ibu+jFZuy8Zke2YXyN7Ow0dWZ1r/Y203CHMIGz+QpmAt35WQaQ1/nOCmOiyxpr1
         jG98zspLFVbWEMzKGTRm3NtSrXFVJxcq/fttGPNGyy+Hbc+9s/05kaHtE0PUyP8qlXAK
         Bocw==
X-Gm-Message-State: ANoB5pntgMsh87yKsSI0VCYpGQBD7JOx0GFyZtRMTeunq34eqMsQwJ+7
        reGnX/9+D6LfjwU18Y8SrRQ=
X-Google-Smtp-Source: AA0mqf7YlRdVJMjJWz/kJrybJBuD5n/FbrEg9kLxcIEwKSVUlB/AmRZl9JVYFgPVbAoyyZWGpm3vtw==
X-Received: by 2002:a05:600c:1c81:b0:3d1:e907:17cb with SMTP id k1-20020a05600c1c8100b003d1e90717cbmr32105618wms.1.1671462269992;
        Mon, 19 Dec 2022 07:04:29 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003d070e45574sm12742431wmb.11.2022.12.19.07.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:04:29 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1e701a54-0356-9f55-ab53-9d8bfdd93e55@dunelm.org.uk>
Date:   Mon, 19 Dec 2022 15:04:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci: only run win+VS build & tests in Git for Windows'
 fork
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, me@ttaylorr.com,
        phillip.wood123@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
In-Reply-To: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 19/12/2022 14:50, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...] 
> This developer's initial hope was that it would be enough to fix win+VS
> failures and provide the changes to be squashed into contributors'
> patches, and that it would be worth the benefit of attracting
> Windows-based developers' contributions.
> 
> Neither of these hopes have panned out.

I'm sad that those hopes have not panned out, but I think this patch is 
probably the best way forward. It is certainly the lowest effort for 
non-windows developers and the improvement it CI minutes is very welcome.

Best Wishes

Phillip

> To lower the frustration, and incidentally benefit from using way less
> build minutes, let's just not run the win+VS jobs by default, which
> appears to be the consensus of the mail thread leading up to
> https://lore.kernel.org/git/xmqqk0311blt.fsf@gitster.g/
> 
> Since the Git for Windows project still needs to at least try to attract
> more of said Windows-based developers, let's keep the jobs, but disable
> them everywhere except in Git for Windows' fork. This will help because
> Git for Windows' branch thicket is "continuously rebased" via automation
> to the `shears/maint`, `shears/main`, `shears/next` and `shears/seen`
> branches at https://github.com/git-for-windows/git. That way, the Git
> for Windows project will still be notified early on about potential
> breakages, but the Git project won't be burdened with fixing them
> anymore, which seems to be the best compromise we can get on this issue.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      Explicitly make CMake-based CI failures the responsibility of "Windows
>      folks"
>      
>      Ævar and I have brain-stormed off-list what would be the best way to
>      resolve the mounting frustration with CI failures that are caused by
>      needing to mirror Makefile changes into the CMake-based build, a burden
>      that the Git project never wanted to bear.
>      
>      While he still wants to improve the CMake support (which will benefit
>      Git for Windows), the main driver of trying to extend CMake support to
>      Linux (which does not need it because make works very well there,
>      indeed) was said frustration with CI failures.
>      
>      A much quicker method to reduce that friction to close to nil is to
>      simply disable the win+VS jobs, which is what this proposal is about.
>      (Almost, at least, we still want to keep those job definitions and run
>      them in Git for Windows' fork to ensure that CMake-based builds still
>      work.)
>      
>      A very welcome side effect is to reduce the CI build time again, which
>      became alarmingly long as of recent, causing friction on its own.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1445%2Fdscho%2Fonly-run-win%2BVS-in-the-git-for-windows-fork-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1445/dscho/only-run-win+VS-in-the-git-for-windows-fork-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1445
> 
>   .github/workflows/main.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index e67847a682c..8af3c67f605 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -132,7 +132,7 @@ jobs:
>     vs-build:
>       name: win+VS build
>       needs: ci-config
> -    if: needs.ci-config.outputs.enabled == 'yes'
> +    if: github.event.repository.owner.login == 'git-for-windows' && needs.ci-config.outputs.enabled == 'yes'
>       env:
>         NO_PERL: 1
>         GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
> 
> base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
