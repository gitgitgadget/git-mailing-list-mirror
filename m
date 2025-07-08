Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525752459F8
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011009; cv=none; b=N0dTPfthxfTeNPHijwvsT0P0eD2bkEFwZpCsvoeYX8h9GpQzl1xRyRNzYFvEqgwH7m6gZflaRT8OdPRLgi/mAxWRMY2VJxiqgEJ9G1f7a5+me1qqZsaiWOZTNXR2opo1gzFDin1nEHzQnny5a7qPWdJkyaK76gmG2wDA/99QdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011009; c=relaxed/simple;
	bh=nwz4SpO63svrOzcindFJNh0EIGS0oQ0TDCXKuUZEDqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnZi9CJRM2bA99cFOfYliTjL+96Fp/ZpdZqmoSs5YTlvE8pJS6XvD7KkqhO1lCwRkeTLAHEI8VWoDYpcfPqguBF5JerkZ/HtYmAOmZ/HHb83pPXQPeE8ef/MjdZiTM2YmzWsTP3FklstJUAsYx+8sUGh+6Yl7ANwvVAuKgMKqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2S7Udqb; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2S7Udqb"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ddb4a7ac19so18728965ab.3
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752011006; x=1752615806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/ZMd3KGYpBDOaQrKZ8O3ES1yPrdYwvza7bWpvLmmxo=;
        b=m2S7UdqbkIVGONBNYzJ9AcqbOxtD1JHIieE+ABWqspWdlo44Z/kZX5obrP0odU1O/l
         DzOy9yA02nyfKnRdaIxUj5O3FXxulLvdpwjxE4ZLC1WxnYo8nny9ik0l/OMEy+vn+srS
         BfHbw13vcXA21R1IjtwAGDu0xlxKmli10vknqr5CQJXlHFo4tEK7bMEAW4VF3PAARtN1
         jqxS1V2yYMBPtiIOhXmrJ3xljZgvtkL/5lf+10QUnMw/aRUhMNdFewWCZKVN8eZ2f09A
         WKBDGsjZKkzUcrUMDWex1d711uRxomaEFM0arhoaUSOfI0WBfNHeiQrbE+nKJp6UA2yH
         6pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752011006; x=1752615806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ZMd3KGYpBDOaQrKZ8O3ES1yPrdYwvza7bWpvLmmxo=;
        b=Lz3i3XSZHIaA6B96k+RfUHmJYx/TsyX7PxemGs7711uaCCTwBWPMQUrkSlKyrNIESs
         VnKZBC1XHbc4QuGqv40sK4eolwMxmt1fBDeMnyNQUvX0jzTgnojV2SAL6ptvuqwmE2SY
         JjiFjwHuXF1M6rp6c1pRj/WzcebkRJc+sx2rb27yxHtZW44IG6SmeI0kd/SK6GupMpX3
         uorQnSo6bkn34o233Aku9t3eCcpbKGi3o78RZnuCpJRnb4zGN6zsrm7MZ64IhWpOC2RF
         jSDttJuvNuzfKSslBuXwdt76xohjuEgmTjRfZin6VCbP26cSrpbSFhpA+yQb5pSP4G66
         k/oQ==
X-Gm-Message-State: AOJu0YzAm+dkIFKLzPooDllKOkXxejuNa4SmcabNIRwbET3VKbhygwkQ
	L1dgKJw62UCX7jdo1b/Kyjd538Kzw0JU/nPglfD1mODFhHFMqc3MMIgKcoTrap8CJa3ZptH7kGJ
	1gfkJ7PkBvKCMPon7xN5wVualFDMyLwk=
X-Gm-Gg: ASbGncuhE4BDzHWNFqXTtW97cG1DUlrfmOWYsDwZ0TGtwdX7pGmzUa1vnXFpukoKFVX
	GBjPLMBOqfsV0iumqsOsK8Mf+Hq2653OcdL+nQGoxVa2+1wX6Z/vFPWjGapszUzrQTUru15X/uH
	f8ZIdPxJgupOGY1UXiYeZJEHQMWX4RN6N7nM0lG1U2oMVFE6QuYb+u+d+oQg==
