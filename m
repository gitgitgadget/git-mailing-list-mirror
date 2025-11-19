Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361353321A2
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547106; cv=none; b=ate6+HPsuHSZ0K6zM5gmW3uPcbD27DsdvgEKzCn3VWe6ymx/ZrVeSMlgEcsBTG7bTxKQgPFB9uecspNVYeNnjPb1G2QEjd7JaOzE5WupfiwxakvrLvKJRxT4TuGgq0hiswxFqZifP7IzUqOcXcRTgsuwR1eFYJ0sciFqbcsgOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547106; c=relaxed/simple;
	bh=pqK+7si8fBe5Q8z5G46rY/pqcPtyxAP5DAjSS0G0Hlw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=m3zw6Y45aHJVvnlyvVnqR6Vls585QKveG7FRqfgiHBaKYbjJ4ul8RINAe3yo1ri9lnf88Mc4448H3oFtC/u3gHHkNhiz0OrX7yUdP+pnnjdsStCdYJijxekVCi/4RuOYftPf7EvY902GZiwTnV7kZCu0jVuMDsM+0CvKSTrqKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9j8D+hB; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9j8D+hB"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9372164d768so466193241.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763547102; x=1764151902; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BF15iHFfuXjtmyX9o6YPpQX/4hfdOxNCUjKIhp29x5U=;
        b=B9j8D+hB0KsL/zwc5SqUkrLzGSTiHMlx0uFegPWB/rP/H1TKJZLnua39CUITasVZYf
         Fcza/Y5CfrBC9YjH7wZJ+0mcqaCxhFcd9UYS30m/mhXS08zBdCjOVOc7kUXgE6GDnnZK
         scV1fucuB/mJicZYfj9gbZSDwWxTr73+Dokx3kiPSNZPhJt9WVeNvk+LAKG5P3I+rsrd
         6xdjtJyT1lJ63ISKVQoPwngic+keJoi/0POfI2oPr0KcPE3RrEn4S/iV46JqN6dPZuVi
         yobuRPyXokmrV16fu+Dy9fibCgPYB6+w9897jOZ76cwWF6LL3bBZSV+bO1e4A+chZpGJ
         mNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763547102; x=1764151902;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF15iHFfuXjtmyX9o6YPpQX/4hfdOxNCUjKIhp29x5U=;
        b=U1yBLNPDJuwk4CW2miGcRBVshrA/XRRkhW+7s9mitTx4JeWPZIKpdb9+5hGpYbuvRG
         2vvWVWkE7X2M2pXO/OVNJ7C4+EL2sxALvpn32dcbmM71lMzS0Szi17F6d17yc+gqfnJl
         Fz0Nd9ZaC0IST8v5RbFwioiPDQzhz1yDBoqPbDbZ16Vv4Y9a/7O2rSGEklLKEXuWZEXF
         qoAlCFeWLK9Dg2FcIEfCv2xJDMB8NYQNff0wIqYrxfD2pBlI/Rx9i6ve0qomst63m97W
         lEAGyZQG/ChblLEjT249Vt3MqdBwf9cDdCUK5D0JHFqpY3D4tibMIaOw9a0gJZEGH1BQ
         jMcA==
X-Forwarded-Encrypted: i=1; AJvYcCXO4pageDLphF6X0hY7qJe1llgGqz/EMFz/0QbOPxT+CpO95KJGGPtvHi0gwyxGiuxrD4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT11vlX7m54FZjiLCAPMi1wXrUBTNupME6XlvinjxDDIfym9F+
	lHZRrjh9O5sRamll2Uy/au2bRfXooFOaLcJl0zoq24SmRzT9VmhQcsE2+YDodIZOf9D+v9sV3f/
	BqhaM2HpZOOqLDAe/iS8zBH5D5gkpHr3VqA==
X-Gm-Gg: ASbGncugQQFEivIKBZrEXTkyEnufRuTFP3iDkkYV8YQju8UhsdCgL8TYlic2AtzGXqp
	KXRiHtZdMipAJOk1oU8eErHAeiFuG2I2WSc7xR9I3lUQpKT6daUva4T8e0B3MwzXsz2CTw7gzuO
	WaGtuMeU7Yd6m2WZP/O7fgP5acNiNYrbgRvmPCR8tamElCcDWR5GtKbtrfbaSdKIPNXmtzQq8MO
	D7U8mEj4Rs2lMRnYxt2Aax4j1XplkKGfZxhJJeU1ya1NHaVIr2zjG9XhcARVl2X9JzVpm3rYMBZ
	iaMwgKqToCIXYFWkfL41tKCX8YjdsJAPuh6jfg==
