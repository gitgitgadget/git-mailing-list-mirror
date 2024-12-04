Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3916F851
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311591; cv=none; b=gfiQa7Kn6XHlihAz5/JUrmOnCwxcB7guZYNBcN4ijNXb66m5o/EHs03mNJIW+4R9exv1o56v0m6VDzFCciqxQ8VMvj/WubpukYcDk5dIDLMStTFFKNe98EFMJ99uNfsKGg35Oy10rDUO8nQaMGhUvTxEd08D2+DM55MN1UMgKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311591; c=relaxed/simple;
	bh=kJBXvKLojtiFTVOKL/RM1H9IVPkOoQy8DwYjiUWyeCM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=SM1/ibu8AZyfJNDxjXyOzGKxbulGJ6NeJRBBWSGYJTyjZw0vPwKCiu5T24Zh69zAKPCyg1Xy50OmIU/uvi6AjlEKzFoyRhrLRGnVF5R2dKbYQM7YwaXFljAttHVUL/V8dNR42gpxzb99puGX4Kq0nKMlBEEpxIuqkzKUkx1ZLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFwykqHI; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFwykqHI"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afa4094708so300459137.0
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 03:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733311589; x=1733916389; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar6/111NB6Idi7b5ww1q/upNSAQu0SmFz0iKALT5YfY=;
        b=AFwykqHIWb/C2QZhx6MdiLUVSOPSmgc4kgSTddxPRV/5MZ5FE/sVFAXmGOv490xkNx
         jbSGPjNaHRMQwc6rT7WLnOKT5MVwcWzsTLGX6ZI8F+a2CBy59iuppuDHkqkMN/7ZomLD
         0D3q918S/Nf+9sC+uZApE6EIaAT02FCC+SX/Fbgtk/6YCbbAmAWwHsZDk6HQYSERnr+7
         0q/kPiRIR0Edo+S0yOoBDDxaT06CEQrkIWit1e8TuVWkcGXpVv6mmDXP4bjIAPzmC94A
         TH6d0PPYdH3770tx7yV2j2WU4DNQawj2F91TClJrOHSHR8TKrjMCg+mls7ws89Ve0diZ
         1nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733311589; x=1733916389;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar6/111NB6Idi7b5ww1q/upNSAQu0SmFz0iKALT5YfY=;
        b=vLE9sDV4qQXobRDOCviohrmWp3+Nid7MvyPUh1DdLu98+eV3fdi8Zb8C77jM7j69VD
         xV/Rd14Y1dvV52a60wGqQpsQI7vjMvnVTOCoGoRXlUTw6be7eQLa62f/7eADX8ziAklj
         +a/EpQiNF6luW9ydv7Izt/iz2fPLMlVKFBI16CMGqlIVtBSimk7aNBEtntRFRPpFKXYs
         4lvuemJwoQLcm/jejN5OErszSx7/21Id6z+cRdaEJCf7SxFfvc9E6UHep//R7gIY8Ujh
         lNLitSaGvQFQ98+yW1TB/CfvFSZidY0U3H1oAA//XbBGwhY3jknweQQ+X+VUK1acdTO3
         l+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXKVvPT56SN7btvfYofNL9wcs+yNDZ7ZKye9DRYo2dp+HcPMFtOXt9nCj5wIHCiLSKAolc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzETBPDa3u9c0Lrk/rtwgh5xplEgEwCRoH+PLQ3xZzTVam6Tfu/
	MBhwBgxF4xqYYpj/OKv1Gp5mhtqFgG2mR82vgAcp5ABU53jQ3locxDQEB2dUKitjD7nRiQN81w+
	6MR+7awJJrbZDqsH6QlT5Y9FcIU8=
X-Gm-Gg: ASbGncsX/WQ9porRb/+TDWvNZ0twKDc5FlN554c5CV/Fqadl4W3Q5QZGUAjDDz+HZ1Q
	V4Qs+03ZfEHVP1lQqTzpnwe/P/Y/Z2PhnPXQhaW55htDDKr3QDVNV5wK8oRYLzsFf7Q==
X-Google-Smtp-Source: AGHT+IFZF3xO+hTxmNuwJgezepCqs8ReE0WOesMbqcpCKjQqk8ZpPOo4I+JSWG6nmPfvvdvpYh2femIaaRaeoy+0pcA=
X-Received: by 2002:a67:e311:0:b0:4af:a9d1:c849 with SMTP id
 ada2fe7eead31-4afa9d1ca5cmr2115538137.25.1733311588743; Wed, 04 Dec 2024
 03:26:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Dec 2024 11:26:27 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com> <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Dec 2024 11:26:27 +0000
Message-ID: <CAOLa=ZRaXZWmuLsmq9AFkzUFCa__=3rzAYkhULA4duJnGxcoyg@mail.gmail.com>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically initialized vector
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000885e6b0628700d67"

--000000000000885e6b0628700d67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

Nit: Is the commit subject missing a verb?

> We use a singleton empty array to initialize a `struct strvec`,
> similar to the empty string singleton we use to initialize a `struct
> strbuf`.
>

So a singleton empty array is a statically allocated array element, so
for strvec, this would be `const char *empty_strvec[] =3D { NULL }`.

> Note that an empty strvec instance (with zero elements) does not
> necessarily need to be an instance initialized with the singleton.
> Let's refer to strvec instances initialized with the singleton as
> "empty-singleton" instances.
>

