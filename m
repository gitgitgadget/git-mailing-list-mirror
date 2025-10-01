Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE42D373E
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339379; cv=none; b=hWqt1NM9WQBfT4eNf0tiT11MMAXwYSxqPPRa1fWAvkOjKuINmIqAkLzeQktmbjjsCQ1lKn0WAXsqZv/j9jIm9ZzaFjNdHlf1H777ZPq1CkAfhoF3kKTxp+oh9UfZgEaZNk5NouVbh1cGUiDQv9gzHC/kC4oOOJ6y8TAwywOPZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339379; c=relaxed/simple;
	bh=Jo4wscY6Gv4ZwmDi811Yn13gU2kB502RuPMv6L1JwiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogJIXHTkoSCcnTVgg5D+E2EJgIiN/nuEEvLiUvmGk/iiZIcvKU1SZ+47MYGaISdAC5DkfznhywHVhGp8CZat04zSX0TIuk9saLVeyl8D0jz36z6WATN20YXH7vaJgGe//dLwv5pCWolb/RRRsnzXSwtBJo3ZTrAED4mTFT0Ldoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts1uN+xr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts1uN+xr"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-58984c363ceso1181620e87.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759339376; x=1759944176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo4wscY6Gv4ZwmDi811Yn13gU2kB502RuPMv6L1JwiM=;
        b=Ts1uN+xrv3mXp1Cwa62lPH+W1XTtKKoASnGzUlJzH2ko5NtF3C+qinAzYCJ5L2CV4+
         xYK+UwiFbIbWY54GU9WPlsbyKDpn4B7pd8EqnKyykNJ+2iHOBQJGLo10f1kSkKTSbrmg
         93cnEN+bw4MrVNVcbKAB+djD5EszQeOaoRFios84VqYfUK9wI6smdMMENqGnu1Q7GsPD
         cdU3VEEiiUF02iBaINHdhk2O/XO74Cv2B2bHVe2rDPI6k3hFHFv28+uyBFKDJWIiWrdk
         AKQ/n3K7CyqsfmJt52E/9H0jLUSISE4Nhy7vrffVo0EWI56RrxlwJephiVhDGuo1tvg0
         n0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759339376; x=1759944176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jo4wscY6Gv4ZwmDi811Yn13gU2kB502RuPMv6L1JwiM=;
        b=ah8WNHmKlRnHwrHBjEr5pcNWkaoXCvIIfHFflcxM21ZhergY6ogmyx8eo+gECBrdgD
         LiWRK99Lr8itbujKcPsfLPiyP4jf8rzcacUD3u+STyiHnGrmdki8Sv0UJo9pDCG48z3f
         2jL99WZX5INRUypyeq4zsfIFeEggZaU0FvrFmnXE/CZz93IUpiRP/2yMLoODcsaQGwyH
         37Sq6nwU+SVdHEvNkgIPCPRrxnWZyKSocOuh3GHqArC6v0ren7y3K2c+osZUVpOjaL7j
         EbF0D9UpkRpljPbP3TgQtbsFEVzBk1TbRegtSev4mXCA2yK/nUtvh8qnC1O9I3wk+QHH
         tujA==
X-Forwarded-Encrypted: i=1; AJvYcCXu8Y8jNOYSAgAARRCdbVzeDfpLNpZ8arLSBHYBoBvWof92PE2f8mcCgqJhTDabISfQX1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7skHSWx/t933jyf9gRcKVa+/uBLS5Q+k722nK3M19krYET77E
	0jlDuX1fHKkLX5lqZ+waWZmJRH7ufWTiw+gJcrxr9kAiHf2DWe9HXZwAKAJaoyJQcPz0nms/jJ1
	9m12TCGqETLLxEUDdRtVsKWXUqEtCsIQ=
X-Gm-Gg: ASbGncvdw+tr8pFEaqQAGy9OboNn5EwB3/swxFkt1uPPRUSusB603iRPPTPIz26gr8S
	UcwKIvCFYee1t7bTHjRhC9q6z9Eme1Amgw/7UGlo0A1/oW2S/XsHOobFMddi+llwYrQmhaPmb3o
	QiFxVTgIzl0xSwivEG1LqSoT6HgY2ASTBT7Fd1hDeuCR3kwBo6sOVHjEjBTWA7IzQXq0Rf0SdVb
	RIYEUU8CgWi22D9fb1Oj+BL7TC3DPWh6avvfvunAgU=
X-Google-Smtp-Source: AGHT+IHlVsDVgxbSuhfrdjfA3HdCcRr4iGhxq/AIhhOyEmfBT/1mO5BQ9yRMFEQBbbiHzx5ZNv9rAGqqCOzBxSPOOZs=
X-Received: by 2002:a05:6512:3e2a:b0:58a:f7da:6f70 with SMTP id
 2adb3069b0e04-58b00bc721cmr103750e87.23.1759339375769; Wed, 01 Oct 2025
 10:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
 <20250925-b4-pks-rust-breaking-change-v7-5-4e49dcb904d5@pks.im> <037d8685-6521-4ac1-8251-d93e8a1d7081@app.fastmail.com>
In-Reply-To: <037d8685-6521-4ac1-8251-d93e8a1d7081@app.fastmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 1 Oct 2025 11:22:44 -0600
X-Gm-Features: AS18NWBiOdixE8sG_CYz7tByZBK81ve-kFAOhiT0CZPTYqn2D42Quc5PsXO5tB0
Message-ID: <CAH=ZcbBQk9xmTF-m6tX6F+PRmnUSoevyFFvK-fAc3uzL3NvqSQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] varint: use explicit width for integers
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Elijah Newren <newren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 7:34=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Sep 25, 2025, at 08:30, Patrick Steinhardt wrote:
> > The varint subsystem currently uses implcit widths for integers. On the
>
> s/implcit/implicit/
>
> > one hand we use `uintmax_t` for the actual value. On the other hand, we
> > use `int` for the length of the encoded varint.
> >
> > Both of these have known maximum vaules, as we only support at most 16
>
> s/vaules/values/

Other than the typos this looks good.
