Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DB1DF27F
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709708; cv=none; b=Pvj6tCeR28qfZLYRK/9QW53HvWOdkKXdI6JCmSk64I1SmCliXWyZEDsqtOEx19T2TWD+jRHupTvF0p7IytNLfsE7QK8OsuLrzkZL8d1hP2gw2RW5hj2IVkQavtRVL+f/odmUzZupqf+CUKzwndjBLdkcBLg82RjDDQnWu5YPdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709708; c=relaxed/simple;
	bh=afUZ7uXYugRw+2lFdOOpBXbKM5IaGFVPgyk4m5G8PHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMnYDrYND+jB5aLBWXv5x9ctedIOWGSpzw2vTqxzgSqRJ3+Avbwgt9ffcO8AW1HnptiUUoUeG9kVKG9hlRf7AJwTJElWE9cM3f2e8EZl3/vKE3AMWCBeb+LT0V5q3ClRm6ytg6aEL7GloGnamiOvYDwK72gO28/fVjNusHYcNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNNc68Q7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNNc68Q7"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1947092a12.2
        for <git@vger.kernel.org>; Sun, 09 Nov 2025 09:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762709706; x=1763314506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHrpA4KQjhCtFa2UjssuuUFzdRKjhHQEjsTfs0j+qd8=;
        b=NNNc68Q7OTPlcSs1QoiZn+qJwHId9hH+v95rRFkbHs/e3XWsvB46a7lP0dgTuarNI2
         eLUFpXUu+/ccEWTK8xMiaRUpB1XX6bYFPCBBXKyEcVM7NYstKjiPOTabTHdck3XOj6Dv
         IFIdzPJPTiDXOsT7P9JdM51eWgzDzZVvXjF+6KptiIk1sY8Togzc5bBGSnQP+tyhcsIg
         uJADEEuleryQ/BhoQyDYCtGIwwFBA9SnWnUqGRBhWztve4ulXVZC5dsXe1IOrZAmpWiX
         Kt/Ap94JbFjZUa5xnPpJQS4A8Lz9aNeEe+KZvp2DzOO0C9aHoqCDORx7ec8maoDKHUhM
         s9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762709706; x=1763314506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHrpA4KQjhCtFa2UjssuuUFzdRKjhHQEjsTfs0j+qd8=;
        b=abkCjEk0YiHLCsDekHCCDMFkE5KCvV4vVxqEprl6m7Zx2OJKC5YWDrv8IWCwPgE8Sx
         53y7mJ7TmvkCjNFZTdfHZjmelHn5aPj1+qaHYQ2yCOrI9+sOCBzxKAdJpHS4kvWEBuHN
         PJq3lCasywSJsvH30BXTnPVaqV90i5MOe11ou+I9gCpEEe1+EFWyWOh3q8T817j5+QG/
         tjaJAP+LR2qHVJU0bnzRMcm62cJIV/1S5Q6vMRv5pfPJoB5n6+QMTofoUx0Ls0PT10G5
         HnodfwJxyi1qKTvoC9Q32aY4k1Zt8soTs8Gxtr0ZMB7FqpjFViMS1LdxIfm2pBKrQ8v/
         U5aQ==
X-Gm-Message-State: AOJu0Yw97pilWbVPcJIapmmQShHM6aRZ/HXeMawcdPpWNvlHj6pm/WOA
	Ll/gGPMN8Q8DOm2f8j5cyEO6YgyJSITVA6ewa38SWul0Fax8BV5m6QRhcZVgirkAbwNmgnOygJj
	uoWLb+MHs/CZnaYJgELUAwCjY2tqmogw=
X-Gm-Gg: ASbGnct+I3SCvXLsuVXFqxGuPc14m1Hx3kH7MhgSNhhBEJ0/19mSul42ip3FRh1x3jh
	txES0PS/RN9rugK15vPf735K/s8jEdCEccPbt1wNgr17im7bJUZsjdPCTKY98rVtz37ND7SKT+Q
	uezSsK3yDxoM8znf8EqcQmErIgqBngjI6dCdOzmv9kK597yYIzTdcsQoZPD203HLlwaNWl6oMwt
	VmmQXar1isyfcwoXptZHVTXFn3VQfNqXNYsYXWnmAiyLCWQHki1inTfghx+mAuzwkq/xD/DBQ0a
	IDu7aYU=
X-Google-Smtp-Source: AGHT+IFdC9FXg14ajQZWerw1JWr/dPJG3zR8K4MpIkbYFCAqvwi+fUhd9hw0XRWaB6R7nsTqC8dG6zjnDaZyJjqOqSE=
X-Received: by 2002:a17:902:e78d:b0:295:55f:8ed6 with SMTP id
 d9443c01a7336-297e56b8490mr69103315ad.30.1762709706238; Sun, 09 Nov 2025
 09:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
