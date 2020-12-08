Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A8C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 23:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FEA23B23
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 23:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgLHXMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 18:12:28 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F055C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 15:11:48 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id s1so19814oon.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 15:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjoEKArDqLgepr0WTz2FHIgMvqg84uQoa4p2T0NsLWU=;
        b=rmXKQrDJpMbWWjIBa3yIhYvFM7xYn8mxYbIsgJV5HL0QKlZQ9iK6YgjTF8JZugjWtw
         8bVAFZaWfyLf8fDwon3NO1qFksxKAlpyH2Im64K0py5xVGnCMcInGlNB7uM9pKCyxeLf
         o2zjmhzuceQeE3/eS35uPLY6FNtlBf9Y2zn6es/ilfYj5BlI97FmbkNEatdMdNi4WOxj
         kB7zgWkz/O3KFx2ZFxbSTHdKgaDB056sKLJ5B0i+k4xDoNIsbppo47MQUKp8Oi2HLaR2
         OhBhFDTW+81+7apCS/je4csNTkxlKGHQTMmwZZRkC7E6OqE2Wp4R72x8BNEb+kYiX3+b
         ovDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjoEKArDqLgepr0WTz2FHIgMvqg84uQoa4p2T0NsLWU=;
        b=CKoQjRT2Tvdy5kiQiKCE6288Tr2s7mCeDalfW6ASZm2/vCawxNWQ3x4vOGmZAxOcRL
         Z39jQJshQe7orLdqKJlxRYRGCpnlJQi4FnErq017nVhMQM1oftERdP1A3Q4qSa3mSzEt
         SzgdqfwefNZ3bYv+NOf6D6uDm2FolgQIipBcpM9HuTVnzi8XE0sJ+/CSNOAZbI5s4f9h
         oDqdXKag7sJ4CeoVCo3mgBz9FxiDJf67KkIgN63TnxdmR6pK7FFPwEQZ7WT2MNMfDToC
         1ZHlhhjTR1yBvZuL6mC9gA2IdIBuiuA/ktTokrVSo54mrSMM9YLS3d24poSzruttIJuB
         II+A==
X-Gm-Message-State: AOAM533lJrl2ovaQOOw274+05kzqz5aBKugThloRW+AeCXaEvdG5FD2s
        6E7N5u9AymdsM6xLcvwi7wpFayY9mZPxEKZV9TA=
X-Google-Smtp-Source: ABdhPJzCYnUNzjPIqp8oEHGrT6zquhkSt1+R6fT3bYZSotOjMNvjsdlQJdLeY9oLDwoOi7LMQT98wy72Pll6FZoKYWo=
X-Received: by 2002:a4a:b4c4:: with SMTP id g4mr280123ooo.7.1607469107696;
 Tue, 08 Dec 2020 15:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <87y2i8dptj.fsf@osv.gnss.ru>
 <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com> <87y2i8c4mr.fsf@osv.gnss.ru>
