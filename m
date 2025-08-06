Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0413AF2
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439726; cv=none; b=a41M+GxYgz/3/xa8MITNz6ipLRZnfsJtbyKgv+KWO2tGp565VSyg6Qz6Qzx7hAX31IZD2D30WXk0cPXyFRQQfUGKJnGzyEG6VpxMrcb1NuAMK5PcOD//kfbdsxC2MUpBvwcHK7re+70nnYuSR+z2NvQM9CpttnbJ+mhC3LI3uqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439726; c=relaxed/simple;
	bh=xReg1iqgeB6oa8eRIaZFi2XA9NKFRtd6XgeBja0sKZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+46RWZgdz/izx99thW30MXXHfMNlk+c/QtxoQBCHJoRL1jR8DCULHXm3+63gMhRyHz4ogLwAa3mC2g88QJRoaUFIVdN2/resakLnXXt8dQ3Wt8D246f2VkZj9/cMphBVCe1qYXZiW1AUImTmy85ki3KGKz1iZnxgDmv/I+R5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8C4rKns; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8C4rKns"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e3f449fa6fso53533165ab.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754439723; x=1755044523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwR6hv3XjEMTlB1d8Mme5P9qEbBT+MX7IpmGIz1HZKY=;
        b=e8C4rKnsOf8+LKhXTrFNIwKf28tQRi8id+qBFPKtRMnpMTs22N5ZBtLSeYrz8SpUSR
         waG85+DArxggbYufgjxvvPScoR/HvWMaps72XJiD3Q222mtcix68P8m+HVfsFKLV0ijY
         Yuea/TLz8glYotpUq7KCw5VaH3XuzbISqzF/mg9KtOwzi7f5E2A3PWLcOHK41mOa+u8h
         UIDoILHotGRI3u/JLp21Wb2yD0lPgxVIS/Yvlt9L6R7Afz4vhRpRrTFB0T3kdsL7AuX1
         RmsemNnCQe5dkNZ0oQVtakj+2eE+DHPRmsPtl4tOo+W4MismIE1MFeHUMYpPQYpisO4C
         IwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754439723; x=1755044523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwR6hv3XjEMTlB1d8Mme5P9qEbBT+MX7IpmGIz1HZKY=;
        b=PsDq4Hb+W51Huhz4dlKeC41gfXarqdBmd1oZ/zopnFwpPh4kGY+acF6h8F6Z7tSbwh
         rigeNkHPF4kBw9dtMW7jg+ls5SYmWpz5m1JP3iaoba1MK79gc8WE9/F6FctjWEMxzGU0
         OoGy0cEsO8td6jtGuSgJIYl+9CNxYRCxco3t328XHIRI0Vu0XwzzKJa99i47RrkMRqYN
         +gZYeQ+jSP6SKC8GdXJwDX/I07vqax60QHyi7gbmA5qVs7do5bJUEbiRdmos2dFdfPCv
         NpniiyFUGLgqd5X+YTFY8a9+5DR0DHnRGZexTGv5zXGWhvTmhG4As6Zycw9Y38yA4Sa2
         9u5A==
X-Gm-Message-State: AOJu0Yxcg20r1jYGbGCy0OqjICp0Gkem0/7oE1iggFsfTtccVvDJOUmW
	kaUBOZ/WqXoMKtURqZTazTi4sztvm28EaEMESRNz98VwSE3GnigMtrTsKYbtZwREUPpOoCD6hw0
	9vjTqJfzQvMzdM6dzpV5quNqojZH31Pg=
X-Gm-Gg: ASbGncvMnBavrJzdmCuEotH9CEbU9A8jCQax8fAMW+qOMEcOzjOdN2kbIFdkCmFrZS/
	DhhFpFxaSadha3rl5FPxzD1RkxeqevUljKFFZCq6i200sGayfK5sOw0arn/Zw+4cU/ckb3HAL7u
	sevVhOKPWjOHXaRnUkte9q0rwFC+kqoziqADqkcOw01/Fj9QbywxcLtApifYN/tf8GFNJjqifJ+
	UGumrN11OaBUgJ33b948j5/DTpRfKhNsPa3eTk4xtTely2mjvI=
X-Google-Smtp-Source: AGHT+IFVtXmOF6hSDSay8qDmLHn2VqNdlCIhMtMQBl1SYKr5pa1yeOWQVhv7gTTyNp1b6Idb6aCquic+xKnT0FUf4Xk=
X-Received: by 2002:a05:6e02:348c:b0:3e3:fd25:f6a with SMTP id
 e9e14a558f8ab-3e51b8f5a5bmr10565495ab.11.1754439723157; Tue, 05 Aug 2025
 17:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> <82c24ce51980d85e1a53e746b462397e6e6c908a.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <82c24ce51980d85e1a53e746b462397e6e6c908a.1752716054.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 17:21:50 -0700
