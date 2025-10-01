Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21626B74D
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302807; cv=none; b=RgKL0ujToIJn3C+P9YDRFr/MCS6dELxWQsu42ykgmBwsud5JucqLnTdtGbaVHIzKTAkngYFQtPxB/ASahAQRH95vZtIYeQ9KaanmlNB+q90xmI2gNl3WJYvTyDTh7YHkODFvaoBsywvlGdZ3x8tDDQqHtzOQhU5Ngyd2F2vDuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302807; c=relaxed/simple;
	bh=1WVaYJSSvCZZEh0djmI1NyoNR6o0oSYSfxiLlqqVOug=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HnbAX8OKFIccUVg8BKh591ZIDHMaRzcPf6CdzhCMUcm7F2cUWvWol0Ugw8HiHaziT9gS7ArRDTRSyU81Xt8Hh7qy8w4ReXSN6MmdAOnrAhS7SrR8JX31hCr4ypmozSFL7vn+wEWV9dVnCb9CvWaGWtXMqG79y0eVR/quSLyTioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X614TpWE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X614TpWE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e29d65728so46205785e9.3
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759302804; x=1759907604; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3tP6cHQBFOtCzB5V5EPROqS5giXUT0XkJKx9/bMCAs=;
        b=X614TpWEpVdsGVPwDjGSnaFMH5PwC1jQYEfuzXsvv+G/4hk9mRIJ/Vh9Ku5MedqD5W
         6FMPCxxROD9e4mavc1RRFCVSTLZSFDwgp3fDVnbKlg6/6xCuuCwIeHX7yfn7CP9x4HxF
         w9vanZV88qixUtvjIBu8+9io2IMJ47aIwrUsYNqbUIYCPdwqy4ywy8Zqobl8kZQvO5wD
         JRiRv4w7xOO4YBSu8G5eM4gbvM/JQn85SbcsQnsSS5wZK+OkF7yG5hEhcggcoqqfF/vS
         2A3wabBTgWl0aziNxSZQQBElIozG25xXMBivezHSrJoS6qLKB9uxY/hecer45vANAR6z
         nj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302804; x=1759907604;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3tP6cHQBFOtCzB5V5EPROqS5giXUT0XkJKx9/bMCAs=;
        b=XUjnpUvLX2+AKHQYde42DMj7Zb9l7B2cUHt3OPOFapAtgyZle1wy4J9j85KIP/Ap1P
         CQ2qwZCdOPKA9r40Te6pHdu5efUPyt2V2/ev08e2Zc9OCQI+UsLKmGZAns8omKEQ7X29
         P2Q8sxwwe3NxCUbwnWg+GClnXa6w4HTZBRWMl7VV+g0iQiqN/q+Xkfm/+EeU/rKtPVRO
         KAuI0dGlTfq9MJ06mBuPAlP12UP/aboQVf1prQ7mfJ4bL6GR9eX0nOZ0+Z9KB8RuYNLb
         g92seljMDwGKabC7eJh+xzJB9+TK6uc6K709xAMq1t+IzuXKpSzp0rOt+oQpX9BDOogz
         pvGQ==
X-Gm-Message-State: AOJu0YyyDVR1N3IxyM+dJs01GBKd3l6AbIn1CusLjPoa8mOzlEBYcegr
	7esceZ4X5BwU8PHkJB0MtXS72vGSajOR6MoFXujIeJVOwxuL1HadhfFrt78SDNI9p0c=
X-Gm-Gg: ASbGncsUuQnZR33zFaUvZd/tJlRGY6hJfIyrG5IZB+pAkDvKrzhfT4dbFVs+il1e4V6
	XUCHk3NNpqp3Tr6pq0dI6w4xuUfXOngagPi07RWkE2ebh7Fw+/LIwXZ2r9YxUE4KZiqq6zTYjrQ
	ZmtOHg/f51M5kvI9NK1OGhnnCeIDKPjH2ldiOdPC7UdSxJkXVcZIBN3bEsRtAXU+ORkkRkszadQ
	VYMFAfBjVg0J9KVN+uYWyTBkvXzly16kN28XweuSkyXbX8AfCRGMjDk8JaTP8QIV+K6//inx+E+
	nFJ465xMnRSvTC0BirWShIjFwXazpDfFwBJIhR3EAMDoOleIAlmSzt/Pw/b6d9L4QdugSxW27rU
	16iTXuVkOlBuyGkwO7uR/8QAUwwuJ6sM32flyix33gO2EEdXquvptK3TS2OjdRjSY9ak=
X-Google-Smtp-Source: AGHT+IGhDcNKmfsBhvb6emB3sGhQQJelUqEyjmsLfof0At3SCmOf01/m8KBEZayjw/bHC6PsgVbOzg==
X-Received: by 2002:a5d:64e6:0:b0:3ec:e152:e2ce with SMTP id ffacd0b85a97d-4255780b3bfmr1678417f8f.32.1759302803694;
        Wed, 01 Oct 2025 00:13:23 -0700 (PDT)
Received: from smtpclient.apple ([87.224.78.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm27486247f8f.0.2025.10.01.00.13.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:13:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: When should we release Git 3.0?
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
Date: Wed, 1 Oct 2025 08:13:12 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On 1 Oct 2025, at 00:07, brian m. carlson =
<sandals@crustytoothpaste.net> wrote:
>=20
> There's been discussion at the Contributor Summit about when we should
> release Git 3.0.  The original plan that was discussed was to release =
in
> about a year, which is about 4 releases away.
>=20
> Almost all of the functionality that we had wanted in Git 3.0 has been
> implemented.  The two major things we may want to consider as blockers
> for Git 3.0 are the following:
>=20
> * The SHA-256 interoperability work is not done yet.  My estimate of
>  this work is 200=E2=80=93400 patches, of which about 100 are done.  =
If the
>  original schedule is maintained, this would require writing up to 75
>  patches and sending in 100 patches per cycle, which is unrealistic
>  without additional contributors.
> * Some forges and other projects do not yet have full SHA-256 support.
>  It's my understanding that all of the major forges are undertaking or
>  have undertaken this work and are at various levels of completion, =
but
>  it's not clear that other projects have appropriate support.
>=20
> We may also wish to stick to a stricter timeframe for this release
> regardless and make four releases from now or the next release a year
> away Git 3.0 regardless of whether those items above are completed.

I apologise to not have participated to the Contributor Summit, I just =
joined the Git Mini-Summit in Amsterdam and we discussed briefly Gerrit =
3.0 over dinner, but not with such a detail.
Do you have the notes or recording of the discussion?

I am worried that if we rush into Git 3.0 with breaking changes that =
would make other =E2=80=9Cforges=E2=80=9D (e.g. JGit) incompatible, we =
would be in a difficult situation with the other Git ecosystem that =
isn=E2=80=99t based on the C-Git implementation.

> Discussions at the Contributor Summit did mention the advantage of
> having a hard deadline would be that it would make projects and forges
> spend the time to implement SHA-256 support if they're lacking it.

Happy to spend more time on it, I believe Nasser and Martin from the =
JGit project attended in-person yesterday.
Any commitment from your side? Do you have budget from your $DAY_JOB?

> I personally do not want the interoperability work to be a blocker.  I
> haven't really heard other commitments of contributors who want to =
work
> on it and I don't really want to have to run full tilt trying to get =
it
> out.  However, some other people may feel differently, in which I case =
I
> encourage their participation in the project.

Sure, happy to participate.

Luca.=
