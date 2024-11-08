Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2281DFD1
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085496; cv=none; b=txDra0tbMLkdjbZyucM3CZq/CMUbOUzWWP5QoIo2cTdC9jxUfjLcwWn5UfILrvDhk+NhjXhMEa2Bsfr2ZAbm/TJQ6xpjrdnAMLetiuxDucVwxUCj0jD10zwN2n0WsrRdFy56+oAGYTRzndHkjuytltXgJz88GxvpzIQSyVKX34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085496; c=relaxed/simple;
	bh=g/aIub9+xI5SQCYL5i9Lq4Ttzoq1hIsJtqu5DILEPuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyVtt6Qqil6TunJCkTUJsKa2FmoomBTwUeqzmHRHtY6RTJ4n5uG78z6ioMWKQgCNrrWugoZJvUEENcQoPPR8n3gSBBeELOaaENlJoN2aGupXOUfXWX8fEuayOrIh1+fbzWy3fN4/WmQ9zQ2SO9r6d9vdz+w3cQDZgB7NQXb7lfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EELLtO95; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EELLtO95"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-290c69be014so1241147fac.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731085493; x=1731690293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcqG+I7D0rUIpirBh5vi2Hz3tjAcbKe7NaR96sDwtws=;
        b=EELLtO95qSBfd56QsZerSrnY8/GzV5HTtwzkP+C4STxx34o1cD6svLkP+YopPkMdrx
         qoLk6dDHxizGMe3xbxiSz5FhjqjnqPSv19DKQTIAQCA2nQ9QHjTEQ9OH2/TVEypDcgrg
         JGiqm/HsoALBwF/rZGX7/+dCkTpNa58upSQhmNm/fYVWcE24dhpNkYCWao6zBUhSIkLn
         Dh12tOBzOpIf1e3gXCdk8C6fi0ShsGLg9wilvotqSDzI1uEHhsxDM/9qJaTEX2/6+R9m
         oA52LEmRJKwCtIVAgthsIrjMdskBi/W31XYBSS1CQKrVB0BMlSA1qVfLldyr8bZNCAJa
         5QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085493; x=1731690293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcqG+I7D0rUIpirBh5vi2Hz3tjAcbKe7NaR96sDwtws=;
        b=i1LsjGa8x/U0IhcHSYStKGBZTmz00tJ3LUS0DVM1+TeGPltQjKSgbwHtlqd0G1LYj9
         mWLEFzPFX5P5WaWM2rQnvi2kZydbU9yADxDS6s2nS2va3+3waqJ7C9ZryhL4LFTtvrcu
         zPqpMTrAC3xaxOpz8AeT09MAwEntD+cfJ9ZYtz94pFvq7uNEnr1lEzwocVjyjOK4ry2J
         Y+9uExO45M+b/IOy8Nq71+S+yW41Pmo9Oo4P+dAjmBf7S18UmnRmcu1lQpkumXGcLeKc
         p1h1l2TM8geiGP1D+AFfRR9RgnTog6cP+3/qt2kCvvP14bfFVZ48B9jST8suCzxLS2ae
         YOhQ==
X-Gm-Message-State: AOJu0Yy7oLlug4pP/D6aD2JYVbKuhSXuWRSCmdBIw6wIeNjdjR4WB08y
	gKh6QvTspAouuSV6fbMahBmnGL5g+FTJ0asdLenHYLa7bVPAPAGOIQIxesTRs8Ye8ioq/aM29JI
	aEyNWeNxPhHoN32SBMPYJ6Nkld9g=
X-Google-Smtp-Source: AGHT+IGYz5bA81ntaRCo4PF6wTOFFYKOryL7lS8G2eucjNJVvyK76PI0jFvqYCacjQYCNPereoVQWTfp3C1CirfHKQc=
X-Received: by 2002:a05:6870:1f18:b0:278:8fe:6293 with SMTP id
 586e51a60fabf-2956000760bmr3639819fac.1.1731085493274; Fri, 08 Nov 2024
 09:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com> <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
