Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5EC6377A
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0693C61181
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354498AbhGSWUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387152AbhGSUB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 16:01:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFBC0613DD
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 13:40:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f30so25830792lfv.10
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V5m94b6KzaMgJtUScoAtxz9Xws7iwTHy9oApgGiYnvc=;
        b=o2nVSjj0SeD52HZz/7Blr4cMlUQjF4lN/1Ro8nvxqPY33fjCIwlnbltgMyVUyadm3s
         TXAd4mYxLR0ce832ki61iSzQ9wIbbi3zTbhE3nNJfILNAxWzeEMOFBO9Ll15LB9a02pd
         W0oEMGfl3UvMaom/0laOE3xzj00rQyNE2TsrWTEMgodKtk6PfI4LQiryDAWA12ZL528d
         RcGtDz+FlcFVKuI6h5/pWIriaezxYkZ7fY466OA+mNgULvWUcUHpcdxcWBBUMA/n9sYb
         gK/ovlILab5VrftXadxzRaUTkjXqfFplqpstG1Z5Slp4iPbGbOnN/0P7DoVFqv7uD+A3
         fJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V5m94b6KzaMgJtUScoAtxz9Xws7iwTHy9oApgGiYnvc=;
        b=q//ryxl2OpoM0srjA3qh/sExPmhx5OowB5tU/0RvX0+W0JVozvHdet850d3uwtoRbH
         JBYtbukqxlNbNi3YgKYdFpUjUIs3lv+M+R0PpNb++oGx6JX+tfXKa2mqTqZxNYy0bJ+C
         mwMxODaSxCFmFz13kubFcXHsZ+QY3ET+QZXhPbLLZwKZyrlPH1xQWrBN7g0DRSf88nZ0
         BWL7XrtPaOQrRLHMFlebzdSbsD+2NqtqcJO2QFwBbu6Z+TZaYYYjMJxDt57FieWUnwyb
         cBcSHHjXkSTspOrGJsAalgB9e2sB+cHsCociEFS+7IVi1N6hDpvMAvIkEpAltzoV8xlF
         CVKg==
X-Gm-Message-State: AOAM532H9leHAC8LoDxhIz/LN02Fj8ngVR8RoKLI9F1ZdWS7ffyrshla
        FLPAdXegSI98ajX/DsTvv0hYDH4aLPEx9FDeXYw=
X-Google-Smtp-Source: ABdhPJykUJtCr1xYtl9xesss3MBH8mNLdsVgxATy5kjXcEJhNebUBHbVfuUH8asdqoCt8gL1Jc8VJtkyCvFw57/7Nq4=
X-Received: by 2002:a19:c1d2:: with SMTP id r201mr19778138lff.148.1626727355612;
 Mon, 19 Jul 2021 13:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com> <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com> <60f5c7b867941_141e5c20886@natae.notmuch>
 <60f5d3ac6ce_14538820823@natae.notmuch>
In-Reply-To: <60f5d3ac6ce_14538820823@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 19 Jul 2021 14:42:24 -0600
Message-ID: <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
Subject: Re: progress test failure on fedora34
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 1:34 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > >
> > > On Wed, Jul 14 2021, Alex Henrie wrote:
> > >
> > > > On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> > > > <avarab@gmail.com> wrote:
> > > >>
> > > >>
> > > >> On Wed, Jul 14 2021, Fabian Stelzer wrote:
> > > >>
> > > >> > Hi,
> > > >> > The test t0500-progress-display.sh in current master fails on la=
test
> > > >> > fedora34.
> > > >> > The break was introduced with:
> > > >> >
> > > >> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> > > >> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> > > >> >
> > > >> > Kind regards,
> > > >> > Fabian
> > > >>
> > > >> I have not been able to reproduce this, it seems the below E-Mail =
was
> > > >> word-wrapped by your mailer, which is especially bad here since ge=
tting
> > > >> to the bottom of this requires looking at the whitespace.
> > > >>
> > > >> Is there a way you could tar that up and send it (to me personally=
 is
> > > >> fine, or some pastebin or whatever).
> > > >>
> > > >> I am able to reproduce something that looks like this if I
> > > >> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that we s=
et it to
> > > >> 80, and that the progress.c code just ends up with an
> > > >> atoi(getenv("COLUMNS")), and we do our own wrapping (with no other=
 fancy
> > > >> logic) in progress.c, I'm not seeing right now how this could happ=
en...
> > > >
> > > > This test also fails for me when using QTerminal or Konsole, but it
> > > > passes on XTerm and LXTerminal.
> > >
> > > I tried this on Debian 11 with QTerminal 0.16.1 and can't reproduce i=
t,
> > > resized the window etc., always get COLUMNS=3D80 if I add some printf
> > > debugging.
> > >
> > > Do you mind testing with an ad-hoc patch like this on top? It will fa=
il
> > > right away, but should say COLUMNS =3D 80 in the output.
> > >
> > > The only thing I can think of right now is that some terminals are do=
ing
> > > some evil trickery to LD_PRELOAD or whatever and intercept getenv() f=
or
> > > COLUMNS and the like, but that's an entirely unfounded hunch.
> >
> > I'm able to reproduce this. The test fails when running directly with
> > bash, but not with prove.
> >
> > And it seems to be a bug in bash:
> >
> >   export COLUMNS=3D80
> >
> >   echo "COLUMNS: $COLUMNS"
> >   cat > /tmp/expect <<EOF
> >   foobar
> >   EOF
> >   echo "COLUMNS: $COLUMNS"
> >
> > I get:
> >
> >   COLUMNS: 80
> >   COLUMNS: 115
> >
> > Even directly in the console.
>
> Hmm, from man bash:
>
>   checkwinsize
>     If  set, bash checks the window size after each external (non=E2=80=
=90builtin) com=E2=80=90
>     mand and, if necessary, updates the values of LINES and COLUMNS.  Thi=
s  op=E2=80=90
>     tion is enabled by default.
>
> Seems like since bash 5.0 this is on by default.

Indeed, running `shopt -u checkwinsize` right after exporting COLUMNS
in test-lib.sh fixes the tests. Great work!

-Alex
