Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90E5FB8A
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058983; cv=none; b=skbwuiKetispjASB9VjgkPHIRXFTdO4/Ko5fxN8WjVDMBnFTiKK6ECS6/g4qVGbCC/yexWBl3AGkMqpAzxDnKQKlw/UMu2KzTx+8qznBCgJNk6kEI39wSTzNqu+TWPcmxM87cxeFyVaoVTIln9eerYmYYnIkDtu04mVzYPUBM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058983; c=relaxed/simple;
	bh=XgOYhs2hKHABQnYu/DOkZ/Hv8WWbzTzJWj0YhcRaTXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2mIeo/CNARB7kD3uJbP5A3iqdAJJKHwLrzsOINHNLOLjHgVuvBx4IVuT34SBL0+BKKeqmcSVUIqNmnTk8vFldEzc0u/l7ZEuxnXsIHcVDMBiM4f0y6Sc3bgJfkOjmq1DKJk781AGklRFu3QLkrsmtotZRsjXUyHxlm3nOrUPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLDoXfx2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLDoXfx2"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so70724511fa.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712058980; x=1712663780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFVvTUaKCuXVLSfWQPF0yvfjpo44kiaiQw6KmZIql/Y=;
        b=iLDoXfx27Ts09jb2cWKAEB2ZBxr8bzFQEHKcbatPwuhJMTocbSZoNWuCV9OHgDDfsX
         t4SkVTRFzlrrzu0yBrAcyxsdDglKQW3edcMuoW3P1peH71kIUTW4HSz1ddAEDMdBtYgq
         vJtxOl2gcAZHqcVq8Zr9MkoAOjIfEX3zHTFpdmPWF/y0pVLJMpe6cH2hkUKfS4iGaSwW
         1EgT8OMPwjeO4DSPyEcoy3RgNumV09qJ9d32uQBFDKqxgQfma59MrI5YCoaDOqNTn+2x
         9cdTLnHUrvK8RoJOQ9RESOFS3NTUmb7id4xcVSWI/wri71Nxag8bx1Uqb4M3M4cf+A1R
         t9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712058980; x=1712663780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFVvTUaKCuXVLSfWQPF0yvfjpo44kiaiQw6KmZIql/Y=;
        b=fcUSRcTDGuIZTuITrVwu9g/Qlq1TATrDiyaeyZBIwcYyuKJPvF3RZNio6fPVp2AjN9
         vCHK7VKGnpZWVUsIudobMMeNZtlJxerhLzu8MfXFkfAE+KW1sJF80BF7bl1f9tyf3v7I
         cEdMgzlcnLLhfLEZeYt0MteLQKzMZwiQVwANkD4nhwv7LxfFutq4mTtjbxbSBPnP+wIK
         2f0Ax1oC0YaITwC3oNS0PhuJ0cyQlFn3G4PqaF/LqBCABgnzfDM0K/Praf1xdDOblYTM
         H2CHPdDqrDjwBHWOA0Dbde0tsCB34FJlI4CHOYHalqAN/gL2ugaqIcqOR3MYQO5WLEvd
         7D/g==
X-Gm-Message-State: AOJu0YxpWHJ0oIEDpg7F1sCtFJ5jU9iuulsJ9bF8bvnbZNTQufVAop6C
	K0yE0GSgWjHjUbVs5AF88RuKiGcAcmFiX8+6NRUBXakv1+2Bjj4fReuQvmgJHcazVjeso5zH9f7
	XvQeJtsoxKa1248dTwqKN6ZTJCrF+1FO/3oijqg2Y
X-Google-Smtp-Source: AGHT+IHu6ynjVRg9Jtz0fzAKNUUhdZNQI9JZeaLaag5bE0jfOK/Uwb+Zv1BiuRYE3rOQyXBsixTv0yf10NVxMNTEM2I=
X-Received: by 2002:a05:651c:1a10:b0:2d8:19fe:4879 with SMTP id
 by16-20020a05651c1a1000b002d819fe4879mr3815327ljb.38.1712058979362; Tue, 02
 Apr 2024 04:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com>
 <ZgvmoSOPs6FG4jGZ@tanuki>
In-Reply-To: <ZgvmoSOPs6FG4jGZ@tanuki>
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Tue, 2 Apr 2024 17:26:12 +0530
Message-ID: <CAHCXyj1JGYP1k0jeT_yoOViGp8T84z9OEpGFdwxAO8k5fBtN5w@mail.gmail.com>
Subject: Re: GSoC 2024 [PATCH v2] Fix Git command exit code suppression in
 test script t2104-update-index-skip-worktree.sh
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git maintainers,

