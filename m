Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186832798ED
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663900; cv=none; b=ox5qpCWYZNWkxBpkbK6VuDuehzzfNHDqqWRZ0shbLxbK3SJt73KRs22KKiWyiL5OqzYCi1TtpY5MPgzxf0Shd5E60eEkFVKXlQiORiz1DkIPlZ15B7J0IXVt2zzoDuX6MqB8mhcNJRKv1EwMV9IC00m14jRlvYskIM1IXJ9HsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663900; c=relaxed/simple;
	bh=93+jmtvS3RrZL690SG7kNqbo8fPycnmOQ/tmJWcsM5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJUwmLwwzTY0L7FO6Znu4t37EGfge0JDL6A177IXwD7hIuItcdYgqJESXCmOlkKdmlHX1uxkzMPxppgP3ZGAG/N2TbYGUI0mRoPUs6EnrmzP6/c6twPa7b8F80S8KLaXmGkgIgRD+ElzIUNXr7MPqoKmCaHCBbGgT/k/riqpGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzUu1oXx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzUu1oXx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-601a9e65228so2902933a12.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663897; x=1748268697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAdT4C+zdH1Iq94hmsjr/v4d2kBoe2z82dSZ5nwhktM=;
        b=dzUu1oXxyj/OozqYzr7ZiQCLv4We6QQHxjT6/yLMmtlwlvxr1Il3EQLhVoXFeLnCyA
         YWyRG4qUpPQrSnnkFZmuVWws4yC1JsrXpN2m8i4lCZGw3wTcVBeE3xhWTL8BxXdd9c8l
         dNPc1h/PVq3cCwnJbZYFPyEG809QrxP7/9hoUd72uYQduxam7rM8L4Dv8UPjjWT4KVMW
         XsNjR0MEwvg7KnqvKM0WfFRisgjBiy3qmM3xah47CmDuRrY4J09vxeaA6Kcyr6+Exso1
         XhpxXhkHGzCU2zn4/Ccrg4SIIqycUZv0HeGZL4i0py7CYEb6HxdxOFe8y7GZn8DYQ8zR
         XH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663897; x=1748268697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAdT4C+zdH1Iq94hmsjr/v4d2kBoe2z82dSZ5nwhktM=;
        b=WFOGwP1gVgXvVRUjqKdhTYBNK/orvaNp5TyCo0Xmqi9Da3DK2E1QJ5ktRmedqa95L5
         qya481xpbtEg1p3c/9MIo6GVUs6YLWsDku37bYZEwXSwCwcKu+0IlmtJI4z1r5RefH1k
         jNFzaFMFRX0CePNwsciEXQyR2a4h6Fue6SwsC11/WlrG//px0KM40UZNW/CrtZwraR2Q
         4Lr3WcvzVh7UpnlIi3PujOqk1ZZFUsBD1TJwVTl1HGb+QB5m2yxV9M8+6MMZdC/QzKrB
         yiDrae6vZKuXbqHYSA2I5bbyjyw+TrAt1byRHQ4Mz4kIhpa76M3P4QhGYo99zxyaTq2D
         j04A==
X-Gm-Message-State: AOJu0YyGugJFrcHMtvNxzE3ksO4pS9yjo0eNneMYNbYmjspc1Uk6pNPZ
	5vD83X6D/foHK2zO+dJeyApPH2w7L7kdW2oXMfK//nqq4kMtjgBCw9px1M6VxlIAHTxat8xEhcM
	aFn+5Wo+gLBrd9SxqFCXO5GY9CFcEXj0=
X-Gm-Gg: ASbGncvVJ3k4DTEw6IOvsa1XgKHONR252iwEwm+D3oHyBAY+Zig2iw3j8kJLzBkFlC4
	EiBIfd96PJA1RxpfKstGcxo5fJWYErFH/zOcVoEJb1qY/Ak0rljCI1PxbL1TBHcbJdsjGVpK+0v
	ISxhsjjLwK2nj90IIHKSe+wPqbDgt+nuXP1Bo=
X-Google-Smtp-Source: AGHT+IF23oFTTTilFct6G38otuiSzCyJP0JkdyuvdUdZ4QA7McWZVNQ8ygi3d8oaMAvxIKP0e3pIKeauoPaR7RNoY8Q=
X-Received: by 2002:a17:907:3f21:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-ad52d4d1b56mr1019157966b.21.1747663897244; Mon, 19 May 2025
 07:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-3-christian.couder@gmail.com>
 <CAOLa=ZSwzvfQ8MupFzuMEpHCKJRY8p06m-FfyE-deqOsgK_feg@mail.gmail.com>
