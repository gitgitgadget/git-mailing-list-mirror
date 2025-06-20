Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B831236445
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406805; cv=none; b=FkMRUcrnwXbRmAs8uybxU3JXmvy4rSM0Ux4jkNMMic22+OiO+w2YgRzTFzwruk6SR4UN2Dn0kdLKvNYT5a122skC/zgFvUPCykl4FY+h+vE9G6XTT1JCgpD+MQiDmZ7+8ymPjA/58PjnvTUAQPpWktHF3/gqcNVpHjbtkhb6/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406805; c=relaxed/simple;
	bh=Ja1bG0UTgssfHVUnJR+D7iVp6jSkLNEfkK2tJ2AoSfQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0urSx+CBD/+qtUKmrdcAQosTsq0W1RXsEFr/sKODrjXiy/XRvV3G/gp2AjsSBByMYEkPDaUDAaihojAZXFmPuA/L/YVVDMIp2i5zFopK5iuwk1pobKhhd0eMmeKWPcEAJ3CqbVy9Uto2ayxxnVSsUM7HwCVZ6c4EvQxQh4Z+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqRtrUSf; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqRtrUSf"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-52d9a275c27so1305216e0c.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750406802; x=1751011602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cyU1eGz/vSOiEhC5QLgfWhB3rwCrDXigC0s8UHU1fk=;
        b=KqRtrUSfabyPopbt+I4xJ+6oyZtxG9NQqLaKdpfbmbtZdI+0sVPP3XQQ9BPjpeqx5b
         7Ug0Kk8lh/EucE/Afd/k6KrOwhtui8IepCZJIJGej1UXghq3yG7rSXodX7x1O0SM1PSU
         Eu9gT5J6BD7JCDXuVdBHC8rbCe2rPMklKU8mh+5USPeWmC4pPZ38JYHhIX1tsda40B/K
         6/kQfmnitAOm1bUmauEYRGM9TuuCmgtBj93ODMXnfnyDLR4GaRbiGfDpwKakhGRWJx78
         OK72WiwCh2jP3KNPB474opA1olxnWT4SoB65DPVxADTc8OSY/37W6tkcvyv/w0e05sah
         iaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750406802; x=1751011602;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cyU1eGz/vSOiEhC5QLgfWhB3rwCrDXigC0s8UHU1fk=;
        b=hmvzDdsRdpbJZiCHhTC50yCxuOluyOR6+zvqBknQqe/ekVxSf56ypQ27TmSE0ArELL
         w4RgPkxTujEOSnQQFRpPvhgvKBesyPQLXGZ4fTAZ5tHZYzMirsG8Js7DXwKDkT8eFcln
         Kk0QQz0/9aSEUcqqhBbXnDEhonrK68PMs3s3fPwPzgQQi8FpHIy6M34N9G46iH4p+KRZ
         0UJ5O72pQacJxsUXTnPsQbl5L2UdLRoiC+AJ+t1+KBXwtsvlE9VAn8lt2sXh+9Ss6EMN
         qVypvg3XgJZY+/ko6tmiR1Tv9pKfQmX0Rm0RcW4yR/Q1OF+dy+Se8xSMJ/jHdw1AbsXN
         gPAA==
X-Forwarded-Encrypted: i=1; AJvYcCWTbqVb10eCLK37Um4K84whQmyRWFJ9E6YHrWAg+0YlF+7K6fPmf48QdhAEEM/VlHpXUv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDZP2cOxpl3Q3pWR1E0IFg8Rr6DzfyspQU9z4T0I/2aKw0OnI
	hNfuAV5psgMwLPXtXastzlPYH7nTgz+GtGYBnwP6XSEw/hZgum79333k8yv0+ZZhRiokDIVH8af
	cHdmRjy99TUYZlla3etvokdv/h2R6oQM=
X-Gm-Gg: ASbGnctq29/DyUALFb8vaPR/bbNy2fIY42di1wqnVX3UrSHVxRVW+HFKmpRliJJiFha
	83Ov5DMx4uRBmFOzVxCROsH+iEvCrW8RAoFRZtNxHmoY7fhZ4z53vrU29vnBUX+P4Gwi5yfYETl
	bqjQQmFZxhoqUARdeU5aZs73HVxiw10mxU3iF8PWRy
