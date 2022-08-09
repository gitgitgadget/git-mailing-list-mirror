Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C253C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 16:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbiHIQRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiHIQRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 12:17:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC181EC73
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 09:17:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 12so11798146pga.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=xyEc+/wE3U4yRKPAAewxImnd3m+spmDFC1s0cknvKCE=;
        b=Yd97hilnSIzgi7hfEKK3LzPE4PlTUwuWm4FTE3RhwvGncKQ3KY18CVmVRAMFEextqk
         RlhcrQkqULGtn3QwBWLui0x3aXfDbpgfh0QirabXxxcgNXCBiEW58nnSBwHoWPJpJIHl
         gFMUDBGKHxcMEc8152bYBdL+5kwutGrd1mOUQtZjdAjtqH7CgPNz+l9papjP/dlmYwQY
         xhXkzwWCA41qQCjJj1zWOO/yEYYBNYXsvLfxJyYT6QES3mkLTK4yWhqY9rGeXE35c6pD
         S9GZKqbZX5Hz5PXUP8fb5D8xV2MEa/wof4WxoQvYybbatSiHffHRF6Vw4yE8EN4wrhyQ
         KsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xyEc+/wE3U4yRKPAAewxImnd3m+spmDFC1s0cknvKCE=;
        b=qiS59jfu5YPF+0aGldrMjddBb15U7A7KbQuM+ernLgwkm9oUEatamr/WMbSPeO+Qmk
         s4XYCt4gdjTl/xwp3VpCQZmq3kimLe31qCKbhopFIRpeYor8y3OVB3vi/RQYAYJ26Oo2
         2LVgCn+mHXvI2QcToKEIz3MMbBa4OyIiYYyjNccBlRJlxQj2uo1f1Jt3a7hSlwd6NuUo
         QW3FTwHE1IcKDuIyMHVwC4tFTgB2UaNg0UiMtQn+WX7n5p2x2ilWVq4KxKbCQwAcnaHo
         3OPV/yKhRHayyYYUvyRlsDI33ss0VuO+NFR8yuG/W7TYEcTTHLWOCq7BvDc1IJJ5BrxP
         nJLg==
X-Gm-Message-State: ACgBeo3cSeia7F3pMjlSamIQ6UviAaujDbH/k3JscWMlYu3j2gqVg1Mo
        W58wT5FhZA7fc8zt6BkHVlft
X-Google-Smtp-Source: AA6agR4W9xbMvXY+PPuzPBoe+YNlFm5/m02rJJCjvI2rWIWkknSflhmTwAQRO4pGRSgTh0GT5Xos1A==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr20264586pgw.599.1660061840992;
        Tue, 09 Aug 2022 09:17:20 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id 142-20020a630294000000b003fdc16f5de2sm8172658pgc.15.2022.08.09.09.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:17:20 -0700 (PDT)
Message-ID: <82af0381-ecdc-adf4-1339-ec35c18118a1@github.com>
Date:   Tue, 9 Aug 2022 09:17:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 00/10] Generalize 'scalar diagnose' into 'git diagnose'
 and 'git bugreport --diagnose'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <xmqqwnbn6i0v.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqwnbn6i0v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  * (Almost) entirely redesigned the UI for generating diagnostics. The new
>>    approach avoids cluttering 'git bugreport' with a mode that doesn't
>>    actually generate a report. Now, there are distinct options for different
>>    use cases: generating extra diagnostics with a bug report ('git bugreport
>>    --diagnose') and generating diagnostics for personal debugging/addition
>>    to an existing bug report ('git diagnose').
> 
> An additional command gives us far more design flexibility, and in
> this case I think it may be worth it.  It has a risk of confusing
> users between "git bugreport --diag" and "git diagnose --report" a
> way to send a report with diagnostic information, though.

This is an interesting point and something I think users could plausibly run
into. I can think of a few of ways to address that:

1. Do nothing, wait for feedback from users.
2. Create hidden option(s) '--report' and/or '--bugreport' in 'git diagnose'
   that trigger a warning (or advice?) along the lines of "did you mean 'git
   bugreport --diagnose'?" and exit with 'usage()'.
3. Create visible options '--report' and/or '--bugreport' in 'git diagnose'
   that invoke 'git bugreport --diagnose'.

I'm leaning towards option 2, but I'd also understand not wanting to clutter
builtins with options it *doesn't* use for the sake of advising a user.

> 
> 

