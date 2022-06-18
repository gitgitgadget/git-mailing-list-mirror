Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CBBC433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 10:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiFRK7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiFRK72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 06:59:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5B1837E
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 03:59:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so4498153ilj.11
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0lpm7wlCXJnLr1QjgeEdR+63p8x1eNJSBMot+Ow1bao=;
        b=NekwnURZSrjVGsulMJg5h7MCAkY1We26T/CTXXdiyQS1mpkLdhOSH/Hy+oy9DUvmB0
         12g0B7qJQHP4fOKVoDKrnofAXc6vAntQ7Jbjr/6dFpFW+NszvwjiD5ylR2hvLemOdwfR
         7myrJO48T8YLflQ0/11mNiuM2x6Y2z7bpbes98ysXzYmzAKctmPihDAueOK20f5MmwY4
         gu2wHVc/conB2SkKmTs3bYcBwGe3mRE/2l+V0JA91V1jG3BfcfOCafqe1Jt1r73ZfZ+C
         XqTFPmMfJOhd51Zrwx5ZZKlAMsX6j6pcrC8eXfI7Jl6R6H4V73jZEcU8zXko0mlqjPWP
         u/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0lpm7wlCXJnLr1QjgeEdR+63p8x1eNJSBMot+Ow1bao=;
        b=D+hzhKW3eOztj4p3oQHcr3tI0/LWl3nt2Sw/2wnYr7/WiZi/clTNLaX9jbm+Hc1oAx
         tSFijajcTgKGbmPzGkZAj3f/lirV+noyIGg4KU36BLOZw6XGe/FODSjv7bPLdf/C62MW
         H42c8QwvMF4MQzOom4VHYfk17XpLh8bxDMEwFDPmIw/E5xKaGcqGQyZq5L6VFOGhRwDL
         AV2/RvGfyDBR8kFj0vnCcPLHqM2/54vps0+LkLhgaUUnluyBVJHIpWnkmgt3EkPRuoCU
         y0rfY4LE8dgS3fAI2qVITMP0P8AuiLTvlhbGUG2QOI3j5Tk/Bixv7aK/fRKawl5KNuMl
         fvHQ==
X-Gm-Message-State: AJIora83AV7wGGVIW5lyne4Xr9BE26oGpP8QXB5abYUSNid8JUajpDnT
        8S0TYwoCyxI/WLfm1vYjYg3PLR6YVV3NXT/2OCTf8DCOF7RAYxZq
X-Google-Smtp-Source: AGRyM1ucTyiBUGWoGmtA7EdA/JODvVP3fgRiCqOqCeckx6fk+JAI9JZTzKdKoT/H9retD1fHS7p9UpNZf1+ZzvTtr7Q=
X-Received: by 2002:a05:6e02:1a43:b0:2d3:cded:23dc with SMTP id
 u3-20020a056e021a4300b002d3cded23dcmr7709254ilv.43.1655549966781; Sat, 18 Jun
 2022 03:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
 <81ae1280e8eb471c7a11dceb0aa7a8915948b2ce.1655300752.git.gitgitgadget@gmail.com>
 <220615.865yl1y8qh.gmgdl@evledraar.gmail.com>
In-Reply-To: <220615.865yl1y8qh.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 18 Jun 2022 18:59:15 +0800
Message-ID: <CAOLTT8R35G2dcquO5uXHxnt2NKwgpFZ48ZqmKyiE2yCi0+SLEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ls-files: introduce "--object-only" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B46=E6=9C=8816=E6=97=A5=E5=91=A8=E5=9B=9B 04:25=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Wed, Jun 15 2022, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > --object-only is an alias for --format=3D%(objectname),
> > which output objectname of index entries, taking
> > inspiration from the option with the same name in
> > the `git ls-tree` command.
> >
> > --object-only cannot be used with --format, and -s, -o,
> > -k, --resolve-undo, --deduplicate, --debug.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  Documentation/git-ls-files.txt |  8 +++++++-
> >  builtin/ls-files.c             | 36 +++++++++++++++++++++++++++++++++-
> >  t/t3013-ls-files-format.sh     | 34 ++++++++++++++++++++++++++++++++
> >  3 files changed, 76 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > index b22860ec8c0..c3f46bb821b 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -13,7 +13,7 @@ SYNOPSIS
> >               [-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored=
]
> >               [-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modifie=
d]
> >               [--directory [--no-empty-directory]] [--eol]
> > -             [--deduplicate]
> > +             [--deduplicate] [--object-only]
> >               [-x <pattern>|--exclude=3D<pattern>]
> >               [-X <file>|--exclude-from=3D<file>]
> >               [--exclude-per-directory=3D<file>]
> > @@ -199,6 +199,12 @@ followed by the  ("attr/<eolattr>").
> >       interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (=
LF).
> >       --format cannot be combined with `-s`, `-o`, `-k`, `--resolve-und=
o`,
> >       `--debug`.
> > +
> > +--object-only::
> > +     List only names of the objects, one per line. This is equivalent
> > +     to specifying `--format=3D'%(objectname)'`. Cannot be combined wi=
th
> > +     `--format=3D<format>`.
> > +
> >  \--::
> >       Do not interpret any more arguments as options.
> >
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index 9dd6c55eeb9..4ac8f34baac 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -60,6 +60,27 @@ static const char *tag_modified =3D "";
> >  static const char *tag_skip_worktree =3D "";
> >  static const char *tag_resolve_undo =3D "";
> >
> > +static enum ls_files_cmdmode {
> > +     MODE_DEFAULT =3D 0,
> > +     MODE_OBJECT_ONLY,
> > +} ls_files_cmdmode;
> > +
> > +struct ls_files_cmdmodee_to_fmt {
> > +     enum ls_files_cmdmode mode;
> > +     const char *const fmt;
> > +};
> > +
> > +static struct ls_files_cmdmodee_to_fmt ls_files_cmdmode_format[] =3D {
> > +     {
> > +             .mode =3D MODE_DEFAULT,
> > +             .fmt =3D NULL,
> > +     },
> > +     {
> > +             .mode =3D MODE_OBJECT_ONLY,
> > +             .fmt =3D "%(objectname)",
> > +     },
> > +};
> [...snip...]
>
> This code all looks OK from skimming it, and is substantially copied
> from builtin/ls-tree.c (which is good).
>
> But I wonder as in that case whether having such an alias is worth it at
> all, especially since in the case of ls-files (unlike ls-tree) we don't
> start out with various --just-the-X-field type options, this is the
> first one.
>
> So I *really* like that you took my suggestion of "why not a --format"
> from a previous round, but given the above for ls-files in particular is
> it really worth it to have this extra code just to type:
>
>     --object-only
>
> Instead of:
>
>     --format=3D"%(objectname)"
>
> So, maybe, and I'm not set against it, but I think it's worth
> re-evaluating in this case.
>
> In particular because the part of ls-tree's code is missing here where
> we "format optimize", i.e. we take a form like:
>
>     --format=3D"%(objectname)"
>
> And dispatch it to the more optimized special function, instead of the
> generic strbuf_expand(), whereas in this case it's the other way around,
> the option is just an alias for --format.

Thanks for clarifying that --object-only uses the fast path instead of a si=
mple
alias of --format=3D%(objectname). Maybe I should do this too, or just
drop this patch
because git ls-file --format has included such a function :-)

ZheNing Hu
