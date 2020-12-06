Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C61C4361B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206992313F
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 14:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLFOcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 09:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLFOce (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 09:32:34 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7F4C0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 06:31:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so10144979wrv.6
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 06:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VIXbvR8zP6GsQRrhUXCszUVzZlXDIt6nsitHmiz/oMQ=;
        b=agbm93Ej26JtCjW6XtGzIUtz7J1awGz3+f2eSEBn8z8C6R7W2W8g5ghXMaW2NunECT
         woedXx4ZSdUBIK+CQ8zvsvpQpCCJxQ2xqGy55BitBG3j/DHuIszN0o3W6q/SZsZTAuj5
         eTjbirxtxdk4Liovbjqrs0r11ki3o/tVpVEg2QdiI6SmFB2nYO/kjSdGmmU0Nu/Vwecj
         0hJq0LMnxzwbSznu6y9K1zYNwigI/odAFzA3WzoHpR5uXEsJAqYj2CHu6FvH/dDT9D+0
         Bs8bOmRck5YWN9GoiVrGKv14XhmGk/67iZQDMSN10gl6pRRuUXaZqNeFgAW8H40Jp5j4
         UT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VIXbvR8zP6GsQRrhUXCszUVzZlXDIt6nsitHmiz/oMQ=;
        b=LyfT9fzpyxhdKBvPBBx5XFKHSpqUKWHQu7/RFXFYGeDyRqidMV2fXAhMJ9XVxLezxZ
         9ztC2Pr2CbXCvupQ+Sbn9OTjGZ3aOu1h/QCwwMp6YVTiFkqtpZdgCmP+gA+JGvg12kws
         8sO/yDiVRQvlJEaKTYyUCqX6/NSsyrdVbgSPjKyElxIDdfwEzdn48IMyo2wns/W+4xm5
         sMowXrcMNA/3Fz44LCo45T3ycga8HWBm+hkfS97IbCbOB70iC13zRp/nDIPgPGWF+EMf
         7AezW0tc2RvXvxojQo5zQiB1vH4fYjUFPc8nU/m3BlsV1PxnDNwR/qNCHih2UFWSstbL
         TAvg==
X-Gm-Message-State: AOAM531/FcUyg8MFfTGmX7mkHxMC2zLSjMm1aVMTrai6SyunUuekG8oq
        5CY0qY0e8h2moNWJjr8MceEo4WTqdWLjuyEv5RQ=
X-Google-Smtp-Source: ABdhPJyfEK8Bhdj8cBCp3idHXBVt2gypue+KyvyjJoXOMzRDq8LVnQmAAfipXmVqu7+lMfkFr1b7GiD9l7id8GaZEOw=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr15188234wrv.255.1607265112841;
 Sun, 06 Dec 2020 06:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com> <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
In-Reply-To: <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 6 Dec 2020 08:31:41 -0600
Message-ID: <CAMP44s2fCnjJSp2fzSq5is0LR6GDPP+wnM9r3kz=U65c7h_UPg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 7:01 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sat, Dec 5, 2020 at 1:28 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > On Sat, Dec 5, 2020 at 10:28 AM Elijah Newren <newren@gmail.com> wrote:
> > > On Fri, Dec 4, 2020 at 5:56 PM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> >
> > > > Well, I already said I partly agree with you: in the --ff-only case
> > > > the suggestion should not be brought forward.
> > > >
> > > > But in the "git pull" default case, *today* it's doing a merge. If
> > > > uttering --merge and thus making the current behavior explicit inst=
ead
> > > > of implicit seems dangerous it's because it is. But not documenting=
 it
> > > > doesn't make it any less dangerous.
> > >
> > > Sounds like we agree that the future should be ff-only-as-default.  I
> > > also agree with you that the primary problem is the current default
> > > behavior, and I'll agree with you that documenting the current defaul=
t
> > > is okay.  However, I disagree that your wording here:
> > >
> > > +                       "If unsure, run \"git pull --no-rebase\".\n"
> > >
> > > does anything of the sort.  It does not mention that this is the
> > > default behavior the users would get if they provided no flags.
> >
> > But that is not the warning, this is the warning:
> >
> >   Pulling without specifying how to reconcile divergent branches is dis=
couraged;
> >   you need to specify if you want a merge, a rebase, or a fast-forward.
> >   You can squelch this message by running one of the following commands=
:
> >
> >     git config pull.rebase false  # merge (the default strategy)
> >     git config pull.rebase true   # rebase
> >     git config pull.ff only       # fast-forward only
> >
> >   You can replace "git config" with "git config --global" to set a defa=
ult
> >   preference for all repositories.
> >   If unsure, run "git pull --merge".
> >   Read "git pull --help" for more information.
> >
> > This warning says:
> >
> > 1. There's 3 options: merge, rebase, fast-forward
> > 2. merge is the default strategy
> > 3. If unsure, specify --merge (the default strategy)
> >
> > So taken altogether it does say what is the default strategy.
>
> We don't need to take them together.

No, but that's what I'm proposing.

> #2 by itself states the default strategy.

Yes, with configuration, not with commands.

> I don't see why defending #3 as being for the purpose of
> documenting the default strategy is helpful, since it doesn't do that.

I disagree. It does do that, but it serves a more urgent purpose: it
tells the user how to ignore us quickly, for now.

> > The current warning should not exist at all.
> >
> > The complaint from V=C3=ADt Ondruch [1] that reignited this series is a
> > valid one. A *permanent* warning is not good. We should have a
> > *temporary* warning with the express purpose of notifying users of an
> > upcoming change.
> >
> > If we have not yet decided on what should be the default (Junio seems
> > to have casted some doubt on the consensus [2]), and we don't have a
>
> Useful link there.  Based on his comments, we may want to make
> --ff-only, --merge, and --rebase all be mutually exclusive and result
> in an error message if more than one is specified at the command line.
> (But still have the command line countermand any option set in the
> config, of course).

Yes, but that's a change in behavior.

Moreover, what do you suggest this should do?

  git -c "pull.rebase=3Dtrue" -c "pull.ff=3Donly" pull

I have already tried to make pull.ff=3Donly work in several ways. It's
just not a clean solution.

Cheers.

--=20
Felipe Contreras