X-Google-Smtp-Source: AGHT+IHFhD/dyarSBBmBGOMAoAKZff43pdqfDh3wBqts2u5+JrWjZdSdAh4/IUsDrwZr69w6Fia/SNnU9WiM52LOgUE=
X-Received: by 2002:a05:6102:c87:b0:5db:d36c:89d4 with SMTP id
 ada2fe7eead31-5e1a787e342mr596742137.3.1763547102295; Wed, 19 Nov 2025
 02:11:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 02:11:40 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 02:11:40 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-5-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im> <20251119-b4-pks-odb-read-stream-v1-5-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 02:11:40 -0800
X-Gm-Features: AWmQ_bnDho1YInv9Y9nDtpL9_DLdivXtj8OrMqpRnl795jbF03hsPG1O20I40iY
Message-ID: <CAOLa=ZTF+xzhZv2yXp8L_URk8cjscycheD=Xgdxd=eRGtvpt2A@mail.gmail.com>
Subject: Re: [PATCH 05/18] streaming: allocate stream inside the
 backend-specific logic
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000093d8160643efce71"

--00000000000093d8160643efce71
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When creating a new stream we first allocate it and then call into
> backend-specific logic to populate the stream. This design requires that
> the stream itself contains a `union` with backend-specific members that
> then ultimately get populated by the backend-specific logic.
>
> This works, but it's awkward in the context of pluggable object
> databases. Each backend will need its own member in that union, and as
> the structure itself is completely opaque (it's only defined in
> "streamgin.c") it also has the consequence that we must have the logic

s/streamgin/streaming

> that is specific to backends in "streaming.c".
>
> Ideally though, the infrastructure would be reversed: we have a generic
> `struct odb_read_stream` and some helper functions in "streaming.c",
> whereas the backend-specific logic sits in the backend's subsystem
> itself.
>

Will this also mean that we move the backend specific functions like
`open_istream_loose()` away from 'streaming.c'? Let's read on.

> This can be realized by using a design that is similar to how we handle
> reference databases: instead of having a union of members, we instead
> have backend-specific structures with a `struct odb_read_stream base`
> as its first member. The backends would thus hand out the pointer to the
> base, but internally they know to cast back to the backend-specific
> type.
>

Right.

> This means though that we need to allocate different structures
> depending on the backend. To prepare for this, move allocation of the
> structure into the backend-specific functions that open a new stream.
> Subsequent commits will then create those new backend-specific structs.
>

