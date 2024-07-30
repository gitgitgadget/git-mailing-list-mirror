Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844018EFE0
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337800; cv=none; b=LP8K7vmTkQqX/QeGjToJejpdpnmJLqKpENCZ82lrMf0gHioWdEN0faugAZTPG+CKSDRMrhy/kubMtiEJ+mgi8koYl3VcoQ2QmXGqbr3D3TfUggmqYpruMNKD3IniJ2xRj2ekv7tyoZASFXuZw/sX8EG3YfAStou7U5xkyhyShiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337800; c=relaxed/simple;
	bh=+2pDoGq1W3blQ82rgGc/75fX4dQWvYIvkRrnV/iGGH0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=BVpM5kSpnjPNwlLX/mnxrPKkvIK6/LGWq/aA2Bcs0DqV8yFI/AscArzI0ZlId3EmNzmD1PBT+WHSI3iU7GmNk+YCz/3A5rhhKj+tFj0UxQIbjWZGGSEe5YDkyQif01UgK7JjJTwHq/g3GgQO+9nYG1k5m69ssGGE+8Ec8UBNlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQvG4VRS; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQvG4VRS"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260e3e295a7so2621916fac.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722337798; x=1722942598; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2pDoGq1W3blQ82rgGc/75fX4dQWvYIvkRrnV/iGGH0=;
        b=QQvG4VRSaivUeH1JFCM2l7Jn5hq1YwfNTjps4w42bCeSpCF0A1MocAcirRwpykkmRF
         4OrwP8ya9jlhJA5y8s/fVV3ulOsPaQ37NeSWVZslxX45XPvHE5PGEw1dun0Iw8AURMjA
         +jocQwzp5L6a8zpzkiazWNd5qymRewSmnP1cxJk6HsIahleWWqjpdIt7ZVkpbKAZGUUD
         9wyCRgumrlljvnzgWUW5ph6fxFe4XsyTHT3PV1mUvCVhjSTWzBlDT1Cf7fj97YcGy1qg
         eJB9MKGUwp1OFfCMsmGpZ3z6Bv4kqpwPtEg6Kcb1P1Ued6nRdFkKvz3vhX87Od5sv6jJ
         x/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337798; x=1722942598;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2pDoGq1W3blQ82rgGc/75fX4dQWvYIvkRrnV/iGGH0=;
        b=bwUIl/nCsLsdfaaPetrnW0koRqD1U2V7YJyLML/T+aAmMJqcDGb/aY02T42o8IREFZ
         VLoNpaN6POHlnpNQ5bjNxhRVqclWJozfGjEEpu3AW1p64fal0mrEaVWJ/nZdv9rlT6jm
         3DNjWeFLIdMQPjUp1Hy19Lmj9RIxJT24wzMi2CmbPoZpnT5ce4S7kSYt8+SYvaFfePqP
         h3b/rieWnSLyGEMxWRCWkFmrFjq5QwaQ4e1BJqLy440kuSj3CCv6gXTRECeIia68lcWb
         +2Ieet9zpPzGwsPWIemVZrCWQ/suW7b8ERXLdsAVXHsOkQ04Eff2q4l2rLgVwnlMjs88
         AdMA==
X-Forwarded-Encrypted: i=1; AJvYcCVrFYniUN5Tbzm5UUoPDy8DsvXTLYLwnvCLXGjQryTrNj7i6+YGP/vrqIsOYuOzR66viI6WeyktOmnxkekVoYJYS614
X-Gm-Message-State: AOJu0YwhypF7MrlyQtUCmE7pln3CLTxriPdC6xWKyYOQpqt7NVur2FjD
	nQuVQe7Ec3qG5KZUs6qeTHx031hzK/xBffpfqlXX5TYmi9b7vJ5EFPrUQ9hKoXvLvcIS6a+h+zK
	w4eOLQH+SVxhYGay4oo+iWwjQMG2jeA==
X-Google-Smtp-Source: AGHT+IHYT1lgchPy4hIoidHGLr7l20TL3PeY0+bsNkIkMqZPfc0xcn7pE44eetnqQ72Sb8Z3Z+tU7rid9J5gtSWnzXA=
X-Received: by 2002:a05:6870:4209:b0:260:e453:5368 with SMTP id
 586e51a60fabf-267d4f3b530mr12638759fac.46.1722337797938; Tue, 30 Jul 2024
 04:09:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 07:09:57 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 07:09:57 -0400
Message-ID: <CAOLa=ZT==H9VQp_Z_VcQEmXVBUPWWui1CfmRQbLnOyyqMwxjmg@mail.gmail.com>
Subject: Re: [PATCH 00/23] Memory leak fixes (pt.3)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a142ef061e750472"

--000000000000a142ef061e750472
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I originally wanted to hold off with sending out this series until v2.46
> was out. But I saw that Junio sent out some patches which are plugging
> the same leaks as I did, so I dedcided to send it out now to avoid some
> duplicated work.
>
> There isn't really any structure to this series, I just happened to pick
> some random test suites that fail with the leak checker enabled and then
> fixed those. Naturally, I've also got part 4 of this series of patch
> series in the pipeline already :) As mentioned elsewhere, I hope to get
> the number of failing test suites to zero this year. Let's see whether
> this is realistic.
>
> Patrick
>

This was quite easy to review since there wasn't much to add and it was
clearly split into small commits. Apart from some nits, the series looks
great to me.

Thanks,
Karthik

--000000000000a142ef061e750472
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 302bb97c3100a4d3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb3lnTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXpqREFDYWZDMXJJOEpFV2d5cVNqdU1JNCs2WUl1aApDQUo3elpNSGxF
YXhJeFU2NmphZENlL2xkMldWaFZZRGErNnVaa3RwdFNPMEdlakQ3Z083WTcwbGxrNXFBS0FlCmxQ
OGVENG1RVTFabitYZFdtbFRIM1ZERkpvVFdHUEt1RWVBdGRJSVpqcnpiV3NoZ0Raa1hNMEpmdGFX
THJ2bmkKdEMxWFZZa3lxd0xWbk1obDl2REZuQ2NBS1ZHemFYN1QyVFlJQmNJM1dZUWZmRzRUVjdw
TmpCVlpVSHZFSnV5cApwN0JWVTBIeDdEanp2VklBekdlbHZUWUwzQkhDOFdzaG02SVJ0MEZVTWlL
T2czb1ZoemQ5OHRSckUxRzREWjFFCm1RVjFxZ1NVeU1OQW9mQmFydmNURTZqU2lncG5BS01LSXVu
MzVHWEJkcHVPNGFhWG54UGQxZ0pNSkQvYXZ6L0sKbW16ZjRodW5xdDF2YzB2SFoybEVuTjlMZUNw
ZVhqN2RkQldVTW5xU0hXem5XSEUrK0NNOE9Wcmc2cHhXb2RHRApJY3BmUFdSNXNiYzNxSmRnM3Rw
TWpaSEdCMFNUYWtGYklEZ2tOU1IrRld6amg1YTZTVGx3bk1OdTBmNVc5VWZXCkVzdFg1VE5pMmRG
YmYvNnVUS1dVWkZjSmc0dVFkKzdDSDhSU2cxMD0KPXlJcTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a142ef061e750472--