In-Reply-To: <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 9 Nov 2025 12:34:54 -0500
X-Gm-Features: AWmQ_bkfbIGdc6E7OQottgBAWnYpEk3JKebrgsR6b4huGTpJSQYb9otpmSaCneE
Message-ID: <CALnO6CC+ke1L7T+dO13B0FSjLyJqihKHKZaa-B4dh9guxk7z0Q@mail.gmail.com>
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:43=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Detecting renames and copies improves diff's output.  This effort is
> wasted if we don't show any.  Disable detection in that case.

Indeed. I've confirmed this and v1 both fix the issue, although v2 is
significantly faster (which is great for the intended use in
git-prompt.sh!):

=CE=BB hyperfine -NiP v 1 2 ~/code/git/'buildv{v}/git diff --cached --quiet
--no-ext-diff --find-copies-harder'
Benchmark 1: /home/benknoble/code/git/buildv1/git diff --cached
--quiet --no-ext-diff --find-copies-harder
  Time (mean =C2=B1 =CF=83):      72.0 ms =C2=B1   3.3 ms    [User: 45.2 ms=
, System: 26.2 ms]
  Range (min =E2=80=A6 max):    67.6 ms =E2=80=A6  79.6 ms    42 runs

  Warning: Ignoring non-zero exit code.

Benchmark 2: /home/benknoble/code/git/buildv2/git diff --cached
--quiet --no-ext-diff --find-copies-harder
  Time (mean =C2=B1 =CF=83):      19.9 ms =C2=B1   1.5 ms    [User: 8.9 ms,=
 System: 10.6 ms]
  Range (min =E2=80=A6 max):    16.1 ms =E2=80=A6  24.0 ms    151 runs

  Warning: Ignoring non-zero exit code.

Summary
  /home/benknoble/code/git/buildv2/git diff --cached --quiet
--no-ext-diff --find-copies-harder ran
    3.61 =C2=B1 0.31 times faster than /home/benknoble/code/git/buildv1/git
diff --cached --quiet --no-ext-diff --find-copies-harder

> This actually fixes the error code when using the options --cached,
> --find-copies-harder, --no-ext-diff and --quiet together:
> run_diff_index() indirectly calls diff-lib.c::show_modified(), which
> queues even non-modified entries using diff_change() because we need
> them for copy detection.  diff_change() sets flags.has_changes, though,
> which causes diff_can_quit_early() to declare we're done after seeing
> only the very first entry -- way too soon.

This does describe the behavior I saw, but it seems to me that, if we
have changes, then we ought to be able to quit early for --quiet, no?

So there's some other knock-on effect that causes quitting early to be
wrong here, and I'm not exactly sure what it is (other than the diff
queues being different sizes when we hit relevant parts of
diffcore_std, though it's the working case that has the larger queue).
So I'm having a hard time tying this paragraph to the actual issue
(mostly due to my complete unfamiliarity with the diffing subsystem).

> Using --cached, --find-copies-harder and --quiet together without
> --no-ext-diff was not affected even before, as it causes the flag
> flags.diff_from_contents to be set, which disables the optimization
> in a different way.
>
> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
> Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  diff.c              |  2 ++
>  t/t4007-rename-3.sh | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index a1961526c0..efa8d9773c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4987,6 +4987,8 @@ void diff_setup_done(struct diff_options *options)
>         if (options->flags.quick) {
>                 options->output_format =3D DIFF_FORMAT_NO_OUTPUT;
>                 options->flags.exit_with_status =3D 1;
> +               options->detect_rename =3D 0;
> +               options->flags.find_copies_harder =3D 0;
>         }
>
>         /*
> diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
> index e8faf0dd2e..3fc81bcd76 100755
> --- a/t/t4007-rename-3.sh
> +++ b/t/t4007-rename-3.sh
> @@ -41,6 +41,16 @@ test_expect_success 'copy detection, cached' '
>         compare_diff_raw current expected
>  '
>
> +test_expect_success 'exit code of quiet copy detection' '
> +       test_expect_code 1 \
> +       git diff --quiet --cached --find-copies-harder $tree
> +'
> +
> +test_expect_success 'exit code of quiet copy detection with --no-ext-dif=
f' '
> +       test_expect_code 1 \
> +       git diff --quiet --cached --find-copies-harder --no-ext-diff $tre=
e
> +'
> +
>  # In the tree, there is only path0/COPYING.  In the cache, path0 and
>  # path1 both have COPYING and the latter is a copy of path0/COPYING.
>  # However when we say we care only about path1, we should just see
> --
> 2.51.2

Covering both seems like the right move to me, thanks!

--
D. Ben Knoble
