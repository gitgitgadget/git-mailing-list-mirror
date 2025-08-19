Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6D238C0F
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596856; cv=none; b=dQpfBX9cXs1mGM9M1I8bi1SmzhMhKqcxLip5M+LGF1f353Muc5f2UQV446+a1jYk3+GpXPcKtn7zTmbXLIbupJxc7d0/oTR7jQHP02zoDmJmSDTrsThopyaysbbWGJ/fiq6XBePfreN11G9W1WiBCYDOqxO2luolljfSOCoWHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596856; c=relaxed/simple;
	bh=B3Zs+RayRS4fLBsT5NHqfYspKxSjJZmf57Yw4NRkXD8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=KMluDgDQD3Izlbj5SW312kEBKKSPqM4fh440BpkrtS205yEPxmoP5rIoP9iWCw20pctl6UBwL9NrP8vMf3vIaPdipzq9khWwtNUz/aHh+yvl6kuCRF1uz8j2qU3T2usqLRdue3/OEB1Ebw3FkJVzcxblNkxfHPnN+fD7q+3/axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRayPt/D; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRayPt/D"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b17558b2fso3780544e0c.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596853; x=1756201653; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9u0Mt1rn6ESteQuonItXbOxzwBUDTMgQrweBqeTTL8=;
        b=PRayPt/DRInqDLupyv0vVW10gEbx36grHolV2Ns4AjNvBw5yoW4zmJ+io4yLzmWvDg
         B/h/cR9h8pK1qJFkwOs2DC8ObXE73atDFk9Ua8NS7Fb4A2BdIJndDCGFLEi87NOhHNsr
         sd1AN+zXPalxkeQrS0aKtXm6YJk/XzOkb25kfZ+O4wB2MIiGzzmbc7ajpDOEoZlUJ1U2
         +SJk09O0/15ZHUbOfKlNpDKul5PP664KzVwXV+hFP3LXwydOOkFwX9e9wkBPOc1KXTHP
         ancj8lfmQhVem6nBELczyrQPvtZgnzyvHn3vO1gsHkcdAR4HhBRwdsQMdmCbhWCeLUGg
         zmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596853; x=1756201653;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9u0Mt1rn6ESteQuonItXbOxzwBUDTMgQrweBqeTTL8=;
        b=AwC40qeAKTjuZbi7Eu52HBszapisyirTHfzmJFjLoElCblvk8SLS0U3FeOPoOKy3Jy
         YHfJ6s8365jhh1y3GouAwNAr7j0p3IEs9GBb7KPNIpFqI3RrJieok5a4oJHcrMH52aK7
         6ViZTYXIT82+M7VHcCr+X19ZglaGLOxRKJ0rh1Dwvwb5fZCj5oTO7fk2NuCEduu6/9ji
         TG3vere3USTD6VOFMo+lFt9lZX9dHJ4dQDp9t5I3liapY22+mAX73XG7oyezfnCI3VIO
         OGPW7QouFI/i9sLEqcptyRSF9BNdo0bxUiiyaWlAJuBLW105Lth25T5Uzdea+Aizj5S1
         newg==
X-Forwarded-Encrypted: i=1; AJvYcCUcd18qtfA8XDlrSy/8fJCb2Ny5FGBKopvHnu9oMGa945BYV8urRfo9nW9Z0Rdq7Gt5qpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi51k8AHokg3+EbRx8qE07TgubMnYb/0+yt7yGOrIWOo3q8/eW
	WlRZGqC6YRdQmOdh1vt+/7U9bgy+V/UcDJb0vBxtgQtr/MOyiuiyxwxESUNxTOAcxILuvMWwt61
	K23txVG7YFgywh+TizIYj01UyskFx7cY3GQ==
X-Gm-Gg: ASbGncu5cQoMzEp2IzTZ8Aflv4cc8zR6ib/eZ5HJvLYjRSCkU5Lod1YZIlWqQ4ffGcn
	ft3unJCTIUHQ+f36zpQIkvglkOJESoNbR8rfI48s+eZ0EeO0bSblzRvTLIcN/MGJSnYVFSRhlLT
	+ebuCYkiN2WJCGoRlvuI37/PYXLPTc6lZ6ECf+yOE4hdy7K+5NXfieXrNfftIc7aNau2hM9/1c/
	5km61e+CD4jEMzTDQc=
X-Google-Smtp-Source: AGHT+IEL5BluYnq4ToQyP0/WwZay2/IrQmi22EXpZUM3+yYa/mGoZMYBgKXLYDPrqONqbxfLs7eC+E1SDHZeelK9fhg=
X-Received: by 2002:a05:6102:cc9:b0:519:534a:6c3d with SMTP id
 ada2fe7eead31-519534a73ecmr375868137.31.1755596853315; Tue, 19 Aug 2025
 02:47:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:47:32 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:47:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-1-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-1-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Aug 2025 02:47:32 -0700
