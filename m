Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADF1DD0EC
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485203; cv=none; b=XYYRRLSQKWsW9a6rGVxIVMqLQbOm1V5l7uTC3uD/rWlPd9eRuKq30W7jRNdUfC0Ie1vfd2aeDMF/uJ8V9ggPUiaicTpUvDplvu+Hp8gxgSis3tTyCAvnoFm8j1G7fm47ObWgsv2GTVCvVLiucDLZ/vhmELhrTAyeMQOb4BVkLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485203; c=relaxed/simple;
	bh=v+v6vxFa3na4A/uXJ8YB2HI0+fVi+A5bf3is/uXXrow=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=AI2hZM6YDtr1P9498KS/hPaS+l5Lw8StfCeVirU0rxJJFnudYTaJcUzwvmP1IE7633xWD56SJbh76cnXLGHrSYRK3arNtC0w0Hewc4OyetI4RRj51QNcwnpHWDRfa/OgblMKNV2vqPbwIdGoYzGFnSQ8DWCijhunhjopdmWwDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWYfHhji; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWYfHhji"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85bb264993cso446111241.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733485200; x=1734090000; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32C/HSFwd/VXqDq/dKFM87jF0Dz7QpBtybhaOGe2+U8=;
        b=jWYfHhjiGQnWXebjubxpBqxvzl2uYGHM5VdBoVahbudo/4qW05v81INm/dYzkfTr1U
         OwBxbHch9gpL4qi1JdFZfGIlWIJafx4Jcl7fLStxhlBbnZne1lHSdOxCJmQ0DslgnTJp
         bsh5Qn+IWXBE8DrjogxbGGdL38JdeFM3P2liZKVRzwemZQxRC7oT9mhBL7PjrvAi1Jpz
         01tHcdn8Z7WNwViodjqeFlqTp2Kj0gFYwx4Occdzi5UXtbz0r8dDZL8m6QVaJvkg24EK
         Z8XgKzixPtwicULp3qvsVWebPRzdkqjBEg+YGhOCU0Dzpw4Y6W7zTMkx/fMrbOQ/mdG5
         TEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733485200; x=1734090000;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32C/HSFwd/VXqDq/dKFM87jF0Dz7QpBtybhaOGe2+U8=;
        b=qJAFwZYQ8za7WuU4AsV/hZuwmB7pA1XU2U9oHM9hWhL/ZdLDrflismh8p12zZcaFp+
         nRBlsFjSTsqGqKVWKTW3m0eJ60mhdwoJ0ykYaOFgiKF1xVFj8N2MyUaq/UtMzgQ/v3rS
         xfEnhku/tOguMPdd8/iHMokC5N3XhVSFBfGKzzYzRLa3CNPjL1IKetYuUooJtLgnmyfe
         +T0iKblIq8ZIwQX3J9nYt8LgkOjbfBDqdxHPSz41F76/vc7IWFDyFmRD4uS1WiydJYIP
         qG9Lxyiitw1pxtaNBV8LYgiixHo7AMuU9CrQyAOhbZhEwCHgZjEKGPhYysnJk5QrbzBn
         qsIg==
X-Forwarded-Encrypted: i=1; AJvYcCW+xsM3Av9YOuL69pH+wGV2or3pKgmM0kq61LX9/pz/l+oWFuSf/wtuOj4MuzIrc00HSU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiJzdbK1K2eMi4uQkAnDdDZBN4yAH5aXbq3xTVlHuSe5wWgy3
	v4eXx43VEico/aJBJMm39uioE/r/2bvSEFgKyaY3hCzSp0ifFUs7k4Xryj9E/xnxCSUtnL0yDXl
	wwNuk+FuFckLYEMcBzVtG7tWtfZ3NsnyH
X-Gm-Gg: ASbGncsaBe9VwwL1V6LtEmEYqmE1Btfq8IQ4DAifYw5noMX1Wmy4EGp1h+EWElFiAZh
	9Ifkw/AVqGzoLEVAq12DzPxZTTqG42A==
