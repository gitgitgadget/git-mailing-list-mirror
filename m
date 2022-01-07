Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E69AC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiAGTQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiAGTQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:16:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD76FC061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 11:16:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c71so14255907edf.6
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSBKWZohUvf5BIMRV+TNrrN4KmS3Ngi4WmTJWIj27M8=;
        b=K9ieXofSuissg1Em4HWnzlAaTA0y48UDn7ULyDr6qE4uhohyKi1UPp9n0OaxL1jbuE
         liRGikHTHMpglixJ3O1BrN8/Ap75NabM8zF5SB5gAYRRgD89+xInynQW+IXNNI9mFXcV
         vNp1TTdSiCRkMY4hI44ZmRrvkSi6EnsBGcrPM5YZrOMWCQ/6DHocB6ut6rMr05wcAPF2
         7lg1f74cPx0iPCreQiXy+xLlw4WpoMclxik03E6FIn/Qqutbehf+ePkFSD0nuvrPjlCv
         EKF1XsSU8lu1XHVbMrMiipyw5Cwa0C8TPMaZR18WMSwlz/o2n2CHd/BNj1NbX31kMzmt
         iysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSBKWZohUvf5BIMRV+TNrrN4KmS3Ngi4WmTJWIj27M8=;
        b=15ayQOkbEOTn2CkRV+1ejt82iy0gVxTOL3GA/9+uM5sGL1SjAmLosDi6uG0f0BbrAB
         xhZ9W8LAQz5tg8WAVSrLI0kS6XchDxKVUe05FlMf8Ehq2Ll51Zyw585iYZu8UTDMHTim
         Wk7FhHrNx6umfUx91cbfco3bLgAgMKCcmC5KfCGy5+6MhRA7n7LDkQD5A0/UIeAMUqzK
         SUfHAT8imGvdVk98JiSHNLTjT8nVL5GrmXsK+2dNka/5r+CF+J73k2j87UCyKvV6yL6A
         t4DPLe3+iVrrX5wDHM9mlo5QT6Z0p+jOA0qOy1MTsRPqJo7xWVveoN1R6tocQRQ+kTr5
         ED2Q==
X-Gm-Message-State: AOAM530HvheyYopg5GHDzd8IOcfar6CsJUk5+RcR+hld+4q/2LzWbj0k
        rf3Jw0nfqgG8PscvPrJpRhNbaCiSQTmyCls4HLDWT6Vq4YI=
X-Google-Smtp-Source: ABdhPJyqGkNzsifslmwWbzxcfS3BTCqFpClcvq720qCY+xLBs//gMZd5eiwTxPitiAqcBT6fU6LbvgULKZoG4X3ZiMw=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr50349561ejc.192.1641582966312;
 Fri, 07 Jan 2022 11:16:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaqbjf.bet> <CABPp-BFUJ6pU_CKM7ccnFvi0nkeeGfd2GETdksKLaz=B_=BZAQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201071915290.339@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201071915290.339@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 11:15:54 -0800
Message-ID: <CABPp-BHKxOodfVsoH9sS1FkS4=zL4Oh0NCfRExyZtJz_5YvFUw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Jan 7, 2022 at 10:23 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Fri, 7 Jan 2022, Elijah Newren wrote:
>
> > On Fri, Jan 7, 2022 at 7:30 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:
> > >
> > > >  SYNOPSIS
> > > >  --------
> > > >  [verse]
> > > > +'git merge-tree' --real <branch1> <branch2>
> > > >  'git merge-tree' <base-tree> <branch1> <branch2>
> > >
> > > Here is an idea: How about aiming for this synopsis instead, exploiting
> > > the fact that the "real" mode takes a different amount of arguments?
> >
> > My turn on the grammar thing: s/amount/number/.   :-)
>
> See? I know why I'm refraining from nitpicking. It's just not good for
> anyone involved.

Well, in your case, the point you brought up will improve the commit
message for future readers, and so it was totally justified (and I'm
glad you brought it up).  My comment is useful for nothing more than a
bit of good-natured ribbing.  But I'm not sure it was taken that way,
so I'm sorry if my comment had any effect other than making you smile.

> > > > diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> > > > new file mode 100755
> > > > index 00000000000..f7aa310f8c1
> > > > --- /dev/null
> > > > +++ b/t/t4301-merge-tree-real.sh
> > > > @@ -0,0 +1,81 @@
> > > > +#!/bin/sh
> > > > +
> > > > +test_description='git merge-tree --real'
> > > > +
> > > > +. ./test-lib.sh
> > > > +
> > > > +# This test is ort-specific
> > > > +GIT_TEST_MERGE_ALGORITHM=ort
> > > > +export GIT_TEST_MERGE_ALGORITHM
> > >
> > > It might make sense to skip the entire test if the user asked for
> > > `recursive` to be tested:
> > >
> > >         test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort ||
> > >                 skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
> > >                 test_done
> > >         }
> >
> > The idea makes sense, but it took me a bit to understand this code
> > block.  I think you're just missing an opening left curly brace right
> > after the '||'?
>
> Yes. Sorry.
>
> > > > +test_expect_success setup '
> > > > +     test_write_lines 1 2 3 4 5 >numbers &&
> > > > +     echo hello >greeting &&
> > > > +     echo foo >whatever &&
> > > > +     git add numbers greeting whatever &&
> > > > +     git commit -m initial &&
> > >
> > > I would really like to encourage the use of `test_tick`. It makes the
> > > commit consistent, just in case you run into an issue that depends on some
> > > hash order.
> >
> > I've used test_tick before, but I already know this test can't depend
> > on hash order.  Further, the hashes in the output are also replaced
> > before comparing in order to make the tests also work as-is under
> > sha256.  So the tests are explicitly ignoring precise hashes.  As
> > such, I'm not sure I see the value of test_tick here.
>
> Nevertheless. To make comparing logs of two different test runs easier, it
> makes more sense to insist on consistency.

Ah...comparing logs between two different test runs; that sounds like
a reasonable justification.  I'll add the test_tick's.

> > > > +
> > > > +     git branch side1 &&
> > > > +     git branch side2 &&
> > > > +
> > > > +     git checkout side1 &&
> > >
> > > Please use `git switch -c side1` or `git checkout -b side1`: it is more
> > > compact than `git branch ... && git checkout ...`.
> >
> > Yes, but less forgiving to later modification where I go and add
> > additional commits on one of the sides, because...
> >
> > >
> > > > +     test_write_lines 1 2 3 4 5 6 >numbers &&
> > > > +     echo hi >greeting &&
> > > > +     echo bar >whatever &&
> > > > +     git add numbers greeting whatever &&
> > > > +     git commit -m modify-stuff &&
> > > > +
> > > > +     git checkout side2 &&
> > >
> > > This could be written as `git checkout -b side2 HEAD^`, to make the setup
> > > more succinct.
> >
> > ...the presumption of HEAD^ is hardcoded and has to be parsed by
> > readers to understand the test.  It felt like more cognitive overhead
> > to me, in addition to being less malleable.
>
> Right. Different developers, different preferences. I wish we had a
> standard way in the test suite to initialize a test setup that _everybody_
> could agree to be succinct and helpful. So far, we use shell scripted Git
> commands to recreate an initial commit topology, but especially when
> comparing to existing test suites with fixtures that are not only
> well-documented but also easy to wrap your head around, I find Git's test
> suite awfully lacking. Mind you, the code _I_ introduced isn't stellar in
> this respect, either, not by a very far stretch.
>
> > > > +test_expect_success 'Barf on misspelled option' '
> > > > +     # Mis-spell with single "s" instead of double "s"
> > > > +     test_expect_code 129 git merge-tree --real --mesages FOOBAR side1 side2 2>expect &&
> > > > +
> > > > +     grep "error: unknown option.*mesages" expect
> > > > +'
> > >
> > > I do not think that this test case adds much, and we already test the
> > > `parse_options()` machinery elsewhere.
> >
> > It's more about verifying that exit codes of 0 & 1 are reserved for
> > "completed with no conflicts" and "completed with conflicts".  The 129
> > bit in this test is the important bit (and perhaps is well-known to
> > lots of other folks, but I thought it was worth highlighting).
>
> Fair enough.
>
> Ciao,
> Dscho
