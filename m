Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14343C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbiAZPQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiAZPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 10:16:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B3C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:16:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so4722308pjj.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B+3KtRMtVflcass0t8O9wIXn7My/O1G0Xc52JqN0mtA=;
        b=GyeJdoFAJHu4/UUoUCwUHkWMzVRoXaXmCtzmvXGH+lw8DjjJ8URJx+Vs1iBwPGv8YH
         2fyc+9TowgPnblM30evflfPNAZLnCjFgxVCuMCmdDuetOL7eqG9hHfpTNdzqdcNgMYms
         g/i3UycJK+XjAjSQ817FGUSx3CI0sWkIoy4usRF0bcr18FUMyc2vTF+TPM+kZLHQrGdh
         MV/Qt2zDjQQujdiW1vgOxDOeydDGEJYf7JhS2GMNJgXYS7mvLbR8iL3jXnCUmeTUOAS1
         lDDdRsubeyj2HNtKYkY5oKiabvhF981G8JgZnizCTqKz892VZO2NZZ4qQhuPmprgDT19
         MmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B+3KtRMtVflcass0t8O9wIXn7My/O1G0Xc52JqN0mtA=;
        b=vtQOqXob7SXAN8DOIOIHlves46g5tyLfkslGngEPTSWBoTsGpfXZf1wyLDFWBDFMzF
         aB8H1obqA665w//rEwIFXa4dIgN2Z8sD9e4dFOACZRIsBYKx035U7XoU16wYSp0EK4PN
         xIvOSsAAaaRctwiH4ESbmG5qRIN4hSdJuC0vzh1EpEBPLTkLWfkh8ac3B6eEM3b62GY1
         qxti2W/F/I494JlzCiS86FKw6yQNOP8psKqPrx+TUTxnkOAtaM2ioHaOUCThAIxAVdhm
         vzNe7eJkKPEiLbbLm5S/OWQC/y9lNRXyFT/LB8iOv+t8vUs2I3YQYyJX+A8kuzFaKjw2
         wkiw==
X-Gm-Message-State: AOAM531iGSdhZJAx3Pr/uSldBXuaDMutH2q+vFtoB5xTxqAJ8MXJXxb5
        3p++ymOYUuuTbOjAqSMDm1M=
X-Google-Smtp-Source: ABdhPJzuQsaK1YcwR9pcmfbcZLHS1Oz+AhSRyTnN8zqeWIfnRrXRB5hIXbrWcNxGPpuRn3d29GK1aA==
X-Received: by 2002:a17:902:b184:b0:149:be5f:c6f3 with SMTP id s4-20020a170902b18400b00149be5fc6f3mr23077613plr.174.1643210215325;
        Wed, 26 Jan 2022 07:16:55 -0800 (PST)
Received: from [192.168.208.38] ([49.205.87.95])
        by smtp.gmail.com with ESMTPSA id t15sm3289322pjy.17.2022.01.26.07.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 07:16:54 -0800 (PST)
Subject: Re: Submodule UX overhaul update (was: What's cooking in git.git (Jan
 2022, #07; Mon, 24))
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, gitscale@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <xmqq35lc53e9.fsf@gitster.g> <YfBTRuPrGGjepe+D@google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <8171a321-20a0-508d-f2fe-57707d03a00f@gmail.com>
Date:   Wed, 26 Jan 2022 20:46:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfBTRuPrGGjepe+D@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/22 1:15 am, Emily Shaffer wrote:
> Finally finding the time to write up another "what's cooking as pertain
> to overhauling submodules UX" reply.
> 
> On Mon, Jan 24, 2022 at 11:39:58AM -0800, Junio C Hamano wrote:
>> --------------------------------------------------
>> [Stalled]
>>
>> * ar/submodule-update (2021-10-13) 9 commits
>>   . submodule--helper: rename helper functions
>>   . submodule--helper: remove unused helpers
>>   . submodule: move core cmd_update() logic to C
>>   . submodule--helper: run update using child process struct
>>   . submodule--helper: allow setting superprefix for init_submodule()
>>   . submodule--helper: refactor get_submodule_displaypath()
>>   . submodule--helper: rename helpers for update-clone
>>   . submodule--helper: get remote names from any repository
>>   . submodule--helper: split up ensure_core_worktree()
>>
>>   Rewrite of "git submodule update" in C.
>>
>>   Expecting a reroll?
>>   cf. <YWiXL+plA7GHfuVv@google.com>
>>   source: <20211013051805.45662-10-raykar.ath@gmail.com>
> 
> Sounds like Glen is interested in this series with regard to some edge
> cases about cloning newly added submodules during a 'git fetch
> --recurse-submodules'. I'm curious to hear from Atharva about the status
> of this work :)
> 
Pinging Atharva for this.

-- 
Sivaraam
