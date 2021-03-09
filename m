Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0694EC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 07:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8F265199
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 07:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCIH25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 02:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCIH2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 02:28:37 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D843C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 23:28:36 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d20so13919718oiw.10
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 23:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/iRJIlg6GXniru3u+wKXaDQLlZog1ZtTwTZ3l+SvSbs=;
        b=LzfcUKR8SgldCCFZ5EYuAMBjkp8lsp8QeZqKcUQYd3rVNv+qTjKlX4f8p2pEUlozo4
         R8UTah5ifV3T5YMtsCz+eqPxSQ+ZwfIT5sKfEJJu+DNESVhY4QopaEAmh6T6p/VuqWqO
         BD+dIG5WhrWTiPgENrNtS3Pu5l4a7As1aw3vxzZv/anRaQLMa1UvrxRq+OdF+UEpDw8U
         ruwnpTzP5sVLgQB30vlJRNTB9qU39Fzan+RLC7LL9GbNbbx4YpCnxBD+H8/PVCuwtPfT
         Qwbx5pVxvfE+1WEz/kq8ER52D/OUv4/GYwf/JHU12rrFwa+scm2vf+R+whYXbPJ9Tcy1
         NaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/iRJIlg6GXniru3u+wKXaDQLlZog1ZtTwTZ3l+SvSbs=;
        b=Fr8zaomypGiUbZeFzmmS2sihzbFUDKO5EDnAYS/3r7tWx87cYTD999cDQUdkb3joE0
         aiXSwFIx8l1TSf1Nf+q108DC4powE2iUafD0IIXckwwCp4E/Az5Fyg8agVO4L58K7gxY
         5osAq4vBmIFus2nl1rMO6OQtSNbiZnPV0dx/830ulMbUQV8kkXxqsbmENsHPRtBA4Z4Y
         ekCzhZH0muKiDtaQKuY98LbL8uj0sxIZ5WioaqSCFp3Yn8O3E7F41+IVtODWU0a+9Cat
         tbwLOowP9AsaJNpYgJFdi8pDjVTav/SbZLd4j+BaKMgyxVQ7UVzhvAn13VNWHVyxz82M
         Ub2g==
X-Gm-Message-State: AOAM530jRVoJOUxFBE6mCHH72JpcxgJxDiN7JB2P1SvjnEACj7jPF3Cc
        /Gy6Pnm+L2CIp9SBpBDc0OA1njUxEFoRIxS8NV4=
X-Google-Smtp-Source: ABdhPJzEhsAwEtG0SrdwOB+XPoEj4aNVU6CmiK+rUd3ZWPch6Hs7m0vMmZ4J6Fuyo+sHaoYonPw1d9fz8FlAWkGPwd8=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr2098327oia.44.1615274915642;
 Mon, 08 Mar 2021 23:28:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.898.git.1615100240295.gitgitgadget@gmail.com> <YEaGbn5rU3pU7/q5@nand.local>
