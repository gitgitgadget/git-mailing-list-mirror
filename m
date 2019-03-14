Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA5020248
	for <e@80x24.org>; Thu, 14 Mar 2019 10:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCNKmK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 06:42:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40019 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfCNKmK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 06:42:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id g20so2144106wmh.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lsLnDD0Jk9eUAaXFUdtWknQKp2+vG3w6TCJ3pjFUx+M=;
        b=klxXsu4TZsxRC78OcuW5vMFWu3u1D8FqINUEQWipdDYv/LiOeeSj70geoCoJkNB/aZ
         5GaSnMqF05K4auzHnkRGFvCnpJcPHLU2u5sG5ihS52Y8bW4LuKDmetoBoCP9XUH5NPfU
         Fx8/5niVd92ldH8cgnTXmIpaJa2bYTOpovODKgZYIBJRyVCB9RAWEZUyWyleYtTPaFPK
         0h6eStcCYF1AP9D3eUGy18is6MJmOPcu91AWD+05hIGXNzpIR3nY2U2AyDrop2qYk0KL
         6poutlNExH3XwRgsits4r4Z0QSQdSIwqcEVgBkdiD/DqlsvTV68Frup1TOA2dQAT+54l
         aCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lsLnDD0Jk9eUAaXFUdtWknQKp2+vG3w6TCJ3pjFUx+M=;
        b=kmUa9wG1DXWtIQmyMF/nkluFjZvOHudp6ul1MN4Z88kWTdi+EYT+9QGQWU48Lo6Xas
         u+7bjdHsNuN27SMZT5poypmVhEQhc/jwOmc2kxnHAokbjLT5yT2vEt//SvjF3Y/7Q8wY
         DpSRMrHoSG8NuIFPYaQYByPDvQB0b1/gGawUMGH3lQHZKyScSTCBuJrh66UCjNyKgUQ9
         7gDLkxGhMF9Bw5oGJey9hET009w1X2AXwRgb7f55tfXzMUFZ/k35wK/8/mnSEHdbF6m8
         zhQEf8ppdAsBdcpN3l56zNPlBTmgWtBsBUaorrDIPnOgOyucxiUCx13zXFKmIIAokjrK
         DvlA==
X-Gm-Message-State: APjAAAUTyIYnKpTdgE90AdHByu8UCeMgtaVPwQuIW8dRdbr2KGqJ1afL
        9MG83BTfwt6R9Lw0sE2mU5coqnEqL12xfQ==
X-Google-Smtp-Source: APXvYqx99rGcmiPWku+trj51PeQFi7DqORbUakQZ9oo5KgImA1pNZHFVKLaKFvYb3CQeYQuX/dlw8A==
X-Received: by 2002:a1c:eb17:: with SMTP id j23mr1962413wmh.86.1552560128316;
        Thu, 14 Mar 2019 03:42:08 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.googlemail.com with ESMTPSA id y20sm16933711wra.51.2019.03.14.03.42.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 03:42:07 -0700 (PDT)
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Elijah Newren <newren@gmail.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <CACsJy8Ax0nt1zt9eqNs6QM4gCS-PFfXH9woxd81X-_zywQRnVw@mail.gmail.com>
 <CABPp-BFw2O_N8bYz8DDSj5RWhn-TNh7Z8ww4joKYvL4CQrOO4g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1f52d046-11a4-c1af-32f6-d0de5c358d55@gmail.com>
Date:   Thu, 14 Mar 2019 10:42:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CABPp-BFw2O_N8bYz8DDSj5RWhn-TNh7Z8ww4joKYvL4CQrOO4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2019 17:05, Elijah Newren wrote:
> On Tue, Mar 12, 2019 at 4:58 AM Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Mar 12, 2019 at 12:25 AM Elijah Newren <newren@gmail.com> wrote:
>>> On Mon, Mar 11, 2019 at 4:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>>>>> On 08/03/2019 09:57, Nguyễn Thái Ngọc Duy wrote:
>>>>>> "git checkout" doing too many things is a source of confusion for many
>>>>>> users (and it even bites old timers sometimes). To remedy that, the
>>>>>> command will be split into two new ones: switch and
>>>>>> something-to-checkout-paths.
>>>>>
>>>>> I think this is a good idea, thanks for working on it. I wonder if it
>>>>> would be a good idea to have the new command refuse to checkout a new
>>>>> branch if there is a cherry-pick/revert/merge/rebase in progress (with
>>>>> an option to override the check) as switching branches in the middle of
>>>>> one of those is likely to be confusing to users (if I do it it is
>>>>> normally because I've forgotten that I've not run 'git whatever
>>>>> --continue').
>>>>
>>>> Interesting. I think this would be a good default if we have an escape
>>>> hatch (which could even come later). I often wander off to some other
>>>> branch and go back. But then half the time I end up forgetting I'm in
>>>> a middle of something and just "git rebase --quit" :P
>>>>
>>>> Of course with git-stash (*) and git-worktree, I guess there's little
>>>> reason to just switch away from a something-in-progress worktree. I'll
>>>> try to implement this in the next round, unless someone objects.
>>>
>>> No objection here; I like this idea.
>>
>> One last thing. What about --detach? Should it have the same
>> protection or should we let the user doing --detach (experiments) take
>> the responsibity to not screw themselves up?
> 
> My intuition here is a bit weaker; it would be nice to hear others'
> opinions.  My best guess thinking it over a bit is that while someone
> doing --detach is more likely to know what they are doing than other
> users of the 'switch' command, they may also be the kind of person who
> is more likely to run interactive rebases and thus had more
> opportunities to forget that they are still in the middle of one.  I
> think I've been guilty of that a few times.  So, while this would be
> less critical for this case, I lean towards saying that it may still
> be helpful anyway, and if nothing else the consistency of handling all
> switching cases the same seems beneficial.
> I think that having all the switching cases consistent makes sense as it
is easy to understand and avoids complications if we end up adding a
config option to allow an implicit --detach in the future as suggested
in one of the later patches.

Best Wishes

Phillip
