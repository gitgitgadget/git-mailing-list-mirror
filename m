Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4A34BA37
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877374; cv=none; b=dD3yoIefzJyfC4i2WVHqgl/KCDo+PwCkQeCq0mZnPUpHRQT7AuMbrZR730NoeBOQUP/3EMxC8WyBQMDzUPyOZ0DWSt9b3RLgFNxbqFvjpJiYAEdGgQaILeXapZMnse5UToV6JTBhT761NrwN2JG5NrN9WviDM8Xe8ExhvTCCDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877374; c=relaxed/simple;
	bh=QFBJX/v1b7u5G2irbV/O2PrWvM7Ek+pCvfEKF1D3Ne4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=od66hnrU72GOe+QrxBjZXE2benJM9UIDuWzPpJwj6fP5oXLsZzV4taOtu6IKSAfOR3EoDhI9XPEc1xztIzDmwVD4WWgi1FT+x2SodJYjLajX/XGaOtoX5FW+oCQwh0dETetGA3E6/rCFIUkmjZ3ZPimNlC4qNdR24tA6iqL69fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgfaSR4f; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgfaSR4f"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-938c85ccabcso18585939f.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759877371; x=1760482171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGYk6tK3P4bCI7Vm7HWPY+IgoJqAgHw7j1MMLwIqu+Q=;
        b=kgfaSR4fPWKZOLLl8wQlc9pKko5SlCL8vrMz8dIm7tXkamBCeCAWQZ6ni1fMcnLAWP
         CAxnJaLX36SJD1kFF4mfWv7vRLV8fT4TDIqLkVPjPy+ruxhFQju/d96GDcMpvnPtzUwp
         B8dk50lRguJ2UnU21SrUOS4sHLPRQJRkrwf73vL7rrJX/3a66cDXqr91P/5xcTKEEFDg
         D5H6KFzv7wxjsIY09v3X9OGly/IQx2gFdISleJuI32Y4vby7hvkrn7swWDCXZalw8d4r
         Vzkaz0JciN2V301Ic+JNtgFTzvxqk/0NG9LAyAT7nMKNS0gipfGHxHKS+HqkDYP/dyug
         BYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877371; x=1760482171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGYk6tK3P4bCI7Vm7HWPY+IgoJqAgHw7j1MMLwIqu+Q=;
        b=EFFE0K82vHl/w7JtQpG6/mapCHWeSU4djYLloR1YMH2Rdog2oothz+22GWf0Mhk4Jz
         H0e/bASZ0AM04EyPRAj9wc/UeI94Bk8PvThdkOjfsAl5RkchlFDuTFLnPdU0I03eqJk7
         YlcH+BEztk1T0McWU06O0FhyU42luaCjbWYMxCKXGFoAQPUkxDfVzzshAyVmHng/NMX5
         uwILUeMqTb7f/X0Z+7V74WnA1PcTh4prOqGenk78OCKevabM/+ZWO1n15zJI2iB+k/tG
         1DWYN3grjwja3GB0OtatmU6PXBQnwpTUwT+XpkRAz3YI1d/3WUKVyJAXHsSnQ1pGQq21
         68pA==
X-Gm-Message-State: AOJu0YynHFWOg9pzivsVKg9LC4V78CYdpcVgiKmg0p7eAnRFIQZcJbX9
	k5RZJiPBaxU6SCFT0Iqnnk6q8P73QsfkwYIEV5MvFciV4Q2DSFgzAQysKzJc4DjLwVYPHxPldPM
	VVm3Dbsosq3LUv0VhTH7fh5C6R7D9LUU=
X-Gm-Gg: ASbGncviENwvaigkxRk0p0AzDvOFJDpbU9C+j+quzG8PTNsJ/uUArQz80a9OxtM3MDa
	23/QBSFs5SrxltoEVVJb2R0ELemNG8jbM01NiJrb8F2PcMf7skyIHlFRPXzpe+UxiyjR2QDEI3+
	dq2GcixWH406m4yOJHm3u0kHAsa6JXBLmCHPkxocHUPuQgRq6yGb7F3bxI1t+XYbhylRG/qd7Hc
	dRPjmEz6vLDmmlROVWRLPU79c+K9Z0hVHGx0GZ1VQp71FhjCPHvCZAHhQIqt8Zx
X-Google-Smtp-Source: AGHT+IGm8/Mf4euk63rbaRUSoUfTytlVB1+WQzMH4et1ERnii8M6REESgR7MsC3zFDcAIKjc4I6oaoeDA/RyQeyscOk=
X-Received: by 2002:a05:6602:a107:b0:918:46b7:4d35 with SMTP id
 ca18e2360f4ac-93bc412cf0fmr540159439f.6.1759877371248; Tue, 07 Oct 2025
 15:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com> <a1564f74cfa19eee528a1a0c54b87ac52d1e8975.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <a1564f74cfa19eee528a1a0c54b87ac52d1e8975.1757673011.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 15:49:20 -0700
