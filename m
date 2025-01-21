Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C44187FE4
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480434; cv=none; b=faRxhygGbLpAM+fokX72Iivs0VuVQsOJGlphOOW9PWs1iBlRNWyXX06s1rlP27cbuhZPCs+E5AHPHM+oZ6cd0cGpnnqqGF0TweBB4U/S2rXLYrWBCQRCKjJBPD4aj0VKDgAf9OtmaD3h/C92ZjSsT1l4AcpOp6uRus/mJ2Dg7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480434; c=relaxed/simple;
	bh=OHSM3nQFgNCBfFXoHfxby+Zx3J6xWUwxy01Sl7g9ns4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpd6qr0jg/0gPcLoignyh55v1p42kEnmWjMxl8IdIlv66IAQFC+22ndXdqjzCmn4+Hy71sFs4ycjtUVPiR3Q5VKIdZyC2xExqVQCIphfYqYqw+TSAuvWiSRABtlkKAk92WoTJbl/kvK+i0CAJj2iinwh91lps2Z0ZgH/V0zXeOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com; spf=pass smtp.mailfrom=jetbrains.com; dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b=DXImkjxn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="DXImkjxn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso8175711a91.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 09:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps; t=1737480431; x=1738085231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHSM3nQFgNCBfFXoHfxby+Zx3J6xWUwxy01Sl7g9ns4=;
        b=DXImkjxnGpeb+kt4wvS+RtGSr8aPY0ATGIQDSLBijfVbVmivssI/Bt+5FdbF99+A6n
         51uhP4tE8dXKXTj6hX98+Zeu6NjH6PR4ifd6kge/2WsUXH2cBQSTZD6dWe+b6NUUUbvw
         uUjjI4r//Ca03IzD08sKPEGrNhej7QQjWzHoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480431; x=1738085231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHSM3nQFgNCBfFXoHfxby+Zx3J6xWUwxy01Sl7g9ns4=;
        b=Ui+lay0xFr92jzqfxtlv7NsIAImyHaZSZGl36ARdG5bLzgn3VgDTI4j3i7NX+aIUes
         rxo3j0vq82hM3J2ok/gmn2g6DpKDEyVCXmVUxNm4Xi/CDb45yXBfJvdOHVB66y4aE2Ht
         3nAYrY0zDBq8ngaq3g+bRciiTkneidZGpQ3M+ryBWH1WnFnPMbACrK2TIeT9W++unNge
         6Vtuk2uBSM0dRj4vKMbpIFcH1jJq/o7j/sswg/Hve5he9ScoYoALNt3qbewCvGBcfccz
         LFOfiLEI380psyIE2UhNjeUfAP8olw0rylh61z8sDBdaXtuD8gbsIcRuIxdUzM561D4c
         qb+A==
X-Gm-Message-State: AOJu0YxuApO+ta6sPLOLbnoa9IhJHnRR9QpoClGfpGrG3eyiE2cdb1R4
	utS2Wyq9/ixfVh8WpHLRHfz6PqAFWCIYfnQJy8uUeotRHireHkXPTYsqBbOxFAVBursSMdAQfx/
	oss2Xsm8GlUXypteNKity1akutbjf1yPQaMlHuzdvH5eWkse9HhU=
X-Gm-Gg: ASbGnctbdA58Irv+R02rTnaqv1DpP415OuglGzaIbe7G8ak0BcFAkNzMwYnoC5ooBxZ
	Vt8EeJOpj6DScV8F6qqoWf6Yp6wrvkPxTsgXxtqWVnAZ6shvc
X-Google-Smtp-Source: AGHT+IF6FuQewbVDgLHrbwFcIMyDf1L1YI4fX4m90QGxSSbLA1ZhzxUAHuEmPPVkx7DfP8M+f/P6jQpRWWYKXB0G/i4=
X-Received: by 2002:a05:6a00:181f:b0:727:3cd0:1167 with SMTP id
 d2e1a72fcca58-72dafba0247mr26921264b3a.21.1737480430114; Tue, 21 Jan 2025
 09:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
 <D6ZXVILR1D36.3W0QVQCVE1P2J@ferdinandy.com> <CAM6buW6NbdZ6wLGP6LWePiA7n0At=jxxqtBEUv0fTY6mOdTmyw@mail.gmail.com>
 <D705W1554XJ9.30SRYLNGNOX4@ferdinandy.com> <CAM6buW77CeuKfr3b4SUbYyFaU1OTvRsYBjPBE05YMzJo36bGdw@mail.gmail.com>
 <D706LPHBPUL4.3LN27T1UG1FI2@ferdinandy.com> <CAM6buW4UiCs9pFeH0cxxdhLHCSNO9wLVz9_p4Y0u8LaGWy--ng@mail.gmail.com>
 <D712LKI48ZUD.2UK8FX0YZBEYM@ferdinandy.com>
In-Reply-To: <D712LKI48ZUD.2UK8FX0YZBEYM@ferdinandy.com>
From: Danila Manturov <danila.manturov@jetbrains.com>
Date: Tue, 21 Jan 2025 18:26:59 +0100
X-Gm-Features: AbW1kvYKbkj7tMFPadzsY46k7qSnMe-quJ8AVPhZxqehXpt_cblwyHSQtzvWAMk
Message-ID: <CAM6buW4e4c_3BgPo_GU64Fvi7XGcP7tuxdaap1LypyFCOZvZEw@mail.gmail.com>
Subject: Re: Git 2.48. Changed behavior of the git fetch
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello. I have done some experiments. For some reason, it works
correctly with JSch. With native ssh/https it doesn't work

On Mon, Jan 13, 2025 at 5:03=E2=80=AFPM Bence Ferdinandy <bence@ferdinandy.=
com> wrote:
>
>
> On Mon Jan 13, 2025 at 15:14, Danila Manturov <danila.manturov@jetbrains.=
com> wrote:
> > According to our CI, the first commit where the bug occurs is
> > 5f212684abb66c9604e745a2296af8c4bb99961c
>
> That makes sense, what is more interesting is why the fix Junio wrote lat=
er
> doesn't work in this case ... I didn't have time to dig yet.
>
>
