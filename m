Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D25FC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 11:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1872C64DD9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 11:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhBBLf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhBBLdm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 06:33:42 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F1C06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 03:33:02 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id s77so5986805qke.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 03:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uTdPtgyzjpV+R9vpuSt7egTzhuEmbbFfukfzW3cm57w=;
        b=qHa2qJ8ShnVyKfX23741agKnEQ44k+xv/YLGC0GrgpYxK8iS9lPwMO5v8lxSvZftj1
         Cl3zO0FN7FeBJSkDQMHRHb5jgtXlHSvj0CL89NlNKthWcRkHk7dzuND8bo61rYUoZZhP
         evFsbs0wjiHUXkDf1UOpEDjHN+4K2feWXXpv6XwfJWDwJ0wmOMh8z7o1SaoBU+v7Srhh
         7c0OQsFV/clrqWo1nj8yiJykJColR35TCIuXaUw00FWpztaD7rWM80bGJeNq69dy5NKA
         cQCfC7ZNw/QgPuFgvo8Q3dXSxmrb5o9sj1TsDgTWrAc4TXl/rufduaw6evDCtla5uhpE
         wcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uTdPtgyzjpV+R9vpuSt7egTzhuEmbbFfukfzW3cm57w=;
        b=OiW7+4oU3xVK3gDs52sxeGjZVRnGZHKeZoti/JaDg6WgRRluHWf/xEZsi67leptbys
         SBlXmk6kuEvP6lGEZymHG49wzhBCDkjEuN6agSJoxIdug8yjK4199BFS1+o2H4tyWoKy
         tUsMS1EfxPHclHMylslgU8kbILvM2E+eo8IPlvxtkmOTkbBEYaPak3+ACw0bE0nRksWi
         xEE2ypxVKAdJFdaysSl3LCfb0ZqeAhMx+GRokcNc6lP4AwsRdaYuMEkN1fUTN8Mq9c4o
         vDc6GHdw6OaqKjSdPc6TyNqG4R9r/3Cjj0xf3z0qrKFkv+zY8Vu8EZ3HtyTRR/hUBq9w
         oMVg==
X-Gm-Message-State: AOAM5335zzZeYclUTYo9RdOXI5S6y/0Wz0Aju5kECQCt/HiRxsjI8rvz
        1Z6VC3lrC978NqTAxAQaXJI=
X-Google-Smtp-Source: ABdhPJzup6aMARrES9OdJKGzBPlPFmwo8e+u1Gdy0OsmVXCXN62QB9G9QUOngrUOYooGqrVj9j8tIQ==
X-Received: by 2002:ae9:ddc4:: with SMTP id r187mr20129439qkf.391.1612265581570;
        Tue, 02 Feb 2021 03:33:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:cc4:631e:f39f:4032? ([2600:1700:e72:80a0:cc4:631e:f39f:4032])
        by smtp.gmail.com with UTF8SMTPSA id 15sm5893854qty.65.2021.02.02.03.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 03:33:00 -0800 (PST)
Message-ID: <bae3726e-25e1-90e5-b0e3-5c2d0c4cd26a@gmail.com>
Date:   Tue, 2 Feb 2021 06:33:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: RFC -- making a plan for remainder of merge-ort
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CABPp-BHvk5RLq3OOYhcQZJ_9w6hbQUVurJiRrks8kcGq5-rn0g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHvk5RLq3OOYhcQZJ_9w6hbQUVurJiRrks8kcGq5-rn0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 10:52 PM, Elijah Newren wrote:
> Hi everyone,
> 
> There will be ~11 more series (with about ~6-7 patches per series)
> before merge-ort is complete.  Now that gitster/en/merge-ort-perf has
> merged to next, I can start submitting the next series.  Some
> questions before I do so, though:
> > * What's the right rate to submit them to not overwhelm reviewers? One
> per week?  I didn't get much feedback on this for the past series.
> [One per week, assuming the git-2.32 cycle is 3 months long, would
> mean finishing in about 3 months, i.e. just a few weeks before
> git-2.32-rc0.]

I promise to get back to reviewing with a faster turnaround soon.

If these are smaller series (and ~6-7 patches per would be smaller)
then I could see most of them stabilizing within a week. I think the
biggest thing for dependent series is to allow one to stabilize
before starting the next one. OF course, we can _think_ something is
stable and then a contributor appears with insightful comments a week
or more later.

> * My focus for the next few series is on diffcore-rename.c, which will
> also affect things other than merge-ort.  While each series is
> self-contained, given that 2.31-rc0 is just over 3 weeks away I'm
> wondering if it makes sense to hold my future diffcore-rename series
> out of 2.31 and start merging them in the 2.32 cycle.  Thoughts?

It might be fine to get the code under review, but ask Junio to
delay merging into 'master' until shortly after release. This
ensures that there is plenty of time to "simmer in CI."

Thanks,
-Stolee
