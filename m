Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0021A718
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080044; cv=none; b=MIXfYo4/ToOR7Hp08xVsUqI1GacoMX4lcsLovBHcjkx9Ik6wKAyh8mohgqmaPlCTes7ovOuo2imiM4NwzKczJV5GFVz7OFkk5sYznodaEQaHx57DAiel9ZEN0ldlzQnGo05nuYGS69aEgWdjNmmF0JSVfZ7ufaopCP5QKU/8l0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080044; c=relaxed/simple;
	bh=Db3GnsF4qK3seRroPeY2obNtEWtCrK91x655sSWM2UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgbtVv+hJA6R9MUZ/TXClRWX2IuA/rUZjP3opFbDPH+b2UIru/JYPDrqcrsX7CTX9A0oNTrWeQ0KuzHIXxzBSOfY0NR9Txu2RypDvwPfloXPh5EH7jLgOfeoIL1ge2zkwOi8Krw3bhrJuPrXY9XcINucwfewQp0f7x/K25sxWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPswv/QX; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPswv/QX"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a6e960fa2dso7977745ab.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 07:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080042; x=1731684842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcr1o9FOJkcGscVv8LVShHADRmXpfLRu4LQGKROVIAU=;
        b=HPswv/QX8R41VNv8lvR8NTJ00UIJwuNsnVJV+bOiD8nCbPetbJ20LHENl9sZevxho2
         JUl72LZyHcn5dB6Na80VvkGaj3wPcDFjhQ34zZFjptAx0Gb+HLcxiS1UNxKs9OsmoxdB
         zg1WI13lTZyrEehgPrTf2kolP2o5G2n6FPsgNplU2BGpA8Ny2Vwd0/gJOH5sGuYVBTG5
         nyhMBTv0fcEZqTaiLp5QXnBakoY2D0EVC+tfILKgmPq8x8QDm57PCcfY5JjmMJTso7oX
         5ryiiajUOoCRmHWob+XnLJ8rU7deHe4UixJr0Ci5EeQPU/QwPjDge2Wp5IYb895fbjIv
         f7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080042; x=1731684842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcr1o9FOJkcGscVv8LVShHADRmXpfLRu4LQGKROVIAU=;
        b=LLaz5ZQ1NzkV1z1wAdZDVX4Mo+bj04dLbjvYobpF7GFtrksOG0qzVH2MbDiBsZHPty
         UHvBYwTHOsEDcnp4k56uENKPSMb0PsYgNDV8I8Tb7o+y2FvfBiDZvM4uihK6fw2+BsmP
         Vf++wJRqWGi+LqZrfyFV5Ddv62VxM7Z9QXCbhFoe4dd90+jQ1vwmzc5RUAHjUSsY5Dck
         fMZje39tnAxB+pzPYaT5gwCVWcoSoNGPnfQE6klRl6C8Sqihb4gGwppIiS8cdi4YfliZ
         PxaeNhEJj+0Lf6Ej1G6C6Q7IFrl6TK3oXHdqwt1A8ZeqaZun4oplrw4CD2KSNIc5V0dY
         RtBA==
X-Gm-Message-State: AOJu0YxBvvfYAo4HUIRER2p1pfWMf0KBaDZXaCcc02ONprY8MtY8EWgs
	Y59w0l6GkfzAhuhNPSCKcjYrok15SKvKoi06ub9Tf2RZbmtSaLLqNIb05zVak8dv4iItn1FrcOz
	/QGdB2jjoNGlObENnYxhG4aCysvo=
X-Google-Smtp-Source: AGHT+IG4gyRDEbSIR0DThoGEOTmiI+9Bj99H1hE6A4FGVXj+BZVnfX491Yiiyz90OiOPwwHI0GdIBuPZ4VnYHHyEbPk=
X-Received: by 2002:a05:6e02:1c2b:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a6f1a6438cmr42892255ab.19.1731080041635; Fri, 08 Nov 2024
 07:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
