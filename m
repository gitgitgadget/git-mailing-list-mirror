Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC297278156
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055955; cv=none; b=DAUo58tyd0LxHNL6NshRAd6odhiUWnPvQ5Ky0Xc4vIcwaazBC7kCCapLVJzaEttb+kl9q5w2m2rHriaBmGQxRacbf899apXlgI/9WemXr8X3D4E/F1Q92ZjvD3v6p+I3c8cXwkzL/lK/HT8xVbbwpMMfyTNgYIEExb3so4lywxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055955; c=relaxed/simple;
	bh=+dsToFvhmMMrKGR0ptcySs4pCyMjFn9ZI/USrhGIOrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1xZ5fn4M3megziCdTEZyvWXfdnzt2+1Jy3LMaEvkUB3rTpYYZVu4UwmpaXf1zSQKvDOTR1iYf0zI4DB0FO3VIFWEhq4aYVSh5ty1W9ekPpb9fRbiUyayKpKut3ojeW3HbyxlKBgMvkyCF9bWQfWB6fQcRCAMb4xRX53WNay1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS8vKj6J; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS8vKj6J"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso8350411a12.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758055951; x=1758660751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmebX77UJIwY51bj3Imgroi1fn8NqBgN3q+zu+wgdgE=;
        b=IS8vKj6J7o7SVAcvmHwVvqkpMcVIhubaAizmiExjlJPMJSW7keTCYjhta8FeFbT93o
         jKUFPo/cCLGan4owyRSWtFb8e6KtcJq8u2ZmiS2I+LRqsw4eQcDG6mqNrMMmiFOySdUG
         HQa/AwgDSxQmHZ+t2JlJnhVYbVReAqtf7YcdtTD/6bNEkkTSuvqTGsUMCwB11iqP+p4E
         /SdptxP1bQfp+G6Oq2oH9nYf3owk+ieG/BbwG/mqIMjHsrW9i6g/97YERTZyEBce0J8J
         m8lTnCj03G1CyeO+t6Dxx1c3P6oCceV+3GpWPFk2taUyoE4yBqkahNomRqTrccUAts7P
         SNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758055951; x=1758660751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmebX77UJIwY51bj3Imgroi1fn8NqBgN3q+zu+wgdgE=;
        b=WyzyLk3hJcgTVufG/ZzfexYpGOgSBxRzj/Xt7J3dLPA+nm1Ib3mdEsiQqUF4jofxOx
         GqAlfcOKgeyOtEIsOSho6Ckh+mwmybrYJkV+0vQq6d15tBsVWR8BzDEak459U5gbdSz/
         vEviJzitBFLElJPL1sBqM2oiGHrve5n15hBOBhPdfFLS/f9JfazqQCTr/vRezDjv5EqG
         IvaWInOcdIkO05caksa6QG7ULvVoi1ZnZ87JtZ+7ZU46yuTMZN6WtBLg2J57usAAfYSj
         mGBz/NUugt4t1uB36FIvh4yUZ1TNXymlFlR9bUR4GgEMX79Hhzi8UP8221K37nWnnLXA
         y0yA==
X-Gm-Message-State: AOJu0YzWFh/CtX248nz98/G1+OVmQCCmkWGIdHIFBrQVQd5JinkL6pW5
	CVymMUwMa9PtHnFk5xjESkj5mrV36tVp/XTNU/vYzQY1yrTWLhn92O4JNKNyXE/ALOXhcSt0Dhv
	P1YDGux1n/Rk0jvUPRFrPV10yWX1CzouckRkKUM4=
X-Gm-Gg: ASbGnctIrrMmTSvEwrSExWBaX/cmT610SCQoBdTAQvCzkVjIgNCfJJBfMMz/VEBoUvN
	zZDQEeoxhHK5n5bFmWG9Q/MJ0WpmHHZR8GU0HW6mOUljLC1aOwUOjeizbcrMUnnEsPg16Qn80ve
	v/ZgsEemR2FYVjGY83/RIEcHPwyJLL/V9MKUCbP5hqaK0c7V5RpqgIX7DahygLPIGG/ux2g4UYE
	h/XAr5ASdRWeDalF3aaKjPfZDRYw1odMM0nG8x4SLjQ3gvxe0PB
X-Google-Smtp-Source: AGHT+IGdhLHIHoV9mfgai7dbrLFMjnMzfkWmDO3Kk0YdrAJ13sW7AFOeyCnsESzgNO10WPkxDrXtr7FBcE0ZYz5O9Uo=
X-Received: by 2002:a05:6402:2790:b0:62f:345e:45df with SMTP id
 4fb4d7f45d1cf-62f345e48famr8453276a12.1.1758055950954; Tue, 16 Sep 2025
 13:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
In-Reply-To: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 16 Sep 2025 16:52:17 -0400
X-Gm-Features: AS18NWDKQGpz3ILWmVGk49pAup_KIJYuX3zOXlYVnHCZhdWr4vqmTD85lEf3T7I
Message-ID: <CALnO6CCz6dFX1Est0hhCbvaepBvG4+rpYQRQ2bP5vAQVmaY=OA@mail.gmail.com>
Subject: Re: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
To: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:36=E2=80=AFPM Anselm Sch=C3=BCler <mail@anselmsch=
ueler.com> wrote:
>
> After a new repository has been created, before a commit has been made,
> when files are staged, git-status suggests using git-rm to unstage
> files: $ git status [...] No commits yet Changes to be committed:   (use
> "git rm --cached <file>..." to unstage) [...] After a commit has been
> made, git-status suggests using git-restore instead: $ git status [...]
> Changes to be committed: (use "git restore --staged <file>..." to
> unstage) [...] Why is this the case?

By following builtin/commit.c:cmd_status() to wt-status.c and
searching for "rm --cached" (and then blaming), I found the following
relevant commits:

- 80f537f79c (doc: promote "git restore", 2019-04-25): conversion from
reset to restore
- 4d4d5726ae (status: show worktree status of conflicted paths
separately, 2009-08-05): introduced the is_initial check

Unfortunately the latter does not appear to describe or justify the differe=
nce.

However, a quick test of the kind

    git init foo
    echo a > foo/a && git -C foo add a
    git -C foo restore --staged a

gives

    fatal: could not resolve HEAD

Contrary to Junio's mail about "where to restore from," the following
does work in a non-unborn repo to move "newfile" from "untracked" to
"staged" and back again:

    echo >newfile && git add newfile
    git restore --staged newfile

So we don't need "rm --cached" to

> remove <file>
> from there [the index] without losing or clobbering the <file> in the wor=
king
> tree

(But the point about having nowhere to restore from stands!)

--=20
D. Ben Knoble
