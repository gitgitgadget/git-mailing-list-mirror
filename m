Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE345027
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459143; cv=none; b=YsmahL80ypSlFjwghE3lmIyJVRkOvt4/IMr0a00JWfHPfEBlESk5Qpg6jHH1O2ecUNhEIWqbSQ56AWIAFpqWvfWlIDelP86FrjX849795PJxfC1kwvRabXy31NgO95ZXRwpDrO6Jj3ajsXrCvNcaRDKg4D5271IAw4PyXylDtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459143; c=relaxed/simple;
	bh=atu1gqr0TRnmgxKZQCkAyZoEHK1REYbmXHCJM3jY9LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPStaePX8fnvkMBPF0lOnrLccRl3dX4WqF+a1j7/GhW4zHpHMUXc3TxEgwwnLVf5a78gpMVfPgJcTfFyXHbp/psp+wtOsVXir9eebR4O0n69HyYlh5glpLOK3mOkrZQVATL/f5jASGeAo+cBJlx88b6wgV6K600ilRPgXWwy5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHw/lwzj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHw/lwzj"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc346ceso8809152a12.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722459140; x=1723063940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhbtjMqzCDrwQ3pPYC/X/7nJFKcLesdLKmlTNkNWbdY=;
        b=RHw/lwzj7Ul8YGZ8O00intLU2wc6Rvd+Vtl5g/pNKj6+qSnNW7uo2pe0902MkUsI+l
         MlEC5risLlIE8iewcdwCTG6Vqrsq2Hu9MoOQOsQsbnPHE+EG/Q4NSRaFBxbxxNxxre16
         GgUa3BLwE55f8e8vPDBqFsH7D/Sxd8FF6w7+nzhosRdkhHbGdgUBwAXXqlm+PA0BgFu/
         Bjec348h7ha3vcLQFa868L6e4bQ2178kLifUDV7uJHSRjHCKBiRI0qtp8ySNReNhkshZ
         fDSKtvt8Jp5Xg49uh+IRuw2yVKOtWzG0SlvohZlXVs7z/Erm9lktrb2IeI+qJgs8025H
         8thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459140; x=1723063940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhbtjMqzCDrwQ3pPYC/X/7nJFKcLesdLKmlTNkNWbdY=;
        b=gR0O4Fq3V1gNWGBkTjGgwFpMsNv8iHBlm1OZy9dvHQRccql3GxzV6mjnS3ZAYiEf8o
         1wDWM5U6xT5eHyGN5T/VJW6wqzoMawvxUC4MIGsWX7miOdg8v9ZB6jCHbZcA5+4alNjU
         4PBMeE2LgAh4WvADryhzGsXe+VpkD/LhsgaLETZznZU6K6LwvtC45ysUplSMPKv+pyxQ
         HruQOs52T8lrySx1DO4Dp9HSJQhOuobuP7e1gdPyx16XZtj45RiLwnTKx7ZLV6OuEdcF
         RxAzIksFw6Abh97fNNeWbfesdwmAcwDsJT+Jo7XBI9nfB7MXBG4IKSB6tSQ2Kj40aMZh
         OWlw==
X-Gm-Message-State: AOJu0YyRzDiANCAB/6aeDaU76XEhKQap0yOKGrXJZFw+xv4EsKGNf4MQ
	RP2mnidVWCZfSUaec9xthizZbuia6ZyMpWAr2zB26WYTVGMti2pZl63PK4o/bjoZBQi7ct6AtNr
	HQPdZG+R0utYqFthMlRyLMSiok46g6T8UA/Vs
X-Google-Smtp-Source: AGHT+IFMNn7TmA0WB7Q/ezffvvUTfv6C+zlZsXUazvLUpuXXLE2UTcoeaWWrm3c3NIuV2ir6rMMYg1Vm5s9lhCsRgC4=
X-Received: by 2002:a17:907:3907:b0:a7a:a138:dbd2 with SMTP id
 a640c23a62f3a-a7daf5c15a9mr23144266b.50.1722459139740; Wed, 31 Jul 2024
 13:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
 <23498c37-1e30-45a9-92ae-d31a05778fca@web.de>
In-Reply-To: <23498c37-1e30-45a9-92ae-d31a05778fca@web.de>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 31 Jul 2024 13:52:03 -0700
Message-ID: <CAO_smVgvUksJEk3Q3DJbB4-QbTD48o6pAONwH8Q5Hz-SVr8PjQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] t0080: use here-doc test body
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:06=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Improve the readability of the expected output by using a here-doc for
> the test body and replacing the unwieldy ${SQ} references with literal
> single quotes.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/t0080-unit-test-output.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

I'm not an expert on git's style guide or testing infrastructure, but
this looks like a good improvement to me. Thanks!
