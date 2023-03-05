Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58169C61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 20:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCEUPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 15:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCEUPc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 15:15:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D9EF8E
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 12:15:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so6965085wms.2
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678047328;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3oUuwNbeQiqFmMHqGG6BGHKSfUDtW84lV4GQv2GPYqY=;
        b=MH6QqJQcoqt+gr43R88xjmWvSDz87s7P+NFxgR+cTwbxEPZlPjteg5BaVc2FT+zbnM
         ytOActLwP0va+i84sZJp2qlf9jnzyGzakdAqvcoaKqiVB4deUNk0PoS4atbcOOWUhiMr
         6cDqtrJlUdwjqwRoyvcA0oY72omN0Wh0g+xMD4ZsZ6pLIMyN0OCkxxB4xhwJr1Gj8xZw
         dJkQtV69yGNB19Su9RYYTLHZbTsS6eyGVnmrMzsCX99kLSRvhj6LnVQJEpYbzzaFDPsh
         jVFaGcjSyzUBOKh2cwM9dhuVJOpQt2p5oSK4YMdiJw7H7H5twGNcgWUAgvocr9F+V5tz
         XmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678047328;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oUuwNbeQiqFmMHqGG6BGHKSfUDtW84lV4GQv2GPYqY=;
        b=dvzgfyc2wZ6xJNv7LWqfTbE69yoPwXYuv7zd5PR8iYma/OyNViw4QlxLVmYgZQr1kZ
         Cj04Ax3EngB4RN2NaBwejLJl97dxO6mNWQ/K8/vSQq+J2ioRLEQKt9ErnmFA6qD/s1RI
         LxoNRwnSyfLxjEAGWGDjQGtTeL6sgEoReJacLCN4hj5QpcO9CDfCRAzSTLk/PwoD+y8R
         Bbgu56E9+eq9/ZLM8fheksjA8c6bGL9Xij0nAra9BZ/QdknvJhu8YCm0LZqWAi4dsgj6
         YbzLBf25eAom6nXmyGwvZ+gN02P6PTa6DkcNQ1e4Dqhs/b5lDwhS5TyRNW2m8P9CoKm5
         FGHA==
X-Gm-Message-State: AO0yUKVMXdRKQMSC2gRedOjPi7X8XrQeCjVlOFllv/bSPg/Iamx9T+BM
        5YhujdzzOEWxsvt7ENarZYY=
X-Google-Smtp-Source: AK7set8hP2zIjZ7ezrtmeCT9rx718I7Ujqk00pVlSmuJ4bMSLofitj2+iVaiskYp3bHAatHtrhw5rw==
X-Received: by 2002:a05:600c:4f96:b0:3eb:29fe:7b9b with SMTP id n22-20020a05600c4f9600b003eb29fe7b9bmr7371644wmq.9.1678047328421;
        Sun, 05 Mar 2023 12:15:28 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c304800b003e21f01c426sm8302971wmh.9.2023.03.05.12.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 12:15:28 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
Date:   Sun, 5 Mar 2023 20:15:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
In-Reply-To: <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 05/03/2023 19:13, Stefan Haller wrote:
> On 05.03.23 17:59, Stefan Haller wrote:
>> On 05.03.23 15:31, Phillip Wood wrote:
>>> Hi Stefan
>>>
>>> On 02/03/2023 20:27, Stefan Haller wrote:
>>>> On 02.03.23 11:19, Phillip Wood wrote:
>>>>> On 28/02/2023 12:55, Stefan Haller wrote:
>>>>>> The reason why I am asking this is: I'm using lazygit, which, during
>>>>>> interactive rebases, shows a combined view of the real commits that
>>>>>> were
>>>>>> already applied, and the remaining commits that are yet to be applied
>>>>>> (it gets these by parsing rebase-merge/git-rebase-todo); something like
>>>>>> this, when I set the 2nd commit to "edit":
>>>>>>
>>>>>>      pick   4th commit
>>>>>>      pick   3rd commit
>>>>>>             2nd commit  <-- YOU ARE HERE
>>>>>>             1st commit
>>>>>>
>>>>>> This is great, but assuming that the 2nd commit conflicted, currently
>>>>>> the display looks like this:
>>>>>>
>>>>>>      pick   4th commit
>>>>>>      pick   3rd commit
>>>>>>             1st commit  <-- YOU ARE HERE
>>>>>>
>>>>>> I would like to extend this to also show a "fake entry" for the commit
>>>>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>>>>> except that I need a way to distinguish whether it was applied already
>>>>>> or not.
>>>>>
>>>>> Can you check the index for conflicts when the rebase stops?
>>>>
>>>> I could do that, but then the fake entry would go away as soon as I have
>>>> staged all conflict resolutions. I would find it useful for it to stay
>>>> visible in that case, until I continue the rebase.
>>>
>>> I've not used lazygit but looking at the github page it seems that it is
>>> a persistent process that runs "git rebase". If that's the case I would
>>> think that you can check for conflicts when the rebase stops and keep
>>> that value in memory until the rebase is started again.
>>
>> I had considered that, but it would be preferable if it were possible to
>> quit lazygit, start it again, and have it show the same state again. Or
>> even start the rebase outside of lazygit while it isn't running at all,
>> and then start it and have it display the correct state.
>>
>>> I think your best bet might be to read "$(git rev-parse --git-path
>>> rebase-merge/done)" the last line of which contains the last todo
>>> command the rebase tried to execute.
>>
>> I'm not sure I understand; you mean in order to distinguish whether it
>> was a pick or a fixup?
> 
> OK, I guess it's something like
> 
> show_fake_entry :=
>    REBASE_HEAD exists
>    && (last command in "done" file was not "edit"
>        || "amend" file exists)
> 
> Is that what you meant? (Minus the bit about rescheduling failed
> commands, which I still need to wrap my head around...)

I meant you could just use the done file to get the last command, there 
is no need to look at REBASE_HEAD.

Best Wishes

Phillip

> -Stefan
