Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141418B1B
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708884347; cv=none; b=RYCArn/web4XqbjBjjyYjLVHZcyPb0YyOfw73raZV1UkCk9wikm06u0eMJbGLFDvorYsGyaH36fJxMv9QqxkAaYQl7Ab4esSCMWJhO+7NLKLLkaUbyDqR+pjLbanvxP1eOhvoo7zF+acD/nb3se/Qs6JztPlZUJKB+I0sN4FLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708884347; c=relaxed/simple;
	bh=33Dha4NqW7wPIi9i6ZblJv+QNFHAtPPdH6Q7y1IxC4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXAI3fUJWqqIkjzjhDLhbRSVsdwlfFrxscmIIAw29EszRmZyDRYfOG1E07yFccGekGgR8jqlE3vcCIKWy3fzffzDr8SsXbQ7wQuKgyxP7rLWlfnEtP936MlY7u+UG5ZC3Sx1fmDnJtqN+sdZMyo4kYHgHAXjfu9Dzv/F+rxswjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-429f53f0b0bso18183321cf.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 10:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708884344; x=1709489144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbLo5AKPzyv6VAbAG5m8cl4lPN87WbBERZ6HJZLJyEM=;
        b=ZNwl9Bb6tauu65+EaAdHbHQG26RohD7D/e8m/5wCLBmCcKq8woJN4Pvu5Wolwz5wHE
         zBsp6WFX14mw4Vr1usKjRUp1n/gqV+wfyECBFkXWGQNdsoUBtswk6XYMnSRM+0lTOM+p
         SegHKHqe5dUlW9h2PNMYJbzyYengeKn78PEtlQXjWuBA6bxbtsj1Y7Du03exFWuCB0tP
         e/jkbhvVfVLKhinkMkA7ULeXZLmXzLD5TFQj2nSBz+zR3ZsP5KSlB6TJwlT530B31B7U
         STZVVAAEiyC1VfggIrEXIjyEiolasfS4s7SDmRldDZHHnxPJE57lEGzwXWIaGC6ai0An
         QXRA==
X-Gm-Message-State: AOJu0Yw7BuvR4iSObVx9N1DbmuftYivfkLzJNTbEzTUxWm66bCO314bF
	BFX4ZoWjrOAUQhY5CrUUTRnHKeRqBWhaviM5VScZWvRkp3nMrRx06PXEScCdG7YGKVT3T72O3vR
	e168HqC7FfX2ORJZTWike/rr0aXM=
X-Google-Smtp-Source: AGHT+IFwIIpegDDl35ao/Dc152M0X9Qbg6thVVHEEGGDVknUgXUhRWvYS+ePg/etC44dxwtNIQUybG/Wb1tFbPzz0ek=
X-Received: by 2002:a0c:cb8b:0:b0:68f:b5ee:140a with SMTP id
 p11-20020a0ccb8b000000b0068fb5ee140amr1698525qvk.7.1708884343892; Sun, 25 Feb
 2024 10:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225112722.89221-1-l.s.r@web.de> <20240225112722.89221-2-l.s.r@web.de>
In-Reply-To: <20240225112722.89221-2-l.s.r@web.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 25 Feb 2024 13:05:32 -0500
Message-ID: <CAPig+cTvs7Ckg=k1T+N3N=yT840xM2DYf3LV9NZhii8+c1nkbw@mail.gmail.com>
Subject: Re: [PATCH 1/3] t-ctype: allow NUL anywhere in the specification string
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 6:27=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
> Replace the custom function is_in() for looking up a character in the
> specification string with memchr(3) and sizeof.  This is shorter,
> simpler and allows NUL anywhere in the string, which may come in handy
> if we ever want to support more character classes that contain it.
>
> Getting the string size using sizeof only works in a macro and with a
> string constant, but that's exactly what we have and I don't see it
> changing anytime soon.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
> @@ -1,23 +1,11 @@
>  /* Macro to test a character type */
>  #define TEST_CTYPE_FUNC(func, string) \

Taking into consideration the commit message warning about string
constants, would it make sense to update the comment to mention that
limitation?

    /* Test a character type. (Only use with string constants.) */
    #define TEST_CTYPE_FUNC(func, string) \

>  static void test_ctype_##func(void) { \
>         for (int i =3D 0; i < 256; i++) { \
> -               if (!check_int(func(i), =3D=3D, is_in(string, i))) \
> +               int expect =3D !!memchr(string, i, sizeof(string) - 1); \
> +               if (!check_int(func(i), =3D=3D, expect)) \
>                         test_msg("       i: 0x%02x", i); \
>         } \
>         if (!check(!func(EOF))) \
