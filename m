Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B215C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6010522263
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qER4CQj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782254AbgJZO5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 10:57:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37790 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782231AbgJZO5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 10:57:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id f7so10759221oib.4
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q0iAo8L5BKJCw0woSFu3CP9vn9sMX0XuO9UjcFTjeNU=;
        b=qER4CQj2xAo1JWxLJVnnwf6L/vWP70NU661UqCWnosLGoJhtGP42SCTrk/78k+DKJr
         xqllPWlLwWTO0el3F3xoCSqUmtVXezapnae7IuYTLOPZkmc505JFVBvXlV97Df9Bt9q6
         yHnAaBzXk6sBjzMPDMvjGvOwsz7wiYpagZx/CRXddc4gy18x4mMDreSrDoxsuzM3bI5/
         1sOhvWNmWlrqOv+YlGu5F6tXCqNMvjHUNYlafIWiMvmh1TNQmn8DTG3DuyyfkOhyUPKo
         c8EHZnLibs0wIUotMobTELLJR9dHwrZTP+pjSHnC5vpg3ahwa/xa+vsy1qzY9hbXq/RC
         RXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q0iAo8L5BKJCw0woSFu3CP9vn9sMX0XuO9UjcFTjeNU=;
        b=BhchL5zI14saeU3guPa+XUzGjpxgYllH/ggjjgDtpmDzb6AhJYJRs0gGua+sEeEGzd
         SUMInQocZ/XSpT0jkTdR+krHGgnO3indT1fqlimAQ3HfL7mCtud1E7j9RnnSs6Svdt74
         s9UFrCaaq8QpBRKu664tf+fOu+65Q93FW+oyjF+X14rublZzNjrdnfp6PpbNpxL3xOsv
         hx28WuJGsbieW4bV66VZbx17kzBb+spJ1bZcoJdPA5ywb1AdPX1gHpwe8KGzbpmFZjUM
         aUXEPq3B3Co3QtZgA1ovSYsPbepGU8zNd2IOkNOro+At7t6+a+tp8bEeooXTMu6IQaHm
         ec0A==
X-Gm-Message-State: AOAM533caVoSbvx6zxq7lzPvy4AgMSrWF836h4svXFDQpA7I8b4wnK1R
        7RD86aBsCxbkEmT2yBsH4yYYXmkYHjiaCSaYCG8I9jfJx20=
X-Google-Smtp-Source: ABdhPJwocyDb2MabdpUJ1aUUxZ0UdWCPA9aJ8+1aaWoljJZ9nbkLd3nNaONx7heCgULVsKeTJ7WfyVOWqOWeBUcpcPY=
X-Received: by 2002:aca:b4d7:: with SMTP id d206mr5563355oif.39.1603724230435;
 Mon, 26 Oct 2020 07:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
 <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
 <20201024104910.GA15823@danh.dev> <CABPp-BHgJrQMNEm7-y7nStVjcAedsNKH+bHNM9V34netTN+NTQ@mail.gmail.com>
 <20201025134905.GB15823@danh.dev>
In-Reply-To: <20201025134905.GB15823@danh.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Oct 2020 07:56:59 -0700
Message-ID: <CABPp-BEmJA92tDymypgJqGmi=eMsvU+eP=KeTKvKcJEvFVztEA@mail.gmail.com>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but fail
 with recursive
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 6:49 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2020-10-24 09:53:18-0700, Elijah Newren <newren@gmail.com> wrote:
> > On Sat, Oct 24, 2020 at 3:49 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng D=
anh
> > <congdanhqx@gmail.com> wrote:
> > >
> > > On 2020-10-23 16:01:16+0000, Elijah Newren via GitGitGadget <gitgitga=
dget@gmail.com> wrote:
> > > > +test_expect_merge_algorithm () {
> > > > +     status_for_recursive=3D$1
> > > > +     shift
> > > > +     status_for_ort=3D$1
> > > > +     shift
> > > > +
> > > > +     if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> > > > +     then
> > > > +             test_expect_${status_for_ort} "$@"
> > > > +     else
> > > > +             test_expect_${status_for_recursive} "$@"
> > > > -test_expect_failure 'check symlink modify/modify' '
> > > > +test_expect_merge_algorithm failure success 'check symlink modify/=
modify' '
> > >
> > > I find this series of "failure success" hard to decode without
> > > understanding what it would be, then I need to keep rememberring whic=
h
> > > status is corresponding with with algorithm.
> > >
> > > Perhaps this patch is a bit easier to read. This is largely based on
> > > your patch. (I haven't read other patches, yet).
> > >
> > > What do you think?
> >
> > It is easier to read and I think something along these lines would
> > make a lot of sense if this weren't a transient change (the idea is to
> > eventually drop the recursive backend in favor of ort, and then these
> > can all switch to just using test_expect_success).  Maybe it still
> > makes sense to make further changes here anyway, but if we do go this
> > route, there are 1-2 things we can/should change:
> >
> > First, while a lot of my contributions aren't that important, and the
>
> Mine aren't that important, either
>
> > new test_expect_* function certainly falls in that category, one of
> > the driving goals behind a new merge algorithm was fixing up edge and
> > corner cases that were just too problematic in the recursive backend.
> > Thus, the patch where I get to flip the test expectation is one that I
> > care about more than most out of the (I'm guessing on this number)
>
> Make sense.
>
> > 100+ patches that will be part of this new merge algorithm.  Having
> > you take over ownership of that patch thus isn't right; we should
> > instead keep my original patch and apply your suggested changes on top
> > (or have a patch from you introducing a new function first, and then
> > have a patch from me using it to flip test expectations on top).
>
> You can take back the ownership, the patch was based on yours, anyway.
>
> I wrote like that since I need to rewrite part of the message to match
> with my changes ;)
>
> No need to generate extra noise of additional patch.

Just to be clear, others have made suggestions like yours in the past
where they've taken over ownership of a patch in a series and I've
been totally fine with it.  Your suggestion to do the same would have
been fine here, but I'm just kinda attached to being able to flip the
test expectation for these tests; I've been working towards it for a
_long_ time.

I think an extra patch, attributed to you, actually makes the most sense he=
re.

> > Second, I think that lines like
> >     test_expect_merge_success recursive=3Dfailure ...
> > read like a contradiction and are also confusing.  I think it'd be
> > better if it read something like
> >     test_expect_merge recursive=3Dfailure ort=3Dsuccess ...
> > or something along those lines.
>
> When I wrote the patch, I was expecting something like
>
>         test_expect_merge_success recursive=3Dfailure,other=3Dfailure ...
>
> in order to merge all algorithm into single parameters.
>
> How about something like:
>
>         test_expect_merge_success exception=3Drecursive,other ...
>
> Not that we have "other" algorithm to begin with.

Sure, sounds great.  I wouldn't spend any time trying to make it work
with a 3rd backend, though.  The goal is to have two merge backends
only long enough for people to become comfortable with the new backend
and discover any unknown issues with it that we can fix, then we'll
rip it out the old "recursive" backend and we'll translate any
requests for "recursive" to mean "ort".  We'll also rip the
test_expect_merge_success() function out since it'll be unneeded (so
efforts towards future proofing of that function will be wasted).
Then years will go by before another merge backend comes along, if one
ever does.
