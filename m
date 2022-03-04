Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF0C433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiCDN0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiCDN0p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:26:45 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BC5B8A2
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:25:58 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso9342348oop.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=iGFy4h94WIfNUhq1Cbk2x/eXMYzPR12ZX1T2DOXzoVI=;
        b=F+EuDQV8DDSGn2lKF099Sw9g4QaZ832CgyQYhQvpAh4RnXsZi8MITRPebY1zy+xWnL
         yVxbdd5Lh09jh4AU1NXU0hhh6jVM3pPtwZvwkDDonxMItowEn1yWuwXap8+PpehHBGaQ
         BVe9JFNIhTibkEwyKvQ12wI6t61XQ6hfg0bc6twGaRmebGD0WRl5Ve7v4kVj/LvOSov3
         d5J/Obi+yhmWIo3wAItEjZPB/+vAGR+kQVgeE2vyutwhAogXBoB/leLiwqCtG7s/qbEh
         LmR2NtU1XBkbSUtuWd+/glGznWY3g2heErmKSu4SAxLsJCyiUlqqxJOcRNR0AYUZmBc7
         7NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iGFy4h94WIfNUhq1Cbk2x/eXMYzPR12ZX1T2DOXzoVI=;
        b=olbpg8m21aABhCPT3xKUTCBNP33Z1eYs8pH/QVQbXey4LUHM4j6eL+tTLWuTr6Fowe
         i0Xg7M1HH5LWCR3OSZBi4DsTT2FuBbrEFEKmObf1diAE8XIIyOHmrmvQzZ8u4WKwyMdP
         2f7tYYTQIIS3gZenmLHJZBDtb62M6O4gU4fyQ3FNiPWqvWFcy6TK+x5/id3lnlaEWtYn
         y4YGrxnpzkHfK3mv207y2SjqLgwqGxP/4do/AQpJcSF0NrkCQE8jpSLKNUSQphxpQLzg
         Fj5jo2A9PZf7b3K9MA93WwL7MKuLNb1wpSp6Ya23ceqq7bbkxeDcpgNK+AACbKUSRyqc
         7g4Q==
X-Gm-Message-State: AOAM531aE36oek1NlMipZbjWjRNvpt1CaWZBP6ibHUlDmvrl/0vlUPrx
        MlcSru4B3sOylraUSiQ5Mor5
X-Google-Smtp-Source: ABdhPJw/GvNL1Atk2+f/E9VlilIfPONpNUtXYWpRiKE3dv3yIqQJqB/Pb8Wif5WX1UNsE2wHVQzN3g==
X-Received: by 2002:a4a:c719:0:b0:2eb:c34a:2ba7 with SMTP id n25-20020a4ac719000000b002ebc34a2ba7mr21636899ooq.98.1646400357739;
        Fri, 04 Mar 2022 05:25:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t11-20020a4ae40b000000b0031cc933b418sm2275817oov.40.2022.03.04.05.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 05:25:57 -0800 (PST)
Message-ID: <5f8740bd-c0b7-a8e1-4d73-b79b40cc02e9@github.com>
Date:   Fri, 4 Mar 2022 08:25:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: ab/plug-random-leaks (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqv8wu2vag.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8wu2vag.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2022 11:31 PM, Junio C Hamano wrote:

> * ab/plug-random-leaks (2022-03-02) 14 commits
>  - repository.c: free the "path cache" in repo_clear()
>  - range-diff: plug memory leak in read_patches()
>  - range-diff: plug memory leak in common invocation
>  - lockfile API users: simplify and don't leak "path"
>  - commit-graph: stop fill_oids_from_packs() progress on error and free()
>  - commit-graph: fix memory leak in misused string_list API
>  - submodule--helper: fix trivial leak in module_add()
>  - transport: stop needlessly copying bundle header references
>  - bundle: call strvec_clear() on allocated strvec
>  - remote-curl.c: free memory in cmd_main()
>  - urlmatch.c: add and use a *_release() function
>  - diff.c: free "buf" in diff_words_flush()
>  - merge-base: free() allocated "struct commit **" list
>  - index-pack: fix memory leaks
> 
>  Plug random memory leaks.
> 
>  Will merge to 'next'.
>  source: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>

This series needs a re-roll before it gets merged. There is
a correctness issue in this patch:

>  - transport: stop needlessly copying bundle header references

Thanks,
-Stolee