X-Google-Smtp-Source: AGHT+IGP619ZXpuXmQZEpU4i5GZxaFQmoN1qPfKG2e/CKe5bXFhxlEO4mAkcOs888pFtxhITr+aSiGpa4LO2PN8WK94=
X-Received: by 2002:a05:6102:f09:b0:4af:98c6:bc98 with SMTP id
 ada2fe7eead31-4afcaad6f21mr2426606137.20.1733485200591; Fri, 06 Dec 2024
 03:40:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Dec 2024 06:39:59 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241206-pks-ci-section-fixes-v1-1-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im> <20241206-pks-ci-section-fixes-v1-1-7ab1b69e3648@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Dec 2024 06:39:59 -0500
Message-ID: <CAOLa=ZRUZC9KDj9F6iLWWU+CBHz_DWKA_8znM=7RVSCVGSeD9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] gitlab-ci: update macOS images to Sonoma
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009af1a80628987946"

--0000000000009af1a80628987946
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The macOS Ventura images we use for GitLab CI runners have been
> deprecated. Update them to macOS 14, aka Sonoma.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitlab-ci.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 526ecfe030a43e0a5a83ddd35cb7c96d46ab2485..61c56ccac8fdc940075d91dd4cb0b54ee33d5199 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -99,10 +99,10 @@ test:osx:
>    parallel:
>      matrix:
>        - jobname: osx-clang
> -        image: macos-13-xcode-14
> +        image: macos-14-xcode-15
>          CC: clang
>        - jobname: osx-reftable
> -        image: macos-13-xcode-14
> +        image: macos-14-xcode-15
>          CC: clang
>    artifacts:
>      paths:

The changes look good, the documentation also states that if no image is
mentioned, it'll use `macos-14-xcode-15` [1]. I wonder if this means
that if the image is unspecified, it will always use the first
non-deprecated version. That'd allow us to not have to keep updating
this.

[1]: https://docs.gitlab.com/ee/ci/runners/hosted_runners/macos.html#supported-macos-images

--0000000000009af1a80628987946
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c896158f874ad30b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUzRvNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3B6Qy85cWtYTlJpY3hNL1NiZzlmZWh5VGJTbFgwRgpaU0dXUWJ6UDVL
dWZ2YU9NaTE3cXlkblBnb2svWE95eFZUQ2pwZUw2VXE5TEF5TjNWUW5nS0dtZitpZnVzdzVCCnZH
YkxDS2RTOVp2TlVjOUtLMTZzVjl4ajI2M1B3bDY5M3BGaHJUaUJoK3NRTHdIaEhQekhWSGFpQUtE
YzBVcGcKSW5sTlFEK2hvMUZLREkyV1UyTnhCNEhmZjMvS01HWlBLSVhyU01IeVd1bkZuc2lEMlY4
ckVTUFlkU1RyR043QQpTd1ZiQ3dwYTlwZVcwclhER3NzUGpOMzI4SDZwdW1CZmhydWpiaEd6UVBZ
bmp6N3I4T01oQVh2RjRDandhWjZlCityUERWUFkxNVVEZDlWN01PMVYwV3ptMUk2bmhWVG55SjIr
VlFMUi9kRjJaODdCY08vRFFYdjVJVDVkL3VNTG0KSUxRelZIV29aOGJ0WC8yaVdsVjU5UWNrVldI
Sk8wZDNROU9tVWNnOXVKTnN2eXpNVUxMQkx3cEFwa2tMU0xwbQpodWx5YkRYUTZ0L29iY0kzd01L
Q3Y4NzFUT2YxbXpOZjFSMlhBNHprd2Nta0RnR1c4VEliSjlCRElVYTNNUHFICm5JcnlDMDBHTDZZ
N1BJSEpNa3FvZCtJZ3hOZzUrdndjTGd0bDdoOD0KPUlNQksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009af1a80628987946--
