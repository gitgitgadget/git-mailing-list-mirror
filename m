Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AF134AB
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470885; cv=none; b=dpg8KU1o2eu1cbGXyYpqe9sfP37xoBl8HyMLDTHw6XlnbSzbjVrw1nI1C0/j22Hn1q2cEWPzEE5am/THsLdz/vHQ9n3ziSTwtEEsTJWfjhASizi1qOZELLKhgcX9VC6HL0hwlaBBxbI2yPSYSp7TID6zpdKfURbEzBPKLHLFYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470885; c=relaxed/simple;
	bh=fI0nKpnyKYbjeMNRti3a0P/xN1HyYKolSKnPQNWoLy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJGSVIEg2OjTbS99+gQCbMm1ayAOSkVN01eOp+4Z2YpCdp4ge7UjGKV/0/9ja+MnpnDRcESqwm7LDbZ/BdNXKIDXas7a04Ep11iZCQ6YyH5k7FiSWeTr1XVRSIPqMIyAnB50cdcRkw8nioJf8fbttZi+f4kB+gN2nPNfBivpgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAp54b8y; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAp54b8y"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-43346da8817so1023875ab.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 15:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762470883; x=1763075683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gueIN4a72rWkYCihuZZZl7f5y4PLrSamaFI6CqKoXp8=;
        b=GAp54b8y0SxKhOCQnNGlJkenAMy8EFWNy67g/zO9+bQ4XnLFzX+Jtz8dLjM21+Pu0M
         +4Dlx57cn/DY0bqmGmpPx8KQBGRgNb1WK22vYn66uiXB9horFIk4Fg7TyoHq+448eChJ
         8xUnTZurWCcRgqZRiLM70i2IxiB1WHH9brUzNvCTc7jz7+6PsO8ETlb6ZMS9N130sko0
         gZHK1kRqJ23qXQOmIyb9t+CfORQ97KwKrs/K5kkrbOo0nuM/sH53x8GflVSqslJ3vRSU
         RsrdSCO+QawAQkwEKPsGlnSyv1hVEmHBrogXYIaUMVY+0n3e3FXQJKY8YNM/J3F19AZr
         wExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470883; x=1763075683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gueIN4a72rWkYCihuZZZl7f5y4PLrSamaFI6CqKoXp8=;
        b=hhM55PaXMJrjVwEAHKTf9WlUYXTw87xe/3+UcCFjMyte1ZxPUaC3jFaMFNaayC7k7S
         4bGZy7z5d8rFpgXdw0fxzxIxck4rx5lQb05ONNmPvVDMGGdUZrGF06swUMyiabmsAhFk
         IsT6F2c8SMJ2ENo3teAamYHu5fPW8s/1ZTHCnjwDaB4PSpa+CZ6AcSbXcM4fKxGMD4io
         bi8QFnJBZrYClx/a9SgBN7SnWFnsQSMoylEsjdPyRC2OcAslXxC4KAwb9xgLL8kiTvza
         YRnsnQu3Pg7raBL/m+oLjSgRqM5Il78S5P8qbGMlKCDZikGhyYrtrCgSvuMKtL1FM5t1
         mnMA==
X-Forwarded-Encrypted: i=1; AJvYcCVYs0fb3Yyt3zk3b5SDhiuvudJdFFYDAmVUHMgoEN0CxBo39dna+FCXptzHw+JbgEV3PWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMgA9L06spM2B5hbNGsSdXf9Gxwy18CUqXBgTp3XYnk63Un+e9
	K4bsv0lpskcqZmGNOSgxnXn5kdAP19JlR+CiBXmXWBcCTY7v997YN8hySEpMXTLxA/OhBGXKzDW
	zeuhSu6PiagFScXJB7++ZVr8R4TI9QL8=
X-Gm-Gg: ASbGncs4IPOExJY5of/CyrnvPDfQ3Ft1hyRaktfRIMKOSJaJCiQV1U8mqHTaMz5fZl+
	jaxCinPDoI5xW6fyfFdpBfVD4AFFry8bfoGXI+Pau9Of1iPVJHVkN9nirS3gvjzGRlMp/1PDB19
	1dsDU5Mh8UefMexYuONP2nuiPaNPyqSdFkIzpTrjJQGBNmIYupFQsG89dPjQvegQLs2WrGd2dmO
	7k5GA/f3Z+dX3Qg3KgkYPhzVG8VXPssBxqZVpjtp24+oLjOJa6TprJaFUxP94AMUwZzoDoP
X-Google-Smtp-Source: AGHT+IETezJPBPviY6N90ZgMoqJn/duqv1/ZrSuh7AxNO/QMioTkM6hNkwJoyJea0oB4WAj2qiqHVCPwA+FfaD3nWAE=
X-Received: by 2002:a05:6e02:2708:b0:433:2920:a0f6 with SMTP id
 e9e14a558f8ab-4335f01d41dmr19803645ab.11.1762470883245; Thu, 06 Nov 2025
 15:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com> <46bc1b3e25885fbd324a6428ee7ac3b5d272c4ce.1761776388.git.gitgitgadget@gmail.com>
 <3f7bbb5e-0d67-4ef2-82fb-e0b00683c178@gmail.com>
In-Reply-To: <3f7bbb5e-0d67-4ef2-82fb-e0b00683c178@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 6 Nov 2025 16:14:30 -0700
X-Gm-Features: AWmQ_blN9AHzUzAcpv4JqqBbzYAqSpU9r2BqbHo5T79seyQv70LVVcQ3o-HRPs0
Message-ID: <CAH=ZcbDTnvgrkfKYe_uyPHh5Xd2Pbw4532UvNcz+nz+rpbhUiQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of char
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 3:55=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> > @@ -156,8 +156,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfil=
e_t *mf, long narec, xpparam_
> >                       if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, nare=
c))
> >                               goto abort;
> >                       crec =3D &xdf->recs[xdf->nrec++];
> > -                     crec->ptr =3D prev;
> > -                     crec->size =3D (long) (cur - prev);
> > +                     crec->ptr =3D (uint8_t const *)prev;
> > +                     crec->size =3D(long) ( cur - prev);
>
> The changes to crec->size here look unintentional

I agree. I'll change that.