Right, so when we add elements ideally, we ideally check whether it is a
singleton or not. This is evident in `strvec_push_nodup()`:

    void strvec_push_nodup(struct strvec *array, char *value)
    {
    	if (array->v =3D=3D empty_strvec)
    		array->v =3D NULL;

    	ALLOC_GROW(array->v, array->nr + 2, array->alloc);
    	array->v[array->nr++] =3D value;
    	array->v[array->nr] =3D NULL;
    }

>     As a side note, this is the current `strvec_pop()`:
>
>     void strvec_pop(struct strvec *array)
>     {
>     	if (!array->nr)
>     		return;
>     	free((char *)array->v[array->nr - 1]);
>     	array->v[array->nr - 1] =3D NULL;
>     	array->nr--;
>     }
>
>     So, with `strvec_pop()` an instance can become empty but it does
>     not going to be the an "empty-singleton".

Correct, since we simply set the array element to NULL, but this is
still a dynamically allocated array.

Nit: The sentence reads a bit weirdly.

> This "empty-singleton" circumstance requires us to be careful when
> adding elements to instances.  Specifically, when adding the first
> element:  we detach the strvec instance from the singleton and set the
> internal pointer in the instance to NULL.  After this point we apply
> `realloc()` on the pointer.  We do this in `strvec_push_nodup()`, for
> example.
>
> The recently introduced `strvec_splice()` API is expected to be
> normally used with non-empty strvec's.  However, it can also end up
> being used with "empty-singleton" strvec's:
>
>        struct strvec arr =3D STRVEC_INIT;
>        int a =3D 0, b =3D 0;
>
>        ... no modification to arr, a or b ...
>
>        const char *rep[] =3D { "foo" };
>        strvec_splice(&arr, a, b, rep, ARRAY_SIZE(rep));
>
> So, we'll try to add elements to an "empty-singleton" strvec instance.
>
> Avoid misapplying `realloc()` to the singleton in `strvec_splice()` by
> adding a special case for "empty-singleton" strvec's.
>

So everything said here makes sense, that's a great explanation.

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>
> This iteration adds more detail to the message plus a minor change to
> remove some unnecessary parentheses.
>
> Junio: My message in the previous iteration was aimed at readers like
> Patrick, who is also the author of `strvec_splice()`.  I certainly
> assumed too much prior knowledge, which made the review unnecessarily
> laborious.
>
> Rereading what I wrote last night, perhaps the problem now is excess.
> I hope not. In any case, here it is :-)
>

I would say this is very useful over the first iteration, considering I
am someone without prior knowledge here.

> Thanks.
>
>  strvec.c              | 10 ++++++----
>  t/unit-tests/strvec.c | 10 ++++++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/strvec.c b/strvec.c
> index d1cf4e2496..087c020f5b 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -61,16 +61,18 @@ void strvec_splice(struct strvec *array, size_t idx, =
size_t len,
>  {
>  	if (idx + len > array->nr)
>  		BUG("range outside of array boundary");
> -	if (replacement_len > len)
> +	if (replacement_len > len) {
> +		if (array->v =3D=3D empty_strvec)
> +			array->v =3D NULL;
>  		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>  			   array->alloc);
> +	}
>  	for (size_t i =3D 0; i < len; i++)
>  		free((char *)array->v[idx + i]);
> -	if (replacement_len !=3D len) {
> +	if ((replacement_len !=3D len) && array->nr)
>  		memmove(array->v + idx + replacement_len, array->v + idx + len,
>  			(array->nr - idx - len + 1) * sizeof(char *));
> -		array->nr +=3D (replacement_len - len);
> -	}
> +	array->nr +=3D replacement_len - len;

Why is this second block of changes needed? Will array-nr ever be 0 when
we reach here?

>  	for (size_t i =3D 0; i < replacement_len; i++)
>  		array->v[idx + i] =3D xstrdup(replacement[i]);
>  }

[snip]

--000000000000885e6b0628700d67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5d7ae63d683cb4e0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUVBHQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXhrQy93UGFyWlc2MXlKRDJlcHo0SE5BQlZJZWpPeQpUT0d1TytPOVdZ
Y1Z5cGNwUWlJYWQ2bHBTZjg2cDZ1QTRybG9yWE91UG92WEsxQk5QYTlLUDZ6NEt1RlFLMUkvCnNs
Q1dXV1RNL05Rbm9WOTVZbEI3aU8zeEFWdEk5cXFDVVd5cmJLQlVHblNHc3BIWUhtcFpoWGtNNjQw
MHhsaXUKRnZlUkFGeGNBVVZabWVRVGdCaTlNUCtveVZ1cGJrSHJ1a2UxWEVXME4yUUhZTTVIbFhO
L3Z1cnphdy8wd0NGWgphRGJxMWdGZ0Q0WkVKUnQ5ZzhtcnJiam8xT3cvTTFNdUFNaXlsemdhdElW
VVRMYXNOemwrcnFOdFZIZWlZQ2cvCnR2Wk9vRWxzdSt0R3M5N2FIa0RUWmpjYUJGbWlFeXhQSFky
WjZwckxCSWR2bnBNY0pSOGY3TW4rY2F4UmVGWHEKRXNoYnRmYnZqdlhFSVdVVThvYjVSOTFqNmx1
a1pHUmgzRVhSYzBOMXlZdzhmVys5a3pWR1QzL1AxWjdQM01aLwpDR1lBS2NXdWxlSStCMzhRampV
Y3pEMkpwT1lDdzY5NlBIWkkrYXk1dS9CQXFtcUlURldOcUttTEhKQXdrZkM3ClZQQ2xSUjhRTU9W
U2xnUngyMXhqRWFWb2kralJoMjV3L3Q0eFVrcz0KPUhUejMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000885e6b0628700d67--
