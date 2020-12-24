Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A4BC433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94D022517
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgLXAOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLXAOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 19:14:48 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF3AC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:14:08 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d11so583549qvo.11
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrFKosXkBdCKJlU+SaNNyB/aWae8Gi9YVpZhuIkydU4=;
        b=bpLTjy3tlTwRacz+vxqizZ6gEM+XSMnDuMy0Yv0vbyX/A9/sxcDw6kALe0Sn8dPewT
         3nb/zIiyX3C+ex3OivYBVACPTshm+KrvKhw6/WVbd/bn27sPIop2Es+AXjzAMgrujGM+
         jPmaDbPkyPQ5D8iGhfUtBLcizZ9rWi8aNCkK4c8o8MRMs1xng1NrOFzD6tyn52PytutW
         Vag53t8BbQhl4AeM9hhKUKjTP+viYPlTjd3/Wie46DRhS4s9Yi3q/79dce6ukh8bh2Rh
         bUwpU3TuiEv9uBlJPNjoLrApKs1bWKZ4sh8hrZp6lWvjWfDZlUalb+i3Kk35a1lyXz4z
         iR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrFKosXkBdCKJlU+SaNNyB/aWae8Gi9YVpZhuIkydU4=;
        b=Yjy6Dh6iZOtwp8R03oHDnR5GS+D2dVjopAi5zEhSN9euTbPUICRmdnX0d7LvZR31tj
         BG6biPxTZkmNG4ViRhHNVxv+VxJkeAsC/1j5hZotv8cFQbHlcEixOgmIzpF3v9a7ZNF5
         /B3FeZ1oi8LCSVtsH8SpKX4jqm7/bafZf+p0OBJGD+8sHscef0uFNCTVxcDeRDAdGkCY
         ifvwQYQ8Q+aghzhGo77bAEfYchIFgNSJrVhfwT2yYAxhFTDkhLsQBpalTX9zMP72kx9L
         yUJjeTULHrqzceahfR9IATyJluK7DcFm/fLX3fIVlgRct52FPDjOYUhXwDhzfz66D5r+
         MfAQ==
X-Gm-Message-State: AOAM530eDL+JUw5NLz2GoZ23I2Bh4PShnljGXlD2/xJoAvNhs9ngh1sZ
        +Pd4gv1WsyZKM6yRJ2p9Etl8/1q4ARKGJrxmHoCCcsBkMZQ=
X-Google-Smtp-Source: ABdhPJyYicvwL8yp9apoBcO8qYtYQ+EYZ0X+K2wHAETKqnUcU+V81nAJaNX1hUAmT2wyrztfNHnNd7LOK2oQZsfFIDI=
X-Received: by 2002:a05:6214:cb:: with SMTP id f11mr29753691qvs.15.1608768847461;
 Wed, 23 Dec 2020 16:14:07 -0800 (PST)
MIME-Version: 1.0
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
 <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com> <xmqqczz05b4x.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczz05b4x.fsf@gitster.c.googlers.com>
From:   Mike McLean <stixmclean@googlemail.com>
Date:   Thu, 24 Dec 2020 00:13:56 +0000
Message-ID: <CAM0jFOfSE3_TQ7WXiR_G6eHOZnr-0ryv=CniXs4sxs1=JnucUg@mail.gmail.com>
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree that "realism and frequency of use case" is a critical metric :D

For me it's very much the 2nd case you described and there are 2
scenarios that it comes up in most frequently:

1) WIP commits.
For whatever reason I want to create a commit even though the work is
nowhere near ready or functional. It's not that I've done part of the
task and there's a separate extra bit pending - I'm just creating a
temporary save point.
Maybe I'm putting work down in the middle due to some external factor.
(Perhaps a colleague needed some help for something, for which jumping
over onto their branch was the most useful thing to do. Perhaps a
blocking bug was just found in our UAT that needs a 2 line fix put in
right *now*. Whatever... :D)
Or Maybe I'm part way through some work and want to attempt a
different approach but I want a "save point" if I get part way through
and decide I was right the first time.

