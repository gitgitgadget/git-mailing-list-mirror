Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719DF1EF092
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668665; cv=none; b=aZ6TsHh5tlW7UrBGUHMZWnVmZeBFqdEQ50kpC7Bbm5BHO4iNLuD4jfNwVj8gzEYvavOFBLTayc3IQ2z+t0zsYBJiCvDmYg8Yok5FxGxp1oK8eQ1TkWfjzwYR90r0sNusdQaUZIhbpLdkzV6LKyNVUZkKIRh3DYi+EEB5ALaYzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668665; c=relaxed/simple;
	bh=84KRGK8UPiby2aa34a8x7tVncIY6i/VFZv7BxA/0eMM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJkcv7+gH51eYzkNtLBDGH7iwRdanuffaOeW99K+wwmM1ln0o8ezmWw8bK7YZJkk1Y9X1EFOweiXnyaaYNPbSSvAn8121z0NtPKod+EnkrmQm2x04PEtBPz5FO/IiCS2NEFvH9oYf/q2wZYFxoP94Kc3ExzVkrCvlVQTuop4mNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+PSokC3; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+PSokC3"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so590800241.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743668662; x=1744273462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gRrrKq9VYtwC0SRXHIrzO5RUkjhBXZQV3bhHL1/Q0Q=;
        b=U+PSokC3r2c+A95UunJ38HrrtHqT0S5JJPGsjX/7CxqQ+k/ZRoAmjIq9aQOCJdmdVy
         XYPn2BbzoA0rNK4fKD5WaVjkBgZReyEaQuxkqt+jTNA1nOki7dFn16rYPQXmaBCFNWiE
         QFBsUmN0yWQVWPqXAf/ZIlCp8NCVlLp8CC9RxPhA7MtABL1EXP7D938bGe/cubLlAi+V
         GQE8ohz+GXVw2qSv3J6KYlcn5CAHmhol3oELhY2Vb7yzjBL14A4eiEu0ZrZtSoLRe/+l
         kAjdQlJjElmued/t/Mzdjagzz/M7qhGhxqprSbVTe2WYLcONceSdl3kApgN0hoaJETDh
         xfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743668662; x=1744273462;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gRrrKq9VYtwC0SRXHIrzO5RUkjhBXZQV3bhHL1/Q0Q=;
        b=UCzt5V7PTRVMBCAhNObPb22bQ3m0mADNz6KHFbF4CAmQAgtzDDCOMisHacgFjkaZnc
         iO82jiqusqtX0h6/WGhIsTgBH11OBA6/d900ydt3gf9ROQiZHfevy3FQabI78JUVxpob
         tFjM6t8cZMoC8RCx89O7ZrNuQigay07hrnTQ5HKWDbLVvNbI19aKte975sV4PgHcFmIg
         Pwu9cftnnWII+f1vztgUTVRXG59rG2lg1d7dQy9W9EdJHX0syOStWnf6S9rgGvfefZYz
         ASf2cT16f/ot0q0gWYly5YyDd6SK4Dy5yc1w2Iq3gvQlZZo0XtxUf6smOjB0SwmRZGIC
         OKkg==
X-Forwarded-Encrypted: i=1; AJvYcCVNX+e8OWAzK4v+mxxIJ61vX5ShpDDPtV43zaQ/OYpVLT4JmWy6/AVPXn/ZErRS2VwZBoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfW7ygzg4rWFzLwRSEygmhnlSRRcIrvjeHEGjdyZS/csmIPdwL
	+tjMnfaw+sRizOSdYrE2DYMqZK1CWmm3i8VqM5TlPYKg9MHyzcPkOG+biofvsuKbGGJ347QBA4d
	tuKTygIrqlF/jRxVtxaePKkEsWPc=
X-Gm-Gg: ASbGncvUR/4dwi2P1LcqhhXStkHlHzMTpL5idCuy2MhKZ2HinE/7zDugNyUd/wjXRad
	o2d8jNMamQ+9gXeaRnXi0yRv8CltcvY5EUPOKzRgrgCBMhaWqC37y3/3e6wP+HbsgfGsRWC7wAn
	ak/rjppXK34+D/zITVVt4izBSd3D9UaEfwL+OusetmtBaz1eXdXsb1p8i57g==
