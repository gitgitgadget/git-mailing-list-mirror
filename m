Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEFD223DE7
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988511; cv=none; b=bN6yj3hTA3cyH+3HM/oqXg0T8+RG4XG9W+tLkIkl1HG3kuOrvta1S6NNIcLNMfntIVY9mA4afp/xLIou5eZbu1e1j3dP7slZ4Hy9Vq4dE57Ko+MaCyEFy6TuYd8eN9TDv8VlDkLpKjDcfjqQo69C2KUinqzvHSMesSovCQOokO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988511; c=relaxed/simple;
	bh=HDv8VKKVB64YkWcADim5Sl9zqhqD4iII99uHLpx2m/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG9wuWmXwtuP1zsSze20GpIkuRnm/sQxSvwmlguxprAo/KmsRESoXdFiIJ/pq3nESkkoQuTeC9KLN44uGVpKl+WXfAkm780dG/CSMYqhVcn56/Dws69o+/qfVyWxdl/u6DhNcd3Hlk1B/DpX1CqylR8D9dbNg3dJ1iHP8wrLYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfTdCAIO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfTdCAIO"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b52bf417cso2945247b3a.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751988509; x=1752593309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW380gFzAo3ANba8JFFchoNer8kE/pvmZglvFrLnjqc=;
        b=mfTdCAIO3b1fAwasiYu/e2T17GY/buUK1d4YtwBtOl7ijz1cIafTY8uL0XnO08WkFY
         u7mM5xgH5JYK+160cbCobLK6WvsjM8TD+NSd0/WN8y57m78Y8AAR0iM1zTliWVtpoHG/
         GnqnFCNvVGmgcF7vQacE5yLQ7i3gsAHFBvLUx2iUgNwsndxKkS1qcf0hvE/bLC6aY0JI
         7v/VF7OWwubF6oMwUp8YpYH0WOM98831/g2lCWrH1bUvtNEjY2PjiFTHDxqjvuTPy2E6
         8skpO2Pu8l8EhymSMw8GvoOHmms3citz+mlPV4Ng/b6kZzEi6fjy/0ONLxW6e9S09Un/
         gIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988509; x=1752593309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW380gFzAo3ANba8JFFchoNer8kE/pvmZglvFrLnjqc=;
        b=M/s3QjKE5rfz223JzUAgLseSm1Hz7yVAT9w76NYVkPNeKn+QH2Oy0hN23d1Zz/Gslk
         yZF3zRq7stvLjCgwBUdyRVYg7eXJ9zD/qNP5S7MebGd3nx8u+VZzNRizBENObay7iuGC
         G+ARDEZmjkp7srmTJz/sHSOE0vALHzU/UBcX2Z/xCZ3dBqrxGK5bO7P0VidLqzgLUqLw
         6BbwQCJLV4jrMHey0ICFk83sD+lBKPXPERmQ85KuAl9g6kg+U+T9f78pt/lUXkHDUMo2
         z9WITHFE7O5zlUtmWjXBfh2k9R/S9yPX+egoHA3z0TZsNce9RS7ht1JVVOeluIFVbQtq
         hbHg==
X-Gm-Message-State: AOJu0YzfMA4sj/0VW4HJQwQe1bBWTWFiPde7y4hZHJljNMsydZA2N2TK
	KLK9kKERN7yJD/tSY9pWf6s64BwZmsgHtRTYx0vDbTsoej29QjttLjasVeptubmHuOHk28jBzEw
	41dWNczh66wx43xHQLQcQhol4KvVlPXs=
X-Gm-Gg: ASbGnctXc8h4ynNQvVhyn+AmVNWqJc8+l6NL0xxZ5qqLF3YYVjB7eVI292phwMj8ADN
	A2ofmvD7PdgangAJ+dKGmpvurpYKkkM+r3R/DORj/M/4O1yU08c36zF3ixzXNA8DbH4FP/u76Q3
	KIrkGpa60SRTKMx6y+plPOFlU8bSjJTgCJJ9QWR5E6bItzgkpTJlzfeHBRJdRZhHAF+pzBDRQDX
	+s=
X-Google-Smtp-Source: AGHT+IFoUMmydrWJu59O1ItNQZUGpi8kY79f3W8l50DDLjhArEBmoSVxrbvUQ2Tqi4UWITDo4qkybEyr12SLgfN/hYk=
X-Received: by 2002:a05:6a00:895:b0:749:b9c:1ea7 with SMTP id
 d2e1a72fcca58-74ce65c4f2cmr22153251b3a.17.1751988508661; Tue, 08 Jul 2025
 08:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk> <3747a1f77f03bf2572e195673d021dcf827ae59b.1751983009.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <3747a1f77f03bf2572e195673d021dcf827ae59b.1751983009.git.phillip.wood@dunelm.org.uk>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 8 Jul 2025 20:58:17 +0530
