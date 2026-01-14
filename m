Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0F2D9EC5
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400639; cv=none; b=WBcezzNQbx07vgSMgxrvfN/TYdclWQZTCzQ85dJSl1HnEbQs6TMcSFhSEG1Q11uioG4v/z+0nnvQDu3MExlXPVRKLhuayV6k8uU6QKO7/sCQUG/Y2YZlF5DDtyuPaBYqCGAhSNDtUuqmlXD/ehc+YvDDqKWpSLyFxa2v5bgSPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400639; c=relaxed/simple;
	bh=EUyNW5VM8piuHSMTu94HcVanDpGPup2reyAGBKjPozc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFJuhlg3ri7szFnww7SWuGMuUbu/gHc1xgGn3J45CNJKeCQAIRWXPkluhgSMzjs4bTVwiHLdA6LjbzHCIHR8FJMDZMOGuiAcxGi61STJoVu9Lngo6oPFlbZ6mQ5+lOIuSjJPLUQsD/4UpMjRUMbmvKQCUFKVFWHHkPWgjTN3Yps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGo0gFc2; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGo0gFc2"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6455a60c12bso8396973d50.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 06:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400637; x=1769005437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKzHUzfNLMLYIV2w8XxiekligWS4irqg8WN7FffeK4Q=;
        b=HGo0gFc2AFOALBuk+RJUdydWx425ZkhZA91YcmPtsPIRV27o9drjWvO05lvqmH59tu
         nLK3XuMThKRxRg/wPbjecpfPawh/kZmwXzIr6idlnb11qZLbJSj5+gpR04xIC2ScIDBc
         5oFtzhyRm3yytjZmShQcApXXRkKZMD/TzAPtiodcv1qNKcd550k+oAofNQ7VBuMMZ3/I
         cyfEktXQWkcPGIAEic28MWTTNGZS1ZGgfDKdCShZqyWNGrKEVhtrnES3RyVwgpc/M5CK
         r493daYp1OusTpNimwWcsXXydfj15hLNaGmekFjvIjSIXeaURJBdIDKdXOoilgJnTwgj
         x8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400637; x=1769005437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKzHUzfNLMLYIV2w8XxiekligWS4irqg8WN7FffeK4Q=;
        b=OP1KlMgtY7aF26usQOdDVpCiaRgv1tYwm9JpJkkiHLveCkzHxapBCLcwE5I2oTL9cp
         djVg8T5mzLoug5dGl+rCuPPeXpF/ZUTzxdImdZmhGsaKIcw8PYswaI16+COYHBaHgP8h
         kXMov5k+SzmC289jIjLLPKtZbvsqCe7DQnSCFFY0Y8JIUp2BkT8feAd67ysEntxc9U3o
         9w5MWTuarQFfWwSTIopJqQXY6ONk+JMmZqD68jbVofnCMSBD5JuNK+9ugX7Ye30fDjeJ
         GUMjvJBc1SyWhfTGLHgtOwqEW/gxei8sBbDKe1D74sBtlVvK4KqCdMGOmVBiiwi0hCgk
         2bCw==
X-Gm-Message-State: AOJu0Yz9PCOsmZTopEK6eM7tDRTKGVUo2Xb/JmgL1tAxFJz5wBR9t8Y0
	nBh5ZpPEkwIVvLqtkESnIor8Rtbwb1OIQHXxHaraF6pdOs+QS9RLTDKDxy61r04T7i9XF3aOeoW
	fsl1rddk9blDuhDC5NrEGGBuu4JxjfYM=
X-Gm-Gg: AY/fxX6lVLwtVCpOHcDPfTnyWnF+lD262UCh3mynuewL4nd4W3sv6Umus/1AEF3ejDc
	f7CuT9XDipwn6eDhqhDlKezAC3Q0Q3YWYVNZtw1zB2Ot5uwxlx0Fh5Odld1DZHbFNhkYMCXRTt4
	31J8mEEFB5skwwK+nYy7ahLbvQfgskp69aeb+XIGWy1KKGwSGY3aCWQHsNUQRFqVVD/ToOkvG37
	ozSjbn6wIgVNEre+o7HIOydQxFurZhN6YWEmr3sLKaLQ7SdnIBKcVCunh5gvK+59FQe/b4=
X-Received: by 2002:a05:690e:11ca:b0:63f:b0a3:7400 with SMTP id
 956f58d0204a3-64901b1cf01mr2148622d50.66.1768400636638; Wed, 14 Jan 2026
 06:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113180409.36683-1-amishhhaaaa@gmail.com>
In-Reply-To: <20260113180409.36683-1-amishhhaaaa@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Wed, 14 Jan 2026 19:53:45 +0530
X-Gm-Features: AZwV_Qgbp2A2Sxm7wW1AW-eybR5zFi6s2BmiWF-neZhQqa6lFiLr0DrKcMvFP18
Message-ID: <CALE2CrQFZngj6_NDuf0S=_-nDrrf6b6r=C9jMyEVjwMqvh6J2w@mail.gmail.com>
Subject: Re: [PATCH] t0100: avoid suppressing git exit code
To: amisha <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

Thanks for the patch. This makes sense, since piping into grep was indeed
suppressing the exit status of git cat-file.

One small style suggestion. Most Git tests use the helper instead of raw
grep, so this could be written as:

    git cat-file commit HEAD >actual &&
    test_grep "Merge branch 'other'" actual

This gives nicer diagnostics on failure and is consistent with other
tests.

Other than that, the approach looks good to me.

Thanks,
Pushkar

On Tue, Jan 13, 2026 at 11:34=E2=80=AFPM amisha <amishhhaaaa@gmail.com> wro=
te:
>
> In t0100-previous.sh, the exit code of 'git cat-file' is suppressed by
> piping it directly into grep. If git crashes, the test might not
> notice.
>
> Redirect the output of git to a temporary file 'actual' and grep
> from that file instead. This ensures that the exit code of the
> git command is properly checked.
>
> Signed-off-by: amisha <amishhhaaaa@gmail.com>
> ---
>  t/t0100-previous.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
> index dd5d9b4e5e..ffe3fda495 100755
> --- a/t/t0100-previous.sh
> +++ b/t/t0100-previous.sh
> @@ -40,7 +40,8 @@ test_expect_success 'merge @{-1}' '
>         git checkout other &&
>         git checkout main &&
>         git merge @{-1} &&
> -       git cat-file commit HEAD | grep "Merge branch '\''other'\''"
> +       git cat-file commit HEAD >actual &&
> +       grep "Merge branch '\''other'\''" actual
>  '
>
>  test_expect_success 'merge @{-1}~1' '
> --
> 2.51.0
>
>
