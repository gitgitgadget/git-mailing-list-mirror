Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C258EC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B66D61626
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFORBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhFORBW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:01:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC4C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:59:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a26so18846470oie.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRj2c8Sw5I0LCHeWMsSnT+uJ10OL711kEJQCtVd4r+Q=;
        b=IUx1uuJGxeP8yLOCGQSgICYrQxrLroc0gNZ2JxodVzk2wf1LneqJ5lOK2UVU+RvBoO
         m3zeV+7jo7s0S0L2KXS+gI8r3RwAV3yo9Foehy/HRPb6UScxxaaRwukk6WcThVW1gcjD
         iupDMeUbrmd5jf65fAPrKmt82P76e1u4kVQ6xYO9LVE8/6uM1FD3a2qurvBKLo5vzgLU
         jvtcLtbHlOPYBzkrPlnwpZ6Xd50GSqdxcKearLkB5aDFZVKDQ+/DrtEhIxW8TlupntZ6
         pM0D+4NEIL+uUuoJSTNYzBdgfHsiuFTcAzju80R1Pz6JYTRJ3ROrrL6QnjjkfSFOkf6w
         OQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRj2c8Sw5I0LCHeWMsSnT+uJ10OL711kEJQCtVd4r+Q=;
        b=Md/kxOo5/aJzCHOEprjxxLXOofDNBFecNfzafsgWBW9Dfayr5nTUKWHTJ0KWJSMJZn
         JApLZb0sNah8YyLYmNrc2asiJbnR1YXM1/X3M1tMzZQifUzMm8wwoDvF0ILricdbz7OW
         yX+O9U7JVQ8rnqWrh3pr+1f6866FHIhwyAp2LApNt4pLnqK8v4OnjD0ufjV04UxWBFah
         MZpMn8L+L+Hm5Um4VuKi62+OpyKB61mExsFZW/PLXCweKciedxEkD6OqLxtLMcI26Kri
         CECAkQGumJiBeDknIxN1zDaTVxE++nxAyKhKpL8VGTsshE4448yw05GxrZNPi88KVExu
         nyDw==
X-Gm-Message-State: AOAM533yZMhaLvBIcxXFSDS1Y5iYZEtIUJDVS5i/Gi42365xai53MWyW
        7uTtUBI6Jp9E4OJuVtUEdEE7ZWH2QdPSsMhAM8o=
X-Google-Smtp-Source: ABdhPJzg7eOF4t0ffbt0WnXL5rjJIxYrCRLwm8pmwJ7pWgpZCr2OOT6dNye5bkffEYLiaX++bZfbxRMFOqyztcrHZv0=
X-Received: by 2002:aca:f482:: with SMTP id s124mr3914783oih.167.1623776356242;
 Tue, 15 Jun 2021 09:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net> <60c647c1d9b5c_41f452089@natae.notmuch>
 <60c677a2c2d24_f5651208cf@natae.notmuch> <xmqq7divzxrr.fsf@gitster.g>
 <CABPp-BFY7uU5Ugypv4xCHq+XHTc3UROWPdV1v-JbN7xBycDZTA@mail.gmail.com> <60c86ff87d598_e6332085b@natae.notmuch>
In-Reply-To: <60c86ff87d598_e6332085b@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Jun 2021 09:59:04 -0700
Message-ID: <CABPp-BGrKjpjb5epv1nXcvn4Z1OHP4Uf6G1f9FARmwUcFVa96Q@mail.gmail.com>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 2:16 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Mon, Jun 14, 2021 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Felipe Contreras <felipe.contreras@gmail.com> writes:
> > >
> > > > I found the problem, m->chg0 was not initialized in xdl_refine_conflicts.
> > > >
> > > > I'm not familiar with the area so I don't know if the following makes
> > > > sense, but it fixes the crash:
> > >
> > > Unlike the remainder of the xdiff/ directory, xdiff/xmerge.c was
> > > Dscho's brainchild if I am not mistaken, so I'm CCing him for
> > > input.
> >
> > This is going to sound harsh, but people shouldn't waste (any more)
> > time reviewing the patches in this thread or the "merge: cleanups and
> > fix" series submitted elsewhere.  They should all just be rejected.
> >
> > I do not think it is reasonable to expect reviewers to spend time
> > responding to re-posted patches when:
> >   * no attempt was made to make sure they were up-to-date with current
> > code beyond compiling (see below)
>
> What makes you think so?

I did a simple grep to see where "diff3" was mentioned in the codebase
to see if any of those needed a "zdiff3".  Among the things I found
was that although the original patch updated git-completion.bash,
there were additional locations within a current git-completion.bash
that referred to "diff3" that should also have a "zdiff3".  I know you
understand that part of the code.