In-Reply-To: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 8 Nov 2024 09:04:42 -0800
Message-ID: <CABPp-BGeSwDHNeDdEwf+mo5q33GO3f0UiFpVOpjiLF3msEvrfg@mail.gmail.com>
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs in
 the analysis
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 5:43=E2=80=AFAM Johannes Schindelin via GitGitGadget
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
>
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
>     Changes since v1:
>
>      * Changed the documentation to recommend first-parent mode instead o=
f
>        vaguely talking about various modes' merits.
>      * Disallowed the no-arg --diff-merges option (because --diff-merges
>        requires an argument).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1734%2F=
dscho%2Fsupport-diff-merges-option-in-range-diff-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1734/dscho=
/support-diff-merges-option-in-range-diff-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1734
>
> Range-diff vs v1:
>
>  1:  11361e07af8 ! 1:  d01a395900b range-diff: optionally include merge c=
ommits' diffs in the analysis
>      @@ Documentation/git-range-diff.txt: to revert to color all lines ac=
cording to the
>       + corresponding `--diff-merges=3D<format>` option of linkgit:git-lo=
g[1],
>       + and include them in the comparison.
>       ++
>      -+Note: Some of the formats supported by linkgit:git-log[1] make les=
s sense in
>      -+the context of the `range-diff` command than other formats, so cho=
ose wisely!
>      ++Note: In the common case, the `first-parent` mode will be the most=
 natural one
>      ++to use, as it is consistent with the idea that a merge is kind of =
a "meta
>      ++patch", comprising all the merged commits' patches into a single o=
ne.
>       +
>        --[no-]notes[=3D<ref>]::
>         This flag is passed to the `git log` program
>      @@ builtin/range-diff.c: int cmd_range_diff(int argc,
>                                   N_("notes"), N_("passed to 'git log'"),
>                                   PARSE_OPT_OPTARG),
>       +         OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
>      -+                           N_("style"), N_("passed to 'git log'"),
>      -+                           PARSE_OPT_OPTARG),
>      ++                           N_("style"), N_("passed to 'git log'"),=
 0),
>                 OPT_BOOL(0, "left-only", &left_only,
>                          N_("only emit output related to the first range"=
)),
>                 OPT_BOOL(0, "right-only", &right_only,
>
>
>  Documentation/git-range-diff.txt | 11 ++++++++++-
>  builtin/range-diff.c             | 10 ++++++++++
>  range-diff.c                     | 15 +++++++++++----
>  range-diff.h                     |  1 +
>  t/t3206-range-diff.sh            | 16 ++++++++++++++++
>  5 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-d=
iff.txt
> index fbdbe0befeb..17a85957877 100644
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
> @@ -81,6 +81,15 @@ to revert to color all lines according to the outer di=
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
> +Note: In the common case, the `first-parent` mode will be the most natur=
al one
> +to use,

I think we need more wording around "common case"; I believe this
"common case" is when you are diffing against a merely transplanted
series of commits (a series created by rebasing without inserting,
removing, or minimally modifying those commits in the process) that
`first-parent` makes sense.  And it only makes sense in that case.

I think `remerge-diff` generally makes sense here, both in the cases
when `first-parent` makes sense and when `first-parent` does not.  It
could be improved by suppressing the inclusion of short commit ids
(and maybe also commit messages) in the labels of conflict markers.  I
suspect that issue might make `remerge-diff` less useful than
`first-parent` in simple common cases currently, but I think it's the
right thing to build upon for what you are trying to view.

If `remerge-diff` didn't exist, I think I'd always use
`dense-combined` over `first-parent` because of this
merely-transplanted limitation.  I suspect dense-combined would
probably be kind of ugly and hard to parse when there is an actual
evil merge, but it'd at least limit what it shows to the evil merge
content.

> as it is consistent with the idea that a merge is kind of a "meta
> +patch", comprising all the merged commits' patches into a single one.

Doesn't this wording of yours naturally lead to the idea that
`first-parent` is a bad choice if patches leading to the merge have
been inserted, removed, or more than minimally modified?  It points
out that first-parent is a diff over the whole range, and so
range-diff shows you a diff of the diffs over the whole range.  If you
want to look at the "evilness" of merge commits, i.e. the
user-generated portion of the diffs included in by merge commits, you
need either remerge-diff or dense-combined.

> +
>  --[no-]notes[=3D<ref>]::
>         This flag is passed to the `git log` program
>         (see linkgit:git-log[1]) that generates the patches.
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 1b33ab66a7b..901de5d133d 100644
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
> @@ -36,6 +37,8 @@ int cmd_range_diff(int argc,
>                 OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
>                                   N_("notes"), N_("passed to 'git log'"),
>                                   PARSE_OPT_OPTARG),
> +               OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
> +                                 N_("style"), N_("passed to 'git log'"),=
 0),
>                 OPT_BOOL(0, "left-only", &left_only,
>                          N_("only emit output related to the first range"=
)),
>                 OPT_BOOL(0, "right-only", &right_only,
> @@ -62,6 +65,12 @@ int cmd_range_diff(int argc,
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
> @@ -155,6 +164,7 @@ int cmd_range_diff(int argc,
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
