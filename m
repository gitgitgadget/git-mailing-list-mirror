Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A5189
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014266; cv=none; b=CWMvLuIHuGWIPDROEIje3qySM70B4lNd7E1p+ikmkeKGGpG996tmZurBSznIJF4aqumQQnIPNEdgKR57O3d6BmXC2pKEBe1bj3a4p5UlGE10W3bEVRVku7aQ8L2EybDRr1tfKTwNd1Uw/rH/MA9yFh4vRnqYl1+93h/1Wk/AmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014266; c=relaxed/simple;
	bh=teKWHBJfxhstpANCWAm1L+58LUI2m9C+w7rr5XxZ5lw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUjWSbAalWg2XmztvSIjR9CeXdcqMapXtfGvz0cPtsHIkYQwknVpfG03oWGCm3APtOxqnvwemIssnysyZSQkmBZhR2lSGwOzOCCi1kquwIZRmI27odK0pcDyMdeDVSdKJ7kX6omEXpS1SXIO9jcAH6Xw338BlJ8lrrJIIeRkVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlRzc+86; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlRzc+86"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8988b982245so2548454241.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014263; x=1758619063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=teKWHBJfxhstpANCWAm1L+58LUI2m9C+w7rr5XxZ5lw=;
        b=WlRzc+86eLKQt0PfywuN3G6Nll8xX6k7MtvaYn92kOB/IZSaI7tp48rID1ZnKk9tUa
         vc8DtaB7j0ud6yN4TB0x7aVzlqCRYqEdst2SSLPiZBxdGiVy55Wosi5PIveCxsurPXrY
         vyuXr53sAdt/VcLUEn7hTBLcewUjf2bCCxG3GLDmXQOUPX8Y60BpyS+uJ1d5GLBrznfA
         82WXjiP/0/6gu7w5A20lKmsoWnYIKvV5l818IfHQbrSqLsv6VQ8HU2iezLcKcyCqreHX
         /M/ENGqc3dk0rr4apRupC7cUs+vSfowYqsP3hUU0g5U48xUUuOwzq6NqOINccfhPixN1
         LUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014263; x=1758619063;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teKWHBJfxhstpANCWAm1L+58LUI2m9C+w7rr5XxZ5lw=;
        b=DExH136fv/7mcy2fBalrFtAcvINZnUE8UPuTSWBzhXQS4BtKnaKUkpsKPr5kjIAQ+z
         d1Vcx1JLS7cu4rj5ACIAhX6UvgX6CJI5haHbQi9qi7y10OI6IY3kEeyAU4u+ZGRDjN48
         4nNlFkVvaPwUOs4lTzBmMOFQVWZFrgebt9MUXMUgkjZe/bPV8QvduNABL6E/SsZP7MIn
         vVogOdQdWtYFfXKGPbD4A080rFxIm2NTzeSYRs6DNhNtTvIWCx/d2k69/fSpflmgEkhf
         rFcKd7pg8v4M5QXxYmPK/aL31yb/vTWedrGutNLHGXn4PGYkSIVnLvoBVcJcPpG5whhd
         fxvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqj8eZxng42Eq0BPn87Yv4HmZbMdJlAO8uGHyHoSGg+zxx66HA1xvhnZ6KKjwNWHDpa9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo930ks2G/J8aBEGDSzh9GIx6ZUTVdJF4mcL41DKbOIL39xowV
	aeM+eJ7JUfjPu9xZPF4OGuKss1ti84/fi+NKAc16yHOB1r9UKJWdN5xHx3NttllquqkuAIBpFjO
	uoYqjPwYCMqJlwkr+vei0Oqwb1FPCtNGf4MW5
X-Gm-Gg: ASbGncsisv0A5HGNZ/hG1YK3gkD17QVTTd5vay+H8lNExzlxDK6qWgb2FsZaYSaZPhz
	E5Nv+gVRjlvHwLLcAkZIXBHs99wVoJ3GIuiMrf0NVqZ09y2xJtXIvjNnPDUbIDGrUXd0dDfZS+y
	YPsPueuN9IMudwh/KznHc032A8np2s7IuUQ/58buuoWz1rwY9Z1Ebp08XkQmV7kzmv2w7AWvjsc
	gNLknEYAoCMOogdv1BSb/E3jcqKQdIZCMcKbpejSA==
X-Google-Smtp-Source: AGHT+IEFIRbgMUqSYeX+5J89vS4xqSQnDvFgsm5WuLH7T1J+CgYjuSXSUAo1ArbT2pbM6gr886jHhBRa3pJcOpCgluo=
X-Received: by 2002:a05:6102:3713:b0:537:d785:b3c3 with SMTP id
 ada2fe7eead31-5560e7e0075mr7303958137.17.1758014262914; Tue, 16 Sep 2025
 02:17:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 05:17:42 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 05:17:42 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 05:17:42 -0400
X-Gm-Features: AS18NWBJ1-YkTiz2AMou1iaM-W3qpIfaXN2wfd-IzQfQYVHRwK69yVBFNvsVBOI
Message-ID: <CAOLa=ZRXdnMbkxVTPa=8NVNBpshQsyNP3HRb_5u51StBu5R8Xg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ci: don't compile whole project when testing docs
 with Meson
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a6d269063ee79721"

--000000000000a6d269063ee79721
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> these two patches introduce a new "docs" alias into Meson and use it in
> our "documentation" CI jobs so that we stop compiling all of Git only to
> verify the generated manpages. This fixes the issue reported by G=C3=A1bo=
r in
> [1].
>

One small question from my side on the first patch, regarding the build
options. Looks good otherwise.

[snip]

--000000000000a6d269063ee79721
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5f31d745af465963_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSkt6UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVJvREFDaGdSK3R3cTBIR0VJTHAxSmkzSmlNNElDOQpZYkRkbFgrdGVq
MVo2bWNuZExTUmlySkEyNElTa3l5a1ZuS1k0WXA5MnU4Yk82M3haMkwvVHZtS3NyZ2pjWUtGCkh6
a0hiSWtqY3FoWXdmekhLQlErWk5tYXptbDVyKzlBTmFHc1l2NG5ISWlCeVRQenkvSlZlV1M3Lzk3
QmY3SEsKL3R0N1pxYnMzMDdKbi9KeG1Na3YrdDdCRzFydzJ4RWsxcUhsVHl2NUtrUk5haHNUS1ly
YlRSeHNUeUdvZnpsNQpCVXVoMmpCQTZ3aFU0TVpLQzE4STJrdkkzSUxRMXRpR3JGTG9TSTBPc2xu
QW9Ha0pUMWVpWDRLaDMrQjJmQjdiClVhbUZtYXhVcEFQZDIyRVJQWjVwY05aa2FUdDZjcGhkcm9x
ZVNzYjRmLzhCTzdUMkNIa1R6ajlrQkpwVlVrUWgKYTJGclRIVkwvMWRocFlNNXhVN3pmTnJ1M2o4
SDJ3Z29CSGorSC9YckhqOHZ6M0U3VzZOd0V3NEF0UytFMWozawpTRDloVXh4TXdScUw3eGJUYmYx
OG04aU9LNEliRnY3ZEFvZFVnb050MzJOWmFjZC9RRTVMVjh0UmNyeE1KRmNOCmRtSDVWTmc1eFp0
NU5KTDZ5NXo5VERkRTEwN0NyOEM1Tzc2a2loRT0KPTZ6c3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a6d269063ee79721--
