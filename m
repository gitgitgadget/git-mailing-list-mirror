Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8591DC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A1613BE
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbhDFOfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbhDFOfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 10:35:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B5C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 07:35:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id v26so15762614iox.11
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RRQhASsHyFJQVsJwvfNN77kXQ/5HelaYFkEW8m/pyYw=;
        b=rV7f8FNu833Md3g9KErmE2pNHTjg8ANjmfp1DmEQin2lXNERS7SAp3eBRhQ5+lo+OZ
         PAzgGmwEoS5HLGHltRtgZmyvhaoTG43ew8Hi4a5itKYVNcb+FB2+QnkgBzzyPixQG0au
         bAn67/fy9wNri6jfjt6UJa7u14lBU9YUirGqHcqpVliWnm15utimqX4gMXAvD1t3c9Dy
         VkoTFRf6UC8hWW5EChgeX4P5lEgqbIi4k7xM4qAgIi7U2+mYq27imGzRQxfeko8mhjSs
         6WtJnF2mYGOlLVbgzZRGawUPnWFfCxvj2HxgIBCREwljoKoHO8+7AozVGfts+m9xuRC1
         qvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RRQhASsHyFJQVsJwvfNN77kXQ/5HelaYFkEW8m/pyYw=;
        b=Nkz9wCrVHYRckPpSes/NOEJdIddAndO9diKqiVWQ/lWQX9MPzk23qHTpO2oOGRmwCG
         QbfXzTRv8zYKmOTWtCWqrDCfbu1apdKIttY7cDBa8jxxiLtTZDkb1aIRiQvkphVgQHCE
         D05tlBStYm8jVYDw3vpj5r99vWSCmP15Gl+Z2o/JrxAAaMKtfFJb/7k6k4qCgZ2s4nUA
         U0I7XSWTzIwYhHS4xAGc94DxVgxHzKkCgKKujg01DjFUY68W9+7zaPzA/gNuKc7F1URp
         gxWstT7z+Q0Ikgkg0k68s49FcLxISGerQEXIzLz1pnRzspg88UP/7OKwS2ElPgmkIJUS
         ixlA==
X-Gm-Message-State: AOAM530VK5rfuYVfhbXTjiRd8HVbemwinspehzUp2+gY61+SwDuPJuza
        QC0uOOUCuqnEQOyyqjlvvXet/Abm4egsuAKEQro=
X-Google-Smtp-Source: ABdhPJxn7QAe9ujdq0uDnWUMWoMrFvXZvv2PIDgzOBcxfHSmsPQooiC0/Hvr04129Vawnwc957IakhNC2hAAVmj6EV4=
X-Received: by 2002:a6b:6308:: with SMTP id p8mr24559985iog.172.1617719733157;
 Tue, 06 Apr 2021 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <YGuMaxoYgRkUR1sa@coredump.intra.peff.net> <CAOLTT8TwjRyT6MK_ekEx9APBv7jn17JRKj=mJQMO5Sk-DgHA-A@mail.gmail.com>
 <CAOLTT8SzDsoScFaGe5emQc6V5QDJD=osdE5OMAz2Xs8=AvrfVQ@mail.gmail.com> <YGxpZ/vJ/MyS0tLB@coredump.intra.peff.net>
In-Reply-To: <YGxpZ/vJ/MyS0tLB@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 6 Apr 2021 22:35:17 +0800
Message-ID: <CAOLTT8Q5kQh+8M3Ws4zjyid1+m3orBkootObxd0N2B6p8yNukg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 06, 2021 at 06:35:57PM +0800, ZheNing Hu wrote:
>
> > ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:49=E5=86=99=E9=81=93=EF=BC=
=9A
> > > But this is the first time I use `t/perf/*` and there is a little pro=
blem.
> > > It seem like whatever I run single script like `sh ./p0007-write-cach=
e.sh`
> > > or just `make` or `./run ${HOME}/git -- ./p0002-read-cache.sh` , thes=
e
> > > tests will fail.
> > >
> > It's because I don't have /usr/bin/time, solved after installation.
> > So best have this:
> >
> > --- a/t/perf/perf-lib.sh
> > +++ b/t/perf/perf-lib.sh
> > @@ -152,6 +152,10 @@ immediate=3Dt
> >  # Perf tests require GNU time
> >  case "$(uname -s)" in Darwin) GTIME=3D"${GTIME:-gtime}";; esac
> >  GTIME=3D"${GTIME:-/usr/bin/time}"
> > +if ! test -f "$GTIME"
> > +then
> > +       error "command not found: "$GTIME""
> > +fi
>
> This patch would create problems when we expect to find the value of
> $GTIME in the $PATH e.g., you can see in the Darwin case it is set to
> just "gtime", not an absolute path).
>
> I am sympathetic to helping people see what's wrong, but I think in this
> case we're better off pointing people to using "-v". E.g.:
>
>   $ GTIME=3Dpretend-we-do-not-have-gtime ./p0001-rev-list.sh
>   perf 1 - rev-list --all:
>   not ok 1 - rev-list --all
>   #
>   #             git rev-list --all >/dev/null
>   #
>
> Uh oh, that wasn't very informative. But how about this:
>
>   $ GTIME=3Dpretend-we-do-not-have-gtime ./p0001-rev-list.sh -v
>   [...]
>   perf 1 - rev-list --all:
>   running:
>         git rev-list --all >/dev/null
>
>   ./p0001-rev-list.sh: 160: pretend-we-do-not-have-gtime: not found
>   not ok 1 - rev-list --all
>   #
>   #             git rev-list --all >/dev/null
>   #
>
> which I think makes it reasonably clear.
>
> -Peff

I just make a small suggestion. ;)
You are right, "-v" is enough.

In addition, I found that the performance was basically
unchanged after testing. It seems that this optimization is
indeed too small, not as practical as in `cat-file`.

This shows that the performance bottleneck of `ref-filter`
lies elsewhere. E.g. you mentioned "intermediate copies".

--
ZheNing Hu
