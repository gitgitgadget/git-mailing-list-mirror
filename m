Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406D2E7657
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013040; cv=none; b=enC8IZRKhp7RYY+URSxdnT6UY5FuZoYXfDqWNhI0sMLPq5/uiqC0teiSFVpuVtLc20yQFVewzjdNPSAZtFnJtIZ4u/yfKHxM1uWNHmL6Y0iRxyaUCfg+fokIxnDA+M7T8P5THwpPYsljNSsAIdNELIMlUeOTVC/N3PAzJCFAvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013040; c=relaxed/simple;
	bh=gWxkIqxXwqh7VqWfR0+XUUGgLWGOxiMy9f2L7GiCjZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBwVH7xbZ4Bc/Gkf78+SKCbX91VuDu7LQRN0vjkHUXMb9cDncfdoT8c++B0sFfVpWoCVaY5VDsL2fcVBrkzeEr0T4faxowsH7SXVCNvYxV0d7Rla+TmbJmOPJTuSDwo88EUKSrxk+6A7/X3oCSS8KIeX0RgVV1+KNgBRYzyMNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfxJkWO2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfxJkWO2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3b27b50090so163605866b.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760013036; x=1760617836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SbnjWkh8U88qufCt+6oiNzGiFmIbpWmJe/M4sO2+sM=;
        b=HfxJkWO2uApcjAPhmy9AS+elhKicW0mPLjz8tkLQEtnF1eu6zEh4zmrDFZzp08MexR
         EsPhPsdKnxXTqjzPIZ/FIhKEopoFe+Dv3CrrdEa33ZovW/JxC9xrbCHWkNak+q+PDHGl
         41VfXaDQ02B1mkhbWDiKQPrO2deqHwARMU+FE21j2rhTM9I3PTKlkPiXkJLRlVvg0NzC
         GGn/mgJ1jsZ1ajb1cTGvfYhQEgMgLp2rQfll2hCfuBK4h+Wv/YuJMYu32GtXFZda86bp
         fDI7Xm1tUYwe4b9yyQ4a71jOPMEwJgmMZ6uOh2VZHNtSEOQIi/x+V4U6IpqjHFjK6hAm
         K0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013036; x=1760617836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SbnjWkh8U88qufCt+6oiNzGiFmIbpWmJe/M4sO2+sM=;
        b=chLkhHoLYDAI1e5CA0peG+SP4LvXh5DJRgbYR39iEbO7oO8oyUvBY6cMQ3kqKPTEuh
         N4oBsZduu5/tcrOuvHpQPS1xsNLqZCFkxExEWYPer0OdR94tBo0BMXQBGX9qh5SWULHJ
         qUzjT0EZNMvw9QOl/YU4yw12ROWATj+aI/tLppxtAcxLGVvwJZZqwaP+n/qHdk/IFCsV
         tpr/s0fep2qRJL3oflnSfYUmEw+3DRhsj+7YsrvoTgfAZPT4Pq71wWNmwSaL4ZY1/CMd
         lkrF612IIychdu9VfiJq/Qb4gyD3gvWiUAGqOr2rFYoHNoOPKdk8I3jwBx5zZ88U4fZM
         yxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPH2tp7/APBEI+7LGjCmznqSTNkierKroaNp47aPmeID8iane1zhEbRtt02jXs8qrsois=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2B23auyyv1Jtd0YBuMgEvUAww+HX4zNUU5EM7JCslOryysoV5
	fU3WL+C9hszXtbORLDh1sdAAYY5efglKBz1U6HHNgfIJ2juP8cHIYfBSumMhRGewxyDnaZvsYUL
	aoohOrn3Tpibjbf2xRuq2NG+yee1I6Wk=
X-Gm-Gg: ASbGncvnU5rD8qLvy3CKCsuWGFw8MBH+Ua5T1m7D2u4ozgtC+W+TPCbl3OgNbzvFe6B
	x7eiM50nBpkBh2VUNdGrEhoQS+XKCDPeC1D2k/A/0TwOvGkejaMNlqKfMKZf3QeJKJRLpYV3ddP
	p+ElkiQFAEx1PxtWuIs0wD4wYqttqx1XZ2/8Z3NpZmpUc9muQUQFZcRkgS57zPHbJuRp/zGRTZN
	OugO4+IiaK5YK61OD35mlurjUoXMe4=
X-Google-Smtp-Source: AGHT+IFo8/tzJeyAOsKH+hB1OTBdmp1ZkTfLrOxZLKtdAZWQKBCvQ0Fbh1lP/fTb4ZUnhfluYRdb4AlhRpIfvpsifBo=
X-Received: by 2002:a17:906:4fcd:b0:b50:697e:ba3 with SMTP id
 a640c23a62f3a-b50acc1a958mr806795366b.63.1760013035671; Thu, 09 Oct 2025
 05:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-3-christian.couder@gmail.com> <aOYPTKG9t4ZB_Mbi@pks.im>
 <CAP8UFD2VRfZuaycCdWt4kpVpRv_UhNHdzqJ2vL8uyKJusUttnA@mail.gmail.com> <871pncdfrw.fsf@gmail.com>
In-Reply-To: <871pncdfrw.fsf@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 9 Oct 2025 14:30:23 +0200
X-Gm-Features: AS18NWB-37jKQWRuqyAJei_4oMI4oHY8ZGmMWbiq03GS3KkQs0VeXpzRaxONv2A
Message-ID: <CAP8UFD1FOy1DZnhRCqxyPe9g8+S1yDMR9R=JstGNC4dtOQ1ntQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
To: Collin Funk <collin.funk1@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:29=E2=80=AFAM Collin Funk <collin.funk1@gmail.com>=
 wrote:

> > I am not sure. It might depend on the gpg version. Or maybe gpgsm
> >  does it but not gpg. I will check.
>
> If $GNUPGHOME or --homedir is the default (usually ~/.gnupg) gets
> created by 'gpg' and 'gpgsm':
>
>     $ ls ~/.gnupg
>     ls: cannot access '/root/.gnupg': No such file or directory
>     $ gpgsm
>     gpgsm: directory '/root/.gnupg' created
>     gpgsm: invalid command (there is no implicit command)
>     $ rm -rf ~/.gnupg && gpg
>     gpg: directory '/root/.gnupg' created
>     [...]
>
> If it is not the default then it will not be created:
>
>     $ GNUPGHOME=3D$HOME/test gpgsm
>     gpgsm: keyblock resource '/root/test/pubring.kbx': No such file or di=
rectory
>     $ GNUPGHOME=3D$HOME/test gpg
>     gpg: keyblock resource '/root/test/pubring.kbx': No such file or dire=
ctory

Thanks for this useful information. I have added a code comment to
explain this in the v2 series I just sent.
