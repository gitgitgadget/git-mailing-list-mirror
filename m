Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51E3594B
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738577292; cv=none; b=qgwEh8R9fHEgFTvsf79uli+7ENwxdThkBkFqj1VmsNe9FCV/+bB3kP1jzYy07yB+LaX38eTamsJ7IS7aiJw3V5SoHpFwMms/6ptOOsICNfMGliefr0XTb+YynbFXE/OYOdL5yRPseaH9fdYq59xV544ICm0uHats2k/SyLRqLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738577292; c=relaxed/simple;
	bh=Mtys2tzAU3UlSprWiYG8mXL2WW+Nwf79Sjn0zT3Gdig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUiVQpK4j+eM/qM0C76wJsXpD3DfdYWqdWPgm4yZmZ9fNZuwmzJUUVa5VxcfQPwNEfSNaOdXgk5cSl9juwCSPIjcu6yX9rJOwbLJJJH4VmLFGYlZ6kfPr99nRvIWVXWvKLyZKLprdpTeB68xMUQk9ZhOL8t2qiBpQuI911w8Bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLwJf4+H; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLwJf4+H"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aab925654d9so781112866b.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 02:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738577288; x=1739182088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ6lhhU0psYMteJx940nP39XqKQaQuCYBoG8L/QJe0I=;
        b=PLwJf4+H+droRuB5DhcxE/zS5x+Baly/73mhdOMK/o6RUefgXlohzRLG8KRBntL65h
         272/w05oNil8AsgJvsMf2nq6Trb5GpBrN8tNWl+8j71/fK6kIFKTuTMW21XiKh9LMrcL
         O4MAy6XFoZN6OEiKPxRRDuO+3JLkOocEmBdWXAEl5ZKCOypgTTAdHqofnphFfqLQqpc5
         uPhe+YKXxYZow8eRF0inxgpXjn1yR5SzCCAlStHuGnmjah1RNhmLVES8evVKjTxNXZEA
         risZfc3z7l0zssnsf2lPHHxxQ5xJZcyVgf8ls5n2ZwHWyS1bfbqWwOnPQ+eDXsnt4LQ0
         9R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738577288; x=1739182088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ6lhhU0psYMteJx940nP39XqKQaQuCYBoG8L/QJe0I=;
        b=b5t+UyEiCHaj/4BzGlcm3rLdHh4BQopVyGrtUWRsbcqoErAV9Ger3I1CKWM0U5Z0ox
         kVGDASLfWKDw2dT2HQ4hmPLmxUPgdaAviqkj9nv5294vmyP6JIXiSGxnVvgo4XJ6sesk
         R9hdWhoRxwOuJ41lV8UtXgfRylfbPf4ep/84zSaE0hBembPm1nwxq+PCFAe5hG+8iHOG
         XNQJM6Ix8u5Q+ZQUJj5MjuJkq/5thlDFzddU5j38miouWoF4lrAaxo0LIWnLP3kkS6ZB
         JmP8RkqVRElpGXkIGuh4BSPumhiWbfge5cXvaAU+u+TwLTiLUHcyyFYUhxq/XmDtF4E+
         7JQw==
X-Gm-Message-State: AOJu0YxYbL7B1mXK5nsu6F74s+JFgdX37/8XkJDcVBBEcBuer5aNyJ9y
	nuMwaH02+p5wMldsubmxq6jKc4JQ5Sg2TT7m+nIWe34f0jb2fOQSHLGH+fO+XGbZwbQuwtcUoqC
	TPIiK7D1Czh4XgoTntfpdRBbz7tI=
X-Gm-Gg: ASbGncv2170g1+o/oZoQHG5v14e3s8tKHuiYrjxz2qgSGJxf0sQFPXHypMOnwgd+Zk0
	Pfi0ZN2bowN98SGyWqqEJKPuPjUQj+38MKK7UWim9eyS2hsOpcfkqXXS4byI470UFnN74j1hzRg
	k=
X-Google-Smtp-Source: AGHT+IHu4dhRhqRFeBA9S/p2zlpTR8kgcYPMD0LKWa3li5I7JxPwhYlz3hLLano7FP148GCC4ZXEacm9DRjfy+48l9w=
X-Received: by 2002:a17:907:7ba2:b0:ab7:e16:aab7 with SMTP id
 a640c23a62f3a-ab70e16ab12mr851765566b.13.1738577288141; Mon, 03 Feb 2025
 02:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110053417.2602109-2-jltobler@gmail.com> <20250201201658.11562-1-jltobler@gmail.com>
 <20250201201658.11562-3-jltobler@gmail.com>
In-Reply-To: <20250201201658.11562-3-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Feb 2025 11:07:56 +0100
X-Gm-Features: AWEUYZkQ4TxyJ4Ji2WB5esdV_MtaCZcHm_DN4ZA6VanMNbV0Sz0NXl3M1OcZBVo
Message-ID: <CAP8UFD0bPXkryaBRQCJZfOOPXBRmxs3EMN9mn1SmBBbvmb7YjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] quote: add quote_path() flag to ignore config
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 9:20=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:

> @@ -370,10 +370,18 @@ char *quote_path(const char *in, const char *prefix=
, struct strbuf *out, unsigne
>  {
>         struct strbuf sb =3D STRBUF_INIT;
>         const char *rel =3D relative_path(in, prefix, &sb);
> -       int force_dq =3D ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' =
'));
> +       unsigned cquote_flags =3D 0;
> +       int force_dq =3D 0;

I don't think you needed to change how force_dq was computed.

>         strbuf_reset(out);
>
> +       if ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' ')) {
> +               force_dq =3D 1;
> +               cquote_flags &=3D CQUOTE_NODQ;
> +       }

If you didn't change how force_dq was computed above, then this could be ju=
st:

     if (force_dq)
              cquote_flags &=3D CQUOTE_NODQ;

>  /* quote path as relative to the given prefix */
>  char *quote_path(const char *in, const char *prefix, struct strbuf *out,=
 unsigned flags);
> -#define QUOTE_PATH_QUOTE_SP 01
> +#define QUOTE_PATH_QUOTE_SP     (1u << 0)

Nice cleanup that could be mentioned in the commit message if you reroll.

> +#define QUOTE_PATH_IGNORE_CONFIG (1u << 1)
