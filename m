Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FA21FF2A
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230301; cv=none; b=FJXpKBMvBh2EVpvtDIzafsaXWPa1iv05NgH65/xC2cjk4ckIvcPVWdkxTAuQmlWcNbLdiJtJ52s0q3DbKam8qZaKgMxZIYYP6gD54dF+mHk/iEsvgP6gaWJqYS+imZN7JnaeIGyHyAR5iM9OdQluZwoBhDjxVqu5+Qkd2DCT5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230301; c=relaxed/simple;
	bh=qfz/7K/LKUYii53fJ+7oBpenqbeLHk9LupafkraRlWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKq2o2acJHh+kHpSQS4jVirBpKvKUUltvfPkApP17IubQ1aOZ+Q06mOMqI2SvX5aN7DfUDhCtSlotyCjoGh3DYfd4icqyrDL9BaiZZD2nAYdOMAn2Bt0OvkDx3tnNXThkzgwaSaOO/O5qbvMqyQRb/k1rje/9QSoFCCoN8zwbkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bESmeQ5a; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bESmeQ5a"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704c52b3so665749385a.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756230299; x=1756835099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghVD8BXAS5OSSZRpB9O+mx6ABsWPpKcI8IcU7p8Ta2A=;
        b=bESmeQ5a0It+rLVnY4GCBSe8jJevh8uiLIbatdEs3yL1d5E7TuRkeqKdRrBR863eiP
         18wMOFHOJPDmeZRsKBWKtaJenEzdqQGQ+82dluTWJAzJw+qNgvoaTGlxn1dPKxRBczWD
         y1BIlOkOTdYFDtDV6xAsKBOeVLVBQ3rVTS1XLfGuGLmBrXVCWj5oA07wOcdPFa6L05/Z
         1N1RHlkVMgtDjNt0+D9mmK6QhEy2CHyY1QXfiwr46dOy+lgVazPqv91Dd2Mj4SYI+I4d
         TJlnfeGGu3gv9yTNw147SpWNcQnW3OZNU+WglMd7QCHflo7fAJXbyT1eDHCTbvoeirpD
         wckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756230299; x=1756835099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghVD8BXAS5OSSZRpB9O+mx6ABsWPpKcI8IcU7p8Ta2A=;
        b=hQNIxMxjDnhF0phUE5AeDWjfzaaFcy4szksjNCnTIkLxcwS6LUX3kJAV7jiX8hM0J9
         faJhuk/swxDiAgmci0lk4ZyPwTD1L2rMjb8+XrwiMBf4VoYwRymyy7PDkHPlwS2KkNxt
         REeSZTCzVqaCQkUSbpl/9JX/EaZs18l0XgkW6eWJLoVrkIP9zt26D+OEzRWxt5wezsfB
         8bZqxYqY3mA8CsrR0QyDu9BdlRrWYHf47DgSfYgDjrhrUCg/EFRe/4oPYnF6s1rluVWl
         gYT04/UHLGGwNwBN8KMv4NIX2hyAPpCZwpXRkA2040544AYi1QNTzG7ZiyYcrx5hS0Sf
         bMfg==
X-Forwarded-Encrypted: i=1; AJvYcCXPEGgpgQI3Q4ARtdb9YLDpPUeeE29FQfWKMeWtKu9J10mxi4LAdhpe3QSGGgUmfZ52M9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oRljT4G2VKSRPpfn5OpQ9ZJicl9w08sWoo3SCL52EPZscSic
	7SwpQs7VIcou2MqET6wX/zMTuKh53PpyljjQ8S5OV5wB8e9HJJowGT2ZlqTPWF1tSjII1KD/Xdn
	gU7xKjiOXNh7+YjVqGWZDyTcr18OpYRZv17x5fW/H
X-Gm-Gg: ASbGncuexSSWquThoDWDLdSAU9H276CMHH/cF6hhlacR3hWja5ZeHK5YSpx2KUX2qoI
	CyrMsJsvb/Jm8x1uJQp5lVfKqKFY3F2uCZijHYR1KbIg8PYU8kY4Tny0N5oopNXROXyq7g1wAyK
	MmwCUML6rGwxPfKg5QGE0K/h8pClpL3ao93W6yTsMOn7hHkV7KbdIbcBlTZDX+VlcqC53j1Usgv
	oykvOXwypsOAm7ywYx515nRUTJWc8ESaTECkFawzS2K
X-Google-Smtp-Source: AGHT+IFVQzS76NFVBTF7XYwQz5uwhWvY7pIOl5PrLTdzle8LrTCG6zeEnDrjPVDq9vNSSzIBfvREhN7mgepiwf2QjYU=
X-Received: by 2002:a05:620a:4512:b0:7ea:1069:2c8d with SMTP id
 af79cd13be357-7ea1103a5d5mr1799856385a.46.1756230298312; Tue, 26 Aug 2025
 10:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826160437.2539113-1-davvid@gmail.com>
In-Reply-To: <20250826160437.2539113-1-davvid@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Tue, 26 Aug 2025 10:44:46 -0700
X-Gm-Features: Ac12FXyyE565u4qlqTAOiOhqb6n0H0dADwB5P37Ucs1GkeNisTxCbycovL4m5IU
Message-ID: <CAO_smVjviMdpZyHFp4zJc62DJYAZxLAc5yw68C3U+c5wbwRziA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: build libgit-rs and libgit-sys serially
To: David Aguilar <davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:04=E2=80=AFAM David Aguilar <davvid@gmail.com> wr=
ote:
>
> The "cargo build" invocations in contrib/ cannot be run in parallel.
>
> "make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock warnings
> and can trigger ld errors during the build.
>
> The build errors are caused by two inner "make" invocations getting
> triggered concurrently: once inside of libgit-sys and another inside of
> libgit-rs.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 29a53520fd..286d3ba3b2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3989,7 +3989,7 @@ libgit-sys libgit-rs:
>                 cargo build \
>         )
>  ifdef INCLUDE_LIBGIT_RS
> -all:: libgit-sys libgit-rs
> +all:: libgit-sys .WAIT libgit-rs

I'm not familiar enough with make or with rust, but do we need to
depend on both of these here? Wouldn't it be sufficient to say
libgit-rs depends on libgit-sys, and only explicitly depend on
libgit-rs in `all::`?

>  endif
>
>  LIBGIT_PUB_OBJS +=3D contrib/libgit-sys/public_symbol_export.o
> --
> 2.50.0.7.gec2f25360c
>
