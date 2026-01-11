Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5820DD48
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768143016; cv=none; b=eqEO6+i7y617vaEEulpRPAKlOnF3tbvNx+/GvJlqekapdfQxrkgC6rPITmQ1oA1eDxkzUlSnFyrbT2nfprYoGC+fvjFgnuFBK/LlcnImZeiFNOh4Aqavph8VEefrMQPrALYfhADRaj8XhljiVhOvo0TxPppyKhZdBVEi7Jk8GCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768143016; c=relaxed/simple;
	bh=pdzYjm8wQ7YIi7pBS2uPOQzWKROwq/YIX9aX0dFSAZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kp3GyZCSQxTnplN4/9oz8oLsTU+cIh/htcpP9flLgavQLymXIeW41rNKufR7DyAIzS41MfIoWWclYhXBNfbwm2CvbxDJBTG/Zv9UPFf/8W4E38rW9v/qjDh+DD2/DyH8W6Iptss6oT4HNDu6Ag4uD/9+7v6yadmA/BhqtTX2IUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBX1YH6u; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBX1YH6u"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-644795bf5feso5757521d50.2
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768143014; x=1768747814; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHDIGtK0JnN+W84QKQmHwyth4JwWSvJNecqYY7dvqeE=;
        b=WBX1YH6u05MOW48r/AGUSvGy+TPuUcFdyRfWcoZrGUI5BAE0CP7vozQUKpAIAsUqo4
         fSTAGWcvaNxnR9NAVigiCKIuE/K0c2hQGbhcflA39fcpky0emJKeHzJLAIcnuiSf9naV
         S2sd71PJ/x2q/XIiij0MRm7JcObRyQwDUWQ0kg0sJL0FIw1Zf/9uD5gwnrIpKSixQyGH
         cgeH5D881YHagknXRa7jPX04iXmYyJs+aiyxD058FKTGAHmA1aAc+9jJs8qyUkZepuSh
         /w5ncBHJavW66LkcdiwnDZjJzPSmHST3KjrjS6Z3AX3JazvVeyWQBVV7GpHmry4R2uMS
         /mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768143014; x=1768747814;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHDIGtK0JnN+W84QKQmHwyth4JwWSvJNecqYY7dvqeE=;
        b=pYO/Py7fnFllpg9RhedPA01JCGRdn92ByCyG6QKP9Co2V/vTUSjDwu06YUrPR0d3Yj
         +b/fofLU0a+41bLsrMXYM9XMqVJeuWzOjTv1aQ9aQVTFVQbRy5ertGQ9cAeshiLFODFV
         DiZRCQODAWF5I2eNbV2vi0wRocgTweTJ8t4iA9sFzB7qc1Y0db+BoAb7dyDSszeQwV82
         CuN5UHH8kobphqjVvpu/4C64PSll80NMXvGQ3YFtpzAOBJCVi7WihayjuRBAtk55O6oV
         IrYOoChWsh6MbKLJWyMTchM/hNNJJFVYJczsT01eoF+Ok+5ZrICvjBFDynR7BKNtXd+4
         upRw==
X-Gm-Message-State: AOJu0YzhEp60wxouItJo5xxI0mDy0pzvIBK7W9z4POuzz3PhfE1Q1YB4
	wKbKmxgcd8wkveOdXq+i28dj020YAWJpmuQrZkNLVdRMi116RcHhoVRAnI8g0TCv9i4/CFaGCXX
	h7VEUBD6uyU7tIuNh2imJhZNj+73A35vYah30U1U=
X-Gm-Gg: AY/fxX7wTeHygVOurotfZ7arMV95z1IXejjua53lP6ZS6QZ2Ev1C2LbURa1mvDWEleO
	hTnLaJEtTVyAQL/sTmcxRbSm9mxC6TRLv5+vICurN5epWtIuphzVFS874HK0zljhxoT5Gwla6v9
	DILNUTBywfdjJazDUrm1tnEYUDCgh8qFLSUZCRR5zLWe9JCltVl6gw+Jdt/vs/4+AMY3CaiSpl4
	yINhOBpT3AW97EDCYXzhmNM83QZkcTQs8DvmH3w5u1XqO8FI7Ab28NKO9IxngJCi9cAgRRXQ7iz
	H/uvbA==
X-Google-Smtp-Source: AGHT+IFL3TQn+dTkOsclqxfh5gY3J61EFDuXm0BJLF+F3YWnffXXVgr57gTZAm26PKEF6YY9Qs8qxfN64QXL1J4A+pI=
X-Received: by 2002:a53:b482:0:b0:640:e6aa:b2bf with SMTP id
 956f58d0204a3-64716bd7729mr10154707d50.43.1768143014387; Sun, 11 Jan 2026
 06:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111143928.37604-1-pushkarkumarsingh1970@gmail.com>
In-Reply-To: <20260111143928.37604-1-pushkarkumarsingh1970@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sun, 11 Jan 2026 20:20:03 +0530
X-Gm-Features: AZwV_QjDSddlgOsx0XJBxQYXiVjPEJgYu0d297NQ0XasUv4tOkYPv03lsqH7E2U
Message-ID: <CALE2CrRJdNVVc+f5RR4yXBgsuYfGXSPaHUAA3qyLrkM3Met6wA@mail.gmail.com>
Subject: Re: [PATCH] t1420: use test helpers for lost-found checks
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I noticed that this test is already being worked on and reviewed in
another thread. I=E2=80=99ll drop this patch to avoid duplication.

Thanks,
Pushkar

On Sun, Jan 11, 2026 at 8:09=E2=80=AFPM Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> The lost-found test used raw `test -f` and `ls | wc -l` checks.
> Replace them with `test_path_is_file` and `test_line_count` to provide
> clearer failure diagnostics and keep the test consistent with the
> rest of the test suite.
>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  t/t1420-lost-found.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
> index 2fb2f44f02..da1e48d35e 100755
> --- a/t/t1420-lost-found.sh
> +++ b/t/t1420-lost-found.sh
> @@ -28,9 +28,10 @@ test_expect_success 'lost and found something' '
>         test_tick &&
>         git reset --hard HEAD^ &&
>         git fsck --lost-found &&
> -       test 2 =3D $(ls .git/lost-found/*/* | wc -l) &&
> -       test -f .git/lost-found/commit/$(cat lost-commit) &&
> -       test -f .git/lost-found/other/$(cat lost-other)
> +       ls .git/lost-found/*/* >actual &&
> +       test_line_count =3D 2 actual &&
> +       test_path_is_file .git/lost-found/commit/$(cat lost-commit) &&
> +       test_path_is_file .git/lost-found/other/$(cat lost-other)
>  '
>
>  test_done
> --
> 2.43.0
>
