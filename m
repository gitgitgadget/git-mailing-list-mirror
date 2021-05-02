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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982BC433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118C9613EA
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhEBGNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 02:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBGNM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 02:13:12 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF226C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 23:12:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s4so1651337ioc.3
        for <git@vger.kernel.org>; Sat, 01 May 2021 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zDkMl+Gsb6E12RI1QohPE0egR+VVPlSZU5JgkjdzWR8=;
        b=Qw9Tv7MAeiCtftx45PUkgRVFke08OisA5CtVUyrUNwdIHco629P+lQeEsMy2haKdqC
         1+CFqHP56wpUtm8TLiKkL4TccS7hRIJaydxCl3bKp/CvKvu6De4Diukpkhxlu92PZ2Ml
         W7tWTt/+PggTTwolKNtZKoYU+WJ6W64VWBgMDLR0ygTx80a4Op5HousVcOhIOrtj6BIA
         38m9HJG7+NHY/l3KlRSqKnvf6ge8yK0we09pY7xwitosOnJOPFF0wzPreZHyMZ8Hl3s5
         cfR2rqdRlNAKcGrSRfE+pJ5lp2sRx3x36VmO2Thv0NZt4n+1/gtd7QQ0csRaOcvl6Gu2
         BPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDkMl+Gsb6E12RI1QohPE0egR+VVPlSZU5JgkjdzWR8=;
        b=ITFQ5NWYiPLjqBmi6auCKfMzjQYvG1KIc6hywsxsmMMpB0UNWP1vZo5NPbURId2RFV
         F1s4AVgoCRebX3zmtrfpf4e6KrYCKbB0HJ3J8SrMPZjQYVZSPXp/QcrA7hxuVq3HdTTd
         acNyGZ0rXdliKocnHbPgZcR9k8CKQuyr6Y55Qj5wqXsa1MEnOy7gpFhmFddhcjA0lFag
         qHkLhSEt2WpNncsR9ffn4FgGiJMW79KIJZlejDjq4ZsWHYZzObE06EXM9EldN5NDq7eF
         QRNHQ9H9Dg33wmA+IdIc6b99+bB3ND0tSfRWba3ANOwMmFv89v9/mWnyFRNlMHn6g3CG
         d5Jw==
X-Gm-Message-State: AOAM53070dx88lZVB0/By0Jy+hxEd8ZA/ZppkC61EjZ1qy1uAd5d0F9Z
        CVzDCt3c9Ji5alctlmAh7tBFvpE1Cjx3kML7sXir1wMlrwWRmOPEADaD7A==
X-Google-Smtp-Source: ABdhPJy3YwiOGDdOlwFrw/PWIbxg+DHPsNYcazWXoIKDSniLTUPVJXOTyOqM/VsNyGLXegmgFo9AAbJgYUUohJvEkKk=
X-Received: by 2002:a5e:8a08:: with SMTP id d8mr4766570iok.192.1619935940323;
 Sat, 01 May 2021 23:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.944.git.1619691880696.gitgitgadget@gmail.com> <38083c1b-f92b-7624-67b7-3a5dcf213d79@web.de>
In-Reply-To: <38083c1b-f92b-7624-67b7-3a5dcf213d79@web.de>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 2 May 2021 14:12:09 +0800
Message-ID: <CAOLTT8TGaVxxHJRF_-Dq0Gnd50_H-80C6zPhjQAQruiO59qw2A@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add %(notes) format atom
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> =E4=BA=8E2021=E5=B9=B45=E6=9C=882=E6=97=A5=
=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=883:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Am 29.04.21 um 12:24 schrieb ZheNing Hu via GitGitGadget:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Note that `--pretty=3D"%N"` can view notes related
> > to the commit. So add `%(notes)` to ref-filter
> > seem is a good choice. This atom `%(notes)` view
> > the notes associated with the ref, and support
> > dereference.
>
> I can't judge the usefulness of this feature because I don't use notes.
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] ref-filter: add %(notes) format atom
> >
> >     An important step in the GSOC project Use ref-filter formats in git
> >     cat-file is to integrate different format atoms into the ref-filter=
.
> >     Olga and Hariom have also made a lot of efforts in this area.
>
> This is done to replace the custom format parser in git cat-file with
> ref-filter in order to reduce code duplication, right?
>
> >     Currently, I noticed that there may be some format atoms in "pretty=
.c"
> >     that have not been migrated to ref-filter, such as --pretty=3D"%N",
> >     --pretty=3D"%(describe)".
>
> git cat-file doesn't support pretty format atoms, so I'm not sure I see
> the connection here.
>