I apologize for the previous patch for
t2104-update-index-skip-worktree.sh. It was overly verbose in the
subject line and rewrote significant portions of the file, making
review difficult. I'm still learning how to write clear and concise
commit messages and reviewing patches effectively.

>We typically don't say things like "This commit", but rather use an
>imperative style ("Address this issue..."). Also, we typically start
>with the problem description before we say how the problem is being
>adddressed.

New Commit Message:
Fix suppressed exit code in t2104-update-index-skip-worktree.sh

This patch addresses an issue in the `test_expect_success 'setup'` test
where the exit code of `git ls-files -t` was being suppressed. This could
lead to the test passing even if the Git command failed.

The change ensures the output is captured in a variable (`actual`) and
the exit code is checked using a separate `if` statement.
Signed-off-by: Aishwarya Narayanan <aishnana.03@gmail.com>

>I assume two things happened:
>- Your patch may have changed line endings. Please make sure that your
>editor writes Unix-style line endings ("\n"), only.
> - You seem to have changed indentation from four spaces to two spaces.

Here's a revised version of the patch that addresses the original issue:
Captures the output of git ls-files -t in a variable (actual) for
proper exit code checking.
Uses test instead of [] for conditionals and maintains consistent
indentation (two spaces) for better readability.
This patch ensures the test correctly verifies the functionality of
git ls-files -t and prevents false positives.
I'm working on improving my patch creation and review skills. Please
let me know if you have any suggestions or require further
clarification.

Thanks,
Aishwarya Narayanan

