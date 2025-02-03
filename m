Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AF1FE467
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576289; cv=none; b=L+D6stjXgoFRpSOr1+t2RGlvTZ3YnNH5BPLI/J3iMzsKst580LeVx/0OYDZ63+S9mbUJCeKQ2a3j9w+GRSG4F0hG8vHUypW9mTQ419iluyy4RwLBbum2BSyjTdcnvD/hgX7zvRBfuQAUxaIZAhUMyHO65tj9TpWTYHtDxkKimso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576289; c=relaxed/simple;
	bh=HskEkVB+Ox5uktvKHLBCj1HANMJGOz4hKOKsCVUIs7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+VzoYfh9fwv5mKX4tNkyf02yKGb1XgnDP/BKEdbJ5ZBQx23aZVV3RBoum5aQt3B7WDhzau/c1rYN1z4lqVxrhi8HinHorle57f7snv9O7JD07TWxL0vsxAaCYMJRU4mqUwEdMLAdeGzh1GH8ha0mLL2p8p8Q4+dEgtwcB1BFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI5jKHmy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI5jKHmy"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso7717382a12.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738576286; x=1739181086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd4G8TRxqBowewxNiNnskjYSjAgn5TtlbL5/gJ3OTCU=;
        b=bI5jKHmyxcgT6ez1+CBLR0CCpvwspB2/FoA+RmkYbtRs4OTC/hV78Onf/RqCtOoqhb
         U7Znz+2BnKlvlELlPQ+q3p7AfNAq4eSwF5QeOnACsZI2LJ4l79D38fNAtXUyNOPzRmmk
         eI8wmFN0sJLMdh6+0x1sH3SUX2u7RIkCkNGDVf4Zv8Jpy/CGYnnxvw52hFV/6bLHVQK/
         c2xUwoX9JqGPEEcRJIQnkHAg2TejNaDePCFVX0MWCS3/UR2RXQGzhyHFs4pVk7CD6aiJ
         /gtDxnuD3RLnJg7AF036grdFzfmakJku/9SGPrsDOl6SlPv18dAnOyb1Pm5HDTwXYK5U
         xMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738576286; x=1739181086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd4G8TRxqBowewxNiNnskjYSjAgn5TtlbL5/gJ3OTCU=;
        b=P8OsPlv1xZ7ktC7kIAxAaiaV3kn/atO4iRVoNbLAXNjKN+HmOKgJL5LyXiIQA+Nh8x
         ThgFJxTGsX+ZfnAf22g97jh5AiGoVrUgCSizkMMBNWtUb39WGN9vcdaDHIR13oNEJ2YD
         AUBKvrNEqurBspEgY7eqmENEsGwyKmwnViI4dSdZghLNQykOCtdm4myYt+J00GvBqxTq
         kR93VhBq4jAFcHTksf96nouQONzWxcs57LbrFkgeYmTnbRxkVlvFZ/yrpSnXSLDzf2iV
         Wpk/pPyxRuZ/FzihPCbBc0Y8fMouXFApUIXlhMCuAWi/8VuyiDWDlPafjbQcps2som9l
         RxgA==
X-Gm-Message-State: AOJu0Yw1gKf6J7JlNImLbhrHAS3PzX9tQSUobvYjQuielr7oI+sWxnmI
	hJFPyAbK4DM0d4Yj467xShzt7O+dnyhqO4XoRfvrOsJtu6NpdnaSdy4YNV+OfGkFD9rurInu8nx
	9o+k3koTZMSvDAimP5L28igsnQ+4=
X-Gm-Gg: ASbGncthu2cfyPLTY6Qh4rqWMJOGC8unfm4jB7y2TW1rTFDXtGmqeKBVwzgPfF1nR/8
	9g2rnd2v83oCN0q1RgPGn8c8QWz9iEbL3G77zeI4R6nnhLKidW1j6Fgt2zVw0CZ4jIkc9RcxpD6
	Y=
X-Google-Smtp-Source: AGHT+IFWwQhK+Jxny6XWlX0gQDHR6XJzKb7+9spuFbFR75i5oqj2sK067tGIUI5hEHGviEwiBy0a1PcAeCLq349E9W0=
X-Received: by 2002:a05:6402:520e:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5dc5f008488mr22605781a12.32.1738576285662; Mon, 03 Feb 2025
 01:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110053417.2602109-2-jltobler@gmail.com> <20250201201658.11562-1-jltobler@gmail.com>
 <20250201201658.11562-2-jltobler@gmail.com>
In-Reply-To: <20250201201658.11562-2-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Feb 2025 10:51:13 +0100
X-Gm-Features: AWEUYZkr4EXEYhmzUV6zdsCj6TSrKTooTQqy2DphyyFe1Z7FNISAv9lmG8Kttow
Message-ID: <CAP8UFD2y=di9iKF+-nm90bg6zVnQ10OW+bvAyxTPM+xKpMYfLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] quote: add c quote flag to ignore core.quotePath
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 9:20=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:


> -static inline int cq_must_quote(char c)
> +static inline int cq_must_quote(char c, int ignore_config)

I think it's a bit better to use 'unsigned int' instead of just 'int'
for such flags, but it's fine here to use an 'int' because both
`quote_path_fully` and `no_dq` below already use that type.

> -               for (len =3D 0; len < maxlen && !cq_must_quote(s[len]); l=
en++);
> +               for (len =3D 0;
> +                    len < maxlen && !cq_must_quote(s[len], ignore_config=
); len++);

Micronit: If you really want to split the line into many lines, I
think it might be better to go all the way like this:

              for (len =3D 0;
                   len < maxlen && !cq_must_quote(s[len], ignore_config);
                   len++);

> @@ -83,7 +83,8 @@ int sq_dequote_to_strvec(char *arg, struct strvec *);
>  int unquote_c_style(struct strbuf *, const char *quoted, const char **en=
dp);
>
>  /* Bits in the flags parameter to quote_c_style() */
> -#define CQUOTE_NODQ 01
> +#define CQUOTE_NODQ         (1u << 0)

Nice small cleanup which could be mentioned in the commit message if
you reroll this series.

> +#define CQUOTE_IGNORE_CONFIG (1u << 1)
