Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB3AC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 08:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiHLIhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiHLIhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 04:37:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C81BEA3
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 01:37:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w3so498308edc.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9GZfzy7jReyQDjdP55rN5bwPVVk6SKFjsFQBnc4BZlU=;
        b=CAC86xadCu5oiWtEmLYLf871Sc6oFO2b8/A/ztykgZsKAZ/0UFLhndgv55TUNXXYb+
         NLkF8eq6KwE3aUjqlB4ho78lGmcjyVNrP1feO7HOcw4/IUDIrlY1XNESvENK7o7bCR9w
         HzGJ8dgUdrSRVVykJCv1Kp8S07+psoC4qjUwego+Qj8shN1xVyc6GSQWpRlMPdPOBXiE
         3mtgJwGSmyq6n+0WhqP6aL4HXpB6Sh7/Hv2Zq4ETpzAQ5zGqqjgo5zrY93QyPsDxXD5R
         g1xvFpfOnmYs1OshrxDKJBRfpncw4B8jzbuh1hzbz7ZpheJETIT4sd4yLAYohdkauPd/
         F2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9GZfzy7jReyQDjdP55rN5bwPVVk6SKFjsFQBnc4BZlU=;
        b=adZZDvCSnAcXa2aku3j6Aj6fYM3d0UyYZAGBWxKkmcYqU0DVKEYf2B6KGTyGM9T8oG
         1rQL1gcFXIxN5IuUVfossGxrLYD2B5jf5La/QoUHwa4enR90SfdD4NRSnJygyegPe7Sw
         GmdDqo2WukFkNOhPPnAgeCgc0TYvoD5mbhfziTaCfHWws2RGVGw2JpyDSWA31b7TnQll
         BqWfLnrcfax68Hcm8yBzOVQjvwFJmvyq2iWZdH5beg27xzDEdmNCiN7KAdBPH4gQm7rL
         CsnNkOiT07Z+WjBJo+qzHlJtjnWCZlrAz9g9KOxrPRld15XBzKbkiIiIYO28MDD6g8JX
         eYYg==
X-Gm-Message-State: ACgBeo0+utl3GT06FwWBE4D2O/aUGUTfiwRYJl2QrvVygcwCG5jAI1Eb
        Kt/mcM2Q04jwXtq4ytcjFknXwpIipKeZGN2tKyL9MVVI1fTEOw==
X-Google-Smtp-Source: AA6agR5jkJChfX7QZTgaQ9sAcFtkWuxHG6m47JhK3QzqMpziSwjn4HIcaGPVjbBF5EwrEsP77Kdcf2v1glGWd3wxtdU=
X-Received: by 2002:a05:6402:5192:b0:43d:cc0d:6ea4 with SMTP id
 q18-20020a056402519200b0043dcc0d6ea4mr2589368edd.111.1660293433836; Fri, 12
 Aug 2022 01:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAO8o=D6p+aFOeRdTDHwPa1E+V45Uqh-TuSZbz0WU=rE-ksGj_w@mail.gmail.com>
 <CAO8o=D7QC71mnyKSceMpYJzVO4=POva=mJQ1bi0teUHPB9xesA@mail.gmail.com>
 <a4c937ed-ea89-0564-db64-f0634fe7eeee@kdbg.org> <xmqqzggag28x.fsf@gitster.g>
In-Reply-To: <xmqqzggag28x.fsf@gitster.g>
From:   Noam Yorav-Raphael <noamraph@gmail.com>
Date:   Fri, 12 Aug 2022 11:37:02 +0300
Message-ID: <CAO8o=D7Zf3W2BwYwx91SK8STgi+xRbvEnZtdWhLahj6e_t0ZUw@mail.gmail.com>
Subject: Re: Fwd: Idea: add --squash to cherry-pick
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank Hannes and Junio for your suggestions!

Another issue with using "git diff A...B | git apply --3way", besides
it not showing the commit messages, is that I wouldn't be able to use
a graphical merge tool that shows the entire source file. When I use
"git cherry-pick" and there are conflicts, I see the change in the
context of the entire file.

(I'm using this modification I made of the meld diff tool, which shows
4 panes, and helps me understand the cause of the conflict:
https://github.com/noamraph/meld)

My main problem with using "rebase -i" is that it would require me to
fix merge conflicts one by one, on each commit in which they appear,
instead of fixing all conflicts at once, treating the change from A to
B as one. It also requires manual editing for every commit between A
and B.

I think that the best way to do what I want using the existing commands is:

git checkout A
git merge --squash B
git commit --no-edit
git checkout @{2}  # Go back to where we were at the beginning. This
is not exact, as you're in detached HEAD state.
git cherry-pick --edit @{1}  # cherry-pick the squashed commit A..B

This allows you to fix the merge conflicts in one go, shows the entire
files causing the conflicts, and allows you to edit the commit
message, starting with the descriptions of all the squashed commits.

I think this also gives a pretty good explanation of what "cherry-pick
--squash" will do: it really is the analog of the "merge --squash",
but for cherry-pick.

What do you think? Did I explain my need to "cherry-pick --squash" and
explain its behavior?

If I do an experiment and try to implement this, would this help?

Thanks,
Noam

On Thu, Aug 11, 2022 at 7:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > That question on Stackoverflow asks "how to do X with Y". But Y (git
> > cherry-pick) is the wrong tool to do X (apply commits from a branch to
> > somewhere else in squashed form).
> >
> >    git diff A...B | git apply --3way
> >
> > would do what you want. You would have to come up with a new commit
> > message anyway, so cherry-pick would be of little use there.
>
> I do agree that cherry-pick is not the best solution for that XY
> problem, but in a typical undisciplined development work, it is not
> entirely implausible that pieces from original commit message may
> still be of some use, exactly the same way as people would want to
> use "squash" while "rebase -i".  Most commits may have completely
> unusable "oops fix", "worked more", etc. messages, but some of them
> may summarize what the past handful steps with such garbage messages
> have done, which may be worth salvaging.
>
> If I were solving the XY problem, I would probably use "rebase -i".
>
> To transplant the range A..B of the history on top of HEAD, for
> example, I'd start with (notice ^0 after B, as I do not trust myself
> so I'd leave the true branch B untouched as I may make mistakes
> while running rebase):
>
>     $ git checkout --detach HEAD        ;# this is only to use @{-1} later
>     $ git rebase -i --onto HEAD A B^0
>
> Then if my goal is to squash everything down into a single commit,
> then replace all 'pick', except for the first one, to 'squash'.
> That will give me one single chance to edit a single commit message,
> but the editor buffer starts with the log message from all of the
> original, so I can pick good bits from them while writing new stuf.
>
> I'll have the result on detached HEAD.  If I like the result, I may
> update the branch I was originally on with it.
>
>     $ git checkout -B @{-1}
>
> Or, if I don't, perhaps because I made mistakes, then I can just
> discard it and go back to the original branch.
>
>     $ git checkout @{-1}
>
