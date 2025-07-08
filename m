Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835923D28E
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007025; cv=none; b=raJU9tQbOZZ0qmqq55ua3hSvnDQPqW0D8M2s9x8oEfiKieCWdmVVAdi7hFvIKG+Inbp4dTj8HGagT7S0cl9bT+gfgfCK8OH6l4uQlkxciDKRIPB4KvPO6vNXr5XZOtQXuhwaJoAlka48RSeubWN87yAcnsXB2PMOWj93aZ1EcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007025; c=relaxed/simple;
	bh=yI2xtYqkX2m4OKujCuW59H/vivLEjrc1Wvr87xrMxFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3r960UqK4kYbpD8AreLknhEgSubSKLFlkzeZxFOuZUnXbEcAXisRcjs4Drg0H45GAlB6QftcPjGG3vKPUqSxLWJ9nPuCNHZpll9uZrQL2a/Tu53j7Z399vDEqfAkMa9pDa1rRIQUT4q9VFAf9c/By2umd49SAOuwQvudyV3D6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYghtgeE; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYghtgeE"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df2d111fefso42840685ab.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752007023; x=1752611823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrgWBmhCtjV/8z4lKwu8PQkceA3twLEbwB9Ym8P3ulQ=;
        b=JYghtgeEfRDWTpkA9gNMtCuMC1hBQm9s60CsU2jQH5wdvGenJfPCzCxg+etwODRLfW
         DZCwIbo1NztQDgofCIInf7BhLXwH1NOY3I3NhNCQ/HpsQWsde0vQHbzQ0qGV23O5Zub8
         6Z35ICc+8xfc62hjJwdBaqSmAlCm8n/D3QykHKaz3OG4xYhNCZOC+3P/4i5wXp4e7Www
         3vjGLvG8Sd2kUnFjqZcXvIoptPI4TjyFONgE2dW108/V+1Yagy5sCWBmW9rAccvIin4m
         fl564g0WiZib6eoARDweipCVIyp+ktEr6ihD3t6d4Kr0UsCdHHH8iioxgt1V0PtgAvHH
         JPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752007023; x=1752611823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrgWBmhCtjV/8z4lKwu8PQkceA3twLEbwB9Ym8P3ulQ=;
        b=DQR/8nOoxDgabpXSopapy76dIO6Rm04ynELwHAkNzCYW3TQRqxM7X6T/riZqWM1E55
         qo6y3xUGvPZ7QqcahVcQCU+7qA7cARTyEFyvKJZTqqqX8ApX0LxFltQOWdzaOMKDJQm1
         sgxl45+XB5R4LLYlu92MazXKd2Uwp0hHXunXhHcI7LV8IG00FpckDDmbtnVFiCMXlrC7
         lo7Vj27b3Wi8x8Q/LmXb7GSj+L2XoGJ/Cc+YiAsou9PvV32L5xxdxM0y4ArLSbFFX+Y9
         AsZAIkJFfwN8wsFSidfBLLTY6aWaSQ0oN28NKzI6xvFJjGTiT2tkYw6kquEMrF8l9Q6S
         ykHg==
X-Gm-Message-State: AOJu0YyOYApfMk56dmAi/j2iX4Fo1SP04gVLqHO8NcNfFxTZpeuVUZkg
	yTJs9VvnqwfGKXuSIZ874Nu/fUwcbrvEKacuxFY409nL47dMa+Jkzl6NTK1WfUI1rJVAdznrx42
	uVTksKtcTASAHM29R/qHherW+68TGzHWju2lQ
X-Gm-Gg: ASbGncs5pC5zyIa8/VkoPsgxwFgwXo6hKIIF4e1gHm8KsK3u8ahCQDHC7gr4z5EyXyP
	XjXPIbNZi7ph+Zfjm6PCpN+KvK77wy+x3FNWH1/UgqBKtq5i6Y9pLAhj62Jh9gkvIudl1EWL4Gl
	Bi0umkd1pMOVJTv8JFFc5uTEcNo48jVRhCaRZP9vLHu78A+ftrw3d2pTYDlQ==
X-Google-Smtp-Source: AGHT+IEc5HFqUIvZGbTSd4vuFy9ldiL2lgT212kr2q7Bddi5z1AWpqGsJ5spYThzeLfFU0LfxtWpLx3qlR+9Pn+3yqY=
X-Received: by 2002:a05:6e02:1f0a:b0:3df:4234:df71 with SMTP id
 e9e14a558f8ab-3e1670b6aa9mr967565ab.10.1752007023060; Tue, 08 Jul 2025
 13:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 8 Jul 2025 13:36:51 -0700