X-Google-Smtp-Source: AGHT+IGf4kSgs34uP1JLTIpXhRALb5DckGqC5FAxc6se6LDgDFsF2fopgEg7jtE7ZdiJQenOfWDoxlAtAXCfDCt4C9o=
X-Received: by 2002:a05:6102:c50:b0:4bb:e36f:6a35 with SMTP id
 ada2fe7eead31-4c839e3795amr4940759137.14.1743668662239; Thu, 03 Apr 2025
 01:24:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Apr 2025 01:24:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-1-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im> <20250331-b4-pks-collect-build-fixes-v2-1-6b06136808f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2025 01:24:21 -0700
X-Gm-Features: ATxdqUG6EcZGwv1WLXfj5VhoSQNrqWakcI-86aGsv4iFRhnHujS1TjPje1R7rXI
Message-ID: <CAOLa=ZRoeXumWxTPeZ-dw-vOPb1-BeaTxYJ_sSYx=CpekQT0eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] meson: fix handling of '-Dcurl=auto'
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
	Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, Peter Seiderer <ps.report@gmx.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="00000000000038211f0631db7f82"

--00000000000038211f0631db7f82
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "curl" option controls whether or not a couple of features that
> depend on curl shall be included. Most importantly, these features
> include the HTTP remote helpers, which are rather quintessential for a
> well-functioning Git installation. So while the dependency can in theory
> be dropped, most users wouldn't consider the resulting installation to
> be fully functional.
>
> The "curl" option is defined as a feature, which means that it can be
> "enabled", "disabled" or "auto", which has the effect that the feature
> will be enabled if the dependency itself has been found. While most of
> the other features have "auto" as default value, the "curl" option is
> set to "enabled" by default due to it being so important. Consequently,
> autoconfiguration of Git will fail by default if the library cannot be
> found.
>
> There is a bug though with how we handle the option in case the user
> overrides the feature with `meson setup -Dcurl=auto`: while we will try
> to find the library in that case, we won't ever use it because we later
> on check for `get_option('curl').enabled()` when deciding whether or not
> we want to build dependent sources. But `enabled()` only returns true if
> the option has the value "enabled", for "auto" it will return false.
>
> Fix the issue by instead checking for `curl.found()`, which is only true
> if the library has been found. And as we only try to find the library
> when `get_option('curl')` returns "true" or "auto" this is exactly what
> we want.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index efe2871c9db..a8d1e63ccc6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1686,7 +1686,7 @@ bin_wrappers += executable('scalar',
>    install_dir: get_option('libexecdir') / 'git-core',
>  )
>
> -if get_option('curl').enabled()
> +if curl.found()
>    libgit_curl = declare_dependency(
>      sources: [
>        'http.c',
>

So here, curl is defined as a dependency on 'libcurl'. Ok makes sense.

> --
> 2.49.0.604.gff1f9ca942.dirty

--00000000000038211f0631db7f82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 103098d5d5955e9c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdVJiTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjViREFDR3JsODlhR1pSZWgrdXpuVmRoc2I4T3BtNAo0K2RUMWs5ZWtn
Y2FjWTYyVnZhZG5SbkRacVhXRDIxbm5KcVhaWVBqSDhhTUFHOElVNTBERWIyTzhCc2sxeEpYClFD
OUpHcnlIeml4SkZnZFd0ZGFDbGpzd2pzUmpha1V2OGJEYWJudmJtdVlXbXZYQU9Ub050Z0QrYXRX
ZTE1MlkKaHBXVDVnZVk2eUlTR1M0SVdNNnpnSTRXWkFZZDNOYVdTMlh5UE9vczcycVJsajJELzd0
d29DNzdxQjRuUW4vcAptUnFLRjlHSVRWQmdEWVZITUhqL21ibFlFajhXUFRReUE5d0s4dEZRN2hm
cklhYWFSU2c1OXVTcUErWjRDRmxJCnBrbGVNT1pUbDRFaHdTSGJnRlJVMnFPc1pBMHpRWTJISkRV
a05ZUnNNRHhhallrQ1MzU1Y4Y0lROUhwUEhBWFQKR0JrdnNFdTV2UzJMUk8yTGpKNWVjdWtSelEv
UHlBYWlsVWRaWEsvazRmb3puNjN1akhycG45ZnpoYVAzRlhPbgpTNUhJaXZZUVlVY3NReGNEQjll
dnVJS1hMYnBTN2E3RXhpb3VxRXlnS04rMDRSbXpNZGZhWm00MHo2RFBkUmwrClhUeHNvV3hKRGVZ
YTEvTTIrbzE3a2hhaisxNzRUdFZiYUxQTUEzZz0KPXNBSHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000038211f0631db7f82--