In-Reply-To: <YEaGbn5rU3pU7/q5@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 9 Mar 2021 15:28:24 +0800
Message-ID: <CAOLTT8REFb1QCpu=NQUBZJHy-uj_OhpNJJMu2PrTp6wkCDYr+w@mail.gmail.com>
Subject: Re: [PATCH] [GSOC][RFC] format-patch: pass --right-only to range-diff
To:     Taylor Blau <ttaylorr@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <ttaylorr@github.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Mar 07, 2021 at 06:57:19AM +0000, ZheNing Hu via GitGitGadget wro=
te:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
> > Taylor Blau proposing 'git format-patch --cover-letter
> > --range-diff' may mistakenly place upstream commit in the
> > range-diff output. Teach `format-patch` pass `--right-only`
> > to range-diff, maybe can avoid this kind of mistake.
> >
> > Because `git rebase --apply` will internally call `git
> > format-patch -k --stdout --full-index --cherry-pick --right-only
> > --src-prefix=3Da/ --dst-prefix=3Db/ --no-renames --no-cover-letter
> > --pretty=3Dmboxrd --topo-order --no-base`, In order to avoid the
> > ambiguity of `--right-only`, users can call `format-patch
> > --range-diff --only-right` instead of `--right-only` to only emit
> > output related to the second range.
>
> A couple of times this new option is called "--right-only" and other
> times it is "--only-right". This comment makes me think that you meant
> to call it "--only-right", but...
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC][RFC] format-patch: pass --right-only to range-diff
> >
> >     Transfer parameters are relatively simple. But because I can' t
> >     reproduce the situation, There's no big difference between adding
> >     ---only-right and not adding ---only-right. So I haven't written th=
e
> >     test files for the time being.
>
> Note that I think (and Johannes--cc'd--could confirm) that what you want
> is '--left-only' to discard rebased changes from the upstream branch:
>
> In either case, this should help you reproduce it (and would be a good
> starting point for adding a test case). Here, we're using '--left-only'
> to discard changes from upstream (here, the 'main' branch) after
> rebasing:
>
>     #!/bin/sh
>
>     set -e
>
>     rm -fr repo
>     git init repo
>     cd repo
>
>     git branch -M main
>
>     echo "base" >base
>     git add base
>     git commit -m "base"
>
>     git checkout -b my-feature
>     echo "feature" >feature
>     git add feature
>     git commit -m "feature"
>
>     base=3D"$(git rev-parse main)"
>     old=3D"$(git rev-parse my-feature)"
>
>     git checkout main
>     echo "other" >>base
>     git add base
>     git commit -m "new"
>
>     git checkout my-feature
>     git rebase $base --onto main
>
>     tip=3D"$(git rev-parse my-feature)"
>
>     git range-diff $base $old $tip
>     git range-diff --left-only $base $old $tip
>
Thanks, I have seen an obvious phenomenon from
your shell script, and I wrote test code based on it.

> >     I may need to ask reviewers opinion first.
> >
> >     this want to fix #876 Thanks.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-898%2=
Fadlternative%2Fformat-patch-range-diff-right-only-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-898/adlt=
ernative/format-patch-range-diff-right-only-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/898
> >
> >  Documentation/git-format-patch.txt |  5 ++++-
> >  builtin/log.c                      | 15 ++++++++++-----
> >  2 files changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> > index 3e49bf221087..5dae34c3090b 100644
> > --- a/Documentation/git-format-patch.txt
> > +++ b/Documentation/git-format-patch.txt
> > @@ -27,7 +27,7 @@ SYNOPSIS
> >                  [--[no-]encode-email-headers]
> >                  [--no-notes | --notes[=3D<ref>]]
> >                  [--interdiff=3D<previous>]
> > -                [--range-diff=3D<previous> [--creation-factor=3D<perce=
nt>]]
> > +                [--range-diff=3D<previous> [--creation-factor=3D<perce=
nt>] [--right-only]]
> >                  [--filename-max-length=3D<n>]
> >                  [--progress]
> >                  [<common diff options>]
> > @@ -301,6 +301,9 @@ material (this may change in the future).
> >       creation/deletion cost fudge factor. See linkgit:git-range-diff[1=
])
> >       for details.
> >
> > +--only-right:
> > +     Used with `--range-diff`, only emit output related to the second =
range.
> > +
>
> s/--only-right/--right-only?
Now it's all "--left-only".
>
> >  --notes[=3D<ref>]::
> >  --no-notes::
> >       Append the notes (see linkgit:git-notes[1]) for the commit
> > diff --git a/builtin/log.c b/builtin/log.c
> > index f67b67d80ed1..5d2f39fd19a7 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -1153,7 +1153,7 @@ static void make_cover_letter(struct rev_info *re=
v, int use_separate_file,
> >                             struct commit *origin,
> >                             int nr, struct commit **list,
> >                             const char *branch_name,
> > -                           int quiet)
> > +                           int quiet, int right_only)
> >  {
> >       const char *committer;
> >       struct shortlog log;
> > @@ -1228,7 +1228,8 @@ static void make_cover_letter(struct rev_info *re=
v, int use_separate_file,
> >                       .creation_factor =3D rev->creation_factor,
> >                       .dual_color =3D 1,
> >                       .diffopt =3D &opts,
> > -                     .other_arg =3D &other_arg
> > +                     .other_arg =3D &other_arg,
> > +                     .right_only =3D right_only
> >               };
> >
> >               diff_setup(&opts);
> > @@ -1732,7 +1733,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >       struct strbuf rdiff2 =3D STRBUF_INIT;
> >       struct strbuf rdiff_title =3D STRBUF_INIT;
> >       int creation_factor =3D -1;
> > -
> > +     int right_only =3D 0;
>
> Nit: the newline between creation_factor's declaration and
> builtin_format_patch_options's is good to keep.
>
> >       const struct option builtin_format_patch_options[] =3D {
> >               OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> >                           N_("use [PATCH n/m] even with a single patch"=
),
> > @@ -1814,6 +1815,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >                            parse_opt_object_name),
> >               OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
> >                          N_("show changes against <refspec> in cover le=
tter or single patch")),
> > +             OPT_BOOL(0, "only-right", &right_only,
> > +                      N_("only emit output related to the second range=
")),
> >               OPT_INTEGER(0, "creation-factor", &creation_factor,
> >                           N_("percentage by which creation is weighted"=
)),
> >               OPT_END()
> > @@ -2087,7 +2090,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >               creation_factor =3D RANGE_DIFF_CREATION_FACTOR_DEFAULT;
> >       else if (!rdiff_prev)
> >               die(_("--creation-factor requires --range-diff"));
> > -
> > +     if (right_only && !rdiff_prev)
> > +             die(_("--right_only requires --range-diff"));
>
> These may be good to combine into one big conditional that dies whenever
> an option requiring --range-diff is set, but --range-diff is not:
>
Good tip.
>   if (!rdiff_prev) {
>     if (creation_factor)
>       die(_("--creation-factor requires --range-diff"));
>     if (right_only)
>       die(_("--right-only requires --range-diff"));
>   }
>
> Thanks,
> Taylor

Thanks,
ZheNing Hu
