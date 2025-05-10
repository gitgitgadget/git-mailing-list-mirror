Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92C1428E7
	for <git@vger.kernel.org>; Sat, 10 May 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746847130; cv=none; b=X0UhnTJxrf3SjMmdS3fxDwH2Xs5JiOLbBiAleKcv9nviA7Vp2RUtn9AwgWP7s+77keKbDRiNx5+Bl4kRZ5eQN0lp0rQEKXVNoAs4FVVXtQGMzLVeWp4FioyOA4KQhOYCkyEVSepSqqJYNL1EJ01ca/OppUfVUjpKHLJLYPPga6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746847130; c=relaxed/simple;
	bh=fQVhxc5bFjtyGMoQtOBQlmQRoikbiBn9g5mE1OGbqoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuIiG8a0fW2WPZX9HmpHgVd1muaeh7aDG2jQoYxXg398cYxbfs53XIdECRnbkx7TbaJEBbsUOin02DF3K0BRGDuw0IZYE2SbNYTmwGjRUUlFmqOC/u7mIAwm4cJSUtLlWN2b3jvKljwMYOGoDhxIiLa62Amue51WToOXh8n4dTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAZHNwaD; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAZHNwaD"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3da73e9cf17so24904615ab.2
        for <git@vger.kernel.org>; Fri, 09 May 2025 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746847127; x=1747451927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cDT5a1/LBAmY6ul3DjGSoA0A6pRe1ctoGYHJv12anc=;
        b=gAZHNwaDxaqT0HV4rAd2olc/sEUzGl0v9Ik9G6zWbnrL+/SN4x8gkkB+Olj902O0JV
         JxHfbt4O/ZngKNN12kvLZGIVG6BQdjefsX/5xYuGTqxYKn8P7DlaSWr+gjKL5KGDYhG1
         wySDhHX+obB0sa5qgh2mc0yLMGE2/mFz0ufqGNGXpUPRHS+xYXVwy7DqfBAgGjzOqtC9
         iWJc7F+rzVPlphfrPFDhLqcmD2nLeiGbCrKnZZGEuuScpZEstH2aU1WYM+sXjwDvJ1xk
         ceqVvczs3cuiUDkGBN5Wq/K2MzZa5DKfccOm/zhv9cN8LnSMhAMuTjKdGmjIjTeDVWZQ
         QOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746847127; x=1747451927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cDT5a1/LBAmY6ul3DjGSoA0A6pRe1ctoGYHJv12anc=;
        b=XkB1kuhEW08/z+eL8SYye+D53TDtAtXZJvuNG3uZ0X5yW87VWj6WdK+x9NEN834uZg
         EhJeSjoRYVT5Hjc5XTTTClpPcup73F0ZtGdIQbxpGlvWjZp4ZqpL7V88J5YoOgNAqZUQ
         aq3KVyKyaeXc69Fld7gGoICviYSAimlQwRl/B+TqbmvjuW8Y8Vjuyc+EFTtmrO460MOE
         OoAdJGuNv6rf33o0lK6zAmpOTDAhSdz10PqINOpR9+rB6FnxhYjWpbWTObe8LjPxIMZj
         izGMcwBdhHtJ1gw2o25qiaNJyNsK9pDpyBSOWGxaOs4SlBYQrbijiTn/QAHyg4SQMt/y
         kEZA==
X-Gm-Message-State: AOJu0YzJxj1FkBJEYCeXAFpwXED7qhDoxoTR09U+0s6/VGd7nyTheB3u
	LQdlJUQiVq/GH54ooPvYeiHd+9bqFPZYrTe1leBjFyllpn8PRY7ikVjmeGfbrsxEwFqfw6ZxsRU
	B8EbfnQ0wy4r/noT2aauLSFV+7dTkcb3Xvjs=
X-Gm-Gg: ASbGncuFGTLcpcFv19J4IkSJ+WC576tBXCVZ3gewkqabo5tlGJ14ifgP5MJXdFP4aFX
	Vr3Rgz2eXIXejDodq8GIBcq8PKVT+KGtdZsIKTnpZBgvOdTTEOqCyxchbXwIIRc2pnv5EfRI20F
	B4MpZBlSuWnoXIr7NptgXP/7mLpayIpqwGh5mo+PreKh14tyGT0uSIv7lMKDo7cjwXcQ==
