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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF13C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 04:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E30864FFD
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 04:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCEE4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 23:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEE4a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 23:56:30 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CDC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 20:56:30 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q203so1174138oih.5
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 20:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=66QjjdDVPxtuKZUI8lLQsD6WjOa+B7jVWvZbeuPxing=;
        b=BieM9VlmyU4O5hK/4MmLCJEXwv44VphvYhInrVTPDzu8/nHaOBTd3/fw8k86geRC4i
         buHVY3Xvj7bcZ64lURumSHXUQO04OIlCfaNgnPFy+ye7s3KlXBA8xyM8PUe/gf1kHlON
         8Rfnm3OiR1pT+sdYmcDb0dlcs3TNYNMU96pPW9BL57v37uZMLaOHp17tGj8ul1DtLaht
         UEPty+ynOVnfOvdDJFqB/RqjOyg6fXPXwyIxQaSggQun/gkMpDmZmkoPCEXRSXDh9iZ4
         mcmLcr7X92NqXtT7i6tjEc/owp0SlrRCUnByIOdl6GDl9LghorD7JgkufVogFzzJaRPU
         QI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=66QjjdDVPxtuKZUI8lLQsD6WjOa+B7jVWvZbeuPxing=;
        b=CIH/vNWQEAyYjR0xGziKT3cDrdPx5+gM0paBgluS1LDHDsRR6G3W6MWq1g4fNeCueT
         HbROjXZD+0iQzpl2/pY8gAtNRccn5Ssm9QkIWCqIeJ4NQ0qNudKd1IpOSP1ZokCPk+ZY
         Swz+fXslmGK/+3O2aswhNsjAzTkJ2mttr3i8crFvLp7P4TtgheA5CypI1ZqVxZMdmvlZ
         +omhxjEj3z/KppnVQOrZdXUXUJ2tBPvg6mxWYsRGTmPelWQycmMvWZgRL7eln6yf3UQX
         LSA058Ky3bwDSyi+hN4J/FqzTw2ukYgudQOfcoQaB8r43VvOw2wesHttYIaki7psoH4q
         9J2A==
X-Gm-Message-State: AOAM532z1PmDMi8t2EHNXByXZbrZ3hgZUNPoiqKyiZtTORGjUszhFjFH
        1Lc22DwhLoG1JlW/GPdfpfug3BMiLMFBARiC36I=
X-Google-Smtp-Source: ABdhPJzpp0FRH8/VEV4AuhHMxYhEH+qcAWrLD+Vlhn/siOhjm56UOlHQWLwlFx9Zt8yu7YVt0Fxb5TMCEhVd1KIRiSc=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr1833102oia.44.1614920189216;
 Thu, 04 Mar 2021 20:56:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
 <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com> <YEDXQCOyQmw61zYZ@generichostname>
In-Reply-To: <YEDXQCOyQmw61zYZ@generichostname>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 5 Mar 2021 12:56:17 +0800
Message-ID: <CAOLTT8Q-8512Zbs4qh9PU0XZjr7JpgL80V9ZFnhKQNbmu9GA7g@mail.gmail.com>
Subject: Re: [PATCH v3] format-patch: allow a non-integral version numbers
To:     Denton Liu <liu.denton@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=884=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing,
>
> On Thu, Mar 04, 2021 at 12:12:06PM +0000, ZheNing Hu via GitGitGadget wro=
te:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but sometimes a same fixup should be
> > labeled as a non-integral versions like `v1.1`, so teach `format-patch`
>
> s/versions/version/
>
> > to allow a non-integral versions may be helpful to send those patches.
>
> s/may be/which &/
>
> >
> > Since the original `format-patch` logic, if we specify a version `-v<n>=
`
> > and commbine with `--interdiff` or `--rangediff`, the patch will output
> > "Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but this does
> > not meet the requirements of our fractional version numbers, so if the
> > user use a integral version number `-v<n>`, ensure that the output in
> > the patch is still `v<n-1>`; otherwise, only output "Interdiff" or
> > "Range-diff".
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] format-patch: allow a non-integral version numbers
> >
> >     There is a small question: in the case of --reroll-count=3D<n>, "n"=
 is an
