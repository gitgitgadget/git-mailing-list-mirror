Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDF3DBB6
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666927; cv=none; b=kmY/904UwJzs0eqoIi73mWEdERlFK5Mbi/TNk1yiHa2casf6S2osgB9LJbneIp/fB6DcwCTL0N0jlwvCLl+j4vhj+VAcEeVOMRBlkUimacP5O06FHIWLc97aXPSTBOOXGUWHmHNv5hwRn1m7MP9eh1jkaEqRCclOwhFjGzojSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666927; c=relaxed/simple;
	bh=AVnvAq6Gw8SCm7Q+0D62OaGv1LwnXgMfnOhCxT2ADJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ok1dc8SOt9EU6+uV53SkvsPm02bQ1LVxN+v+ngiJ0z8z0ytTAvvlMOr5Txcj0eCGJ1uQo7K6I4SNPuFhMtaeU3xJd13ONsJzmA0bC7zSFV9jVXjDoUl+jBxKRv4g3xADhYPbxit+k9IHGsNhuIjl2nBNf6t9haO+Nku3u0EpFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU2xuwA+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU2xuwA+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab322ecd75dso289356866b.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 13:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737666924; x=1738271724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y0SJknFuqx3e3W+PGT84H2N3bevyOJ1FusPSX5KwdM=;
        b=iU2xuwA+Hy+aENufTcKsEqab/1+E5HsxirDgQq6s2aypU9yNrxdOxjoX+MaHAZznhn
         Aq7U9gEY9sX/qc0wMNpjpFtQG9LnSB6ZiBO0aXcZgHk3XM/wN0mFtKuO/jXd8x/8JYaM
         vO6euf/N+gthsZcdYSEX5Qizxz2BoU5f1FZcfJKluI3GReeynQl1gvxnfnLfEAmTRaXj
         Ue00ualitfXxkaeafYKBKAjisd7Z2rj1hfdF1K4tXoJfEcUps0DahCjjWfDMxriAsoXO
         qID2GuWZa49S1TN6ZJGHTXihjpYsdtiE/bcboOQoRWqRU8DRBPGu8g5KQWLxrq3tsLeQ
         ekDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737666924; x=1738271724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y0SJknFuqx3e3W+PGT84H2N3bevyOJ1FusPSX5KwdM=;
        b=Ti5RSO8pC6hA5RmXBOXIU2rbfEeejtEMQ/NOUZAZEuEauGmjSXxPZfiQWX/SGcc86Y
         4jOwpx1RLaz2QxngeoANKk7scdDrB+nWRu4LHsz0FEvqmsmebwX+gZTO3SEJduHiCZQ1
         YGvXAzpBITQJjEruY9GaINXwQan/APTWJrRxBV/bulgx9gwZwpYqiq0n/kt9rK12wFRK
         3QfmJDPBINVla8wjLLGyGxRwTDX1EIFLr8wri+wTPT6k17uCKGur2jHx6tiWm3n+hCKO
         YLmx8kpnKnkXR9Nl+B5wiXh2kkuoRROY3YniNjdB9ZkHBUHPtBtcTFTOcm/YWyc6Emeo
         aERw==
X-Forwarded-Encrypted: i=1; AJvYcCX5uRJ8w2U/wn7VERYz+AWGvlBwImvFVuNTWm+k/cBVW89/HlkIMLT8gTp/Be2vIVeb3nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXsGKIPjHy1m3wUT3aZ1k2NYAHJWqDh1WaTEX4BH0rEUYPpE8
	qsyXJ8nYPEXoL6Ypu+r48okEXjMA2i9rXM/rP5bSni2QD/a7b3zo71Ixhlu2SRKNpnt2QFEErwW
	adzR/JuIVe5M+TPLMZFrP2fcpNnwCuc5c
X-Gm-Gg: ASbGnctehltTCue0p9D1YoMbkk/811lN4S7CK3q53HGghdwiPApopqnSqpFZ7sh0DRd
	dmeHWhtAcCG8wWqDAyRM2YGw62AcSXJI9KX53viqMBJG/caRsQn6rdMev1FCHcQ==
X-Google-Smtp-Source: AGHT+IGJW2BBWer76R0K9ZcaA+74N1T+wFfdkJ0LMs2KBSYCi3QLw7kkwj6psDRxMDFpd/wtcsfgNmphMTE0EAI2gPY=
X-Received: by 2002:a17:907:988:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-ab67460161dmr79079066b.14.1737666923655; Thu, 23 Jan 2025
 13:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
 <pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com> <c1398676-ddd7-c161-e114-2249316b5311@gmx.de>
 <xmqqfrlawwd9.fsf@gitster.g> <xmqqbjvyww3j.fsf@gitster.g> <CALnO6CDH1aQrq0tcvr4rEGukksYv5bJ9W4icqBUC2Z3AyixRUw@mail.gmail.com>
 <xmqqr04ts916.fsf@gitster.g>
In-Reply-To: <xmqqr04ts916.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 23 Jan 2025 16:15:12 -0500
X-Gm-Features: AWEUYZkF8cbBKJswyJ5jHAi02dfYojEgnvt_itUC8JGFi7VFxG9IRPR1HI764r8
Message-ID: <CALnO6CAcv+544jRdp9VO1d38dvHX6MNfu4VLKenjKZCsCaf14Q@mail.gmail.com>
Subject: Re: [PATCH v2] trace2: prevent segfault on config collection where no
 value specified
To: Junio C Hamano <gitster@pobox.com>
Cc: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>, Adam Murray <ad@canva.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > I was curious what changed, so I found 792a3850fa (trace2: prevent
> > segfault on config collection with valueless true, 2025-01-10) and I
> > noticed this:
> >
> > -       redacted =3D redact_arg(value);
> > +       redacted =3D value ? redact_arg(value): NULL;
>
> Oh, I do not think I tweaked any of the code, other than fixing the
> new test that was not properly formatted.  Mostly I touched up the
> log message.

I could have been clearer=E2=80=94I think this was in the original. I just
happened to notice it because I was curious about what touch-ups you
performed :)



--=20
D. Ben Knoble
