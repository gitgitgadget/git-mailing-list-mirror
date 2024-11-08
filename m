Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D621C172
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080838; cv=none; b=Y6rCGxkaq7t95FrHTpkCxCDwpx4UpQWpcPVBH1vb1O40duwqcv9aNEFmkzhgBv21AXUwWzFcvKfREBjSWbpA2M5kFxywvVW0qIOuTwVy1EXxm7qrmOROxASLTsaknpFNyylJg9EZpuf2b9d7VHZ5Bb4PDxx0KQVsApf+XCnon6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080838; c=relaxed/simple;
	bh=u54/RKIvg8jtEkzOLyFErMEK1zNe4WnJ2VZkjk3BY3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gygennn9Bv1PeVzHmy2sCqWD3Eq+kWzMQhr2AeISt9bNK1euJJOdC7jJrbHlKZKc4iZdrp3YXktygt9GpeFf7WFDQ5QZBQpODaDyvnKh8BKhyQAtyj6HtqzBA3HYFSDxMqbAENkKgKANB06yaS24ZZhfNod5f9oNqTp5BDtQrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuEtOsKX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuEtOsKX"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ab94452a7so91970839f.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 07:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080836; x=1731685636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNsFxR4FrJ3Pn2rosGWm68rjCnIbiUdvsIbdF/TE0gE=;
        b=VuEtOsKX1WoMHp0r6cM7w9Mrbyur9yIOLH29W4MvxJdF3Gycof1ccU8gZIMZ5s5EdN
         PB3wxoDrTBsdgaAYiOv8oXCugBugkSEm/nzlQfJmdwQgpunxEilOS6gGq+Vnv8xTTfou
         SXMA6SyIksyGY9lDwqypBkC4SU6bO6R1RRt0ibYW2eSyTizEP7deI5uXadbrIIc2XGD+
         wtO47x9aDl8cV3KsFwbo29F4S4hjRGakjto2/ZCHe+TFn59c77pIycdhgKNEvjsUISxm
         0rvLusfmp+xopHsLGR6Le8okKWV5ZDBGQXQMn9khW4GP4wzaAkw42elvEA4BKlST3kc2
         W+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080836; x=1731685636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNsFxR4FrJ3Pn2rosGWm68rjCnIbiUdvsIbdF/TE0gE=;
        b=ji2wDvbdmrYiG55qw+CrrJQtEKAawTTC1AvEMAaA8C+tRBFNbrray5HRRmISNBuJsy
         uvr2lh7gLGks4zBljTSTZGA+DXthJMMuSe/HcgEM+zVdhuLkNqNk0wIosqe31hILztSo
         T9CtRfQS+nL9Ywpec8ElZAfGVp9qNa9IMWnri+2v8292orfFVY+XWSmVGQ8K032YRsZx
         Z7xh4l8dAESMyOU+qokoMbKhi6MV11/OUldtp9NCStctYHSVhVzoNiS1NGaZ3x5df1DJ
         3Uz8dnuKbdtsNIdMJft5ixtAREXnVXCUGInYuPq5+RwZbNe/8skGsCADdACL9SMzsfza
         RmiQ==
X-Gm-Message-State: AOJu0Yze6jPr6gxXs3Y3M2RgBvm25Hgf8C0uT1mvpCGgbhLUKFk+TnQr
	OaXDKW3TkqagqQHIYjmnu54vJCQQNi0ey9ZD02+edn4yQgjtrIXUb2xb75BCDqYp5SJczGDJ8wa
	7Q25Jv9Jo1wGRXcGbo1G+m+rKmCE=
X-Google-Smtp-Source: AGHT+IGGkWjqucO+hTLDzESQc8YSv22epnlrImx0JiTFMUe4PJetW1knoYpokgSIcpEhao6DkSFU0Fyimn3li4+5tHI=
X-Received: by 2002:a05:6602:6c1c:b0:83a:b98e:9240 with SMTP id
 ca18e2360f4ac-83e03386a5bmr372910239f.10.1731080835799; Fri, 08 Nov 2024
 07:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
In-Reply-To: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 8 Nov 2024 07:47:04 -0800
Message-ID: <CABPp-BHauuserYU8t5ybn+ghqRb-c85qwwjLWVe-e5EC8sVVxQ@mail.gmail.com>
Subject: Re: [PATCH] log: --remerge-diff needs to keep around commit parents
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 5:43=E2=80=AFAM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> To show a remerge diff, the merge needs to be recreated. For that to
> work, the merge base(s) need to be found, which means that the commits'
> parents have to be traversed until common ancestors are found (if any).
>
> However, one optimization that hails all the way back to
> cb115748ec0d (Some more memory leak avoidance, 2006-06-17) is to release
> the commit's list of parents immediately after showing it. This can break
> the merge base computation.
>
> Note that it matters more clearly when traversing the commits in
> reverse: In that instance, if a parent of a merge commit has been shown
> as part of the `git log` command, by the time the merge commit's diff
> needs to be computed, that parent commit's list of parent commits will
> have been set to `NULL` and as a result no merge base will be found.
>
> Let's fix this by special-casing the `remerge_diff` mode, similar to
> what we did with reflogs in f35650dff6a4 (log: do not free parents when
> walking reflog, 2017-07-07).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     log: --remerge-diff needs to keep around commit parents
>
>     This fixes a bug that is pretty much as old as the remerge-diff
>     machinery itself. I noticed it while writing my reply to Hannes Sixt'=
s
>     concerns about my range-diff --diff-merges=3D<mode> patch
>     (https://lore.kernel.org/git/af576487-5de2-fba3-b341-3c082322c9ec@gmx=
.de/).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1825%2F=
dscho%2Flog-remerge-diff-needs-commit-parents-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1825/dscho=
/log-remerge-diff-needs-commit-parents-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1825
>
>  builtin/log.c           | 2 +-
>  t/t4069-remerge-diff.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e98..a297c6caf59 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -522,7 +522,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
>                          * but we didn't actually show the commit.
>                          */
>                         rev->max_count++;
> -               if (!rev->reflog_info) {
> +               if (!rev->reflog_info && !rev->remerge_diff) {
>                         /*
>                          * We may show a given commit multiple times when
>                          * walking the reflogs.

Should this comment be updated to reflect the expanded rationale for
this block's purpose?

> diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> index 07323ebafe0..a68c6bfa036 100755
> --- a/t/t4069-remerge-diff.sh
> +++ b/t/t4069-remerge-diff.sh
> @@ -317,4 +317,11 @@ test_expect_success 'remerge-diff turns off history =
simplification' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'remerge-diff with --reverse' '
> +       git log -1 --remerge-diff --oneline ab_resolution^ >expect &&
> +       git log -1 --remerge-diff --oneline ab_resolution >>expect &&
> +       git log -2 --remerge-diff --oneline ab_resolution --reverse >actu=
al &&
> +       test_cmp expect actual
> +'
> +
>  test_done
>
> base-commit: bea9ecd24b0c3bf06cab4a851694fe09e7e51408
> --
> gitgitgadget

Wow, nice find, and I appreciate the nice simple testcase
demonstrating what had been the problem.