X-Gm-Features: AS18NWANoruzCYapQfD_ojgjJQDwoEjziBh6oOxxP8NVPCQEZDnEd0QxeJtpIO4
Message-ID: <CABPp-BGJ66e=znwOxvU0fLiw=KXwMg8FZxa283Jr5PXut_ECWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] sparse-checkout: add basics of 'clean' command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:30=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> When users change their sparse-checkout definitions to add new
> directories and remove old ones, there may be a few reasons why
> directories no longer in scope remain (ignored or excluded files still
> exist, Windows handles are still open, etc.). When these files still
> exist, the sparse index feature notices that a tracked, but sparse,
> directory still exists on disk and thus the index expands. This causes a
> performance hit _and_ the advice printed isn't very helpful. Using 'git
> clean' isn't enough (generally '-dfx' may be needed) but also this may
> not be sufficient.
>
> Add a new subcommand to 'git sparse-checkout' that removes these
> tracked-but-sparse directories.
>
> The implementation details provide a clear definition of what is happenin=
g,
> but it is difficult to describe this without including the internal
> implementation details. The core operation converts the index to a sparse
> index (in memory if not already on disk) and then deletes any directories=
 in
> the worktree that correspond with a sparse directory entry in that sparse
> index.
>
> In the most common case, this means that a file will be removed if it is
> contained within a directory that is both tracked and outside of the
> sparse-checkout definition. However, there can be exceptions depending on
> the current state of the index:
>
>  * If the worktree has a modification to a tracked, sparse file, then tha=
t
>    file's parent directories will be expanded instead of represented as
>    sparse directories. Siblings of those parent directories may be
>    considered sparse.
>
>  * If the user staged a sparse file with "git add --sparse", then that fi=
le
>    loses the SKIP_WORKTREE bit until the sparse-checkout is reapplied. Un=
til
>    then, that file's parent directories are not represented as sparse
>    directory entries and thus will not be removed. Siblings of those pare=
nt
>    directories may be considered sparse. (There may be other reasons why
>    the SKIP_WORKTREE bit was removed for a file and this impact on the
>    sparse directories will apply to those as well.)
>
>  * If the user has a merge conflict outside of the sparse-checkout
>    definition, then those conflict entries prevent the parent directories
>    from being represented as sparse directory entries and thus are not
>    removed.
>
>  * The cases above present reasons why certain _file conditions_ will imp=
act
>    which _directories_ are considered sparse. The list of tracked
>    directories that are outside of the sparse-checkout definition but not
>    represented as a sparse directory further reduces the list of files th=
at
>    will be removed.
>
> For these complicated reasons, the documentation details a potential list=
 of
> files that will be "considered for removal" instead of defining the list
> concretely. The special cases can be handled by resolving conflicts,
> committing staged changes, and running 'git sparse-checkout reapply' to
> update the SKIP_WORKTREE bits as expected by the sparse-checkout definiti=
on.
>
> It is important to make clear that this operation will remove ignored and
> excluded files which would normally be ignored even by 'git clean -f' unl=
ess
> the '-x' or '-X' option is provided. This is the most extreme method for
> doing this, but it works when the sparse-checkout is in cone mode and is
> expected to rescope based on directories, not files.
>
> The current implementation always deletes these sparse directories
> without warning. This is unacceptable for a released version, but those
> features will be added in changes coming immediately after this one.
>
> Note that this will not remove an untracked directory (or any of its
> contents) if its parent is a tracked directory within the sparse-checkout
> definition. This is required to prevent removing data created by tools th=
at
> perform caching operations for editors or build tools.
>
> Thus, 'git sparse-checkout clean' is both more aggressive and more carefu=
l
> than 'git clean -fx':
>
>  * It is more aggressive because it will remove _tracked_ files within th=
e
>    sparse directories.
>
>  * It is less aggressive because it will leave _untracked_ files that are
>    not contained in sparse directories.
>
> These special cases will be handled more explicitly in a future change th=
at
> expands tests for the 'git sparse-checkout clean' command. We handle some=
 of
> the modified, staged, and committed states including some impact on 'git
> status' after cleaning.

I appreciate the more detailed explanation.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-sparse-checkout.adoc |  19 ++++-
>  builtin/sparse-checkout.c              |  64 ++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh     | 103 +++++++++++++++++++++++++
>  3 files changed, 184 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-s=
parse-checkout.adoc
> index 529a8edd9c..baaebce746 100644
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
> @@ -111,6 +111,23 @@ flags, with the same meaning as the flags from the `=
set` command, in order
>  to change which sparsity mode you are using without needing to also resp=
ecify
>  all sparsity paths.
>
> +'clean'::
> +       Opportunistically remove files outside of the sparse-checkout
> +       definition. This command requires cone mode to use recursive
> +       directory matches to determine which files should be removed. A
> +       file is considered for removal if it is contained within a tracke=
d
> +       directory that is outside of the sparse-checkout definition.
> ++
> +Some special cases, such as merge conflicts or modified files outside of
> +the sparse-checkout definition could lead to keeping files that would
> +otherwise be removed. Resolve conflicts, stage modifications, and use
> +`git sparse-checkout reapply` in conjunction with `git sparse-checkout
> +clean` to resolve these cases.
> ++
> +This command can be used to be sure the sparse index works efficiently,
> +though it does not require enabling the sparse index feature via the
> +`index.sparse=3Dtrue` configuration.

