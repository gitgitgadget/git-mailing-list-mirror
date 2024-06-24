Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C51A0AFE
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267187; cv=none; b=QOp8e/y4nMyrkSUeY1N3MiA7izssF74AoeToKTLGkBtx+njkxotVBDJxc3UpIIhNzA003lYParRSIwthuNmz0O94vWZOsbrOQtO42goH1dnn9Jd+L4SY4ER9HPSS+ifBmIJ/9KZ/nyQ9LEzhC+4C7RK1w7+XLVMoMbkM96MlRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267187; c=relaxed/simple;
	bh=Vz/6eQ+7QMGLgeV398dMm29vWv/VSnGvmiFOVOmsvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJ5uCFOBBwN2A4259e3R8tSQ4+M3KwOFQhDGifSMp5Uik+lDcwrKbaZfb6jkV71FbbUeQf/enhv7GH9KG2Mq+ePh6QSpTnPVxZZIwzYQdrJd8Ym/8lBV7BQP1hJvHy3YzhpBzdsqIjwVJhRwfLEo7W5oSQBb2az5ZC96zUiMKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWNxdnk3; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWNxdnk3"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ebdb5d9915so187196739f.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719267185; x=1719871985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XySIZKMp4qnfMZz3wpza8NmtEo9Vs4YkpJPRUlRUWs4=;
        b=CWNxdnk3Cx7w9mRt/65LVSpR7B1cSJwGtmlZLy90N0elorsFJzKguRBH/A/7TAH2/w
         aqFiVKAza9vcUC30cEFgH5vFn9nx+9Hkrt97mjMVp4zVsFsYRLKzGFZ+i8LVIWnFCwcs
         n4RYXfAubmR6XV17QFU2FEN1m4FZjT2u1/FCIuF5FJDyYc3e9ZtGNpkSvpTRsiYfVSwa
         lj1xq1orHXYJ+OlQJ8glaiVVpqiixDOEjjqACqb/6xUgbSCn8x3ZoRYBm0MMKsakhSvG
         ME67kt1UTl+6t7EkFDvN65C5QLTVQw4a0C614Sw6NCO5hG3EI2R+B7i8iLhoJ6tjreGa
         Up+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267185; x=1719871985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XySIZKMp4qnfMZz3wpza8NmtEo9Vs4YkpJPRUlRUWs4=;
        b=gMnAeLH6BxrDX0NwOr4FdavVFAmyRXwws0n22V9gaYqQGe9GwTWcvd11UNZOQoiIGa
         O9UHrQH8CI69elwpohl+kdrwj4JtXlc/VbBpfRB/KpowNCRcYuDntunhMZWqHWWl+y0S
         Mw3ApTM9pW4jdoo3G1ouR/Ul6g/JsxGVRYX4KX6nAZhOQZ5VPXboYYrDvOVzkEUPuplG
         BxMichKsOVs7IjSURC2V4QqAJqVOaRlDhHkQVBvh3BBEEp2iRHsEfaoXDpL3VvHpw1xp
         vw40/Pzw65s857qy1g3YDKhzWOxG3CXkbF0Dd5HOszISbPnNufR2L7wf+5O7F3cSWmsI
         SYyw==
X-Gm-Message-State: AOJu0Yz5tNFSPE/brn47rrYX8u5e2DTxyNHhtPt1lQvsEirjky7g3cmK
	Eg1uREk18i691JknvKY1VduGc+Dtf/V0tXBK76M7dGrOiBJCoW6XUzpNxs8xkurNFjCMBC09nvV
	L35GGpcOpF30XwZGgrD9a6KsQcjc=
X-Google-Smtp-Source: AGHT+IFZcHT85BTjebbX93UWboVCbiHjChXW1XEeyJzwj5/cgvALfQyzA522gW0Lm4/WXyMfqq4/gv5xXbCtJD8zZUI=
X-Received: by 2002:a05:6602:14c2:b0:7eb:6cbc:8856 with SMTP id
 ca18e2360f4ac-7f3a7480881mr714958539f.2.1719267185080; Mon, 24 Jun 2024
 15:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com> <ddd8a9a90cea10be47eba4775bb90f01a9b80443.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <ddd8a9a90cea10be47eba4775bb90f01a9b80443.1718899877.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Jun 2024 15:12:53 -0700
