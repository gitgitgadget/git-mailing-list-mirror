Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD080C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4D46502D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 17:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhCPRdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhCPRdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 13:33:08 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A4C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:33:08 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id n6-20020a4ac7060000b02901b50acc169fso4343368ooq.12
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yL+wr+IzTCezArVDI5Tj+tWy2GWz2EXCHcuEJg7e3Cg=;
        b=e4Hq0qiWnfXp1dbMORXzBA9id22gJUvaC5eJLn38BWizGHGWE9RPPJZllkerXrkLlw
         tGHOs6ivv9bSiQbeFk0P2hDXHbeq0JszNR7VvgPTNl4yqfmM3Q5o10PDGBGZvC25AOAJ
         Ejm8ItmH5cf/mAg6/p/pGjAK8kYA9TD1x9yv3Xh3R+jQYlbwAr4Hti7CwjGwUdrUsztO
         cygdpgh67nfNxnuIfJE8j/4TxXLb7j1dZUtMaMFxqrbfslDWZY8MAG+wFkNAy7pf1K07
         gj/nf9Yfld2mwO3c8o+Me8aQ/MIiS956E3pfA6hHzURZud1zCuqEuQW8kTW69lhV9HPF
         2cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yL+wr+IzTCezArVDI5Tj+tWy2GWz2EXCHcuEJg7e3Cg=;
        b=kpck5gUcKOJOPbLENQZ0w5jl0kv6kgTgek88oz4rPPN+QTm4z8Rg4zBFp7lK8Vx3jS
         6Z1eaQLk8oS8OOu6qdt7NHD+WL8Eb7/66VRfvY5CFgCbZKfiMiZgK//w9A2BanG88hAG
         PPM5nZO3n5Lr65bbT16RZfi+qq2mtzB8sTy75j6fAo84tBDsGemjbyLXm+0V7F8KcBBH
         2MeZRNYqqGhM0BrkMgwhl6oH/UPiEMH308Tp66Wev8PrC5ZE1fONjEcuxb3NFnGokIM9
         FLY0OwyG+dvwGbo9wNxIYH9MUFbN9y483ESwXlgB+SDJLUYl3RbKKnP73hZCPSQYeREC
         RTVg==
X-Gm-Message-State: AOAM530gDe8mF+l8gIU9qH5k3dtjc3DGtZyAk0aROBJar4AJzvSDd+sG
        mtwEAZ6bbluG2y+uhmRTtGI=
X-Google-Smtp-Source: ABdhPJzF5Xo118T93TDjmFcA+KBD/QzIXWenEWurl65YRCH/5PV+ZJHnebp/aEmLK2I+yUdCjiLW8w==
X-Received: by 2002:a4a:ab08:: with SMTP id i8mr4718467oon.40.1615915987648;
        Tue, 16 Mar 2021 10:33:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id y200sm4084950oia.49.2021.03.16.10.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:33:07 -0700 (PDT)
Subject: Re: [PATCH 0/2] Declare merge-ort ready for general usage
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
 <44487d2a-f591-7e0f-8532-41397ec805c9@gmail.com>
 <CABPp-BEP5dJpT3q9Lx_Kk5qqSq+zN2F=13nTuTg7UpLCeFKSWw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d71ae08-68e9-3dd9-b462-1ba888ea94b0@gmail.com>
Date:   Tue, 16 Mar 2021 13:33:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEP5dJpT3q9Lx_Kk5qqSq+zN2F=13nTuTg7UpLCeFKSWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2021 1:25 PM, Elijah Newren wrote:
> On Tue, Mar 16, 2021 at 10:01 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/16/2021 12:05 AM, Elijah Newren via GitGitGadget wrote:
>>> This tiny series depends on ort-perf-batch-10[1].
>>>
>>> If the ort-remainder topic[2] is merged with this series, then the result is
>>> a version of merge-ort ready for general usage. Users can select it by (a)
>>> passing -sort to either git merge or git rebase, or (b) by setting
>>> pull.twohead=ort [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=ort.
>>
>> Does the other topic add GIT_TEST_MERGE_ALGORITHM=ort to the CI builds?
>>
>> Specifically, the Linux builds have a second run with some optional
>> GIT_TEST_* environment variables. This seems like a nice addition.
>>  Other than that extra request, this series was easy to review. LGTM.
> 
> The other topic left tests in t6423 failing.  This topic leaves the
> tests in t6409 and t6418 failing; it's only the merge of the two that
> has all passing tests.

Combining the series might be the right call, or say this one depends
on that one.
 
> I guess since the ort-remainder topic still hasn't been picked up, I
> could just combine it with this series (basing on ort-perf-batch-10).
> Then I could either add a patch at the end of the series that runs
> tests under GIT_TEST_MERGE_ALGORITHM=ort, or which changes the default
> merge backend to ort. 

Perhaps change the backend to "ort" only when "features.experimental"
is enabled, at least for one full release? I'll do my part to do some
testing with our repos in that time, too.

Thanks,
-Stolee
