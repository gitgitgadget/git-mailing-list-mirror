Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508573D0D5
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939260; cv=none; b=joBjxmFS94JlbAZPL8lQukK3j3l3R/gG0+1J9wPn42zHD8wnpdXziXJv1fBElgx70sZ32BKtBQda5YWKBrZ6vzfkJx7XdfCBt8fTjQiQaQm+X0nPwgXFdxwuFKrocX63GWN/ZjoQbN7WOq9Pi7cD3x+pPXWdPodF4ONzgEndV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939260; c=relaxed/simple;
	bh=0uuUxyCttsg12AHPWCyBjVcRq6xoUmEFfucSFEQPd88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTwuNxR24D78Wb1ro/oZoAdekyf1RADfwjfQYeixg7pTjTvGEOxtOcADMAt3omUEMBAyQBMKljWqEmdSsojZFj7T0AfmLv1mGdUq/9j+zdKjJqMbNKcJXXpyjC+6CW4NaAv69MiSX7Zx40aEiMxwTSyCNxDxuEaFJ0mJ4I3cycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LownQs0b; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LownQs0b"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fe76fa0b8so82621cf.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721939258; x=1722544058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MNjIXEtlvmaAGUr4hTAyl5kwXJLxiKpTSWZoXmIy78=;
        b=LownQs0b95yRYWM6dIC+nxeJ7IFRr6BI7RWzXM6iEt5RayyXVMt4CF6wCSWsurIsDd
         fL7qOhj0e77Qbkqu0NoU82HcERJoJqOL3bWQ6aQbJedGmChvUtfxFydI6tIbnRxO7Czp
         kAgnMTo3Weh1JL3oH+cbH5MBxvGgl9+a7v6wOVdSIEUwfA/TJXxE+0aniZ3ss/N8xfTM
         8EGP0qSEJ56vM8iAdLFc/x+t51M2Mo+mQnhdk1DI2+cL9dqbci39H1Z5EfE1m34vfK7B
         BtU6N02WlOj3Znkjoo6PmeI3HB/2fjrsz4kj+T9eel5zfGPVGlbfhts43kKhQ59L+5Ah
         bLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939258; x=1722544058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MNjIXEtlvmaAGUr4hTAyl5kwXJLxiKpTSWZoXmIy78=;
        b=SH/9dWqv6ya0qYNaVAKmJFmR2Br38OUh9joxicNY/1GEqLFYEQRQEYLqF/cyEwU7TQ
         UW9STSqXKpyEZFwOs+eWYWZWvY7vZeQPYbrslR/nsqCu4+iGz/PAovSuLzkXcQKo4Sdw
         fey13Q9gyNRegD+JajushQ7aaG4xttBLeerrMy9j9IbCE4RVRoCFNznQo91MZ0Wu1x9M
         pHIGVwLT3Ff9WHu10EFirRx/46XtGU3X20cCSdeQ6snOqbFCukeJ2D/XkfonVYWPGbTq
         bH+IEPZT6VWUsRSKPSAoZexsnAzqRANDENZKx2jIKbsv4lE+F5XaayxkKpdvLprT/LP8
         D9Vg==
X-Gm-Message-State: AOJu0YwV0bZ2lSyVT9ddAMKrZfajqXMp+ILiwUGzkAlhAzpB/sxJ316v
	l2IEz0T5z6IuXDOpUoqFiUOJqCWxj6PunYD0Puded3nhLZUQAEB2D8nsnjp3AXMWcXJyfLgWMVl
	n8o7AtxsKT2YnTscRpEdqK87jpyJ7UDfgdb+7
X-Google-Smtp-Source: AGHT+IGA87I3huYaI5ewfWFUY2BWWmOL7r7amKDvZ72uRGc8zh7jUDuAgqPWT3RPdQEmebLtdsH3elBjnJiCvwJyjNM=
X-Received: by 2002:ac8:5e0f:0:b0:447:d555:7035 with SMTP id
 d75a77b69052e-44ff3db0ba0mr558691cf.13.1721939258043; Thu, 25 Jul 2024
 13:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711232413.693444-1-emilyshaffer@google.com>
 <20240718173843.2411415-1-emilyshaffer@google.com> <Zp9xiYVh11KurICO@tanuki>
In-Reply-To: <Zp9xiYVh11KurICO@tanuki>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 25 Jul 2024 13:27:24 -0700
Message-ID: <CAJoAoZnqheGE94jH4UNYpX+6wSfVEJtGXABmP8Df0q5L7jaXmg@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 2:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Jul 18, 2024 at 10:38:43AM -0700, Emily Shaffer wrote:
> > +* If you rely on Git avoiding a specific pattern that doesn't work wel=
l with
> > +  your platform (like a certain malloc pattern), raise it on the maili=
ng list.
> > +  There are a few ways to avoid these breakages, so we'll work case-by=
-case to
> > +  find a solution that doesn't unnecessarily constrain other platforms=
 to keep
> > +  compatibility with yours.
>
> I found the latter part of this bullet point a bit weird. We don't yet
> know about the specific pattern that may fail on any future supported
> platform, so claiming that there are ways to avoid them goes a bit too
> far, no?

I guess I had in mind "some entry in contrib/ that happens at compile
time" or "some preprocessor define hack that happens at compile time"
or "???", which is where I got "a few" from. I can drop it, it is
wordy and "we want to work with you to find something that doesn't
suck for everyone" is the important part. Thanks.

>
> > +** Include a comment with an expiration date for these tests no more t=
han 1 year
> > +   from now. You can update the expiration date if your platform still=
 needs
> > +   that assurance down the road, but we need to know you still care ab=
out that
> > +   compatibility case and are working to make it unnecessary.
>
> Do we maybe want to replace "from now" with "from when you add them"?

Sure, thanks.

>
> Other than that this document looks great to me, thanks!

Thanks for the review.

 - Emily

>
> Patrick