Message-ID: <CABPp-BF=8y2yC0WvF7BhNFiyW10A_yKs5s6euEi3FwYSsmHnWg@mail.gmail.com>
Subject: Re: [PATCH 1/5] sparse-index: refactor skip worktree retry logic
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:11=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The clear_skip_worktree_from_present_files() method was introduced in
> af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files present
> in worktree, 2022-01-14) to help cases where the sparse index is enabled

s/index/checkout/; the code in af6a51875a made no assumptions about
sparse index being enabled.

> but some paths outside of the sparse-checkout cone also exist on disk.

s/cone//; it wasn't specific to cone mode.

> This operation can be slow as it needs to check path existence in a way
> that is not stored in the collapsed index, so caching was introduced in
> d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
> caching, 2022-01-14).

This is worded in a way that seems to imply the code is only relevant
with a sparse index.  Part of the code was written to be faster in
general with a sparse-index, but having a sparse-index was not
assumed.  Perhaps,

This operation could be slow since it needs to check path existence
for the paths outside the sparse checkout, which may vastly outnumber
the number of paths inside the sparse checkout.  To address this,
caching was introduced in d79d299352 (Accelerate
clear_skip_worktree_from_present_files() by caching, 2022-01-14).

> If users are having trouble with the performance of this operation and
> don't care about paths outside of the sparse-checkout cone, they can
> disable them using the sparse.expectFilesOutsideOfPatterns config option
> introduced in ecc7c8841d (repo_read_index: add config to expect files
> outside sparse patterns, 2022-02-25).
>
> Even with that caching, it was noticed that this could take a long time
> to execute. 89aaab11a3 (index: add trace2 region for clear skip
> worktree, 2022-11-03) introduced trace2 regions to measure this time.
> Further, the way the loop repeats itself was slightly confusing and
> prone to breakage, so a BUG() statement was added in 8c7abdc596 (index:
> raise a bug if the index is materialised more than once, 2022-11-03) to
> be sure that the second run of the loop does not hit any sparse trees.
>
> One thing that can be confusing about the current setup is that the
> trace2 regions nest and it is not clear that a second loop is running
> after the index is expanded. Here is an example of what the regions look
> like in a typical case:
>
> | region_enter | ... | label:clear_skip_worktree_from_present_files
> | region_enter | ... | ..label:update
> | region_leave | ... | ..label:update
> | region_enter | ... | ..label:ensure_full_index
> | region_enter | ... | ....label:update
> | region_leave | ... | ....label:update
> | region_leave | ... | ..label:ensure_full_index
> | data         | ... | ..sparse_path_count:1
> | data         | ... | ..sparse_path_count_full:269538
> | region_leave | ... | label:clear_skip_worktree_from_present_files
>
> One thing that is particularly difficult to understand about these
> regions is that most of the time is spent between the close of the
> ensure_full_index region and the reporting of the end data. This is
> because of the restart of the loop being within the same region as the
> first iteration of the loop.
>
> This change refactors the method into two separate methods that are
> traced separately. This will be more important later when we change
> other features of the methods, but for now the only functional change is
> the difference in the structure of the trace regions.
>
> After this change, the same telemetry section is split into three
> distinct chunks:
>
> | region_enter | ... | label:clear_skip_worktree_from_present_files_spars=
e
> | data         | ... | ..sparse_path_count:1
> | region_leave | ... | label:clear_skip_worktree_from_present_files_spars=
e
> | region_enter | ... | label:update
> | region_leave | ... | label:update
> | region_enter | ... | label:ensure_full_index
> | region_enter | ... | ..label:update
> | region_leave | ... | ..label:update
> | region_leave | ... | label:ensure_full_index
> | region_enter | ... | label:clear_skip_worktree_from_present_files_full
> | data         | ... | ..full_path_count:269538
> | region_leave | ... | label:clear_skip_worktree_from_present_files_full
>
> Here, we see the sparse loop terminating early with its first sparse
> path being a sparse directory containing a file. Then, that loop's
> region terminates before ensure_full_index begins (in this case, the
> cache-tree must also be computed). Then, _after_ the index is expanded,
> the full loop begins with its own region.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  sparse-index.c | 77 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 24 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index e48e40cae71..e0457c87fff 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -486,49 +486,78 @@ static int path_found(const char *path, const char =
**dirname, size_t *dir_len,
>         return 0;
>  }
>
> -void clear_skip_worktree_from_present_files(struct index_state *istate)
> +static int clear_skip_worktree_from_present_files_sparse(struct index_st=
ate *istate)
>  {
>         const char *last_dirname =3D NULL;
>         size_t dir_len =3D 0;
>         int dir_found =3D 1;
>
> -       int i;
> -       int path_count[2] =3D {0, 0};
> -       int restarted =3D 0;
> +       int path_count =3D 0;
> +       int to_restart =3D 0;
>
> -       if (!core_apply_sparse_checkout ||
> -           sparse_expect_files_outside_of_patterns)
> -               return;
> -
> -       trace2_region_enter("index", "clear_skip_worktree_from_present_fi=
les",
> +       trace2_region_enter("index", "clear_skip_worktree_from_present_fi=
les_sparse",
>                             istate->repo);
> -restart:
> -       for (i =3D 0; i < istate->cache_nr; i++) {
> +       for (int i =3D 0; i < istate->cache_nr; i++) {
>                 struct cache_entry *ce =3D istate->cache[i];
>
>                 if (ce_skip_worktree(ce)) {
> -                       path_count[restarted]++;
> +                       path_count++;
>                         if (path_found(ce->name, &last_dirname, &dir_len,=
 &dir_found)) {
>                                 if (S_ISSPARSEDIR(ce->ce_mode)) {
> -                                       if (restarted)
> -                                               BUG("ensure-full-index di=
d not fully flatten?");
> -                                       ensure_full_index(istate);
> -                                       restarted =3D 1;
> -                                       goto restart;
> +                                       to_restart =3D 1;
> +                                       break;
>                                 }
>                                 ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
>                         }
>                 }
>         }
>
> -       if (path_count[0])
> -               trace2_data_intmax("index", istate->repo,
> -                                  "sparse_path_count", path_count[0]);
> -       if (restarted)
> -               trace2_data_intmax("index", istate->repo,
> -                                  "sparse_path_count_full", path_count[1=
]);
> -       trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les",
> +       trace2_data_intmax("index", istate->repo,
> +                          "sparse_path_count", path_count);
> +       trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les_sparse",
> +                           istate->repo);
> +       return to_restart;
> +}
> +
> +static void clear_skip_worktree_from_present_files_full(struct index_sta=
te *istate)
> +{
> +       const char *last_dirname =3D NULL;
> +       size_t dir_len =3D 0;
> +       int dir_found =3D 1;
> +
> +       int path_count =3D 0;
> +
> +       trace2_region_enter("index", "clear_skip_worktree_from_present_fi=
les_full",
>                             istate->repo);
> +       for (int i =3D 0; i < istate->cache_nr; i++) {
> +               struct cache_entry *ce =3D istate->cache[i];
> +
> +               if (S_ISSPARSEDIR(ce->ce_mode))
> +                       BUG("ensure-full-index did not fully flatten?");
> +
> +               if (ce_skip_worktree(ce)) {
> +                       path_count++;
> +                       if (path_found(ce->name, &last_dirname, &dir_len,=
 &dir_found))
> +                               ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
> +               }
> +       }
> +
> +       trace2_data_intmax("index", istate->repo,
> +                          "full_path_count", path_count);
> +       trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les_full",
> +                           istate->repo);
> +}
> +
> +void clear_skip_worktree_from_present_files(struct index_state *istate)
> +{
> +       if (!core_apply_sparse_checkout ||
> +           sparse_expect_files_outside_of_patterns)
> +               return;
> +
> +       if (clear_skip_worktree_from_present_files_sparse(istate)) {
> +               ensure_full_index(istate);
> +               clear_skip_worktree_from_present_files_full(istate);
> +       }
>  }
>
>  /*
> --
> gitgitgadget

Although I had a few wording quibbles with the commit message, overall
the commit message was clear about what you were trying to achieve.
Also, the change in this patch is a straightforward splitting of the
old function into three new functions (one of which is the overall
driver calling the other two).