On Tue, 2 Apr 2024 at 16:36, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Fri, Mar 29, 2024 at 12:17:25AM +0530, Aishwarya Narayanan wrote:
>
> The subject of this mail is not in line with how we typically write
> commit subjects. For one it is overly long, we typically don't want them
> to be longer than 72 characters. Second, commit subjects are expected to
> start with a scope.
>
> > This commit addresses an issue in the `test_expect_success 'setup'` tes=
t
> > where the exit code of `git ls-files -t` was being suppressed. This cou=
ld
> > lead to the test passing even if the Git command failed.
> > The change ensures the output is captured and the exit code is checked
> > correctly.
> > Additionally, the commit message follows recommended coding guidelines
> > by using `test` instead of `[]` for conditionals and proper indentation=
.
>
> We typically don't say things like "This commit", but rather use an
> imperative style ("Address this issue..."). Also, we typically start
> with the problem description before we say how the problem is being
> adddressed.
>
> > Signed-off-by: Aishwarya Narayanan <aishnana.03@gmail.com>
>
> Paragraphs should be separated by an empty line. Most importantly, the
> trailer lines need to be split from the remainder of the body or
> otherwise they won't even be recognized as such.
>
> > ---
> >
> > Dear Git Maintainers,
> >
> > I'm writing to submit a patch that addresses an issue in the test
> > script t2104-update-index-skip-worktree.sh. The issue involves the
> > inadvertent suppression of exit codes from Git commands when used in
> > pipelines. This could potentially lead to false positives in test
> > results, masking actual bugs or regressions.
> >
> > This patch modifies instances of git ls-files -t and similar Git
> > commands used in pipelines to ensure their exit codes are correctly
> > evaluated. It achieves this by:
> > Capturing the command output in a variable.
> > Applying checks for the exit code immediately after command execution.
> > Adjusting related test cases to work with the new method of capturing
> > and evaluating Git command outputs.
> >
> > I've carefully reviewed the Documentation/SubmittingPatches document
> > and ensured the patch adheres to the recommended guidelines. The patch
> > file itself is attached to this email.
> >
> > Thank you for your time and consideration. I welcome any feedback or
> > questions you may have.
> >
> >  t/t2104-update-index-skip-worktree.sh | 98 ++++++++++++++-------------
> >  1 file changed, 52 insertions(+), 46 deletions(-)
> >
> > diff --git a/t/t2104-update-index-skip-worktree.sh
> > b/t/t2104-update-index-skip-worktree.sh
> > index 674d7de3d3..8fdf0e0d82 100755
> > --- a/t/t2104-update-index-skip-worktree.sh
> > +++ b/t/t2104-update-index-skip-worktree.sh
> > @@ -2,67 +2,73 @@
> >  #
> >  # Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
> >  #
> > -test_description=3D'skip-worktree bit test'
> >
> > -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> > -. ./test-lib.sh
> > +test_description=3D'skip-worktree bit test'
> >
> > -sane_unset GIT_TEST_SPLIT_INDEX
> > +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> > +. ./test-lib.sh
> >
> > -test_set_index_version () {
> > -    GIT_INDEX_VERSION=3D"$1"
> > -    export GIT_INDEX_VERSION
> > -}
> > +sane_unset GIT_TEST_SPLIT_INDEX
> >
> > -test_set_index_version 3
> > +test_set_index_version () {
> > +  GIT_INDEX_VERSION=3D"$1"
> > +  export GIT_INDEX_VERSION
> > +}
>
> Sorry, but this patch seems to be completely broken and rewrites almost
> the whole file. It's basically impossible for a reviewer to figure out
> what exactly has changed.
>
> I assume two things happened:
>
>   - Your patch may have changed line endings. Please make sure that your
>     editor writes Unix-style line endings ("\n"), only.
>
>   - You seem to have changed indentation from four spaces to two spaces.
>
> It would be great to pay more attention to such details and review your
> own patches before sending them out to the mailing list.
>
> Patrick
>
> > -cat >expect.full <<EOF
> > -H 1
> > -H 2
> > -H sub/1
> > -H sub/2
> > -EOF
> > +test_set_index_version 3
> >
> > -cat >expect.skip <<EOF
> > -S 1
> > -H 2
> > -S sub/1
> > -H sub/2
> > -EOF
> > +cat >expect.full <<EOF
> > +H 1
> > +H 2
> > +H sub/1
> > +H sub/2
> > +EOF
> > +cat >expect.skip <<EOF
> > +S 1
> > +H 2
> > +S sub/1
> > +H sub/2
> > +EOF
> >
> > +# Good: capture output and check exit code
> >  test_expect_success 'setup' '
> > -   mkdir sub &&
> > -   touch ./1 ./2 sub/1 sub/2 &&
> > -   git add 1 2 sub/1 sub/2 &&
> > -   output=3D$(git ls-files -t)
> > -   echo "$output" | test_cmp expect.full -
> > -   if [ $? -ne 0 ]; then
> > -       exit 1
> > -   fi
> > +  mkdir sub &&
> > +  touch ./1 ./2 sub/1 sub/2 &&
> > +  git add 1 2 sub/1 sub/2 &&
> > +  git ls-files -t >actual &&
> > +  test_cmp expect.full actual
> >  '
> >
> > +test_expect_success 'index is at version 2' '
> > +  test "$(git update-index --show-index-version)" =3D 2
> > +'
> > +
> > +# Good: pipe only after Git command
> >  test_expect_success 'update-index --skip-worktree' '
> > -   git update-index --skip-worktree 1 sub/1 &&
> > -   output=3D$(git ls-files -t)
> > -   echo "$output" | test_cmp expect.skip -
> > -   if [ $? -ne 0 ]; then
> > -       exit 1
> > -   fi
> > +  git update-index --skip-worktree 1 sub/1 &&
> > +  git ls-files -t | test_cmp expect.skip -
> > +'
> > +
> > +test_expect_success 'index is at version 3 after having some
> > skip-worktree entries' '
> > +  test "$(git update-index --show-index-version)" =3D 3
> >  '
> >
> >  test_expect_success 'ls-files -t' '
> > -   output=3D$(git ls-files -t)
> > -   echo "$output" | test_cmp expect.skip -
> > -   if [ $? -ne 0 ]; then
> > -       exit 1
> > -   fi
> > +  git ls-files -t | test_cmp expect.skip -
> >  '
> >
> > +# Good: separate command for exit code check
> >  test_expect_success 'update-index --no-skip-worktree' '
> > -   git update-index --no-skip-worktree 1 sub/1 &&
> > -   output=3D$(git ls-files -t)
> > -   echo "$output" | test_cmp expect.full -
> > -   if [ $? -ne 0 ]; then
> > -       exit 1
> > -   fi
> > +  git update-index --no-skip-worktree 1 sub/1
> > +  if [ $? -ne 0 ]; then
> > +    echo "Failed to update-index --no-skip-worktree"
> > +    exit 1
> > +  fi
> > +  git ls-files -t | test_cmp expect.full -
> >  '
> > +
> > +test_expect_success 'index version is back to 2 when there is no
> > skip-worktree entry' '
> > +  test "$(git update-index --show-index-version)" =3D 2
> > +'
> > +
> > +test_done
> > --
> > Sincerely,
> > Aishwarya Narayanan
> >
