Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616D316199
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772394928; cv=none; b=YLCq4CMswoweO8xcpg5z7a+/W4RqC8xfra1YxIYEDIWQCO8TJ9LS0WXzaD+umSL1mIKOD0iw75YVNPqQs1pDsK+RKlr1vH+jDOoWJwMQEl5QVaBZLtPnb3nCvl6T8cAuwL+iaQLBcJWgmHmDVcegYVm0d4deb6Df0fIj0dCt+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772394928; c=relaxed/simple;
	bh=b7ebynxzUmIwIEx/nSIIhckGatM8DMldCzSKizwwlH0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n1POMb3D6KUWX+hLxNiX8XHi0a2OAtwOOShkHdxqoOmadckTXGA/ZaVa6Dw3TMpF0xEo3rrqpSJNGYGZfdff6gaGM14xhlmF1QG1ZdmMCLms5tuG1eFL1yxIDxY9oC/fzk/DgTKhg1Iigr33NOzB39ylGVzUXLM0xIT4v11RNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/zlSWSK; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/zlSWSK"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ff14dd9bf8so930305137.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 11:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772394927; x=1772999727; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7ebynxzUmIwIEx/nSIIhckGatM8DMldCzSKizwwlH0=;
        b=j/zlSWSKJFd77frmlpKCUNRHF9gl1IO0kBOpzRiTOPFo9yUOlnZnOnUgMJvS2VkAMe
         oXsL6FtN0vaFER9M2B+vxT10RXFUqXO3BvtL89M6LBsOZdJe+dRiWgCVww8Y+6/QmjnC
         VI/YE6Vb+451PsnVU7eX0lUW9xt8Fft0cZ9795EcneLLNsm6481J6tthQ5/wSs3Z5WYv
         ZTzV5Now7x8wwHXzgvV5r3cSzhoYZOmPrBDqVkx9bwXqzSxDR0FpdfT3I93ef3dDzbKV
         8psgP3ccwjpcm3W8KTL7KMK7g5H8GPuj7fNcH1lj93jkEjZbrr7LtezwbsiVqvBqhwI0
         Z6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772394927; x=1772999727;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7ebynxzUmIwIEx/nSIIhckGatM8DMldCzSKizwwlH0=;
        b=pOAh8hrzPusKlaQbVNM6vJhbh9q12y1yUtfMaInKLClYOD7SB/oUa474g/4fL0Xwno
         hdpIrfT9tkMALNPUztMdOcKshThUUJX1DIRGMtRJbdwuy4djbXXHlj3tWD6I0Jx1UMCr
         QimddSmjVgzjuyFp9B2RiG+1mSKF/dhy+U8hFIFmb0YpUL56BfHEiy8sa5QQvPm1lvx8
         cM0Gi7pJS55q+g6XK+gAfiLlHMuvgDQDLf9EjnkFdfsCjzjU0xRJo7ZBhcAQc+rhuzxA
         XDLx31T6gcT0QU1zqN/Lu9ocAJuNc5JSGhe/JLAQG53AsLGLkHa7iqc/ICjDh3km1Mws
         S/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvdTZY8czVjYvig/TBLU3Bmo5gKw6uIEoWv5rLBMoR1Q0Dwyls/3ti3z2/CqLpjLGz34Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxLucTJCKfi7tfxV65DBssyOOrwVwR+BViQFYkWFeFeNRcI7T
	anrRYEPrleY73iJRnep0R5i7oWvTwxjvlrOZ009jiQzLmNci9b27IYCD1VjQyc0C
X-Gm-Gg: ATEYQzy3hbg+iVhz7/DwSYlqoLcMZaKV2mNYpHw+n2IMamWv10He4Bz22YPWHCceW2k
	g5PNVQ5hiENU31UY2RyKoEOLpsasYg2qks9DhMsm/7U60vB9cDm5rZeidUFsM598I5yygkfH9Xg
	1SOOKkSgnXxXiYn3dZPJIFR+IVegCP59j64XViKMikZp0fD9V5gcBxpilf6AgQoa1r9EG1yJN8I
	kKUhfSvT/W/dMJsILMlz4Pdq4GpJFyBMZJbUkaPYPekAH3bQcbEimCa49RqmYKUYP6Qh6aVaWSX
	5DrbW9meyR6ukT0va1H4EgfIlaj/291EgqJnL52DXhrN8b5C8ZD5o+Drcq47ICD6FF1i4E0RnRh
	lE2i6l9vF6/emLxUfPuo3p5RjDzioRbhktaL3eLtnkduq0zTANroqzI6BAl7asDh6FoXM/1wJBJ
	RcOOwrnIimQMKwkQLf2rooiItSZgEBBcyelCfoc5yiFhzEA4ypbEN4x4w7uM9h
X-Received: by 2002:a05:6102:c0b:b0:5ef:a644:ca4 with SMTP id ada2fe7eead31-5ff324dad7bmr4110583137.23.1772394926719;
        Sun, 01 Mar 2026 11:55:26 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e80818dsm11423690137.5.2026.03.01.11.55.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2026 11:55:26 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAFNBzOdCx=R3r9+m5eDyAykMAbmbcfpX3kPeEPjqXPYT-_89+g@mail.gmail.com>
Date: Sun, 1 Mar 2026 16:55:11 -0300
Cc: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>,
 git@vger.kernel.org,
 sandals@crustytoothpaste.net,
 a3205153416@gmail.com,
 valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B46AA932-28EF-4A2C-96B9-0F05D9641C1C@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com>
 <CAFNBzOdCx=R3r9+m5eDyAykMAbmbcfpX3kPeEPjqXPYT-_89+g@mail.gmail.com>
To: Ayush Jha <kumarayushjha123@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Hi Lucas,

Hi, Ayush!

> Thanks for sharing this series =E2=80=94 moving the path formatting =
logic into
> path.c makes a lot of sense and avoids duplication with rev-parse.

Yeah, but since git-repo-info was written as a better home for
some features currently in git-rev-parse, now we can think in
better solutions.

> For example, something along the lines of:
> path.toplevel
> path.absolute.toplevel
> path.relative.toplevel

I also thought about that, but what would happen with --all?
If --all returns both absolute and relative, then we would
have the third solution.
