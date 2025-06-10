Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89728369D
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590205; cv=none; b=LGul3iF82aFk1bBW9q3NWgu7HYel9DUfx6TyIZ5nYcGfUxmes8HKEnYj2TswpYeeIgyq7ERIvHUnwJkqXEDfq+hXcQYGmvaOuvHKDWW7Mhi330QtkgkO4NbWJLA/o4fO2mI7pdA5tbFoj0NvbJajXHXFzW5D4Te+hTyyG4GcDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590205; c=relaxed/simple;
	bh=1aRRx4TYtgF1CXo6lOuJx9UStAYTZ/xfbK+MZhEE9rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZMw6fgl3dLrl0r7jAT/5PH9sMgzmXIGqdLC4LmU7ckInHvyeShwoHxuY+OwehOM7QBVYkDaivbSLj+tAlRMOz81mQjIyFqMmOhE22HZlLYKNE+P1/O6PvfoFPlK4QGgLb8iAd0J1EbRjkrWjt/+ioo5ynGVkzoyQPpMf3vYzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fldoh+c5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fldoh+c5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso10398998a12.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749590200; x=1750195000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjtQD0wFfUsGhxTO4OGMvofTFinRy79c/BuQa4XWL9Q=;
        b=Fldoh+c5sGhXko3JQyD4fpaUhL2qqrUsm32Ye9tHbCOAa8guVEv1DVoBakNLp/lzJB
         4hXSkAk4TN3fe0A8LjmdJnU/KSM/zyZ4e8gzA0w/+MzrIG8X1FdOFuOveV2xv/0/bBtN
         j61Zg62MfX3K1olCEKXpC+Km8HTCdDB/pH0rew9+dOkor8zhBLI8DatbsSR+0rpntI/Z
         wSqjv1NOYI+DbeBldL6uHSDDpfHfKPCHg0wSCWS42ORmNfdJmNLJSAQ3yEZ+K12ME2rD
         Mnk+MnuJROaAQY0/ZiAZxckRhO6CTHcGTfvbmQ9nw6EvDn8tLI4vu/4Nqv86OLe5va7q
         sRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749590200; x=1750195000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjtQD0wFfUsGhxTO4OGMvofTFinRy79c/BuQa4XWL9Q=;
        b=UuOFuLmYBK4g/7IOh+GkcQjh8D6vXRQ/MiLp7msHHXAa2G/jDaNrC6ki6uYZ0k809T
         UIR09ETPhg5IloUszMjZ0DsMFqrV5P2k0vmgPII1/oFL80hCN3tDKVtQfUxR+oWrqgzN
         rYIwx8yWVrluSCcd82UK0khzU0FmLHMNBffw2Oja5UYRSN8blC4wsAq3Rna9GYM/xHnf
         hmG/N0vzySSYCHuDogJHJ3SjqlZtKSjJv76oEkDwl20zCz6X8iPEw1WIediwmJVp2+ll
         YQgYAzk4WfY+vBssLxfaXGNxT9EO602TfAwfLFU7Fr1PCSFjCgatIcK0QnydVdy7HAZW
         UaVg==
X-Gm-Message-State: AOJu0Yzp/yXUlgRsWkoIS9AjP5Rg3ZkyGI3wpue7IjkUacEsgonswvW+
	UtGvM+g0d6X0fl0GT7vRUS2vIODUrjEg/n4sfUhpjZb+EhNNqfon1AfDyxu7kUz22xrwO20Sk0R
	FKpC4Ki33Tdvf/1DcHEh6Wx+D6cZ0G0LGJQ==
X-Gm-Gg: ASbGncvMLD8Rv9FnvDN9ixbq8hJ3Xbb4kOiHEv10DIOWaF1YgqLTmYUq/2n4zrqzBS2
	KgRbGscvwg6OWtv5Knj4bL4OMGB59BeSZ4ykcbzgCp+7ZWVVMhzltqjiDrrfD3DKMZ6HWKPEiLx
	1rXMbavY2fdH1sJPuw6VBqO8HvPmkNAfhVKVcgEU3mwFhUjodGOdq1HVlpgFy8fzoMxp5/F+xFZ
	j42dg==
X-Google-Smtp-Source: AGHT+IHzf7XeRnCbSdSUGNDvqCrYjMrkTUZAx2nAzs4LcLpAWqTi8WwtuL5LvXaiCRT+BTlD48EiJ29DryQdNKg0mgE=
X-Received: by 2002:a17:907:2d8c:b0:add:fc52:898f with SMTP id
 a640c23a62f3a-ade8976341emr79111266b.42.1749590200340; Tue, 10 Jun 2025
 14:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xh6xlpm.fsf@gitster.g>
