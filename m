Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBE1369AA
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738416652; cv=none; b=qqJjkxjFMXrImtzN0IEkcj0jiQacZgGAWHuV6ptYoUARo/gLRDFiyv0xoGeghpqSt0yHIoL6xN59AYaUZ2wSKK3Md/XlhEk6zCfQaWwQ2GWW2XfXou7Z38acVHMid5SeYkVbEJ9wcRM1lJaMsl7goksyZUhWCMDupHwparJ5yyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738416652; c=relaxed/simple;
	bh=eTn+QraW4S0RaAnLwZQhWgKvpb+UAs3Wb0gvc5J9ZWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1pt3koTS83fOxKLb34nAG9E8yv/neHaef0q685tjhiEf47PIsCkbLOBnf970Jtt3ae498CUcp8/K4nxTDGrVYuAmyffRyjPHp9VI/FnWer/dPyvIMdHnJ/pDaOPfFza3wEnP7uVEW1J9pJjtNDv1iBVhBs98ctm2RKoHOHlgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koSR0m9+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koSR0m9+"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab651f1dd36so588655166b.0
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 05:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738416649; x=1739021449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYTxl/PNV2vyWdhCDqgzTnYc319ILGptkPS3BNmz5o8=;
        b=koSR0m9+tXHFdY9wIs+4ej80rKmsCPeo2R1XkDhBTRMms4VwPpvyyV6BCb+p1V5cs6
         z55smva3x7h7eqe4EyoNI2kkiYeVUBT42s6xnbcyzRfcsSo6OVsZDNCClCXAWou1p+qe
         k2Ydu0D7aQfN6mffzY2TjpTDIVoBSegjTJg1DzIy+0tkVip+kT/KV+WW55TsMsN9pb+i
         Y1HnifxVkXKLGGtBK9NDzKGXuPVspBP6i9buy2UDg93j3OHq7ThNpYzL2mgpcRlNiksp
         PPLaeH3C9npT9SmpCo6/v9TQZQ21d/3GW5mEy3dAw3sJaWygOSh/ki5a7elnxf++BAvw
         kiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738416649; x=1739021449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYTxl/PNV2vyWdhCDqgzTnYc319ILGptkPS3BNmz5o8=;
        b=HQRN8vBv8pzokKXdv36W94jRna6JSZ6cmCfdZrJB/5wWn1qohtfK8iEGd6GEIragkd
         VJcrMu1dqw+91JU67EIGhaMz3Fi7CiXN3g/7DliW2pdKw4HmwjYdCLWkngCnivjOIf1c
         LofNVST60i1QQxIDKChmSr0v4eZxNPsweBnvTps1JS8Eo1qnAmSb1tfzsVgoPdf9PAKV
         Vz9nLJg6jIhiIc+rRg5oPff9winCb9Vgca8FXUUJWwHQMhMHVvOehPbR4OJlMNcCokDG
         CQOC+9j1VgAFaONV3dta2YPf/lp6J7MX03GSJ96+jQ6dNDQy+018eK8gcaioEqsOShJ8
         0nLw==
X-Gm-Message-State: AOJu0Yz7wZkc7qr6ZDzupU5CjtO2OuYluX2kVoRJYUmHSelUwTR8kRj2
	kJjdmvQij6SCkByMOsiGSQ1H6mFB9PS2pOn1WaVBrC4XjWvxwUMZsF+9SdC9p/9XMB7IQhSWMZQ
	q7VjVgTwL0tBC99uxsFiKT7gsewx4R8K9
X-Gm-Gg: ASbGncsUexiF+hjGQ5kpPd3D2TjI0WK24ZANpEZYwZ3uezUMpl6MItBVY95WTjT/lsL
	/RXXoX9hbef/xVwLzupgym+KXk5KQWZI0rq0u9DJNmTk5uBuhgQnPpi2CtvK4cR4TTcM8oSb47Y
	q950A2HIU1g6rgk5sRI9QZoGlTRhwHQbc=
