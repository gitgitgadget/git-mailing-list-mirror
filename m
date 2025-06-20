Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51717583
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405016; cv=none; b=ILwyJLIQNBkoABczQl4iTkYcgb9EgRD1wViuOIYEdeZ9KEZjGu8NeJtxT73nr4dO0tBUv97eFkslDSzrq1a27eYeAR/RxwT5jJFFtqKdS5tm5o1F+CBOFhUvhEszKeQtOu8FjDdzblwQ00/PmasdHGxHYrYZRLnKlEaVt9UX3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405016; c=relaxed/simple;
	bh=BSjBFyPbAq+lZSes4B6XeOFfMyFGphNcvVurHlmX9ng=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjucBzr969MzuI8QrRm2UyIieNkMI3Lj7rdfoZVcmI9LaXRTysmJSBojO3kXgm9qo9bsYwold+67MFvj7QKpGsOr/KwsTgwqyO4R5oTbIB6SBnO+nIPCrfz5h5UZ2D3VMUKKXEFbDj5y6gkITxQQXRY2XLTfDxeUHlqMFcnCvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsgsHPa3; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsgsHPa3"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87ec5e1cd4aso348102241.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750405013; x=1751009813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lo1qlYNequdAo2IsxLv6dC8f916J5NvTabK1JsJEPSY=;
        b=QsgsHPa3No0OUb/pSGV3rUNDZpXiCfDm7dt8P+qLGLY1iwK4qwpqx0o7fZbG6+UR0B
         hy8qgSCHaWThO5eyaq3JqXsE98OJ6KfmcyHdwJdyIN5zT2+YCafFgKh3MPGUG2qExGFw
         A/pBfBnmKbecsj4vpQY/CLVi+xyMn5Izz6/O597qLylAgfvoarlpe5tbqmLDw4Kh6ZWB
         S7OSMOa9KfVgsViQr699EeXpQTD1E1UJ8rr/tRn4NaJfUR0t/hDpBAblxXGPUD5og/Dv
         L+bYTptKgKRMKLheslPpPDOEayxHXOhl+okdaIYiP/3EwsUGlzdRnSdZVz3QlJccTTPx
         VYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750405013; x=1751009813;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo1qlYNequdAo2IsxLv6dC8f916J5NvTabK1JsJEPSY=;
        b=Xxai3Bip+st4A16Sf1NHp4JY4MQeH3wwyd8Hv12qYFwJ/2RAQnaxSSbGJp5f/mfrcO
         l6wzouD6fXBnmMrQyJOIP4ud8tdPuKIstMsCoUfjfCiT1C+DXAcHq/1Nq2l0dybZ8TPL
         uMBuJa9ti0LRFL2kCW/id9z/M0CLPBD9/Q2lRFXLRPSGiXoBVHCsychVmrVaDsFIQCsK
         CRbbaFihdDeBsW+fLKnmhwPU0lIefI9rXf3dGr+ugLcDIkn7BXaPjWNmXjVfF0u2DQeT
         DWdg+vcKhJanerRThde2X3h4q/IOHPc4/iLnskSMkkNxs9qy/arDsjYCY3o7wMYVVoYT
         RRlg==
X-Forwarded-Encrypted: i=1; AJvYcCUjYKuRiV3VlO40gEKtkFfgg1bVVe4lS1ufXLT3aEYjAz0oJDfBi4ozJSiAIkBnskhVwRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPcjClqVCnRmhmUUlNdigIR0Gh7cOfoNelIn/T5cMi7u3/6tk
	eFBAAjfc6ok9TkZ6i6YBUpi7PurT+F6l2BXx13W2OFSnfCoYRuBbIoeYbTaiq8IXlu0agWt+atN
	0JBP6FW8wZLrLjX6UsMN8fF49iDrRl5U=
X-Gm-Gg: ASbGncshv3vTROogHwMLdO1/Ma0Jx541CjjiolH43SNQo0aIMrHi68Fr6ZxKnfkBCgn
	IIoxpXTJFMs2Fzuv2QItTQiOoo3tKy9Cz3ALiUoU0X4gI11ht4vT/TQZmUl2Uo/JUSck2aO6IKd
	UTSRbcOgzpZm1CsvCYAlqh/lhyX0E39CLV7uL91g3k
