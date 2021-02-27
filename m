Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA18EC433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA264E7A
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhB0Hba (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 02:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhB0HbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 02:31:25 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C1C06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 23:30:44 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b8so11396227oti.7
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 23:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NrxKsznlHSHdZ9v6ltaaFT+0vJcWYSLY3zs4LdRYKZo=;
        b=uX5vEt73hWnr5OeHB3AJjdZKqgrYjOoUSfoYTwTynIpM/5rIeOsZ41mgC6QOP0UGrh
         Kr+i1mnfz1zeWQ7NW+GUOJKVc7dSP7oLxCC2GZmVLxH82NAETe4t9709wZJnqm2OUycq
         b4uidJHtqU6iiWu0XGTEFMxk1QANGISJVRfSH2JTGp0LwW1m3iASIT9L2cg6LOgArHwa
         n/MCIu42WSd8FXz9GvVTnSiImsP0gvCMe1OMKNz4zdmXSL0pzfJIhXJ0gTGZf4aZ9WAU
         uWqZvKmPYZ/pSDS2iaCqv58TYpYH0Ci4JYdYZ/qK381WorOFzyX2Nb3nTwzQbGXU2yJE
         eivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NrxKsznlHSHdZ9v6ltaaFT+0vJcWYSLY3zs4LdRYKZo=;
        b=bgHm7GKMZBd9y5GFwto3RwV20xvd8GJKhxzHIt2GvDlRSeg3j+kt4GdnXCIzCFx2KI
         vheRgfk7gBj7X+3VV2KHDdWdvPuEfl0doGJxvr79wL3TvTc+8e9UVS5fRzvQX/lR8ksq
         +5LGzGMaF7WiaHLjzPIgTpNG6WNaAy/0NXb3XuR5Aottz0MyTsvTAHt5RRMahvKhGKTg
         DMcv7NMwgGBNhDpC6ELpsJvW/RhPOeFlZdEtGZIaJSQAWffsdmrN/OAreMW5YL+IYu0s
         vtY01xh73wTR1fkF9da9U3+D0u+c09oFxRs6v+rcioNWxJL/imL39LfGqPk/+R4JnElb
         an8g==
X-Gm-Message-State: AOAM530b8YWqyyzA+F/96Syr/tYDbJOCdlDBXzi9RnOQrbPPXXgP+4rt
        fnZFKhjgRZ9nvFhNgJ3oGgOMrElkvm4h9R3UGto=
X-Google-Smtp-Source: ABdhPJwAI3jkTIaItu/E24Kv+nLtanLCV2h3F34V/6sX3jqz23ak9z1WgbBoUc76bpAIm8OBPUMoFdzd341ZIh6FXqU=
X-Received: by 2002:a9d:6308:: with SMTP id q8mr5259494otk.160.1614411043448;
 Fri, 26 Feb 2021 23:30:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com> <xmqqzgzsuibf.fsf@gitster.g>
In-Reply-To: <xmqqzgzsuibf.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 27 Feb 2021 15:30:31 +0800
Message-ID: <CAOLTT8RVxdmt+f+TNt7uxTp3CJv5_9xtTwzGw7hw0NJuWPXa3Q@mail.gmail.com>
Subject: Re: [PATCH] format-patch: allow a non-integral version numbers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:13=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but if we can provide `format-patch` with
> > non-integer versions numbers of patches, this may help us to send patch=
es
> > such as "v1.1" versions sometimes.
>
> A pro-tip.  Do not make your change sound like "because we can do
> this"; a change sells a lot easier if it were "because we need
> this---see how useful it is in such and such cases".
OK. I will fully express the advantages of these patches in the future.
>
> I am not in principle opposed to support a fractional version number
> that comes after an integral one, which allows users to signal that
> it is a minor correction that does not deserve a full version bump.
>
> But not in this form.
>
>  - This implementation regresses the output of the diff_version()
>    helper function, and does so deliberately, even by butchering a
>    test that protects it to hide the regression from the test suite.
>
>    "This is the change from the last version" is expecting too much
>    from the reviewers.  Those who may recall seeing your v3 may have
>    been otherwise occupied for a few weeks and ununware of your v4.
>
>  - It also closes the door to a feature that is occasionally
>    requested to update the make_cover_letter() to carry title and
>    description over from the previous iteration.
>
Indeed.
> If we were to do this, I would probably suggest a preliminary patch
> that refactors the hardcoded "reroll_count - 1" out of diff_title()
> so that the helper takes two "reroll count strings", i.e. reroll
> count for this round, and the previous round, as two separate
> parameters.  Teach the caller to pass "reroll_count - 1" for the new
> parameter in this preliminary step.
>
I like the idea.
> Then in the main patch, soon after we finish parsing the command
> line options to learn we got "-v$N" argument:
>
>  (0) It might be acceptable to teach the command a new option to
>      allow end-users to explicitly give the previous reroll count
>      string from the command line.  If we were to do so, skip
>      everything below when such an option is used and use the
>      user-supplied one.
>

>  (1) If $N is an integer, use $N and $N-1 as the reroll count
>      strings for this and previous round.
>
My patch still in WIP state,but (1) work here.

>  (2) Otherwise, scan for "v(.*)-0*-cover-letter.$suffix" in the
>      output directory to find all previous rerolls, and pick the one
>      that sorts the last and before $N (use versioncmp).  If there
>      are existing v1-, v2-, etc., and if we are given "-v2.1" from
>      the command line, we'd want to grab v2 as the previous reroll
>      count.
>
I have some doubts:
(1) if the user generates multiple patches through the `git format patch -v=
<n>`,
they may be placed under different folders, we may not assert what the
version number of the previous version of the patch is by looking at all
patches in one directory.
(2) "0000-1234-cover-letter.patch" this form may also need to be considered=
 in
the v(. *)-0*- cover-letter.$suffix".
for the time being, this approach will be more cumbersome.
>  (3) After doing the above steps, if we still do not have the
>      previous reroll count string, error out.
>
>      You could argue that we may optionally work in degraded mode,
>      using "last version" as the fallback value for the previous
>      round count string, and it may work for some things (e.g. the
>      "change against the last round" label) and not for other things
>      (e.g. reuse description in the previous cover letter).  I would
>      not recommend it.
>
> And then, we have two reroll count strings that we can feed
> diff_title(); we also can later use the reroll count string for the
> previous round to teach make_cover_letter() read and recover the
> description from the cover letter of the previous round.
>
> Thanks.
>
I think the user should be allowed to provide the previous version number
 in the console. If the specified `reroll_count=3D<n>` is integrated, then =
we will
use `n-1` in the `diff_title`, or if the user specifies `
previous_count `, we will
use `previous_count` in `diff title`, otherwise, `generic` in the parameter=
 of
`diff_title` will be used.
I don=E2=80=99t know if my ideas like this are inadequate, hope you can poi=
nt it out.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] format-patch: allow a non-integral version numbers
> >
> >      * format-patch previously only integer version number -v<n>, now t=
rying
> >        to provide a non-integer version.
> >
> >     this want to fix #882 Thanks.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2=
Fadlternative%2Fformat_patch_non_intergral-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlt=
ernative/format_patch_non_intergral-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/885
> >
> >  Documentation/git-format-patch.txt |  6 +++---
> >  builtin/log.c                      | 20 ++++++++++----------
> >  log-tree.c                         |  4 ++--
> >  revision.h                         |  2 +-
> >  t/t4014-format-patch.sh            |  8 ++++----
> >  5 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> > index 3e49bf221087..0cc39dbf573c 100644
> > --- a/Documentation/git-format-patch.txt
> > +++ b/Documentation/git-format-patch.txt
> > @@ -215,12 +215,12 @@ populated with placeholder text.
> >
> >  -v <n>::
> >  --reroll-count=3D<n>::
> > -     Mark the series as the <n>-th iteration of the topic. The
> > +     Mark the series as the specified version of the topic. The
> >       output filenames have `v<n>` prepended to them, and the
> >       subject prefix ("PATCH" by default, but configurable via the
> >       `--subject-prefix` option) has ` v<n>` appended to it.  E.g.
> > -     `--reroll-count=3D4` may produce `v4-0001-add-makefile.patch`
> > -     file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> > +     `--reroll-count 4.4` may produce `v4.4-0001-add-makefile.patch`
> > +     file that has "Subject: [PATCH v4.4 1/20] Add makefile" in it.
> >
> >  --to=3D<email>::
> >       Add a `To:` header to the email headers. This is in addition
> > diff --git a/builtin/log.c b/builtin/log.c
> > index f67b67d80ed1..72af140b812e 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -1662,13 +1662,13 @@ static void print_bases(struct base_tree_info *=
bases, FILE *file)
> >       oidclr(&bases->base_commit);
> >  }
> >
> > -static const char *diff_title(struct strbuf *sb, int reroll_count,
> > +static const char *diff_title(struct strbuf *sb, const char *reroll_co=
unt,
> >                      const char *generic, const char *rerolled)
> >  {
> > -     if (reroll_count <=3D 0)
> > +     if (!reroll_count)
> >               strbuf_addstr(sb, generic);
> >       else /* RFC may be v0, so allow -v1 to diff against v0 */
> > -             strbuf_addf(sb, rerolled, reroll_count - 1);
> > +             strbuf_addf(sb, rerolled, "last version");
> >       return sb->buf;
> >  }
> >
> > @@ -1717,7 +1717,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >       struct strbuf buf =3D STRBUF_INIT;
> >       int use_patch_format =3D 0;
> >       int quiet =3D 0;
> > -     int reroll_count =3D -1;
> > +     const char *reroll_count =3D NULL;
> >       char *cover_from_description_arg =3D NULL;
> >       char *branch_name =3D NULL;
> >       char *base_commit =3D NULL;
> > @@ -1751,8 +1751,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >                           N_("use <sfx> instead of '.patch'")),
> >               OPT_INTEGER(0, "start-number", &start_number,
> >                           N_("start numbering patches at <n> instead of=
 1")),
> > -             OPT_INTEGER('v', "reroll-count", &reroll_count,
> > -                         N_("mark the series as Nth re-roll")),
> > +             OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll=
-count"),
> > +                         N_("mark the series as specified version re-r=
oll")),
> >               OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max=
,
> >                           N_("max length of output filename")),
> >               OPT_CALLBACK_F(0, "rfc", &rev, NULL,
> > @@ -1862,9 +1862,9 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >       if (cover_from_description_arg)
> >               cover_from_description_mode =3D parse_cover_from_descript=
ion(cover_from_description_arg);
> >
> > -     if (0 < reroll_count) {
> > +     if (reroll_count) {
> >               struct strbuf sprefix =3D STRBUF_INIT;
> > -             strbuf_addf(&sprefix, "%s v%d",
> > +             strbuf_addf(&sprefix, "%s v%s",
> >                           rev.subject_prefix, reroll_count);
> >               rev.reroll_count =3D reroll_count;
> >               rev.subject_prefix =3D strbuf_detach(&sprefix, NULL);
> > @@ -2080,7 +2080,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >               rev.idiff_oid2 =3D get_commit_tree_oid(list[0]);
> >               rev.idiff_title =3D diff_title(&idiff_title, reroll_count=
,
> >                                            _("Interdiff:"),
> > -                                          _("Interdiff against v%d:"))=
;
> > +                                          _("Interdiff against %s:"));
> >       }
> >
> >       if (creation_factor < 0)
> > @@ -2099,7 +2099,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >               rev.creation_factor =3D creation_factor;
> >               rev.rdiff_title =3D diff_title(&rdiff_title, reroll_count=
,
> >                                            _("Range-diff:"),
> > -                                          _("Range-diff against v%d:")=
);
> > +                                          _("Range-diff against %s:"))=
;
> >       }
> >
> >       if (!signature) {
> > diff --git a/log-tree.c b/log-tree.c
> > index 4531cebfab38..5f2e08ebcaab 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -369,8 +369,8 @@ void fmt_output_subject(struct strbuf *filename,
> >       int start_len =3D filename->len;
> >       int max_len =3D start_len + info->patch_name_max - (strlen(suffix=
) + 1);
> >
> > -     if (0 < info->reroll_count)
> > -             strbuf_addf(filename, "v%d-", info->reroll_count);
> > +     if (info->reroll_count)
> > +             strbuf_addf(filename, "v%s-", info->reroll_count);
> >       strbuf_addf(filename, "%04d-%s", nr, subject);
> >
> >       if (max_len < filename->len)
> > diff --git a/revision.h b/revision.h
> > index e6be3c845e66..097d08354c61 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -235,7 +235,7 @@ struct rev_info {
> >       const char      *mime_boundary;
> >       const char      *patch_suffix;
> >       int             numbered_files;
> > -     int             reroll_count;
> > +     const char      *reroll_count;
> >       char            *message_id;
> >       struct ident_split from_ident;
> >       struct string_list *ref_message_ids;
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index 66630c8413d5..b911e08f0810 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -372,10 +372,10 @@ test_expect_success 'filename limit applies only =
to basename' '
> >
> >  test_expect_success 'reroll count' '
> >       rm -fr patches &&
> > -     git format-patch -o patches --cover-letter --reroll-count 4 main.=
.side >list &&
> > -     ! grep -v "^patches/v4-000[0-3]-" list &&
> > +     git format-patch -o patches --cover-letter --reroll-count 4.4 mai=
n..side >list &&
> > +     ! grep -v "^patches/v4.4-000[0-3]-" list &&
> >       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > -     ! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
> > +     ! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
> >  '
> >
> >  test_expect_success 'reroll count (-v)' '
> > @@ -2252,7 +2252,7 @@ test_expect_success 'interdiff: cover-letter' '
> >
> >  test_expect_success 'interdiff: reroll-count' '
> >       git format-patch --cover-letter --interdiff=3Dboop~2 -v2 -1 boop =
&&
> > -     test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
> > +     test_i18ngrep "^Interdiff ..* last version:$" v2-0000-cover-lette=
r.patch
> >  '
> >
> >  test_expect_success 'interdiff: solo-patch' '
> >
> > base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
