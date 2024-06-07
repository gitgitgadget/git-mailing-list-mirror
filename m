Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80A15443A
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749721; cv=none; b=OC262bUsBevsoSGsRh5xTzwpzdemU3FPhzYGWv5RD5zT5tTkdTPQTqIiyivIdXVt6S7oZAaKFHe3Nnp0+oAFWDQ6NzyBqNJuWaUh5GzJVA+Dx6nyc/fmC7Ww2W9GLpL/nJFdq/NtFVBIW+dgrDoiSkwyc7nyzyk8VoxjitRNM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749721; c=relaxed/simple;
	bh=/jEyZ51ekO0OiLNzTRJdXr6dN3S1WRFpWqWLU4oP3VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7/gePUvjI5/yI3qS9XHNzLqvyr2Q0CG5sIS91AKTd37nh9V4264b+7JqkACHcTtEL5hQtrV3SmslaVphsuVO39z7QXInANCFCxbnUYfuUTfZVSHrTb7kuadb4O2n1SZ7v7NWmunI/qecPYBNQBDrRDSyureDEeH89cv4ww6BeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMEwjPLW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMEwjPLW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6ef46d25efso4574466b.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717749718; x=1718354518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly1DJFcLvqq2aXzKR+4puI+BOqytOMERS+zrkA47Gqg=;
        b=GMEwjPLWcyOY4NAh9ijAIqbfAgepNgWhB4pvYf+rQ/hvwqXiN3yPy+N5vdz7paQJ4N
         xUEDTT5ck/BHx+N3/0SkIDfAJViIu2zZna3Hh/297t3pfYFbX/HRd0muwA99PUVSvEFX
         +Wfu6KSzsWLi0OT3geOmkp3XKyD3mi4wNPqRlIi61Wo6Ispxnmib/jeIBd6Smq/z/n5/
         NUpsWmId7hfd4aHKWjXIbwaF+Ba7rdBd1j+e1HMuxOw9H8iOiO7sj98dNDXUmseFrJSh
         iUc1SYsWK0jDSyuDzmwNCmiW62T8C7RYmgLlFKmvaUWZzPVGkPbp7BgLBIPKQYpu1EmU
         kxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749718; x=1718354518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly1DJFcLvqq2aXzKR+4puI+BOqytOMERS+zrkA47Gqg=;
        b=cep4jbbHafH+Hc/JXA0IbXLVSFBhf4x9Gh02rykuXby1Ac+xKR+jyO8G/IumkpJNVV
         3/tbqTuTHzKLXtiwgMc0xQTp28sKrwLIqeeYfd+FmyQGPnrq/qbLKMVbpn+h5uArQxqs
         I8xTlKwKMx7qaymx4UUCcx8jJqslwM3Nf+5oa/bEatKIds6MXU67+x5bdEEmUbAFgf/K
         BI4C+qaG4v6MFOCAzTm1oUq8L0RLr1aJ0Lq1jJ6jOZgqEig1JEbZfzzSeshiBKiQ1IcB
         sIVdMo6sh32pbIUntN+BDpaB6ZeJcd9Gvqoufvn8f50FbiIqbozatBFTsEOf9t2457F8
         5WeA==
X-Forwarded-Encrypted: i=1; AJvYcCVeblBa1m4mQcoOBMlMr0czMB7TSoN4bJ0gtYoAfyIisR+uAkphWMRHOgramQue+Yu2vPH4sKEp3d1TKD3RYUF3CJ6K
X-Gm-Message-State: AOJu0Yxl7AOjQwtK9OBjaWFNOTAnvzY2FxPJuBTTWuS8ZhOejqMfmoLG
	9irV7ZorD9YWsDPqEfJZ/+KE61m78X5FGin7jiJBcp38R8K9ZdRKnm3y4rzazsG4o8NzGbcq8wd
	OaLkWp8bN8tGCivjSaoQi4fZVSduzlJ1T
X-Google-Smtp-Source: AGHT+IE/6t3zoTFfCOCwdZpmaRwDekE2fgo8DsIT896jdQXfb0T5tC1Qnk9v56khLKkVrdibYZzRicu2jWOkeiLwmMo=
X-Received: by 2002:a17:906:3482:b0:a68:ee4b:1e18 with SMTP id
 a640c23a62f3a-a6cd6663fb7mr146196166b.21.1717749718056; Fri, 07 Jun 2024
 01:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
 <xmqqo78dka99.fsf@gitster.g> <dohbd64jxuahelut63esztozdozqrhx5rgv5m4t3wt5gz6v6kv@6q2aivlcvxcq>
 <CAP8UFD0r+YYxAvN2Ej1mGa2Kt5M2dQgQEGLraB3iQ30cPWuA6Q@mail.gmail.com> <CAP8UFD2eUxrr2Z0etZKbakXEB5VAfXH63jLhfAYJyOxBwvJPEQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2eUxrr2Z0etZKbakXEB5VAfXH63jLhfAYJyOxBwvJPEQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 7 Jun 2024 10:41:46 +0200
Message-ID: <CAP8UFD3aTC_s8BgXYDcM_ecjMQmRsMiNMJxgXD2FLYvt26OwWQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:36=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jun 7, 2024 at 10:31=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Fri, Jun 7, 2024 at 1:35=E2=80=AFAM Ghanshyam Thakkar
> > <shyamthakkar001@gmail.com> wrote:


> > > static void check_each(struct oidtree *ot, char *query, ...)
> > > {
> > >         struct object_id oid;
> > >         struct strvec hexes =3D STRVEC_INIT;
> > >         struct cb_data cb_data;
> > >         const char *arg;
> > >         int i =3D 0;
>
> ... and above only:
>
>         struct object_id oid;
>         const char *arg;
>         struct expected_hex_iter hex_iter =3D { 0 };

Actually I think it should be:

        struct expected_hex_iter hex_iter =3D { .hexes =3D STRVEC_INIT };
