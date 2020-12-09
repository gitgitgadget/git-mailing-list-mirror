Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D7C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E529623433
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgLIJxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 04:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgLIJxm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 04:53:42 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F90C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 01:53:02 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id p22so840454edu.11
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 01:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGf1q52F7emFA9yc9jtn6O6WNrWyUT5IHH34C6KJVwo=;
        b=gct0AXeAYyz9Uc4xTWbwQXcBDE9HOToh5gJIIDIlradTRGsNV4CLIjiUfhKchacZXA
         jPAqzYupApo/1dWwlGKMec5M3TzYuJW8k1UOEhqrYXXi4VIgDTeSfW7PF5+qn89pFWKM
         QL19p833rRPwrdDXu4M5DLqg+Zixx2oMz+GeYJgtpguA2312PWayBuTNWY19mv+PWxlC
         qLqH5/w5Yhk8elSU9QfHh5shVtACG9STNW4t6dHz19iMDXZeZQh3R0/uFdJ80BHYN/yu
         SxaJz/ADJop4L0DuDa/ar4EWUZ2k6H3MVRGhTozxuLdvlFrwCJM+rNsPdXqrbTOfPsG7
         XwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGf1q52F7emFA9yc9jtn6O6WNrWyUT5IHH34C6KJVwo=;
        b=etKy4C1rdMiTcj3DlyyClw8MhYrOLTlzpC+UB1LXWuni3sj1mRRIgWmwHs0Gf0j8e2
         XL6XLZyL1+XtFXsdP0eymIfFc2vTjF+ImIf2yozSNiIVSya1wkQXUlU4WfcbsTf56Lxz
         aH/jWSfWlEQiWwKOMRqDexIpR8arfw8oe15UAVAPUOKZ6fwNB7gumGpNF9OOakeFkUkG
         pwr8q7C5FoXnGXc8xMmgZflGUE924tBxFN7KJIvw9hTWvUuC6f2m5Mmzu9S2daFLYTWZ
         GKRUXKdiZlROjLJ5aI/6Vh8hthChCRwZFx+AoyQIhGoAgk9hWOahuFUK3tsJw1aWa6FU
         sU/A==
X-Gm-Message-State: AOAM530Bf9EIYirGjToZ3ACN+q0wbHTMryaXfJ0IWaDDX9UQ7wMKUan4
        0JcQ9hio6YcA/ThBftm0//Hy6M907OVByiJM1U8=
X-Google-Smtp-Source: ABdhPJwlEYJgAQvgTubc3XmJorWektjrZdNxhVc9sjGQwzcWYe6AzivbazuNQnmqA4FZ2ncQzAmmmMhftxhJxztAeBc=
X-Received: by 2002:aa7:dd17:: with SMTP id i23mr1216804edv.14.1607507581176;
 Wed, 09 Dec 2020 01:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com> <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com> <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 03:52:49 -0600
Message-ID: <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 2:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > That is exemplified by the fact that this whole thread started from a
> > user that refused to configure pull.rebase and expected the Git
> > project to just do the right thing (which is basically choosing a
> > useful default).
>
> Which is basically asking for impossible, and I do not think it is a
> good idea to focus our effort to satisfy such a request in general.
> There is no useful default that suits everybody in this particular
> case.

I think I already made this point, but this is the nirvana fallacy
(the perfect is the enemy of the good) [1]. Just because we can't have
the perfect solution doesn't mean we can't pursue something better
than the current state.

What was asked was not a perfect solution, just a better default. If
right now the default is good enough for 20% of users, and with some
changes we can make it better for 40%... that's progress. We don't
have to wait until we have a solution for 100% of them.

> But for anybody who uses git for real (read: produces his or her own
> history), it would be pretty much a useless default that forces the
> user to say rebase or merge every time 'git pull' is run.

This is not true.

I will give you a real example.

I create a branch named "fc/margin" based on "master", I make my
changes, I push the branch to my personal repository, and create a
pull request. This is the typical triangular workflow.

Then I do "git pull [--ff-only]". What will happen? 1) As long as my
branch is not merged upstream, I will get an error, and my branch will
stay where it is. But then, 2) when my branch is finally merged to
"master" it will be fast-forwarded, so now both "fc/margin" and
"origin/master" point to the same commit.

A. Did I use git "for real"? (produce my own history)
B. Was "git pull [--ff-only]" useful in this case?

I think that one of the problems is that Git has so many different
workflows that finding another person that has your same workflow is
like finding a person with your same birthday. It's not impossible,
just takes more than a few tries.

Also, and this is not a deriding question, I'm genuinely curious: how
often do you send pull requests?

BTW, this example above is real [2]. In my particular case very often
I'm creating history, I'm just not the one pulling it.

> But other than that, I do not
> see any real use for the choice, which would mean in practice,
> pull.mode would have only two useful values, rebase or merge.  That
> does not feel a good enough reason to supersede what already exists,
> which is pull.rebase=yes/no.

The fact that you don't see the use doesn't mean the use is not there.

Why do you think this issue keeps coming back again and again, and
again? And every time it comes back people say the same thing:
"fast-forward-only merges should be the default".

Unfortunately it's not that simple. It's a rabbit hole that leads to a
cacophony of issues in git pull. However, we can fix some of them
*today*.

> Perhaps there is a good reason why certain classes of users would
> want to configure pull.mode=ff-only (i.e. "I might type 'git pull'
> by mistake, please stop me if I did so on a branch I have real work
> already.").  If that is the case, I would very much agree that it
> would be awkward to express that choice in the current framework to
> choose between pull.rebase=yes/no and pull.mode=(rebase/merge/ff-only)
> would become a lot easier to explain.

There's three options:

1. pull.ff=only (that doesn't work IMO)
2. pull.rebase=ff-only (that works, but it's kind of wonky)
3. pull.mode=ff-only (maybe it should be pull.mode=fast-forward)

But the current option (pull.mode=merge) just doesn't fly. And BTW, I
did create a poll in reddit's r/git [3], and 67% (of 789) said they
didn't specify anything, just "git pull".

So, most people simply do "git pull" and hope for the best.

Moreover, in 2014 I said if we don't fix it now (which is likely), we
will be discussing it again [4], and here we are now. And I'm saying
it again: leave the mode as "merge", we will be discussing this again.

I could do some mail archeology if you want, but this issue starts to
be mentioned at least since 2010, and virtually everyone (except one
person) agreed the default must change, even Linus Torvalds. Reading
back what Linus said [5], it's something very, *very* close to what
I'm proposing (I would argue my proposal is better).

So you let me know. Do you want me to dig a decade of discussions and
coalesce those conclusions into a summary so we can decide how to
proceed? Or should I drop the plan? Only that if we drop it, I
*guarantee* we will discuss it yet again years later.

Moreover, this is the reason why I split the series in 3. Even if you
decide you don't want to change the default, part I of the series can
still be merged *today*, and everyone would benefit.

Cheers.

[1] https://en.wikipedia.org/wiki/Nirvana_fallacy
[2] https://github.com/git/git.github.io/commit/5d90fd64d80847e3d873da43515750bc04b639e2
[3] https://www.reddit.com/r/git/comments/k6uj7c/do_you_use_git_pull/
[4] https://lore.kernel.org/git/536429e97cf5a_200c12912f094@nysa.notmuch/
[5] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/

-- 
Felipe Contreras