> >   * no attempt was made to address missing items pointed out in
> > response to the original submission[1]
>
> The original submission caused a discussion with no resolution

The discussion ended with no resolution in part because there were
multiple items discussed that would need to be addressed.  Including
the one reiterated at the end of the discussion.

>, and
> edned with Jeff saying he wanted to try real use-cases and that that he
> wanted to use it in practice for a while.

That wasn't the end of the discussion.  The email you are referencing
occurred here: https://lore.kernel.org/git/20130307185046.GA11622@sigill.intra.peff.net/.
The end of the discussion was Junio quoting himself in order to
reiterate that "As long as we clearly present the users what the
option does and what its implications are, it is not bad to have such
an option, I think."  See
https://lore.kernel.org/git/7vip42gfjc.fsf@alter.siamese.dyndns.org/
and check the timestamps in the threadlist.

> >   * no attempt was made to handle or even test particular cases
> > pointed out in response to the original submission (see [1] and below)
>
> Those were sent *after* the series, except [4], which clearly states the
> *opposite* of there being a deal-breaker:
>
>   But again, we don't do this splitting now. So I don't think it's
>   something that should make or break a decision to have zdiff3. Without
>   the splitting, I can see it being quite useful.

This statement from Peff was incorrect; the zdiff3 patches made the
code do splitting of conflict hunks.  I would normally understand if
perhaps you didn't know his statement was incorrect and wouldn't have
had a way to know, *except* for the fact that this exact patch we are
commenting on that you posted is modifying the code that does conflict
hunk splitting.

Further, you stated at
https://lore.kernel.org/git/60c8758c80e13_e633208f7@natae.notmuch/
that you wanted to see conflict hunk splitting in a zdiff3 mode and
expected it.  So clearly conflict hunk splitting is relevant to you
even if it wasn't to Peff.

Peff and Junio spent several emails discussing conflict hunk splitting
in the original thread (with Junio raising the question multiple times
showing it was a concern of his), and Peff spent several emails
discussing that topic even assuming that code was never triggered.  In
contrast to Peff, you know that conflict hunk splitting is relevant
since you wanted it to occur, you saw the old thread where they
discussed that topic and length, and yet you made no attempt to
include a testcase (perhaps even using the one they discussed) to show
how the splitting works?  I find that negligent.

> >   * the patches were posted despite knowing they caused segfaults, and
> > without even stating as much![2]
>
> Whomever *knew* that, it wasn't me.

You knew that Peff had reported they caused segfaults.  He pointed it
out after making you aware of the zdiff3 patch; see
https://lore.kernel.org/git/YMI+R5LFTj7ezlZE@coredump.intra.peff.net/.
You also acknowledged having known of Peff's reports before reposting
the patches at https://lore.kernel.org/git/60c82a622ae66_e5292087f@natae.notmuch/

You may be correct to point out that you only knew Peff had reported
segfaults, rather than having verified for yourself that there were
segfaults.  But the fact that you took no action on the knowledge you
did have, neither trying to verify, nor asking if the segfaults still
occurred, nor even relaying those reports when reposting the patch, is
exactly the problem at stake here.  I find the lack of action with
respect to the segfault report to be reckless.

> >   * the segfault "fixes" are submitted as a separate series from the
> > patch introducing the segfault[3], raising the risk that one gets
> > picked up without the other.
>
> My v2 includes the patch.

Ah, so your plan was to post a v2 with the fix as well as *also* post
that fix elsewhere?  Okay, that makes me feel better about this item,
so I retract it.

> > In my opinion, these submissions were egregiously cavalier.
>
> If you make unwarranted assumptions everything is possible.

Which assumptions?  That you were splitting the segfault fixes into a
separate series and not also including them with the patch that
introduces the segfault?  That does seem unusual and would have been
nice if you had communicated your plans somewhere so others wouldn't
have to worry about that particular issue, but I agree that your
explanation does invalidate the fifth item from my list as a concern.

Unfortunately, that still leaves the other four.  It's unfair to
reviewers to post patches if you have not done due diligence.  I've
read other patches of yours and commented that I thought they looked
good, so I'm not just trying to pick on you.  You clearly have talent.
With regards to the zdiff3 patches, I've stated above why I think you
haven't done your due diligence.  Sometimes people make mistakes;
that's something that can be corrected.  What I find egregious here is
that even when Peff and I have pointed out how more due diligence is
expected and needed, you've dug in to explain why you think your
course of action was reasonable (both here and in
https://lore.kernel.org/git/60c82a622ae66_e5292087f@natae.notmuch/).
That in my mind raises your submissions from careless to glaringly
cavalier.  Further, it makes me suspect we may continue to see you
repeat such behavior.  That worries me.
