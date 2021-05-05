Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D52DC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2B0610A0
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhEELse (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhEELse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 07:48:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFDC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 04:47:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l7so1666818edb.1
        for <git@vger.kernel.org>; Wed, 05 May 2021 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=L0oFUuNvPOaN7tK1+IjHSJ/Q6YIXgeFQv/L1eDgLTZg=;
        b=AKggdbIbgE90FaqLxvbTQ89L+/opmry4s70k0YQ66tv3fb3QATXSBydjJugGGiS8kJ
         yt85BdwSsCoI7mnN6OtcJXccD1b12j4XnYClrjaKLE3tRC91DDFtVqaRdnvrh1w98Rvj
         rwrtIqaYZy8BYYJYSqSZXTMmWyPVoK2GL4tyr/+q67WQHu8ECeGuL09k9q9sr3PD360H
         B9mEAL+YKRrpFLKQTAfbnhH+xil3WK4cOwkrtB5IGypVk72l+sxMz/yoIyBNWD64tv3x
         FjmntPQWFs8FX7tYqkQJKfClFnoPb6TC+nL7AeCL4653QxhHYyHuMn3AQmUepaUi7xCe
         vf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=L0oFUuNvPOaN7tK1+IjHSJ/Q6YIXgeFQv/L1eDgLTZg=;
        b=jgZ1N3I5CDHbwFAlRbU7aFYYX6REHRDwT0ifdjM2O0bq58S5G7EamGEg1UU0p6Gb7u
         1+T7jhozfkywN1V9escIPcS664yynNYum5zWdTAlD/hpT+XbQdfKCFmgcUrvvgVLLwHL
         t/qp8XtOnsxKD4UXN4PxJWOYAMiKAFX6SndPA034JPBfAxCNdL66HHhMQkRugLrozKIV
         KT0Lpd5Dbje5TxeFYmjkZ/5RmZH+3G9URNaig+spQum26xa0PW2CA6CDFTvkuc27huDT
         rjPGQ19PjzXcPwX99Wc3a04YD/5TSfo8kh6kWGbsrjnbdWGFxUhPvh+SmSPcsHdMmvPz
         EV5g==
X-Gm-Message-State: AOAM532ZAaw8jMs3JdzFbuc8ITcUHVePhE8pitHbUnbqA8U2tvjpbvw7
        ZaohwQwG4tXSYeo4sov9pMzpBVP5V6nIfg==
X-Google-Smtp-Source: ABdhPJz8t4smDmAhfgcKf0gqwSbQIK/KxaZliUPWvpMjnEqh/sJMHbFdGJ3iZIBImn+WeSYpOmWZ2Q==
X-Received: by 2002:a50:ee85:: with SMTP id f5mr32549395edr.8.1620215255222;
        Wed, 05 May 2021 04:47:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u11sm15836067edr.13.2021.05.05.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:47:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
Date:   Wed, 05 May 2021 13:09:47 +0200
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
Message-ID: <877dkdwgfe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 04 2021, Elijah Newren wrote:

> On Tue, May 4, 2021 at 3:36 AM G=C3=A1bor Farkas <gabor.farkas@gmail.com>=
 wrote:
>>
>> hi,
>>
>> the "git switch" and "git restore" commands were released two years
>> ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
>> BEHAVIOR MAY CHANGE.".
>>
>> i'd love to use them, but this warning gives me pause, perhaps i
>> should wait until it stops being experimental, i worry that it might
>> change in behavior unexpectedly and cause problems for me.
>>
>> considering that they were released two years ago, could the
>> experimental-warning be removed now?
>>
>> thanks,
>> gabor
>
> This probably makes sense.  The author of switch and restore isn't
> involved in the git project anymore.  He decided to work on other
> things, which was and is a big loss for us.  I think others (myself
> included) didn't know all the things that might have been in Duy's
> head that he wanted to verify were working well before marking this as
> good, but these two commands have generally been very well received
> and it has been a few years.  Personally, I'm not aware of anything
> that we'd need or want to change with these commands.

I am.

I think it's quite confusing that "git switch" doesn't switch to a new
"doesnotexist" branch on something like:

    git switch doesnotexist

But requires:

    git switch -c doesnotexist

I mean, I see why. You don't want a typo of "master" as "maaster" to
create a new "maaster" branch, so really that's out. But it really
should be:

    # -n or -N for --new / --new --force (the latter just in case of a
    # race, and just for consistency)
    git switch -n doesnotexist

The design choice of squatting on "-c" for "create" as opposed to "copy"
as implemented in 52d59cc6452 (branch: add a --copy (-c) option to go
with --move (-m), 2017-06-18) has the knock-on effect that we can't
mirror the "git branch" UI. I.e. to make "switch" be "branch with
checkout" for these common cases.

I.e.:

    # copies a branch and config from old->new (or -C for --force)
    git branch -c old new
    # just creates a "new" starting at "old", but no copying!
    git switch -c new old

And:

   # Moves a branch (or -M for --force)
   git branch -m old new

That last one we can't have either because "switch" squats on "-m" for
"--merge", which I daresay is a much more obscure use-case not deserving
of a short option than "rename and switch to".

In summary, I think it should be changed to act like this:
=20=20=20=20
    |---------------------------+------------------------+-----------------=
----------|
    | What                      | Now                    | New             =
          |
    |---------------------------+------------------------+-----------------=
----------|
    | Switch                    | git switch existing    | git switch exist=
ing       |
    | Error                     | git switch nonexisting | <no change (erro=
rs)>      |
    | Switch with --merge       | git switch -m branch   | git switch --mer=
ge branch |
    | Create                    | git switch -c new      | git switch -n ne=
w         |
    | Create from existing      | N/A                    | git switch -c ne=
w [<old>] |
    | Move & switch to existing | N/A                    | git switch -m ne=
w [<old>] |
    |---------------------------+------------------------+-----------------=
----------|

One thing that sucks about my proposal is that it would be squatting on
"-n" for "new" as opposed to "--dry-run".

It would be nice if switch/checkout learned a --dry-run mode, I don't
like e.g. "fetch" having a "-n" that isn't "--dry-run", but can't think
of a better option in the switch case.

In its current state I find "git switch" to be unusable. That sounds
like dramatic hyperbole, but I'm serious.

As much as I applaud the effort to move git's UI forward in this
particular case it's doomed to be only skin-deep because of that
unfortunate initial design choice of sort-of acting like "git branch
with checkout", but squatting on "-c/-C/-m".

I.e. to me the ideal end state would be to deprecate (or at least
warn/discourage) the "git branch -m" case where it does its own checkout
(but for nothing else), and to make "git switch" a "branch with
checkout" with the same -c/-C/-m/-M semantics, just also with a -n/-N
for "create first".

So at the end of the day you still have to use "git branch" for these
common (at least for me) operations of copy/move, *and* maintain a
mental model that "-c" means "xyz" here, but "abc" there.

The "switch" command also solves the very real problem (and I believe
this was the main motivation) of not knowing beforehand if "checkout"
will interpret your "foo" as a file, a branch or whatever. I find it
easier to solve that (I'm aware that it's not a 100% solution) by
consistently using "--" to escape path names, rather than needing to
mentally model the difference in "-c/-C/-m" behavior.