X-Google-Smtp-Source: AGHT+IHOHHxSDmpHG6Qx1gT5jtrCu6OQzIb+6Cvm4TmuBcQJa4slJJBaIZCs+a2MfsJnOF23oM32Pxa0tNNwhLguNXs=
X-Received: by 2002:a05:6102:290d:b0:4e5:ae05:fff9 with SMTP id
 ada2fe7eead31-4e9c27da5fcmr900949137.8.1750405013318; Fri, 20 Jun 2025
 00:36:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Jun 2025 00:36:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250619225751.99699-2-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com> <20250619225751.99699-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Jun 2025 00:36:52 -0700
X-Gm-Features: Ac12FXwLepZxPmBPD5b4fLg7K9QkjqgAvNubFw5sarxftsZ59hHwkFzVE4GOHKI
Message-ID: <CAOLa=ZSgFYXEwdTyAfC2TSgVqpCSq6D1NDBwPU9cY-unX0Jx6Q@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, ben.knoble@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000000855ec0637fbedf0"

--0000000000000855ec0637fbedf0
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Create a new Git subcommand called repo-info. `git repo-info` will query
> metadata from the current repository and outputs it as JSON or plaintext.
>
> Also add entries for this new command in:
>
> - the build files (Makefile and meson.build)
> - builtin.h
> - git.c
> - .gitignore
>
> In option parsing, use PARSE_OPT_KEEP_UNKNOWN_OPT to allow the users
> specify after the flags the information that they want to retrieve.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  .gitignore          |  1 +
>  Makefile            |  1 +
>  builtin.h           |  1 +
>  builtin/repo-info.c | 21 +++++++++++++++++++++
>  git.c               |  1 +
>  meson.build         |  1 +
>  6 files changed, 26 insertions(+)
>  create mode 100644 builtin/repo-info.c
>

Something I mentioned in the previous review, but hasn't been addressed
is the addition of documentation for the new command. With each patch
modifying the command, it would be also nice to add the respective
documentation.

--0000000000000855ec0637fbedf0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b96cbafa74a89dc8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVkQ1TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHQ2Qy85WjRORVF4Y2VCamQvSG9BbExrakYzb2Nkcwp4Wm1yaURORjcz
Rnc4UWk3MS8rTTZucHhkNUFzNUlvU1FVT1A3VGYvNTFFUXFjQUovOUZGK0szWkR3NWcweVZVCjJs
MlRkR0Y1VXhCMVpRa0JtV1ZTRXR4YTM1bndrd2o2elhkUlNuVDB4WVFNeTJoVTJvMDlVZU1VaDZP
OEhwSmcKYWVOV0J5Y1dIMHBKZEd1aTdIK2tYS2NQUjA4elNGWlAySnJhQzdVNzRwanNBZWtibGho
aDVMWG93UEx3UDYwSwpHUnBrVW9OSWpPTkp4bllzNnBaUENGdFp5YXRvWlVSUVo3YXhKTHRyaVhS
QzJLb2RKYXNWd1N4RmRvKzFpNytIClhYSHVNZTdBeGdER1FFdWo4VCsxc0pud0ZhSm16eVVQVk1w
REhjUTJEK1V6R1l3WHpaTGw5M0Z4RGtYdXdyb08KN2xKbHMrNFBXN2NWU1d0UmFLZ1hkY0NxTzkz
eU9mUktjZmNiT0Qwbk42VG1WY2dsNzdBTTlMNjIvYkdKK1dITQo2YXo0djhPTnZKSlE1c0FxMnZ5
a09hQzRoUHVtVElzOS95ZGV0ZUhFNFFGYy9laDVqQ3Q3U2FrdjUxV09GT1EwCjgwdVRMOEhwSHM2
eHVLcGNJeWFRd1RGVS9UVjNJNjU2N0QrWVpIST0KPXoyOEwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000855ec0637fbedf0--
