Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF3C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 02:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiAVCLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 21:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiAVCLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 21:11:25 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B8C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 18:11:24 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id v74so7201890pfc.1
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 18:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=jHdQuMVmnspLQ/Co42UAJFVpgRXdeN5eqwuw9Ecs9Zs=;
        b=CuB3OJ1hRzHlkZ9ljBb+5d8u9Nt8A9cqu87rTQBpUVrpDiulvDRnkSaFz0HKWrSDsp
         IFF5sqr7z327ftgcD1/zxy6Gov8zPHJPFZJ8mlRdXOsKOJIcmXc/QK9j8pWQx4dKm7Oa
         60NaSlWVD7Sut8Kef5HEzZHU2np5vEBZif/GzFbeUlOLu6jO8L9ck9sQOEieDTLwDKxg
         BCUzl9YtWxXs19lqzPq5M9q4dc0tztiwszjJ6Dxpsko7QWm7SK58vs1B/PdgItm5AQQ/
         UBGGlDGgA29BRERRjzss/9E87tzEg8g3K4VpkdMGftu3SJloA1tkdUcGsKwVDXHsPw62
         57hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=jHdQuMVmnspLQ/Co42UAJFVpgRXdeN5eqwuw9Ecs9Zs=;
        b=AiqHIiGxdCMeJhvJJLVgB0bc6D+tZvp5EdDUcJtkd2muEzHcC1qIN8VOtNwuX4DR/p
         pRbpk0mcXHGgrnhfnpSmWaXhNKOaiHbJJrEquQ1La/4usKq+MWdjJGKuv/+lcJ5i74pl
         tWWU4+R2+roPyJeOvbKX1t4d19MIYeIPW4Y/7OCgIpw1KN9z46jNlEvyqwfVpKNqRlxx
         z+x2/8vFbf6WShkJWpr/fzPWPbJxhCCjYX6xMGL00PymR+OI/weJif3dFrfDA2sl5aSe
         rI40rsjvMvYuwh1oA0GgXBI4BgQStDXghacnvF0z4fCdzGyRl/KDuYwOOGt6OVP2Kt7A
         fNfw==
X-Gm-Message-State: AOAM533N990Ik9RrwRoJiaiSGNub0ehTbz79KOPYbLBOXON8Dq0RR8Yh
        BPRClzW2ljb4Of3URBx+ULMNxhIlMxI=
X-Google-Smtp-Source: ABdhPJymMpuvuPv217RT4K3HHbuNbK+HODYWN9NnHviow4bvUXtenGl9/Si2LazIk9LcCwwexstNAQ==
X-Received: by 2002:a05:6a00:1703:b0:4c3:13c9:3a2e with SMTP id h3-20020a056a00170300b004c313c93a2emr5796045pfc.44.1642817484386;
        Fri, 21 Jan 2022 18:11:24 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:59d7:62f6:f657:9932? ([2601:602:9e81:12c0:59d7:62f6:f657:9932])
        by smtp.gmail.com with ESMTPSA id s32sm1990112pfw.215.2022.01.21.18.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 18:11:23 -0800 (PST)
Message-ID: <122b563a-3bb5-20de-6530-c79f02da792b@gmail.com>
Date:   Fri, 21 Jan 2022 18:11:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Content-Language: en-US
From:   Lessley Dennington <lessleydennington@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
 <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <xmqqv8yjz5us.fsf@gitster.g>
 <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
 <xmqq7dayup5d.fsf@gitster.g> <ee58a0d5-5773-238d-706f-3fb264b6e8db@gmail.com>
 <78956982-f5fc-1681-1efe-42e408132a4f@gmail.com>
 <5e7e4858-10ea-06d4-0406-84b83c26dc43@gmail.com>
In-Reply-To: <5e7e4858-10ea-06d4-0406-84b83c26dc43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/21/22 5:08 PM, Lessley Dennington wrote:
> 
> 
> On 1/21/22 5:07 PM, Lessley Dennington wrote:
>>>> I know it is your preference to complete only directories and
>>>> exclude filenames, but I question if the confusion such a design
>>>> causes to end-users is worth it.
>>>
>>> I think perhaps we're a little caught up in exemplifying commands that
>>> are unrelated to sparse-checkout. As Elijah said in [1], the documentation
>>> states that directories and patterns are acceptable to sparse-checkout but
>>> not files. While it is not reasonable to try to offer every pattern a user
>>> could possibly pass to sparse-checkout, it is reasonable to offer
>>> directories and (in my opinion) will help guide users toward correct usage
>>> of the command.
>>>
>>> However, since completion on directories is cone-mode-specific, I am
>>> willing to accept the suggestion to only complete directories if we are in
>>> a cone-mode sparse-checkout and apply it in v4 of this series.
>>>
>>> [1]: 
>>> https://lore.kernel.org/git/CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com/ 
>>>
>>
>> In light of non-cone mode being removed in the near future (see [1]), it
>> actually seems it does not make sense to add different behaviors for cone
>> mode and non-cone mode. I also ran this by some other contributors, who
>> thought it would be best to complete on both files and directories so as
>> not to confuse users (as Junio and Szeder have indicated). So, instead of
>> differentiating between cone mode and non-cone mode in V4, I will plan to
>> remove directory completion.
>>
>> [1]: 
>> https://lore.kernel.org/git/CABPp-BEwMAPHGt5xD9jDU58grbrAqCdqNY9Nh8UJGLKuLbArXQ@mail.gmail.com/ 
>>
> My apologies, I will not remove directory completion, but rather will
> return to completing on both files and directories.

My apologies again, I think I mistakenly assumed Junio did not want
directory-only completion for cone mode based on this comment from [1]:

If a path that is not a directory (either because it is a file in the
current checkout, or because it is a directory only in a different branch)
is given, it might not make sense in the cone-mode for the current
checkout, but it may well make sense when a different branch is
checked out.

However, this line (which I overlooked when I was re-reading this
evening), leads me to believe that is not the case:

Are we limiting ourselves to directories only when we know we are in
the cone-mode and showing both directories and files otherwise?

It has also been pointed out to me that saying cone mode is going away is
incorrect - it is just being deprecated.

So, I will stick to my original plan of continuing to complete on
directories for cone mode and completing on both files and directories
for non-cone mode.

Again, apologies for the noise.

[1]: https://lore.kernel.org/git/xmqqv8yjz5us.fsf@gitster.g/