X-Gm-Features: Ac12FXx1WIrOnZzUwMOhKAlM6X0x6ZoJBM4SkaAzUkUpQjRVXF1I0lJ1D2xNmiE
Message-ID: <CABPp-BGSEsQ5Ljm4j81VUuM+_U6CJYDG64wKxj_-oEK=WVD4iw@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparse-checkout: add 'clean' command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:19=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> When using cone-mode sparse-checkout, users specify which tracked
> directories they want (recursively) and any directory not part of the par=
ent
> paths for those directories are considered "out of scope". When changing
> sparse-checkouts, there are a variety of reasons why these "out of scope"
> directories could remain, including:
>
>  * The user has .gitignore or .git/info/exclude files that tell Git to no=
t
>    remove files of a certain type.
>  * Some filesystem blocker prevented the removal of a tracked file. This =
is
>    usually more of an issue on Windows where a read handle will block fil=
e
>    deletion.
>
> Typically, this would not mean too much for the user experience. A few ex=
tra
> filesystem checks might be required to satisfy git status commands, but t=
he
> scope of the performance hit is relative to how many cruft files are left
> over in this situation.
>
> However, when using the sparse index, these tracked sparse directories ca=
use
> significant performance issues. When noticing that the index contains a
> sparse directory but that directory exists on disk, Git needs to expand t=
hat
> sparse directory to determine which files are tracked or untracked. The
> current mechanism expands the entire index to a full one, an expensive
> operation that scales with the total number of paths at HEAD and not just
> the number of cruft files left over.
>
> Advice was added in 9479a31d603 (advice: warn when sparse index expands,
> 2024-07-08) to help users determine that they were in this state. However=
,
> the advice doesn't actually recommend helpful ways to get out of this sta=
te.
> Recommending "git clean" on its own is incomplete, as typically users
> actually need 'git clean -dfx' to clear out the ignored or excluded files=
.
> Even then, they may need 'git sparse-checkout reapply' afterwards to clea=
r
> the sparse directories.
>
> The advice was successful in helping to alert users to the problem, which=
 is
> how I got wind of many of these cases for how users get into this state.
> It's now time to give them a tool that helps them out of this state.
>
> This series adds a new 'git sparse-checkout clean' command that currently
> only works for cone-mode sparse-checkouts. The only thing it does is
> collapse the index to a sparse index (as much as possible) and make sure
> that any sparse directories are removed. These directories are listed to
> stdout.

But what does it clean up?
  - untracked files?
  - ignored files?
  - tracked-but-unmodified files?
  - tracked-and-modified files?
  - tracked-and-conflicted files? (which is probably a subset of
tracked-and-modified, but thought I'd call it out)

Note: "tracked" probably has a slightly ambiguous connotation here
since we sometimes mean "is it in the index", and there's a difference
between "would it be in the sparse index" and "would it be in the
fully expanded index".  Here, by "tracked" I mean the latter -- "is it
in the fully expanded index".

> A --dry-run option is available to list the directories that would be
> removed without actually deleting the directories.
>
> This option would be preferred to something like 'git clean -dfx' since i=
t
> does not clear the excluded files that are still within the sparse-checko=
ut.

This seems to suggest you are only interested in untracked and ignored
files.  I'm sure that's by far the most common case, but I'm curious
about the others.  Are you expecting users to sometimes need to run
both 'git sparse-checkout clean' and 'git sparse-checkout reapply'?

> Instead, it performs the exact filesystem operations required to refresh =
the
> sparse index performance back to what is expected.

But what operations are those and what is expected?

As you mentioned above, for untracked or ignored files, the
expectation is that those would be removed.

I think if there are tracked-but-unmodified files, I'd expect those to
be removed as well.

If only the above filetypes exist, then we'd expect the directory to
be nuked and sparse index performance to be improved back to "normal".

However, if there are tracked-and-modified files, I'd expect an error
and for the sparse index performance to continue to suffer until those
paths are resolved.  (Or, pie-in-sky spitballing:maybe we could
attempt to do something smarter like make sibling directories to the
tracked-and-modified path be treated as sparse directories, so that
performance only suffers a little).

> I spent a few weeks debating with myself about whether or not this was th=
e
> right interface, so please suggest alternatives if you have better ideas.
> Among my rejected ideas include:
>
>  * 'git sparse-checkout reapply -f -x' or similar augmentations of
>    'reapply'.

The connection to sparse-checkout reapply at least would make it
clearer what you are doing with tracked files, since its explanation
explicitly mentions those.  However, reapply doesn't say anything
about untracked or ignored files, which we'd need to start explaining
and perhaps isn't as clean a fit, especially since your new usecase is
predominantly about untracked and ignored files.  I don't have a
strong opinion here, but I think I also like your choice of a separate
'clean' subcommand better.

>  * 'git clean --sparse' to focus the clean operation on things outside of
>    the sparse-checkout.

Yeah, this choice would have likely prevented you from cleaning up
tracked files, and required users to run both 'clean --sparse' and
'sparse-checkout reapply'.  And this command feels more tightly
connected to sparse-checkouts to me, so I wouldn't have liked this
choice either.

> The implementation is rather simple with the current CLI. Future
> augmentations could include a --quiet option to silence the output and a
> --verbose option to list the files that exist within each directory and
> would/will be removed.

I'm also curious what happens when (1) you are in cone mode and there
is no sparse index, or (2) when you are not in cone mode.  I suspect
those and the questions above will be answered as I read the
individual patches, so I'll keep going...

> Thanks, -Stolee
>
> Derrick Stolee (3):
>   sparse-checkout: remove use of the_repository
>   sparse-checkout: add 'clean' command
>   sparse-index: point users to new 'clean' action
>
>  Documentation/git-sparse-checkout.adoc |  13 +-
>  builtin/sparse-checkout.c              | 192 +++++++++++++++++--------
>  sparse-index.c                         |   3 +-
>  t/t1091-sparse-checkout-builtin.sh     |  48 +++++++
>  4 files changed, 197 insertions(+), 59 deletions(-)
>
>
> base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1941%2F=
derrickstolee%2Fgit-sparse-checkout-clean-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1941/derri=
ckstolee/git-sparse-checkout-clean-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1941
> --
> gitgitgadget
