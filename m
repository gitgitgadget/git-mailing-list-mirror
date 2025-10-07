Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E392DFA27
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848767; cv=none; b=Ib3Odh5yOTjFxWKHxNGIXzh9Bfi910X6HlGPhpBYIpDAhrkasE14VTeF5gCXo5ULDduIlFVPGV/kYC+0npmObkMurebDzpmqFr1AN9RRcdzQSnXWQM7iSq0rrZZFxo//pV/xH+i3r9jvuYGPa0EVCFCqkUXOXTrCfuWmeOGOZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848767; c=relaxed/simple;
	bh=WALH/49yosX6A60/nU3AycnCmW56zm4R55EnLvp9Re4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=J8XNA41FJMhsDOE/At3jhvFSBnmCHZRYODccxo4SyRCYfN5ta66muVAL2p8kfUqhw3JUHh00Ekpv37PbpzXKMYASbJrBXYaY2w9WtK9P2BQYm1FNjUd4Ba9VL5IsKhkrkPMSuWozWojOkogcMGXW+np1sbcj5uyNh+TAL95/IVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxlF8wS5; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxlF8wS5"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a265e0ec25so4905394137.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848765; x=1760453565; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcdegbNzqGWbj7tFuHnP30NrlbnKFiVhIqM4fM+tybk=;
        b=UxlF8wS5oL1UeGFIfudQu0Rtixnwm+mv7OyWh21lSgMw7LW46mEF1gMnW/1dCIVZ2o
         bjqYsXLVwtqz16hhIjZaBZRo80c3QXh2ieHhS9MC8gmNjQ/XOii3T0kDPdo5+UmpB49A
         nOD6F+TMJCNcb8/+oaOwcN6wXd43TI1ft+/ZO00Be7chUj2T8jXXZs2fLc+c1Zl3Hhe2
         ypg6cccxOhoXeMYeAv/JB5wuMA5+9TtPXssiju6+MK3cjiCQ/uWbLOlFfCWpsRzz1Z0f
         T9kfYuFGJhNrgfiU9o5vjrLpBVuFyC6wiLv7NIxh7P/RlDVKBM3UdPe1fX/pLN9ip5LO
         yJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848765; x=1760453565;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcdegbNzqGWbj7tFuHnP30NrlbnKFiVhIqM4fM+tybk=;
        b=U00tGR37XhLJdz3wwp0U5tyzjse5OsIhL09FuL5f0febp86REhmpXMU+hvV93c2Obf
         QGuzNggE7E/XEslcfiyn2TIE4WB7ajdLOy+4MW7/ads7Z10+EAdX2zvpDEy2jJfn/EIc
         1INU9BXEAdIoOdwWukBM/1X2rxEre/AVIFmqcSztqVGiCtAJPav33zAs1VAYBUOLj8Rw
         s76UOTfxNtfYUq9vyBFlk3yOlnCMM4crwlaKFQmUDxyOMAW4BJ650nBn3XFNS2z7rWOy
         Z2z2X7UoqPGgXYyqVffLEHlZ8nLvv4+c6ArEo05yhkUdb0hdtNouRKAvIGXMXlrpNY60
         a3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVHsD8ZtyRJ7likE0X7OeGZYKqxA3zelhImN1hby8JLiiyuQS0cINa1Fc41C9rgzhVbd6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLCnXdtO6nZLbZeVdQwofuEZ9iDZvfXF1/WSb+Kw8lhxBspmN
	oFcFUYWsZQhdB7Sk6FoAP5LHU6+K1ILq4abANfgbudDNkv5+l1E7pNzURW/kLQDg9pUh/sn4YcL
	vxBZ0ZVh6k8jZO2WDT4WWqQBdyUjZfJA=
