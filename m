Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F873D0D5
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943125; cv=none; b=pUbDr2FkJii3/sEZDSeMXx2Fs/aaJ7NOFJzLIW7gQ0f4z28QyEooCzwGpy5n6jJL/HHqggHtdSPARfM2q61XnBcnGm+0rCzaE3yTWnJmLdXYjU9nuJQzYhnRmj5Kzi2QL1/9YQaKZ4mNlpx06YSeMF//w9tDf1M7Quprao8AQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943125; c=relaxed/simple;
	bh=wpuSW+GNrFpjww8xOBnVrr91ZZwicHFY5XQAZx8PNKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7+Z0B/Db05t+V1abea9E88iJh927AIcYps1gxnnGjWRvvx9Kn+z+lsuYyuf2NNuGkRzZapVP5GFL4GAlETtUgY+nPw0AzmhqsYf0ykn6IMAI86ewLCw3dWcO1YIyPF1DIXJ479hmbPfa00/6J7k9Ekjtxa+47XdGGp72Wop03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTuBAIU7; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTuBAIU7"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14cc9066so210169b6e.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721943123; x=1722547923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpuSW+GNrFpjww8xOBnVrr91ZZwicHFY5XQAZx8PNKI=;
        b=kTuBAIU7bf9vrlxMqr1YJ/L+qNQozw99uDYjhyN4WA/y2NXesxfZkPl5tMus6kSMn0
         Mk184nXhLBxUHUDmrRcTdx6ooJQEBBc3YZdDtG1/VXTs80yhz+ob+FKihfaGh6EzoI28
         R5ZlhTh5nTtviM+RtC0e1SJHeGbLbwgMtqD0NPcNYtI55cWiiOlBm0JJWw1GHTCVTTrL
         afe3eeDQUJVTEDMTDMZK0Q1EpdtzFZQn3mAr6+dcC1r1bIJ1ZKkMbiJYDzNhhMt8rrHV
         6goKIOAqmF5SH2QR9NvcyIj5pGI4ktgpvMWC5Tm4x9P7VjJLyIcXDNge3fsrt3FzeLr9
         fguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943123; x=1722547923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpuSW+GNrFpjww8xOBnVrr91ZZwicHFY5XQAZx8PNKI=;
        b=keY2JWAFIT4FMVJF511BHnKVScd9plSOIziQzDaHPyJmM5v4i+NQ6AvifTKcDQrGcZ
         xSi4ZrIRjxW7R4dPV1S3Ng7x/ZS70c+kemugezN2oXvMqIYX6pkmmtLUC/yEnwP7NSU6
         bDA+VfaQSdgzD14GPnfc3okAr299ZmM4329ANFmm48AgbmVzl0uSvt3IBBjqkrRQ4b4Z
         SmqoyH0+xAVzvJLO9WRbsPsVymjSUDhQ6Nej8dWQUxHXD7lEuUf4mTEvJNl+0Kub9Ciu
         szvT5hCSxNiCuDuUooM5KBiDSxJV7a5BXH9uI1XHqAcoTfxAYcAjpRluQ+TD16C1I4uL
         m/KA==
X-Forwarded-Encrypted: i=1; AJvYcCUVxcWqjSrO8yUrSMUGDds7DG6Tv4DKto9vR1H72VzrVWglNf45Zg85ez14nd4pRVqkgUrHk6XS8EjG8cygoInPWpkn
X-Gm-Message-State: AOJu0YysdQGbHYMhNdqXbxVYhO3HE43uQhP4y66MRcwyH0a1JkXT6Gd4
	4bgh0L9ElIIR/56GeQl9lJYx17ZUMpGd07n7q7DBA8Qrq0u10k2ye17Lsy71kqEajUO7pTXc0E5
	wNa1k5KLWupm27VwYEZoD9pdRPf4I1Av5lD92
X-Google-Smtp-Source: AGHT+IHXQEwmBOSbXj3Mspy9x9ruzm2GSQRyYyhOVMA5/TCjsuVV6M2Hq0559+BBY1CW1/JFbyMyRU3s7GueL6rBwXo=
X-Received: by 2002:a05:6808:1982:b0:3d9:e1d1:1580 with SMTP id
 5614622812f47-3db10fb2309mr5546333b6e.21.1721943123217; Thu, 25 Jul 2024
 14:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <73465c3d-1be0-456b-9471-f875e819c566@web.de>
 <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de> <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
 <xmqqfrrxjw8f.fsf@gitster.g>
In-Reply-To: <xmqqfrrxjw8f.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 25 Jul 2024 14:31:50 -0700
Message-ID: <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > Maybe it's because I'm coming from a C++ environment at
> > $JOB that's using Google's gunit and gmock frameworks, where every
> > test is in its own function and we usually don't even write the main
> > function ourselves, but I have a preference for the separate
> > functions.
>
> If we do not have to write the main at all, then it would make the
> separate function that implements a single test a lot more palatable,
> and we do not even have to implement and call TEST() macro ;-).

I feel like you're trying to bait me into coming up with a way of
avoiding the main function ;) But I don't think it can really be done
in portable/vanilla C, unfortunately. I tried to think of a way to do
this, and they all involved some other system coming along and
identifying the tests and code-generating a main function, which also
seems like too much magic to me.