This expanded explanation for users is nice too.  I particularly like
that you called out three things users need to use in conjunction with
this command -- resolving conflicts, staging modifications, and using
`git sparse-checkout reapply`...

[...]
> +       if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY) ||
> +           repo->index->sparse_index =3D=3D INDEX_EXPANDED)
> +               die(_("failed to convert index to a sparse index; resolve=
 merge conflicts and try again"));

...yet the error message you give to users only lists one of those
three things even though the other two may be the problem.  Could we
fix up the error message?

> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index ab3a105fff..bdb7b21e32 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -1050,5 +1050,108 @@ test_expect_success 'check-rules null termination=
' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'clean' '
> +       git -C repo sparse-checkout set --cone deep/deeper1 &&
> +       git -C repo sparse-checkout reapply &&
> +       mkdir repo/deep/deeper2 repo/folder1 &&
> +
> +       # Add untracked files
> +       touch repo/deep/deeper2/file &&
> +       touch repo/folder1/file &&
> +
> +       cat >expect <<-\EOF &&
> +       Removing deep/deeper2/
> +       Removing folder1/
> +       EOF
> +
> +       git -C repo sparse-checkout clean >out &&
> +       test_cmp expect out &&
> +
> +       test_path_is_missing repo/deep/deeper2 &&
> +       test_path_is_missing repo/folder1
> +'
> +
> +test_expect_success 'clean with sparse file states' '
> +       test_when_finished git reset --hard &&
> +       git -C repo sparse-checkout set --cone deep/deeper1 &&
> +       mkdir repo/folder2 &&
> +
> +       # create an untracked file and a modified file
> +       touch repo/folder2/file &&
> +       echo dirty >repo/folder2/a &&
> +
> +       # First clean/reapply pass will do nothing.
> +       git -C repo sparse-checkout clean >out &&
> +       test_must_be_empty out &&
> +       test_path_exists repo/folder2/a &&
> +       test_path_exists repo/folder2/file &&
> +
> +       git -C repo sparse-checkout reapply 2>err &&
> +       test_grep folder2 err &&
> +       test_path_exists repo/folder2/a &&
> +       test_path_exists repo/folder2/file &&
> +
> +       # Now, stage the change to the tracked file.
> +       git -C repo add --sparse folder2/a &&
> +
> +       # Clean will continue not doing anything.
> +       git -C repo sparse-checkout clean >out &&
> +       test_line_count =3D 0 out &&
> +       test_path_exists repo/folder2/a &&
> +       test_path_exists repo/folder2/file &&
> +
> +       # But we can reapply to remove the staged change.
> +       git -C repo sparse-checkout reapply 2>err &&
> +       test_grep folder2 err &&
> +       test_path_is_missing repo/folder2/a &&
> +       test_path_exists repo/folder2/file &&
> +
> +       # We can clean now.
> +       cat >expect <<-\EOF &&
> +       Removing folder2/
> +       EOF
> +       git -C repo sparse-checkout clean >out &&
> +       test_cmp expect out &&
> +       test_path_is_missing repo/folder2 &&
> +
> +       # At the moment, the file is staged.
> +       cat >expect <<-\EOF &&
> +       M  folder2/a
> +       EOF
> +
> +       git -C repo status -s >out &&
> +       test_cmp expect out &&
> +
> +       # Reapply persists the modified state.
> +       git -C repo sparse-checkout reapply &&
> +       cat >expect <<-\EOF &&
> +       M  folder2/a
> +       EOF
> +       git -C repo status -s >out &&
> +       test_cmp expect out &&
> +
> +       # Committing the change leads to resolved status.
> +       git -C repo commit -m "modified" &&
> +       git -C repo status -s >out &&
> +       test_must_be_empty out &&
> +
> +       # Repeat, but this time commit before reapplying.
> +       mkdir repo/folder2/ &&
> +       echo dirtier >repo/folder2/a &&
> +       git -C repo add --sparse folder2/a &&
> +       git -C repo sparse-checkout clean >out &&
> +       test_must_be_empty out &&
> +       test_path_exists repo/folder2/a &&
> +
> +       # Committing without reapplying makes it look like a deletion
> +       # due to no skip-worktree bit.
> +       git -C repo commit -m "dirtier" &&
> +       git -C repo status -s >out &&
> +       test_must_be_empty out &&
> +
> +       git -C repo sparse-checkout reapply &&
> +       git -C repo status -s >out &&
> +       test_must_be_empty out
> +'
>
>  test_done
> --
> gitgitgadget

I very much appreciate the extended test.