X-Gm-Features: Ac12FXxTsVbaAdjh59FaaR6Kghd4GNcHzmAhwGywLGx_CPmnMtNudr1LlDPcCqg
Message-ID: <CABPp-BHLcy-A4yLR8gP1Sjt_EKQ4K08kPyb7G6yifdZj+0MJNg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] sparse-checkout: make 'clean' clear more files
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:34=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The 'git sparse-checkout clean' command is designed to be a one-command
> way to get the worktree in a state such that a sparse index would
> operate efficiently. The previous change demonstrated that files outside
> the sparse-checkout that were committed due to a merge conflict would
> persist despite attempts to run 'git sparse-checkout clean' and instead
> a 'git sparse-checkout reapply' would be required.
>
> Instead of requiring users to run both commands, update 'clean' to be
> more ruthless about tracked sparse directories. The key here is to make
> sure that the SKIP_WORKTREE bit is removed from more paths in the index
> using update_sparsity() before compressing the index to a sparse one
> in-memory.
>
> The tricky part here is that update_sparsity() was previously assuming
> that it would be in 'update' mode and would change the worktree as it
> made changes. However, we do not want to make these worktree changes at
> this point, instead relying on our later logic (that integrates with
> --dry-run and --verbose options) to perform those steps.
>
> One side-effect here is that we also clear out staged files that exist
> in the worktree, but they would also appear in the verbose output as
> part of the dry run.
>
> The final test in t1091 demonstrates that we no longer need the
> 'reapply' subcommand for merge resolutions. It also fixes an earlier
> case where 'git add --sparse' clears the SKIP_WORKTREE bit and avoids a
> directory deletion.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/sparse-checkout.c          |  8 ++++++++
>  t/t1091-sparse-checkout-builtin.sh | 24 +++++++++++++++++-------
>  unpack-trees.c                     |  2 +-
>  3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index f38a0809c098..1d1d5208a3ba 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -962,6 +962,7 @@ static int sparse_checkout_clean(int argc, const char=
 **argv,
>         size_t worktree_len;
>         int force =3D 0, dry_run =3D 0, verbose =3D 0;
>         int require_force =3D 1;
> +       struct unpack_trees_options o =3D { 0 };
>
>         struct option builtin_sparse_checkout_clean_options[] =3D {
>                 OPT__DRY_RUN(&dry_run, N_("dry run")),
> @@ -990,6 +991,13 @@ static int sparse_checkout_clean(int argc, const cha=
r **argv,
>         if (repo_read_index(repo) < 0)
>                 die(_("failed to read index"));
>
> +       o.verbose_update =3D verbose;
> +       o.update =3D 0; /* skip modifying the worktree here. */
> +       o.head_idx =3D -1;
> +       o.src_index =3D o.dst_index =3D repo->index;
> +       if (update_sparsity(&o, NULL))
> +               warning(_("failed to reapply sparse-checkout patterns"));
> +
>         if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY) ||
>             repo->index->sparse_index =3D=3D INDEX_EXPANDED)
>                 die(_("failed to convert index to a sparse index; resolve=
 merge conflicts and try again"));
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index 116ad7c9a20e..4b9078d90a61 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -1104,6 +1104,7 @@ test_expect_success 'clean with staged sparse chang=
e' '
>
>         cat >expect <<-\EOF &&
>         Would remove deep/deeper2/
> +       Would remove folder1/
>         EOF
>
>         git -C repo sparse-checkout clean --dry-run >out &&
> @@ -1115,6 +1116,7 @@ test_expect_success 'clean with staged sparse chang=
e' '
>         # deletes deep/deeper2/ but leaves folder1/ and folder2/
>         cat >expect <<-\EOF &&
>         Removing deep/deeper2/
> +       Removing folder1/
>         EOF
>
>         # The previous test case checked the -f option, so
> @@ -1124,7 +1126,7 @@ test_expect_success 'clean with staged sparse chang=
e' '
>         test_cmp expect out &&
>
>         test_path_is_missing repo/deep/deeper2 &&
> -       test_path_exists repo/folder1 &&
> +       test_path_is_missing repo/folder1 &&
>         test_path_exists repo/folder2

What this doesn't show is that afterwards:

$ git -C repo status

On branch main
You are in a sparse checkout with 78% of tracked files present.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    new file:   folder1/file

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    deleted:    folder1/file
    modified:   folder2/a


=3D=3D> In other words, folder1/file and folder1/ were successfully
removed by this clean command, but when the user runs status, they see
that folder1/file has been deleted (and has a staged change).  This is
probably correct behavior and may be expected, but might be surprising
to users at first; it probably deserves to be documented, or at least
covered in the commit message.  Especially since it's somewhat
difficult for users to work with:

$ cd repo
$ git checkout HEAD -- folder1/file
error: pathspec 'folder1/file' did not match any file(s) known to git

$ git add -- folder1/file
The following paths and/or pathspecs matched paths that exist
outside of your sparse-checkout definition, so will not be
updated in the index:
folder1/file
hint: If you intend to update such entries, try one of the following:
hint: * Use the --sparse option.
hint: * Disable or modify the sparsity rules.
hint: Disable this message with "git config set advice.updateSparsePath fal=
se"

$ git add --sparse -- folder1/file
fatal: pathspec 'folder1/file' did not match any files

$ git reset -- folder1/file
Unstaged changes after reset:
M    folder2/a

$

=3D=3D> So, both checkout and add fail to work with this path while reset
works.  `git commit` also would have worked; let's back up to the
point of status above, then get rid of the folder2/a modification, and
then use git commit to commit our folder1/file change:

$ git checkout folder2/a
Updated 1 path from the index
$ git commit -m "A change"
[main aad2d89] A change
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 folder1/file
$ git status
On branch main
You are in a sparse checkout with 78% of tracked files present.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    deleted:    folder1/file

no changes added to commit (use "git add" and/or "git commit -a")

=3D=3D> Great, so we got rid of the folder2/a modification, and committed
the staged folder1/file modification.  The folder1/file showing as
deleted is annoying but a `sparse-checkout clean` should get rid of it
as well as the pesky folder2/ directory, right?

$ git sparse-checkout clean -f
Removing folder2/

$ git status
On branch main
You are in a sparse checkout with 78% of tracked files present.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    deleted:    folder1/file
    deleted:    folder2/a

no changes added to commit (use "git add" and/or "git commit -a")

=3D=3D> Huh, `git sparse-checkout clean -f` got rid of folder2, but now
folder2/a shows up as deleted locally...and folder1/file is still
showing as deleted locally.  And it doesn't matter how many times we
run `git sparse-checkout clean -f`; this is the end state for it.  But
if we run `git sparse-checkout reapply`:

$ git sparse-checkout reapply
$ git status
On branch main
You are in a sparse checkout with 56% of tracked files present.

nothing to commit, working tree clean

=3D=3D> So, you still need to use `git sparse-checkout reapply` together
with `git sparse-checkout clean -f`; you haven't fixed that yet.


> @@ -1147,7 +1149,11 @@ test_expect_success 'sparse-checkout operations wi=
th merge conflicts' '
>                 git commit -a -m "left" &&
>
>                 git checkout -b merge &&
> -               git sparse-checkout set deep/deeper1 &&
> +
> +               touch deep/deeper2/extra &&
> +               git sparse-checkout set deep/deeper1 2>err &&
> +               grep "contains untracked files" err &&
> +               test_path_exists deep/deeper2/extra &&
>
>                 test_must_fail git merge -m "will-conflict" right &&
>
> @@ -1159,15 +1165,19 @@ test_expect_success 'sparse-checkout operations w=
ith merge conflicts' '
>                 git merge --continue &&
>
>                 test_path_exists folder1/even/more/dirs/file &&
> +               test_path_exists deep/deeper2/extra &&
> +
> +               cat >expect <<-\EOF &&
> +               Removing deep/deeper2/
> +               Removing folder1/
> +               EOF
>
>                 # clean does not remove the file, because the
>                 # SKIP_WORKTREE bit was not cleared by the merge command.

Shouldn't the comment be updated, given the testcase updates?

>                 git sparse-checkout clean -f >out &&
> -               test_line_count =3D 0 out &&
> -               test_path_exists folder1/even/more/dirs/file &&
> -
> -               git sparse-checkout reapply &&
> -               test_path_is_missing folder1
> +               test_cmp expect out &&
> +               test_path_is_missing folder1 &&
> +               test_path_is_missing deep/deeper2

Yes, but why does `git status` show folder1/even/more/dirs/file as
being locally deleted?  Does the code forget to update the
SKIP_WORKTREE status after clearing out the files?