In-Reply-To: <xmqq5xh6xlpm.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 10 Jun 2025 17:16:29 -0400
X-Gm-Features: AX0GCFu71oqvEGW3S_hr83DLUZEUc-7AvmryLmT8wpy56h8KNuqdIeKC_ZgWeXU
Message-ID: <CALnO6CCnjP2XnCw1CwyXztkHHMv-U4zrvf8_m2X4-isvPL3ygg@mail.gmail.com>
Subject: Re: [PATCH] merge/pull: --compact-summary
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 12:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> By default, "git merge" and "git pull" shows "git diff --stat @{1}"
> to show the extent of the changes.  While it gives a good overview,
> one thing that is missing in this output is which paths are created
> and/or deleted.
>
> Introduce "--compact-summary" option to these two commands that
> tells it to instead show "git diff --compact-summary @{1}", which
> gives the same diffstat but notes the created or deleted paths.

Does this suggest that we either want a "diff options" option (or
config), which would be more general? Or perhaps that the intended
workflow if you want a compact summary is instead

    git [merge|pull] =E2=80=A6
    git diff --compact-summary HEAD^

?

(The code seems reasonable, just wondering about the motivation/workflow.)

>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-merge.adoc     |  2 +-
>  Documentation/merge-options.adoc |  3 +++
>  builtin/merge.c                  | 39 ++++++++++++++++++++++++++++----
>  builtin/pull.c                   |  3 +++
>  t/t7600-merge.sh                 | 28 ++++++++++++++++++++++-
>  5 files changed, 69 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
> index 12aa859d16..d53923c3b7 100644
> --- a/Documentation/git-merge.adoc
> +++ b/Documentation/git-merge.adoc
> @@ -9,7 +9,7 @@ git-merge - Join two or more development histories togeth=
er
>  SYNOPSIS
>  --------
>  [synopsis]
> -git merge [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
> +git merge [-n] [--stat] [--compact-summary] [--no-commit] [--squash] [--=
[no-]edit]
>         [--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]=
]
>         [--[no-]allow-unrelated-histories]
>         [--[no-]rerere-autoupdate] [-m <msg>] [-F <file>]
> diff --git a/Documentation/merge-options.adoc b/Documentation/merge-optio=
ns.adoc
> index 078f4f6157..95ef491be1 100644
> --- a/Documentation/merge-options.adoc
> +++ b/Documentation/merge-options.adoc
> @@ -113,6 +113,9 @@ include::signoff-option.adoc[]
>  With `-n` or `--no-stat` do not show a diffstat at the end of the
>  merge.
>
> +`--compact-summary`::
> +       Show a compact-summary at the end of the merge.
> +
>  `--squash`::
>  `--no-squash`::
>         Produce the working tree and index state as if a real merge
> diff --git a/builtin/merge.c b/builtin/merge.c
> index ce90e52fe4..736739d3a9 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -69,7 +69,10 @@ static const char * const builtin_merge_usage[] =3D {
>         NULL
>  };
>
> -static int show_diffstat =3D 1, shortlog_len =3D -1, squash;
> +#define MERGE_SHOW_DIFFSTAT 1
> +#define MERGE_SHOW_COMPACTSUMMARY 2
> +
> +static int show_diffstat =3D MERGE_SHOW_DIFFSTAT, shortlog_len =3D -1, s=
quash;
>  static int option_commit =3D -1;
>  static int option_edit =3D -1;
>  static int allow_trivial =3D 1, have_message, verify_signatures;
> @@ -243,12 +246,28 @@ static int option_parse_strategy(const struct optio=
n *opt UNUSED,
>         return 0;
>  }
>
> +static int option_parse_compact_summary(const struct option *opt,
> +                                       const char *name UNUSED, int unse=
t)
> +{
> +       int *setting =3D opt->value;
> +
> +       if (unset)
> +               *setting =3D 0;
> +       else
> +               *setting =3D MERGE_SHOW_COMPACTSUMMARY;
> +       return 0;
> +}
> +
>  static struct option builtin_merge_options[] =3D {
>         OPT_SET_INT('n', NULL, &show_diffstat,
>                 N_("do not show a diffstat at the end of the merge"), 0),
>         OPT_BOOL(0, "stat", &show_diffstat,
>                 N_("show a diffstat at the end of the merge")),
>         OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)"))=
,
> +       OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, N_("compact-=
summary"),
> +                      N_("show a compactstat at the end of the merge"),
> +                      PARSE_OPT_NOARG,
> +                      option_parse_compact_summary),
>         {
>                 .type =3D OPTION_INTEGER,
>                 .long_name =3D "log",
> @@ -494,8 +513,19 @@ static void finish(struct commit *head_commit,
>                 struct diff_options opts;
>                 repo_diff_setup(the_repository, &opts);
>                 init_diffstat_widths(&opts);
> -               opts.output_format |=3D
> -                       DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> +
> +               switch (show_diffstat) {
> +               case MERGE_SHOW_DIFFSTAT: /* 1 */
> +                       opts.output_format |=3D
> +                               DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTA=
T;
> +                       break;
> +               case MERGE_SHOW_COMPACTSUMMARY: /* 2 */
> +                       opts.output_format |=3D DIFF_FORMAT_DIFFSTAT;
> +                       opts.flags.stat_with_summary =3D 1;
> +                       break;
> +               default:
> +                       break;
> +               }
>                 opts.detect_rename =3D DIFF_DETECT_RENAME;
>                 diff_setup_done(&opts);
>                 diff_tree_oid(head, new_head, "", &opts);
> @@ -643,7 +673,8 @@ static int git_merge_config(const char *k, const char=
 *v,
>         }
>
>         if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
> -               show_diffstat =3D git_config_bool(k, v);
> +               show_diffstat =3D git_config_bool(k, v)
> +                       ? MERGE_SHOW_DIFFSTAT : 0;
>         } else if (!strcmp(k, "merge.verifysignatures")) {
>                 verify_signatures =3D git_config_bool(k, v);
>         } else if (!strcmp(k, "pull.twohead")) {
> diff --git a/builtin/pull.c b/builtin/pull.c
> index a1ebc6ad33..6e72a2e9a4 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -143,6 +143,9 @@ static struct option pull_options[] =3D {
>         OPT_PASSTHRU(0, "summary", &opt_diffstat, NULL,
>                 N_("(synonym to --stat)"),
>                 PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
> +       OPT_PASSTHRU(0, "compact-summary", &opt_diffstat, NULL,
> +               N_("show a compact-summary at the end of the merge"),
> +               PARSE_OPT_NOARG),
>         OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
>                 N_("add (at most <n>) entries from shortlog to merge comm=
it message"),
>                 PARSE_OPT_OPTARG),
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 2a8df29219..ce666efbcc 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -185,8 +185,19 @@ test_expect_success 'reject non-strategy with a git-=
merge-foo name' '
>  test_expect_success 'merge c0 with c1' '
>         echo "OBJID HEAD@{0}: merge c1: Fast-forward" >reflog.expected &&
>
> +       cat >expect <<-EOF &&
> +       Updating FROM..TO
> +       Fast-forward
> +        file  | 2 +-
> +        other | 9 +++++++++
> +        2 files changed, 10 insertions(+), 1 deletion(-)
> +        create mode 100644 other
> +       EOF
> +
>         git reset --hard c0 &&
> -       git merge c1 &&
> +       git merge c1 >out &&
> +       sed -e "1s/^Updating [0-9a-f.]*/Updating FROM..TO/" out >actual &=
&
> +       test_cmp expect actual &&
>         verify_merge file result.1 &&
>         verify_head "$c1" &&
>
> @@ -205,6 +216,21 @@ test_expect_success 'merge c0 with c1 with --ff-only=
' '
>         verify_head "$c1"
>  '
>
> +test_expect_success 'the same merge with compact summary' '
> +       cat >expect <<-EOF &&
> +       Updating FROM..TO
> +       Fast-forward
> +        file        | 2 +-
> +        other (new) | 9 +++++++++
> +        2 files changed, 10 insertions(+), 1 deletion(-)
> +       EOF
> +
> +       git reset --hard c0 &&
> +       git merge --compact-summary c1 >out &&
> +       sed -e "1s/^Updating [0-9a-f.]*/Updating FROM..TO/" out >actual &=
&
> +       test_cmp expect actual
> +'
> +
>  test_debug 'git log --graph --decorate --oneline --all'
>
>  test_expect_success 'merge from unborn branch' '
> --
> 2.50.0-rc1-276-gda78c2366e
>
>


--=20
D. Ben Knoble