In-Reply-To: <87y2i8c4mr.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Dec 2020 15:11:36 -0800
Message-ID: <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 2:30 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Hi Sergey,
>
> Hi Elijah,
>
> >
> > On Tue, Dec 8, 2020 at 12:07 PM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Sergey Organov <sorganov@gmail.com> writes:
> >>
> >>
> >> [...]
> >>
> >> > The series also cleanup logic of handling of diff merges options and
> >> > fix an issue found in the original implementation where logically
> >> > mutually exclusive options -m/-c/--cc failed to actually override each
> >> > other.
> >>
> >> Working further on this, I've noticed very irregular interactions
> >> between -m/-c/--cc and --oneline:
> >>
> >> 1. --oneline disables -m output for 'git log', and leaves -m output enabled
> >> for 'git show':
> >>
> >> $ /usr/bin/git show -n1 -m --oneline 2e673356aef | wc -l
> >> 80
> >> $ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
> >> 1
> >
> > If you leave off --oneline, you'll note that git show produces a diff
> > and git log does not (regardless of whether 2e673356aef is a merge
> > commit or a regular commit).  So, I don't think this is related to
> > --oneline.
>
> Yeah, looks exactly like this, thanks for correcting!
>
> >
> >> 2. For 'git log', --oneline disables -m output, and leaves -c/--cc output
> >> enabled:
> >>
> >> $ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
> >> 1
> >> $ /usr/bin/git log -n1 -c --oneline 2e673356aef | wc -l
> >> 16
> >> $ /usr/bin/git log -n1 --cc --oneline 2e673356aef | wc -l
> >> 16
> >>
> >> The question is: what's the right interaction between --oneline and
> >> -m/-c/--cc?
> >
> > I believe the right question is: Should -m be a no-op unless -p is
> > also specified?
>
> Right.
>
> > In the past, --cc and -c were no-ops except when -p
> > was also specified.  It was somewhat unfriendly and surprising, and
> > thus was changed so that --cc and -c implied -p (and thus would cause
> > output for non-merge commits to be shown differently, namely shown
> > with a diff, in addition to affecting the type of diff shown for merge
> > commits).
>
> Well, so one surprise has been replaced with another, supposedly more
> friendly, right?
>
> I mean, obviously, with --cc I don't ask for diffs for non-merge
> commits, so it is still a surprise they are thrown at me.

Actually, that wasn't a side-effect but part of the intended change --
see https://lore.kernel.org/git/1440110591-12941-1-git-send-email-gitster@pobox.com/.

> > I think -m was overlooked at the time.
>
> Looks like it was, but maybe there was rather an actual reason for not
> implying -p by -m? Maybe Junio will tell?
>
> >
> >> I tend to think they should be independent, so that --oneline doesn't
> >> affect diff output, and then the only offender is -m.
> >
> > I agree that they should be independent, but I believe they are
> > already independent unless you have more evidence of weirdness
> > somewhere.  The differences you are seeing are due to -m, -c, and --cc
> > being handled differently, and I think we should probably just give -m
> > the same treatment that we give to -c and --cc (namely, make all three
> > imply -p).
>
> I think that either all diff-merge options should imply -p, or none,
> from the POV of least surprise.
>
> However, it'd give us yet another challenge: for some time already,
> --first-parent implies -m, that once it starts to imply -p, will result in
>
>   git log --first-parent
>
> suddenly producing diff output for everything.

That is definitely a pickle.

> One way out I see is to specify that implied -m/-c/--cc don't imply
> -p, only explicit do.
>
> Entirely different approach is to get rid of -m/-c/--cc implying -p, and
> just produce diff output for merges independently on -p being provided
> or not. This will give us additional functionality (ability to get diff
> for merges, but not for regulars), and will get rid of all the related
> surprises.
>
> Thoughts?

I was happy when I found out that --cc had changed to imply -p; I
guess I felt the same as Junio did with his rationale in the link I
posted above.  I've made --remerge-diff behave like --cc (i.e. it
implies -p), and I like it there too.  I use it both to turn on diffs
for merges, and to turn on diffs for regular commits without having to
specify the extra -p flag.  I guess I'm not sure why one would ever
want to see diffs for merges and not for normal commits.  Even in the
unusual case someone did, couldn't they just pass --merges (to strip
out the normal commits entirely)?

I may not have the best vantage point on this, though, because I
personally don't see enough utility in diffing a merge to just one of
its parents that it'd merit having an option to git-log, and yet we
clearly have two such options already (-m and --first-parent when
combined with -p).

But, there is at least one more way to get out of this pickle besides
the two options you listed above: we could make --first-parent be just
about commit limiting and not imply anything about diff behavior.
Honestly, I find it a little surprising that despite the fact that log
-p shows nothing for merge commits, that when I add --first-parent to
see a subset of commits I suddenly get weird, huge diffs shown for the
merges (yeah, yeah, I learned recently that it's documented behavior,
so it's not surprising anymore, just weird).  So, this wouldn't just
get rid of this new nasty pickle, but would remove another negative
surprise too.  If we're going to make a behavioral change, I'd rather
we fixed this side rather than the (IMO) nicely working --cc/-c side.


Hope that helps,
Elijah