Whatever the case, I've created a WIP commit because I don't want the
hassle of crafting a good commit message right now. When I come back
to it, I forget there was a WIP commit, and finish the work and create
a sensible commit message. When reviewing my commit history prior to
review, I notice the WIP commit and want to squash it into the final
commit.

2) Interactive rebases
I make heavy use of interactive rebases, in order to make committing
be a REALLY low effort task. If I don't have to clean up my commits
when I make them, then I can commit really easily, which means I
commit frequently, which is a good thing :D But then I have a messy
git history. Especially if I'm juggling a bunch of small fixes at
once, and I end up with bits of one fix/refactor in a commit that was
mostly about another thing.

Not a problem: Interactive rebase to the rescue!

I use `edit` mode to split stuff apart and then squash mode to push
the relevant bits back together again.
But a downside of this is that frequently I end up with the commit
with the good message being *after* the scrappy bit that's just been
split off from another commit.
Sometimes I can just pull that scrappy bit past the main commit and
then `fixup` that bit, but often that would cause merge conflicts, so
it'd be easier to have a fixdown that does exactly what I'm going to
do with `squash`.

=-=-=-=-=-=-=-=-=-=-=

I recognise that these might be very niche or non-standard usages, and
if you don't think there would be much demand for such functionality
then I'm fine with that :D
Just figured I'd throw it in and see whether there was an appetite.

On Wed, Dec 23, 2020 at 11:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Mike McLean <stixmclean@googlemail.com> writes:
>
> > Can we have a similar convenience-command that squashes, and retains
> > the second commit's message? Purpose is the same as the fixup command
> > - saving a bit of time and unnecessary typing during a common
> > operation.
>
> We can view "fixup" as a slight variant of "squash" that gives us
> the right tree by applying the change in the second commit while
> reusing the message from the first commit, and the reason why its
> existence makes sense is because it often happens that users find
> small mistakes in the committed content that needs "fixing up" but
> the small mistakes do not change the intent of the original change
> so the message does not need any "fixing up".
>
> It also often happens that users find small mistakes in the log
> message text that needs "fixing up", but there is no need to change
> the committed content (iow the recorded tree object), and that is
> why "reword" is a useful command to have.
>
> You are bringing up another variant of "squash" that gives us the
> right tree by applying the change in the second commit while
> discarding the message from the first commit and replacing it with
> the message from the second commit.  Can we justify existence of
> such a mode in a similar way (like I showed above to justify why
> "fixup" and "reword" make sense)?
>
> What is the most unclear to me is where the log message in the
> second commit comes from.  Was it first copied from the first commit
> and then edited?  IOW, did the user do something like this?
>
>         $ work work work
>         $ git commit -e
>         ... record and explain the work of the first commit
>         ... with sufficient detail
>         $ work a bit more to fix things
>         $ git commit -c HEAD
>         ... record and explain the work of both the first and
>         ... the second by copying the existing first commit's log
>         ... and expanding to cover what the user further did
>
> Or did the user do something more like this, in which case the log
> message of the second was written pretty much from scratch to cover
> work done by both commits?
>
>         $ work work work
>         $ git commit -m snapshot
>         ... record but give it a meaningless and expendable log
>         ... message
>         $ work a lot more to advance
>         $ git commit -e
>         ... record and explain what was done on the branch as
>         ... a whole; the log message of this commit fully describes
>         ... what the both commit did
>
> Both workflows may benefit from such a feature, but at the same
> time, it is unclear how realistic they are.
>
> If two commits did comparable amount of work with similar
> complexity, it would be more realistic for them to have their own
> explanation that is usable as a part of the final, squashed commit,
> and that is why "squash" exists.  It just is not obvious when the
> new variant would be useful.  Especially if the workflow it expects
> to support is the latter kind I gave (i.e. the user delays writing
> meaningful log message until the last commit in the series and then
> squashes everything down to one), it smells good enough to use
> "squash" and get rid of a few lines at the beginning.  So there must
> be some realistic workflow that benefits from the new variant, but I
> do not think of one myself.
>
> When such an explanation is given, I may agree that such a mode is a
> good thing to add, but "similar to fixup" does not look like a good
> enough reason.
>
> Thanks.
