Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10946C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE831212CC
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h42VROfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgJNOfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgJNOfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 10:35:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E2CC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 07:35:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t9so2346388qtp.9
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pdDquHODdc5X90PgUlfoGFrsanypR2kOXLBPgJvnF/0=;
        b=h42VROfYUntOpZ8JUna1H1YKxT4iPPihOBOoqSWMhdCRKczdKlRtxPwpxb3et65Dje
         L4/f4oxz368fGf47r7UOEAH2mDRvnsRzbl7oI/yJOzh2nUy13tmHt3oPw3FUHNVKCkbQ
         fSUUWlkagQuCWQWyehq7XczuCdpIQaKek3e64JzGN/d7qFZJNKY0j7tnPy9QvHLuuv7K
         S2J7Jeu9jxehWnuCWaXRagYew7tCIR4DGUE24zFPB1/anfLXiklGgHCUJ3K5JyMIe6Bn
         jUpNKAUVhRRnf4W4aNehWJvAAPJ/oF+IiVN4WfaWRqQpzXFQSIHU8cZ8RRDxpn+cEjqd
         nU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pdDquHODdc5X90PgUlfoGFrsanypR2kOXLBPgJvnF/0=;
        b=p7oKRYRe4682J0j/HuMb6ViadWxV37mDnOvoftRZfLtbGuiYdtKQHmG3IPMb4cUai3
         QjKQ37qQ+99iGKG9WfHZy8afHL7Mk1qlkLd6nI9g+UvzfGdGojRm0H7xZ4w2EVmnK5h0
         U+79GR7xlrkpgpYp2WNi+lNG7WrY3TuFXUXrGh49lfYXBWodBujeuHJss+8gYN8fP5dI
         GI0GVlRRXuyykqoDpXx7qt2GQESQcHZtbqUwmgY/ayjCJLqULJBTE9QIk2On4/BeCZP8
         cyLEZaLvAYHfH9R86F6jgvQtsdBQig8YOrKTgy7nW2ptabdaoywT+mDKbPS9Sq6Omjp2
         bWZA==
X-Gm-Message-State: AOAM532h+rJ1LSq/ogEaNZ3yJxSnVj+bCd82PQWde6tyqzEco3TwimMl
        MxbawoQDDPbi9FTFNolnHV8at1m/oapMcSLoqlQ=
X-Google-Smtp-Source: ABdhPJx/sd/TB4qbb6SGVGdFIs9SEAA4Q5atJEsioMEpqsATZZ6t3Mo3wtTDXvWxSUbWRLyuysn2XHN4yWQCBmjeeTs=
X-Received: by 2002:ac8:1af2:: with SMTP id h47mr5176701qtk.346.1602686136551;
 Wed, 14 Oct 2020 07:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+3n-TrVncSq6kY8sTTw=LiOvLKe=6k1yBE8cmmR3i40CaXR6w@mail.gmail.com>
 <E3D98950-2EA1-4BFE-8A2D-CE8AEAF5AD39@gmail.com>
In-Reply-To: <E3D98950-2EA1-4BFE-8A2D-CE8AEAF5AD39@gmail.com>
From:   Marc Sune <marcdevel@gmail.com>
Date:   Wed, 14 Oct 2020 16:35:25 +0200
Message-ID: <CA+3n-Tpb4BGM5W3e5vHwqkU-Tnh2gs0_K1ciEcJ25SnYe5PTOw@mail.gmail.com>
Subject: Re: git diff --submodule=diff and --stat/--dirstat/--name-only
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe,

Missatge de Philippe Blain <levraiphilippeblain@gmail.com> del dia
dc., 14 d=E2=80=99oct. 2020 a les 15:29:
>
> Hi Marc,
>
> > Le 14 oct. 2020 =C3=A0 06:14, Marc Sune <marcdevel@gmail.com> a =C3=A9c=
rit :
> >
> > Hello all,
> >
> > First, thank you to the community for the great work. Worth saying it
> > from time to time, I think.
> >
> > I am dealing with a couple of big repositories that use git
> > submodules. They have nested submodules, and some of them are pretty
> > huge. I came across:
> >
> > git diff --submodule=3Ddiff
> >
> > Which is very handy for creating some tooling, but it's obviously slow
> > - in the order of tens of minutes in my case - for big diffs. I was
> > only interested in the list files that changed, in this particular
> > case, but:
> >
> > git diff --stat --submodule=3Ddiff
> >
> > doesn't seem to honour `--submodule=3Ddiff` and it doesn't go into the
> > submodule(s) nor recurses, of course. Other options like `--dirstat`
> > or `--name-only` seem to behave the same way.
> >
> > I've tried this v2.20.1 and the HEAD of master (d4a392452e) with the
> > same results. Is this a missing feature, a bug or is it just the
> > intended behaviour?
> >
> > Regards
> > marc
>
> This would indeed be useful. It's a missing feature, and so intended beha=
viour
> for the moment, I would say. It was discussed recently on the list [1] :
>
>
> [1] https://lore.kernel.org/git/20200924063829.GA1851751@coredump.intra.p=
eff.net/t/#u

Thank you for the pointer and the clarification.

I am not sure extending `git diff` options (only) under
`--submodule=3D`, e.g. `--submodule=3Dstat` is the way to go. It seems
redundant to me.

I am wondering if it would make sense to have basic options of git
commands, e.g. `git diff --stat`, be honoured for submodules too, and
just control whether git commands should get in the submodule(s) or
not, and perhaps the depth of the recursion (optionally).

For instance, I don't fully get the use-case(s) in which parts of the
output are --stat (supermodule) and submodules show something
different:

git diff --stat --submodule=3Ddiff
git diff --stat --submodule=3Dlog

Specially for log, this sounds to me like it should be under `git
log`, with the appropriate options. Perhaps you can shed some light on
the use-cases these combinations support.

I would think something like:

git diff --stat --submodule-follow
git diff --stat --submodule-follow-depth=3D4

git diff --names-only --submodule-follow
git diff --dirstat --submodule-follow

and for other commands (some sort of header line should be printed to
note the history is under the submodule X):

git log --submodule-follow
git log --submodule-follow-depth=3D4

and of course allowing `--` modifier:

git log --submodule-follow -- libs/library1

would be easier to use.

Let me know if any of this resonates, and if some patches along these
lines would be welcomed (might ask some help offlist).

Regards
marc

>
> Cheers,
>
> Philippe.
>