X-Google-Smtp-Source: AGHT+IE4A129GavPFdcqbiWy4uUu67qv9zNIyX6x7vploEqC40tt59jzvoYQezrPHo6BUT36GWTo67Ho3x7g9nZiuAI=
X-Received: by 2002:a05:6e02:3981:b0:3dd:d995:30ec with SMTP id
 e9e14a558f8ab-3e1670de80bmr4021575ab.12.1752011006159; Tue, 08 Jul 2025
 14:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com> <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
In-Reply-To: <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 8 Jul 2025 14:43:14 -0700
X-Gm-Features: Ac12FXwIoxywnPUpuD_wJDJHFoNd93qAY8FSdupKF_aZOHExK2N2jy_FC_ZzrE8
Message-ID: <CABPp-BH_JGbtDsne_tKBoqDr9LzL==gs0E5xyPdbqygyXs8+vA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:20=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> When users change their sparse-checkout definitions to add new
> directories and remove old ones, there may be a few reasons why
> directories no longer in scope remain (ignored or excluded files still
> exist, Windows handles are still open, etc.).

Good background; I am still particularly interested in the "etc." part...

> When these files still
> exist, the sparse index feature notices that a tracked, but sparse,
> directory still exists on disk and thus the index expands. This causes a
> performance hit _and_ the advice printed isn't very helpful. Using 'git
> clean' isn't enough (generally '-dfx' may be needed) but also this may
> not be sufficient.

Very well motivated.

> Add a new subcommand to 'git sparse-checkout' that removes these
> tracked-but-sparse directories, including any excluded or ignored files
> underneath.

"including"?

> This is the most extreme method for doing this, but it works
> when the sparse-checkout is in cone mode and is expected to rescope
> based on directories, not files.

So is this also meant for cone mode without sparse index turned on?
What about non-cone mode?

> Be sure to add a --dry-run option so users can predict what will be
> deleted. In general, output the directories that are being removed so
> users can know what was removed.

Is greater fidelity of interest when there are multiple different
types of files contained?  For example, "git status" lists individual
files within a directory, unless it find an ignored directory and then
it simply lists the directory.  That means we get more fidelity when
it's warranted, and less when it's not.  I'm not sure if that's a
perfect analogy, though; it may well be that we don't need the same
kind of fidelity that `git status` provides.  (And I'm kind of
guessing it isn't needed, except in error cases, but I'm just asking.)

> Note that untracked directories remain.

What does this mean?  If the sparse directory had an untracked
directory within it then it'll be left on disk, you will only clean up
untracked files at a depth of 1 within the sparse directory?

Or that untracked directories not contained within a sparse directory
will be left alone?

> Further, directories that
> contain staged changes are not deleted.

Shouldn't those be safe to delete?  When a sparse directory has files
underneath it with staged changes, those roll-up into a staged
sparse-directory tree value, and so we should be able to delete the
file.

In contrast, the files under the sparse directory with unstaged
changes would be problematic to simply remove.

> This is a detail that is partly
> hidden by the implementation which relies on collapsing the index to a
> sparse index in-memory and only deleting directories that are listed as
> sparse in the index. If a staged change exists, then that entry is not
> stored as a sparse tree entry and thus remains on-disk until committed
> or reset.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-sparse-checkout.adoc | 13 ++++-
>  builtin/sparse-checkout.c              | 73 +++++++++++++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh     | 48 +++++++++++++++++
>  3 files changed, 132 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-s=
parse-checkout.adoc
> index 529a8edd9c1e..21ba6f759905 100644
> --- a/Documentation/git-sparse-checkout.adoc
> +++ b/Documentation/git-sparse-checkout.adoc
> @@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subse=
t of tracked files
>  SYNOPSIS
>  --------
>  [verse]
> -'git sparse-checkout' (init | list | set | add | reapply | disable | che=
ck-rules) [<options>]
> +'git sparse-checkout' (init | list | set | add | reapply | disable | che=
ck-rules | clean) [<options>]
>
>
>  DESCRIPTION
> @@ -111,6 +111,17 @@ flags, with the same meaning as the flags from the `=
set` command, in order
>  to change which sparsity mode you are using without needing to also resp=
ecify
>  all sparsity paths.
>
> +'clean'::
> +       Remove all files in tracked directories that are outside of the
> +       sparse-checkout definition.

