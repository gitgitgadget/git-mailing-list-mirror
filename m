Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E112C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7E461040
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhHCXoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhHCXoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:44:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB41C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 16:43:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n16so827765oij.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oQjTqas1tvJxGKURQwuwCDaZG90U1L05LUWJslZRAQ=;
        b=tMsBU8eQBBrmifUgtqGS2qfc7y/4fX+92r48aaIW0vG6WNoWwz431Daus+LtlMSsCQ
         i2qs2ALFBXcA6E8HXx211sx5jt+XYXQsK2FgbBgSS2cw6sn+fqKOFGijLmgJZTG1/tLc
         AWT1Dla35hE4CkD2+PaQEuOs60Pi3m4mIaNfYNch1TaIsZzb14IwlhiRyX9jj9oem3Mo
         Ksn3Mh/nD160jPSk8gfExcQwtEPEH6ceq4z9jRPE1j2AJv+72SlRZR2hjzYSFoQQnOmp
         63nkxhJu19L/y4d8pe3Qc0S2CzhebLrEHpeuiCZS+QAwMxW82HbhRUFjNU9BqzsoHqEl
         TLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oQjTqas1tvJxGKURQwuwCDaZG90U1L05LUWJslZRAQ=;
        b=HvRNpbkCsQq4cihcQ+hFP2cHRO5487xQUfrRXx43i44beLfxEvs/1h9bQY+gTspazG
         S5oRJzFd8KSupkdgNR+yZq1clO4TW0nU3NawULzhkpjrnIJNIhImBuAQrpHsbJB5VyPC
         v9nFaf58szHBl0al9XrAGlWNyucOCfrmbnBuiyI6WXE85KtxvAI4d665b22A1E4kqGY6
         Pi5MJWqTdamWBJ6EegYrO1eVBa0ykrNs4NPM9qpBHZKquCpUbSZsIPO+kv+b1G2aPcsR
         Fikj/VBuS7zOKF4M2VP4ePDaiCUpPHvmOokQj8Wz44/br0hOp3Euz+3mve9oTdq5lRMo
         9+6w==
X-Gm-Message-State: AOAM5329J6Pxc8ClFoDbkxveAnMB/spOvTSCcmClBq38oQonRx17urs0
        B1cdycV1pl7fPmjMmLQQZz9hPVdGScYliR1fW0g=
X-Google-Smtp-Source: ABdhPJwOjSsY7djVkP2/l2NPsG1rnUlqJ3Q+ojI9fZFuUvNaN6BeSdWlNFcKLDPh8i01SGNiiaeVO9UdO8oR24LGrQw=
X-Received: by 2002:aca:d644:: with SMTP id n65mr16111867oig.31.1628034227090;
 Tue, 03 Aug 2021 16:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <37a69fd2e0bdb7fba6b6c47c3edec0964165cb61.1628004920.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108040102220.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108040102220.55@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 17:43:36 -0600
Message-ID: <CABPp-BHzXWTiFukuibf0JXyBLx=6xDLxLU5Xsyra7sHvULOn_g@mail.gmail.com>
Subject: Re: [PATCH 09/10] Documentation: add coverage of the `ort` merge strategy
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 5:04 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-rebase.txt       |  7 ++++---
> >  Documentation/merge-strategies.txt | 14 ++++++++++++++
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index b4429954480..3e112011c6f 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -340,9 +340,10 @@ See also INCOMPATIBLE OPTIONS below.
> >
> >  -m::
> >  --merge::
> > -     Use merging strategies to rebase.  When the recursive (default) merge
> > -     strategy is used, this allows rebase to be aware of renames on the
> > -     upstream side.  This is the default.
> > +     Use merging strategies to rebase.  When either the `recursive`
> > +     (default) or `ort` merge strategy is used, this allows rebase
> > +     to be aware of renames on the upstream side.  This is the
> > +     default.
>
> Since this now talks about two merge strategies, I think "This is the
> default" needs to specify which of the two strategies is the default.

It does, but I agree the wording is a bit confusing.  "This is the
default" refers to the fact that "Using merging strategies to rebase"
is the default (as opposed to using git-am).  We can then list some of
the possible merge strategies and which are the default (which we did
in the second sentence).  However, diving into a discussion about
individual strategies might be out of place here.  It looks like that
was originally mentioned because that allowed rebase to handle
renames, but git-am -3 gained that ability well over a decade ago via
falling back to the merge machinery.  So perhaps we should just
simplify this to:

"""
Using merging strategies to rebase (this is the default since Git
v2.26.0).  Note that there are multiple merge strategies available,
and specific ones can be picked with the `--strategy` option.
"""

>
> >  +
> >  Note that a rebase merge works by replaying each commit from the working
> >  branch on top of the <upstream> branch.  Because of this, when a merge
> > diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> > index d21dbd1e051..d13d4a29875 100644
> > --- a/Documentation/merge-strategies.txt
> > +++ b/Documentation/merge-strategies.txt
> > @@ -96,6 +96,20 @@ subtree[=<path>];;
> >       is prefixed (or stripped from the beginning) to make the shape of
> >       two trees to match.
> >
> > +ort::
> > +     This is meant as a drop-in replacement for the `recursive`
> > +     algorithm (as reflected in its acronym -- "Ostensibly
> > +     Recursive's Twin"), and will likely replace it in the future.
> > +     It fixes corner cases that the `recursive` strategy handles
> > +     suboptimally, and is significantly faster in large
> > +     repositories -- especially when many renames are involved.
> > ++
> > +The `ort` strategy takes all the same options as `recursive`.
> > +However, it ignores three of those options: `no-renames`,
> > +`patience` and `diff-algorithm`.  It always runs with rename
> > +detection (it handles it much faster than `recursive` does), and
> > +it specifically uses diff-algorithm=histogram.
>
> Probably `diff-algorithm=histogram` should also be enclosed within
> backticks.

I'll fix that up.
