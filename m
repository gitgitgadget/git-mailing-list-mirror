Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380BAD2F
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738502305; cv=none; b=IrH2Epwa5Gh1HaLPA0Fjfyo9InPa3cGtjW1AFyLtmF12BMHNvd4dm0xkyv7lumQI/SasGMdcypgPrgA56zv//Ioqe/jtaZDtbEVCJAKAOENFh9eNiC5M5HbgLht9C6zg++Jh2fWbgg9J78dJ4ru4yTlfSHD8uSUNB8oSuQYCM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738502305; c=relaxed/simple;
	bh=zLLNOmrxlylzrqqkCJIV6pPEhLtKu8fevEqFtwpPn+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOsGWNbZN8YbSyr3Wmciav2JmPIcd3BKu36zfDXkl2jdUHq0gEpjwfOYO26hvCxKn65pPApgYRYwvaLs09k7Fhhxte0DPEA2N5NhK7rtZI52RrnOlLUSuTBcSnrK/fLojyhxlMEFHCeYtevG+kDQEiPNH2n951zgF30GY/xobmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfdlmzMW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfdlmzMW"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-305d843d925so28369231fa.2
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 05:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738502302; x=1739107102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YBqxfs6UKh2grftfVT1hmWrlTuVTQWIO/sjAwaZm2o=;
        b=AfdlmzMWjV4kKkH0qRw5sbMC9cyo2c5vVlixuGXh+Yu+/eM9v3tYhrJLy6fQx+VRAL
         Hk/KlsBwcOM3Z2h4mNepm4TtDxDtA9fLi+K7M1CZjLKoNbegzKbjSSV08XyQPL/p35Gf
         +OcjGP09LShlurdgjyhyrCOYRBKH2pbEogGH1qAysdglwXcdsTGVJNm9yiOfP2+7SrlG
         NT05hru5Yx/lT5lQbXd09O+j2urPQCujs5DyMBdynmIxRR2vMkE6VmeJJ+G2gwidHQYU
         IB0bfXDRwHx0UbllaoBK1I4mo3H9FeAEe6iLbusa9bB2U5VPSxCD0NK5YqX0rEIs9CCy
         GFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738502302; x=1739107102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YBqxfs6UKh2grftfVT1hmWrlTuVTQWIO/sjAwaZm2o=;
        b=LNh7KeObvVD3qjCST4sObqmXyTqDZYJE30eJw3pR9qt9vod1FJOa1FEW/DtdZKb+i2
         3EkPObLBK/5ZmLUSljpP/HPnk3SIJbWC1UU0rS6tl/xUzjyMJnuMD9F250YymohdRVzz
         b0mxZmtVhlEt9uhvAzXRNdnzGSjXig+/zWG+ve7/lrWpDhUaDTmwgzwT1EHMe0b3O0Lp
         2OA16Wmk/hFjd47HKmuH0XJuWY5Rm88PPA4cyMNaFt7diS/aDBQwanGuKPGRPq3GQSf5
         w6UlnwvpnZhlEFVX3VWQqxaeoAIlhGPiS97Ckjn4XFPWV8WSGtKbfRdeRWmGSkLuLDuE
         tsUQ==
X-Gm-Message-State: AOJu0YyV0HQ0L0w6QpwJOFeRzKSf2Ub3eJixUNABlbpJ673wucYqXwZM
	5USbE7iX8qpPeksBrFjO8Ze8632FBwDUkuv0JjYiR57JXpXJ/n7Y7I9nDgzRzFiTLek3oUE7sLa
	RUPzAZ6HMNyhRGwdLJTz4+1EgegE/6dB6CA4=
X-Gm-Gg: ASbGncsNbsHj/ZCJCKcjCTNKRjls7h+pF4LVb5psGdWGCThnJX3kVGyh3BxgPvGPszm
	/d0zgVooSsJFfqtp+ti1yDJzHi/+MgjdsYP6kU0+yECe0Qqd80vzLTY9jrv9LKRAyhWhALvIrrN
	U=
X-Google-Smtp-Source: AGHT+IEMd17kb2tBu/AHuiStZjAvp1qkjFqam6ETN3on+LWRUnXh3WiiZMNPhO/QZYyDeGAnq1TLgB0i94Bx6E3VU28=
X-Received: by 2002:a05:651c:1993:b0:302:3ff6:c8c6 with SMTP id
 38308e7fff4ca-307968fca8dmr63675151fa.33.1738502301736; Sun, 02 Feb 2025
 05:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202120926.322417-1-ayu.chandekar@gmail.com>
In-Reply-To: <20250202120926.322417-1-ayu.chandekar@gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Sun, 2 Feb 2025 18:48:10 +0530
X-Gm-Features: AWEUYZlKw3wTh2WdsALd3wvVVkz_LM4f__g_YclKBtrazFRr3p_0LRbHLl0L6tg
Message-ID: <CAPhwyn2qeN_tZOEyhD6=TLEdQbcCEV1thxpDwNzApqaET0+5og@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_t6423=3A_fix_suppression_of_Git=E2=80=99s_exit_c?=
	=?UTF-8?Q?ode_in_tests?=
To: ayu-ch <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, =gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Feb 2025 at 17:40, ayu-ch <ayu.chandekar@gmail.com> wrote:
>
> From: Ayush Chandekar <ayu.chandekar@gmail.com>
>
> Some test in t6423 supress Git's exit code, which can cause test
s/supress/suppress
> failures go unnoticed. Specifically using git <subcommand> |
> <other-command> masks potential failures of the Git command.
>
> This commit ensures that Git's exit status is correctly propogated by:
> - Avoiding pipes that suppress exit codes.
s/propogated/propagated
The commit message should be in imperative mood (cf.
Documentation/SubmittingPatches)
>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
>  t/t6423-merge-rename-directories.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-d=
irectories.sh
> index 88d1cf2cde..94080c65d1 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -5071,7 +5071,8 @@ test_expect_success '12i: Directory rename causes r=
ename-to-self' '
>                 test_path_is_file source/bar &&
>                 test_path_is_file source/baz &&
>
> -               git ls-files | uniq >tracked &&
> +               git ls-files >actual &&
> +               uniq <actual >tracked &&
>                 test_line_count =3D 3 tracked &&
>
>                 git status --porcelain -uno >actual &&
> @@ -5129,7 +5130,8 @@ test_expect_success '12j: Directory rename to root =
causes rename-to-self' '
>                 test_path_is_file bar &&
>                 test_path_is_file baz &&
>
> -               git ls-files | uniq >tracked &&
> +               git ls-files >actual &&
> +               uniq <actual >tracked &&
>                 test_line_count =3D 3 tracked &&
>
>                 git status --porcelain -uno >actual &&
> @@ -5187,7 +5189,8 @@ test_expect_success '12k: Directory rename with sib=
ling causes rename-to-self' '
>                 test_path_is_file dirA/bar &&
>                 test_path_is_file dirA/baz &&
>
> -               git ls-files | uniq >tracked &&
> +               git ls-files >actual &&
> +               uniq <actual >tracked &&
>                 test_line_count =3D 3 tracked &&
>
>                 git status --porcelain -uno >actual &&
> --
> 2.48.GIT
>
>
It should=E2=80=99ve been v2 of the patch you sent earlier [1] (cf.
Documentation/MyFirstConribution),
but otherwise, it looks good.
[1]: https://lore.kernel.org/git/20250201004556.930220-1-ayu.chandekar@gmai=
l.com/

Meet
