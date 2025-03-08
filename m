Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FE1CAA94
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455240; cv=none; b=QRc///A/2ZSsw4nAdfeFntd4UtIe+EFbbVlsx/M+iwM+iPTF9H1IdIWNbsmkJKTKA92ZVQ86TKvfWjKaFnGJtl4JedZF7zDXFOtg8nrm2TU+8hV5Ez7BwiJvSyBGIs/fANfFswmPbGgTqSs1tTqQUgszdbIsG2wzdBqiDAEDKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455240; c=relaxed/simple;
	bh=C8fTx/QfxhYiNvgQeX65rBBZOip01ANmf5l3VhRcPqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzvqsX+tM/fgddbEQxmW1D+l68WTE2+tkB/4/hYuzzywS1ff27vXT4dDWrY3Uf/bW4N+RPYK/BrZwCGZEida/JVGuYL4LSO9oZpFEi6yKJaSnWteBwhIktj4LLjLWy7fY8u1qCVvNPfncP7Swmr1b01cqk+6jTcdqEPceZzWJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU2pzzHR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU2pzzHR"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30b83290b7bso33039341fa.1
        for <git@vger.kernel.org>; Sat, 08 Mar 2025 09:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741455237; x=1742060037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8fTx/QfxhYiNvgQeX65rBBZOip01ANmf5l3VhRcPqA=;
        b=VU2pzzHRWjzjJtDCwcjN7VYRJ+m26uYmxCGjUg9HEwdwbRP/pbn3KXQjwAIoPPvqWn
         e660+mTBRgwoNPBqWhuLXAb2PR+ycPpX2+GLohWwLZsRKorrsAvri7wkvSvEr7P2ic3/
         9ZOXe4sRxrcYa45e78UbHGbSmTtEMrUc/0ibcwntKamtWp6RKxzqaYSywgf6UW5AWtFv
         qciZKtJliyKk9FirI8BNT/QQmG9+uL6FGV16gY8kDCiv+kvcTjDLecRvop+qZgvKola1
         oSXRngiyJSaavsiNvIticA5U9BUeh2yEwWDWT+IHBD5U3z2zsOu8Zdq1B68+o4H/+5Ga
         wnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741455237; x=1742060037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8fTx/QfxhYiNvgQeX65rBBZOip01ANmf5l3VhRcPqA=;
        b=OvOyuaztI+qXnebHiYHiIwRx8Mynst1e2EeqoWmqJbM6xMLYhwV7kxySsYXnLR9YGI
         sKSI0iKru6ENQrIRguShVsgo9LoNHHTRotrJVCWu0RC0C7zxGBl+dfRyxZEsEeKiRs5X
         FbL9Cu7NFNYWkTRKLL1pt3QERWR99NOPBt8yPx+zosL4ZQK2TW+t7BNVWhg/i/qDIV4o
         xMyJmNwE5zZ4ejRHp7nY3y8fs/Ch+DXYonN7nB6UByaU4ZRX9jJk+P8X1RBlR4HLkUg9
         Axbqy8RSdBeqHNlhW9m2L3kaUb9m2US18qSvTlNnxMx9CjU/DX70Bz0jmXp2U4eA2ZDs
         Tc+g==
X-Gm-Message-State: AOJu0YxeBXeDe1C8mhFjJFydvjIghHE9+TY+KhalHEXbTugEOXsGxdK/
	AlhuVqf8j+jvu55D8Lc6SXXCmcRfOlLVX0a3PsiwiHCBTI6ouLk7xrcN37XUQMRErGtS68wiiSK
	HBP6u6Khg5pm9WmrOHNEpNWbK6NHR5a2YuJ0=
X-Gm-Gg: ASbGnctHvKV/yHY6GyGPPDHVwv7gwoENXBDTfuXIMWDTd0N6lrW7D2D65HUbEm5IjGI
	GXuF9+TwvBsDPSCcRGs5/ACQBtuJ+9YAUMK8GGw3lU2X0yZ/8KmuBPbwpFxBAsz/hbSP96GRKyc
	Vlk//Qh8g07nyVeFvUYuM8laZ8XuZTnIo9R3JPDYbEJvlUFaO+9Fp73nEWvb4=
X-Google-Smtp-Source: AGHT+IEII9rdPvEn/lhisnZG2pstRLo5olwu444PoTfKz4BbfY/gpdscKrasGLOH8wNLYpJ6emdpgtRsbPEYsCw6y5A=
X-Received: by 2002:a05:6512:b14:b0:549:66d8:a1f3 with SMTP id
 2adb3069b0e04-54990eacdecmr2442429e87.40.1741455236477; Sat, 08 Mar 2025
 09:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
In-Reply-To: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Sat, 8 Mar 2025 23:03:45 +0530
X-Gm-Features: AQ5f1JrKUYAKQ49ugBMG650mYLrQucs10diLNO7cy6WZfuNlgZwhHpfNySq8qeI
Message-ID: <CABGrwBDLO9=FCjUW_LfJ_RZ95bRXWHFFNvdJfOuiYocGXdj3Mg@mail.gmail.com>
Subject: Re: [GSoC] Microproject: Updating Documentation
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 9:11=E2=80=AFPM JAYATHEERTH K
<jayatheerthkulkarni2005@gmail.com> wrote:
>
> Hey Git community, I'm Jayatheerth (he/him) you can call me Jay.
>
Hi Jay!

> I'm pretty new to open source and since I know C, Python, Rust and
> Shell scripting and experience with Git, I wanted to contribute to Git
> itself.
> I always wanted to contribute to open source code as I use them on a
> daily basis and I would love to stay even after GSOC...
>
That's amazing.

> So I had a question. I went through the documentation in Git source
> code as I'm new to Git and I found that there were several outdated
> elements and issues.
>
Ok. Can you provide references to the issues?

> Since Git suggests starting with a small microproject I wanted to ask
> for advice if updating MyFirstContribution.adoc would be a good micro
> project or am I looking in the wrong way?
>
I'd suggest trying to submit a microproject listed in [1]. Further,
please go through the General Microproject Information[2] and
MyFirstContribution[3].

> Thank you,
> Jay
>

[[ References ]]
1. https://git.github.io/SoC-2025-Microprojects/
2. https://git.github.io/General-Microproject-Information/
3. https://git-scm.com/docs/MyFirstContribution

Thanks,
Mahendra.
