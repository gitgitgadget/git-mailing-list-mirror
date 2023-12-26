Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1822307
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM1z39vH"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e18689828so4673080e87.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2023 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703618582; x=1704223382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpvpWiF09W1xv0tkmYY4BRsDtnJTX3lE0D1HY2b2Vu4=;
        b=BM1z39vHT9EQoFssXAjWi3jm0MyZRksN1nW8PT3gQE6cop4JreWoq+flTm/KRR4sAA
         5AAOg6o6WR9ElTuBuhr8Aw+qMV73VAbuxZwaGxSNYcRV3YhU0bAKlCMoGNeM508I9iZC
         oldhcKNxhv4Iwul9QaViT6sEohkVtG2ks+WkF/MlR0pyrQiuVluL0A6422HM/XcQYAW3
         IW0mNzLEpbvqF6TWQ1KzrAYXJZ61/fEmsCSzvesEmKLaeNWN0biRHq9kDO0E5AzuZ3sr
         5SgIDp18sNgAyPQRAxlIiewWS1tSsVgB7053Ca8sbOm/xu2gSIISTz7279q+H+Nt5A//
         PjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618582; x=1704223382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpvpWiF09W1xv0tkmYY4BRsDtnJTX3lE0D1HY2b2Vu4=;
        b=ODEdwSlgIznHOeT33gMskrS8KWzjXWl8AxuPKddvKNIG2HxvwdRKTqc9B8MpALYCuY
         DQQO8hqv3NqTZYfsXaHsNC12gZixTcry0XXkCT6/SrYQKhELiuaHYa8pIFOS0k7oWut3
         f7a1zbTKwnxWc/XWgpBgac6CJ5FGgMayDoEEmymROhRlrgC4EnvXmIxJQOO/WW+kdxxT
         UQn5da1W8P/ZkQcvqWrV4ULKLVaB1iZbpIsSI0hKb2+6Gfa93p3JYGy4tTHul9nDS/E/
         qPpat6uc4a0s9G7uNj8jqVvNLPH2TSVvMSq3/DHWODCZXLxwAPGaGj61OJzta2LVke1/
         8rwQ==
X-Gm-Message-State: AOJu0YyxYD1jqeg5dxZoKLp3mfQYsCWGuYUUeGxYV5NROhglkwOfrr6P
	TDc3Bk+6I747O/arjCCnRoYXYxuk1hOVjhrtB5Foo6st
X-Google-Smtp-Source: AGHT+IGv4/7MyAT5Db7k1MkNFLD2VWnlkL8+aqIMsLhBHh+wPTgqaEvmTBNwt0xDcbu747V79rLWoaIlVuOtxplP+Dc=
X-Received: by 2002:a05:6512:33d5:b0:50e:7e1f:8b69 with SMTP id
 d21-20020a05651233d500b0050e7e1f8b69mr1208254lfg.8.1703618581364; Tue, 26 Dec
 2023 11:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50c1f410-ca37-4c1c-a28b-3e9fad49f2b4@web.de>
In-Reply-To: <50c1f410-ca37-4c1c-a28b-3e9fad49f2b4@web.de>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 26 Dec 2023 11:22:51 -0800
Message-ID: <CABPp-BFcUdheVde6-uFjtwC4ZAmVxJe6SOMTOwRRWDBqOT=DvA@mail.gmail.com>
Subject: Re: [PATCH] fast-import: use mem_pool_calloc()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 12:18=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
>
> Use mem_pool_calloc() to get a zeroed buffer instead of zeroing it
> ourselves.  This makes the code clearer and less repetitive.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/fast-import.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 444f41cf8c..92eda20683 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2809,8 +2809,7 @@ static void parse_new_tag(const char *arg)
>         enum object_type type;
>         const char *v;
>
> -       t =3D mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
> -       memset(t, 0, sizeof(struct tag));
> +       t =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct tag));
>         t->name =3D mem_pool_strdup(&fi_mem_pool, arg);
>         if (last_tag)
>                 last_tag->next_tag =3D t;
> --
> 2.43.0

Makes sense; looks good to me.
