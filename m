Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D103C433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1FB64EEE
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCSNJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCSNJK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 09:09:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA5C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 06:09:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a11so6619584qto.2
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BCHbPtDOevwpF8eetV+Gs8l75/jvFiKOyEV+L79lB2g=;
        b=qpPQSwo8L42+5lC7Wba/tedoYzfnZnB/nOfDmcf2FdCwT/z2kLoejAlwaNWFmPA2Pm
         7RmXVfCdadaAPNYkQoGZ6TgilNK8IHuZygtLLArPhplCH5AjqZfDySCsL7BPBNVyvWc+
         fEwYDf7Aw3I88UXqrG/OzxMd4dgMUt4mdDhJycqtoH7P5mjrxi5mHsiLmyg9ht4ws6UY
         48xNkzHT9G0Wm2YhRGqxq0ybWaYkh6EAZth+ODz4kPAZ3I4VrgNFlr4SR/0JBpWoOMX7
         VCV0o64XhvudihevuMMknq3QQlKcX+3EuoNEEUcaSJcy62f3STf+OhaGJ2MnAKnZoz0X
         9caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCHbPtDOevwpF8eetV+Gs8l75/jvFiKOyEV+L79lB2g=;
        b=AZtkRwBH/RAkg6QfTluvyjPIqT7Qk6UXmZOVX8KqtQZxfQ+SY1KDKkLLj+izqeowrh
         dbECgNnR20Em5nuA+L5oIuE2q0kr6uP/7MM0Bi2ndmVFAlCD3JYWRCrMxK0WHXWrPFF2
         5wcd+0jfMrmF0pp9culXsOJOcHZXO06y8Pt6SBGYmR/TcjyJFOhLwzqQjfYxQniHoUWF
         KH/apGkkZTeMefXxuAcsH2a7HQ0aFW5nnpvd+IwuCC1KrZDDbxXyZ8L3jK1bQSWzGcsa
         69P/vUoQpY8xj/ESLNVYCDzdHOB2ZkWSwJ/6fL+gb0E6yKsMGyGEo1DpRW92WhI+9+Kr
         8vVA==
X-Gm-Message-State: AOAM5305bhdJLuP8cfJJZ2LUDtSegZi/mgfjcIMbl3KxGxAGxZ0yeT6G
        jXogeiSqBiWdD406dQUbjjs=
X-Google-Smtp-Source: ABdhPJyYau7lhkHR/zdqtHsOSVksC7meJ3EQJC/6YZAHDkiFTRtWvovEJ2R7k0oNYajTMzuwCwTH5A==
X-Received: by 2002:ac8:5557:: with SMTP id o23mr7945308qtr.327.1616159349211;
        Fri, 19 Mar 2021 06:09:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7c62:2958:a423:b37b? ([2600:1700:e72:80a0:7c62:2958:a423:b37b])
        by smtp.gmail.com with ESMTPSA id 61sm3701804qtb.53.2021.03.19.06.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:09:08 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] Declare merge-ort ready for general usage
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
 <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <80cccc70-296a-05d2-94a8-0e005e4abe1d@gmail.com>
Date:   Fri, 19 Mar 2021 09:09:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 5:27 PM, Elijah Newren via GitGitGadget wrote:
> This series depends on ort-perf-batch-10[1], and obsoletes the ort-remainder
> topic[2] (that hadn't been picked up yet, so hopefully this doesn't cause
> any confusion)
> 
> With this series, merge-ort is ready for general usage -- it passes all
> tests, passes dozens of tests that don't under merge-recursive, and
> merge-ort is is already significantly faster than merge-recursive when
> rename detection is involved. Users can select merge-ort by (a) passing
> -sort to either git merge or git rebase, or (b) by setting pull.twohead=ort
> [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=ort.
> 
> Changes since v1:
> 
>  * subsumed the ort-remainder topic (the first 10 patches), which has
>    already been reviewed by both Ævar and Stolee[2].
>  * the next two patches were the original v1, reviewed by Stolee
>  * the final patch is new and adds testing.

Sorry for the delay in looking at this. I read the two series before
this, and found this to be a good union of them.

My only question on the final patch is a two parter:

1. Did you mean to go this far?
2. Did you want to go farther?

Mostly: how much do we want to prepare for ORT as the default
strategy, at the expense of reducing testing of the recursive
strategy?

Thanks,
-Stolee
