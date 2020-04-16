Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D44AC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 03:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CC52076D
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 03:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD27Ftrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391150AbgDPDpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729245AbgDPDpS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 23:45:18 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32557C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 20:45:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w12so1902197otm.13
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yUdG5V1eMzvtVnJnK+vPYpv4Hbvevok928f3JsK5TRw=;
        b=kD27FtrdEI7uG1/axhXSLtpLWdGyvYLsqKHD7sZHUq0HHW9QG98OSYA5Sj4+VPxF/a
         rnImLR3g15Q9iJUl3fmAj4ZOfJlHUL+355MRFLeQ1RdKMtWJrGN1DM2BzxfhdsWsha70
         tA3a7tIk78Vc++FJr2CwoE68lUsALvL0sdjDKGcogAmkkdkWDqhi6xp69HYS9sx7Xb67
         BJt6gFgEkLZeNJJ9QYpGoqQilXHiNS8oljmagD+Mj7ZI++RWYYVs8cFPGxy/fanwt0OM
         dDqNPLIDjGdwdc65DBeDoMvF0VG7ZUce9VjhMUdjmz5BGMi9MsfinHQpzx4p6l9kNwgK
         Ovnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yUdG5V1eMzvtVnJnK+vPYpv4Hbvevok928f3JsK5TRw=;
        b=VyePI638v7oUhxPmmbkqYtY/qRoz7Kh507lmv2sDdzi9nGb1zS2KK0t3HqAmaOnInR
         EcCNb3IH7LUN/Y/Ub/5J0TxYuBibaVHXLr8U8tbvJQEkx0lFvlekvMFADGNHu46R8j5g
         e1JmszrluNhE6OCA/KOdzjKGLaHEo02J+rbasCc+IZQuk78RSoycztcpjL2g/jhetn74
         HSNViBWUDuFNQkEku6KjtUlLpN4BqLie+U0b6YeT2fIssPgbGWB6BUURmMJRsPt0EZtX
         mkY2xJzaRs3jaRE1bNLt6hZkQEmtRNYouyERSBqw7o+EXq8H73yGd0JGRavoBBmGAx2s
         rd/g==
X-Gm-Message-State: AGi0PuYczKlAqeUnySM7GCMOQbhaG/z8oISRsCamPgJoRaVhuFOExcb7
        6UsurE6/uPe08hBpxWXs2fqdUIya465Qi8pO8+hBXDGCWAo=
X-Google-Smtp-Source: APiQypIicBy3E3K3DFr5ppBBVodt5mjy5rnuAreOJF+8ZGN5pXkHEp4GJmpl3XpVhpUpM+8LVd9d8qvfhrwebNy3piw=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr25714342oti.162.1587008717254;
 Wed, 15 Apr 2020 20:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com> <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet> <xmqq1rovl54d.fsf@gitster.c.googlers.com>
 <20200410174141.GB27699@danh.dev> <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
 <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com> <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
In-Reply-To: <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Apr 2020 20:45:05 -0700
Message-ID: <CABPp-BFM-A43GpOkfNeSt6KKsdpXzObhwajvT5qBp-ws_jstRw@mail.gmail.com>
Subject: Re: fixing ci failure of 'pu' with the es/bugreport topic
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, Apr 15, 2020 at 7:01 PM Emily Shaffer <emilyshaffer@google.com> wro=
te:
>
> On Wed, Apr 15, 2020 at 6:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Danh Doan <congdanhqx@gmail.com> writes:
> > >
> > >> Excerpt from build log:
> > >>
> > >>> fatal error C1083: Cannot open include file: 'config-list.h'
> > >>
> > >> It's from bugreport topic.
> > >> I've seen this failure in the past (when testing with pu),
> > >> then I saw it disappear.
> > >>
> > >> I thought it was fixed during my testing for v4.
> > >
> > > Is the issue something similar to 976aaedc (msvc: add a Makefile
> > > target to pre-generate the Visual Studio solution, 2019-07-29)?
> > >
> > > If that is the case, perhaps something like this would help?  I'll
> > > tentatively queue it on top of es/bugreport and merge the result to
> > > 'pu' to see what happens.
> >
> > The build just passed: https://github.com/git/git/runs/590781044
> >
> > Emily, you may need to squash in something along the line of this
> > change to the commit in your series that starts building and using
> > the config-list.h file (was it the first one?).  I've queued mine
> > as a follow-up "oops, it was wrong" patch, but that would not be
> > kosher from bisectability's point of view.
>
> Hm, ok. I'll send a reroll squashing this in verbatim tomorrow unless
> I hear otherwise from Dscho? Looks like it's indeed the first one
> (dd763e).
> I'm curious to know how I can check this build method for myself for next=
 time.

Create a fork of github.com/git/git and open a pull request against
it.  (I believe you could also fork github.com/gitgitgadget/git and do
a pull request against it, but I switched over to /git/git a while
ago.) Immediately upon opening the pull request, a bunch of linux,
mac, windows, and freebsd builds will be triggered with various runs
of the testsuite.  Has been very useful for catching issues for me
before I sent them off to the list.

You can also make use of Dscho's gitgitgadget magic at that point to
take care of the git send-email step for you too by commenting
'/submit' in the PR, though you don't have to do that.  It's perfectly
fine to just open a PR for the automated testing and then close the PR
and do the rest yourself.  But if you leave it open and have it submit
the patch emails for you, it'll track their status.  I kinda like
being able to go to https://github.com/git/git/pulls/newren and have
it track the state of where all my open pull requests are.  (You might
even be able to click through some of those to see example build
results)

Dscho has done some great work with his gitgitgadget work and azure
builds.  SZEDER G=C3=A1bor also has a few builds triggered via Travis that
check a few more things off the same PRs (static anlysis and whatnot).
I've been very happily using them all by just opening PRs, and have
appreciated the heads up of potential issues I would've otherwise
caused on various platforms otherwise.


Hope that helps,
Elijah