Who's in charge of free'ing these structs? I see that `close_istream()`
calls the assigned `close()` function. So this could be handled on the
backend level. But it also does `free(st)`.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  streaming.c | 99 +++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 63 insertions(+), 36 deletions(-)
>
> diff --git a/streaming.c b/streaming.c
> index d7db446d25..b8ce82483f 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -222,27 +222,34 @@ static int close_istream_loose(struct odb_read_stream *st)
>  	return 0;
>  }
>
> -static int open_istream_loose(struct odb_read_stream *st, struct repository *r,
> +static int open_istream_loose(struct odb_read_stream **out,
> +			      struct repository *r,

We take in a double pointer now, since the allocation will be handled
inside the function.

>  			      const struct object_id *oid)
>  {
>  	struct object_info oi = OBJECT_INFO_INIT;
> +	struct odb_read_stream *st;
>  	struct odb_source *source;
> -
> -	oi.sizep = &st->size;
> -	oi.typep = &st->type;
> +	unsigned long mapsize;
> +	void *mapped;
>
>  	odb_prepare_alternates(r->objects);
>  	for (source = r->objects->sources; source; source = source->next) {
> -		st->u.loose.mapped = odb_source_loose_map_object(source, oid,
> -								 &st->u.loose.mapsize);
> -		if (st->u.loose.mapped)
> +		mapped = odb_source_loose_map_object(source, oid, &mapsize);
> +		if (mapped)
>  			break;
>  	}
> -	if (!st->u.loose.mapped)
> +	if (!mapped)
>  		return -1;
>
> -	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
> -				    st->u.loose.mapsize, st->u.loose.hdr,
> +	/*
> +	 * Note: we must allocate this structure early even though we may still
> +	 * fail. This is because we need to initialize the zlib stream, and it
> +	 * is not possible to copy the stream around after the fact because it
> +	 * has self-referencing pointers.
> +	 */
> +	CALLOC_ARRAY(st, 1);
> +
> +	switch (unpack_loose_header(&st->z, mapped, mapsize, st->u.loose.hdr,
>  				    sizeof(st->u.loose.hdr))) {
>  	case ULHR_OK:
>  		break;
> @@ -250,19 +257,28 @@ static int open_istream_loose(struct odb_read_stream *st, struct repository *r,
>  	case ULHR_TOO_LONG:
>  		goto error;
>  	}
> +
> +	oi.sizep = &st->size;
> +	oi.typep = &st->type;
> +
>  	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || st->type < 0)
>  		goto error;
>
> +	st->u.loose.mapped = mapped;
> +	st->u.loose.mapsize = mapsize;
>  	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
>  	st->u.loose.hdr_avail = st->z.total_out;
>  	st->z_state = z_used;
>  	st->close = close_istream_loose;
>  	st->read = read_istream_loose;
>
> +	*out = st;
> +
>  	return 0;
>  error:
>  	git_inflate_end(&st->z);
>  	munmap(st->u.loose.mapped, st->u.loose.mapsize);
> +	free(st);
>  	return -1;
>  }
>
> @@ -338,12 +354,16 @@ static int close_istream_pack_non_delta(struct odb_read_stream *st)
>  	return 0;
>  }
>
> -static int open_istream_pack_non_delta(struct odb_read_stream *st,
> +static int open_istream_pack_non_delta(struct odb_read_stream **out,
>  				       struct repository *r UNUSED,
>  				       const struct object_id *oid UNUSED,
>  				       struct packed_git *pack,
>  				       off_t offset)
>  {
> +	struct odb_read_stream stream = {
> +		.close = close_istream_pack_non_delta,
> +		.read = read_istream_pack_non_delta,
> +	};

So this is now statically defined. Won't this cause an issue?

The rest looks good. Thanks

--00000000000093d8160643efce71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b5ad49af30751b69_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZGw5b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVZ6Qy8wYmpmVXV5NW52Uk9lTnNyYTByNEE1OTBLRwp6MWlhcXdVVGFF
SFlWdExGallPaG52OEY0dm5Wd2Q1bU84UVU4M1VoMXlDUlJVOVdBR2o5UVJHQUM0SlI3TlY1CjQ4
M3Z6VnJDYUFvYk9xbmNack0rSVhoWFhHU0hQWEFtcytOSWpKMVZFYzJjaFpoWXNMVlU3dDBGMCtF
cEpRSWEKQ0Z0RlRGWGN5WTdFNVZ0SlViWFgrdVluVitWOHR2SU8vRFlCa3A0Q2VQdVR3cU5xUE1P
MUUxakhFKzNZNDVBdgpkQmFqZ1RVK0tqTSszRTltV1pqY01DckZSdzAxSGxJRi8rREJJdGo1MlQx
OHJIOFk1MnpXSnNrRERKOG5mU0svCmZCMkVUemViU3lGaDljNTBmSEd6MHcwMkZiQmFVRGgrZHZi
OE5JdWtIQ05lV1dGN3FyTGxBbHJxelpQVDBJQW0KYkIyVzMzbnNoenRkaHhRbGRURGNERlcveiti
dExhSGgwTDZBZ0J2Y0t1dFlJVHNjYWw1cVRDa05GZm95eDhOcgpBSUdsZUJQMUFhUVZMVUxzcGN5
bnpzOEY4aS91SWljL0Z4bHdFdnVtWmsvTUt4bHpWUFpOTXllM09HeXVZUHZMCnU1SCs1Q2FJKzA5
cUs1V2R4NnZ4U0xCdFliUmNmSFdaTExKWkV3OD0KPXJqR2UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000093d8160643efce71--
