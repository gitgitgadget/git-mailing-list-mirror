Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349C6FC3
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473370; cv=none; b=QP8PkPuLx4hl8AbHsTJixLwghJkqIsUzgh+oFtcy4tVgFQvRB3NIalWLqR9rWwiqIc0voENm/Jr3WwflP45ulU+veeW0iyLAnzdDurUski4QMYhy71r01X+VtnPkI/kMTMq/jPoEtynppcbyjoX0LSKPpDagW5lL04a7HnFqS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473370; c=relaxed/simple;
	bh=VqXrYHPAJO5CCfcLYslgNWgYelm/7VBhmTHvKoWztZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOSAXrXhCUiGIjks1LbtDoQenzxu4lBGr2jhZM6o0K3eENL0LCUK9cDskl/BVs4RE81iTSj8APB9nAUmvSQ5Yc1WjT15AnbUCczlbN8XHSqhl11SSEv5nH7FU+6KqABL2YQQpEww7kkc1CmA52bSbEOexlkzNycqrC18QzlozFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXi1ovjD; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXi1ovjD"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so27737951fa.2
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758473367; x=1759078167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqXrYHPAJO5CCfcLYslgNWgYelm/7VBhmTHvKoWztZM=;
        b=DXi1ovjD+4zwvkcXJ35Mv6y2Mn8A0wM/uAxC13V9HFAh80I+z7rvHpzhriiuNLUPj0
         a4JipqltWsVwHoh4YnqdxwMndrR16yh+iaq3iXMQUvHy6/ZGJf/gg7X9APp9/MOuonXg
         alnAZTknAtHWkj1yBmhYtEtDXJNaYG9GjJSbORlig8Z9o7LsDHhwfJqMJTcoQD+8W8Xz
         kZFEsXDaS0XOefy8G6KaRTzgO2t9eEeLUEJlDqvbpRWn2lmp0ZNUmsWQDcbzys96mVQx
         W943rTnqGSaQtVgXLEjgvzayVyALa2BzhluhH2H7IYZbPtiSeDDI9yZjtY1LkrvHORxO
         BQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758473367; x=1759078167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqXrYHPAJO5CCfcLYslgNWgYelm/7VBhmTHvKoWztZM=;
        b=oHWhkRvYkINF790E6AdXsy0aOzRGNDDX+Nvs3sjH3StY4aqvmBdhOTEZCeGb3e69KM
         YS1YqWazTMvIXkih50LTpLy3TtxCQXBf6dIxk41ac1WZXIClr+4CRVTTRvl87p/hWNvd
         PewkdeWvza9m0PGbUI9E4dt1GaiuLSfPdbgM2dQWFW0ZkpmanjwVrW+uYWK2uBnGH95J
         j4jqN0bwwbPm/3Xr9dL1e5mBt3NHjtItYTF072B7BnZWgjRT3IIVE003TMOHABycqxZa
         LJeOvyYZWpiiT0sRRXwi4+z1gFU1seoX1y8TZT8I22VU+hqloAaWtm3+KI+HoKKIZxyW
         kbSw==
X-Forwarded-Encrypted: i=1; AJvYcCVnNZt9kA5HsL+nvxe2qD4a+yMTL/nnq21ZXeTcat9MWNIlwQmVrcBp5mwQC14HGL6DxZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hs1rM9RhzzxKbP52tXfDhLuh3nwMCJQmiiEqnP+O1Sheu3Us
	onME4ULC0YyIJzZW5+jHZ4Cey2q9JZ0A4IN4WiSuVAGIdKCXj5opeiM/RZ3BGnCMX6bFuyVZN+L
	E5RFdvUAHuOS0atsat11RWAHUQiOvxxs=
X-Gm-Gg: ASbGncteBF+WwnpBsY8ilegFKZJxuL2EofcXFHaLiWTOgcnz1FzX0X1PunMfvCMoz5+
	d+LzKgg6yGEGDwmpmxhgS0K2xH6kO7MalJzYpc0GM0d5CMeAs0wxUWfEOBCdR7ShZbblKJTK6pW
	eOBIbqqkKBeBCexoXuYABuLM9Mvhvye5dd9ctl4laYG3JDz1pbx4fyt6pEf7rABucsqMhHoTI7Y
	H11v8qO
X-Google-Smtp-Source: AGHT+IHqzc9qzVnj14shVN0PHEEzl6tNHn34945oUrKbIAyVq6l/hXR0+BdktiAchhJJKCiPir8/QrO4NbFms2Q9K5o=
X-Received: by 2002:a2e:b889:0:b0:36b:5945:d3e8 with SMTP id
 38308e7fff4ca-36b5945d4aamr1958811fa.39.1758473366662; Sun, 21 Sep 2025
 09:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
 <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
 <002001dc2a84$cda40380$68ec0a80$@nexbridge.com> <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com>
 <002c01dc2a95$400315f0$c00941d0$@nexbridge.com> <CAH=ZcbDGaxiW=QCTrRo3YqxS-rY0e5h5PrnKQt9htJfn4firJA@mail.gmail.com>
 <003401dc2aa6$623d1420$26b73c60$@nexbridge.com>
In-Reply-To: <003401dc2aa6$623d1420$26b73c60$@nexbridge.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sun, 21 Sep 2025 10:49:14 -0600
X-Gm-Features: AS18NWCDhCn3eK3EHE76zF3JOw7YUewT_c7S7OVCTjPtTl066jleqtkHPPA4mb4
Message-ID: <CAH=ZcbA0jpntXjPnrVi13Sz1PipnyBLNWKW4Q5taGEHqBrqj-A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
To: rsbecker@nexbridge.com
Cc: CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com, 
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im, 
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org, 
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org, 
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, newren@gmail.com, 
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im, 
	sam@gentoo.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 9:18=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> This is a much longer discussion. Windows is simply not a trusted platfor=
m. NonStop
> is. Building on NonStop provides a virus free/malware free container that=
 passes audit
> requirements for financial transactions that cannot be demonstrated on Wi=
ndows. I
> have customers who refuse all attempts at building anything on NonStop.
>
> In addition, production control cannot be done from windows. There is mor=
e to
> life than Dev in DevSecOps, which is the only thing Windows builds gives =
you. Unless
> git runs on NonStop, production artifacts (scripts, configuration, deploy=
ed objects)
> cannot be audited and controlled.

Can linux cross compile to NonStop? If so, would Linux be able to pass
audit requirements?

It seems like this might be a first mover problem. HPE NonStop doesn't
want to support Rust because no one is demanding it from them, but
engineers don't ask for it (or rather, aren't heard) because HPE
NonStop refuses to support it. I'll bet NonStop doesn't support Git
because why would they pay for it when you're doing it for them for
free. and now people are talking about adding Rust to Git which means
Git won't work on NonStop and then something breaks and management
screams at you to "fix it", but you can't because their policy forbade
you from using the tools that would allow you to "fix it".

Am I telling the story right?
