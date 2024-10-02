Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F72F22
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906849; cv=none; b=Z6/noRRybGqBSJ5WsnCX1CHB2gE3/TCL0AiBTDYN032O2OaA9KDMA5kJ/FLE0DgxglopDU05BZooj2GBWrpskKJIOTQiKFj5zMYM5OgfexyJLAb6+fpRYEVdQHHg54JnVwyJIQp+fRJ4kZlsiAfXwc4/RsqGB/YxU93ciVWOrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906849; c=relaxed/simple;
	bh=daBvqKCssbvDWDHt+Rbml0aIo7mhVDrop5OgiMQg+Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iv4Q0EmeJs1ReqEL2Y9GyHkavhVJrntT05FxM8L31umBC+QSvrTPx3bkL+2RS6wTsFgFdf0U97izvvSskBNVUPdZK4AbuCwxmBYYClusIni3QR72SMuo1D9jxVEEzZKKn4ZCPno/XO9VsgutspXCIyE6MQAPGHzI0jIAggiimzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb3eb30527so433326d6.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727906845; x=1728511645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9tvyUKC9Tn8QYZmM2XwOmSZ/xtUGK+eaFGEH7Se0C8=;
        b=DtJNe4W7YeRylJ1DrGYHqDszh5iRuOTfpyBpMh8MWtltBnob2DFfX2iHOG4pkm3BMa
         4/RgQu0Ll0NK0smqfi9x/NGFixhYthzb5Q1zpFBwJvl5YujxztyISZSmGJicoHK1Wt51
         tyM0Upzc2ZIELBapdm3eiw7q2csxHxwLDy2d7Xvj0xrMg4JeBqI7lF0UgLPXnWOafmdl
         IaI6AQq58vjD3BNB6/rR96UJ8ywzeuXS7wRKbcAUIsN8QQyNF+D0KRUP5FEC44Sua4SS
         8Ic4CHdX+QJFwqUot63rtg/W5iDSwPZe1v5+SYBPfdfPE/ZJAwtnMSkwXNreq1qEMe0f
         HEzg==
X-Gm-Message-State: AOJu0Yx1hPF3xB7Ut4br7DuV6AJqnzkeLnkHGMRzpSj8tuS5E/W7Tcp/
	nN3JLOA6oKmNG65f32lUAgQeXcM4XhpeSDKCSNilbsYzZbBXJ0Qq7zw69jofCPIsxjCPF5vYzSM
	X1l9XIfp/5D4TfTf6lKNvYPGlFu8=
X-Google-Smtp-Source: AGHT+IHbqmQbo6PLOFleh0hbLLT0wZnFHfEpgtRq+S7tbLTnc0nSCK0jsVuqE3zO81Mu7DFOxgNuFQowDTsrNHW/g8s=
X-Received: by 2002:a05:6214:5299:b0:6c3:6282:8d69 with SMTP id
 6a1803df08f44-6cb819ed5d6mr29230826d6.4.1727906845615; Wed, 02 Oct 2024
 15:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726489647.git.ps@pks.im> <cover.1727866394.git.ps@pks.im> <bdfddbebce9f77959fd9544cd5ba3496d5b9dccf.1727866394.git.ps@pks.im>
In-Reply-To: <bdfddbebce9f77959fd9544cd5ba3496d5b9dccf.1727866394.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 2 Oct 2024 18:07:14 -0400
Message-ID: <CAPig+cT7nni11bGmNyYCQZ0P0QZ_HG-izPtsymq==sUOkOn-Lw@mail.gmail.com>
Subject: Re: [PATCH v5 05/25] reftable/basics: handle allocation failures in `parse_names()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 6:56=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Handle allocation failures in `parse_names()` by returning `NULL` in
> case any allocation fails. While at it, refactor the function to return
> the array directly instead of assigning it to an out-pointer.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/reftable/basics.c b/reftable/basics.c
> @@ -152,14 +152,26 @@ void parse_names(char *buf, int size, char ***names=
p)
>                         REFTABLE_ALLOC_GROW(names, names_len + 1, names_c=
ap);
> -                       names[names_len++] =3D xstrdup(p);
> +                       if (!names)
> +                               goto err;

Am I reading this correctly? Presumably, `names_len` can be non-zero
here, right? And we now check for names=3D=3DNULL to detect an allocation
failure...

> +                       names[names_len] =3D reftable_strdup(p);
> +                       if (!names[names_len++])
> +                               goto err;
>                 }
>                 p =3D next + 1;
>         }
>
>         REFTABLE_REALLOC_ARRAY(names, names_len + 1);
>         names[names_len] =3D NULL;
> -       *namesp =3D names;
> +
> +       return names;
> +
> +err:
> +       for (size_t i =3D 0; i < names_len; i++)
> +               reftable_free(names[i]);

... and then we potentially index into names[] because `names_len` is
non-zero, thus crash because `names` is NULL.

> +       reftable_free(names);
> +       return NULL;
>  }
