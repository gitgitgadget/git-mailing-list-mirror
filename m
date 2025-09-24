Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6E1A9FA7
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724510; cv=none; b=Z8DlPr7gxVoqNOMhjCx30HFRxcRPO/VICSBmJrZ8HLTPY+OGt5Hb/N2KeII93yY9DaAPEUmTiGsgMZBpZZAxr07G+f0gpUSdEAR832QlDewwULoWluxsavCAOwq7eCAcHZUk2dFNMZhdCku1ag3uZponk2ZR+EkPr/aFL8Rju8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724510; c=relaxed/simple;
	bh=Tn5wpGQsq6A24oxt1XUaqX29emckIfjlo7vvWoBpEME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctZlqrV55W2b1CJt0KKDSgSJQJQh2+flSLLpT8hL97G0SxYqjK03lWq7EOY1VQwk8KgE0elwqGcavYr6JLmBweUCZPmAt7DZftrJ5ngCLB6v3U0BYnd+NX4PwkD0+aBeni6mi+/T3YzvCoqGkTRjs3cbcKi310S3x66AX00h1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAW+nI4u; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAW+nI4u"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so29475191fa.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724507; x=1759329307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAst4EZ0CqJsYpnY//pjqYKWbhVWnB/ia1YbbKD6a6Y=;
        b=nAW+nI4ulFoUPsKL1ABadHx8o013r05A7xaOp8PHRBaIf8jGsZzGL0Jtknl2yoSCWb
         Eh6LvIgJpan5zpm/geFvDygLwUAHvd4g5upTQkzRDWVul110bU8mbmaeBBrYYk2r+TQU
         Was/SfDGj10Gmh4VYAVIbtmJbpl0P6Ousxww98FwuylEkYhYGXTCQ3t2HXk4/rsNmYjv
         MthS/EnqeT0dwnQmTv7/NaO9/6XZdKC3/zWyS5HxQ87d4XF8pv4zZrEBTF2xhADmNm0R
         Y6qhBtomIt56EwUYXweLLpm8zJypPCVPeyoyjDHMWsnMR/uxf8dIQbPfm/MpccN1Za79
         sBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724507; x=1759329307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAst4EZ0CqJsYpnY//pjqYKWbhVWnB/ia1YbbKD6a6Y=;
        b=hKLm313S4054ekypW/N25T1BbHK+Qa1P4ipn+mrMOlNnTNdkhzuuX3iXUBsScrWqGw
         WXncLPT6q0EJ3CxPeWNG7xb8TIQpiUyFhZ+ek17/aGd0KEZ2u5K6vmIrzCRsJzMIAQ9p
         WuvIHiz6clkoM1Cv39bcg7kP6jBUP5shARlRH9QcYSoFzwMFoNGMqnCTGE8xgdIlsZZu
         jJ7MAPJzVXLBJMI+zWcwIxVAvjE3xzS6yeoK3PSWR56lWvLU0Xq+KDfBCVFjyHSFPICt
         zJ3az0J8rnQBAD8llQaYQGdi8QAT0P9hPtV15HIMudKyC+N9C2WTB56w/xFwBACYrDTn
         unwQ==
X-Gm-Message-State: AOJu0YxxPdFH6bMAK8KrGZeO5hUWiJDeAjWm7mJcNWGxw/40JCRTUfm8
	zVzG+sXUIDEB2ukIPoqlbn7KhmMU1uQHPRMm3rkVV8Q9SAD5iNlAhiasHzUdI9nng6KJQQBu4Nx
	UW12EJf6uMoLkCYPz7t5grjxzyGzV3c8=
X-Gm-Gg: ASbGnctai8ztwzgDdkWD+4pwcIkq0uV7KEL8p+q6pHwn2S1CMQBEO+7zfvUYIhthW2J
	8sazYrvcr9uocIYuMd/Ohybut8ZpO+UWCT24gOcTTu6IhH2WrE/wnrnO7WElNMzHYd2Zddds3wR
	tAzkMItrszk/FSenyiwRc1eMaBqOXVdOc0ANKAi1evqqVbv6DN5xO8o4bMp6EzuMvqLPPSIquGS
	vfdTMNk
X-Google-Smtp-Source: AGHT+IEp0FgksmVgrHbCrILFQ0yJ9E8MaA402op/xp8dBByR2u3nqM5lMZ/MoXRDWcVwXOGPyLW0W4SfJooltzhP9OA=
X-Received: by 2002:a05:651c:2152:b0:36c:7c35:49c8 with SMTP id
 38308e7fff4ca-36d16bf57b9mr12772011fa.30.1758724506590; Wed, 24 Sep 2025
 07:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
 <CAH=ZcbALjKY+=TQfv1L4PsAyC=-fxNdi8PhSFnXq9G5zcVtkCQ@mail.gmail.com> <aNN7dG6oLrv2Mokq@pks.im>
In-Reply-To: <aNN7dG6oLrv2Mokq@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 08:34:54 -0600
X-Gm-Features: AS18NWC823uMj7DVdcR7AoQBvHO1TqT8tTiMrX4LL2J4ymlmleaeyZk8Bge_tt0
Message-ID: <CAH=ZcbBjL09Mk3AXBSgmZGvmFtU3Roc2P5rbQsZ-U5DBHYSs7w@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Introduce Rust and announce that it will become mandatory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:02=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Tue, Sep 23, 2025 at 02:15:35PM -0600, Ezekiel Newren wrote:
> > On Tue, Sep 23, 2025 at 3:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > Your patch series has 2 critical problems:
> >   * meson doesn't check for "is windows and using msvc" -> <crate>.lib
> > else lib<crate>.a
>
> I didn't wire Windows up yet, so this is a known omission. It's not
> handled in the Makefile yet, either. My plan here was to tackle Windows
> support as the immediate next step once this patch series lands.
>
> Would that be fine with you?

So long as you're aware, I'm fine with it being fixed later. I believe
that Makefile doesn't ever use msvc in the github workflows and you'd
only need to tell meson to look for <crate>.lib since cargo will
produce that if it's using the Rust toolcahin x86_64-pc-windows-msvc.
Also you'd need to update your cargo-meson.sh script to merely look
for <crate>.lib instead of lib<crate>.a and move it.

> >   * Using the name "git" for the crate is problematic because both
> > Make and Meson already produce libgit.a which is different from the
> > libgit.a that cargo is producing. Change the name in Cargo.toml from
> > "git" to "gitcore".
>
> I wasn't quite happy with the "git" name anyway, so I'll happily take
> "gitcore" instead.

Ok.

Thanks.

Ezekiel.
