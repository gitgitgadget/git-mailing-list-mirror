Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A528152B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027845; cv=none; b=P5/akjwYujOOnJ+NKToh603wrJHGGBnlRSy9So9KPHmOE0TnbLrXz7do41R1UMMOoFPxt/wwyviGhtNMkCvIOf81siyTBnKyAhydCDCeU9oyoldjZTRnrlJRP2bkXgDVahnWFAB7mXlDwMCmGZcK7G/fxmRnCO5+KmGER8bemyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027845; c=relaxed/simple;
	bh=sZTa/Zx6mPrrRL8ucf/nLp0P/7XEGXrbSmbhS89TA4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJijOxczq8jwTiKuuklQPME22C8tYSGRcszxaxa1v3XBG/EQ4sWcsgJ75ZqitRAiws8BdC1NoID2DpqFqMUTtCafy3SmPdLpY6EuIAH9VNS9o/Lo1XiicumBLmnzFrSBqOQzavTAqfDS7b5i2Y0iciTtU/5rv0aTxJUx1WKzJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3Uf1UPC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3Uf1UPC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-336dd55aae1so15006261fa.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757027842; x=1757632642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZTa/Zx6mPrrRL8ucf/nLp0P/7XEGXrbSmbhS89TA4k=;
        b=B3Uf1UPCRAaSJnqmwYPgQPi8tS1S9vEkrtZcS05LIHOUlu5uoKGTxa5cCUH79m/jkb
         NLgF557N5saPEgvUwXF2LIpU1ak/8o3DdmAWhgCdaBOEn2HE7MZvAe0KEF9txqvOp9Jg
         eNaKXKZbHvlb+xZNN/B2ApP0JBeS5CUYqf30E8QVDZMu60n11LzGJ4m10/OAo3zW123C
         0/mWRP7OOHJoMmAaVOxeasX3c2X1uB5udXM+cIOfd9HAmZDXR4Awq/j1q3MRtGjz04Sh
         3DWCgqJafZnUHLKwMfyHoDoC2JNSebwdQ4qKSnrHzRF5OTCpnC8YCP0xELMTlPNRysLe
         dqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027842; x=1757632642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZTa/Zx6mPrrRL8ucf/nLp0P/7XEGXrbSmbhS89TA4k=;
        b=t17Lj9rVMzjeXj7cpjqmIRoRPqqLkdRFWaa3Hc7216bCEqDQwNfYdzrDhPI7bU6s1K
         3hc7kaxV38NV89Sjalcd3vlhK+H0tw/USMfw9/I6rb+WP9T8BIC1/w3d2AxXystasZMD
         Ky9KZvXxVRLPavWnOi4uKUqLcpin5iCKLxFiuBtMD1ab5RfgJKq2UzAEqjbI+0hILtV1
         7GKVMDD0bmpZCMXzIjy6T7C/TP2xUWdbF2GXZbSRrYOgf9HyTiNbFlmGdzr5YHxuV8we
         0VXYmjKPlhnO5AGbtgotuOBbnu8fL3xbuvFNaH1lh4/6imJBMv93zHGjiPq+SzTYjLUj
         lKDg==
X-Forwarded-Encrypted: i=1; AJvYcCV8MIVzgj/wfD0hhqXWuBcVGt3VlzSNLu6V0fcYepvMg1kyxZfVJZFdpetUXQKRTbWrw7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EauhNfXWYaO6j5GGVLQLpRD0kmb6AX03OdV7LuIk0I1KW4Ry
	q7HG0v7DS1TVIXdCcHuFUiR8AhDmseBcr3GtVodUsEESCQ8v9efJXcSHVbCoZNIw3g0Qh8hwF0N
	kaNDEIgSuirGZCHkRoBeD4mQE0XziJ6Q=
X-Gm-Gg: ASbGncvgRxJcXf4yBFIbKQyTR6mDA0XLv2j8WGq8DcPebDIq7LWhKQM2n8c8IrZOmNW
	HzDiInBowC+CEjGTLY61SlIETvkDNMg6uyKjUZVPjT0hN3WnIVXV65bnGm7EqiEU/DXS+PBnNET
	xXBmKMFhLTCWDSMN8mFAZgG2v7etoQYTv6SP//CVAj35s6BF6bQn2mlarecEcTxWbx+nMP0Std6
	Eo1N5JN8vnOOGM+KdGLGkaIPjXrIA==
X-Google-Smtp-Source: AGHT+IHqFfbx9nhI4hx+MVifKsTPIQqCk4ylSvYY2JOMUZFwhG1DKlXCHcQ+CsyR61ngqeqLm6cVxjzn6b/qPbzc4H4=
X-Received: by 2002:a05:651c:211d:b0:337:ed76:7067 with SMTP id
 38308e7fff4ca-337ed76723amr37787281fa.39.1757027841573; Thu, 04 Sep 2025
 16:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local> <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im>
In-Reply-To: <aLl6iFXeAvL_hvqR@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 4 Sep 2025 17:17:10 -0600
X-Gm-Features: Ac12FXzJIlp8kqqz52Pet56htxmPdt3CkaL7Eg7EhuGN1BXyi8Wxf574ArBfoS0
Message-ID: <CAH=ZcbBLAKaE733_2_2qbFTYCfwGq37RfF-Z3vaKL1ZR49msAA@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com, Elijah Newren <newren@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:40=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> The only reason why we want to have it as an optional component is to
> make the transitioning period easier for downstream distributors. And
> the intent is not to convert major components -- it should be trivial
> components that we can use as test balloons, similar to how we did it
> for all of our C99 test balloons.
>
> We cannot just pull the rug away under their feet without advance notice
> that this is going to happen.

I think making Rust optional for at least 1 version is a viable path.
I'm not opposed to that idea; it was just easier to develop and talk
about Rust as a hard dependency. I needed to know if making Rust
optional was in demand before spending any significant time on that.