X-Gm-Features: Ac12FXzZ1sCSGlyL6vjgnFEOIGsH0i0cB-tUz5iwIxud6jk3YmgmWAzo__GNPwk
Message-ID: <CAE7as+YyKHzHjpCn2fFym0e5JquhroeDPHo_FHtdNCCb1HVSgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] breaking-changes: deprecate support for core.commentString=auto
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Tue, Jul 8, 2025 at 7:27=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When "core.commentString" is set to "auto" then "git commit"
> will automatically select the comment character ensuring that it
> does not the first character on any of the lines in the commit
> message. This was introduced by commit 84c9dc2c5a2 (commit: allow
> core.commentChar=3Dauto for character auto selection, 2014-05-17) The
> motivation seems to be to avoid commenting out lines from the existing
> message when amending a commit that was created with a message from
> a file.
>

s/that it does not the first character/that it does not appear on the
first character?

> Unfortunately this feature does not work with:
>
>  * commit message templates that contain comments.
>
>  * prepare-commit-msg hooks that introduce comments.
>
>  * "git commit --cleanup=3Dstrip --edit -F <file>" which means that it
>    is incompatible with
>
>    - the "fixup" and "squash" commands of "git rebase -i" as the
>      comments added by those commands are then treated as part of the
>      commit message.
>
>    - the conflict comments added to the commit message by "git
>      cherry-pick", "git rebase" etc. as these comments are then treated
>      as part of the commit message.
>
> It is also ignored by "git notes" when amending a note.
>
> The issues with comments coming from a template, hook or file are a
> consequence of the design of this feature and are therefore hard to
> fix.
>
> As the costs of this feature outweigh the benefits deprecate it and
> remove it in Git 3.0. If someone comes up with some patches that fix all
> the issues in a maintainable way then I'd be happy to see this change
> reverted.
>
Nit: s/benefits deprecate/benefits, deprecate.

