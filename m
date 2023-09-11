Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90254CA0EC5
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349368AbjIKVdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjIKKBG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 06:01:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C1E69
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:00:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so3878535f8f.3
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694426455; x=1695031255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QWPNRZ/DA4lAtq1YoNCvc/rl5JY7qxOnHfTA0oQNFi0=;
        b=aZUzxwbyKDRQPx9WXoZW3Ag1NbZtZFxL6PPoaojbEWe60tS4/MtAISdkbWzlO3SCsQ
         nepYHF44ZSkNe+3iLZ3jrz/Gdh5H4XeVwl8EJH6P3tTccYBZMKNuMTuzbaeOZEGZyKln
         iRoITG+n9nQJ6M89ZSyGIC18fYFICZjP/5VIwI8BDwRS/CCnIgNq+Roc4GBZdWHs9V0l
         3v+UAMqa8ZmtZoaFbbjzH14GeOp9ybTzdlwCuuRwoXT9S5z56h9a6my8sgT0U9DigU8p
         wDmQ9+11NEgjhn6hBK4ve3TgZQC8d+M6so7t17JGlTZiiMGINwOX+o0Uw1JXzyhyx4kJ
         d90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694426455; x=1695031255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWPNRZ/DA4lAtq1YoNCvc/rl5JY7qxOnHfTA0oQNFi0=;
        b=ctilwPDdwndZSrDOrK+AXql7K6mqQRld25DLb/LFKL0HCmTkCcDUpShfEYpN/GAt1T
         P2qsxflsvVwnuNYmVa6l4cwPjMyJUJ38ST0R7qzWCgXtzWkiOcdKWo/1W2iu3PNMkGuq
         EJOBr+jWqumJ3IuVt13fRdvCo7sG/fXoP/L388vfzn7hNh1VzZVjb+V7SpD+jATFXnsg
         3khxuVqIrufhMB8rXhHdTq9zWJxC39smMqDVaYov7Y314pJw/8k3Je4O4UnRvQimX4jr
         Ess/bF1jZTLar0eJeVWqk8HCitPTf41fP++XANMKQvsdN0cFIN1mmc+wx1fiFR817XAF
         iFdg==
X-Gm-Message-State: AOJu0YzyQX8bclTn7XhyQ7RXYEswM4t6nS/NRghMxc92Pm5BuP92OkNU
        g2uS/G7YW16UDEmYnEkQw8w=
X-Google-Smtp-Source: AGHT+IEYEjBCiBGDDC/SAnqrKiYZw3CVteI/uSSPuTjCc4lSMfbh1sIEZfHIfhg0J2km75ANmBhA3Q==
X-Received: by 2002:adf:e444:0:b0:319:8c35:37b with SMTP id t4-20020adfe444000000b003198c35037bmr7754565wrm.7.1694426455264;
        Mon, 11 Sep 2023 03:00:55 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id y1-20020adff6c1000000b0031ad2663ed0sm9575999wrp.66.2023.09.11.03.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 03:00:54 -0700 (PDT)
Message-ID: <80eb7631-e5c0-497e-b2a9-b1f8c8a4a306@gmail.com>
Date:   Mon, 11 Sep 2023 11:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <ZP2U8TBNjKs5ebky@ugly>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZP2U8TBNjKs5ebky@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2023 11:05, Oswald Buddenhagen wrote:
>> The child not dying is tricky, if it is in the same process group as 
>> git then even if git dies the I think the shell will wait for the 
>> child to exit before showing the prompt again so it is not clear to me 
>> that the user is disadvantaged by git ignoring SIGINT in that case.
>>
> there is no such thing as waiting for grandchildren. the grandchild is 
> reparented to init when the child exits.
> 
> there is a situation were one can be deadlocked by a non-exiting 
> grandchild: when doing a blocking read of the child's output past its 
> exit, when the grandchild has inherited stdout. but that's a 
> implementation bug in the parent. and not relevant here.

Yes I got carried away and thought that the shell waited for all the 
processes in the foreground process group, but it can only wait on those 
processes that it created.

> On Fri, Sep 08, 2023 at 02:11:51PM +0100, Phillip Wood wrote:
>> On 08/09/2023 10:59, Phillip Wood wrote:
>>>> I've never done it before, but from my reading we basically want to do
>>>> (in the forked process before we exec):
>>>>
>>>>    setsid();
>>>>    open("/dev/tty");
>>>
>>> Do we want a whole new session? As I understand it to launch a 
>>> foreground job shells put the child in its own process group and then 
>>> call tcsetpgrp() to change the foreground process group of the 
>>> controlling terminal to that of the child.
>>
> this would indeed be the right way if we wanted to isolate the children 
> more, but ...
> 
>> It is better for handling SIGINT and SIGQUIT when we don't want git to 
>> be killed but in complicates the handling of SIGTSTP and friends. [...]
>>
> ... this shows that we really don't want that; we don't want to 
> replicate interactive shell behavior. that is even before the divergence 
> on windows.

Yeah, I'm not enthusiastic about emulating the shell's job control in git.

> so i think your patch is approaching things the right way.
> though blocking signals doesn't appear right - to ensure git's own clean 
> exit while it has no children, it must catch sigint anyway, and 
> temporarily ignoring it around spawning children sounds racy.

There is an inevitable race between wait() returning and calling 
signal() to restore the handlers for SIGINT and SIGQUIT, it is such a 
small window I'm not sure it is a problem in practice. There is also a 
race when creating the child but if we block signals before calling 
fork, then ignore SIGINT and SIGQUIT in the parent before unblocking 
them we're OK because the child will be killed as soon as it unblocks 
signal by any signal received while the signals were blocks and we'll 
detect that in the parent and exit. Currently editor.c just ignores the 
signals after fork has returned in the parent which means it is 
theoretically  possible to kill git with SIGINT while the child is running.

Best Wishes

Phillip