X-Gm-Gg: ASbGnctB00EZWRSj2Hv4e79rd13t6E/MSF2d4FBEy5/+xcs4UyHruUpvkaFPmvSTLqY
	6goQkufuULYy3PxHrW6/lVq6HBKpgp+UhwrORBsQbculdUyioo9X79NA95/qtq43bCZTRyKoFls
	lndZsZ2mF58hLLqyhuhiN+boxtXlGld6L3YjjlVb+vkumqfhYGHxnXgycGd9wVHN1lMBEZpNWEh
	C4fL5PD/jg2a9jk8iVTQLHQW0odbQZc699b/L/H7PBQ0XM3QsA8aya2KDmjQk2ObhLEUyb9wdVN
X-Google-Smtp-Source: AGHT+IFLnTLAhyVkn172SLG5fJjIZCxxe6mcAMpif9zAlyIcc9OEgisPPDM/R+PDuKU5fWVtk9v5ZucJo5RapdFwkmA=
X-Received: by 2002:a05:6102:4420:b0:59d:6be4:5b97 with SMTP id
 ada2fe7eead31-5d41cfc9344mr7009142137.5.1759848764995; Tue, 07 Oct 2025
 07:52:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 07:52:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 07:52:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-4-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-4-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 07:52:43 -0700
X-Gm-Features: AS18NWCqowMqeemFkmUkM6YxTjT4txqRVB8e5N96P_oCp98C4-GUDCHmDfs_m1M
Message-ID: <CAOLa=ZRQuLa_xD8GzynHNmNZuyoJeK9dCBOKbUfkCES4ejG0OA@mail.gmail.com>
Subject: Re: [PATCH 04/13] refs: expose peeled object ID via the iterator
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007f4826064092b83a"

--0000000000007f4826064092b83a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Both the "files" and "reftable" backend are able to store peeled values
> for tags in the respective formats. This allows for a more efficient
> lookup of the target object of such a tag without having to manually
> peel via the object database.
>

In the 'files' backend, I thought only packed-refs store peeled values?

> The infrastructure to access these peeled object IDs is somewhat funky
> though. When iterating through objects, we store a pointer reference to
> the current iterator in a global variable. The callbacks invoked by that
> iterator are then expected to call `peel_iterated_oid()`, which checks
> whether the globally-stored iterator's current reference refers to the
> one handed into that function. If so, we ask the iterator to peel the
> object, otherwise we manually peel the object via the object database.
> Depending on global state like this is somewhat weird and also quite
> fragile.
>
> Introduce a new `struct reference::peeled_oid` field that can be
> populated by the reference backends. This field can be accessed via a
> new function `reference_get_peeled_oid()` that either uses that value,
> if set, or alternatively peels via the ODB. With this change we don't
> have to rely on global state anymore, but make the peeled object ID
> available to the callback functions directly.
>
> Adjust trivial callers that already have a `struct reference` available.
> Remaining callers will be adjusted in subsequent commits.

[snip]

> diff --git a/refs.c b/refs.c
> index 15ad0ef7a8..5002e56435 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2333,6 +2333,18 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
>  	return peel_object(r, base, peeled) ? -1 : 0;
>  }
>
> +int reference_get_peeled_oid(struct repository *repo,
> +			     const struct reference *ref,
> +			     struct object_id *peeled_oid)
> +{
> +	if (ref->peeled_oid) {
> +		oidcpy(peeled_oid, ref->peeled_oid);
> +		return 0;
> +	}
> +
> +	return peel_object(repo, ref->oid, peeled_oid) ? -1 : 0;
> +}
> +
>

So similar to `peel_iterated_oid()` but instead of relying on the
reference backend to actually provide us the information, we simply rely
on the value if present. This avoids the round-trip. Makes sense.