> >     integer, we output "n-1" in the patch instead of "m" specified by
> >     --previous-count=3D<m>,Should we switch the priority of these two: =
let "m"
> >     output?
> >
> >     this want to fix #882 Thanks.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2=
Fadlternative%2Fformat_patch_non_intergral-v3
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlt=
ernative/format_patch_non_intergral-v3
> > Pull-Request: https://github.com/gitgitgadget/git/pull/885
> >
> > Range-diff vs v2:
> >
> >  1:  800094cbf53b ! 1:  d4f38b78c464 format-patch: allow a non-integral=
 version numbers
> >      @@ Commit message
> >
> >           Usually we can only use `format-patch -v<n>` to generate inte=
gral
> >           version numbers patches, but sometimes a same fixup should be
> >      -    laveled as a non-integral versions like `v1.1`,so teach forma=
t-patch
> >      -    allow a non-integral versions may be helpful to send those pa=
tches.
> >      +    labeled as a non-integral versions like `v1.1`, so teach `for=
mat-patch`
> >      +    to allow a non-integral versions may be helpful to send those=
 patches.
> >
> >           Since the original `format-patch` logic, if we specify a vers=
ion `-v<n>`
> >           and commbine with `--interdiff` or `--rangediff`, the patch w=
ill output
> >           "Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but =
this does
> >      -    not meet the requirements of our fractional version numbers, =
so provide
> >      -    `format patch` a new option `--previous-count=3D<n>`, the pat=
ch can output
> >      -    user-specified previous version number. If the user use a int=
egral version
> >      -    number `-v<n>`, ensure that the output in the patch is still =
`v<n-1>`.
> >      -    (let `--previous-count` become invalid.)
> >      +    not meet the requirements of our fractional version numbers, =
so if the
> >      +    user use a integral version number `-v<n>`, ensure that the o=
utput in
> >      +    the patch is still `v<n-1>`; otherwise, only output "Interdif=
f" or
> >      +    "Range-diff".
> >
> >           Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> >
> >        ## Documentation/git-format-patch.txt ##
> >      -@@ Documentation/git-format-patch.txt: SYNOPSIS
> >      -                   [--cover-from-description=3D<mode>]
> >      -                   [--rfc] [--subject-prefix=3D<subject prefix>]
> >      -                   [(--reroll-count|-v) <n>]
> >      -+                  [--previous-count=3D<n>]
> >      -                   [--to=3D<email>] [--cc=3D<email>]
> >      -                   [--[no-]cover-letter] [--quiet]
> >      -                   [--[no-]encode-email-headers]
> >       @@ Documentation/git-format-patch.txt: populated with placeholder=
 text.