> The next commit will add some advice for users on how they can update
> their config settings.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/BreakingChanges.adoc |  4 ++++
>  Documentation/config/core.adoc     | 20 ++++++++++++++++++--
>  builtin/commit.c                   |  4 ++++
>  config.c                           |  4 ++++
>  environment.c                      |  2 ++
>  environment.h                      |  2 ++
>  t/t3404-rebase-interactive.sh      |  2 +-
>  t/t7502-commit-porcelain.sh        |  4 ++--
>  8 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingC=
hanges.adoc
> index 61bdd586b9e..f38ba1de6e4 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -183,6 +183,10 @@ These features will be removed.
>    timeframe, in preference to its synonym "--annotate-stdin".  Git 3.0
>    removes the support for "--stdin" altogether.
>
> +* Support for `core.commentString=3Dauto` has been deprecated and will
> +  be removed in Git 3.0.
> ++
> +cf. <xmqqa59i45wc.fsf@gitster.g>
>
>  =3D=3D Superseded features that will not be deprecated
>
> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.a=
doc
> index 9fde1ab63a7..7133f00c38b 100644
> --- a/Documentation/config/core.adoc
> +++ b/Documentation/config/core.adoc
> @@ -531,9 +531,25 @@ core.commentString::
>         commented, and removes them after the editor returns
>         (default '#').
>  +
> -If set to "auto", `git-commit` would select a character that is not
> +ifndef::with-breaking-changes[]
> +If set to "auto", `git-commit` will select a character that is not
>  the beginning character of any line in existing commit messages.
> -+
> +Support for this value is deprecated and will be removed in Git 3.0
> +due to the following limitations:
> ++
> +--
> +* It is incompatible with adding comments in a commit message
> +  template. This includes the conflicts comments added to
> +  the commit message by `cherry-pick`, `merge`, `rebase` and
> +  `revert`.
> +* It is incompatible with adding comments to the commit message
> +  in the `prepare-commit-msg` hook.
> +* It is incompatible with the `fixup` and `squash` commands when
> +  rebasing,
> +* It is not respected by `git notes`
> +--
> ++
> +endif::with-breaking-changes[]
>  Note that these two variables are aliases of each other, and in modern
>  versions of Git you are free to use a string (e.g., `//` or `=E2=81=91=
=E2=81=95=E2=81=91`) with
>  `commentChar`. Versions of Git prior to v2.45.0 will ignore
> diff --git a/builtin/commit.c b/builtin/commit.c
> index fba0dded64a..8794b24572b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -683,6 +683,7 @@ static int author_date_is_interesting(void)
>         return author_message || force_date;
>  }
>
> +#ifndef WITH_BREAKING_CHANGES
>  static void adjust_comment_line_char(const struct strbuf *sb)
>  {
>         char candidates[] =3D "#;@!$%^&|:";
> @@ -716,6 +717,7 @@ static void adjust_comment_line_char(const struct str=
buf *sb)
>         free(comment_line_str_to_free);
>         comment_line_str =3D comment_line_str_to_free =3D xstrfmt("%c", *=
p);
>  }
> +#endif /* WITH_BREAKING_CHANGES */
>
>  static void prepare_amend_commit(struct commit *commit, struct strbuf *s=
b,
>                                 struct pretty_print_context *ctx)
> @@ -912,8 +914,10 @@ static int prepare_to_commit(const char *index_file,=
 const char *prefix,
>         if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
>                 die_errno(_("could not write commit template"));
>
> +#ifndef WITH_BREAKING_CHANGES
>         if (auto_comment_line_char)
>                 adjust_comment_line_char(&sb);
> +#endif /* WITH_BREAKING_CHANGES */
>         strbuf_release(&sb);
>
>         /* This checks if committer ident is explicitly given */
> diff --git a/config.c b/config.c
> index eb60c293ab3..f99496b16c0 100644
> --- a/config.c
> +++ b/config.c
> @@ -1537,14 +1537,18 @@ static int git_default_core_config(const char *va=
r, const char *value,
>             !strcmp(var, "core.commentstring")) {
>                 if (!value)
>                         return config_error_nonbool(var);
> +#ifndef WITH_BREAKING_CHANGES
>                 else if (!strcasecmp(value, "auto"))
>                         auto_comment_line_char =3D 1;
> +#endif /* WITH_BREAKING_CHANGES */
>                 else if (value[0]) {
>                         if (strchr(value, '\n'))
>                                 return error(_("%s cannot contain newline=
"), var);
>                         comment_line_str =3D value;
>                         FREE_AND_NULL(comment_line_str_to_free);
> +#ifndef WITH_BREAKING_CHANGES
>                         auto_comment_line_char =3D 0;
> +#endif /* WITH_BREAKING_CHANGES */
>                 } else
>                         return error(_("%s must have at least one charact=
er"), var);
>                 return 0;
> diff --git a/environment.c b/environment.c
> index 7bf0390a335..6804380889f 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -111,7 +111,9 @@ int protect_ntfs =3D PROTECT_NTFS_DEFAULT;
>   */
>  const char *comment_line_str =3D "#";
>  char *comment_line_str_to_free;
> +#ifndef WITH_BREAKING_CHANGES
>  int auto_comment_line_char;
> +#endif /* WITH_BREAKING_CHANGES */
>
>  /* This is set by setup_git_directory_gently() and/or git_default_config=
() */
>  char *git_work_tree_cfg;
> diff --git a/environment.h b/environment.h
> index 9a3d05d414a..871596afcef 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -207,7 +207,9 @@ extern char *excludes_file;
>   */
>  extern const char *comment_line_str;
>  extern char *comment_line_str_to_free;
> +#ifndef WITH_BREAKING_CHANGES
>  extern int auto_comment_line_char;
> +#endif /* WITH_BREAKING_CHANGES */
>
>  # endif /* USE_THE_REPOSITORY_VARIABLE */
>  #endif /* ENVIRONMENT_H */
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
> index 6bac217ed35..ce0aebb9a7e 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1176,7 +1176,7 @@ test_expect_success 'rebase -i respects core.commen=
tchar' '
>         test B =3D $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>
> -test_expect_success 'rebase -i respects core.commentchar=3Dauto' '
> +test_expect_success !WITH_BREAKING_CHANGES 'rebase -i respects core.comm=
entchar=3Dauto' '
>         test_config core.commentchar auto &&
>         write_script copy-edit-script.sh <<-\EOF &&
>         cp "$1" edit-script
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index b37e2018a74..65b4519a715 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -956,13 +956,13 @@ test_expect_success 'commit --status with custom co=
mment character' '
>         test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
>  '
>
> -test_expect_success 'switch core.commentchar' '
> +test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar' '
>         test_commit "#foo" foo &&
>         GIT_EDITOR=3D.git/FAKE_EDITOR git -c core.commentChar=3Dauto comm=
it --amend &&
>         test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
>  '
>
> -test_expect_success 'switch core.commentchar but out of options' '
> +test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar but =
out of options' '
>         cat >text <<\EOF &&
>  # 1
>  ; 2
> --
> 2.49.0.897.gfad3eb7d210
>

Thanks for initiating this topic.

These changes look good to me.

Ayush
