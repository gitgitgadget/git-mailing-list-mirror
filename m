Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC09DC77B70
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 18:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDOSa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDOSaz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 14:30:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED72696
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 11:30:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so4858661fa.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681583446; x=1684175446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfIGQ4cFP1U0QPBHPBD8CMuYnmg9ouV3Pd9CK862Two=;
        b=QQDowpoiN7zHhh1yD+m5OSem9n7oIO+E7Ba12KFOJlwuHca44Aiq+8Yh4K5d1Zw4yf
         wUmH556ydZH8EFgVKq7FA6X6fV4oWV+x0/eYDpldnENKTtdrGFzsIp7EXeAJCnUep97p
         JemzBExbRbTsSyeYtt3qrG+xVWHtXLojT8Dt3y8uxZEdNvQv0ZYCvZTKFPKGwBoOnq/7
         9vseI/yn00ersyhTAVnW6csTLDEJmFCPN8DfjnD2jaqNcgp4mkBMHo62+rRdFojCLFGs
         htfPFGMYZ7RMjNCWouwCpsmVAB3u9JfNplmz+l7yPUNbBX5UKALV9eOa2Ftk9l1fkHKw
         APEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681583446; x=1684175446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfIGQ4cFP1U0QPBHPBD8CMuYnmg9ouV3Pd9CK862Two=;
        b=KYRchORJ67tPtc0ws4Q1AvxCl2Fdf0ythSWj4ucSSAhrECAU/syelerANYhE0e4mqq
         wCuxxjsvKWAEUyMfBL0Ozu+cOS7NveUEZvlu/eFioNWSqGFvHAvuSFDPMWLtCu0/vPDc
         80Tbr8bAvKtTDijj2ncLE2W5Zta42KMjIiY3Y981l62DaWMWvi7LdM9jzpNKA2lx1bds
         5/g7xuVBAx9zCUS9pRxXvAKpvd3Sqo6nn9xAvsJYWwZeIJkIEhT7N3yEb3csoqirYNBv
         /RuMbemBBHxRig3+pAPSTq2MZxyXFLFpJSzIBp+bDiCyNGp9r+J6UwZaFmJx2MKJcdHx
         B2vg==
X-Gm-Message-State: AAQBX9dvvMyMhAmb/lIgLdR02DV9vOHRgRPGCjkb5hv+ClG9PCCYKv+9
        6RrK6I3ooy4HYjCmjflE1FS9zsBWuOacTrM+/Fs=
X-Google-Smtp-Source: AKy350aZr+BuDt3MAtpy1Rmk4mIpsnuCA/IkrCxYv/C+AgOYAxREZhqw6I2n/K0yMIZrCvffojoplBs1U43VltQ0ZgI=
X-Received: by 2002:a19:7001:0:b0:4ec:4f58:f24d with SMTP id
 h1-20020a197001000000b004ec4f58f24dmr789098lfc.7.1681583445602; Sat, 15 Apr
 2023 11:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
In-Reply-To: <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 11:30:33 -0700
Message-ID: <CABPp-BH7ZPBtV5Hu_-_yVdqVmiydW7_s_LYAtwbPuYSbRQiuQw@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 7:09=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/7/2023 3:24 AM, Christian Couder wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Instead of the fixed "<oldbase> <branch>" arguments, the replay
> > command now accepts "<revision-range>..." arguments in a similar
> > way as many other Git commands. This makes its interface more
> > standard and more flexible.
>
> Unfortunately, while doing this, you have broken the --onto
> logic:
>
>  $ git replay --onto HEAD~2 HEAD~1 HEAD
>  fatal: replaying down to root commit is not supported yet!

One of the things Christian asked/proposed a while ago was instead of
modifying fast-rebase into git-replay, just build git-replay from the
ground up.  I argued for using fast-rebase as a starting point, but I
think you've perhaps given an example for why I may have been wrong to
do so.  It has caused confusion, because fast-rebase used a very rigid
syntax and specification (because it was a simple test script designed
to handle exactly one simple setup) that is completely against what we
want here.

In particular, you are probably thinking of
    $ git replay --onto HEAD~2 HEAD~1 HEAD
as meaning replay the commits in the range HEAD~1..HEAD (i.e. just
HEAD) with the new base of HEAD~2.  That's the inflexible way
fast-rebase worked.  We are dispensing with that here, though; your
command means replay the commits in the history of either HEAD~1 or
HEAD (all the way to the root since you had no negative references) on
top of HEAD~2.  If you had instead said:
    $ git replay --onto HEAD~2 HEAD~1..HEAD
then I think `git replay` handles it just fine.  Christian did cover
this in the commit message, but it's perhaps subtle and easily missed.

Anyway, at no point in this series does `git replay` support rebasing
commits back to the root, so the error message is what I'd expect.
The problem was we weren't clear enough about a different syntax being
expected.

> The rev-walk you are supplying by this line...
>
> > +     argc =3D setup_revisions(argc, argv, &revs, NULL);
>
> is taking the remaining arguments and using them as tips to
> walk. We need to be able to recognize that --onto A B C means
> that A is the new base and our walk is B..C.
>
> I'm not sure if there might be a way to use a callback for
> the --onto option and pull out the next three options into
> 'new-base', 'old-base', 'tip' values or something.
>
> Overall, I don't think being flexible in the CLI is of high
> value for this command. Let's be as prescriptive as possible.
>
> Something like:
>
>         'git replay [options] <base> <tip>'
>         This mode means to rebase <tip> onto <base>,
>         detecting the range of commits to rewrite.
>
>         'git replay [options] <new-base> <old-base> <tip>'
>         This mode means to rebase the range <old-base>..<tip>
>         onto <new-base>.
>
> We don't even need "--onto" for these positional arguments.

So, from my view, the problem with this alternative design is that it
inflexibly hardcodes a linear range of commits, in a way that likely
precludes future extension.  In particular it:

  * precludes handling multiple divergent branches, which I think was
a core design requirement
  * seems problematic for extending this to handle replaying of merges
(where being able to select what to replay needs more control)
  * more generally from the above two, this precludes the opportunity
to specify both multiple positive and negative refs
  * precludes things like using `--ancestry-path=3D<commit>` which was
specifically designed for use with git-replay[1]
  * may not work well with --first-parent, which I think should be
allowed (in fact, --first-parent in some instances is a specialization
of --ancestry-path=3D<commit>)
  * seems to presume that rebasing is the only thing we want to do,
possibly precluding supporting cherry-pick-like commands

[1] See https://lore.kernel.org/git/CABPp-BHmj+QCBFDrH77iNfEU41V=3DUDu7nhBY=
kAbCsbXhshJzzw@mail.gmail.com/,
look for "Here's my usecase"

And on a minor note, it also copies the positional argument UI design
from rebase that I've always considered to be an annoying UI design
flaw.  (Not sure if others agree with me on that, but it's always
bothered me.)

Since you followed up on this, I'll add more detail in response to
your other email.
