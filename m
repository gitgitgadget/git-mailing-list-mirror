Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16D2C6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCPRdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCPRdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 13:33:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1EEE05A
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:32:59 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e65so2819629ybh.10
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678987979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf7w3Qv8BgqpXMcE1Db9R1+3wzOCFlH5Hra4hDQnEC8=;
        b=YIEvilpdL0l5AbjogsGbQWT7ef472cxG6EiBJfjjSvVJP4ehw5Y6iPfGorRtcz42MB
         fdD2/vjtrQLNJwD9YlHBllhH+E0yjQcwTnM7Qbc1cNa+airxfx+q87V/JhrA/Ww89Z/j
         cAw0QpCiTy4R2f5ScAgyN8wfDdXOuZQ0UtcItt4EaKrPovcy+cKrRY39QoyFzFkrfu4g
         9+xp83pxtmS/q9CSsX2e0Xy0uwv/IiLn3NvW4Og5cPE375TwzKMrFm5M3++RhOf3BvNW
         kfyZRdB+a2FCA4aDTWq1Xr3Zjv9nlE1cu/QFmlHmkc1bmmY537fpl2S3HDz63VA7uLiy
         buZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf7w3Qv8BgqpXMcE1Db9R1+3wzOCFlH5Hra4hDQnEC8=;
        b=Mfnr0YKwmE4UQ4Q2c7B5MQLoZQyZ9onviS8XfuSBKQdg3+jCthuk3Xh8DHMYIgWWKk
         5mOujLDLLsgqhnlhj94l1v9+gSL2tQSj/vwG22wBZJIY9XQbu0FO7Mi9HXn7h6cEyMPV
         yxMX0JZH+5w/5QpEG1AL7Asd7lPAPwS/uH+RZfShEWgB1i7v4n4eZhvJLiAIZQU3nFdw
         29znPpAhGOAMm1RvF1cFTTIskZ7MejicKGx+0F6W3V3ABqn4ni5vWYhBrgHGO+GjWR4r
         1qOYcguC4lzy6WS3v+yMzNWHGWrxx8J9uimQ/ty8dlBW49SVp17Z9PPB9rqcgcxzvyKy
         VDig==
X-Gm-Message-State: AO0yUKUGnAB+InUg0LVnVbHYxVVTkmpik/N53hp7M9R2/djRSm4S61Nk
        IVs63MmXSU/KoeFgQ103aRUnlvUW4SOvLx/dBsuBE/PI2fg=
X-Google-Smtp-Source: AK7set+7g5WPH4WXzeu9XIR8eXU1q+inb6NHA/nNo6x5YhIWPQ1iL4Ii0O8PjvKiP3b1gzuoGsEKbVqo8OOST8T0WeI=
X-Received: by 2002:a05:6902:1101:b0:b26:d140:5f74 with SMTP id
 o1-20020a056902110100b00b26d1405f74mr219338ybu.1.1678987978760; Thu, 16 Mar
 2023 10:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230309220405.219212-1-anarcat@debian.org> <CAMP44s2=qzmF1Odc_auCaKQmTBYD53YYtaJv_LGwvoFDmTxPSA@mail.gmail.com>
 <87356ctvta.fsf@angela.anarc.at> <CAMP44s30GBC7PFovzgaORMLLGYW=1mFVG4WH-dUfUW5-1sMd1Q@mail.gmail.com>
 <87lek1suqb.fsf@angela.anarc.at>
In-Reply-To: <87lek1suqb.fsf@angela.anarc.at>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 16 Mar 2023 11:32:47 -0600
Message-ID: <CAMP44s12i0nzSKd4reJf_51=BgrGVD3xpsDzYHGJOO11FcvjCA@mail.gmail.com>
Subject: Re: [RFC PATCH] hooks--pre-push.sample: identify branch point
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2023 at 12:14=E2=80=AFPM Antoine Beaupr=C3=A9 <anarcat@debi=
an.org> wrote:
>
> On 2023-03-10 16:09:43, Felipe Contreras wrote:
> > On Fri, Mar 10, 2023 at 10:28=E2=80=AFAM Antoine Beaupr=C3=A9 <anarcat@=
debian.org> wrote:
> >>
> >> On 2023-03-09 17:22:55, Felipe Contreras wrote:
> >> > Hi Antoine,
> >> >
> >> > On Thu, Mar 9, 2023 at 4:34=E2=80=AFPM Antoine Beaupr=C3=A9 <anarcat=
@debian.org> wrote:
> >> >
>
> [...]
>
> >> > It's interesting how we keep coming back to the same problems; right
> >> > now there's a discussion in the git-users mailing list precisely abo=
ut
> >> > the same topic: how to find the branch point, in particular so `git
> >> > name-rev` shows the correct branch a commit belongs to (which is
> >> > otherwise just a bad guess).
> >>
> >> Well, it's a need people certainly seem to have. :)
> >>
> >> I feel we are letting perfection be the enemy of good here. No, there
> >> are no solutions that work for the general case, you always find a
> >> corner case that breaks it. But what if we could have a simple solutio=
n
> >> that works for *most* cases and then *fails* gracefully for the corner
> >> cases?
> >
> > I did propose such a solution, I wrote extensive tests to make sure it
> > worked properly, but it was largely ignored [2].
> >
> > The solution with --exclude-first-parent-only fails my tests in a very
> > complex case:
> >
> >    X (master)
> >     \
> >      A (topic)
> >
> > Sure, it's probably easy to fix, but the point is that a reliable and
> > robust solution everyone agrees with doesn't exist.
>
> Hm... that's odd, I'm surprised that doesn't work. But that's certainly
> a "special" (!) case that should be handled properly.

That's because the command wasn't meant to be called from a script,
but by a human who knows what he is doing.

To make it into a command that "just works" regardless of the
situation some work would be needed to make sure it works in all the
cases people have already debated.

My command just works, I would be willing to do the work of
investigating if  --exclude-first-parent-only could be used instead,
but it's not very tempting to do that work again if it's going to be
ignored again.

> >> Or they could even have a per-branch .git/config entry to map the bran=
ch
> >> to an upstream branch, and *that* could even "default" to "main" or
> >> whatever that setting is called now. :)
> >
> > Sounds like you are talking about the upstream tracking branch [3].
> > Are you familiar with that?
>
> No, I'm not refering to branch.NAME.upstream here, sorry if my use of
> "upstream" here was confusing. I mean "the branch this branch has been
> forked from" not "the upstream equivalent to this local branch".

Unfortunately Git conflates two different concepts into @{upstream}:
the branch we want to rebase to, and the branch we want to be merged
to. By "upstream" I meant the upstream tracking branch when it's
configured to the branch we want to rebase to. For example:

  git switch --create topic --track master

In this case topic@{u} is the branch that we forked from.

In my fork of git I de-conflate these two concepts, which are clearly
different: @{upstream} versus @{publish}.

In my personal workflow @{upstream} is *always* the branch I forked
from, and I want to rebase to, and when it's not configured "master"
is a safe default.

Because it's tedious to do this check every time, I have a script to
basically do:

  local u=3D"${branch}@{u}"
  git rev-parse --verify --quiet "$u" || u=3Dmaster
  echo "${u}..$branch"

It would be nice if git supported @{upstream|default} or even better: @{bas=
e}.

Cheers.

--=20
Felipe Contreras
