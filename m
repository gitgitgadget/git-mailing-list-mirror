Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E53590C6
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957877; cv=none; b=tIencnbgQu2oxyqgQk20phC8DD55jLPqIWIFwo5++DXxU/JCmeJ/2RTPYUWg5/RNLt+2tsRSRTcmTvv5bGA6kinquFRuIQjiUe6+t8mxPye9IirG8QdxP2O01pwePJ2eNZjcUqm66jI946bKfPPNjCV9z1gz2Jaic5y+XPJHauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957877; c=relaxed/simple;
	bh=PtHY02LGiu84JdrVjQMw3YaLqNaUKdhWw3Ii0+RojSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWNP4grkXQD29Tb/TULMpeavy7xD+zjVnzXtAOBzCll7RN3JmlaZ3xrTDPDM+PXf0WacvK1fpuUEkjAUcNBQLnpQ0Od8CB+mEB3V4gXXcVdb5KwHbHthlui8CEbIKthnL9SHrcPMHE1Nx5waDVUmiMl4dICV1J7pHpCvuFJbePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6VM2pAG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6VM2pAG"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78fc7893c93so41604217b3.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 03:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767957866; x=1768562666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoZoU1OcizoK8o0KezkIe/JKPfLHx47fP8AM/0rDbo0=;
        b=O6VM2pAGhliCY+bCsURJtVmmxeAC+D0LILuAdCwhmtIneqXooIIhpeu1H21z1NsHXJ
         rfoZRhXkHRmtn7N42qN3K3CyWCmEHV47kUn/R315hdgz9AeXieWE4nonZtdczffuoJFQ
         zOcYiDT6iLKqD1DJqgVToJvB5yLVQRdeoZhdKuKRSOUNFcLM7AMimvZDfGuZnk6XWuVj
         lFIVz2xYS4czYk2Y4PK+DyMiT0MmRQ2aSRdeehQki3Rwk8VazW+qmajNCQwPZt4diAPg
         CFYKdUsM601LeOSL8gpTAIIbYsGmgaooSa6p+sNRoH/tv2RycbhQWz8+w9wSc+2Fxm5w
         5jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957866; x=1768562666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MoZoU1OcizoK8o0KezkIe/JKPfLHx47fP8AM/0rDbo0=;
        b=OoenY1/GuX9MdPr2zO73uBm5txrtqx5i45nsgygoAQaRJEbbLFJuOLMy5r8a5ymo+X
         VKlW0fIX2n0Sr15xKeD0kujPrfqQ+MLyDEBSd7mmMvOhqri5tjiM5o8paxMBeiN8lDu9
         ZDJFVCPLfg3U9hNpJ2+Fsh1Qy8RgU22BBzf7pkWHBfOEaK48jVmEoXqSqS+G4PtzSjJi
         3DUwW29Es/TMbavdM1ErFca4c+AUChbLGv2pLkz04VwMwqKZgdHcEGAVqToclfKst14H
         qTIKnbr1DKtKzqRc42BqhyFL1JaJssZMPoII2YG4utUl5KoJjZon1n867nLJM5E/06F3
         YJIA==
X-Gm-Message-State: AOJu0Yylqer/CHxnXbVwc5tAvMy8w6ZzAOT6RnXKtLCIARftGcupJWzy
	TkNQzDh08TDgHcnAjQTBR7T3yGe9nE6UigO5s1wbNHiTHHtvaJm5rf6dZ3ue10SJ9slzFImE7Oe
	W/exA3y/IKUdEoYKaSVOkoDIQDrLFNBo=
X-Gm-Gg: AY/fxX5nEt3E8tclYlsMopoAyTGFl84nBWECdSjhCVuXWyUO2KnYjVxTm4fIW4LBMXY
	IXxl+IKN90HfdZqoeBuOmvthJnimGJYAMfFUETbOB5Jv6VyT458U49fFZrplILO572mFYIXZrwH
	B9e7ZXIg22vWkzR4GdRo57wYnrlLNVmcesU2sFjG6oNVDzl+xv9rOlB9qfwFn9WqE2UI38xeQTc
	N7kswa6vJM8Z3PL87m/IQByuTuAW+/ym3J520gRbWu6euXOwMkdiIe0CaD2zNG0UPWzV5E=
