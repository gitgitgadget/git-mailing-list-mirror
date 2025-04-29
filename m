Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF432204C07
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939550; cv=none; b=OTkmh62mah6mwR/wTatIK9t1zOVwzBTysG7WXb9AokQWAmgqLRLmYBFl+kRBsUS5pr1TFrKbPQrDxliG+SXLfOeCH6kUgGxdXLARYMix+ZPHNqKJAmIN95CjchdvfVx+tWU+btMYLRzW3sd7DReb31gdp0OgHFNmhofX+EPm+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939550; c=relaxed/simple;
	bh=0g2MQfT7un2YOv3NeKI5XxLTLlHNHf+MZHWb/bRDmhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIz/wuVSUGwDcLkYeGl60bcMQny8ZB0MBClxZYPVcI6fAYNeFyGi7S4R8jCUb2VJTp6U2d8COd2OB1TEmVZ9wBL+JqOEkpCqZo56aykNjffDv/HvQkIK/ySwdIrhlvTlh1vcD6fcnwc413oM6kIWE2MtDO54NYcYRAnwydbdSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPyRrmRC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPyRrmRC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so409721a12.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745939547; x=1746544347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRbiEyivNGZRsIdkf4dqDegpOEMvFdkHIxixugy7Z1M=;
        b=CPyRrmRC+zZDQIyQ3SjYEOFXWRgLctteM1xlGaBCQRg9PqD86R0y61+5M55DFibOaa
         v/ENflX9uxnoI23dgFFuXkjuiugtCb2/WCm/aPW2tFK57BWAoDfsIt7W1aIs8T5J0giy
         uizZ1Xmh3kbvuZFVsCMO2SaR95EmLG8ORgFYH6jZpez7Jz0Jf6umobXCfALQIKGyzfB8
         MZ70IzBZBmLaAd22QYWVJXAPddQR3G681WXuJhAZlE1qJr2Ohw2+5vNosbMYEfHQDCz9
         Mr7hCXdUAueyFzjcMEjXEBEHlPELjlgqBa4X4E8asJcXVnvmJkwhDdYXV08L2pCrf/is
         UjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745939547; x=1746544347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRbiEyivNGZRsIdkf4dqDegpOEMvFdkHIxixugy7Z1M=;
        b=B2RADC30DIP7JrxWM/bnXIa4aqBEX1/9Y4iIs/gsYJCQlZkyTdQvq0kWw6PnJXOvi+
         43b6fSReuiL5Hkquma8M2Hna7BosquBOxGl7j+ZNbsjdXPn/dGs+rqGCkXTjSPkUzBwn
         Kzoa6BilE7mznw07yrX8LKcpxXX002b+Qi/JNKJgelPSnsjEWG+pDSfAUmUR03Nlp0JH
         uFH4KyXr2ArROgzFRPLwIyew6tbWcslbsjd2U4yOrOP2z1lI0XaJ7CxSwWMEhjZQxb3+
         VwZQp82Fu9cQaz5JdBLtFpw6aRMJ6tyC/hLUUr77PaGVt1olgXfJeg2kdts03ttUTxK/
         MuMQ==
X-Gm-Message-State: AOJu0YxWHRTrAydQrpjG/qMjBg6404qWEP5ihCmbti9cLnh+5WWRerTh
	zsOGtR9DGwjp5k0+nvYIRrtqgdwnpwDitYeRj9za5B3Gf0Tg5SwW5tzeMv+zRnGQCq3Is8dAQ1H
	0uMDm/GC2U6oWxA2WK801/z9wLlM=
X-Gm-Gg: ASbGncs8ChIEOf6R1VqTRnQt+qkPMNdY67xf49iRnGje7JMf5k/4Xfzu/Zmp4v3+VX1
	jjCB4zy4uStyR3fNcXwgGhVZ1L/kbGsYjKpyz4DEMd7+D2sEBtpfS1NFhZNqsXJfy4FZJGBOTmN
	BwY1lriYVwRk1Up1JWvcalf1q+jp67hcmE6xIwI6pZAAbCMkSmq8lLcg==
X-Google-Smtp-Source: AGHT+IFidlnFPLxYHq3lDePmolKWu5ZFVk1soJRjZjuSDypladf+O/rT8CKEzIJnn3LuO5KKUaPUenWsSfuzmaCXoWA=
X-Received: by 2002:a05:6402:4408:b0:5f8:357f:8445 with SMTP id
 4fb4d7f45d1cf-5f83889e07amr3845642a12.28.1745939546655; Tue, 29 Apr 2025
 08:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250414160343.2216312-3-christian.couder@gmail.com> <aAdrzlUX61TK1x8_@pks.im>
