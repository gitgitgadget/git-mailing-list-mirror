Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818B8F6F
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917637; cv=none; b=d7hsHl5kTCB1ian2HiaoG42jmgLsRpmL958Mz3cdhxnpirAOiYCLiKUeyrV7EXuJ/C151mqsPDCMvAqvLRW3Ntv3/lt605Q5/dAxyifMxa5WrgIjUSKTKVzhgPZSp4qD6bvcWLMZb6XMGVZH1lYm4gMJj+bYDEOXQCWU53pxfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917637; c=relaxed/simple;
	bh=wYcjszV/FqlC86E0HcKChwIWOwSoSa49I0fMDRJO2xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6teoHFaTdq66QjISxz6K6CP1yaVYIgaw/N8RfgEWzvhj1Z6JoFTXheED+6WDndScnLtx5bHdIz4mfBlTly2rhn+FybNTCTG/uSZS90YKCblCrxriv1hJzTsjZL/g1g7prbwE6eg+FKOsp2tdHy1LgLHu0boJJP3CK1beBLQkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/n+Bag9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/n+Bag9"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6398ff5fbd3so6811545a12.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759917634; x=1760522434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slp1pSBk3oDm1KRWREwTYr1oiufiUqbjjsPwRIdm6jo=;
        b=D/n+Bag9LC0CZlbKIGjWIuAh4OW7x1V8Y/1FlSEmwybt92OirbGTZnOL4ZPlr3JpTo
         vT0+E3B+lLW7eakCtPRzlbFFCeu6kFYittuekFO228SFvUAK+DttVZLiT6afsIl87Z0f
         TMtshCHh+JGxw6gNk0AWMq//q+4oXV/a/9FZf9Aj1aJzmEP8sjGTPWSPVu0gfzEtLZUS
         e19NrpbmMvZPYLMuZCJIjArPWNBe4FFo0qA7N4fQ20HPJqQBsVkR9qAeRWwVk/0Rq7J0
         VdoGQLpY6uo8XfK0a4YJgJs2L1u1cAzUZtSaeYjXew7+M+ZYijU9XrCF2Ixw7TlqRitR
         TpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917634; x=1760522434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slp1pSBk3oDm1KRWREwTYr1oiufiUqbjjsPwRIdm6jo=;
        b=K97MALgL/QVA8qy5nU1tYS7MdWOmzvRFhxuUNoqOeSqKbNU8lxrQSR3KG7jIdPAKnf
         pP3bD4x2cqOkboRQ/qF1a3RI9bzK62rZ4dv7OKpWHn8qPX+kiCdriIxOP0A8wj82ToIy
         KRMdwBadUjilQkTvlXXlrz3lCo2rxm5T+CKj6R/619GPixktDgdO2OizySQ/2Bwj61ZY
         WJ2el8Wxbq96KHp5T6XlGSyM9WQk5Q2GStpaGT8CGkU2o1B6p0ykgJJuu76zND38V12u
         zqTI46fWtOoaMaq3UhF0lrkbK+q7O1QEXtfmBp4ckMat5frUIDZXlVJXMjg7USCnmNve
         7Sww==
X-Gm-Message-State: AOJu0Yw6OA0mBb6BgkBsvMFH594vAU/scGx4rGf02fPF5yWo/W0M1XKi
	K181n/KzTnjZGeOYBeI7clT7+3N+I4PpFhVx9RFsVoEqDSrQHVQtn5sxyLqzXwLjBsAmhtkXmRp
	ubi7eZE3njloJcyCVhYdu+g+nWWy79Rw=
X-Gm-Gg: ASbGncvrytP2fnNY0q38EFaolbyYq4omKcL6l7wVlrF0qr2GOS11Yphe/MxZt5vBLXX
	nV5Qlqpo1tSKS9dI33d0q33s3GwqVQPLYEL6etm3934Cq/lggtAoDIgadTzYuGoKen4WYChuqwe
	pjrxCFfTHrV8KIeYfMaX3BtSbFOD7xWtW74UTI3dUCxPofwrsXd7rzLmQTsUTuzpuUccHW+vvI4
	cxLK/0Dl361TlIerR+EBDAPiJ3nt3g=
X-Google-Smtp-Source: AGHT+IF7UacNcmHD93vPBx5aEqF2kgjJram43StbJ6p4ce3FdjGUjeGNjG+taNWQ2H6Gtdo8PB8MMgQKB2YZ3DWPncY=
X-Received: by 2002:a17:907:c2a:b0:b3d:e9be:7ac2 with SMTP id
 a640c23a62f3a-b50a9d6f5f3mr306754766b.5.1759917633825; Wed, 08 Oct 2025
 03:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-4-christian.couder@gmail.com> <aOYPUyKJPFyfKD46@pks.im>
In-Reply-To: <aOYPUyKJPFyfKD46@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 12:00:21 +0200
X-Gm-Features: AS18NWCS3eYCu4fd5JaKMy8mfig0TVG3eXHlixHENoTiekgKaZHiwuM3ltf4xpc
Message-ID: <CAP8UFD2dncBPHMH6oKUvT29iV2-qPg60i5Lt9wEsPCj2JYcwJQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] t9350: properly count annotated tags
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 07, 2025 at 02:29:56PM +0200, Christian Couder wrote:
> > In t9350-fast-export.sh, these existing tests:
> >
> >   - 'fast-export | fast-import when main is tagged'
> >   - 'cope with tagger-less tags'
> >
> > are checking the number of annotated tags in the test repo by comparing
> > it with some hardcoded values.
> >
> > This could be an issue if some new tests that have some prerequisites
> > add new annotated tags to the repo before these existing tests. When
> > the prerequisites would be satisfied, the number of annotated tags
> > would be different from when some prerequisites would not be satisfied.
> >
> > As we are going to add new tests that add new annotated tags in a
> > following commit, let's properly count the number of annotated tag in
> > the repo by incrementing a counter each time a new annotated tag is
> > added, and then by comparing the number of annotated tags to the value
> > of the counter when checking the number of annotated tags.
>
> Hm, okay. I think having tests interdepend on one another is bad test
> design in the first place, but it's not a new problem you create. An
> alternative solution could of course be to change the new test so that
> it works in a standalone repository, or to add it towards the end of the
> test suite.
>
> Have you considered these alternatives?

Yes, I have considered them, but I think those workarounds could make
the technical debt worse.

For example if I move those tests towards the end of the test script
or in another separate test script, then someone might wonder later
why they are not at the logical place where they should be. They would
then move them and realize that it creates problems with subsequent
tests. This would waste time.

So I think it's a good thing to make the interdependency clearly
visible instead. This is a bit ugly, but it shows the existing
technical debt instead of hiding it.
