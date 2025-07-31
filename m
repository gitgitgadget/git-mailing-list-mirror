Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCF29826A
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946523; cv=none; b=li9z+KE/oPmSGobbocfxMJxmZHtRvE7/TifzImy/jxDmaGpqa7+T5YG2hHCYU/VeIa+4gC2ZfpMQB84shH6dVIQ65i+mcjoksNmOofrGNb/k7RFkr/ZPdb2QZY2boUNS7AsZqOTAxYza/mqEKuDDdyavI7pYTATDVpirGvsbZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946523; c=relaxed/simple;
	bh=xTAP0n2EHhzsXEmcYzfehzRGJHDCP8esP/qXBFJXpNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7T6b7VS3Z5YE0A3iGKrX2X7pjIQTMO++GEvlU9OmftZXiywz+aI8tlPnGXbSuYGttJna52zFCYqBVSs9A+14vfLigPiahEIaaQflW9eARLQT6TiYoUHqJsqoJ3fjtrk00WQ2twVtV2/VayMcFG9SN+uEe/n9N1aGobrs15G4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJULf/kF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJULf/kF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3b336e936so120158866b.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753946520; x=1754551320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWJJOZsbSqC9VM0hDDdFLal4t9HVlOQ3MhXb1cb0uNc=;
        b=dJULf/kFX32g+IEZHvcOsMyh96oZRXHmcSiKaoOnHNL1As4GL8cjPUA6+qAYhwj20t
         xE3r9Yu6Qvm/qQ8W+L5OcFV/raTrPtaIgkz/nn+VFDxkoCWySOkWFQiM7hJxI6yTgxTT
         SE3pCmsZzaOwfotPglN1+P+BbtqbqStj7HUR53jm0wPfMlIaDleyepqb8iZKlFR5vTPN
         KOh6FV5f7+XlGENWE/vxullHINFYFhCvlwUrmlWsOrWvfkvSR7j/Om9VdXBem+WKg00/
         hFNB4Yq5sRurF8exeDIJu6GUHSdLPuGzz4XuJEE3cqSS79yVrF4EW5kP9plBTQOv+CM3
         oScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946520; x=1754551320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWJJOZsbSqC9VM0hDDdFLal4t9HVlOQ3MhXb1cb0uNc=;
        b=KL1vitH9Pqh8kPJgQBBUJyBMepJ+1XV2PnUwJVL8b1EW4r7zOXgqXAITuyOFDrNMa0
         FrswRw20ylCVDsEP9lWeiWGfoWeQ4W/+pDiejXnmXTiCIyIuaoPDBbyizIoEhJIgKIc+
         YGlnlCcBZA156PsOsayGVgejVFI9i7S/NHBRS9GjZmMGuZTn84jmvAo2jmNTxHdBxZXI
         FaF6evoUiB1uaHb4txj+W5t6o/w86IES71O54Onad090q1M/cqUZ4R1q6tROBGCytfXd
         FMR+/k8nPius5pT+QCBUcmKMNv7HF45tke2Gz/V2nmEj9fiWAxFOep3HU773zDXb6di7
         nHsw==
X-Gm-Message-State: AOJu0YxBn4jbAgHWNrJNSaChNZ9dYJuVDsWFq9S5mF5S7mGn29i9TchO
	iOy2spUG4RXfXBhl5hUuJP1rpYxW7Opn9CkLP2X1j5dsGIeFbXnYiM3B3aLGpVoD6wGhLEKoH6h
	yTfO6DPZaVJsCGHFxh+io1X0dXyV/xes=
X-Gm-Gg: ASbGncv2v5nR3Ow+u2nkTBdaHukvCzUfAb4XIeW1F1couHPUgQodeX6eQ+Ag+gWNjqY
	TvtTXtfGbt3WRimcBBDc8kgur2OLNjIRH8msa2X50ilx0HOiXfEmVpJX/6Tw3lMf95uJIfoUcM7
	SVJlvkV2dcl48JSAxejVRbgY/sF2Ygt6JCbqqv19AyzNrf8tFU40jE7gznb36c2qyrkngL0BzJL
	AJ3IfRcNYXj4eHyBoNc
X-Google-Smtp-Source: AGHT+IFwBExyalEVTAxr1vExU+QcB3NNFSM4LsbtgX3WLmV6C4kaO6HBz9/dRWkPJF/E219xkOQEX9YJsRbdq+OGnik=
X-Received: by 2002:a17:907:f816:b0:ae6:abe9:4daa with SMTP id
 a640c23a62f3a-af8fd79320dmr866656766b.27.1753946519495; Thu, 31 Jul 2025
 00:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625125055.1375596-1-christian.couder@gmail.com>
 <20250721141056.2283349-1-christian.couder@gmail.com> <20250721141056.2283349-5-christian.couder@gmail.com>
 <xmqqo6tdw996.fsf@gitster.g>
