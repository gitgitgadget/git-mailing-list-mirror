Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5701DE2D6
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552361; cv=none; b=kJxS/ZrldoFJveATL7qQvMASGywNGa+cGyQ7gUyX0dU2ZMNz7BMC2MWPCS+AaRQVawScX2yBKw0NKWPBkEvHUK96Lo0mHO/FJIjVbahfHAz2cbBZHoavnL4+TRL5SeAICdyBvI5C1TVZr0ncvRtzl+vnZgrjq3agx9h5j7+9afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552361; c=relaxed/simple;
	bh=TdCnEgLaxfem1iFVe1Ptuzi5csyYSB27ZiDXxGEs0tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwLSmaheYKJI+xXr7yFTXUTcLeYLtNHUPKQaAbiAG+Fp+0Tj6b9o7EHg2IPqlav2b+t/6TiXvnTJ13ozCFEL2bjLr7GSEEZpZIMSMyHGFwAmIogqaPrfQ7QCQAJF/kIfJcA2T/0NFMKN53bF4RyZM9/GsdZSiCEfNhjLJhfb5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg/+SR/F; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg/+SR/F"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-549b116321aso7384123e87.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746552358; x=1747157158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjRwQB7SXCKJUQNOE3Qsaa+9pBqpPp0nZFuqFZTixLQ=;
        b=Rg/+SR/FweQHKK/7Ad6YRKmpK27MHPmJZC59Fyq4PQO/5cdTFtbjyvfFdsJtKRgZ8N
         wyBW142ivXKUzbhWMDx88pu2DWQL7xUoBLQOFd0636zX5IFlG6KXW9jsK/Q4TAYsIzlt
         c6QKJxDPhmovL1TTUBhzMMi4GDZh631K2zda+yVlIxjgqGmxWPfGOonV5W2SG93vpBcv
         QX5kgjTSAp3bUPsYDKDzBohZHVf7sCxxyCs6j6O4/ZxkB//lguK90vqXdf7PQiFbd1S7
         DP+go0ytw8wISWGlpDGmgdwNVWAeh1bA6pwtEF00I6D+vxyn6dpxRYoTGwBLAtGnlgI+
         KC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746552358; x=1747157158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjRwQB7SXCKJUQNOE3Qsaa+9pBqpPp0nZFuqFZTixLQ=;
        b=qKea+kW5R/IQnLZmHuJHEHYT+Bw8nEKJFytnwYQmIXvXpmRuIX//NqcbvcCEltdVkp
         aNfnoFtlhgKpxvPXjvxex+XV8MtY3DacMXDvycUuFfE20RmwjAO5LbpzWJdOlFUcAUZy
         ADsufZ0/rOfvltv8WS+Iu/ibTly7F6Snl+xTygTyCrb6CvzI3TILpCgQHLgZElbXB8z1
         vydfnr5gJ/fKZwHaBVFhP9ttmeTPXZ3Iy85EGK8TpptBJieujdroYrNKvWOhLP7aRwu1
         zcVdRN92d1WHbPrBehBFJ+UKMewhqrBIujVKF4jOBt/H/kfaIF7KjvH0iiaU483w5ymZ
         kiKw==
X-Forwarded-Encrypted: i=1; AJvYcCXgq4k9gB9S5xBGvyV/D5vzBrFzAqUGroYOcaPIl+9exii+sHzGXBNzfPaoXAEavxv09eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IhWbIsudGPwCdyy8yZ3XGDuCJZXi2NoWevKIl+8SxLSLHLni
	W2xUKfOIyOnRA9DCW/pVu2Sx06at1fT/cPyqq2UgJ1O6zq4mxp5A36FBCsw1Q697GdeadoFTH9L
	pGC4Y2BYZEXbQFVvaqIXCwyc3qZ0=
X-Gm-Gg: ASbGnctj91HSTMUDvgMojGwDy+IBxpD+pl/0tJ3Fy7Q1DDUETHKeFU1FjQ+kb9PepRH
	chdJTWICv3DLJajiJxRBtvLJJVIr8DiN3iyxg/JFGmzkWHf+K9au0rXnXIzgQkbE1LYJ40LU7qc
	Wm+0ucG1pc85AtvtFfHenB3hb2AGA=
X-Google-Smtp-Source: AGHT+IFJ8ZOLqCokbLBFD+p5E94EwI5sGn89d5bK6fUZpq18vFoXFgl5+NXQiJgnW1xG8sgpOqhHO8gbPym7Un73i6w=
X-Received: by 2002:a05:6512:3e15:b0:545:c33:4099 with SMTP id
 2adb3069b0e04-54fb9602b7fmr77581e87.27.1746552357581; Tue, 06 May 2025
 10:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
 <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com> <xmqqldr9lmpg.fsf@gitster.g>
In-Reply-To: <xmqqldr9lmpg.fsf@gitster.g>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 6 May 2025 18:25:45 +0100
X-Gm-Features: ATxdqUH4LFiHkIqKUzSvm0qgM1qKEfYTUHdpySB5vVKfFhf1qIeLeHjzpNeo3Y8
Message-ID: <CAP9jKjF2y48Zo6wSFPBN9OZy+iOhwmWPThVEt0o+9A0CASHXHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 17:37, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, in the real UI, the first letters of these commands (which
> have deliberately been chosen to be unique) are shown in different
> color to hint that the answer to the prompt can be like 's' (for
> status).  I would hate to see that quit/help, which are somewhat
> special, move from the very end position.

This is the main reason I chose to put the new subcommand before as I
also feel quit/help are better suited to be last, although I do see
the argument against muscle memory and is valid.

> Perhaps the example of the documentation page shown above should
> respond with 's', not '1' to show more prominently that it is
> possible and encouraged?  I dunno.

Writing the first letters as opposed to the numbers is how I
personally use this, just to add another perspective.

Would "config" as opposed to "settings" fix the unique lettering
problem? Or perhaps config is not the best description for what it
would do (I sometimes find myself using config/settings
interchangeably but the majority may not...)?

Overall I feel the first two patches cover my use case the most so I
am also not opposed to completely dropping the last patch about the
`--interactive` context subcommand. Inherited diff context and command
line overrides I feel are a great base to begin with either way. Just
some thoughts :)