X-Gm-Features: Ac12FXybTTWl9joGP2z4I8kDWeEP6WzvOHgF0Y4vepqasB2uwb4h5PXBSXuMJzM
Message-ID: <CAOLa=ZTd3JTfkkxuuD51CbvJH1B+ag56LWKCgD55AzmWvi4XhA@mail.gmail.com>
Subject: Re: [PATCH 01/16] packfile: introduce a new `struct packfile_store`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cfabfa063cb4bebf"

--000000000000cfabfa063cb4bebf
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Information about a object database's packfiles is currently distributed
> across two different structures:
>
>   - `struct packed_git` contains the `next` pointer as well as the
>     `mru_head`, both of which serve to store the list of packfiles.
>
>   - `struct object_database` contains several fields that relate to the
>     packfiles.
>
> So we don't really have a central data structure that tracks our
> packfiles, and consequently responsibilities aren't always clear cut.
> A consequence for the upcoming pluggable object databases is that this
> makes it very hard to move management of packfiles from the object
> database level down into the object database source.
>
> Introduce a new `struct packfile_store` which is about to become the
> single source of truth for managing packfiles. Right now this data
> structure doesn't yet contain anything, but in subsequent patches we
> will move all data structures that relate to packfiles and that are
> currently contained in `struct object_database` into this new home.
>
> Note that this is only a first step: most importantly, we won't (yet)
> move the `struct packed_git::next` pointer around. This will happen in a
> subsequent patch series though so that `struct packed_git` will really
> only host information about the specific packfile it represents.
>
> Further note that the new structure still sits at the wrong level at the
> end of this patch series: as mentioned, it should eventually sit at the
> level of the object database source, not at the object database level.
> But introducing the packfile store now already makes it way easier to
> eventually push down the now-selfcontained data structure by one level.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c      |  1 +
>  odb.h      |  2 ++
>  packfile.c | 13 +++++++++++++
>  packfile.h | 18 ++++++++++++++++++
>  4 files changed, 34 insertions(+)
>
> diff --git a/odb.c b/odb.c
> index 2a92a018c4..34b70d0074 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -996,6 +996,7 @@ struct object_database *odb_new(struct repository *repo)
>
>  	memset(o, 0, sizeof(*o));
>  	o->repo = repo;
> +	o->packfiles = packfile_store_new(o);
>  	INIT_LIST_HEAD(&o->packed_git_mru);
>  	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
>  	pthread_mutex_init(&o->replace_mutex, NULL);
> diff --git a/odb.h b/odb.h
> index 3dfc66d75a..026ba9386d 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -83,6 +83,7 @@ struct odb_source {
>  };
>
>  struct packed_git;
> +struct packfile_store;
>  struct cached_object_entry;
>
>  /*
> @@ -128,6 +129,7 @@ struct object_database {
>  	 *
>  	 * should only be accessed directly by packfile.c
>  	 */
> +	struct packfile_store *packfiles;
>

Nit: The newline spacing makes it seem like the comment above only
applies to `struct packfile_store` while actually it also applies to
`struct packed_git`.

>  	struct packed_git *packed_git;
>  	/* A most-recently-used ordered version of the packed_git list. */

[snip]

--000000000000cfabfa063cb4bebf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 90ef99875698273d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pa1NESVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTRzREFDRG91WVRlL1lpUFZDeWUzNnZicEFSNGpudQpFZFE5aWoranNW
eG5tT3d6SVNuemRlbUJWbWE3VHdKanh3UnNpYVlrRWxIZmpya1dXNFVYbDNRUE94Tzk0L2drCk9v
ZWh1OG9HVjUwZVkyM3B2UGhscFVzWjY3ZDlaZmFOdlNaajBnaW9nUzZkMnpqN3RlU1FrbGV4b3J6
eXl5ODkKSmFPZ0tHb1c0YU5YMXYvenNSeWRuZEpydDhaTWJ2ZjQ5SWlQRkdnOVpYU2wvc3Q4Sk1q
OE43aTBOaE4rQTVlcQpObk1KeTU5cmt2NnVIK2d4SjNTZVAxVDhxS3drdnF5aUZtbHhrZVhwY2R3
bDJxaVZNNVgxbkZsVk1saEJrYzYyCjlqYW1MaWJNeEFMcldsUkRlakw4U3I2SU0rbGdkT1RWZVNz
eFp3VGlub0c0azY2Ym0vUDd2Q1gzcW9oVmJWTXoKOW9XN2lVYUxsN0JadENHcUtuNFlmVHZQS3Bw
dEczT0MyeDdmcnJ2bUx2dndrWTBjdGJES01WS3FnMzZMMXQzeQpRNjlOalR0TmlCNnUvZFM4blpW
QjQreWVGRzI4SnIreXpLSUpZOGFBSWgxOGhKYmpqK01vOXF1eG9wU3BJVktpCk9jQkJhVUxJQnJO
eTEwcmJJeW9ZN2V6c0EvSEh6a2E4M2x6UHdPMD0KPVhDTFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cfabfa063cb4bebf--
