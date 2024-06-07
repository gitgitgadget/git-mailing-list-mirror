Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B415B109
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749432; cv=none; b=ktuuf966D+V4R/n3EnuOJbjdUt93t5Wq+h/iC1rixjcXl1Pw0wKd+uBJHNg4prsNT3jMDGQAojCbWuyTdAF0HJy8yJx8YghO9QreAP8xnF8AH4BBowzZokgeDJXKhpXBughhKojhQB/jkVnTirbomKqnge9QZSp9+KLGDhg+1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749432; c=relaxed/simple;
	bh=i2LWT7NJhui3IYCWuDV1O4Xgw/N4J2m9JGMwHyt703I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQZZjZdwYBBaZB750UMphvIGsSb0NEVm8CtXqOMBc54fwbYnQuEVjFBKBnoFU04e2w1jPn9S0l11kto6JhU27eQd2Bv37jB7Jd4M+ABO4mxf530d1oW2MzIsX6RBeTYikeLdzf3ta6PjJ3UAUqvkjQ1U+e4FAAT+4e90LrsRtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYqrj8Dl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYqrj8Dl"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d48ec3so218952866b.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717749430; x=1718354230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNWEDvLW3bqpnbRZiHIGZ2/+Uy8YBWrOYBD3U0IW62s=;
        b=HYqrj8DlMsRaoySONYPqQW1izXqxPfD/j1j6q/XETd9STh6Y2AtcHvAHNOF9yVZ4rs
         EGgu64psqFyqOSkFjqT5yMEUl8EzwgjcT+Q/zhCrQzXoIWN4oTMBaSO6CNw9RMspBPWL
         x24CUQZuy103U0bRrEUAeg+jkk3Ow3N7lBuzi3XmcAkekA+ZlmEIe5cjgzjB7UtoieBy
         jBmmnveWjpfG3jZBpfajgHZwrT4Uf7Lcd28dKbEnvQVqVMnq2iMWdwHfkQflIrbV6TzL
         0CFtmWXk6A+1F4mUHmr+2+5H0YmnLQ796OiFJNsYf2oX8wdTE5yf9H8bhQwikXZUgJRw
         NDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749430; x=1718354230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNWEDvLW3bqpnbRZiHIGZ2/+Uy8YBWrOYBD3U0IW62s=;
        b=ceZVC2Nsswk2W82k+LX66VJfoggjW5L8pHn7gqfGlUeRcSSsWE1KJ0YJ9c8FaIRsZi
         W/8Ph35LmQ+YrPMo7uaNC3Zc9qoHmjXU5Ymoq+U2UtKwqfrBKDMACb+pKa+r+RZXNunE
         XhGUn9DdIz82g6oweqnbfFRd1c9ARYkofdA43lBzdC8hPJD7x5kn3Jyb8dXossKnfs7T
         CaMNmb94miXK77IF3zijYxZCg6zxQtNAyN/H7T/PjXHC+cw+rMCheMOjjHx5wsGvNKAo
         UJgIQigrBp8iBwC6TCGbRTS7gA5IGuMDeeDhKSJm0oJER4ZJEuf4Otbd8ne6HlJ6T9t9
         S6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCU15bWoaTOcJz2L7qBOSK1VvUuVGqJmJIdJDZbcyWxTjwjl/w4DELLoedTPkw/egXcUdW3gjJahpuZJHcRfnYSUhN70
X-Gm-Message-State: AOJu0YxesusFkcaO2hH7dPguXu/7ZGS4gQRbz2W3r7Z7EcwGyHZ/giSp
	cNDiSSJ6dN586+1Y+nnSaurVyMe2GH3aUspnpROVOfgIjovmzwoR1hN3GyvSX9Yn+IxLykK1e+Y
	s0sUrdo2qgcKm5X9ti2y79rBj9FA=
X-Google-Smtp-Source: AGHT+IGWcWH9iwvWtAjwwoQGJ5tVX5X/IZz2fLREgMs4PvrUWRPCzxE1Bz0f9dXqh1Ibj1/bK6pChO3fmzMNMlNWHCw=
X-Received: by 2002:a17:906:c191:b0:a59:a83b:d438 with SMTP id
 a640c23a62f3a-a6cd675c490mr129798066b.23.1717749429687; Fri, 07 Jun 2024
 01:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
 <xmqqo78dka99.fsf@gitster.g> <dohbd64jxuahelut63esztozdozqrhx5rgv5m4t3wt5gz6v6kv@6q2aivlcvxcq>
 <CAP8UFD0r+YYxAvN2Ej1mGa2Kt5M2dQgQEGLraB3iQ30cPWuA6Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0r+YYxAvN2Ej1mGa2Kt5M2dQgQEGLraB3iQ30cPWuA6Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 7 Jun 2024 10:36:57 +0200
Message-ID: <CAP8UFD2eUxrr2Z0etZKbakXEB5VAfXH63jLhfAYJyOxBwvJPEQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:31=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jun 7, 2024 at 1:35=E2=80=AFAM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
>
> > > Come to think of it, how is your check_each_cb() ensuring that it is
> > > only called once with "123" when queried with "12300"?  If the
> > > callback is made with "123" 100 times with the single query with
> > > "12300", would it even notice?  I would imagine that the original
> > > would (simply because it dumps each and every callback to a file to
> > > be compared with the golden copy).
> >
> > That's true! I did not think of that. What do you think about something
> > like this then? I will clean it up to send in v2.
> >
> > ---
> >
> > struct cb_data {
> >         int *i;
> >         struct strvec *expected_hexes;
> > };
>
> It might be better to use a more meaningful name for the struct, like
> perhaps 'expected_hex_iter'. Also I think 'i' could be just 'size_t i'
> instead of 'int *i', and 'expected_hexes' could be just 'hexes'.

Maybe even:

struct expected_hex_iter {
       size_t i;
       struct strvec hexes;
};

(so without any pointer)

...

> > static enum cb_next check_each_cb(const struct object_id *oid, void *da=
ta)
> > {
> >         struct cb_data *cb_data =3D data;
>
> Maybe: `struct expected_hex_iter *hex_iter =3D data;`
>
> >         struct object_id expected;
> >
> >         if(!check_int(*cb_data->i, <, cb_data->hexes->nr)) {
>
> A space character is missing between 'if' and '('. And by the way you
> use 'hexes' instead of 'expected_hexes' here.
>
> >                 test_msg("error: extraneous callback. found oid: %s", o=
id_to_hex(oid));
> >                 return CB_BREAK;
> >         }
> >
> >         if (!check_int(get_oid_arbitrary_hex(cb_data->expected_hexes->v=
[*cb_data->i], &expected), =3D=3D, 0))
> >                 return CB_BREAK;
> >         if (!check(oideq(oid, &expected)))
> >                 test_msg("expected: %s\n       got: %s",
> >                          hash_to_hex(expected.hash), hash_to_hex(oid->h=
ash));
> >
> >         *cb_data->i +=3D 1;
> >         return CB_CONTINUE;
> > }
> >
> > static void check_each(struct oidtree *ot, char *query, ...)
> > {
> >         struct object_id oid;
> >         struct strvec hexes =3D STRVEC_INIT;
> >         struct cb_data cb_data;
> >         const char *arg;
> >         int i =3D 0;

... and above only:

        struct object_id oid;
        const char *arg;
        struct expected_hex_iter hex_iter =3D { 0 };