In-Reply-To: <xmqqo6tdw996.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 31 Jul 2025 09:21:46 +0200
X-Gm-Features: Ac12FXwo_T_xKyHEKEn_1pt8wGxhv7Yw3DtQDLEsm4ASZZxPeGwSqi7wUaew8vg
Message-ID: <CAP8UFD0a5xJuSm4683J_wrZQic9Lzj3imjf7MgGHmwudbDhbtA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] promisor-remote: allow a client to check fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Jean-Noel Avila <jn.avila@free.fr>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index ae2c49a0a0..501cb92391 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -388,6 +388,20 @@ static struct string_list *fields_sent(void)
> >       return &fields_list;
> >  }
> >
> > +static struct string_list *fields_checked(void)
> > +{
> > +     static struct string_list fields_list =3D STRING_LIST_INIT_NODUP;
> > +     static int initialized =3D 0;
>
> No need to explicitly 0 initialize "static int"; let BSS take care
> of it.  Perhaps we should add an entry to CodingGuidelines if we do
> not have one (#leftoverbits).

Yeah, right. This is fixed in v7 in both fields_checked() and fields_sent()=
.

> > @@ -533,6 +547,61 @@ enum accept_promisor {
> >       ACCEPT_ALL
> >  };
> >
> > +static int match_field_against_config(const char *field, const char *v=
alue,
> > +                                   struct promisor_info *config_info)
> > +{
> > +     if (config_info->filter && !strcasecmp(field, promisor_field_filt=
er))
> > +             return !strcmp(config_info->filter, value);
> > +     else if (config_info->token && !strcasecmp(field, promisor_field_=
token))
> > +             return !strcmp(config_info->token, value);
> > +
> > +     return 0;
> > +}
> > +
> > +static int all_fields_match(struct promisor_info *advertised,
> > +                         struct string_list *config_info,
> > +                         int in_list)
> > +{
> > +     struct string_list* fields =3D fields_checked();
>
> Asterisk sticks to a variable, not type.  I.e.
>
>         struct string_list *fields =3D ...;

Right, fixed in v7.

> > +     struct string_list_item *item_checked;
> > +
> > +     for_each_string_list_item(item_checked, fields) {
> > +             int match =3D 0;
> > +             const char *field =3D item_checked->string;
> > +             const char *value =3D NULL;
> > +             struct string_list_item *item;
> > +
> > +             if (!strcasecmp(field, promisor_field_filter))
> > +                     value =3D advertised->filter;
> > +             else if (!strcasecmp(field, promisor_field_token))
> > +                     value =3D advertised->token;
>
> Hmph, together with match_field_against_config(), do we really need
> to have this case insensitive to begin with?

I think so. When comparing config option keys, we use case insensitive
comparisons, so I think it makes sense to use that when comparing
field names too.

When we call fields_checked(), we get a list of field names as they
have been configured in the "promisor.checkFields" config variable. It
is very likely that for "partialCloneFilter" some users may not
camelcase it properly. So if we use strcmp() to check if `field` is
"partialCloneFilter", it might result in things not working as they
expect because of subtle camelcase issues.

> I would suggest making
> it a habit to design the interface minimally, and not making case
> insensitive comparison as default counts one of them.

There is a reason. They are not used by default here.

> If the
> comparison were not case insensitive, we do not even need to have
> this loop; rather we can just look up from the list of the fields
> for an exact string (i.e. promisor_field_filter).  I do not know
> offhand what other code will become easier to read and simpler by
> such a change.

I checked other places in the code and I think it's right that in the
"promisor-remote" protocol the field names ("partialCloneFilter" and
"token") should be checked case-sensitively, so in v7 I have made this
change in parse_one_advertised_remote():

   @@ promisor-remote.c: static struct promisor_info
*parse_one_advertised_remote(stru
                       info->name =3D value;
               else if (!strcmp(elem, "url"))
                       info->url =3D value;
   -+          else if (!strcasecmp(elem, promisor_field_filter))
   ++          else if (!strcmp(elem, promisor_field_filter))
    +                  info->filter =3D value;
   -+          else if (!strcasecmp(elem, promisor_field_token))
   ++          else if (!strcmp(elem, promisor_field_token))
    +                  info->token =3D value;
               else
                       free(value);

and I have clarified that in the doc too:

   @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a
bundle at the in
    +connecting to the remote. It corresponds to the "remote.<name>.token"
    +config setting.
    +
   -+No other fields are defined by the protocol at this time. Clients MUST
   -+ignore fields they don't recognize to allow for future protocol
   -+extensions.
   ++No other fields are defined by the protocol at this time. Field names
   ++are case-sensitive and MUST be transmitted exactly as specified
   ++above. Clients MUST ignore fields they don't recognize to allow for
   ++future protocol extensions.
    +
    +For now, the client can only use information transmitted through these
    +fields to decide if it accepts the advertised promisor remote. In the

But when we deal with field names from the config, I think it's much
more user friendly to use case insensitive comparisons.

An alternative implementation might be to canonize the field names in
fields_checked() and fields_sent(), so that for example
"partialclonefilter" would be changed to "partialCloneFilter" there.
We could also use for example an `enum field_id` instead of field
names and convert the field names to those field IDs in
fields_checked(), fields_sent() and perhaps other places. Then yeah we
might use case sensitive comparisons in some places like here and
perhaps simplify other parts of the code. I am open to going in this
direction if that's what you prefer. I am not sure overall the code
will be much simpler though. We might just move complexity around.
Also for now I think using strcasecmp() is not likely to be a
performance issue.

Thanks.
