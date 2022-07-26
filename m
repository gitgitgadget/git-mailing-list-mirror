Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B6C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 13:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiGZNaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiGZNaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 09:30:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C077C11
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:30:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m10so10597855qvu.4
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yc5/SIM4OgS9okIrjFGOWk8AYEi9q5c79B95WCR5Mbc=;
        b=G+nRHDO81LXg6s8gz6IvLQJOxi/zxl+7X+8Vfe9r+bq87J75b3lXL7E231aT/uLgon
         sm+/dVvqgMSvpQbuv0nsTc89pkeaTopnVzto4pI1mpJjkAjfPV1Y/igZEB1kOaJjKywQ
         UksGsBAz4t6Ow71dnHfAZuhZDNKmd5Oyz9pya/C9aNOGn0IBv8hXvkqb3eriO381D/+i
         fzhbasJYQQXJdOWH/ZaH6+uJXJyEWlipm36cmpMQdjAV3xKgmWrOwba0Hlh37Wfegcd7
         cCMMs7VjYXXWx+tAm9zxn1LTKvo7wiUsYYlJ66rzM5/2z5dfgtQ2q1CLewbbauj6uI6a
         iM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yc5/SIM4OgS9okIrjFGOWk8AYEi9q5c79B95WCR5Mbc=;
        b=RuUoE2arxObZfErb6LKB541HZiEn5zeLC8QCBTRGFYM8gCc7wtV6MjkPbLic53GvGw
         0t0O2jh0cqUDh4MD5WzPZURXb4DMskuhklU6qrh21I31MVzOgk2PeqVCv/ucnehYQZca
         Ar5orvBuJCk+XVujnuGuY9sgvNL6sSfoN4D11Dk0+lDBEsTpfTxGsjESYl+nTeF0xPkg
         lFpkP7rzx3SI1X5e6cNcaK6UuNl02c0sMgFTjDSJGwPM6hqJBWcerMPo1qaA2T+SwL8B
         07Ezt6nMM5UKpA6XrEUhww4904/tHBVf2OKXn6ja7Jw+8VWxzOGF72DJIohTijztjled
         LJcA==
X-Gm-Message-State: AJIora+xZZFI18309FNnF48SNQQ/wfp0jJpnjDvbXPcfWD2SEzQLs7/U
        rKUZZ3mQFryl3LTqsjwgNYD+g+sIdNta
X-Google-Smtp-Source: AGRyM1vXRDSC9R0jGDHk87YU9HF6bgnZu8XwWKgyuxNBwYqLf3HqYGaTyhJ7WGps2dm0kZZzC4Fn8w==
X-Received: by 2002:ad4:5bcf:0:b0:474:2d74:997c with SMTP id t15-20020ad45bcf000000b004742d74997cmr12919382qvt.52.1658842209616;
        Tue, 26 Jul 2022 06:30:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:70fc:586a:b1e2:eef? ([2600:1700:e72:80a0:70fc:586a:b1e2:eef])
        by smtp.gmail.com with ESMTPSA id p9-20020ac84089000000b0031eb5342520sm9251023qtl.15.2022.07.26.06.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:30:09 -0700 (PDT)
Message-ID: <d4dcb1f6-6076-3725-d479-7e9f1fece2a3@github.com>
Date:   Tue, 26 Jul 2022 09:30:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/2022 7:09 AM, Ævar Arnfjörð Bjarmason wrote:
> Add CI targets for SANITIZE=address and SANITIZE=undefined. The former
> would have caught a regression in 18bbc795fc5 (Merge branch
> 'gc/bare-repo-discovery', 2022-07-22) which made its way to
> "master"[1].
> 
> Per [2] the GitHub fork of git.git runs with these in CI, so it's
> already useful to some forks of this repository.

I'm a fan of adding additional sanitizer checks in our CI. Let's let
computers do the work for us here instead of relying on humans.

> Also per [2] we could use SANITIZE=address with some ASAN_OPTIONS
> instead of our SANITIZE=leak job added in 956d2e4639b (tests: add a
> test mode for SANITIZE=leak, run it in CI, 2021-09-23), but unifying
> those two with these new jobs would be a lot harder, so let's leave
> that for now.
>            - jobname: linux-leaks
>              cc: gcc
>              pool: ubuntu-latest
> +          - jobname: SANITIZE=address
> +            cc: gcc
> +            pool: ubuntu-latest
> +          - jobname: SANITIZE=undefined
> +            cc: gcc
> +            pool: ubuntu-latest

> @@ -277,6 +277,12 @@ linux-leaks)
>  	export SANITIZE=leak
>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>  	;;
> +SANITIZE=address)
> +	export SANITIZE=address
> +	;;
> +SANITIZE=undefined)
> +	export SANITIZE=undefined
> +	;;

In both of these cases, we are breaking from the nearby pattern. These
jobs could be renamed to linux-address and linux-undefined to match the
linux-leaks job.

Alternatively, we could rename linux-leaks to SANITIZE=leak, since the
point is not to test the Linux platform but to use the additional runtime
checks (and Linux is the fasted CI platform).

Thanks,
-Stolee
