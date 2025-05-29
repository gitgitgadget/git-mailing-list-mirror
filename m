Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F34C92
	for <git@vger.kernel.org>; Thu, 29 May 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748548954; cv=none; b=N3aNgKWaR5KtP5TL4JrGUI1KuN9rc64hVAIEeXfDGh91LTCN+UTBz9mWPVMl3YPpqfv++sci3IRYnraEwhhZTOR3czgv9m+mCnemybJg1AYOiUhmbJZ+K6U7utmyFCtEOaV787eUxwgvsAWzLLw+QlTwG34WaEbGUsL2ORYfpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748548954; c=relaxed/simple;
	bh=spMMeO1Ga77FguGQ1dAENWZzWbG8lVRVIwO1hYH0JjY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=qhoYZwwTl6TE8cd8SsKGPfsTGtXzgrT8m61YVBa9ajNJRAaP5pqhe7/NsW2GD/K0+r+rKcBhMAjx2XEinaApeuLWP26n4Zg1E60MTrW3Nk6WBxOwVWk3kDI+9ESX84Z7XwtyOhy1HQtMQBHUFsXabfTIbQk4/2CIyHXl/fzbGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a25l4ze7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a25l4ze7"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7304efb4b3bso766060a34.0
        for <git@vger.kernel.org>; Thu, 29 May 2025 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748548951; x=1749153751; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiNcgA58UzWLCatCCRBz0h5mTHkSbmFwyVh8oYJ7khc=;
        b=a25l4ze7C2PyRs2DkqQ0j1xKgy6Wa55QdtiT//bUUnGZypOP2SkZdfPfxCzzQIBsk+
         yiy6DX/fPYJMYpsyL+4Nd/FLpjiZlsB99j5Qi2eYtabTSNpxXWQ+EpsyuF8nNu2JQR14
         tsTdGP7s49YfzSK+kA7Vi8KrRwubQZ6KbdqeZ9PyNO15Qkct8+1PJvtG/Knmt3VUGI3y
         2/mfjOMwQtM/cZqwVPqePGaAjZ8PAoTzZjKbdhGuddFW5MI+3JQeOHLa6rILnqU8KYY2
         60tGkEbjYZcArZasL1x0rI0ak8aTv6sJ1iHJXTbw3LGdaAcooBe15e2XYcoEg2zAuc6i
         COGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748548951; x=1749153751;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiNcgA58UzWLCatCCRBz0h5mTHkSbmFwyVh8oYJ7khc=;
        b=kSO+b3M8XhY1daZbjXXDCDk5C99nIMWSetBJG8kdtSzGXj4OB/fzTj+ppfmaiqnvYc
         6gl/HXogOdz4cBdN5DJMFAtHuV49Yxv88+DvIoMHnlu8IZqq8AxaVTXXJqMbIoi5Fde9
         HYNjDSeEjzx//w5M2UeQwYFeETcEujm+ldVP8xNITOYwOHOSRlynniUmYl2csJyoC73Q
         BEGsOIPiOapc/mZDnX8YdGQ74Wh6YhJ3EggA1r0iXnISG8V9sSVwdngMlyx/K8CYXuRN
         V+yykC0ADcPBUjCyeGQ7vTvuqDrnKGqrP2ATXzaqLVMl6byINC9RcqY7uDqYtJM/4P7x
         FdPA==
X-Forwarded-Encrypted: i=1; AJvYcCWU4C8Rc6TMV072mySLAxKEU/l2NX9H9qGoFibiUpekPRLhZ+mnYbsERQv7Fj3l0lMO2fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhcxASSZoJT8IKY+cJzn4sQafLy0FkumpU6d7yjGSNiDXMG1x
	Mydw6SW/a7+G8H6sf60Qy4+4qpYuMm2Gkdqik5Tmjhu55WH9gZRFjwLiz/jww/Y8bo2myVvcbi4
	f4V4wumBktXtI1f/T3vdOHXG8aZd36A3qG2ta
X-Gm-Gg: ASbGncu1UOFO0apT5VXI8nARpie7x5eka81F23gy7JxTcf9poAAUFgwxZNoUXTkKu5k
	QRfuZzNKFWXrCV1ukG2QAdGBVdfIi0V2YSAgSNIX8Zgg7McdUNGKAWwaNdSaabynt27uk3nk4Em
	SAKnFnaH4BK2y7dWs1syObaVIBMqcTo34LqDNGgVEAJYaxYLKM4uF5uRaVrnbzSUm7vmc=
