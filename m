Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8ACB20248
	for <e@80x24.org>; Wed, 27 Mar 2019 10:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbfC0KYf (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:24:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33839 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbfC0KYf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:24:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so4444264wmc.1
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Cen0/29AhLyh9bCsn93sruC30t+HQLo+1t85Yzkge8=;
        b=R2lrMrZ6ZS41pOgI0PG6U8TB7gYpN3RBwZHcgu6zXhmZPIKQQDvvz1SlJYzbNOQcHq
         Jm66ZnIyGHFkAEwTGv8V/p1mze1HpEjd7YWvE6K/zq3fPQqps4mLq99nwPASPpKKjx2Z
         GbUyoPCfu+6LYI0mhXCgSAu7Rc6tEIBZv2MORfbKeatuEeDHmIChJcbLf7Aw2Rg3RpIV
         60rW1315e8DPgO8WFyrGs0b8PSfXY4GlnpPe+fOd4UM0m8X+u1DXMx0KO0+ovWbIInF/
         cfVkVy3vLSEI+5kvJBtsiqpKqt3GLLg13Sxi+Elwm8QlFb6JtjP2QCWNcQrC76RczT0B
         hu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Cen0/29AhLyh9bCsn93sruC30t+HQLo+1t85Yzkge8=;
        b=JrJ79kRqQdkz7JszzOyBzLnrF4exrIr+tp33Cw8hKEEZP4h4lOVksL3FtgWgH/KcDl
         ZU5gThOro/cBxeppepqo1lQH5rtdsyTpmvIO7enm0NZhwB/fjYwVnLjrcT+EGzdMWH+3
         pLl1LBTlEleeJvLyLubrsmV5osFL4SyKTjkZD9I7JE2uCsS0KpNZCHRVmtrb5MGMBT/X
         +ORvgxvwcqaEF42Xe7cUU0dRJ0ob+QPTwovqMJuE/rWHTiH91xPBlRcvWzN2tCe3uIef
         yax4dIyX2/cfbF4p9m0LQHYGdUSnZpcW+0YtmvmuQ+8KhP4LiC+G7ZqWNL85pQgLSDq7
         de4Q==
X-Gm-Message-State: APjAAAXYa0cCOzS/dEQlXQM66zWFFKHcQE4A2rH1FV0xv3HxfahI9ZQr
        KTE52RZIFRKcEf79fm/rKuY=
X-Google-Smtp-Source: APXvYqyUA/ke2ybY+tpicbNM4HS3BGSA7Q6Ic82lCN7JIMqY8MgfGZGLzlWWXWZma0N4Efp/ASaXKA==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr17377889wmj.153.1553682272251;
        Wed, 27 Mar 2019 03:24:32 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-188-250.as13285.net. [89.242.188.250])
        by smtp.googlemail.com with ESMTPSA id x5sm23075064wru.12.2019.03.27.03.24.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 03:24:31 -0700 (PDT)
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
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
 <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com>
Date:   Wed, 27 Mar 2019 10:24:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/03/2019 15:48, Elijah Newren wrote:
> On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:
> 
>> Yeah.. --ignore-in-process does not necessarily mean aborting
>> something when you just want to get out to examine some other commit.
>> And I agree doing nothing seems like the best (or least
>> confusing/surprising) option.
>>
>> There will be some funny thing. Like if you commit after switching
>> away and MERGE_HEAD is there, I think you will be creating a merge
>> commit.
> 
> Yes, and in the middle of a cherry-pick with a range you've added some
> commits to one branch and some to another.  In the middle of a revert
> you're doing similar.  It sounds like crazytown to me (and maybe we
> shouldn't provide the --ignore-in-process flag unless users clamor for
> it 

I think that could be the way to go for merges and cherry-picks, or
possibly require --discard-changes as well. The only time I use checkout
like this is during a rebase if I want to rewind it - I edit the todo
list with the output of 'git log --pretty="pick %h %s" --reverse' and do
'git checkout' followed by 'git rebase --continue' Though these days I
could add a 'reset' line to the todo list and skip the checkout.

> -- or maybe we should print a big warning whenever people use it
> much like we've traditionally done when people checkout a commit
> rather than a branch), but it at least makes sense what is happening
> and users had to explicitly state they wanted the in-progress state to
> just be ignored and switch anyway.
> 
>> But I guess if you choose --ignore-in-progress, you're pretty much on
>> your own. We could improve "git commit" and friends to realize that
>> the current state is unlikely safe to resume whatever in-progress
>> operations. But that's separate and I don't want to dig another hole
>> to bury myself in while there's still 'git restore' to take care of.
>>
>> Or maybe I'll just suggest "git <verb> --quit" when the switch is
>> successful with --ignore-in-progress.
> 
> Combining that with some kind of warning about weird effects of
> applying a mid-operation process across branches seems like a good
> idea to me if we're going to have that flag.
> 
>>>> PS. git-reset shares the same behavior, but it's in a different boat,
>>>> I think. Or maybe I should scrap/replace that one as well.
>>>
>>> reset has traditionally been the home of
>>> how-to-clear-in-progress-state.  e.g. aborting a merge or cherry-pick
>>> or revert was 'reset --hard' (or later 'reset --merge'), skipping a
>>> become-empty cherry-pick or rebase is still 'reset', etc.  So it's not
>>> that surprising to me that it clears out state.
>>> ...
>>
>> Yeah but it was surprising to me that this is not even mentioned
>> anywhere in git-reset.txt. You learn by examples basically, or by
>> experience. But I digress.
> 
> Yeah that is slightly odd -- but that at least provides a small silver
> lining: it makes it easier to decide to change it and move all the
> mid-operation-state-clearing to other commands.  :-)

The missing documentation is odd but I think it makes sense. 'reset
--hard' throws away all the changes in the index and worktree so it
would be confusing if MERGE_HEAD was left behind. 'reset --mixed' throws
away the changes in the index and you cannot do a partial commit if
MERGE_HEAD or CHERRY_PICK_HEAD exist so it probably makes sense there as
well (although if you do 'git reset && git commit -a' it wont remember
the merge/cherry-pick). Some of the other reset modes (--soft and --keep
I think) detect on in progress merge and refuse to run, I've got a patch
somewhere that extends that to cherry-picks. I should probably extend it
to handle --merge as well (are there any other modes, I only ever use
--hard/--mixed/--soft as I'm never sure what the others will do)

Best Wishes

Phillip

