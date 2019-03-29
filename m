Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B5120248
	for <e@80x24.org>; Fri, 29 Mar 2019 11:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfC2LEZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 07:04:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40256 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfC2LEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 07:04:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so2302869wmi.5
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3w76EN3cIPf4GKF8dGVLy75BjgaklC6t14G0TfR1jXE=;
        b=AKJ/IJTJkt2oDidSlL9Qtaj0EjjMOffsbJIt/hVKkmYqrvXVEfBpEcpGWcx9rNMDo0
         WapYCqzDegWQI5gxq5IXHKJ7Yc58kxS2EVOT7rntgFk5NnYXGD9nUm3e0i9JYQs3l6SL
         /4u6jInxfpXeV9yQW/v5RGWM0Zdrq7hVERDWgdjeycW8mnezRNecJr10rZk1o7o700/l
         9jAGLav8YdfbCP2BLxbXlZ4Wv5wXVJiF48xsCVOUb6jg8xa2P9CXX2R04JHzyTfPmlvy
         5XKlEnuSHy8TEaqcRgXSw7X0C25vyKjR76qCY0geLmLw5FrYJ8n2BtxxzXPDRSY9WQPO
         OZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3w76EN3cIPf4GKF8dGVLy75BjgaklC6t14G0TfR1jXE=;
        b=O9SGxVbAFL4SNmkjiAf4EM7yVcExRzXjgdGizOS/saslpZFSM+aTFIlvttJXiHFjqp
         NYB2aNccTi9ZHL3/TcYbH189L4+FdbIzBbt+WAHkUGU1jVBRVMRbij2/UhMlGYSfhBJh
         AgOQJSic2RuEU/xm3CyfiO+iFCzRZIm2P0I0tBZ3N9nXyzepED9u4tGWrGqHHegyYaEd
         8F539z8c1GDn/pbj8xTvfEWf3qPSxGToDadSTR8+SAgScPbdvAKcJsXyav/sVY/mjj97
         QPUFeP48ufrpfWB5i+ClthLnxGLRK0p5r7NT0AgPRyU69XRTwSvj9UWQ03wKQ4xk5+35
         87eA==
X-Gm-Message-State: APjAAAUw2Pu0owFZfpn/AW6Vr4Vs7d7wrFsk3W/jvOt1BWwurwYi3XxS
        nmAJbvrLq9Pe3LXXsLokl2M=
X-Google-Smtp-Source: APXvYqzq7zSlwq41/ruU/BlXhBqgYsfUGr0S4S8zACrHTdfB868HcaBlMUwa6ENfcG+JIw+URwZHvg==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr3401067wmj.22.1553857462306;
        Fri, 29 Mar 2019 04:04:22 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-191-183.as13285.net. [89.242.191.183])
        by smtp.gmail.com with ESMTPSA id c16sm1528780wme.31.2019.03.29.04.04.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 04:04:21 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
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
 <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com>
 <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
 <a68ce0b4-81c5-e889-fc90-ed8b17a10d4a@gmail.com>
 <CABPp-BHsD=o=3jPKH6gH+XbEdNVqzhr18BSfupbaSNpxAgaqdw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <42ba7f39-4a8e-9866-eebd-2a4dd5ff8414@gmail.com>
Date:   Fri, 29 Mar 2019 11:04:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CABPp-BHsD=o=3jPKH6gH+XbEdNVqzhr18BSfupbaSNpxAgaqdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 28/03/2019 17:39, Elijah Newren wrote:
> Hi Phillip,
> 
> On Thu, Mar 28, 2019 at 9:23 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 28/03/2019 11:04, Duy Nguyen wrote:
>>> On Wed, Mar 27, 2019 at 5:24 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> On 26/03/2019 15:48, Elijah Newren wrote:
>>>>> On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>>>>> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:
> 
>>>>> Yes, and in the middle of a cherry-pick with a range you've added some
>>>>> commits to one branch and some to another.  In the middle of a revert
>>>>> you're doing similar.  It sounds like crazytown to me (and maybe we
>>>>> shouldn't provide the --ignore-in-process flag unless users clamor for
>>>>> it
>>>
>>> I missed this part in my last reading. I think if we could safely
>>> switch away and get back to resume, then --ignore-in-process could
>>> still be useful.
>>
>> If we can get back safely then that makes sense, I'm not sure about
>> switching while there are conflicts or staged changes though, it feels
>> like there's more potential for things to go wrong there.
> 
> I really like that way of putting it; I think that makes it much
> clearer.  Note, though that staged changes and conflicts could happen
> with any of rebase, merge, cherry-pick, or revert, so this problem is
> not limited to a subset of those operations.