X-Google-Smtp-Source: AGHT+IEgvm3y8v0o+nBMod+N0cPnRAMDOkAmKBd3vRxAAJNxY+y8Ey68qi94wfQ4i7yEHVc8XW+ATUP1sEi16ABkgkQ=
X-Received: by 2002:a05:6e02:190e:b0:3d6:d162:be54 with SMTP id
 e9e14a558f8ab-3da7e20d810mr65333575ab.14.1746847127006; Fri, 09 May 2025
 20:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com> <0e6e199cd19ef186fb10b192529269cafc47805a.1746579321.git.gitgitgadget@gmail.com>
In-Reply-To: <0e6e199cd19ef186fb10b192529269cafc47805a.1746579321.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 May 2025 20:18:35 -0700
X-Gm-Features: AX0GCFuIQuTMitf6FZWKxexDcYxz-MwDCpxriz-dFo4f_x2_d8kyydpWtYTJTfg
Message-ID: <CABPp-BHkgvc0UQbhXfP4POtY8GPVpz9J8ZbX3_jyzL_V7GyBbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] apply: integrate with the sparse index
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:55=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The sparse index allows storing directory entries in the index, marked
> with the skip-wortkree bit and pointing to a tree object. This may be an
> unexpected data shape for some implementation areas, so we are rolling
> it out incrementally on a builtin-per-builtin basis.
>
> This change enables the sparse index for 'git apply'. The main
> motivation for this change is that 'git apply' is used as a child
> process of 'git add -p' and expanding the sparse index for each of those
> child processes can lead to significant performance issues.
>
> The good news is that the actual index manipulation code used by 'git
> apply' is already integrated with the sparse index, so the only product
> change is to mark the builtin as allowing the sparse index so it isn't
> inflated on read.
>
> The more involved part of this change is around adding tests that verify
> how 'git apply' behaves in a sparse-checkout environment and whether or
> not the index expands in certain operations.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/apply.c                          |  7 +++-
>  t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 84f1863d3ac3..a1e20c593d09 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -12,7 +12,7 @@ static const char * const apply_usage[] =3D {
>  int cmd_apply(int argc,
>               const char **argv,
>               const char *prefix,
> -             struct repository *repo UNUSED)
> +             struct repository *repo)
>  {
>         int force_apply =3D 0;
>         int options =3D 0;
> @@ -35,6 +35,11 @@ int cmd_apply(int argc,
>                                    &state, &force_apply, &options,
>                                    apply_usage);
>
> +       if (repo) {
> +               prepare_repo_settings(repo);
> +               repo->settings.command_requires_full_index =3D 0;
> +       }
> +
>         if (check_apply_state(&state, force_apply))
>                 exit(128);
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
> index f9b448792cb4..ab8bd371eff3 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1340,6 +1340,30 @@ test_expect_success 'submodule handling' '
>         grep "160000 $(git -C initial-repo rev-parse HEAD) 0    modules/s=
ub" cache
>  '
>
> +test_expect_success 'git apply functionality' '
> +       init_repos &&
> +
> +       test_all_match git checkout base &&
> +
> +       git -C full-checkout diff base..merge-right -- deep >patch-in-spa=
rse &&
> +       git -C full-checkout diff base..merge-right -- folder2 >patch-out=
side &&
> +
> +       # Apply a patch to a file inside the sparse definition
> +       test_all_match git apply --index --stat ../patch-in-sparse &&
> +       test_all_match git status --porcelain=3Dv2 &&
> +
> +       # Apply a patch to a file outside the sparse definition
> +       test_sparse_match test_must_fail git apply ../patch-outside &&
> +       grep "No such file or directory" sparse-checkout-err &&

I was slightly confused by this at first, because I was thinking of
the case where folder2/a exists in the working directory despite not
matching the sparsity patterns, but you were testing a case where the
working directory matched the sparsity patterns, so folder2/a doesn't
exist.

So, the check here looks good.

And, when folder2/a does exist, then we're in the case handled by
82386b44963f (Merge branch 'en/present-despite-skipped', 2022-03-09),
which forces the directory to not be considered sparse, and so it's
just like the ../patch-in-sparse case...meaning it's not really a
different case to test.

So, it all makes sense.

> +
> +       # But it works with --index and --cached
> +       test_all_match git apply --index --stat ../patch-outside &&
> +       test_all_match git status --porcelain=3Dv2 &&
> +       test_all_match git reset --hard &&
> +       test_all_match git apply --cached --stat ../patch-outside &&
> +       test_all_match git status --porcelain=3Dv2
> +'
> +
>  # When working with a sparse index, some commands will need to expand th=
e
>  # index to operate properly. If those commands also write the index back
>  # to disk, they need to convert the index to sparse before writing.
> @@ -2345,6 +2369,28 @@ test_expect_success 'sparse-index is not expanded:=
 check-attr' '
>         ensure_not_expanded check-attr -a --cached -- folder1/a
>  '
>
> +test_expect_success 'sparse-index is not expanded: git apply' '
> +       init_repos &&
> +
> +       git -C sparse-index checkout base &&
> +       git -C full-checkout diff base..merge-right -- deep >patch-in-spa=
rse &&
> +       git -C full-checkout diff base..merge-right -- folder2 >patch-out=
side &&
> +
> +       # Apply a patch to a file inside the sparse definition
> +       ensure_not_expanded apply --index --stat ../patch-in-sparse &&
> +
> +       # Apply a patch to a file outside the sparse definition
> +       # Fails when caring about the worktree.
> +       ensure_not_expanded ! apply ../patch-outside &&
> +
> +       # Expands when using --index.
> +       ensure_expanded apply --index ../patch-outside &&
> +       git -C sparse-index reset --hard &&

All makes sense up to here.

> +
> +       # Does not expand when using --cached.
> +       ensure_not_expanded apply --cached ../patch-outside

Wait, what?  That makes no sense.

After some digging, I see why the test passed, but it's very
misleading.  Just before this command, if you ran the following
commands from the sparse-index directory, you'd see the following:

$ rm testme
$ GIT_TRACE2_EVENT=3D$(pwd)/testme git apply --cached ../patch-outside
$ grep ensure_full_index testme
$

Which matches what you were testing and shows why it passed for you.
But I'd argue the test is not correct and confusing for anyone that
reads it, because:

$ git ls-files -s --sparse | grep folder2
040000 cb4007891397aa2a451037d1c69e57f0cf498c24 0    folder2/0/
100644 78981922613b2afb6025042ff6bd878ac1994e85 0    folder2/a

In other words, the index was *already* (partially) expanded by the
`git apply --index`, and the `git reset --hard` did not fix that
contrary to expectations.  Continuing from here we see:

$ git reset --hard
HEAD is now at 703fd3e initial commit
$ git ls-files -s --sparse | grep folder2
040000 cb4007891397aa2a451037d1c69e57f0cf498c24 0    folder2/0/
100644 78981922613b2afb6025042ff6bd878ac1994e85 0    folder2/a
$ git sparse-checkout reapply
$ git ls-files -s --sparse | grep folder2
040000 123706f6fc38949628eaf0483edbf97ba21123ae 0    folder2/

So, we need to do a `git sparse-checkout reapply` to make sure we were
actually in the expected fully sparse state.  From here...

$ rm testme
$ GIT_TRACE2_EVENT=3D$(pwd)/testme git apply --cached ../patch-outside
$ grep ensure_full_index testme
{"event":"region_enter","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c"=
,"thread":"main","time":"2025-05-10T03:08:56.856008Z","file":"sparse-index.=
c","line":372,"repo":1,"nesting":1,"category":"index","label":"ensure_full_=
index"}
{"event":"region_leave","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c"=
,"thread":"main","time":"2025-05-10T03:08:56.856454Z","file":"sparse-index.=
c","line":455,"repo":1,"t_rel":0.000446,"nesting":1,"category":"index","lab=
el":"ensure_full_index"}
{"event":"region_enter","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c"=
,"thread":"main","time":"2025-05-10T03:08:56.857016Z","file":"sparse-index.=
c","line":372,"repo":1,"nesting":1,"category":"index","label":"ensure_full_=
index"}
{"event":"region_leave","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c"=
,"thread":"main","time":"2025-05-10T03:08:56.857135Z","file":"sparse-index.=
c","line":455,"repo":1,"t_rel":0.000119,"nesting":1,"category":"index","lab=
el":"ensure_full_index"}

So, indeed, `git apply --cached ../patch-outside` DOES expand the
index, as I expected.  It has to when folder2/ is a directory in the
index, so that we can get a folder2/a entry that we can modify.  And
that's just what we see:

$ git ls-files -s --sparse | grep folder2
040000 cb4007891397aa2a451037d1c69e57f0cf498c24 0    folder2/0/
100644 50f4ca4e6265a0497ec2ee6782648138914ad398 0    folder2/a


Can you add a `git sparse-checkout reapply` right after your `git
reset --hard`, and then switch the ensure_not_expanded to
ensure_expanded for the apply --cached call?