X-Google-Smtp-Source: AGHT+IH3NViF4WJsuNUiv5f4yno1LQrOl7bM/2sUni+nWWLeiPP5/mVjnnlBGDz/MVKKQspCKBlNsbSolqSeN1iwPvM=
X-Received: by 2002:a05:6122:2517:b0:531:236f:1283 with SMTP id
 71dfb90a1353d-531ad823953mr809543e0c.10.1750406802258; Fri, 20 Jun 2025
 01:06:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Jun 2025 01:06:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250619225751.99699-3-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com> <20250619225751.99699-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Jun 2025 01:06:41 -0700
X-Gm-Features: Ac12FXx9y5sjivxUITduzolKqD5JC8oLguP8sIkN0xso9RXcpEf7x5eOxmg3CUA
Message-ID: <CAOLa=ZT=rwejgefvQcxwLBUS3ExoO_G_r0ruBoQZWKDR-LfzvQ@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2 2/7] repo-info: add the --format flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, ben.knoble@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000a95c0a0637fc5720"

--000000000000a95c0a0637fc5720
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the --format flag to the repo-info command, allowing the user to
> choose between output formats. Use 'json' by default.

Similarly here, it would be nice to mention why we add 'json' formatting
and why it is the default.

[snip]

> diff --git a/t/meson.build b/t/meson.build
> index 50e89e764a..d9ecaba3b7 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -246,6 +246,7 @@ integration_tests = [
>    't1700-split-index.sh',
>    't1701-racy-split-index.sh',
>    't1800-hook.sh',
> +  't1900-repo-info.sh',
>    't2000-conflict-when-checking-files-out.sh',
>    't2002-checkout-cache-u.sh',
>    't2003-checkout-cache-mkdir.sh',
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> new file mode 100755
> index 0000000000..f634e1a285
> --- /dev/null
> +++ b/t/t1900-repo-info.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +parse_json () {
> +	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
> +}
> +
> +test_lazy_prereq PERLJSON '
> +	perl -MJSON -e "exit 0"
> +'
> +
> +test_expect_success PERLJSON 'json: returns empty output with allow-empty' '

Huh. Where is allow-empty being used? and why in this patch?

> +	git repo-info --format=json >output &&
> +	test_line_count = 2 output
> +'
>

--000000000000a95c0a0637fc5720
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be29f3b0a717161b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVkZvOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlFoREFDYm5uWGZYd3hnd0JkdVBVemZsS2ZSNk9jLwpadVBNbmNXc1Qz
TmZTeHhhQkdOaUo2ZlRxUU5GUkpyWTBCWTVSczNENFBaUWxrV0Q3S0k1L0d5WkdLQjZ0UjZmCnY0
WWtGSWVWaHkvU1lUaDdESFRhdVBxSGxiNXRQbGNrRTAvbU9Kc0RzbG92cTM4emZqL2FEM08zdmVX
N01pL2cKMFBOaTZ3cTd2R3RTRmVKYlBGWFp3N25wS2hLSzhYZEZMR2pKRExwWmlYQktwMTdsK2xu
MUdwQWM3eElDcDd4Rwp2YWp2QlNTS0lEamdxR0Y4Z0lOd0UrYXFpRnR4NVlkcnpBcnhRbndIbDBU
emRPZktPaEdxL2NMaGZmOGN3UzFKClVUQTVJVlhzNU9OY0JWRjlZUHhKZnNzaFVCRENzd2tnWG5G
dzZrSFQ2NzhMT0JnQm1lVDVWRmFuVnBwaFJjeTgKS1Zta0pwUlEyNkZDL3FDTzBVamZxU09ta1dy
NUZkcW9OM1ZKcXVjMEV6Rzh3dmVMQ3BvanN2K3hSRURTa0VXVQpRMXNnMkFjL003TlN0SXdjMVhH
Z0xJcFMxc2M3L2NCQkxjUzNUNkVmNDIvVDVjNW9UZmhCeGNOdW8waHlqUGVxCkY2SUR0cWxTU0pa
Vk11UkIycWZGVTVRQksxN2Z3UVNGTElMQzg5MD0KPThJbEoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a95c0a0637fc5720--