X-Google-Smtp-Source: AGHT+IHGeXpCtztD+QhGp/eovnq4+/tV1EEV1Exv+QKogFkpJq5RYA9t6t+d2hhQ8NkQS/AgStJprsfvYipFSI4cajo=
X-Received: by 2002:a05:6871:e7c6:b0:2c1:5674:940e with SMTP id
 586e51a60fabf-2e9212cee43mr401604fac.21.1748548950604; Thu, 29 May 2025
 13:02:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 May 2025 13:02:29 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 May 2025 13:02:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250529192036.75408-3-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com> <20250529192036.75408-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 29 May 2025 13:02:29 -0700
X-Gm-Features: AX0GCFs9dVxPvW2bPMiZPJpldseS3hg-6IJlIzPV3l3Rxc_EBeSj5KC-HAy8TJ0
Message-ID: <CAOLa=ZRG2LWrivhqv-gn9x3Apyd1v1qtVqRLY9Sc6B1z34Fw5w@mail.gmail.com>
Subject: Re: [GSoC PATCH 2/2] MyFirstContribution: add walken.c to meson.build
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000013e9a106364bc71b"

--00000000000013e9a106364bc71b
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Instruct in the documentation to also add an entry in meson.build for
> builtin/walken.c, as currently both Meson and Make are supported.
>

Nice.

> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/MyFirstObjectWalk.adoc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
> index 29d26abb47..3b66e48dd9 100644
> --- a/Documentation/MyFirstObjectWalk.adoc
> +++ b/Documentation/MyFirstObjectWalk.adoc
> @@ -96,12 +96,19 @@ maintaining alphabetical ordering:
>  { "walken", cmd_walken, RUN_SETUP },
>  ----
>
> -Add it to the `Makefile` near the line for `builtin/worktree.o`:
> +Add an entry for the new command in the file of our two build systems (Make
> +and Meson) before the entry for `worktree`:
>

Super nit: The 'our two build systems' is a bit out of context, which is
why you also mention them in parenthesis. Perhaps we can simply name
them directly. Perhaps something like:

  Add an entry for the new command in both the Make and Meson build
  systems, before the entry for `worktree`:

Feel free to ignore this :)

> +- In the `Makefile`:
>  ----
>  BUILTIN_OBJS += builtin/walken.o
>  ----
>
> +- In the `meson.build` file:
> +----
> +  'builtin/walken.c',
> +----
> +
>  Build and test out your command, without forgetting to ensure the `DEVELOPER`
>  flag is set, and with `GIT_TRACE` enabled so the debug output can be seen:
>
> --
> 2.39.5 (Apple Git-154)

--00000000000013e9a106364bc71b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f598fad0f5ab0c80_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nNHZWTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2ZYREFDaklMeXhjK2Q5RGc0a1lLYnRGWEgremI1dgo4R3dhaFdqSGpp
VTk2QXN6bUhxS3ppZXFFUHZIalB5V3pNa1h4Y3BDRTJ3Y3RENmF5N3pjR2pUUU9GdUhXSDF2Ckd2
eWRKSUJpR0tUa1dKM2lmN1hGWTVSUHZrNEhOSzRPMzIvRlEralNCbEVDWVpjRGsrcDhqbmtQTVZD
cXFxSUIKMC9maUk4M3k1SEErN05ZbWdJMEZCby9RNEMveGJrdHBsVEFTb2l2UllicE9na3pncGs3
ODFZcWxVc1NXdmcyZgpqNkQ1OTQwRUVKRnhBcHhtVjY4VVR3NllpSlVrM0R4WWM3MXpEb2E1a0dm
UEp3akc4d3BDNU4zUXBpeGtMVk9ECjI2cjdodnI3a0RhTkZBcFFIMGJwY3dMejNtUC94U2REaVRi
b0lFQVBVbnRqNkRRa1lqZWNXcDlDWThtWEpUZzkKWlRzaGxEV0UrMW80dWd5RE9hdmY1T1lkbU9S
T2ZmRGVuSnp0UFpVSkFaMTFPdldCaTk4ckJCbVhmSWIyZ3l4ZwpMbjF1RHZSdWg5QzRFaHU1RTR4
dkxHV1JpeVY1WXJxS0MzUFdXWFc4WjRsOHFaS2RsWEQ5dHBjUnRkN09RQjFCCjJYQ3VCOTFYZVBn
elN4bjlUMGhCRU5mQzlOSXJ3eWVWVGlZRW9zVT0KPXRWankKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000013e9a106364bc71b--
