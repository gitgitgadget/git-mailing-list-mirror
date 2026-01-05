Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6979286890
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621878; cv=none; b=DyTexnZunHUHooxW2yauAfNGc7l+zrP/VHTdDMNviez9fDexlMDpBYBhz3DeQyI8vbGdJovdExkrh8vu0OUikhcOlOwwcQH3rSRYceSxMVMkEPWBD53QTM95OjLBmO3YmA4mWCAnjU+dpiYgBzklMCt90qos9FmtRcMPdcSjNh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621878; c=relaxed/simple;
	bh=/+csrxPV2PIf6TbR+pnHruj4koU1SsTJxVyZzbfmyRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMqlLJLOTaGXKDaZN9jPLHW7fp6yd9VB76ycz5LM/8W+C6yTBddE7cbNQ7pgqvyCOoInJWXU55slL0Vba+V9nhQljWfOjGA4iABrjCdnKECT2dfcKUrwL7HXG48nPGqyf36RZrWKRlsTKjA8+qN00FvywDm09MNDAvc2R90Eu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ6zWaZo; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ6zWaZo"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93f69720a7cso7252291241.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 06:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767621874; x=1768226674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+csrxPV2PIf6TbR+pnHruj4koU1SsTJxVyZzbfmyRA=;
        b=TQ6zWaZon91WFTXUpt5FbZqsk0UHBNdbwdMUrL1KYClZkziMRxF8ynOoGo2D+cMOUy
         FFO/c7bHvVfo15tdGiRqg68MCfEuhj2Hc89FjM6owDO6tkYH0t9E2RumnaTAAKVnS0FR
         TYhnTbE9v7xaM7PtGLOerAFkdAUdmfR70mGhAITkjGJSrFySeIjy9UW7cOxZS5YyRZ/P
         vTUc/u12kki5Tbw+LZdNCokQqcMwUZpI1yE6ZkOMZRgdNGS8c/1D3m3W6ZBBXsdA9qOy
         +rwYLeHieDZnhLncBYtfI6k8lACIQOP96WJOxUtcqO+G+OpSHOsHJ9C5iG9WyAGqpx/+
         F7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767621874; x=1768226674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+csrxPV2PIf6TbR+pnHruj4koU1SsTJxVyZzbfmyRA=;
        b=pLxIJWFcribyb51xpcYz2mEHMleNOYiHdjaq1iv1mnkIwijKFbK9fDQtkqw5gpCQO3
         WLnPDc4dPcp41mbIvFvy5mV4kBdV6k6v2yQIg1ABvkFFsaPHQ6XwphP/KXxsitX8Qgqm
         MHtsFqmA2DcJrEuO+DA9HHU2tQ67y5IOTkb7GoOs218l+2i71deK6ukLEcgN2dm1BZuO
         2OTDls6cZ7BM0GZs7xz7a8eqYDylPELqZpGAP+Pwu0C6cPLazvN6mj+e1tuJBwOY8RT7
         k4gDM5aj7LiPlPAdJLvuBDSqDosqQ/wa6xYv31hbHeIK4QatGrwLn8NxI39i0pmXomda
         aNkw==
X-Gm-Message-State: AOJu0Yx2jb+ONOZoRl5XHF8JbzLoK765K7kWl8jA+sXyVdNdBWmtogaO
	JFQeo8Nk8R1/WXGbqDEhYq+/69gqK5XcyNfMfccQKOx3K5afTJ71X6+37nDD5gpAg+FloIin7aj
	i3JqjHpV7FtYbEUMM5gbTPSl/icNmk7a0v8ORjwo=
X-Gm-Gg: AY/fxX4WHAyTqNfJNPb9d7FoaHNBX975Gmkh5UVey0lA+MzsBg6gussEISF0T1dSqY6
	Xs2V8LpwZiGNUdJaYcKoUamK75KlXwEjfyhAAahXmyiLTWR8W6CKyxgAZ4iuvy5tPVzScc5gvN+
	KGewKEEPOfwBBLCuBRuog6Et39+kZ5k1+hBNONMryNBHzXeg0ENHeho1qUxRi22VwD4Vg6ljNXO
	JuJa2MQLOqf+ooDYHSVINPvGrhIsGdvyUKb4Auc9Qj+sScEsHMXstyd+xKvqB/CjBxWAfvFmY+g
	lZSCrA==
X-Google-Smtp-Source: AGHT+IHm3iRPLnPS5cn4bEifUh5vT0lu+OeBK7TpFZXm68257ZQpbFqXlR8yOBe1GXbh/byNUIMbjvEZ0y78y5ofkMU=
X-Received: by 2002:a05:6122:a04:b0:55b:305b:4e31 with SMTP id
 71dfb90a1353d-5615be51feamr16347426e0c.17.1767621872759; Mon, 05 Jan 2026
 06:04:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fa1BB2DzDFj4+GLqtDPg55JCi9VGCv0pgj2C8y_PaM5rA@mail.gmail.com>
 <CADYq+fZ2gempytBwUKUMaV29mdHStueuMYMdqwM-7W_eyQ6znQ@mail.gmail.com> <CAP8UFD0pEjjfiPSrXDnTwNbS5MFaRaEfWvnOUja2A5x2vtBuAA@mail.gmail.com>
In-Reply-To: <CAP8UFD0pEjjfiPSrXDnTwNbS5MFaRaEfWvnOUja2A5x2vtBuAA@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 5 Jan 2026 15:04:34 +0100
X-Gm-Features: AQt7F2q0OBDxpi48-9kLT9DoPKC1VZUHCxRfcemanfbRfPWqsVufXcHr9IiRHWk
Message-ID: <CADYq+fYc3rRHSS4=XHEL49U+UeBrPo4oQeOYHnPaU5wFztK9UQ@mail.gmail.com>
Subject: Re: [Gsoc] Early Introduction
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 10:35=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Samuel,
>
> On Thu, Jan 1, 2026 at 10:19=E2=80=AFAM Samuel Abraham
> <abrahamadekunle50@gmail.com> wrote:
> >
> > On Mon, Dec 29, 2025 at 10:43=E2=80=AFAM Samuel Abraham
> > <abrahamadekunle50@gmail.com> wrote:
> > >
> > > Hello Git Community,
> > >
> > > My name is Abraham Samuel Adekunle and I am excited to introduce myse=
lf to you.
> > > I have a strong interest in low level systems development and I have =
previously
> > > contributed minimally to a couple of open source organizations and I =
would
> > > love to start contributing to Git for the upcoming GSOC 2026 program.
> > >
> > > As suggested by Christian and Lucas in previous responses, I have rea=
d
> > > [1] and [2].
>
> Great! Thanks for your interest in Git and welcome to the community!

Thank you Christian

>
> > I forgot to mention that I had started working on this #leftoverbit
> > and had sent the initial patch
> > below.
> >
> > https://lore.kernel.org/git/aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.loca=
l/
> > I will continue working on this after receiving feedback from Junio.
>
> Thanks for starting right away!

Yes I have pushed updates already and this is the link to the patches
https://lore.kernel.org/git/aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local/T/=
#t
as I have made changes from reviews up to patch v4.

Thanks
Abraham.
