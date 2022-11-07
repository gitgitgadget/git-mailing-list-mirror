Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE4C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiKGUIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKGUIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:08:49 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E123F52
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:08:48 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id c8so8868900qvn.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPp/WXVoAh7rdvzH5J6jXBiNvoEKEl7Dtr64doyS6Ic=;
        b=aFyT0L2EyxVm22JQac4j9wqgV8NEfyEI0gC+LjDf3Purkn6FvbTyestd5cc98Snbtq
         KXcTeSqzD0USR+duY9a9JiUyzX0755xS+S6n/wMBRNTGrBFEmS1pMnIfE++9tSXJiuom
         UGYcqsZqhn0hzqXkPs9GZ7dA5W6FwRH2I/g0ndVeBXMG9MNicXf9PzJrh0b1LgvyQiWH
         K9Wh5BlncIvMgzmP3abF6AoQgOnvNzqIqYMvLGNMvu93fmKUkf928CtY16XhZRekD0rk
         q7+gkiqyE0+mEr0Juby16uYPfw4tkfg0RmdErEVBuzCtlAR4ei5WrW8tsLeK7VFQ28DV
         6dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPp/WXVoAh7rdvzH5J6jXBiNvoEKEl7Dtr64doyS6Ic=;
        b=3WSeAtQyGu1xUCJmn8bgR3PDByvslyBmyJv4dgYsqdFgU+tSkGul/ckvau493yrhlw
         aNtDizAcs7TO/Big+Cn18yI0ZgUdBTdQ2Ug+WuBMu01uh/n9cZbPM+sxEROe2uDa/LWn
         /nxv0795aB/KfrC5fB9ApvfBeEcQn3gclleIdPQlDQPELXFJ3bY0m+pLrtW+9j5N4f+M
         l1AHMwQN2rguMtLgWezS7wllCIsnKSAWlK+f1phABWmwAQ0o06r9s+RqafjSFO77ATeV
         IUJqDGw17SySVMMbWXhZwAAeB8X5oL0iWIzoBK88NEBxXHs/R2LCvDz5a14iQTmDuApe
         Nqlw==
X-Gm-Message-State: ACrzQf3/F2FgLOVDdtAUDXpumDMxu8a+UZ6uKSkMyL91IQTTnuAi3kJG
        byLnzjuws5IuvU2plpMRGIKp
X-Google-Smtp-Source: AMsMyM5ElOslv+YofGTYcDXLHWb5vwyraOGVxjGqxlYJxhXClSb3ssNhI83MfEo/4XzPLcFpJrohDg==
X-Received: by 2002:ad4:5be1:0:b0:496:a686:2bec with SMTP id k1-20020ad45be1000000b00496a6862becmr45825534qvc.85.1667851727501;
        Mon, 07 Nov 2022 12:08:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id fe6-20020a05622a4d4600b0039a08c0a594sm6644522qtb.82.2022.11.07.12.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:08:47 -0800 (PST)
Message-ID: <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
Date:   Mon, 7 Nov 2022 15:08:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] ci: avoid unnecessary builds
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
 <Y2liOzOFLyz4uzd0@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y2liOzOFLyz4uzd0@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/22 2:53 PM, Taylor Blau wrote:
> On Mon, Nov 07, 2022 at 02:45:24PM -0500, Derrick Stolee wrote:
>> On 11/3/22 9:34 AM, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> Whenever a branch is pushed to a repository which has GitHub Actions
>>> enabled, a bunch of new workflow runs are started.
>>>
>>> We sometimes see contributors push multiple branch updates in rapid
>>> succession, which in conjunction with the impressive time swallowed by
>>> even just a single CI build frequently leads to many queued-up runs.
>>>
>>> This is particularly problematic in the case of Pull Requests where a
>>> single contributor can easily (inadvertently) prevent timely builds for
>>> other contributors.
>>
>> As someone who is both the cause and the victim of this, I
>> thank you for finding a way to reduce wasted CPU time. This
>> patch looks good to me, though I'll need to trust the docs
>> and your testing to be sure it will work. We will definitely
>> see it in place as it merges into 'next' and 'main'.
> 
> I wonder how we should treat Ævar's concerns in this thread. I suspect
> that the vast majority of workflows wouldn't be affected, but I don't
> want to completely break Ævar's workflow, either ;-).
> 
> Some kind of configuration mechanism like I proposed might be nice.
> Thoughts?

Taking a look at that sub-thread, I have two thoughts:

1. I don't think supporting a "multiple pushes of WIP work"
   scenario is a good use of "free" resources. If you want to
   test multiple versions of something, then use multiple
   branches (and I think Johannes's patch allows concurrent
   builds for distinct branch names).

2. The change you recommend requires running the job and
   deciding at runtime whether to do the actual build
   (unless I'm mistaken). It is better to let the workflow
   coordinator decide on concurrency before the stage where
   worker VMs are engaged.

Either of these points may have an incorrect assumption, so
I'm prepared to be wrong.

Thanks,
-Stolee
