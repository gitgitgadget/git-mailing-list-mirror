Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733DEC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 16:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiCJQHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiCJQHg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 11:07:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401A186460
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:06:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so5746971wms.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l5PBqyg1omJAty0x/UV7j8p/aRFL4QGN5saK19G9BdE=;
        b=MOfLsESNxBWn+rmTJtVMVMLxNNUZzni0h+ilPboUZ6Xx9WSY43tubvULU55c9YkK2a
         cyvfHZ65NmuPYo4+OldwH/8zp85qYlAXKFtl76JCyfl6jW1ciedQOeqfbuMUhyC7XFn7
         TlOU0heWyk74K9BMzhUv+XDhwQLlcX9rzqKKNBe3Xwv5kdARbeVJOdp6aymz573yuSoi
         Uc43UI4o2diiiYoyHhQsoXQ2EEbZM+WECUPZ7oSNw4jlF2hjAY1iOhs1WPtZzVN7L9tw
         DRBUda3ouUxFR6Ku+X1K34/PuSfDm3BhFAAk79qmpjQBdxn3juwk8aP/uETqE3TI/ikZ
         LkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l5PBqyg1omJAty0x/UV7j8p/aRFL4QGN5saK19G9BdE=;
        b=dtxzek+y8JOO97Or+ffFQY3do1705VyE+PNbFmHLSZXBwXsGxwKf3+e9RgYwunu+kZ
         tvCiLbiD/ICQOrts9F8JBjvEOjzVlvqd53Js2azmr/k7WJkMH5aMJFbOZUr2k/hnVmSW
         ge1eQc0ryOcdxnYynRxsq7Tb7WgNoybIfJWTQ87FnwE3lNirE1f3UXwKA1m0sIWHslIX
         E0QkQwaMgCykXiEYkmH1RzWT87GBgXLa1KLnofB/nOvhMAxkHiABYoUeez1mfbn6P70b
         lZXuzmlASG7LxgVoB2j26n32ePfUN7fEPwHu0AO/nDK9s+KNHwZj/Fydg+h/rCBikxXl
         yO2A==
X-Gm-Message-State: AOAM530Q6KJF3P8twQqlD9+EPPMYU6PvcslNrsdGJgHUmb5GpU2FOvto
        l3fIrbvKIMthEnrK1/1I06AltwWWjI4=
X-Google-Smtp-Source: ABdhPJzTiVtJNytXfJswQh2J5bu3/00GEouppBKvRIGCsasS/0fy5sMuoHQSCO3MAtuC09+ks5EivA==
X-Received: by 2002:a1c:2b41:0:b0:380:e379:b8b0 with SMTP id r62-20020a1c2b41000000b00380e379b8b0mr4164386wmr.87.1646928393126;
        Thu, 10 Mar 2022 08:06:33 -0800 (PST)
Received: from [192.168.1.240] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id y4-20020adff144000000b001f022290737sm4451815wro.6.2022.03.10.08.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:06:32 -0800 (PST)
Message-ID: <7fff6841-968d-b741-2589-fa737499113d@gmail.com>
Date:   Thu, 10 Mar 2022 16:06:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] terminal: restore settings on SIGTSTP
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-5-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.2203091310080.357@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2203091310080.357@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 09/03/2022 12:19, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 4 Mar 2022, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the user suspends git while it is waiting for a keypress reset the
>> terminal before stopping and restore the settings when git resumes. If
>> the user tries to resume in the background print an error
>> message (taking care to use async safe functions) before stopping
>> again. Ideally we would reprint the prompt for the user when git
>> resumes but this patch just restarts the read().
>>
>> The signal handler is established with sigaction() rather than using
>> sigchain_push() as this allows us to control the signal mask when the
>> handler is invoked and ensure SA_RESTART is used to restart the
>> read() when resuming.
> 
> This description makes sense. From my understanding of signals, the code
> also does make sense, but it is unfortunate that it has to be so much code
> to implement something as straight-forward as suspend/resume.

Yes it is a lot of code. It would be a bit simpler if we omitted the 
warning about resuming in the background but I think that is worth 
having. There's also a lot of changing signal masks to avoid stopping 
twice if the user presses ^Z a second time while the signal handler is 
active.

> FWIW I tested the `add -p` command with these patches on Windows and it
> still works as well as when I had developed it.

Thanks for testing this on Windows, I don't think we have any meaningful 
test coverage for interactive.singlekey and it is probably tricky to add 
because it relies on having a tty.


Best Wishes

Phillip
> Thank you,
> Dscho
