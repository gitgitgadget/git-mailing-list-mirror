Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ADEC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 01:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC261610E5
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 01:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhHTBK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 21:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhHTBK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 21:10:27 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48EC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 18:09:50 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so2400631ooc.2
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=weUKr3fDl7kEZSUBf6RjpejHPQgXb///NJXZaflOsxc=;
        b=gawK6X3BYPXhMPi0c/lgOZJlnYhAXbTXAmtX4HOJls+ZJIeSQEyj+ynpnPEsNxUT4Z
         fo0pqLRs/Zk9/lUVwdRkF53qSROR/FzospyTVU3d+QL98/YxI8SdKH+xqgGxkDbYp4uY
         n+2EWl181tyuNzX1mzbjc6aE91yV6NhhEm6BClse/5ZVohhUKMPYPp0dQgCadshhVSdR
         rFKqAnDVeSDxrqazF4sbwmGmB6AVTwFj5PxvyOCu+CW+tBRXxffKeMZhUqN4J1oqV1Pv
         Y4rGR+iAMvc77UjIyAfeT+YVEfP5as1CtLV7WrzrbVdZXs+vEqrvd+YfnTm/kr/4ac6W
         e9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=weUKr3fDl7kEZSUBf6RjpejHPQgXb///NJXZaflOsxc=;
        b=YSbYcAINQHYQouXTdbra02Go2oCYMwpz3nAnhkXjdfgYR2PltOyVZ/Pi6amPr9+w/h
         Ka8ORDce/uQ1t3MmVvKioB5mOZ8FWE1QViDSNFAOnrHUIW0yCYRsT/9QcUkrDmPQpMx/
         ihH32dMB/enamMNC1ng04bVtT+HFPYWfEDfrIAcdlmy+kdvYT0XrA4HwXOZnUEYly4dj
         URawRuV165jQ5iwh5ogkthGGGPPwPYfBWlsNvb+Oizl11hz9zWJNGfsl1e55i2YNPivQ
         rxx4By8OA77jBroRPClcBjGEFl4mBzJoxAGUs9nXJXzqY8oHOKNK4zxhhUPV/AhG8XSs
         yFMw==
X-Gm-Message-State: AOAM533zFp1XIiyrGMMz0N1GNg0nM0ukfJ1GJ7Gq2oHGrlv8igDWqYNg
        RJUZwtvbzYN6/LidRl8Hshk=
X-Google-Smtp-Source: ABdhPJwxsPh+H8ZiS0+W9EZjZCd/14fwcu3hKqmpE8xYk95tkLeHC+c3fvoCwoK4+S7QBXT/QiQVlg==
X-Received: by 2002:a4a:b481:: with SMTP id b1mr13754995ooo.79.1629421789424;
        Thu, 19 Aug 2021 18:09:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2127:20ac:7d67:3e01? ([2600:1700:e72:80a0:2127:20ac:7d67:3e01])
        by smtp.gmail.com with ESMTPSA id 14sm1178554otl.78.2021.08.19.18.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 18:09:48 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] cache parent project's gitdir in submodules
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f5197594-550f-3bd8-2d22-c9e1b3e161fd@gmail.com>
Date:   Thu, 19 Aug 2021 21:09:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819200953.2105230-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:09 PM, Emily Shaffer wrote:
> Since v2, mostly documentation changes and a handful of small nits from
> Junio and Jonathan Tan. Thanks for the reviews, both.

Sorry to show up late with many questions (mostly because my understanding
of submodules is not as strong as yours), but I do have some concerns that
we have not covered all the cases that could lead to the relative path
needing an update, such as a 'git checkout' across commits in the super-
project which moves a submodule.

Leading more to my confusion is that I thought 'git submodule update'
was the way to move a submodule, but that does not appear to be the case.
I used 'git mv' to move a submodule and that correctly updated the
.gitmodules file, but did not run any 'git submodule' subcommands (based
on GIT_TRACE2_PERF=1).

You mention in an earlier cover letter that this config does not need to
exist, but it seems to me that if it exists it needs to be correct for us
to depend on it for future features. I'm not convinced that we can rely
on it as-written, but you might be able to convince me by pointing out
why these submodule movements are safe.

Thanks,
-Stolee