If literal, this sounds unsafe, particularly if run while resolving
merge or rebase conflicts (since those conflicts may occur in paths
outside the sparse checkout definition).

> +                                                    This subcommand requ=
ires cone-mode
> +       sparse-checkout to be sure that we know which directories are
> +       both tracked and all contained paths are not in the sparse-checko=
ut.
> +       This command can be used to be sure the sparse index works
> +       efficiently.

So...what does it do when in cone mode and the sparse index is not enabled?

> ++
> +The `clean` command can also take the `--dry-run` (`-n`) option to list
> +the directories it would remove without performing any filesystem change=
s.
> +
>  'disable'::
>         Disable the `core.sparseCheckout` config setting, and restore the
>         working directory to include all files.
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 8b70d0c6a441..6d2843827367 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -23,7 +23,7 @@
>  static const char *empty_base =3D "";
>
>  static char const * const builtin_sparse_checkout_usage[] =3D {
> -       N_("git sparse-checkout (init | list | set | add | reapply | disa=
ble | check-rules) [<options>]"),
> +       N_("git sparse-checkout (init | list | set | add | reapply | disa=
ble | check-rules | clean) [<options>]"),
>         NULL
>  };
>
> @@ -924,6 +924,76 @@ static int sparse_checkout_reapply(int argc, const c=
har **argv,
>         return update_working_directory(repo, NULL);
>  }
>
> +static char const * const builtin_sparse_checkout_clean_usage[] =3D {
> +       "git sparse-checkout clean [-n|--dry-run]",
> +       NULL
> +};
> +
> +static struct sparse_checkout_clean_opts {
> +       int dry_run;
> +} clean_opts;
> +
> +static int sparse_checkout_clean(int argc, const char **argv,
> +                                  const char *prefix,
> +                                  struct repository *repo)
> +{
> +       struct strbuf full_path =3D STRBUF_INIT;
> +       size_t worktree_len;
> +       static struct option builtin_sparse_checkout_clean_options[] =3D =
{
> +               OPT_BOOL('n', "dry-run", &clean_opts.dry_run,
> +                        N_("list the directories that would be removed w=
ithout making filesystem changes")),
> +               OPT_END(),
> +       };
> +
> +       setup_work_tree();
> +       if (!core_apply_sparse_checkout)
> +               die(_("must be in a sparse-checkout to clean directories"=
));
> +       if (!core_sparse_checkout_cone)
> +               die(_("must be in a cone-mode sparse-checkout to clean di=
rectories"));
> +
> +       argc =3D parse_options(argc, argv, prefix,
> +                            builtin_sparse_checkout_clean_options,
> +                            builtin_sparse_checkout_clean_usage, 0);
> +
> +       if (repo_read_index(repo) < 0)
> +               die(_("failed to read index"));
> +
> +       if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY))
> +               die(_("failed to convert index to a sparse index"));

So, you make the in-memory index sparse; I don't remember the details
on this function so it might invalidate some things I say below...but
after this point you then...

> +
> +       strbuf_addstr(&full_path, repo->worktree);
> +       strbuf_addch(&full_path, '/');
> +       worktree_len =3D full_path.len;
> +
> +       for (size_t i =3D 0; i < repo->index->cache_nr; i++) {
> +               DIR* dir;
> +               struct cache_entry *ce =3D repo->index->cache[i];
> +               if (!S_ISSPARSEDIR(ce->ce_mode))
> +                       continue;

...skip the entries that aren't sparse directories.

> +               strbuf_setlen(&full_path, worktree_len);
> +               strbuf_add(&full_path, ce->name, ce->ce_namelen);
> +
> +               dir =3D opendir(full_path.buf);
> +               if (!dir)
> +                       continue;

...skip the sparse directories that, as expected, don't exist on disk.

> +               else if (ENOENT !=3D errno) {
> +                       warning_errno(_("failed to check for existence of=
 '%s'"), ce->name);
> +                       continue;
> +               }
> +
> +               closedir(dir);
> +
> +               printf("%s\n", ce->name);
> +               if (!clean_opts.dry_run) {
> +                       if (remove_dir_recursively(&full_path, 0))
> +                               warning_errno(_("failed to remove '%s'"),=
 ce->name);
> +               }

...and then unconditionally remove the directory, as you stated in the
documentation for this clean option.

I'm worried whether this is safe; if someone does a merge or rebase,
there could be tracked-and-modified/conflicted files outside the
sparse specification in the working tree.

Even after resolving such a merge and committing, the paths may remain
around until the user does a 'git sparse-checkout reapply' (I don't
remember details here, but our documentation for reapply certainly
says so), and since the file might stick around, the user may make
further modifications to such a file.

...or will the convert_to_sparse() call above fail in all these cases?
 If it does, should it give a better and more useful error message
than "failed to convert index to a sparse index" and rather e.g. "path
%s has modifications; please stage or revert first"?

> +       }
> +
> +       strbuf_release(&full_path);
> +       return 0;
> +}
> +
>  static char const * const builtin_sparse_checkout_disable_usage[] =3D {
>         "git sparse-checkout disable",
>         NULL
> @@ -1080,6 +1150,7 @@ int cmd_sparse_checkout(int argc,
>                 OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
>                 OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
>                 OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
> +               OPT_SUBCOMMAND("clean", &fn, sparse_checkout_clean),
>                 OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
>                 OPT_SUBCOMMAND("check-rules", &fn, sparse_checkout_check_=
rules),
>                 OPT_END(),
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index ab3a105ffff2..7f8a444541f7 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -1050,5 +1050,53 @@ test_expect_success 'check-rules null termination'=
 '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'clean' '
> +       git -C repo sparse-checkout set --cone deep/deeper1 &&
> +       mkdir repo/deep/deeper2 repo/folder1 &&
> +       touch repo/deep/deeper2/file &&
> +       touch repo/folder1/file &&
> +
> +       cat >expect <<-\EOF &&
> +       deep/deeper2/
> +       folder1/
> +       EOF
> +
> +       git -C repo sparse-checkout clean --dry-run >out &&
> +       test_cmp expect out &&
> +
> +       test_path_exists repo/deep/deeper2 &&
> +       test_path_exists repo/folder1 &&
> +
> +       git -C repo sparse-checkout clean >out &&
> +       test_cmp expect out &&
> +
> +       ! test_path_exists repo/deep/deeper2 &&
> +       ! test_path_exists repo/folder1
> +'
> +
> +test_expect_success 'clean with staged sparse change' '
> +       git -C repo sparse-checkout set --cone deep/deeper1 &&
> +       mkdir repo/deep/deeper2 repo/folder1 &&
> +       touch repo/deep/deeper2/file &&
> +       touch repo/folder1/file &&
> +
> +       git -C repo add --sparse folder1/file &&
> +
> +       cat >expect <<-\EOF &&
> +       deep/deeper2/
> +       EOF
> +
> +       git -C repo sparse-checkout clean --dry-run >out &&
> +       test_cmp expect out &&
> +
> +       test_path_exists repo/deep/deeper2 &&
> +       test_path_exists repo/folder1 &&
> +
> +       git -C repo sparse-checkout clean >out &&
> +       test_cmp expect out &&
> +
> +       ! test_path_exists repo/deep/deeper2 &&
> +       test_path_exists repo/folder1
> +'
>
>  test_done
> --
> gitgitgadget
