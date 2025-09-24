Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A92629C
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734552; cv=none; b=Egk9cVwnu4gKldm8PVC/gZEg2pfjJFmrtjZQrShYi56cKbE+TyOtXFl8skbea1l+ZsfiywJKIuoaE5RvJ/FffqSfqszMdCtwOqcS1AsELJE782YmvNq2hgOjxmoehgX05hGQikTduJLbvDDU7XibqgFNGuVVeKqE9UeVET8e9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734552; c=relaxed/simple;
	bh=BGg3AZ5cfXdRBwhKG8nGuSV1TDOC6bkCq8C4yaxAhXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhzAC7EoUuAsT8dArOtWL+BYu0QUz2DerX3IJDsyrWdzyXQWbq7euXaCrU5Ypx/ePWs7eggGhbYjZnUjQLB2yzU+kbzrSf8k2XTwm2gsZB+6g/X13w5FkCiwFHHOlfBMvHe12nOhQzQudZgbAIqWTfTQwMoU62wDCFYJv1L2vA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07SesZTz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07SesZTz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681645b7b6so213495ad.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758734550; x=1759339350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mxg87c8jNFLloKBediEESeHmxcSJZBWHQNIWLWOACg=;
        b=07SesZTzwf+3hIRusI/CHsFVI554APD9y0YVT7zwJhyGyGRaY+pSL8PsIJSYfCEhLl
         ZlDot6qgwbza/0AyR/6nMJ4p+QHZbyxyBcs8sNqbHEtmaGm90hPlkAmBgNq976pqQpoU
         eNIHy3Z7cOdaZvxMGkgNQFQDnDR1p2k0nHwmFpnl8HtgK88AHf1tyk2+ukVH6xvAlqi7
         yvE+0OOtW3VfTn/nUl8aAYmGUz8DjJ+nWKy2s8Dv0vCnFf/MRukYWNhf0WugeoBm3miW
         W8hNoTlkFlUR/e8Mz0/ZjggziY76X1ugMI7ToL/gDQ0lUZbcO3qMpP1u/3wFUaNheBL8
         P3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734550; x=1759339350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Mxg87c8jNFLloKBediEESeHmxcSJZBWHQNIWLWOACg=;
        b=YqYxDsRpmlHqaPbhZHdWjxwGT9jaNcfdJRr5N2JjpkFj+Likm6z89jQCX4gHTA7ZaI
         UycI2Vik0NcckrSPsZbZOdeKgjJkIuRHsq4AM2upK+c2IYXOkOu0qok6r0ZdeoL8sURV
         2zsfbzqmm2grIuaQ8yAYmz30EwhKNtJqoaqBuS6wXDlY3B4SH7QCjcbVtrAHV7fxBAp7
         kNRq5kI+kNRTJBhjFuTFeTzEbbluv4+4M/gCrWx9dUsz5UPjq6L6zJHG1vLzob/eKpNu
         bB6r5h1IqhSg5GrIXNvBMymfh2CcjafcNC8TsDQBRQj281sGwlwwEEST6LHqcbedxb+u
         tRZg==
X-Gm-Message-State: AOJu0Yw/WU7ZxxOW4LbEopQzwErWRjAm7cc5vR+RIpJtvSnMGe3QJ6aE
	wrIjZz9OplKvRhu7AegIMNEGg3flHXljpQfPzZTffHjAZYnRlg+M0H9tiBxXV8cCpSRrcAoEhdS
	+3kQBCOKo/lBW+Fy//hCqPM+U4abR2mQ10xexdhTvdXaXCTMljA+1QcjGnhw=
X-Gm-Gg: ASbGncsUXGR696eJiyNSjZrXL1raNBfTHJQfMLUF/oxE4L04kitVKgaxmdehagWt0C3
	UydwSwpVKxWwj+4K4gZjPT/y1D4jOkAJIuYLw4lvAvvI+VfSZljC9OmZTQdvfh6NwjtwtzWJIGS
	tiHwj+xnrni0fhYjCbT0JUlUrnAdGCnX8QF30jD09K5uX8DLsm1v4nHm59OkKQUKKGEsUT5N2ix
	rw5fFSMU6Qn+CWI/MMSzWKme5El9aogFXYhjU3HdhxuuPV58l/0v7Y=
X-Google-Smtp-Source: AGHT+IEWdZ1+nb86j1C9/sQfC063Fixi5FYFY4sNxFZaG0AW44QMTGCFv/wu+v0IXpHdx6PZH/UVoPMPwYxg0PQayqQ=
X-Received: by 2002:a17:902:ec8c:b0:26d:a02f:b046 with SMTP id
 d9443c01a7336-27ed3fc4c47mr885945ad.11.1758734549585; Wed, 24 Sep 2025
 10:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com> <f1599790-b48c-4c37-8cf7-4756f5064d2e@velocifyer.com>
In-Reply-To: <f1599790-b48c-4c37-8cf7-4756f5064d2e@velocifyer.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 24 Sep 2025 10:22:16 -0700
X-Gm-Features: AS18NWDrlP5YC0vjgxT5sem5cwcOMrSnI-7Rd_oSuj3P2Mxb45njJ02Re1CGqBQ
Message-ID: <CAJoAoZkhqF83gsT963X81zZZi0wvYV9umEoXaArVpan6nDCoDg@mail.gmail.com>
Subject: Re: 0-Based indexes for git log
To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:15=E2=80=AFAM =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=
=9D=F0=9D=95=A0=F0=9D=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=
=F0=9D=95=A3
<velocifyer@velocifyer.com> wrote:
>
> > In git log it uses a 1-based index for the date instead of a 0 based
> > index. So it says "Fri Sep 19 14:23:24 2025 -0400" when it should say
> > "Fri Sep 18 14:23:24 2025 -0400" (or "Friday 2025-8-18 14:23:24
> > (-4:00.00)"  to get a better format)
> >
> I suggest git adds a config option for 0-based date and automaticly uses
> 0-based date if there is a file at $HOME/use-0-based-index-for-date or
> $USE-0-BASED-INDEX-FOR-DATE =3D=3D true

Git uses strftime from libc for date formatting. strftime[1] doesn't
offer a way to format the date as you prefer - what you're asking for
appears to be a personal preference, not a standard in any community
of the world. I think that your best bet would be to attempt to
contribute an option to strftime to render the day of the month from
0-30, but I would be surprised if such a contribution were to be
welcomed - as, again, this looks like a preference held by very few.
Based on my quick refresher through date.[ch] in the Git codebase, it
would be infeasible to add such a flag and custom formatting.

However, Git is open source software, and you're fully welcome to
patch your copy of Git to accept such a config (or this ~/some-file,
which is not a way Git typically sets configuration) and build it
yourself locally.

1: https://www.man7.org/linux/man-pages/man3/strftime.3.html
>
> --
> George truly, =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=9D=F0=9D=95=A0=F0=9D=95=
=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=F0=9D=95=A3
> This email does not constitute a legally binding contract