The last resource is to look into the object database. Which should only
happen with loose refs in the files backend.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 7987acdc96..7922d63acc 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -959,11 +959,14 @@ static int next_record(struct packed_ref_iterator *iter)
>  		if ((iter->base.ref.flags & REF_ISBROKEN)) {
>  			oidclr(&iter->peeled, iter->repo->hash_algo);
>  			iter->base.ref.flags &= ~REF_KNOWS_PEELED;
> +			iter->base.ref.peeled_oid = NULL;
>  		} else {
>  			iter->base.ref.flags |= REF_KNOWS_PEELED;
> +			iter->base.ref.peeled_oid = &iter->peeled;
>  		}
>  	} else {
>  		oidclr(&iter->peeled, iter->repo->hash_algo);
> +		iter->base.ref.peeled_oid = NULL;
>

So my comment on the previous commit holds. We have to manually ensure
we reset the fields.

>  	}
>
>  	return ITER_OK;
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 97555fa118..2f46f650a6 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -428,6 +428,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  			iter->base.ref.name = entry->name;
>  			iter->base.ref.target = entry->u.value.referent;
>  			iter->base.ref.oid = &entry->u.value.oid;
> +			iter->base.ref.peeled_oid = NULL;
>  			iter->base.ref.flags = entry->flag;
>  			return ITER_OK;
>  		}
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 7fbc77492e..f93ab96358 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -546,6 +546,7 @@ struct reftable_ref_iterator {
>  	struct reftable_iterator iter;
>  	struct reftable_ref_record ref;
>  	struct object_id oid;
> +	struct object_id peeled_oid;
>
>  	char *prefix;
>  	size_t prefix_len;
> @@ -670,6 +671,8 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		case REFTABLE_REF_VAL2:
>  			oidread(&iter->oid, iter->ref.value.val2.value,
>  				refs->base.repo->hash_algo);
> +			oidread(&iter->peeled_oid, iter->ref.value.val2.target_value,
> +				refs->base.repo->hash_algo);
>  			break;
>  		case REFTABLE_REF_SYMREF:
>  			referent = refs_resolve_ref_unsafe(&iter->refs->base,
> @@ -706,6 +709,10 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		iter->base.ref.name = iter->ref.refname;
>  		iter->base.ref.target = referent;
>  		iter->base.ref.oid = &iter->oid;
> +		if (iter->ref.value_type == REFTABLE_REF_VAL2)
> +			iter->base.ref.peeled_oid = &iter->peeled_oid;
> +		else
> +			iter->base.ref.peeled_oid = NULL;
>  		iter->base.ref.flags = flags;
>
>  		break;
>
> --
> 2.51.0.764.g787ff6f08a.dirty

All of this looks good and as expected!

--0000000000007f4826064092b83a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 36a70a09a031e234_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qbEtUVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjhKQy80bGNoQ0xqNjZNc1hjc2Ntc3dIUFFFRHc4cQovMGtyUWFXM2p0
TFgvNmpxSTlkalN1eEFGQ0VJb0VzRlpFM2Vid2VBVU9DbDhSalA0QkdoVXZVOWN1RXYxY21RCjd1
ZnJ4cFh6eW9IUFpuWVBjNVVuWS9wY1JBZHlvWnJsYjFiSDFKTUV6TURpV1hqeE05SHJ2UzBmUFpO
VjBJcFAKdktGdkwyTU50N1haeGdtUHJWeFNXalVzUzRoNVZINGp5amI5MUFZbGwyNVdvMVdQQmcz
RTlWTDZEb0RpOFhIYwpzRXpmZDhDeUVZOHBuZ2tYNTFqbG9rMHpYdm1tZHY0Y3o1T2dFTEp5dlBD
ZWt4R3RMcGUzalFhNjZxcDl2UVVQCkVIT3lFemsrbnRJTXRpT2RzSEJ5bW0xa2E1U2xkanNpV1FO
OHhsckNmL0VUZzdpcGZqYS9LWUFXcjVJeWROSTkKRXJGVlVTaXdMUlloSGtPenFsWDhnZmh1VXZv
ZW8rVnUyZi9NeUh4SERGV1paQW9xRGZXb0VqZjJOdlR6TWtQdwpSSlpqSGtCcGRMQmRuR1ZqcEVk
bDIyUGo2TEYzNWZkbEZnOXNJS0dPK0p0dXpudDgwMkppZnV1NmRBVXUzVGVYCm9kSXZ6M3dYeGJX
TU0rZzRvdUJMOVUwWUdCWlI4bEdhU3FnckxjTT0KPVJYYjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007f4826064092b83a--