X-Google-Smtp-Source: AGHT+IEkxr/cRG0x7j/hjksw3AO1DrwV8CZb9Gq8AtakakU3qXYxXuNfRvpbKiWrj7pgUjdII3uDx+4F3qFYPfwJ/3c=
X-Received: by 2002:a05:690e:11c9:b0:63e:30e1:4429 with SMTP id
 956f58d0204a3-64716bbddedmr7578389d50.38.1767957866306; Fri, 09 Jan 2026
 03:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109032027.68680-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20260109032027.68680-1-jayatheerthkulkarni2005@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Fri, 9 Jan 2026 16:54:14 +0530
X-Gm-Features: AQt7F2rKXm1jd-O-ciWTcC00WeKxolig5sfqx_-O47dVSANyHHA8HxHgXWctA-s
Message-ID: <CALE2CrS0Q2NS1DbFv4pyRQsuypu=KH6Kurs=m4yWrFbR9QosoA@mail.gmail.com>
Subject: Re: [GSoC] t7101: modernize test path checks
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jayatheerth,

Thanks for working on modernizing this test. Using the test_path_* helpers
is definitely the right direction and makes failures much easier to
diagnose.

I went through the patch and the conversions look correct:

- test -d path0        -> test_path_is_dir path0
- test -f path0/COPYING -> test_path_is_file path0/COPYING
- ! test -f =E2=80=A6          -> test_path_is_missing =E2=80=A6

all preserve the original intent of the checks while improving diagnostics.

The small cleanups are also helpful:
- Fixing the duplicated =E2=80=9Cchecking=E2=80=9D in the test description.
- Correcting the path from path1/COPYING-TOO to path0/COPYING-TOO so it
  matches the actual tree being tested.

I don=E2=80=99t see any semantic changes introduced here; this looks like a=
 clean
and safe modernization of the test.

Thanks for the patch.

Pushkar

On Fri, Jan 9, 2026 at 8:52=E2=80=AFAM K Jayatheerth
<jayatheerthkulkarni2005@gmail.com> wrote:
>
> Replace old-style `test -[df]` and `! test -[df]` assertions with
> the modern `test_path_is_file`, `test_path_is_dir`, and
> `test_path_is_missing` helpers.
>
> These helpers provide more informative error messages in case of
> failure (e.g., "File 'foo' is missing" instead of just exit code 1).
>
> While at it, fix a typo and an incorrect path
> reference in one of the test descriptions.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  t/t7101-reset-empty-subdirs.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs=
.sh
> index 33d5d5b76e..d1d3e231fc 100755
> --- a/t/t7101-reset-empty-subdirs.sh
> +++ b/t/t7101-reset-empty-subdirs.sh
> @@ -34,32 +34,32 @@ test_expect_success 'resetting tree HEAD^' '
>  '
>
>  test_expect_success 'checking initial files exist after rewind' '
> -       test -d path0 &&
> -       test -f path0/COPYING
> +       test_path_is_dir path0 &&
> +       test_path_is_file path0/COPYING
>  '
>
>  test_expect_success 'checking lack of path1/path2/COPYING' '
> -       ! test -f path1/path2/COPYING
> +       test_path_is_missing path1/path2/COPYING
>  '
>
>  test_expect_success 'checking lack of path1/COPYING' '
> -       ! test -f path1/COPYING
> +       test_path_is_missing path1/COPYING
>  '
>
>  test_expect_success 'checking lack of COPYING' '
> -       ! test -f COPYING
> +       test_path_is_missing COPYING
>  '
>
> -test_expect_success 'checking checking lack of path1/COPYING-TOO' '
> -       ! test -f path0/COPYING-TOO
> +test_expect_success 'checking lack of path0/COPYING-TOO' '
> +       test_path_is_missing path0/COPYING-TOO
>  '
>
>  test_expect_success 'checking lack of path1/path2' '
> -       ! test -d path1/path2
> +       test_path_is_missing path1/path2
>  '
>
>  test_expect_success 'checking lack of path1' '
> -       ! test -d path1
> +       test_path_is_missing path1
>  '
>
>  test_done
> --
> 2.52.0
>
>
