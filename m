Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C5C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D046960FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhHQUaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhHQUaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 16:30:12 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34402C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:29:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b200so9098536iof.13
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aXH1QJIU8V64AM/5T4aubXAygSjdmuGZ1iRgdsJ21dc=;
        b=OS4DXV7F1v1gjzO6M+kMT+2jItj56kkPrF7KUebdV9ySPk8KGV86lJPDul+5T5t8ua
         vP04eX/1XSV+nXlzVZqxdP2SviqDz05NLT5RmMWnDX8MlAo3h/tVIowRXymgw68z64JH
         TTuogrlgZmNp3lKGoewvBEOXg3s1GmB0qwVDhXjVR7uJgOBEParvIRnIux8UjMWIgT5G
         rEwrkFpSc5vgP5vsrS5Hik8g7KpZ6q1GN3LwWudAb10qZDJWjCvvuyTTQuG+Hit6RBu0
         vksJdTlb0Lo8BogqwsbxlJBGLMPhMfhf6iOaMowdxiuCTJbewJX3yMnBWoKHygOKaRcG
         J6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aXH1QJIU8V64AM/5T4aubXAygSjdmuGZ1iRgdsJ21dc=;
        b=la33OtcYfkqMCv5YJjh7ZPZ4sRB+xovosoJ5mFet1aeBgAV34DPwOyAqapc5gsJf+I
         bqaZnWMA3VVl/GcXcoKijYX/hkOx/NFVpEKdu5dyxnTPqLmUeF+Hs/WLVu/AHTvB/i2L
         cJzfatIlG8ruh4IOYGOke3k+uGyiB2Aejpd1l2NtJFgWiQUlrTC7ruwSU2ZDMx1xf4/8
         0MUraA9tdePD3gKrLZS47kBdaKoF7o0icFcmlNOb9Ehdr21bbxUjSbGCHes4DjBWLewU
         oXqzLIniZ2Jb1IQC++UJSZalpk27rTxDSIFoReXyr+8OVSDYq2XmAi93huwwMxDG+KEz
         qhxg==
X-Gm-Message-State: AOAM531Yq+rWmCA92c8/J0fdpSkIn8zgShTxvcW1KwZQirDvQHJ+pjEr
        1+BzFvF03OcpCH/L2R3im5c=
X-Google-Smtp-Source: ABdhPJzQm1Z5aH3Pvu4b9j99ScuwXfuC6vsa/PpE9e1zZazHC0QxzEIbO+33oAzuzobBOK+rbxD7lw==
X-Received: by 2002:a02:cd32:: with SMTP id h18mr4514975jaq.101.1629232178521;
        Tue, 17 Aug 2021 13:29:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dc75:b61d:e533:9004? ([2600:1700:e72:80a0:dc75:b61d:e533:9004])
        by smtp.gmail.com with ESMTPSA id n4sm1690238ilo.66.2021.08.17.13.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 13:29:37 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
To:     phillip.wood@dunelm.org.uk,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210608134000.663398-1-lenaic@lhuard.fr>
 <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
 <86d8fede-5ae6-6c5c-05dd-91373cb9f4c3@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <363a0e7d-ad30-5481-2bd5-c83420a84070@gmail.com>
Date:   Tue, 17 Aug 2021 16:29:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <86d8fede-5ae6-6c5c-05dd-91373cb9f4c3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 3:43 PM, Phillip Wood wrote:
> On 17/08/2021 18:22, Derrick Stolee wrote:
>> On 6/8/2021 9:39 AM, Lénaïc Huard wrote:
>>> Hello,
>>>
>>> I’ve reworked this submission based on the valuable feedback I’ve received.
>>> Thanks again for it!
>>
>> Hi Lénaïc!
>>
>> I'm replying to your series because it appears you did not see our discussion
>> of this topic in the What's Cooking thread a couple weeks ago [1] and might
>> miss the discussion that began today [2].
>>
>> [1] https://lore.kernel.org/git/4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com/
>> [2] https://lore.kernel.org/git/7a4b1238-5c3b-4c08-0e9d-511f857f9c38@gmail.com/
>>
>> The proposal I give in [2] is that I can forward-fix the remaining comments
>> OR re-submit the patches with a new patch and some edits to your current patches.
>> (You would remain author of the patches you wrote.)
>>
>> None of that is important if you plan to submit a v6 that responds to the
>> remaining feedback (summarized in [1]).
> 
> I think you mean v8, v7[1] is what is in seen at the moment. There was a suggestion at the time that a v8 would not be needed[2]
 
I do, thanks. Sorry for picking the wrong version to start
this discussion.

Thanks,
-Stolee
