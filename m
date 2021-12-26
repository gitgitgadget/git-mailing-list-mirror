Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970FC433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 03:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhLZDkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 22:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhLZDkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 22:40:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B1C061401
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 19:40:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p14so9091127plf.3
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 19:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw4uPjiST7KP+JegsF5viTkAUpo+AcnvxLGbb9BiZ3Y=;
        b=ivkxvYF5nAk/r/wcJQOIlFUQvz51l+1BoB6b/s0KQ3RKxq3Tr3jqdzl7QmNb+734OJ
         N3XomifVZm7kV9QdBdW5VgzdbuPguxvzMHZGKRrMVQXW+UmOnLV48UDGAB3U0RvB2J2w
         uKpk7+5ludCbM/f0r4qTh8plfsZY+iJFJfhiykCLUQSrfOuFesKar7Tg6U9LYVLo4NQo
         HDPioy4O6zu+2fTHNGawLiCD3Z+Q7g0g1c8bolGu4a6BI0Pd0VE3MgREpGrki4ClG44f
         tnwkpJa7F/V4HPf/p19HG5By47hJEn4F4vh4FpLjay3ZjzL3DR266/UsvYdl5hMrCg14
         cpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw4uPjiST7KP+JegsF5viTkAUpo+AcnvxLGbb9BiZ3Y=;
        b=NE3aAHRnusouTBG6nMKbpFVOB+Em7lbK5B0Tm2Ku+STYUjbo/Xgyo6IR98/aXeUH5V
         Bu7Rbk56PVlkTDym+D97u6F/gUkjtAd2Vjc+EhQ5hWh4YVZ0a/jGItg7ROzZK0M0vrPL
         xIc8out23AGlnopHhQ7cQvYjQp0AP44jxAs3M+Jdt63xmN+IriksfqlVAFswfnV3lGtV
         YbGdMQjI7bJHaLbk9Khj/9WJtYXt0uOe5XjXYIIrixAxDpn1CiWFYn3mAm0qHXe4wXTH
         Jfy+M5gsQI0+jLP9usB1be/rquCB5BAR+gLm5NB2Q5ZCMH9WKFLi6S6n89d6q/hyfRsr
         t1uQ==
X-Gm-Message-State: AOAM531/fwoN0QC6yiSWUjZHk/SO75GXFXS5O7uJMp13LtUZ9HtpDClR
        t2VfJwtjOLoNnjHYf6kcfKvtxFWuMJcHZA==
X-Google-Smtp-Source: ABdhPJzOuD4qePIjM3eoOjc4mc2k+b8V+nr44nszXW064hHyrWdQzk6Anm+JUWsrGoO7Llw4DWz7ZA==
X-Received: by 2002:a17:90a:1c5:: with SMTP id 5mr15108640pjd.24.1640490022399;
        Sat, 25 Dec 2021 19:40:22 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id u8sm13467819pfi.147.2021.12.25.19.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Dec 2021 19:40:22 -0800 (PST)
Subject: Re: Git internal command line parser
To:     =?UTF-8?Q?Jo=c3=a3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     git@vger.kernel.org
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com>
 <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email>
 <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com>
 <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
 <bZ5IKn77iTM5gCits_kl5lZ7uiOOkkt8dcHPT1UVlPWsrnqapXBtAkYB4uGGBA3Oizq4J7BN4GC6mLR8wQ7x_qqLJPbae6IMTqxW9JFJSbg=@protonmail.com>
 <65fdfd25-736f-5105-6eba-b70cd51cc780@gmail.com>
 <-WF_iHKAhyH3NM_qOg4GeWV-KnDZbiUTF700TOojIuYKduAfY4-Jl4NSmHNHoLjlixEeHH6JVAIEC03IBAQ7mBTdvlR87APri0yyM5tElOY=@protonmail.com>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <d0ccdf56-0b83-782b-1e72-cd0c9ae3347e@gmail.com>
Date:   Sun, 26 Dec 2021 11:40:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <-WF_iHKAhyH3NM_qOg4GeWV-KnDZbiUTF700TOojIuYKduAfY4-Jl4NSmHNHoLjlixEeHH6JVAIEC03IBAQ7mBTdvlR87APri0yyM5tElOY=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/12/2021 10:38 am, João Victor Bonfim wrote:
> Saturday, 25, December, 2021, at 05:32, Lemuria <nekadek457@gmail.com> wrote:
>> Was this directed towards Lemuria (me)?
> 
>   Oh god no, those were more general comments about the way things are done on Git, rather than directed towards you. See it as me reacting to the information received and trying to pull a conversation about it with Philip.

Alrighty then.

> 
>> Okay, I understand. I'll do everything to keep my code bias-free.
>> I'm working on a project in C and if it's okay, I'll link you to
>> the GitHub repository.
>>
>> I'm sure the git mailing list isn't the right place for me to get
>> criticism on that project however.
> 
>   I will do my best to help you out. If you want to contact me, send an e-mail to my address (JoaoVictorBonfim@protonmail.com) and we can talk it out.
I think I can deal with it on my own. But if you're
curious, it's right here:

https://github.com/a-random-lemurian/randstuff

Mostly random generators, like random ascii and hex.

> From experience I learned that, when talking about prejudice, it is better to shut up, pay attention to the conversations in the room and see who is being denied their humanity, who has the power in the situation and who is trying to prop up an emotional response from others. Most of the time, those who are being denied their humanity, those who are restrained in their response, those who have no power or say in the conversation and those who are more emotional than trying to prop emotions are the marginalized in the conversation.

Alrighty then. I'm also worried about prejudice in say,
machine learning. We humans are biased, so who's to say
the AI training data isn't biased?

In fact, I might be biased right now and I probably
would not realized it.


> Now, out of curiosity, are you named Lemuria because of Lemurs? You know, the little primates from the Madagascar island?

Indirectly. I named myself after the lost continent. It was a
decent name, which is why I use it as my psuedonym on most of
the internet.

And the lost continent in turn was named after... lemurs.

