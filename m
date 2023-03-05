Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3215AC678DB
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 14:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCEOdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 09:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCEOdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 09:33:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFA9EFD
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 06:33:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r18so6437392wrx.1
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678026812;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOSEa/3Df4JeDTklIakaDt79eBH3Qd+jyPeZFmiIA/8=;
        b=p33SxiLeEjHi3Amt4D0BdbugTlG2F1z1SfT0amHIyqEAQvCTBofg2ItQwYkdM7IpIn
         Yn5q4a+D+OE6Eg2Jt18Du9UpXpboRRO1xVQZjpyf8r74cOpM6CTdz+41oej1ykbScOkg
         CTrrJqfx1Nn43b0M52OgWl/CynhkAS9bB4Rzy94HSVhKNZ3FrL5l2sbLo/wHwdduaTHP
         MyrVvaWVNMcf4xamKO11gwmtakozvZKiwKl1qi36VEKjwn/BIU7km1alGZJ2NUz1zJti
         J48LKXs+DMMmDYRGQ5err1sWsoRHHvJ5Lu3YIbZY4oArA9ERubhlLLrcwXDzMeFyjWsz
         73TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678026812;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOSEa/3Df4JeDTklIakaDt79eBH3Qd+jyPeZFmiIA/8=;
        b=oklQIN9kMAC33Is3BRydN9/vZyGepBRK11wM+3uRcZaI+MeMVldifaR2Ac+aw0lTs2
         YKVxzPpLMl1bKMiNgnkzcWTyfGK2ODWMUaBgmgoK3lMrIgkrdO98uYF1t/FshoFwspxd
         L5YCzDe8t1AGLt9yK3hof4u9+ido9Nz/L0l3h6JZRX0F0l5jBloB4x2KJ4sCZhDaajdu
         5BxHyRBnczfo5R1B2bdw5BDlsQmBKnf6+ko4BU3Me5TSTDVl97vg/11fZRzkkPHhXwq3
         PBczcQTEhH847/i+pcAwkmhzVIVdoNPqIE2ZXUXOJpl2Zfkme1DJ8uJZPl8B3/hSwEQC
         IW6w==
X-Gm-Message-State: AO0yUKVrVSbJRHeCrYS2oAgVgbdBIiVleNBjjKds7N7BF07d784476Es
        dFxJIVcG992lYoWxGsvRPgk=
X-Google-Smtp-Source: AK7set8eRue6ysuK5C/MDJFCd1yjkC6CqhUfIpGQOhJxuV7zhZom1aD/Ym96i0qFlvNugE16x0+WVw==
X-Received: by 2002:a5d:58db:0:b0:2bf:dcbc:c442 with SMTP id o27-20020a5d58db000000b002bfdcbcc442mr5482342wrf.24.1678026811843;
        Sun, 05 Mar 2023 06:33:31 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id a17-20020a056000101100b002c553e061fdsm7563970wrx.112.2023.03.05.06.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 06:33:31 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <65f9d6c3-d7eb-5059-74d1-b9c150ddcccf@dunelm.org.uk>
Date:   Sun, 5 Mar 2023 14:33:30 +0000
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
 <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
In-Reply-To: <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 03/03/2023 10:57, Stefan Haller wrote:
> On 02.03.23 21:27, Stefan Haller wrote:
>> On 02.03.23 11:19, Phillip Wood wrote:
>>> On 28/02/2023 12:55, Stefan Haller wrote:
>>>> The reason why I am asking this is: I'm using lazygit, which, during
>>>> interactive rebases, shows a combined view of the real commits that were
>>>> already applied, and the remaining commits that are yet to be applied
>>>> (it gets these by parsing rebase-merge/git-rebase-todo); something like
>>>> this, when I set the 2nd commit to "edit":
>>>>
>>>>     pick   4th commit
>>>>     pick   3rd commit
>>>>            2nd commit  <-- YOU ARE HERE
>>>>            1st commit
>>>>
>>>> This is great, but assuming that the 2nd commit conflicted, currently
>>>> the display looks like this:
>>>>
>>>>     pick   4th commit
>>>>     pick   3rd commit
>>>>            1st commit  <-- YOU ARE HERE
>>>>
>>>> I would like to extend this to also show a "fake entry" for the commit
>>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>>> except that I need a way to distinguish whether it was applied already
>>>> or not.
>>>
>>> Can you check the index for conflicts when the rebase stops?
>>
>> I could do that, but then the fake entry would go away as soon as I have
>> staged all conflict resolutions. I would find it useful for it to stay
>> visible in that case, until I continue the rebase.
> 
> It seems that I can get close by checking whether the file
> .git/rebase-merge/amend exists. If it does, the current patch was
> applied already, and I don't show the fake entry. If it doesn't, we
> still need to commit the changes from REBASE-HEAD, so it makes sense to
> show it in the list.
> 
> Does this sound like a reasonable approach? I must admit that the code
> in sequencer.c is too complex for me to tell at a glance whether there
> are situations where this heuristic would do the wrong thing.

When a fixup or squash stops for a confict resolution that file also 
exists as the result needs to be squashed into HEAD.

Best Wishes

Phillip
