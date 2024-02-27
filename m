Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536D137C34
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028256; cv=none; b=EesZmLGjMPjQxdl5MoP6mkn5DFfHLtlYwrw01tTs8DNnn1AKFnHerKA1a7RJdRpxKLnf9vA33H5I+cxZeNxLq4qhcg+QeQEShRiwo4XHQ6F1vcxA3z+k9Otyex1QWiE2VXnk/jfvmUSOiYM8nQv0vAtUehAy9tDKmUcGmBUiuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028256; c=relaxed/simple;
	bh=lwiXxhIA2L1eaLcgg2K0/qpZdJUiyzuF84Tf0hoFXRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VdL3qonj2EA5Eq4iwGi5l1nBfIVGcIpDZcnqePeQ/DgI7/7RGOmV9JHdKk0g5UBUqhEp7yz91jIH+tnN8H0BnVUokop17Lz1/JS9pOmQw0IuHPLisc9POCDNdgwP8u1y45EaBGlwp1I7Sm7Ryefd/uJ6skaPq5fueXjT/jCwQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0wcJ9rT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0wcJ9rT"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so4284908a12.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 02:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709028253; x=1709633053; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOQxWKHUkN0MFc6siHoAIh1RABW4GZ5oUcNq4lTiqAg=;
        b=k0wcJ9rTnBCrSgMSE19haj2owl2O9hQ3TQ98SQFrLt+GgN2jJFC2eDuRmJRRPz18No
         3eFyndVA6GfpFqJ1Mz9J2fUZYQE3ZsKEaOhWWUxaIjPc1lMmcXLMJBSCe2eU4/Pm4sGu
         wrKCywVVhz+RYvBziRVT26o/kPV8B1VSG84nE1YWnbjyJwMfgqnZNNcyr7SgAygnnWa+
         rL3zubZr9JUmu+ZAR/gwk4ExKpvE6JM8vUab7F/uOe/cQocnTj1OjEwSdDypfcO0hpCV
         70+Vzz/VzpoXpF7aiFR/woNC3dRu8213yCn+FQOyGzG3iHLYlV9ak9rJ2Ec/FxUWiIPB
         4Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028253; x=1709633053;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOQxWKHUkN0MFc6siHoAIh1RABW4GZ5oUcNq4lTiqAg=;
        b=FelnxoMf5T0NvUU8O53fRurMp0YURc+H7r78fuouMQqme5JrrnUHCCO2E9ByFIwf3q
         wRroOKuhuxKBxgBmLrgiSKUcZEstYxr2CAtv08Ako9Y92+ShLdKsolFjjAkacYatcUzJ
         MRBvgNJ+6Jn5KtSDGFdkaThh7Q0UfQ8ZyVUc76uPqXHiUf/urBozM09Xtn9Ku58qnNvI
         vk2MLToF+Le1FAjWG/ZeFm7z/RTsLBsNE4SYBLbJBEcZ24PFAxtwaitWk/lVBLwCyW6G
         j42nC/8O2LWgXvQs9VjAwQQu3i9wTF0chKRlMZVeQB6w+PVwxRSOME8Bb+HpwFg4nUMo
         Vdmw==
X-Forwarded-Encrypted: i=1; AJvYcCW7auW0X6Q8uGYH4fmxABVif4tjwoPWCetLmXoUIOH+PWLR9pnGQA1/B3oYrsFSAXBYu3Rz0BkpTFPEkNXUpBEaQ0ED
X-Gm-Message-State: AOJu0YyfknGGR4oeOJelkn3w5kSBigUFAVSrhiGbOx4S/y297TV2ddGd
	FV0dd/gQnSoNBoENJ2NfN8GvqPMndQDGLGIL7yetnk0G9KrcQk8+KUviRxNpgU0nufxjjA1KWT+
	fk2N90wBTIvRUZdbQLqPnZQDduaiKu4IfRfE=
X-Google-Smtp-Source: AGHT+IFUz2VdQNvB9Hb/QeSxpZm0AJUaBAmi/HmHM3LhH2UBi+34//Ci/7qQDlxlI+1FBJNwDgwELsl/1apKZ4+8BHk=
X-Received: by 2002:a17:906:57c8:b0:a43:7c1b:3542 with SMTP id
 u8-20020a17090657c800b00a437c1b3542mr2357901ejr.73.1709028252400; Tue, 27 Feb
 2024 02:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225112722.89221-1-l.s.r@web.de> <20240225112722.89221-4-l.s.r@web.de>
 <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
 <d96aaf45-f073-42d0-b69c-703393634848@web.de> <ZdzfYPim2SP22eeS@google.com>
In-Reply-To: <ZdzfYPim2SP22eeS@google.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Feb 2024 11:04:00 +0100
Message-ID: <CAP8UFD2t1KRo01eenK_RVndyVx5Vp9F4FepTgnR+mwhTGTvXnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
To: Josh Steadmon <steadmon@google.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Achu Luma <ach.lumap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:58=E2=80=AFPM Josh Steadmon <steadmon@google.com>=
 wrote:
>
> On 2024.02.26 18:26, Ren=C3=A9 Scharfe wrote:

> > The output is clean as well, but there's a lot of it.  Perhaps too much=
.
> > The success messages are boring, though, and if all checks pass then th=
e
> > only useful information is the status code.  A TAP harness like prove
> > summarizes that nicely:
> >
> >    $ prove t/unit-tests/bin/t-ctype
> >    t/unit-tests/bin/t-ctype .. ok
> >    All tests successful.
> >    Files=3D1, Tests=3D3598,  0 wallclock secs ( 0.08 usr +  0.00 sys =
=3D  0.08 CPU)
> >    Result: PASS
> >
> > Filtering out passing checks e.g. with "| grep -v ^ok" would help when
> > debugging a test failure. I vaguely miss the --immediate switch from th=
e
> > regular test library, however.
>
> Yeah, I agree here. It's a lot of output but it's almost always going to
> be consumed by a test harness rather than a human, and it's easy to
> filter out the noise if someone does need to do some manual debugging.

Yeah, I know about TAP harnesses like prove, but the most
straightforward way to run the unit tests is still `make unit-tests`
in the t/ directory. Also when you add or change some tests, it's a
good idea to run `make unit-tests` to see what the output is, so you
still have to see that output quite often when you work on tests and
going through 3598 of mostly useless output instead of just 14 isn't
nice.
