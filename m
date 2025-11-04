Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262A23B604
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280561; cv=none; b=gHjUNaEhKjR+QD/IunVHtBtpU5iu3I6JAgWt1Ulo0ZpxWKCH+99fEMMaS+6e3x9/bgsZNZFvH+Vh58fgQVEpfLoQFrvIwfTI1/kt0eiBkfnk12fyGbLXp4u7SaTPfpP73fPwrZqwGzX53Jkgx0EotVCqzCUmnZnO43zhdMZiJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280561; c=relaxed/simple;
	bh=bVZGGTu+yFUF6oVRqipMTji42wK3hUu1KDh0yBrJyAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTfYM499++wWhZoYdWcOJnkL6DTOuxA0AinfQpSJxK+/uQgNeiNEo8o2sHuE1Sg7QaLHNX3CfRMTtLIp12+PGzWZFx3M9NdSFT3/xbCf7FLvPRpMzq+bO+tbwrdeURG3ByUu4rij8QsSsnt55fBS5yE2Kmy4GogrTFABVylrsXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIOpd8u8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIOpd8u8"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72134a5125so217611166b.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762280558; x=1762885358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCv/yUlvCUDFd60R1ObJoBQd4+kHwnywQSb3XnJxmTM=;
        b=BIOpd8u84Ym2rny4yG7n66rfAt9etQKYEk8eiGT7N0BclzUQDzKtOBgkJXBEbOArxp
         YBvsKJGG0saMr2wzHCVczOyrOE1+VoZslBrvhpzX5EQMu/XTZtLfdysuLX5BrS1aTBeZ
         +2FvIkZ4kRoHtZSXXWIQCdiZVilST9rcGQkpBCjnrqLnu7UwvUpJBfAmsdN3EmeHHW4G
         1La1yK9D6ZPAMhicsfuTb0rGP6x95KCmXt+xsCgCVSVi+7GAZFZfF2dCTCAvNmTYYW9T
         OGXOe1NhlNixrgG3Pu8WV7O2MtxHKTHxSicbHYIoQVxUAPKM7roKXpzl3tL/Tjti9ihr
         33Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762280558; x=1762885358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCv/yUlvCUDFd60R1ObJoBQd4+kHwnywQSb3XnJxmTM=;
        b=F3GCoHDqu4+FhHtiuUw6bILqrYHZRKcdS45LFIyarNd6eUBke+oHOUMtANT4qSKZnS
         F4eOUvcRcLnRnscCRd1mg303ZSLJRO7RbtOogoaUOJfr8UeVdE6sqY9yLno1XXK0O0Bj
         Vt1nEGhHoGt5rZRh59/Q7Oiv/N1foUJn9+AYwI/9QlkGUT5L9CnFDe9WAq+cJ/tR9o8J
         4dERJCG3cD4SJ4/i0c4CLaYJdyY6sr9IgV0XezJgqv+ZQ6sSk88//9i4uypXFpiOqIGf
         /AXlu8A6hFwp8j+Yb2CZZNptQt2Hfd5V/3o/Mxa6Tg5BmaP1RXDCX0COGbi0ML7UZWdJ
         CQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjwTNqv0Hbz82Xn/2/dM8pqtXOm35azXRpt5c1j3PKRUQV+WDyd9qhdYwUNK0pQq+LZB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFHgPt3a/jfgAYkkgfor30H0hgWmqPxTIDXdgudG//EJHHxqj
	SCkvDQWnYbY/Y19YlDF+x3pbP9OQdZq0deEUB0JG672hMZ6U2Dq1RJfccFLB1OCdZCyPSzayikz
	8cxK1PrYQX3SnlthC9R6yt/l2VCBlGFw=
X-Gm-Gg: ASbGncvgyB2L0hprWCn53xyHb9rqisnDAO+9JdIeiDNfIZi4UhD+qpVYPAfVTQNTqAv
	ECtbTnL0c8e1/1mOkPx5jdA8Vm1mPepP2q9DY5ptIpaGjn1jovTjtchchi4VHeKQNx3mbc1jinz
	p29ss9OrQSDzS56k2FoNK4AqgRhUfIyvXpH3paRRYZ5HZ1gs3dtJqc3rp+ihs0Uovv41cBqtjiP
	FdxARAyo60Aiuo2Hz3tUPDs+CgCTZv+nCwBOAc3qwk4QFEGpR9CSLlIuO9eTsiiz1ny1jIGQlZR
	tyN2zxm44NGDnyDa5Qs=
X-Google-Smtp-Source: AGHT+IHCZDtG/7jSHK6y3cLHP2s4CJPHXM92hpsi/0MnjvGN/wdj2vsl8z1DaJ9GN9gQ3KSYFH/sudQS4VUyaMQCIbs=
X-Received: by 2002:a17:907:9492:b0:b70:ce44:113 with SMTP id
 a640c23a62f3a-b72654c24c2mr12220266b.30.1762280557457; Tue, 04 Nov 2025
 10:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501214057.371711-1-gitster@pobox.com> <cover.1759094936.git.ben.knoble+github@gmail.com>
 <5f7057c236c9af3152bd531eed2e4ad0ac35e291.1759094936.git.ben.knoble+github@gmail.com>
 <e8755a04-bd44-4ead-ba44-c603bffcc75e@gmail.com> <CALnO6CC=FFuMmBfJPzunUqDOBMBtmXm3i73y9M9LgRrhxzrs9g@mail.gmail.com>
 <CAPig+cQLri3m9398R0JEf2fafKVkZBvOdxvpg=xPF2aZ6ayDvQ@mail.gmail.com>
In-Reply-To: <CAPig+cQLri3m9398R0JEf2fafKVkZBvOdxvpg=xPF2aZ6ayDvQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 4 Nov 2025 13:22:26 -0500
X-Gm-Features: AWmQ_blQF7G4UAFHdMGBRWy2oEST_JcI76LFSmNgDe1Rq8U28ZiVdqKnZIFBjW4
Message-ID: <CALnO6CCDuUNiRTKbuRtJ6nY6OsxqGKvqzzZgYDOqTPZjEJ4MjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] parseopt: values of pathname type can be prefixed
 with :(optional)
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Noah Pendleton <noah.pendleton@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Thranur Andul <thranur@gmail.com>, 
	Michael Grosser <grosser.michael@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 7:10=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Sun, Nov 2, 2025 at 11:20=E2=80=AFAM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
> > On Tue, Sep 30, 2025 at 11:26=E2=80=AFAM Phillip Wood <phillip.wood123@=
gmail.com> wrote:
> > > On 28/09/2025 22:29, D. Ben Knoble wrote:
> > > > +             is_optional =3D skip_prefix(value, ":(optional)", &va=
lue);
> > > > +             if (!value)
> > > > +                     is_optional =3D 0;
> > >
> > > I'm struggling to see how value can be NULL here as we return early i=
f
> > > it NULL before calling skip_prefix()
> >
> > Doesn't the "skip_prefix" above write into value? So I think if
> > "value" is exactly the string ":(optional)", then after the call to
> > skip_prefix it points at the null terminator.
>
> I haven't particularly been following this topic, but your response
> suggests that you're reading the code as if it says:
>
>     if (!*value)
>         is_optional =3D 0;
>
> whereas, Philip is reading the code as written, which lacks the `*` deref=
erence.

Indeed, thanks
