Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA32135B8
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731288; cv=none; b=IlchvsXgfx2JTk6fYVfAZgmoqBhOqoBsdqyRTomoRvzX0rLH2aRSM8o6UrJ4s+1C+mzADNnUTI+IPqODyIFRoaZ8slP221oB0lOnVOtaPmHnIMhWUIVqwXkwuIUP38nxv7BOQI2mYAWu4zI1rN/yn1XZneFkRoTT7DxM1nIIcqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731288; c=relaxed/simple;
	bh=lQMCzLwEgMKf+vwr7GZZI6bWn4YXaEGjaBkiqbdC8tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOjK6eXMbkicL7mxSTEfwG91QRUMMX6sTKA9Ru6IFaR9C95d1HaFmSyAn+UYr/kLrRk6+dNKc4BluhHimVCHFNd4aah1aYjwHSWd8i3sjoQnWk8a0pYOCzuns1wW+xhpmHTVOu4hSV4cCqaO1hIYBou0OKpEJO1xdBSJoAN/Q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDO18Hg/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDO18Hg/"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32e14ce168eso53142211fa.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753731284; x=1754336084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmuQf6J1aBGBaQ3zaUBN4SGvcJtxXG9W/2ied1299RQ=;
        b=DDO18Hg/TpojC9ZDsOWppIdzUL9zfEDqP9z04GNZDSh1gjwJEHtJeOOoYRq3gB/lfC
         49oOhAvgF14+qAz+Png0dFTDSsAfaRfar3NowkrDzI0iY9V3s6rcbm/fykJStJeuOPDN
         NmwiYRvoBsYo2YpsKinktdmLA2EC4L93s3EVYpAvMNxClWl3MNcQqUSPWk7lyEM4pzj8
         CHnKUb16G/NsXr6wosMpJTA2Hl9baVliSHa/pW71aJp5BUJglBi5JDQfnPUyFJB/4t9c
         a/EW14To6uR9eRtPqnC6c21Los+hkRtrks8WA0eL0kXOVzaSyg0/oH6EGAPkO0dUmUTs
         ZvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753731284; x=1754336084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmuQf6J1aBGBaQ3zaUBN4SGvcJtxXG9W/2ied1299RQ=;
        b=oCv3RtRbXhd4u0sZ29OZkAlF8yhx6kqOJw4UVgWfOsBU8MbqOuGzdWc0fvlFpwqypL
         cOPO+zkbwPzjDqZmPMceVefwUaLf35QmzW1MMlh11OBCc42p/cnOWFZV7CW+z9XKAEwy
         mg6V4n66ch9nOLKOELzZJDSFchvPdC02Joz+kuM4bvNtuHidv5t80B1ry5KhPOJGMdHh
         M08tYhyX0D/IA5nu3fFMJeAhmCfz5o8vmcqlTzlHmKC45a9ICL03cHaI8QDeZY3vxAgt
         9eii67l+pIf6ch5ej+EfZtTShSv3PiooOv1b8gOUdOXlKBtB9bhIYhE/CdYP0EtwLhIB
         4DDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOs+cPpXjyIamuzvXneCIEWWHeOZNQkr/ciTEISruWUoVNAF3DKLUqQJPl290jdedyIuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6V+3BU7Qyjr/TKodlWTLn3A/adMGwvf6wVeTY9xDlJw9C7ZQ+
	xg8qv+ITYELAwO9t4SSPm9Fcy655xnwnbjb5ExEDdHdl/9ZpUjtIYYsrqo2tlVAS6YHSp6ib1sy
	xJu3TYHpC2Ec7e27jgFSfhGIbU/vF6AnItEvT
X-Gm-Gg: ASbGncsPCeXaCQFlmixrAAAuAopvVB0v17UmrvNOzFJkR3ExlQbNoKL7J2IstmCC0wP
	tOIn/vdSB/0n/7KGqdd0bzI7k0P64SqnzEX7gTK/73BWvseSONAWCkI3JvT3gAhX/gU4jEpHi9x
	ymP2vq6cX9Tgr6ju3mWNMDyO5iqW7tz29Mulx8rzvaLitfYX2dHXzaY3QLtVwFmcwY/+JqbdNMO
	ZNcI/f8
X-Google-Smtp-Source: AGHT+IEkNnqMja87ktaX1ebNwXkCbTOTIIbOJJ9iBd+igQGgzfIoxqL+6bHh3/rXsr+4YrlzH0cc5cfX4iPkoWIzWz4=
X-Received: by 2002:a05:651c:408f:b0:32a:6a85:f294 with SMTP id
 38308e7fff4ca-331ee760b32mr19713051fa.35.1753731283814; Mon, 28 Jul 2025
 12:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
In-Reply-To: <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 28 Jul 2025 13:34:32 -0600
X-Gm-Features: Ac12FXxa5KkfEiO0COBiGJfzMIzpqNtJoiBaa7jz78_LYfTglI_s0NbJPoX4G_4
Message-ID: <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 7:35=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ezekiel
>
> On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > A few commits ago, we added definitions for Rust primitive types,
> > to facilitate interoperability between C and Rust. Switch a
> > few variables to use these types. Which, for now, will
> > require adding some casts.
>
> How necessary is it to change char' to 'u8' so long as the rust and C
> sides both use a type that is the same size? Also what's the advantage
> of using these typedefs rather than the normal C types like unit8_t ?

Rust defines char as 32 bits. C treats char as signed 8 bits. What git
really means by char* is treat everything like a byte string, and u8
is how raw bytes are handled in Rust.

> > diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> > index 5a96e36dfbea..3b364c61f671 100644
> > --- a/xdiff/xdiffi.c
> > +++ b/xdiff/xdiffi.c
> > @@ -418,7 +418,7 @@ static int get_indent(xrecord_t *rec)
> >       long i;
> >       int ret =3D 0;
> >
> > -     for (i =3D 0; i < rec->size; i++) {
> > +     for (i =3D 0; i < (long) rec->size; i++) {
>
> i is a loop counter and array index so we can lose this cast by
> changeing i to size_t

Ok, but I'm going to change the type of i to usize and stuff it inside
the loop i.e. for (usize i =3D 0; ...

> Thanks
>
> Phillip