In-Reply-To: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 8 Nov 2024 07:33:49 -0800
Message-ID: <CABPp-BHNVEvYx4KwmiSQhPqidhPffb5hGBt=uT5NKqBPXC4j0w@mail.gmail.com>
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:20=E2=80=AFAM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `git log` command already offers support for including diffs for
> merges, via the `--diff-merges=3D<format>` option.
>
> Let's add corresponding support for `git range-diff`, too. This makes it
> more convenient to spot differences between iterations of non-linear
> contributions, where so-called "evil merges" are sometimes necessary and
> need to be reviewed, too.
>
> In my code reviews, I found the `--diff-merges=3Dfirst-parent` option
> particularly useful.

Curious.  Wouldn't --diff-merges=3Dremerge-diff be more useful if you
are particularly interested in so-called "evil merges" and whether
they remain "evil" (i.e. empty remerge-diff) or gain additional bits
of "evilness" (i.e. more changes shown in the remerge-diff)?

first-parent would seem more like a workaround in such a case.  Let me
explain; first, let me refer to the result that you'd get after
merging with no human changes (i.e. a non-evil merge) as a
hypothetical "auto-merge" commit.  Now, --diff-merges=3Dfirst-parent
could generally be broken down as the combination of diff from first
parent to auto-merge + diff from auto-merge to evil-merge (even if the
auto-merge wasn't actually recorded anywhere and is just a theoretical
construct).  Now, you aren't looking at a first-parent diff directly,
you are diffing two first-parent diffs.  In particular, you are
comparing:
    pre-rebase first-parent diff =3D diff from first parent of merge to
the auto-merge + diff from auto-merge to evil-merge
to
    post-rebase first-parent diff =3D diff from first parent of merge to
the auto-merge + diff from auto-merge to evil-merge

Assuming you didn't drop or insert or modify any commits as part of
the rebase, then the two "diff from first parent of merge to the
auto-merge" should match.  Since they match, taking the difference of
these two causes that part to cancel out, meaning you are left just
looking at the differences in the "evilness" of the actual merge.  But
if you did make other changes while rebasing, maybe dropping or
tweaking a commit, then suddenly you aren't just looking at
differences in the "evilness" of the actual merge anymore; it's mixed
with those other changes making it more challenging to review and easy
to miss the parts you are looking for.  If you want to look for
differences in whether the merge commit in question has changes other
than those that a simple "git merge" would make, remerge-diff seems
like a better choice.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Support diff merges option in range diff
>
>     The git range-diff command does the same with merge commits as git
>     rebase: It ignores them.
>
>     However, when comparing branch thickets it can be quite illuminating =
to
>     watch out for inadvertent changes in merge commits, in particular whe=
n
>     some "evil" merges have been replayed, i.e. merges that needed to
>     introduce changes outside of the merge conflicts (e.g. when one branc=
h
>     changed a function's signature and another branch introduced a caller=
 of
>     said function), in case the replayed merge is no longer "evil" and
>     therefore potentially incorrect.
>
>     Let's introduce support for the --diff-merges option that is passed
>     through to those git log commands.
>
>     I had a need for this earlier this year and got it working, leaving t=
he
>     GitGitGadget PR in a draft mode. Phil Blain found it and kindly
>     nerd-sniped me into readying it for submitting, so say thanks to Phil=
!
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1734%2F=
dscho%2Fsupport-diff-merges-option-in-range-diff-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1734/dscho=
/support-diff-merges-option-in-range-diff-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1734
>
>  Documentation/git-range-diff.txt | 10 +++++++++-
>  builtin/range-diff.c             | 11 +++++++++++
>  range-diff.c                     | 15 +++++++++++----
>  range-diff.h                     |  1 +
>  t/t3206-range-diff.sh            | 16 ++++++++++++++++
>  5 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-d=
iff.txt
> index fbdbe0befeb..a964e856c3c 100644
> --- a/Documentation/git-range-diff.txt
> +++ b/Documentation/git-range-diff.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git range-diff' [--color=3D[<when>]] [--no-color] [<diff-options>]
>         [--no-dual-color] [--creation-factor=3D<factor>]
> -       [--left-only | --right-only]
> +       [--left-only | --right-only] [--diff-merges=3D<format>]
>         ( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
>         [[--] <path>...]
>
> @@ -81,6 +81,14 @@ to revert to color all lines according to the outer di=
ff markers
>         Suppress commits that are missing from the second specified range
>         (or the "right range" when using the `<rev1>...<rev2>` format).
>
> +--diff-merges=3D<format>::
> +       Instead of ignoring merge commits, generate diffs for them using =
the
> +       corresponding `--diff-merges=3D<format>` option of linkgit:git-lo=
g[1],
> +       and include them in the comparison.
> ++
> +Note: Some of the formats supported by linkgit:git-log[1] make less sens=
e in
> +the context of the `range-diff` command than other formats, so choose wi=
sely!
> +

Indeed.  :-)

