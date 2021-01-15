Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA6C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1888A23772
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 14:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbhAOO2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 09:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAOO2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 09:28:38 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC845C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 06:27:58 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 186so11767450qkj.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 06:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RiwK7nIo7pVG+zzxWr+0NCdJt0DVYki1iQo38purn7I=;
        b=Ger3Xe5ryUNIVd/ypMog9WyftWcgW2+VZwfn91WFNLURSTLFrrL8qFeOg378z2/U4f
         K8F/dekNZvSlQPfMjIOcY1R+QhjEJA5xuV8DSMfQWfp9/xpA94eXWmCGHWchpj72i6wR
         baYMIGBTSkFVadD/NIlci5LEIZAuAPCN+vZFr1uR6wwg6LtOw/ZJqLZnjb7yrhHVRUwh
         8wvBj4DTk5DhHgypgcpaai0T1iraxmjD1GxRCAGrp5l6qK8psTRyZERx5nemnaR0KrET
         xhHx59Du6cGMrSjeCKP8+K/3kznfaluibpM1829kvg0PyWtyeravxY1gHg+YUElazRFW
         gJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RiwK7nIo7pVG+zzxWr+0NCdJt0DVYki1iQo38purn7I=;
        b=XDtHdIlbmymrynhdhBvmDj/JpObaEWWEh2LD/I5FO4gB+78qiOSpgpivmFUMWvp0Bh
         VE5cIJL/xaWe1fCbQUaNmjDnYrhFUdogHRYOMkNC5sfAqSIrZRK7ADnH3xyhQbr4IMnX
         UZf/5NV7QK70kn0GAjRt3SpUyrDfWuZq7brsaqs1L2w3GlOtQY7eaka1fgmoZztMWW3V
         ssmKSfDeHRhALYoRWIsm7EUb9CT34JEXTN1111R+qGCDlR4jZA8RMTuM2xxEJ0yWyy3W
         z6qn3ZUu6UZ7WgaMAs+TjMn5eL4ZEz+2/0FOETxuJftEH6sSAxiB4UAQnX2AXMpGZO7q
         TDdA==
X-Gm-Message-State: AOAM531bwEO+LG/3vZakJKwmTacUFyM7kpvD+6dJ78Z+cBvsVhY08Cyz
        TaJIMdn0Hk4jwwXJpPhF/zlu/CCZp6g=
X-Google-Smtp-Source: ABdhPJwmEuTodHLkDyPyDxa7oBZTfv96X4/FFp2VnPbKOegnA81uftUnT2X473X23/EbSZ46mmjNbw==
X-Received: by 2002:a37:8fc3:: with SMTP id r186mr12780777qkd.253.1610720877527;
        Fri, 15 Jan 2021 06:27:57 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:45b:efdb:7894:c039? ([2600:1700:e72:80a0:45b:efdb:7894:c039])
        by smtp.gmail.com with UTF8SMTPSA id t184sm5007054qkd.100.2021.01.15.06.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 06:27:56 -0800 (PST)
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
 <xmqqa6tavjgm.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <19de3b73-80c6-ccea-9289-fd3f82c103ac@gmail.com>
Date:   Fri, 15 Jan 2021 09:27:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6tavjgm.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2021 12:48 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> It seems that homebrew suddenly started giving us trouble, like this:
>>
>> https://github.com/git/git/runs/1705953982?check_suite_focus=true#step:3:70
>>
>> Here is my attempt to work it around by blindly following the
>> suggested course of action in the error message, without knowing
>> what I am doing X-<.  I am not a Mac person.
>>
>> What is frustrating is that every time we hit a minor snag like this
>> to break one of the jobs, all other unrelated jobs are also taken
>> down.
>>
>> Help by those who know what they are doing on macOS would greatly be
>> appreciated.  Thanks.
> 
> After seeing 'seen' with this patch at its tip pass the tests [*1*],
> I prepared a merge of this change into the tip of 'next' and
> tentatively updated 'seen' with it.
> 
> The test is still running [*2*], but the problematic part in the
> macOS build has already passed, so I am planning to fast-track this
> change down to 'next', 'master' and eventually down to 'maint' to
> keep the CI going to help other platforms catch more interesting
> problems.
> 
> Help from those who are more familiar with macOS and homebrew is
> still appreciated, though.
> 
> 
> [References]
> 
> *1* https://github.com/git/git/actions/runs/486978562
> *2* https://github.com/git/git/runs/1706704233?check_suite_focus=true#step:3:81

We recently hit this same issue with our macOS builds for Scalar
and GCM core. Your solution looks very similar to how we fixed
the problem.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
