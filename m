Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038C16A92E
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605314; cv=none; b=MzSrjHPy31wuuoIp/k8Aei1PQzGw2axfnhAtVOkeh1PR/nTsPHSeNeWFO9Wl+etdAXGC3zc5OmVxNq8Ytrqr622kUP+FKI759PyDGnI/hGUrruMpXpPms05weJdCpYr07Umj0eKKE/73ddYOI+MSXiBL2xgsU183oZPvYX1IZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605314; c=relaxed/simple;
	bh=U4j8s3IiBqAqB+JlwWMzR/1PYPOpJGnwB/dA1Pr0c/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiOOCOP0e8jS/Y0BI8jDzFp5g7lJvX6SiFkLXnyZ+VxDNfNsSUI8ZyizmL2/Sy+E9fhuhD1ScuTSY7avcofZTyU/O3ZsxQV4eG0sxtuMEuspkxDNkvD0ezOCuLTysKtaA5BvNP9B08sxWNxQxo8I63qKS1F4UNXRvrWIOYX78+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTUTT21P; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTUTT21P"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a47dc2ef46so1541649137.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729605311; x=1730210111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtMJySQWZYbM9O6JV8jgGLEGH3O4qiFLyRgQ3odTm2k=;
        b=iTUTT21PCMPq8WebokPtMwLkRGR9k22aFlFQTnAv9GY/eUpmOAgJhfW0QKF2+NL0RU
         0at70iPP9Fmk5+q4xeEmYNRA8VVieFEZrhg32py++sT1GATNhEHWXC6xZZyaXYftLdOf
         0xikmnnGpv0zPLHeO42VRF777feXQhTqxdN9q4t2NZKHt6UmWl80A/dmjyfWPZR5pqU0
         FOTnQmiWkv6IUuq9BKoOIpRgM42ohVu2lQLOoyA9Er1APMrLghtBzVB953mOWdhjpP4B
         BhYd8o06fXlPCCefjp/O4L/P7gpDx4MS2FzFGFBoFUiRSBq7YJ0AZgwTwF4Oas0vlA3P
         +BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729605311; x=1730210111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtMJySQWZYbM9O6JV8jgGLEGH3O4qiFLyRgQ3odTm2k=;
        b=fbWoa7lIZ/NxqUV/ayA3zctxzz+0iF3XIbC3QFM69ovGn5hXQ0aEa9PYtMi4gzzS+Q
         iKxB6lBtIT8oSVhdXYVmu91s/2Eoq6e7UYLltcOt1g+9b7lWjuO/FrkFSpUS5T+CARdW
         ktBTx0XdEq92EQ3Vt69vueIdAXlht5a5sJs35wnvma/o95Y7ltEf3/nK58rIUNQQ5f7T
         T1t69GFHsTE5JxbLE08/CgJ4j8q+MA1bhYPVoDw3N19v39Ea1Xp/mnUPXfWFL03zPhdO
         6fXZMdGzi7j9oOrEwmBbIHs1OS5SwtEkGYw4MD12JGLecGyOe1HRKi2i2dKFhGZjfzbR
         OcYA==
X-Gm-Message-State: AOJu0YySds8Fx/cmde8HkvGUURLivZKK0iq4ccpZWlWif53zy8e0ZQCh
	mingPiqy7HIqC3Wb+9/hctaxyN+5GahxGm0Ui3GdRIiI5gm42vnZiC/80WJ1ybdSlLEUk8MRtr/
	HYWKlIn10C5GftEL+wiH0Xx4n0uk=
X-Google-Smtp-Source: AGHT+IHx7rld+ziI1XRTwmHMRfG9X4DdVbq/nfLWN26POHsidl1iGT6eZOe9dY3evTPHiZ+WEoiTaQxYDBUgkOsnReU=
X-Received: by 2002:a05:6102:2921:b0:4a1:5415:19e4 with SMTP id
 ada2fe7eead31-4a5d6b9df37mr11802357137.25.1729605311388; Tue, 22 Oct 2024
 06:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
 <ZxeWDTFHpHmVePdF@pks.im> <CAPSxiM9WQMFu+qTgR9LPk9erVUFgPU5tqRBobTomOJhm-hiLAw@mail.gmail.com>
 <ZxelBccIFk1aXP3l@pks.im> <CAPSxiM8bu9LErD8H13_qgb+MV224TbEFzkSr4f74YxEL3Sg7+Q@mail.gmail.com>
 <Zxesj10G3bn27d99@pks.im>
In-Reply-To: <Zxesj10G3bn27d99@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 22 Oct 2024 13:55:00 +0000
Message-ID: <CAPSxiM-wn7x1PyXsAvT9n0P=E6jBgieVEswfrFX3kUU-HqyjZQ@mail.gmail.com>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 1:46=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 22, 2024 at 01:39:21PM +0000, Usman Akinyemi wrote:
> > On Tue, Oct 22, 2024 at 1:13=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Tue, Oct 22, 2024 at 12:54:18PM +0000, Usman Akinyemi wrote:
> > > > On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Patrick Steinhardt <ps@pks=
.im> wrote:
> > > > > On Tue, Oct 22, 2024 at 11:45:14AM +0000, Usman Akinyemi wrote:
> > > > Hi Patrick, thanks for your reply. As you may know, Outreachy has a
> > > > kind of form for submitting applications (they have some set of
> > > > questions someone has to provide answers to)not like GSOC where the
> > > > applicants do not fill any form for their proposal application. I a=
m
> > > > guessing someone should add something  like self-presentation in
> > > > answer to one of the questions as there is not really any question
> > > > asking about someone personally. I think what is near to it is abou=
t
> > > > previous experience.
> > >
> > > I wasn't aware :) But agreed, previous experience sounds close enough=
 to
> > > me.
> > >
> > > > Also, anything about applying to two projects ?
> > >
> > > That is a good question. The only thing I could find on this was the
> > > following statement:
> > >
> > >     > You are welcome to apply to Outreachy multiple times. However, =
you
> > >     > can only be accepted as an Outreachy intern once.
> > >
> > > I'm not a 100% sure whether this means that you can apply to multiple
> > > projects or whether it means that you can apply to Outreachy multiple
> > > years until your proposal gets accepted.
> > Applying to multiple projects is accepted by Outreachy I think, as
> > someone can submit an application separately for each of the projects
> > in a community. I am just curious if Git has anything regarding it.
>
> Ah, our mails crossed. In any case, I don't think we have anything on
> this in the Git project. But if you apply to multiple Git projects I'd
> strongly recommend to state which of those projects you prefer to work
> on so that we can make an informed decision here.
>
> Patrick
Noted with thanks.