X-Google-Smtp-Source: AGHT+IGXL0xkokVB/5iNAoaXtSvjpKnRgIxWLQmmbtlhviSH/fL55YAMM/a91EVJc0a1oJTC9qIeZc/i56Tqk8x2mrk=
X-Received: by 2002:a17:906:dc8b:b0:ab2:b72e:cf44 with SMTP id
 a640c23a62f3a-ab6cfc8730fmr1748234866b.2.1738416648846; Sat, 01 Feb 2025
 05:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071210.30509-1-amch9605@gmail.com> <CAPhwyn0tGHuX_Gh=rno9wj8fLb6zG4M3QAZyQDQ8qZyE+Uyg_Q@mail.gmail.com>
In-Reply-To: <CAPhwyn0tGHuX_Gh=rno9wj8fLb6zG4M3QAZyQDQ8qZyE+Uyg_Q@mail.gmail.com>
From: ambar <amch9605@gmail.com>
Date: Sat, 1 Feb 2025 18:59:35 +0530
X-Gm-Features: AWEUYZnaD-cBomhyZ24O_l7jsNtwyEahXsKO0wkL_p7yl4Lt1wnnFNmtYjALkpw
Message-ID: <CAMG7Y2w5ANKYG6BsfSmELtewvgU3A0hpYm35EMi__70OO_rtnw@mail.gmail.com>
Subject: Re: [PATCH 1/1] t5401: prefer test_path_is_* helper function
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Instead of sending a separate cover letter, you can add it here between
> "---" and diffstat.
Understood.
Should I resend this patch with the change ?

> The patch looks great! Thanks.
Thank you for your time and feedback :-)

Ambar

On Sat, Feb 1, 2025 at 3:02=E2=80=AFPM Meet Soni <meetsoni3017@gmail.com> w=
rote:
>
> Hi Ambar
> On Sat, 1 Feb 2025 at 12:43, ambar chakravartty <amch9605@gmail.com> wrot=
e:
> >
> > From: ambar chakravartty <chakravarttyambar@gmail.com>
> >
> >     test -f does not provide a nice error message when we hit test
> >     failures, so use test_path_is_file instead
> >
> > Signed-off-by: ambar chakravartty <amch9605@gmail.com>
> > ---
> Instead of sending a separate cover letter, you can add it here between
> "---" and diffstat.
> cf. https://github.com/git/git/blob/58b5801aa94ad5031978f8e42c1be1230b3d3=
52f/Documentation/MyFirstContribution.txt#L1220
> >  t/t5401-update-hooks.sh | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> > index 723d1e17ec..17a46fd3ba 100755
> > --- a/t/t5401-update-hooks.sh
> > +++ b/t/t5401-update-hooks.sh
> > @@ -64,14 +64,14 @@ test_expect_success 'updated as expected' '
> >  '
> >
> >  test_expect_success 'hooks ran' '
> > -       test -f victim.git/pre-receive.args &&
> > -       test -f victim.git/pre-receive.stdin &&
> > -       test -f victim.git/update.args &&
> > -       test -f victim.git/update.stdin &&
> > -       test -f victim.git/post-receive.args &&
> > -       test -f victim.git/post-receive.stdin &&
> > -       test -f victim.git/post-update.args &&
> > -       test -f victim.git/post-update.stdin
> > +       test_path_is_file victim.git/pre-receive.args &&
> > +       test_path_is_file victim.git/pre-receive.stdin &&
> > +       test_path_is_file victim.git/update.args &&
> > +       test_path_is_file victim.git/update.stdin &&
> > +       test_path_is_file victim.git/post-receive.args &&
> > +       test_path_is_file victim.git/post-receive.stdin &&
> > +       test_path_is_file victim.git/post-update.args &&
> > +       test_path_is_file victim.git/post-update.stdin
> >  '
> >
> >  test_expect_success 'pre-receive hook input' '
> > --
> > 2.48.1
> >
> >
> The patch looks great! Thanks.
> Meet
