Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64982882DE
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703112; cv=none; b=MC7tdUtrb47ponOw1sb0QnI55xjyCoRg7JudzQ/i5pBwCLoGbUM0mlz1In3FYva4WqK0a+DdJ4a9o+C9dHTjdMROJVOR0wyTWIZGfKc6x1pZLtnqBoU7fx/slkrCXpQw/fOPb7fm7W3pYXt9kd1JFLOdieZT6OdFUyeizKNkHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703112; c=relaxed/simple;
	bh=yokxg+XE8gzitK5xMBAwj7nV1D9GQX3DbnUzYBMOdrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgEIlu3wWGth/QtLcxjvybP8esJpwmW7SEQd3q18r8FHw97hz+yXvG3kz+kaeSmlkI7hvEjoFVYJJbl3liBvRcPnbmtxi+oVQh1BDDNJjfrKOi5zpXRZ91zWKmZ/YWuQVebWUZ0apbif94My1UiUmO/rP8uUQgUbn5V6SY28WcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhpvaDN0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhpvaDN0"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2e66a300cbso505099166b.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758703109; x=1759307909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yokxg+XE8gzitK5xMBAwj7nV1D9GQX3DbnUzYBMOdrI=;
        b=mhpvaDN0lG7Badk38ADGAIgmGTB/TgGcQcU+YeOvePyPY2/EBvg5EbQCxOspucaYdj
         m9MkYPpOk+U2cAywqMopno05Ejn8sUH3AId8itTAk0dJY/nz2Ysv7j8IYdfMnuztIv+Q
         mr4vB5rOwpL8dP+jveyEoMC876iZzZpNdUM0Ow1ee6sn92Kg08DID3uh9kWYq4SY4ltm
         L/Hqaec/5wJScD1CLtOIfq+URxg/HvB2Y+9K8oEiTEwXQazpgheGVT2hLmNONT+7p1Ev
         puqse/xSPX8lRCQgLtJp4415pOz6tSG5Qowp0eJMw/t/962CYqjGxvRBRz6/LAbHTL16
         zRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758703109; x=1759307909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yokxg+XE8gzitK5xMBAwj7nV1D9GQX3DbnUzYBMOdrI=;
        b=RryVK82su/t2iwf28eML5X9323BGh0In3r2xPiMnGgZHrSK7rAaAJ0CDOOfY4/p1nf
         T8mhfawSKoW2iHJkzjkaNjp1I3IDvEa1oYitvEHQMggOTcsW6P/P0XLaY81hGFu+f3m3
         DvzrBqUbz4nJAy3JssjnAdxkrEBNfcQi1EM+zT5fPFjkfL5y2qMLjg2h31m0ija8ILMJ
         LUsja7sE7wE1GmVZORkaoJmAaWAX60uPe3GCob4ZxCLvF11kyWArv4lVlclwkQebohAF
         sQdC+E0+/UJ9n2dHD2KdUzNzfIVbzdx+TgRQftlzqKYWJrAZBu69GEK0rieiYi8J/9EK
         F2nA==
X-Gm-Message-State: AOJu0YyqJa9u5Py7n93JB3WUzSwQcZfsXzPVbDrIqD7Il/jSNJAglVZC
	yGdIUhTBGgp7HlaeXxComoYP34VNPoAPovmDC0dpsh+88BsTyx9GkhvXAUTpoVXjrEuTiMaAegd
	NQTXPZxxSauHDVao9qo2FsmZgEZtlIG8jh8QV
X-Gm-Gg: ASbGncs0A/egQskrmkxEogedDD12usuaxhB5RYb/1JUcLig078J4KDuQKT61UiQWqOo
	MgPRT5Zf79lTX5gUgO3hcttTcYpu/FsXTakQ8TAsDDWt2SUOgRWNlhl5etHiNxXhTpHbb1++mZ6
	/ZewypvHYaBzMNmTJqgzjEULyKBMfYvRIEREbgjFJAwAYPkuV0R1sfeDiPDSqqXDovA/f7V4ia8
	Bs1Vs1G/nuUIrAC7YLmUWer62+GthXzRSOgc1Y=
X-Google-Smtp-Source: AGHT+IFkbeGdBmgYVxk6i/R87FaRv3Edakyfl9SItrLmm4HHycaP4z3VN4Mv4Cr2KcoV2+6KkZJQGBkjgWEVCant77k=
X-Received: by 2002:a17:907:9482:b0:b18:63b8:c508 with SMTP id
 a640c23a62f3a-b302c00a739mr505656766b.44.1758703109023; Wed, 24 Sep 2025
 01:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
 <CAP8UFD2asXf_4_02khYRVWVQruBdvoMkZVE-6cVHttT9gHdWqw@mail.gmail.com> <b5867a92-c516-4a66-a108-8cabbc166336@velocifyer.com>
In-Reply-To: <b5867a92-c516-4a66-a108-8cabbc166336@velocifyer.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 24 Sep 2025 10:38:17 +0200
X-Gm-Features: AS18NWCRA_jG30e_EcnXRgQymP2GNgzx_Llk-FUIwqX3Un-tH138jxqBW7sfQl0
Message-ID: <CAP8UFD0t76v3XYgoLjZ-527EePQKihSNyA=AO0QjJHDy=u32JQ@mail.gmail.com>
Subject: Re: How do i get news of git releases
To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 9:42=E2=80=AFPM =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=
=9D=F0=9D=95=A0=F0=9D=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=
=F0=9D=95=A3
<velocifyer@velocifyer.com> wrote:
>
> > The URL for each release points to the announcement email on the
> > mailing list archive. That email contains the release notes.

> If they already have the realease notes on the mailing list, why do they
> not have a seprate "git-announce" mailing list with just the release
> notes and other important announcements

We try to keep everything on a single mailing list as much as possible
to not split the community. Also what is important depends a lot on
the reader. For example Git for Windows or Git Rev News announcements
might be important for some but not for others. So many people would
have to sort things out anyway even if there were separate mailing
lists.
