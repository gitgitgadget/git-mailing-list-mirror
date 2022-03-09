Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C494C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 15:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiCIPfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 10:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiCIPfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 10:35:53 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873F413AA3C
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 07:34:54 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s15so2143012qtk.10
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 07:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V8nW8Ljw3sM5BTZ6pP0lCJvP+Og+3B70SBTIGbqnIkg=;
        b=V3gdRZFS2hKEHkLlOBgQ49UPiPsLsLDAQ0j+8TZOR52ug3ZNRsf5grfSIggZA1fWws
         bpIs0gXNn7aq1JU9vpkiZPoEVbbJ+9ki13m0L3YoyQ5HTvo91jz+NBdElTVT54bBQSKo
         zDtcJi4nC99y0ysyHYC/A3xmqpdu0dxxDCYxNlrPxMBqVw81jxfE4D2q7nR7LTBH8jg7
         hmZkREXFjFDZmYFsEdY1zRpYt2om1PgNRJAVbYfF/mga5b4zVpM/ZhLbd6GQ1UcbszmD
         KCaCCvqErTa0XNHdsBjXVJH/uicmAU1g6nu+bX3iA1RajiGthkuRU4fWKvmhlZYMpYaj
         MuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V8nW8Ljw3sM5BTZ6pP0lCJvP+Og+3B70SBTIGbqnIkg=;
        b=DpOhRP5qLOQnBvJ6Oc078zhCP1qyl4W7YE4aIEvcWBToi01UcjOgJTLl3d8HG9qogA
         rBpZcrUdryw0yr86g5XnnWsKYeNeuqOoQP5wxEkOW2UaUiHWuBrWVDCvv6WuueO8XT/0
         3PEsU0hTAU8RYjRDnaEFD/K/3VJodMSHMxcjzWNuldZEkeQHV7JERP/ecIpJt9wAlD0s
         PVq32S/oCKEDJA2riI1SA2iJrxGpBDs9d/RR+9UvamLWb6nWMiwittBdrPrLdkRO563Y
         XxMJTVuos6GM4GNK24wnfMVMKRtqnU9cvszjXuceOerAT+rQ4GVL/qlrFQ/bwO8mha/3
         opjQ==
X-Gm-Message-State: AOAM532raxDHnttwUNb6igcyWW4SiAacYwHhBWigvlVb+xqBBwN3gWXN
        jkqSsbPRofhivTxC1iO3e1ABhKBcx5E+
X-Google-Smtp-Source: ABdhPJz9MFGYQGdcDimxK4qEe7WK/P9LvraYuqYQaRxbcDT+LqgDDdHFtBX8EsGiRYJRhL2dubscMg==
X-Received: by 2002:ac8:7d0e:0:b0:2e0:6675:adf6 with SMTP id g14-20020ac87d0e000000b002e06675adf6mr180269qtb.227.1646840093570;
        Wed, 09 Mar 2022 07:34:53 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a8-20020a05622a064800b002dd4f1eccc3sm1498670qtb.35.2022.03.09.07.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 07:34:53 -0800 (PST)
Message-ID: <2caf716e-116f-c10f-1af9-5612e2763a2a@github.com>
Date:   Wed, 9 Mar 2022 10:34:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 00/23] Builtin FSMonitor Part 3
Content-Language: en-US
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <e3c0a046-8041-421d-6640-91d1a560f79b@github.com>
 <eccdf8b7-93b5-f984-7754-622fa7c7771c@jeffhostetler.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <eccdf8b7-93b5-f984-7754-622fa7c7771c@jeffhostetler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 4:23 PM, Jeff Hostetler wrote:
> 
> 
> On 2/24/22 11:21 AM, Derrick Stolee wrote:
>> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>>> Here is part 3 of my builtin FSMonitor series.
> [...]
>>> Here is performance data from t/perf/p7527-builtin-fsmonitor.sh on a
>>> synthetic repo containing 1M files on a Macbook Pro. It shows the effects of
>>> the untracked cache (uc) and FSMonitor (fsm) on git status.
>>>
>>> $ ./p7527-builtin-fsmonitor.sh
>>> # passed all 67 test(s)
>>> 1..67
>>> Test                                                                 this tree
>>> ---------------------------------------------------------------------------------------
>>> 7527.4: [uc false][fsm false] status after checkout                  29.99(3.14+80.12)
>>> 7527.6: [uc false][fsm false] status after big change                73.32(5.11+97.24)
>>> 7527.8: [uc false][fsm false] status after add all                   47.80(5.12+90.47)
>>> 7527.10: [uc false][fsm false] status after add dot                  49.22(5.16+92.05)
>>> 7527.12: [uc false][fsm false] status after commit                   51.53(3.35+100.74)
>>> 7527.14: [uc false][fsm false] status after reset hard               33.74(3.03+85.31)
>>> 7527.16: [uc false][fsm false] status after create untracked files   41.71(3.24+89.75)
>>> 7527.18: [uc false][fsm false] status after clean                    34.33(3.07+89.36)
>>>
>>> 7527.20: [uc false][fsm true] status after checkout                  29.23(1.94+10.84)
>>> 7527.22: [uc false][fsm true] status after big change                64.23(4.66+24.86)
>>> 7527.24: [uc false][fsm true] status after add all                   45.45(4.37+18.70)
>>> 7527.26: [uc false][fsm true] status after add dot                   44.42(4.02+17.10)
>>> 7527.28: [uc false][fsm true] status after commit                    30.52(1.95+10.91)
>>> 7527.30: [uc false][fsm true] status after reset hard                28.70(2.70+13.89)
>>> 7527.32: [uc false][fsm true] status after create untracked files    28.63(2.59+10.71)
>>> 7527.34: [uc false][fsm true] status after clean                     28.97(2.59+10.78)
>>>
>>> 7527.36: [uc true][fsm false] status after checkout                  35.06(3.17+86.11)
>>> 7527.38: [uc true][fsm false] status after big change                74.65(5.14+101.50)
>>> 7527.40: [uc true][fsm false] status after add all                   49.96(5.22+90.96)
>>> 7527.42: [uc true][fsm false] status after add dot                   49.77(5.24+91.72)
>>> 7527.44: [uc true][fsm false] status after commit                    36.95(3.27+92.25)
>>> 7527.46: [uc true][fsm false] status after reset hard                33.89(3.18+85.68)
>>> 7527.48: [uc true][fsm false] status after create untracked files    41.44(3.40+92.99)
>>> 7527.50: [uc true][fsm false] status after clean                     34.60(3.26+90.19)
>>>
>>> 7527.52: [uc true][fsm true] status after checkout                    0.58(0.45+0.10)
>>> 7527.54: [uc true][fsm true] status after big change                 65.16(4.91+25.64)
>>> 7527.56: [uc true][fsm true] status after add all                    45.43(4.45+18.92)
>>> 7527.58: [uc true][fsm true] status after add dot                    15.56(2.57+6.32)
>>> 7527.60: [uc true][fsm true] status after commit                      0.98(0.46+0.11)
>>> 7527.62: [uc true][fsm true] status after reset hard                 30.30(2.96+14.49)
>>> 7527.64: [uc true][fsm true] status after create untracked files      2.15(1.73+0.40)
>>> 7527.66: [uc true][fsm true] status after clean                       1.68(1.56+0.32)
>>
>> The other stylistic thing is this performance test. It would be nice if
>> these tests were grouped by the operation (like "status after checkout")
>> so it is easier to compare the same operation across the matrix definitions.
>>
>> This would require reordering the test definition as well as allowing the
>> different cases to simultaneously live in different repositories. The
>> p2000-sparse-operations.sh has this kind of organization, but you'll need
>> more involved test cases than "run this command".
> 
> Yeah, it would be nice to turn this test inside-out so that
> could group the outputs by test case rather than by (uc,fsm)
> combination.  That would certainly make it easier to see how
> the two terms affect things.
> 
> The problem is I'd either need 4 parallel repos that I could
> setup with each (uc,fsm) pair or I'd need to start/stop the
> daemon and swap out the {.git/index, .git/config} between
> each step.  The former is a problem for monorepos.  The latter
> is doable, but I'm not sure it is worth the effort right now.

Yeah, that extra data is not something to take lightly.

Reworking this test is not critical right now, so I'll leave it
for another time, if we need it. But, perhaps we could set up
the test to create four _worktrees_ so at least the only
duplication is the working tree and not the entire repository.

(The working tree is still a huge amount of data in some cases,
so this doesn't actually solve the problem, just reduces it.)

Thanks,
-Stolee