>  --[no-]notes[=3D<ref>]::
>         This flag is passed to the `git log` program
>         (see linkgit:git-log[1]) that generates the patches.
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 1b33ab66a7b..e41719e0f0d 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -21,6 +21,7 @@ int cmd_range_diff(int argc,
>  {
>         struct diff_options diffopt =3D { NULL };
>         struct strvec other_arg =3D STRVEC_INIT;
> +       struct strvec diff_merges_arg =3D STRVEC_INIT;
>         struct range_diff_options range_diff_opts =3D {
>                 .creation_factor =3D RANGE_DIFF_CREATION_FACTOR_DEFAULT,
>                 .diffopt =3D &diffopt,
> @@ -36,6 +37,9 @@ int cmd_range_diff(int argc,
>                 OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
>                                   N_("notes"), N_("passed to 'git log'"),
>                                   PARSE_OPT_OPTARG),
> +               OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
> +                                 N_("style"), N_("passed to 'git log'"),
> +                                 PARSE_OPT_OPTARG),
>                 OPT_BOOL(0, "left-only", &left_only,
>                          N_("only emit output related to the first range"=
)),
>                 OPT_BOOL(0, "right-only", &right_only,
> @@ -62,6 +66,12 @@ int cmd_range_diff(int argc,
>         if (!simple_color)
>                 diffopt.use_color =3D 1;
>
> +       /* If `--diff-merges` was specified, imply `--merges` */
> +       if (diff_merges_arg.nr) {
> +               range_diff_opts.include_merges =3D 1;
> +               strvec_pushv(&other_arg, diff_merges_arg.v);
> +       }
> +
>         for (i =3D 0; i < argc; i++)
>                 if (!strcmp(argv[i], "--")) {
>                         dash_dash =3D i;
> @@ -155,6 +165,7 @@ int cmd_range_diff(int argc,
>         res =3D show_range_diff(range1.buf, range2.buf, &range_diff_opts)=
;
>
>         strvec_clear(&other_arg);
> +       strvec_clear(&diff_merges_arg);
>         strbuf_release(&range1);
>         strbuf_release(&range2);
>
> diff --git a/range-diff.c b/range-diff.c
> index bbb0952264b..9e59733059b 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -38,7 +38,8 @@ struct patch_util {
>   * as struct object_id (will need to be free()d).
>   */
>  static int read_patches(const char *range, struct string_list *list,
> -                       const struct strvec *other_arg)
> +                       const struct strvec *other_arg,
> +                       unsigned int include_merges)
>  {
>         struct child_process cp =3D CHILD_PROCESS_INIT;
>         struct strbuf buf =3D STRBUF_INIT, contents =3D STRBUF_INIT;
> @@ -49,7 +50,7 @@ static int read_patches(const char *range, struct strin=
g_list *list,
>         size_t size;
>         int ret =3D -1;
>
> -       strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> +       strvec_pushl(&cp.args, "log", "--no-color", "-p",
>                      "--reverse", "--date-order", "--decorate=3Dno",
>                      "--no-prefix", "--submodule=3Dshort",
>                      /*
> @@ -64,6 +65,8 @@ static int read_patches(const char *range, struct strin=
g_list *list,
>                      "--pretty=3Dmedium",
>                      "--show-notes-by-default",
>                      NULL);


>
> -- Hannes
>
>
> +       if (!include_merges)
> +               strvec_push(&cp.args, "--no-merges");
>         strvec_push(&cp.args, range);
>         if (other_arg)
>                 strvec_pushv(&cp.args, other_arg->v);
> @@ -96,11 +99,14 @@ static int read_patches(const char *range, struct str=
ing_list *list,
>                 }
>
>                 if (skip_prefix(line, "commit ", &p)) {
> +                       char *q;
>                         if (util) {
>                                 string_list_append(list, buf.buf)->util =
=3D util;
>                                 strbuf_reset(&buf);
>                         }
>                         CALLOC_ARRAY(util, 1);
> +                       if (include_merges && (q =3D strstr(p, " (from ")=
))
> +                               *q =3D '\0';
>                         if (repo_get_oid(the_repository, p, &util->oid)) =
{
>                                 error(_("could not parse commit '%s'"), p=
);
>                                 FREE_AND_NULL(util);
> @@ -571,13 +577,14 @@ int show_range_diff(const char *range1, const char =
*range2,
>
>         struct string_list branch1 =3D STRING_LIST_INIT_DUP;
>         struct string_list branch2 =3D STRING_LIST_INIT_DUP;
> +       unsigned int include_merges =3D range_diff_opts->include_merges;
>
>         if (range_diff_opts->left_only && range_diff_opts->right_only)
>                 res =3D error(_("options '%s' and '%s' cannot be used tog=
ether"), "--left-only", "--right-only");
>
> -       if (!res && read_patches(range1, &branch1, range_diff_opts->other=
_arg))
> +       if (!res && read_patches(range1, &branch1, range_diff_opts->other=
_arg, include_merges))
>                 res =3D error(_("could not parse log for '%s'"), range1);
> -       if (!res && read_patches(range2, &branch2, range_diff_opts->other=
_arg))
> +       if (!res && read_patches(range2, &branch2, range_diff_opts->other=
_arg, include_merges))
>                 res =3D error(_("could not parse log for '%s'"), range2);
>
>         if (!res) {
> diff --git a/range-diff.h b/range-diff.h
> index 2f69f6a434d..cd85000b5a0 100644
> --- a/range-diff.h
> +++ b/range-diff.h
> @@ -16,6 +16,7 @@ struct range_diff_options {
>         int creation_factor;
>         unsigned dual_color:1;
>         unsigned left_only:1, right_only:1;
> +       unsigned include_merges:1;
>         const struct diff_options *diffopt; /* may be NULL */
>         const struct strvec *other_arg; /* may be NULL */
>  };
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 86010931ab6..c18a3fdab83 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -909,4 +909,20 @@ test_expect_success 'submodule changes are shown irr=
espective of diff.submodule'
>         test_cmp expect actual
>  '
>
> +test_expect_success '--diff-merges' '
> +       renamed_oid=3D$(git rev-parse --short renamed-file) &&
> +       tree=3D$(git merge-tree unmodified renamed-file) &&
> +       clean=3D$(git commit-tree -m merge -p unmodified -p renamed-file =
$tree) &&
> +       clean_oid=3D$(git rev-parse --short $clean) &&
> +       conflict=3D$(git commit-tree -m merge -p unmodified -p renamed-fi=
le^ $tree) &&
> +       conflict_oid=3D$(git rev-parse --short $conflict) &&
> +
> +       git range-diff --diff-merges=3D1 $clean...$conflict >actual &&
> +       cat >expect <<-EOF &&
> +       1:  $renamed_oid < -:  ------- s/12/B/
> +       2:  $clean_oid =3D 1:  $conflict_oid merge
> +       EOF
> +       test_cmp expect actual
> +'
> +
>  test_done
>
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> --
> gitgitgadget

Didn't spot any problems with the patch itself.