> >               `--subject-prefix` option) has ` v<n>` appended to it.  E=
.g.
> >               `--reroll-count=3D4` may produce `v4-0001-add-makefile.pa=
tch`
> >               file that has "Subject: [PATCH v4 1/20] Add makefile" in =
it.
> >       +       now can support non-integrated version number like `-v1.1=
`.
> >      -+
> >      -+--previous-count=3D<n>::
> >      -+       Under the premise that we have used `--reroll-count=3D<n>=
`,
> >      -+       we can use `--previous-count=3D<n>` to specify the previo=
us
> >      -+       version number. E.g. When we use the `--range-diff` or
> >      -+       `--interdiff` option and combine with `-v2.3 --previous-c=
ount=3D2.2`,
> >      -+       "Interdiff against v2.2:" or "Range-diff against v2.2:"
> >      -+       will be output in the patch.
> >
> >        --to=3D<email>::
> >               Add a `To:` header to the email headers. This is in addit=
ion
> >      @@ builtin/log.c: static void print_bases(struct base_tree_info *b=
ases, FILE *file)
> >
> >       -static const char *diff_title(struct strbuf *sb, int reroll_coun=
t,
> >       -                      const char *generic, const char *rerolled)
> >      -+static const char *diff_title(struct strbuf *sb, const char *rer=
oll_count, int reroll_count_is_integer,
> >      -+                       const char*previous_count, const char *ge=
neric, const char *rerolled)
> >      ++static const char *diff_title(struct strbuf *sb,
> >      ++                       const char *reroll_count_string,
> >      ++                       const char*previous_count_string,
> >      ++                       const char *generic, const char *rerolled=
)
> >        {
> >       -       if (reroll_count <=3D 0)
> >      -+       if (!reroll_count || (!reroll_count_is_integer && !previo=
us_count))
> >      ++       if (!reroll_count_string || !previous_count_string)
> >                       strbuf_addstr(sb, generic);
> >       -       else /* RFC may be v0, so allow -v1 to diff against v0 */
> >       -               strbuf_addf(sb, rerolled, reroll_count - 1);
> >      -+       else if (reroll_count_is_integer)/* RFC may be v0, so all=
ow -v1 to diff against v0 */
> >      -+               strbuf_addf(sb, rerolled, atoi(reroll_count) - 1)=
;
> >      -+       else if (previous_count)
> >      -+               strbuf_addf(sb, rerolled, previous_count);
> >      ++       else if (previous_count_string)
> >      ++               strbuf_addf(sb, rerolled, previous_count_string);
> >               return sb->buf;
> >        }
> >
> >       @@ builtin/log.c: int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
> >      -        struct strbuf buf =3D STRBUF_INIT;
> >               int use_patch_format =3D 0;
> >               int quiet =3D 0;
> >      --       int reroll_count =3D -1;
> >      -+       int reroll_count_is_integer =3D 0;
> >      -+       const char *reroll_count =3D NULL;
> >      -+       const char *previous_count =3D NULL;
> >      +        int reroll_count =3D -1;
> >      ++       const char *reroll_count_string =3D NULL;
> >      ++       const char *previous_count_string =3D NULL;
> >               char *cover_from_description_arg =3D NULL;
> >               char *branch_name =3D NULL;
> >               char *base_commit =3D NULL;
> >      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv=
, const char *pre
> >                                   N_("start numbering patches at <n> in=
stead of 1")),
> >       -               OPT_INTEGER('v', "reroll-count", &reroll_count,
> >       -                           N_("mark the series as Nth re-roll"))=
,
> >      -+               OPT_STRING('v', "reroll-count", &reroll_count, N_=
("reroll-count"),
> >      ++               OPT_STRING('v', "reroll-count", &reroll_count_str=
ing, N_("reroll-count"),
> >       +                           N_("mark the series as specified vers=
ion re-roll")),
> >      -+               OPT_STRING(0, "previous-count", &previous_count, =
N_("previous-count"),
> >      -+                           N_("specified as the last version whi=
le we use --reroll-count")),
> >                       OPT_INTEGER(0, "filename-max-length", &fmt_patch_=
name_max,
> >                                   N_("max length of output filename")),
> >                       OPT_CALLBACK_F(0, "rfc", &rev, NULL,
> >       @@ builtin/log.c: int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
> >      -
> >               if (cover_from_description_arg)
> >                       cover_from_description_mode =3D parse_cover_from_=
description(cover_from_description_arg);
> >      --
> >      +
> >       -       if (0 < reroll_count) {
> >      -+       if (previous_count && !reroll_count)
> >      -+               usage(_("previous-count can only used when reroll=
-count is used"));
> >      -+       if (reroll_count) {
> >      ++       if (reroll_count_string) {
> >                       struct strbuf sprefix =3D STRBUF_INIT;
> >       -               strbuf_addf(&sprefix, "%s v%d",
> >      -+               char ch;
> >      -+               size_t i =3D 0 , reroll_count_len =3D strlen(rero=
ll_count);
> >      +-                           rev.subject_prefix, reroll_count);
> >      +-               rev.reroll_count =3D reroll_count;
> >      ++               char *endp;
> >       +
> >      -+               for (; i !=3D reroll_count_len; i++) {
> >      -+                       ch =3D reroll_count[i];
> >      -+                       if(!isdigit(ch))
> >      -+                               break;
> >      ++               reroll_count =3D strtoul(reroll_count_string, &en=
dp, 10);
> >      ++               if (!*endp && 0 < reroll_count) {
> >      ++                       previous_count_string =3D xstrfmt("%d", r=
eroll_count - 1);
> >       +               }
> >      -+               reroll_count_is_integer =3D i =3D=3D reroll_count=
_len ? 1 : 0;
> >       +               strbuf_addf(&sprefix, "%s v%s",
> >      -                            rev.subject_prefix, reroll_count);
> >      -                rev.reroll_count =3D reroll_count;
> >      ++                           rev.subject_prefix, reroll_count_stri=
ng);
> >      ++               rev.reroll_count =3D reroll_count_string;
> >                       rev.subject_prefix =3D strbuf_detach(&sprefix, NU=
LL);
> >      +        }
> >      +
> >       @@ builtin/log.c: int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
> >      +                        die(_("--interdiff requires --cover-lette=
r or single patch"));
> >                       rev.idiff_oid1 =3D &idiff_prev.oid[idiff_prev.nr =
- 1];
> >                       rev.idiff_oid2 =3D get_commit_tree_oid(list[0]);
> >      -                rev.idiff_title =3D diff_title(&idiff_title, rero=
ll_count,
> >      +-               rev.idiff_title =3D diff_title(&idiff_title, rero=
ll_count,
> >       -                                            _("Interdiff:"),
> >       -                                            _("Interdiff against=
 v%d:"));
> >      -+                       reroll_count_is_integer, previous_count, =
_("Interdiff:"),
> >      -+                               reroll_count_is_integer ? _("Inte=
rdiff against v%d:") :
> >      ++               rev.idiff_title =3D diff_title(&idiff_title, rero=
ll_count_string,
> >      ++                                       previous_count_string,
> >      ++                                       _("Interdiff:"),
> >       +                                       _("Interdiff against v%s:=
"));
> >               }
> >
> >               if (creation_factor < 0)
> >       @@ builtin/log.c: int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
> >      +                rev.rdiff1 =3D rdiff1.buf;
> >                       rev.rdiff2 =3D rdiff2.buf;
> >                       rev.creation_factor =3D creation_factor;
> >      -                rev.rdiff_title =3D diff_title(&rdiff_title, rero=
ll_count,
> >      +-               rev.rdiff_title =3D diff_title(&rdiff_title, rero=
ll_count,
> >       -                                            _("Range-diff:"),
> >       -                                            _("Range-diff agains=
t v%d:"));
> >      -+                       reroll_count_is_integer, previous_count, =
_("Range-diff:"),
> >      -+                               reroll_count_is_integer ? _("Rang=
e-diff against v%d:") :
> >      ++               rev.rdiff_title =3D diff_title(&rdiff_title, rero=
ll_count_string,
> >      ++                                       previous_count_string,
> >      ++                                       _("Range-diff:"),
> >       +                                       _("Range-diff against v%s=
:"));
> >               }
> >
> >      @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --rang=
e-diff as comment
> >               grep "> 1: .* new message" 0001-*
> >        '
> >
> >      -+test_expect_success 'format-patch --range-diff reroll-count with=
 a non-integer and previous-count ' '
> >      -+       git format-patch --range-diff=3DHEAD~1 -v2.9 --previous-c=
ount=3D2.8 HEAD~1 >actual &&
> >      ++test_expect_success 'format-patch --range-diff reroll-count with=
 a non-integer' '
> >      ++       git format-patch --range-diff=3DHEAD~1 -v2.9 HEAD~1 >actu=
al &&
> >       +       test_when_finished "rm v2.9-0001-*" &&
> >       +       test_line_count =3D 1 actual &&
> >      -+       test_i18ngrep "^Range-diff ..* v2.8:$" v2.9-0001-* &&
> >      ++       test_i18ngrep "^Range-diff:$" v2.9-0001-* &&
> >       +       grep "> 1: .* new message" v2.9-0001-*
> >       +'
> >       +
> >      -+test_expect_success 'format-patch --range-diff reroll-count with=
 a integer previous-count' '
> >      -+       git format-patch --range-diff=3DHEAD~1 -v2 --previous-cou=
nt=3D1.8 HEAD~1 >actual &&
> >      ++test_expect_success 'format-patch --range-diff reroll-count with=
 a integer' '
> >      ++       git format-patch --range-diff=3DHEAD~1 -v2 HEAD~1 >actual=
 &&
> >       +       test_when_finished "rm v2-0001-*" &&
> >       +       test_line_count =3D 1 actual &&
> >       +       test_i18ngrep "^Range-diff ..* v1:$" v2-0001-* &&
> >      @@ t/t4014-format-patch.sh: test_expect_success 'interdiff: reroll=
-count' '
> >       +       test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
> >       +'
> >       +
> >      -+test_expect_success 'interdiff: reroll-count with a non-integer =
and previous-count ' '
> >      -+       git format-patch --cover-letter --interdiff=3Dboop~2 -v2.=
2 --previous-count=3D2.1 -1 boop &&
> >      -+       test_i18ngrep "^Interdiff ..* v2.1:$" v2.2-0000-cover-let=
ter.patch
> >      -+'
> >      -+
> >      -+test_expect_success 'interdiff: reroll-count with a integer and =
previous-count ' '
> >      -+       git format-patch --cover-letter --interdiff=3Dboop~2 -v2 =
--previous-count=3D1.5 -1 boop &&
> >      ++test_expect_success 'interdiff: reroll-count with a integer' '
> >      ++       git format-patch --cover-letter --interdiff=3Dboop~2 -v2 =
-1 boop &&
> >       +       test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.=
patch
> >       +'
> >      -+test_expect_success 'interdiff: previous-count without reroll-co=
unt ' '
> >      -+       test_must_fail git format-patch --cover-letter --interdif=
f=3Dboop~2 --previous-count=3D1.5 -1 boop
> >      -+'
> >      ++
> >        test_expect_success 'interdiff: solo-patch' '
> >               cat >expect <<-\EOF &&
> >                 +fleep
> >
> >
> >  Documentation/git-format-patch.txt |  1 +
> >  builtin/log.c                      | 46 +++++++++++++++++++-----------
> >  log-tree.c                         |  4 +--
> >  revision.h                         |  2 +-
> >  t/t3206-range-diff.sh              | 16 +++++++++++
> >  t/t4014-format-patch.sh            | 26 +++++++++++++++++
> >  6 files changed, 75 insertions(+), 20 deletions(-)
> >
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> > index 3e49bf221087..8af0d2923118 100644
> > --- a/Documentation/git-format-patch.txt
> > +++ b/Documentation/git-format-patch.txt
> > @@ -221,6 +221,7 @@ populated with placeholder text.
> >       `--subject-prefix` option) has ` v<n>` appended to it.  E.g.
> >       `--reroll-count=3D4` may produce `v4-0001-add-makefile.patch`
> >       file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> > +     now can support non-integrated version number like `-v1.1`.
>
> Perhaps something like:
>
>         +
>         `<n>` can be any string, such as `-v1.1`.  In the case where it
>         is a non-integral value, the "Range-diff" and "Interdiff"
>         headers will not include the previous version.
>
> >  --to=3D<email>::
> >       Add a `To:` header to the email headers. This is in addition
> > diff --git a/builtin/log.c b/builtin/log.c
> > index f67b67d80ed1..d135c30620b6 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -1662,13 +1662,15 @@ static void print_bases(struct base_tree_info *=
bases, FILE *file)
> >       oidclr(&bases->base_commit);
> >  }
> >
> > -static const char *diff_title(struct strbuf *sb, int reroll_count,
> > -                    const char *generic, const char *rerolled)
> > +static const char *diff_title(struct strbuf *sb,
> > +                     const char *reroll_count_string,
> > +                     const char*previous_count_string,
> > +                     const char *generic, const char *rerolled)
> >  {
> > -     if (reroll_count <=3D 0)
> > +     if (!reroll_count_string || !previous_count_string)
> >               strbuf_addstr(sb, generic);
> > -     else /* RFC may be v0, so allow -v1 to diff against v0 */
> > -             strbuf_addf(sb, rerolled, reroll_count - 1);
> > +     else if (previous_count_string)
> > +             strbuf_addf(sb, rerolled, previous_count_string);
> >       return sb->buf;
> >  }
>
> I don't think it's necessary to do this at all. We can just leave
> `reroll_count < 0` here.
Truly.
>
> > @@ -1718,6 +1720,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >       int use_patch_format =3D 0;
> >       int quiet =3D 0;
> >       int reroll_count =3D -1;
> > +     const char *reroll_count_string =3D NULL;
> > +     const char *previous_count_string =3D NULL;
> >       char *cover_from_description_arg =3D NULL;
> >       char *branch_name =3D NULL;
> >       char *base_commit =3D NULL;
> > @@ -1751,8 +1755,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >                           N_("use <sfx> instead of '.patch'")),
> >               OPT_INTEGER(0, "start-number", &start_number,
> >                           N_("start numbering patches at <n> instead of=
 1")),
> > -             OPT_INTEGER('v', "reroll-count", &reroll_count,
> > -                         N_("mark the series as Nth re-roll")),
> > +             OPT_STRING('v', "reroll-count", &reroll_count_string, N_(=
"reroll-count"),
> > +                         N_("mark the series as specified version re-r=
oll")),
>
> Others may disagree but I'm okay with leaving this as "Nth re-roll".
> It's just a synopsis. More information can be found in the docs.
Does Nth feel that reroll_count must be an integer? If you think it is
possible, I can restore it to the original state.
>
> >               OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max=
,
> >                           N_("max length of output filename")),
> >               OPT_CALLBACK_F(0, "rfc", &rev, NULL,
> > @@ -1862,11 +1866,17 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
> >       if (cover_from_description_arg)
> >               cover_from_description_mode =3D parse_cover_from_descript=
ion(cover_from_description_arg);
> >
> > -     if (0 < reroll_count) {
> > +     if (reroll_count_string) {
> >               struct strbuf sprefix =3D STRBUF_INIT;
> > -             strbuf_addf(&sprefix, "%s v%d",
> > -                         rev.subject_prefix, reroll_count);
> > -             rev.reroll_count =3D reroll_count;
> > +             char *endp;
> > +
> > +             reroll_count =3D strtoul(reroll_count_string, &endp, 10);
> > +             if (!*endp && 0 < reroll_count) {
>
> This 0 < reroll_count check is unnecessary; it was initialised to -1 and
> it hasn't changed since here.
>
> Also, we can take advantage of the strtol_i() function, which can
> perform bounds checking and error checking for us. This allows us to
> assign reroll_count only when a valid integer is found so we can
> eliminate previous_count_string().
>
> Something like:
>
>         strtol_i(reroll_count_string, 10, &reroll_count);
>
My code does make the program a lot more complicated,
and your advice is good.
> > +                     previous_count_string =3D xstrfmt("%d", reroll_co=
unt - 1);
> > +             }
> > +             strbuf_addf(&sprefix, "%s v%s",
> > +                         rev.subject_prefix, reroll_count_string);
> > +             rev.reroll_count =3D reroll_count_string;
> >               rev.subject_prefix =3D strbuf_detach(&sprefix, NULL);
> >       }
> >
> > @@ -2078,9 +2088,10 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
> >                       die(_("--interdiff requires --cover-letter or sin=
gle patch"));
> >               rev.idiff_oid1 =3D &idiff_prev.oid[idiff_prev.nr - 1];
> >               rev.idiff_oid2 =3D get_commit_tree_oid(list[0]);
> > -             rev.idiff_title =3D diff_title(&idiff_title, reroll_count=
,
> > -                                          _("Interdiff:"),
> > -                                          _("Interdiff against v%d:"))=
;
> > +             rev.idiff_title =3D diff_title(&idiff_title, reroll_count=
_string,
> > +                                     previous_count_string,
> > +                                     _("Interdiff:"),
> > +                                     _("Interdiff against v%s:"));
> >       }
> >
> >       if (creation_factor < 0)
> > @@ -2097,9 +2108,10 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
> >               rev.rdiff1 =3D rdiff1.buf;
> >               rev.rdiff2 =3D rdiff2.buf;
> >               rev.creation_factor =3D creation_factor;
> > -             rev.rdiff_title =3D diff_title(&rdiff_title, reroll_count=
,
> > -                                          _("Range-diff:"),
> > -                                          _("Range-diff against v%d:")=
);
> > +             rev.rdiff_title =3D diff_title(&rdiff_title, reroll_count=
_string,
> > +                                     previous_count_string,
> > +                                     _("Range-diff:"),
> > +                                     _("Range-diff against v%s:"));
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
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index 1b26c4c2ef91..dc419c087e07 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -521,6 +521,22 @@ test_expect_success 'format-patch --range-diff as =
commentary' '
> >       grep "> 1: .* new message" 0001-*
> >  '
> >
> > +test_expect_success 'format-patch --range-diff reroll-count with a non=
-integer' '
> > +     git format-patch --range-diff=3DHEAD~1 -v2.9 HEAD~1 >actual &&
> > +     test_when_finished "rm v2.9-0001-*" &&
> > +     test_line_count =3D 1 actual &&
> > +     test_i18ngrep "^Range-diff:$" v2.9-0001-* &&
> > +     grep "> 1: .* new message" v2.9-0001-*
> > +'
> > +
> > +test_expect_success 'format-patch --range-diff reroll-count with a int=
eger' '
> > +     git format-patch --range-diff=3DHEAD~1 -v2 HEAD~1 >actual &&
> > +     test_when_finished "rm v2-0001-*" &&
> > +     test_line_count =3D 1 actual &&
> > +     test_i18ngrep "^Range-diff ..* v1:$" v2-0001-* &&
> > +     grep "> 1: .* new message" v2-0001-*
> > +'
> > +
> >  test_expect_success 'range-diff overrides diff.noprefix internally' '
> >       git -c diff.noprefix=3Dtrue range-diff HEAD^...
> >  '
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index 66630c8413d5..59dff38065ab 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -378,6 +378,14 @@ test_expect_success 'reroll count' '
> >       ! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
> >  '
> >
> > +test_expect_success 'reroll count with a non-integer' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches --cover-letter --reroll-count 4.4 mai=
n..side >list &&
> > +     ! grep -v "^patches/v4.4-000[0-3]-" list &&
> > +     sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +     ! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
> > +'
> > +
> >  test_expect_success 'reroll count (-v)' '
> >       rm -fr patches &&
> >       git format-patch -o patches --cover-letter -v4 main..side >list &=
&
> > @@ -386,6 +394,14 @@ test_expect_success 'reroll count (-v)' '
> >       ! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
> >  '
> >
> > +test_expect_success 'reroll count (-v) with a non-integer' '
> > +     rm -fr patches &&
> > +     git format-patch -o patches --cover-letter -v4.4 main..side >list=
 &&
> > +     ! grep -v "^patches/v4.4-000[0-3]-" list &&
> > +     sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> > +     ! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
> > +'
> > +
> >  check_threading () {
> >       expect=3D"$1" &&
> >       shift &&
> > @@ -2255,6 +2271,16 @@ test_expect_success 'interdiff: reroll-count' '
> >       test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
> >  '
> >
> > +test_expect_success 'interdiff: reroll-count with a non-integer' '
> > +     git format-patch --cover-letter --interdiff=3Dboop~2 -v2.2 -1 boo=
p &&
> > +     test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
> > +'
> > +
> > +test_expect_success 'interdiff: reroll-count with a integer' '
> > +     git format-patch --cover-letter --interdiff=3Dboop~2 -v2 -1 boop =
&&
> > +     test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
> > +'
> > +
> >  test_expect_success 'interdiff: solo-patch' '
> >       cat >expect <<-\EOF &&
> >         +fleep
> >
> > base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
> > --
> > gitgitgadget