At present, `git cat-file --batch`, `git log --pretty`, and `git
for-each-ref --format`
lack consistency.

The ambition of this project is to unify these different formats
"%aN","%(authorname)"
through an interface, maybe it's `ref-filter` or maybe a new one.

It is estimated that many places in need to be replaced and rebuilt,
and it not just to
reduce code duplication.

Note that `cat-file --batch` should be a superset of `ref-filter` and
`--pretty`, because
it supports all objects, while `ref-filter` only supports "commit" and
"tag" two kinds
of objects, and `--pretty` only supports "commit" one kind of object.

So it may be reasonable to provide `%(notes)` to "commit","tag"
objects in `cat-file --batch`
in the future, now integrate them into ref-filter firstly.

> >     So in this patch, I tried to migrate --pretty=3D%N to --format=3D%(=
notes).
> >
> >     Hope this will be hopeful !!!
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-944%2=
Fadlternative%2Fformat-notes-atom-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-944/adlt=
ernative/format-notes-atom-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/944
> >
> >  Documentation/git-for-each-ref.txt |  4 ++++
> >  ref-filter.c                       | 31 ++++++++++++++++++++++++++++--
> >  t/t6300-for-each-ref.sh            | 10 ++++++++++
> >  3 files changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
> > index 2ae2478de706..07f037a16e13 100644
> > --- a/Documentation/git-for-each-ref.txt
> > +++ b/Documentation/git-for-each-ref.txt
> > @@ -139,6 +139,9 @@ deltabase::
> >       given object, if it is stored as a delta.  Otherwise it
> >       expands to the null object name (all zeroes).
> >
> > +notes::
> > +     The notes associated with the ref.
> > +
> >  upstream::
> >       The name of a local ref which can be considered ``upstream''
> >       from the displayed ref. Respects `:short`, `:lstrip` and
> > @@ -302,6 +305,7 @@ git for-each-ref --count=3D3 --sort=3D'-*authordate=
' \
> >  Subject: %(*subject)
> >  Date: %(*authordate)
> >  Ref: %(*refname)
> > +Notes: %(*notes)
> >
> >  %(*body)
> >  ' 'refs/tags'
> > diff --git a/ref-filter.c b/ref-filter.c
> > index a0adb4551d87..42a5608a3056 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -23,6 +23,7 @@
> >  #include "worktree.h"
> >  #include "hashmap.h"
> >  #include "strvec.h"
> > +#include "run-command.h"
> >
> >  static struct ref_msg {
> >       const char *gone;
> > @@ -506,6 +507,7 @@ static struct {
> >       { "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser=
 },
> >       { "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
> >       { "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
> > +     { "notes", SOURCE_OTHER, FIELD_STR },
> >       { "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
> >       { "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
> >       { "numparent", SOURCE_OBJ, FIELD_ULONG },
> > @@ -953,6 +955,24 @@ static int grab_oid(const char *name, const char *=
field, const struct object_id
> >       return 0;
> >  }
> >
> > +static int grab_notes(const struct object_id *oid, struct atom_value *=
v)
> > +{
> > +     struct child_process cmd =3D CHILD_PROCESS_INIT;
> > +     struct strbuf out =3D STRBUF_INIT;
> > +     struct strbuf err =3D STRBUF_INIT;
> > +     const char *args[] =3D { "notes", "show", NULL };
> > +     int ret;
> > +
> > +     cmd.git_cmd =3D 1;
> > +     strvec_pushv(&cmd.args, args);
> > +     strvec_push(&cmd.args, oid_to_hex(oid));
> > +     ret =3D pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);
>
> Nice prototype.  Is it possible to avoid the overhead of calling git
> notes as an external process by calling load_display_notes() once at
> parse time and format_display_notes() for each item?  Would it cause
> conflicts for code that uses ref-filter and handles notes already?
>

This sounds feasible, I will try if it can work.

Thanks!
--
ZheNing Hu
