Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79BC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 15:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLHPyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 10:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLHPyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 10:54:45 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74A528B3
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 07:54:40 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c140so2128289ybf.11
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 07:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sN4u0UYr8IrzpIuUEF5nrb94HTB12qvB9ZYUN2Lz8A=;
        b=Z/EbqeXjIEjn7aVqtvsQ4gXYyRq0LNpJ+1nTrvXWi6aeLkGhsY+tFaF8tnSqxgqCVV
         5k6Hrk+WwC9aKDeoVy613VsxEqbnUwvVZ5ZrGfnRezFUpLTHDrAciAdngeM8TyowzAIx
         Ar0HwmNmymHMUBj2K4bsO/OxAU6l8vhj6Z54WZrM60LYmsNoMDkj9BM/2UJ+ETFM7p9A
         dh1dPqpcrSFr9GWLxkf9WRohMDl7dXSiZ71hSQTf+GxIcNZYmza3z5v66XNTOk/8E8bi
         jmKoWFxJP2+ACixDoxdRqD1X1mxy14ui/ewk8HCusAevJEpJV/L69/cjVXh1jFNTKQqm
         X1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sN4u0UYr8IrzpIuUEF5nrb94HTB12qvB9ZYUN2Lz8A=;
        b=b76gkjPHrjXI4LQkVxOCGPCFUyZflMWz7mTHGVkxr1Pwx6TFFtRDOmTkNzJTTLJuPC
         J99kNYMoasGmH9vHexkR/TW+iTkvLciI4D+GMSG9RwMTvFwb6M4yPgGLSrTH+Eo4Zfh/
         RU/RLBV95DvfUGVZboo4ReTi4PjbgOXheNNLBKNTgt1fevumSvhVix4cZV/L2Wgze5Hi
         I1/dWj4zWSxPelh2P275BuuQ0/l94PVmBfPnpBYBuq6Q2JRuNXzPgFU38pW+keMTYBPT
         qClID1eboA9XPCrLVP2rXlnvpYSZz2DYSZtutJqp9xwXcx21JW4zrgFbA9z+KegUPrut
         XN4Q==
X-Gm-Message-State: ANoB5pnNedy1qVR+CyXqsNaST7SaQunZ3zgv1QaZq1ev6EvUhBICwsbG
        ir8Eg6kOUIageopE4bl0HTm37isbphNXRFNmJsU=
X-Google-Smtp-Source: AA0mqf7rhc1uwBnlIIkZPVzLysXJ5Y/1H+eal8c+3ocq9rZFc6viSIJhb3yAMrp3eOsEu2uTPCmG7G2zaPeLh5CBFe8=
X-Received: by 2002:a25:8b85:0:b0:6dd:a4b9:442b with SMTP id
 j5-20020a258b85000000b006dda4b9442bmr92650824ybl.410.1670514879941; Thu, 08
 Dec 2022 07:54:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com> <Y5EPVpb511wk5Uw/@nand.local>
In-Reply-To: <Y5EPVpb511wk5Uw/@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 8 Dec 2022 23:54:28 +0800
Message-ID: <CAOLTT8Qb0euc5WLdi7v_3ovXT4jJ1-t8BO40jjdM4Rj0Ok8Etw@mail.gmail.com>
Subject: Re: [PATCH] scalar: use verbose mode in clone
To:     Taylor Blau <me@ttaylorr.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=888=E6=97=A5=
=E5=91=A8=E5=9B=9B 06:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Dec 07, 2022 at 06:10:56PM +0000, ZheNing Hu via GitGitGadget wro=
te:
> > So add `[--verbose| -v]` to scalar clone, to enable
> > fetch's output.
>
> Seems reasonable.
>
> > @@ -84,6 +84,11 @@ cloning. If the HEAD at the remote did not point at =
any branch when
> >       A sparse-checkout is initialized by default. This behavior can be
> >       turned off via `--full-clone`.
> >
> > +-v::
> > +--verbose::
> > +     When scalar executes `git fetch`, `--quiet` is used by default to
> > +     suppress the output of fetch, use verbose mode for cancel this.
> > +
>
> This description may be exposing a few too many implementation details
> for our liking. E.g., scalar happens to use `git fetch`, but it might
> not always. That is probably academic, but a more practical reason to do
> some hiding here might just be that it's unnecessary detail to expose in
> our documentation.
>

Hmmm. There are two steps to downloading data from scalar clone:
the first step is to let "git fetch partial clone"  to  download commits,
trees, tags, and the second step is download the blobs corresponding
to the top-level files of the repository during git checkout. So I'm not su=
re
if I should mention "fetch" here, since the progress bar for the "checkout"
step is able to be displayed.

> Perhaps something like:
>
>     -v::
>     --verbose::
>      Enable more verbose output when cloning a repository.
>

Just mentioning "clone" is fine... But I'm not sure if users will be
confused, why they will "more verbose" instead of two options
"full verbose" or "not verbose".

> Or something simple like that.
>
> >  List
> >  ~~~~
> >
> > diff --git a/scalar.c b/scalar.c
> > index 6c52243cdf1..b1d4504d136 100644
> > --- a/scalar.c
> > +++ b/scalar.c
> > @@ -404,7 +404,7 @@ void load_builtin_commands(const char *prefix, stru=
ct cmdnames *cmds)
> >  static int cmd_clone(int argc, const char **argv)
> >  {
> >       const char *branch =3D NULL;
> > -     int full_clone =3D 0, single_branch =3D 0;
> > +     int full_clone =3D 0, single_branch =3D 0, verbosity =3D 0;
> >       struct option clone_options[] =3D {
> >               OPT_STRING('b', "branch", &branch, N_("<branch>"),
> >                          N_("branch to checkout after clone")),
> > @@ -413,6 +413,7 @@ static int cmd_clone(int argc, const char **argv)
> >               OPT_BOOL(0, "single-branch", &single_branch,
> >                        N_("only download metadata for the branch that w=
ill "
> >                           "be checked out")),
> > +             OPT__VERBOSITY(&verbosity),
> >               OPT_END(),
> >       };
> >       const char * const clone_usage[] =3D {
>
> Looking good.
>
> > @@ -499,7 +500,9 @@ static int cmd_clone(int argc, const char **argv)
> >       if (set_recommended_config(0))
> >               return error(_("could not configure '%s'"), dir);
> >
> > -     if ((res =3D run_git("fetch", "--quiet", "origin", NULL))) {
> > +     if ((res =3D run_git("fetch", "origin",
> > +                        verbosity ? NULL : "--quiet",
> > +                        NULL))) {
>
> Hmmph. This and below are a little strange in that they will end up
> calling:
>
>     run_git("fetch", "origin", NULL, NULL);
>
> when running without `--verbose`. `run_git()` will still do the right
> thing and stop reading its arguments after the first NULL that it sees.
> So I doubt that it's a huge deal in practice, but felt worth calling out
> nonetheless.
>

The reason I'm doing this is seeing that toggle_maintenance() already
does this, and it's not buggy, but it's really inelegant.

My personal understanding is that the original intention of run_git()
is to help developers simply put git parameters into the variable parameter=
s
of the function, and run_git() has no good way to understand null values.
Here we put it in run_git () The last is an act of desperation.

> Is there an opportunity to easily test this new code?
>

It's a bit cumbersome, but I will try.

> Thanks,
> Taylor

Thanks,
ZheNing Hu