Indeed

> 
>>> I sometimes switch to another commit to check out
>>> stuff then back. For interactive rebase with "edit" command for
>>> example, it's quite safe to do so. (yes the other option is "git
>>> worktree add", but that could be a heavy hammer sometimes)
>>
>>>> I think that could be the way to go for merges and cherry-picks, or
>>>
>>> Just so we're clear, what is your "the way" to go? to remove
>>> CHERRY_HEAD_PICK and MERGE_HEAD (and other MERGE_* as well) if
>>> --ignore-in-process is specified? Or to leave MERGE_* and
>>> CHERRY_PICK_HEAD alone and delete other stuff?
>>
>> I was agreeing with Elijah about dropping --ignore-in-progress unless
>> there's a demand for it or at least restricting it so that it requires
>> --discard-changes and aborts in-progress merges and single in-progress
>> cherry-picks/reverts. (I'm worried about people switching branches when
>> cherry-picking more than one commit, though as you say it can make sense
>> during a rebase.)
> 
> I understand the desire to prevent mis-uses, and I agree that if there
> are staged changes or conflicts it's really likely things will go
> sideways.  But I think we should instead check for those situations
> rather than use e.g. rebase vs. merge as a proxy for whether those
> problems could be present.

When cherry-picking multiple commits if the user commits the conflict 
resolution with 'git commit' then the presence of .git/sequencer is the 
only sign that a cherry-pick is in progress (wt-status.c fails to detect 
this, I've got a fix but no tests yet). rebase can also stop without 
having conflicts or staged changes so I think we need to check for in 
progress commands as well as conflicts (what do we want to do if someone 
tries to switch in the middle of a bisect? - I don't have a strong 
opinion). I agree switch should fail if there are conflicts, but I think 
it is fine to switch with staged or unstaged changes if there isn't a 
merge etc in progress (I quite often start working on something and 
then realize I haven't started a new branch just before I commit). I 
could possibly be convinced that silently switching with staged changes 
is always a bad idea though.

> I am especially concerned with the idea of
> having something like "git switch --ignore-in-progress
> --discard-changes" being used to quit merges or cherry-picks or
> reverts or even rebases. In my opinion, doing so is creating flags to > combine uncommon pairs of git commands (git <operation> --quit + git
> switch) in a way that is far less clear.  I think that's a bad route
> to go down, and we should keep the commands orthogonal 

keeping commands orthogonal is certainly clearer, if less convenient - 
lets do it (assuming Duy agrees).

> (if I could
> start all over, I'd also make reset and checkout and everything else
> stop modifying any in-progress state).
> 
> Instead, I would either:
> 
>    * Drop `--ignore-in-progress` for now.  (Although Duy had a
> meaningful usecase)

I think it could be useful during a rebase, I'm not sure about any of 
the other operations though.

> 
> OR
> 
>    * Make `git switch --ignore-in-progress <branch>` leave all process
> state in place and switch branches, if we would otherwise be able to
> switch branches (i.e. there isn't dirty or conflicted changes in the
> way).

I thought we allowed branch switches when there are staged or unstaged 
changes, I don't think that is a problem unless we're in the middle of a 
merge etc. I'm still not sure it's a good idea to switch branches in the 
middle of a multiple cherry-pick, maybe we should print a warning.

>  BUT, make sure to also:
>    * Make '--ignore-in-progress' incompatible with both '-m' and
> '--discard-changes'; if folks try to use either of those additional
> options with --ignore-in-progress, tell people to use `<operation>
> --quit` first.

I think of --discard-changes like --abort. --quit only removes the state 
dir so would pair with -m, as it does not reset the index or working tree.

Overall I think we're more or less in agreement modulo the treatment of 
staged changes when there is no merge etc in progress.

Best Wishes

Phillip

>  Do NOT provide an override. (Alternatively, refer to
> `<operation> --quit` as the override, since it is).
> 
> 
> Elijah
> 
