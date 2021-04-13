Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B44C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83AC613AB
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbhDMMDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbhDMMDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:03:20 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29549C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:03:00 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id z9so13837974ilb.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OlzryL7+7MLXOm/8WpEo75Fr7dgllHoZXSC3mdrH4JY=;
        b=q7HmfPsx0y66MFZxMqVB1qD04eMHokxofLiy2TzizJGtq32EVQfIjht51I1wRjtFRm
         bslniFREQ4d6O82sd9Uc4SzNKR786by8IO3mDzA3mr/CEfAKpr7Nsz7UeueDozcGzy5/
         grPSDaPVYdTUp8wFlrdmt2LEohJQB2ogeZJVLkDs0f57/8efIZoEqop2qQbagihCSrfi
         0f+e97chWeBRUIP2bXdiioijQFtqwchhnb2OrMXRhFGi4WpeeL0hk6D/7+jRV3kK8FYi
         469NvD4e6XYRjQGnMkyTXXbY4Rw9YuM2jlDMrEq4+ZQ6moatknncQmmKMJOOuh0y4owt
         5PzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OlzryL7+7MLXOm/8WpEo75Fr7dgllHoZXSC3mdrH4JY=;
        b=WQzWFl7fTwOQxDXXiAAMzzXle1jJnRgTFVRLr9de4ujDFv8jsea+WSxM297rRNahaW
         halz4LcvKxtg5CrWAWMcfZQuQ3o1JAWd9rOlnDEqX46dp6DFKkoosxxdvDGMeG8/UZR3
         edDoOiC9btwLHAblpB9+b4Dq/ELuJ5BBCoG37gJvEsawcTbyjJkssJp+dU2NvKoMQivf
         l/w8KPAJHCKOa1B/ZbKwoM4Yer3CeAlm8NJGg1hxJOgGqZ7zLyKB5hrzZIuhoZX5wX6b
         HccpYvuUGEfes1UkOxlKq4dKm7HdOgYAoJSFz+67oWr43qoDe+FmwJekNZlZKP4H0TYe
         PAGg==
X-Gm-Message-State: AOAM532puFYFztQJuVFlCmJaOluUjcVNqOiNqzk2DPGimbxkksIgdVU0
        DdgX0HHNcNlCN+aoJKm1cor+XTI19GOjRcD8HPEz3xU6FNsmcDtBIiIl6Q==
X-Google-Smtp-Source: ABdhPJzgDQLtK3HFMj7oCQHWnDtj2Oz+nCseFK8JVJnhjQTYxA+TEj0nYDMRB7c+B68tGfiq1YuT+bbzpLNZ6vdTJGY=
X-Received: by 2002:a92:d308:: with SMTP id x8mr27032063ila.301.1618315379585;
 Tue, 13 Apr 2021 05:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
 <pull.913.v9.git.1618245568.gitgitgadget@gmail.com> <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
 <xmqqsg3vb51n.fsf@gitster.g> <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
In-Reply-To: <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 13 Apr 2021 20:02:47 +0800
Message-ID: <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Christian and Junio,

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=8813=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:33=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Apr 12, 2021 at 10:51 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > +For consistency, the $1 is also passed, this time with the empty str=
ing,
> > > +in the command when the command is first called to add a trailer wit=
h
> > > +the specified <token>.
> >
> > I guess the same question as 1/2 applies to this part.  I am not
> > sure what "consistency" the behaviour of calling the configured
> > command with no argument is trying to achieve.  To me, .cmd doing
> > this may be for consistency with .command but I am not sure why
> > the consistency is even desirable.
>
> It might be desirable to make it easier for people to migrate from
> ".command" to ".cmd". I agree this is debatable, but I don't see a big
> downside in it. Maybe, if no argument was passed at all the first time
> the command is called instead of the empty string, the command could
> then know that it's called for the first time. I am not sure this
> would be very helpful in practice though.
>

If i'm not wrong, Christan meant that this command must run so it's
"consistency", and Junio thinks this "consistency" is not needed.

It is true that there is not much harm in keeping `.cmd` at the behavior
of `.command` now. But I remember the `trailer.<token>.runmode` that
Christan said before, perhaps adding it in the subsequent iterations can
solve Junio's doubts. Sometimes I also confirm that the behavior of
`git interpret-trailers` is very strange too.

> > > +$ cat ~/bin/gcount
> > > +#!/bin/sh
> > > +test -n "$1" && git shortlog -s --author=3D"$1" HEAD || true
> > > +$ git config trailer.cnt.key "Commit-count: "
> > > +$ git config trailer.cnt.ifExists "replace"
> > > +$ git config trailer.cnt.cmd "~/bin/gcount"
> > > +$ git interpret-trailers --trailer=3D"cnt:Junio" <<EOF
> > > +> subject
> > > +>
> > > +> message
> > > +>
> > > +> EOF
> > > +subject
> > > +
> > > +message
> > > +
> > > +Commit-count: 22484     Junio C Hamano
> > > +------------
> >
> > This and the other (omitted) example demonstrates how the initial
> > "empty" invocation is useless by using "replace".  Which also means
> > that you cannot add more than one trailer of the same <key> with the
> > mechanism (since the older ones are replaced with the latest).
>
> You can add more than one trailer with the same key if you don't use
> "replace" but use "--trim-empty" on the command line, so that an empty
> trailer added by the initial invocation is removed. And we can later
> add a `trailer.<token>.runMode` to remove the initial invocation.
>

Yes, something like:

trailer.see.command=3Decho "$ARG"

git interpret-trailers --trim-empty --trailer=3D"see =3D lll"
--trailer=3D"see:jj"</dev/null

see: lll
see: jj

> > The code change and the test change are consistent with the design,
> > though.
>
> Yeah, this patch looks good to me now.
>
> Thanks!

So is there anything else should I improve?

Thanks.
--
ZheNing Hu