In-Reply-To: <CAOLa=ZSwzvfQ8MupFzuMEpHCKJRY8p06m-FfyE-deqOsgK_feg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 May 2025 16:11:24 +0200
X-Gm-Features: AX0GCFtvKb145spfe0I54kiCzbwBLwTsdnHgHVyrN-d4jrXuDN9vNomcgT_ncYI
Message-ID: <CAP8UFD31PfhJY3jQpBmvbAB6eh43GFfsKzcXby7LshX76Qjekw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] promisor-remote: allow a server to advertise more fields
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:45=E2=80=AFPM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> [snip]
>
> > diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitproto=
col-v2.adoc
> > index 5598c93e67..b4648a7ce6 100644
> > --- a/Documentation/gitprotocol-v2.adoc
> > +++ b/Documentation/gitprotocol-v2.adoc
> > @@ -785,33 +785,52 @@ retrieving the header from a bundle at the indica=
ted URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > -promisor-remote=3D<pr-infos>
> > +promisor-remote=3D<pr-info>
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >  The server may advertise some promisor remotes it is using or knows
> >  about to a client which may want to use them as its promisor remotes,
> > -instead of this repository. In this case <pr-infos> should be of the
> > +instead of this repository. In this case <pr-info> should be of the
> >  form:
> >
> > -     pr-infos =3D pr-info | pr-infos ";" pr-info
> > +     pr-info =3D pr-fields | pr-info ";" pr-info
> >
> > -     pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr=
-url
> > +     pr-fields =3D fld-name "=3D" fld-value | pr-fields "," pr-fields
> >
>
> From this, it seems like the order of the fields shouldn't matter, but
> this is not the case.

I would prefer to keep the simpler version as I find these grammar
notations not very easy to understand.

In v3 there is:

=3D> The "name" and "url" fields MUST appear first in each pr-fields, in
that order.

And I think it's enough, especially since the parsing is relaxed so it
will work if they are not in this order.

> wouldn't it be better to say:
>
>   pr-infos =3D pr-info | pr-infos ";" pr-info
>
>   pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr-url
>   pr-info =3D pr-info | pr-info "," fld-name "=3D" fld-value

Could this be interpreted to mean that it is Ok to have "name=3D"
pr-name "," "url=3D" pr-url several times in a single pr-info?

This seems to me really more complex than needed, and I think it's
better to keep the simple version and then clarify things with the
above sentence.

> [snip]
>
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 24d0e70132..70abec4c24 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -314,6 +314,84 @@ static int allow_unsanitized(char ch)
> >       return ch > 32 && ch < 127;
> >  }
> >
> > +/*
> > + * List of field names allowed to be used in the "promisor-remote"
> > + * protocol capability. Each field should correspond to a configurable
> > + * property of a remote that can be relevant for the client.
> > + */
> > +static const char *allowed_fields[] =3D {
> > +     "partialCloneFilter", /* Filter used for partial clone */
> > +     "token",              /* Authentication token for the remote */
> > +     NULL
> > +};
> > +
> > +/*
> > + * Check if 'field' is in the list of allowed field names for the
> > + * "promisor-remote" protocol capability.
> > + */
> > +static int is_allowed_field(const char *field)
> > +{
> > +     const char **p;
> > +
> > +     for (p =3D allowed_fields; *p; p++)
> > +             if (!strcasecmp(*p, field))
> > +                     return 1;
> > +     return 0;
> > +}
> > +
> > +static int valid_field(struct string_list_item *item, void *cb_data)
> > +{
>
> Nit: Shouldn't this be `is_valid_field` similar to `is_allowed_field`?

Yeah, I have renamed it `is_valid_field`

> > +     const char *field =3D item->string;
> > +     const char *config_key =3D (const char *)cb_data;
> > +
> > +     if (!is_allowed_field(field)) {
>
> Nit: Can't we just inline this?

We could, but I think the is_allowed_field() makes sense on its own
too, while the current one is very specific to be used in
filter_string_list(). So I prefer keeping is_allowed_field() separate.

> > +             warning(_("unsupported field '%s' in '%s' config"), field=
, config_key);
> > +             return 0;
> > +     }
> > +     return 1;
> > +}
> > +
> > +static char *fields_from_config(struct string_list *fields_list, const=
 char *config_key)
> > +{
> > +     char *fields =3D NULL;
> > +
> > +     if (!git_config_get_string(config_key, &fields) && *fields) {
> > +             string_list_split_in_place(fields_list, fields, ", ", -1)=
;
> > +             filter_string_list(fields_list, 0, valid_field, (void *)c=
onfig_key);
> > +     }
> > +
> > +     return fields;
> > +}
> > +
> > +static struct string_list *fields_sent(void)
> > +{
> > +     static struct string_list fields_list =3D STRING_LIST_INIT_NODUP;
> > +     static int initialized =3D 0;
> > +
> > +     if (!initialized) {
> > +             fields_list.cmp =3D strcasecmp;
> > +             fields_from_config(&fields_list, "promisor.sendFields");
>
> Nit: Here too, can't this be inlined? While the modularity is nice, I'm
> not sure the redirection is warranted for such small functions with very
> specific usecases.

In a follow up patch in this series we reuse fields_from_config() so I
think it's better to keep it separate.

> [snip]
>
> Apart from the nits, the patch looks good :)

Thanks for the review!
