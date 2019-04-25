Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971DB1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfDYKUe (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:20:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35957 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfDYKUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:20:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id b1so18184097wru.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S+uXJjaOKCts2YiiEZVHJsaY7sM9TsDkH/Ft76Mqb6I=;
        b=rDcAmSPDk3lPh2WdJOzC4NiVcFNwac6QajMpbpOX+BtoICt8TzWRs+i3gt1T0HIv3U
         HVFalOY3JvWkM+tk2J18acxIqznYC+jwBwqy6T6ZTGfP4plKqG50ms4ZAX2CQTs6wGbB
         r/vxZvvJ0YqhZuzKviQRNt95Kc9SNYf2QgoGtPc08SWIKFm4B6tKXPL1tVyVdnvMkuwl
         U5xSEJrIQgnCziJYssbWA2u2eWFg4meNGya0al6EMOPR3xrTkz2gSoar37SgaivpEb+H
         f9NC+vis7Yls3z7zAaDelxBKqojN/lJ8HxMeRlt6AfJ/tWBmVb/gc1jkYoh1umz1brJy
         fdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S+uXJjaOKCts2YiiEZVHJsaY7sM9TsDkH/Ft76Mqb6I=;
        b=Ur1q79es1zyBTrvEvRxFMhYIlet7jlMBgDnkkKcvusi9uwcgiH8sh1xtSv3K+mUhG/
         1fleDk6jLZBuNiB2LZgEsw9UKh7RSHhevB8jw2LuSTUOrBjfNqBEsUbowDwAqYiLzfXP
         qPQ8J8YmUQU8Xa3drzp4/yz8uX0yKzDC4RNwrRN4oR1O9mtzKBnCZ4QN89igR2PAimhS
         N6N5KoJNVLzE/ITRnw7VTcQfwwl5nnN1MBecQaIrNltdeqnmnO4W6FicQzMv2Kwv7aDs
         KeQBMLMBLNih2a10NJXbBkiRIAGw9bAm78MUWb0Of2glTsrOKyz775MyF14sA364a1zP
         w7+w==
X-Gm-Message-State: APjAAAW2xqX9GEiwMaZBDm27YMSncDgoA7H4NjW/d9m4bausKmw8aIfA
        WuTET+29c21978HJvZKo+Ok=
X-Google-Smtp-Source: APXvYqxfpFgznhbTpQP/UZ4Du/ROboJ0cdzzbjUTiKNCVDlp7TyV824H9UIiJSJKyVgTBbdFoytTrw==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr24596418wru.307.1556187631755;
        Thu, 25 Apr 2019 03:20:31 -0700 (PDT)
Received: from [192.168.2.201] (host-92-26-127-169.as13285.net. [92.26.127.169])
        by smtp.googlemail.com with ESMTPSA id g3sm3575371wmf.9.2019.04.25.03.20.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 03:20:31 -0700 (PDT)
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
 <42ba7f39-4a8e-9866-eebd-2a4dd5ff8414@gmail.com>
 <CABPp-BGE49LyxQSMd8v_af=X_N9b0GyOk6TMK6jb8w1GMy6x+g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <81a1e5d3-5396-f556-ac77-4115f352f391@gmail.com>
Date:   Thu, 25 Apr 2019 11:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BGE49LyxQSMd8v_af=X_N9b0GyOk6TMK6jb8w1GMy6x+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

Sorry it's taken me so long to reply to this - I'm not sure where the
last few weeks have gone.

On 29/03/2019 15:35, Elijah Newren wrote:
> Hi Phillip,
> 
> On Fri, Mar 29, 2019 at 4:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 28/03/2019 17:39, Elijah Newren wrote:
>>> On Thu, Mar 28, 2019 at 9:23 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> On 28/03/2019 11:04, Duy Nguyen wrote:
> 
>>>>> Just so we're clear, what is your "the way" to go? to remove
>>>>> CHERRY_HEAD_PICK and MERGE_HEAD (and other MERGE_* as well) if
>>>>> --ignore-in-process is specified? Or to leave MERGE_* and
>>>>> CHERRY_PICK_HEAD alone and delete other stuff?
>>>>
>>>> I was agreeing with Elijah about dropping --ignore-in-progress unless
>>>> there's a demand for it or at least restricting it so that it requires
>>>> --discard-changes and aborts in-progress merges and single in-progress
>>>> cherry-picks/reverts. (I'm worried about people switching branches when
>>>> cherry-picking more than one commit, though as you say it can make sense
>>>> during a rebase.)
>>>
>>> I understand the desire to prevent mis-uses, and I agree that if there
>>> are staged changes or conflicts it's really likely things will go
>>> sideways.  But I think we should instead check for those situations
>>> rather than use e.g. rebase vs. merge as a proxy for whether those
>>> problems could be present.
>>
>> When cherry-picking multiple commits if the user commits the conflict
>> resolution with 'git commit' then the presence of .git/sequencer is the
>> only sign that a cherry-pick is in progress (wt-status.c fails to detect
>> this, I've got a fix but no tests yet). rebase can also stop without
>> having conflicts or staged changes so I think we need to check for in
>> progress commands as well as conflicts (what do we want to do if someone
> 
> This whole discussion is about "--ignore-in-progress" which implicitly
> implies we are checking for in progress commands and choosing whether
> to override it.  So I don't understand what you mean by saying we need
> to check for it; isn't that a given?

I think I was confused "instead" above. Anyway we both agree that those
checks are in addition to the in-progress ones.

>> tries to switch in the middle of a bisect? - I don't have a strong
>> opinion). I agree switch should fail if there are conflicts, but I think
>> it is fine to switch with staged or unstaged changes if there isn't a
>> merge etc in progress (I quite often start working on something and
>> then realize I haven't started a new branch just before I commit). I
>> could possibly be convinced that silently switching with staged changes
>> is always a bad idea though.
> 
> I think we might be missing the big picture by trying to discuss
> things in terms of in-progress operations or conflicts or staged
> changes or unstaged changes.  Allow me to attempt to reframe the
> discussion:  We have identified at least one case where allowing the
> --ignore-in-progress flag would be unsafe, and we've identified one
> where we think it would be safe and useful, thus we need a rule of
> thumb for when it is safe to use and when it isn't.  Here's my
> attempt:
> 
>   --ignore-in-progress is safe enough for usage if we can switch to
> another branch and back with no net overall changes to either the
> index or the working tree after the two switches.

My worry is that someone will switch branches and commit by accident
before switching back again. Having said that we require them to specify
--ignore-in-progress so we have a safe default. I think your rule is
probably a good balance between safety and convenience, though it is
potentially confusing as it will allow --ignore-in-progress to switch
sometimes but not others.
> This rule could allow for the presence of both staged and unstaged
> changes (or maybe even conflicts in some alternate world where
> checkout/switch didn't necessarily error out on those), depending on
> if switch/checkout can operate without touching those particular files
> as part of switching.
> 
>>> I am especially concerned with the idea of
>>> having something like "git switch --ignore-in-progress
>>> --discard-changes" being used to quit merges or cherry-picks or
>>> reverts or even rebases. In my opinion, doing so is creating flags to > combine uncommon pairs of git commands (git <operation> --quit + git
>>> switch) in a way that is far less clear.  I think that's a bad route
>>> to go down, and we should keep the commands orthogonal
>>
>> keeping commands orthogonal is certainly clearer, if less convenient -
>> lets do it (assuming Duy agrees).
> 
> Yaay!
> 
>>> (if I could
>>> start all over, I'd also make reset and checkout and everything else
>>> stop modifying any in-progress state).
>>>
>>> Instead, I would either:
>>>
>>>    * Drop `--ignore-in-progress` for now.  (Although Duy had a
>>> meaningful usecase)
>>
>> I think it could be useful during a rebase, I'm not sure about any of
>> the other operations though.
> 
> I think it could be useful during some rebases, but it should not be
> allowed if the user can't switch back to the current commit with no
> net overall changes to the index or working tree.
> 
> Also, I don't see how rebase is unique here.  Rebase, cherry-pick,
> merge, and revert can all stop with conflicts, staged changes, and
> unstaged changes.  All of them can also stop without any one of those
> (e.g. cherry-pick'ing a commit which has been piecemeal applied
> already, merging a branch whose individual changes have already been
> cherry-picked and when the user has specified --no-commit, or
> reverting a commit whose changes have already been unapplied).  Thus,
> I continue to believe that which operation is in progress is
> irrelevant.  Either we shouldn't allow switching during any
> in-progress operation, or we should determine some other criteria for
> when it is safe to allow --ignore-in-progress.  Basing it on the
> operation would sometimes allow --ignore-in-progress to be used when
> it shouldn't be, and disallow it sometimes when it shouldn't.  I'm a
> fan of the rule I mentioned up above ("if we can switch and switch
> back with no net changes then it's safe enough to allow")

You're right that there is nothing intrinsically special about rebases,
it's just that in practice I think it is more useful in that case (I
don't remember wanting to switch branches while cherry-picking etc but
maybe that because I use them less). Having a consistent rule as you
suggest would be less confusing.

>>> OR
>>>
>>>    * Make `git switch --ignore-in-progress <branch>` leave all process
>>> state in place and switch branches, if we would otherwise be able to
>>> switch branches (i.e. there isn't dirty or conflicted changes in the
>>> way).
>>
>> I thought we allowed branch switches when there are staged or unstaged
>> changes, I don't think that is a problem unless we're in the middle of a
>> merge etc. I'm still not sure it's a good idea to switch branches in the
>> middle of a multiple cherry-pick, maybe we should print a warning.
> 
> I didn't say to disallow it if there were dirty or conflicted changes,
> I said to disallow it if there were dirty or conflicted changes *in
> the way*.  We don't allow branch switches when dirty changes would be
> overwritten or need to be merged, as that can't easily be reversed.  I
> think --ignore-in-progress should only be allowed when it can be
> easily reversed to get the user back to the right branch/commit.
> 
> This "no net changes" rule also reinforces (or is reinforced by) the
> other suggestion I made of having --ignore-in-progress be made
> incompatible with both -m and --discard-changes.
> 
> But I totally agree that switching branches during the middle of some
> operation should print a warning -- not just for cherry-pick, but for
> merge or rebase or revert too.  In all cases it'll be important to
> tell the user both that they could really mess things up if they try
> to resume the operation without switching back, and telling the user
> how to get back to where they used to be (in rebase's case, that'd be
> "git switch --ignore-in-progress <previous-commit>" while for the
> other three it'd be "git switch --ignore-in-progress
> <previous-branch>").

Giving the user instructions for how to switch back is a really good idea.

Best Wishes

Phillip
> 

