Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4346C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9650A61130
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhHSKEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbhHSKEj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 06:04:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C3C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:04:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f13-20020a1c6a0d000000b002e6fd0b0b3fso4782107wmc.3
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wmg781ZdLO2kEYiQ3RbS1/4uZyIzBAAkm+XotX3Txuw=;
        b=FfvTq7JZR0jWmjui6C0rkkv8PxII4MHZ0fxXLn7JJ49D+8a/37+ui0AsjPZRRDbon+
         zSlT3vDIzImtDRxm+vipW0fZr40Qblhr7czyZGhezo6pfGocK6VCpaf4mJwEssqMGVq2
         vb0NnY2wO01E/LhB2urN6FIEpleXQDkZ4gLUkMlJLN3IzXFsu+06nHWXAhokx7kRikop
         NK2aF7fxDRWtJVQah93+w3/JdDrDQUaKidnN+reeKdsyDKfq2fsHtfclvmUWxRVDNzHa
         i9vfHZrAzQrWzLP94pMeh0Ll90yyJIjFY1ATrDYWOtyMh6Voyb7edPvEskwUDjcAuVCW
         WsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Wmg781ZdLO2kEYiQ3RbS1/4uZyIzBAAkm+XotX3Txuw=;
        b=mp8OD+agrazHRCPVOnMOTtAPiQ6uMDMEysYXle0cv5hktKzLutrTduH7NExIUZJLaK
         tF3dVVQ4LviPxdXpJvmny0J2JOkeKJE9Lrl+QLfAGkqWHSt6cWHxHAExVEqUFYf+5aPC
         8qipwgCE21t5Aor1COZEFbcHsXWsmaAXg+5sNbTE6o+Ob669rFhixa3UzJYW5zGYrI44
         j/7BbU3PmXe4ddFMx1Vq8i2Z1rYyrFsWNvlXmOeKR5Wf1uNNL/jIb0VrwLOgsJ914kxA
         /ZYV8C8iFd96nYiUbRUPJWNHBge7XFSsjFrLjlVu5o36O6+mFQDODJBtqAPYcL3IrKuD
         BEWA==
X-Gm-Message-State: AOAM532FrjVhOihhXrFTrY3S2jDw/Y2xyeOwe9fPMTCcsTuXsbvsyugF
        OlgLe10oI2kuQOMt3PiCvfEaQmX9tEM=
X-Google-Smtp-Source: ABdhPJylJXiQGYJze7kagU/qeTIm4W5o4jpe9f/S6SuirxDNLZ2tmgon4g5Yyr4p58TbaZavOw+oOQ==
X-Received: by 2002:a05:600c:3b98:: with SMTP id n24mr12705158wms.11.1629367441629;
        Thu, 19 Aug 2021 03:04:01 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id k17sm2657732wrn.8.2021.08.19.03.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:04:01 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        phillip.wood@dunelm.org.uk, Josh Steadmon <steadmon@google.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
 <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
 <e363df27-a99e-1a43-f493-ed90de7b6363@gmail.com>
 <cc044079-c40d-ab79-8afa-8a1dfa66f279@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b1a1b548-4fe2-9043-a19c-db9c04be7bb7@gmail.com>
Date:   Thu, 19 Aug 2021 11:04:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cc044079-c40d-ab79-8afa-8a1dfa66f279@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe
On 18/08/2021 23:45, Philippe Blain wrote:
> Hi Phillip,
> [...]
>>> For interactive rebase, an alternate implementation, that I suggested 
>>> in [1] last summer, would be to keep
>>> the cherry-picks in the todo list, but mark them as 'drop' and add a 
>>> comment at the
>>> end of their line, like '# already applied' or something like this, 
>>> similar
>>> to how empty commits have '# empty' appended. I think that for 
>>> interactive rebase, I
>>> would prefer this, since it is easier for the user to notice it and 
>>> change the 'drop'
>>> to 'pick' right away if they realise they do not want to drop those 
>>> commits (easier
>>> than seeing the warning, realising they did not want to drop them, 
>>> aborting the rebase
>>> and redoing it with '--reapply-cherry-picks').
>>
>> That would be nice, but we could always add it in the future if Josh 
>> does not want to implement it now. At the moment the function that 
>> creates the todo list does not know if it is going to be edited, I'm 
>> not sure how easy it would be to pass that information down.
> 
> Well, I'm not sure we need to ? If we change the 'pick' to 'drop', 
> instead of
> not writing these lines to the todo list, the cherry-picked commits will 
> get dropped
> either way, no? Unless I'm missing something - I think you are way more 
> well-versed in
> the sequencer code than me :)

I think I read your suggestion as meaning we would not print the warning 
if the user was going to edit the list - hence the need for the 
distinction. I've just had a closer look at the code and I think it 
would be fairly easy to tell sequencer_make_script() if the todo list is 
going to be edited, there is only one caller in builtin/rebase.c which 
could easily pass a flag for this. Thinking about the 'print warning' vs 
'add drop command' issue if the user is using a terminal based editor 
such as vim or nano then they will barely have time to see the warnings 
being printed let alone read them before the editor is opened and hides 
them so having some indication in the todo list would probably be a good 
idea.

Best Wishes

Phillip

>>>
>>> Like Junio remarked, it is a little unfortunate that some logic is 
>>> duplicated between
>>> 'sequencer_make_script' and 'make_script_with_merges', such that your 
>>> patch has to do
>>> the same thing at two different code locations. Maybe a preparatory 
>>> cleanup could add
>>> a new function that takes care of the duplicated logic and call if 
>>> from both ? I'm
>>> just thinking out loud here, I did not analyze in details if this 
>>> would be easy/feasible...
>>
>> I think feasible but not easy (or required for this change), it would 
>> also complicate the code in a different way as I think we'd have to 
>> add some conditionals for whether we are recreating merges or not.
> 
> Yes, I agree it's not required for this change.
> 
> Cheers,
> 
> Philippe.