In-Reply-To: <aAdrzlUX61TK1x8_@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 29 Apr 2025 17:12:14 +0200
X-Gm-Features: ATxdqUFY1rmD25DwvaWjYC2xU1Zz-uoyDxC3ujLswYjJco0f5leVN8YrQxtqHLE
Message-ID: <CAP8UFD3n09rzS6AMwAP6C=aADW+86r98onL8pci_N_OEF+FPDQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] promisor-remote: refactor to get rid of 'struct strvec'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:13=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Apr 14, 2025 at 06:03:41PM +0200, Christian Couder wrote:

> > +/*
> > + * Linked list for promisor remotes.
> > + *
> > + * 'fields' should not be sorted, as we will rely on the order we put
> > + * things into it. So, for example, 'string_list_append()' should be
> > + * used instead of 'string_list_insert()'.
> > + */
> > +struct promisor_info {
> > +     struct promisor_info *next;
> > +     struct string_list fields;
> > +};
> > +
> > +static void free_info_list(struct promisor_info *p)
>
> Nit: nowadays we would call this something like
> `promisor_info_list_free()`, with the name of the subsystem coming
> first.

Fine, I have changed it to `promisor_info_list_free()` in the next version.

> >  char *promisor_remote_info(struct repository *repo)
> >  {
> >       struct strbuf sb =3D STRBUF_INIT;
> >       int advertise_promisors =3D 0;
> > -     struct strvec names =3D STRVEC_INIT;
> > -     struct strvec urls =3D STRVEC_INIT;
> > +     struct promisor_info *info_list;
> > +     struct promisor_info *r, *p;
> >
> >       git_config_get_bool("promisor.advertise", &advertise_promisors);
> >
> >       if (!advertise_promisors)
> >               return NULL;
> >
> > -     promisor_info_vecs(repo, &names, &urls);
> > +     info_list =3D promisor_info_list(repo);
> >
> > -     if (!names.nr)
> > +     if (!info_list)
> >               return NULL;
> >
> > -     for (size_t i =3D 0; i < names.nr; i++) {
> > -             if (i)
> > +     for (p =3D NULL, r =3D info_list; r; p =3D r, r =3D r->next) {
> > +             struct string_list_item *item;
> > +             int first =3D 1;
> > +
> > +             if (r !=3D info_list)
> >                       strbuf_addch(&sb, ';');
> > -             strbuf_addstr(&sb, "name=3D");
> > -             strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitize=
d);
> > -             strbuf_addstr(&sb, ",url=3D");
> > -             strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized=
);
> > +
> > +             for_each_string_list_item(item, &r->fields) {
> > +                     if (first)
> > +                             first =3D 0;
> > +                     else
> > +                             strbuf_addch(&sb, ',');
> > +                     strbuf_addf(&sb, "%s=3D", item->string);
> > +                     strbuf_addstr_urlencode(&sb, (char *)item->util, =
allow_unsanitized);
> > +             }
> >       }
> >
> > -     strvec_clear(&names);
> > -     strvec_clear(&urls);
> > +     free_info_list(p);
>
> I don't quite follow the usage pattern of `info_list` here. My
> expectation is that we'd:
>
>   1. Acquire the promisor info list.
>
>   2. Iterate through each of its items.
>
>   3. Free the complete list.
>
> But why do we free `p` here? Shouldn't we free `info_list`? And if we
> did so, can't we drop `p` completely and just iterate through the list
> via `r`?

Yeah, it's a bug that is fixed in the next version.

> >       return strbuf_detach(&sb, NULL);
> >  }
> >
> >  /*
> > - * Find first index of 'nicks' where there is 'nick'. 'nick' is
> > - * compared case sensitively to the strings in 'nicks'. If not found
> > - * 'nicks->nr' is returned.
> > + * Find first element of 'p' where the 'name' field is 'nick'. 'nick'
> > + * is compared case sensitively to the strings in 'p'. If not found
> > + * NULL is returned.
> >   */
> > -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
> > +static struct promisor_info *remote_nick_find(struct promisor_info *p,=
 const char *nick)
> >  {
> > -     for (size_t i =3D 0; i < nicks->nr; i++)
> > -             if (!strcmp(nicks->v[i], nick))
> > -                     return i;
> > -     return nicks->nr;
> > +     for (; p; p =3D p->next) {
> > +             assert(!strcmp(p->fields.items[0].string, "name"));
>
> Why do we add this assert now? And if we want to keep it, shouldn't it
> rather be `BUG()`?

Yeah, it's now BUG() in the next version.

> > @@ -414,11 +461,16 @@ static int should_accept_remote(enum accept_promi=
sor accept,
> >               return 0;
> >       }
> >
> > -     if (!strcmp(urls->v[i], remote_url))
> > +     if (strcmp(p->fields.items[1].string, "url"))
> > +             BUG("Bad info_list for remote '%s'", remote_name);
>
> It feels somewhat fragile to assume hardcoded locations of each of the
> keys in `fields.items`. Would it be preferable to instead have a
> function that looks up the index by key?

On the other hand we always require a 'name' and a 'url' fields, so
putting them first can simplify and speed things up.

If the checks look too ugly maybe they can be abstracted out in
functions dedicated to get the name or the url?
