Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150C86347
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826773; cv=none; b=lZS3cqdc2idADYwxlVz+UGlQWFmDCZS1ha2R0DQv8pbwQEhhyoe7kbdhBE4phd5yt0hZwZ2polTdKehAPef9Dia3I7qOifLPiysVw/06yjqPJ1NruTNvAprLiNjhMLuR/IrGvGg81Enm3EFYrq8e9R5h7EnKCkVegr2cKOK23YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826773; c=relaxed/simple;
	bh=/B9+bq5ykvJDVTKQ2p04wLuD7zdIRwIom2RqAU8cRgc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=sulJKtM1B/GQKbziPlJz4eO526QzIUossWqflLfY8vh2LFEy5nXRAtO4xjgj97CH4Xfg4DDRDzGmFHRH6dzL+L8Fz8xhD+1s29G6PL8kdRo1L4mpy7skII0cjfbsQ2MGqFPTgW6/54vcLUAv/7xPcMozBrjZV39dJ2SgANmHJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYRkETtA; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYRkETtA"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-932bc48197bso485206241.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761826771; x=1762431571; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xToUPFK10JvRAbFpbeg6i3G+1ecXA1hZMR2CivjNUw=;
        b=eYRkETtA+8+vGRdc5Gy0W93EqxUWRIiyAgqXN45LNT5CzJpGGcA6XFzL6INyvL0zUk
         sypI01MtHMo1uxj2jsnTCK4ZNV0xy5yHvsXDbMZxGA6mA8Q2QIaXLyH8vbowWm2tTMvK
         rxXYnphXBHXPOVkr6Tur87+C2kZkVw+PZ1tUN2L3R92qb/HjZrymtmnqKvkugiokcUGz
         5RT1pu3nx1H4HquGNJ8MCNqPdlQyOUKsb/SNrPJN0tBH9SLW0eEpcJBPqd1iF+TarBPR
         NQmIEBWuu4QpACyWdcyZ65g3JIF6Gjqy81a+EbiKydU+IMxL1QuUCGrRvY056FJ/1NiS
         rHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826771; x=1762431571;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xToUPFK10JvRAbFpbeg6i3G+1ecXA1hZMR2CivjNUw=;
        b=gevPpULppVVETapuXzwkqVnDRQMAJ9WRxwqu5uHwSdmtIFIijcRY/0vB9EBVRIWoIz
         ScaqwvpYjCT4O9EZQEZL2ilC5egDBz3k9kraSbmcWZAmOw9gdz2I/ARtfdzgNgp6eEjV
         zqrb5H88YOMnWZ9G40TWGLwIaIVtKgl6Wv4aS1Xa4Vezvt+bDALePSzCia8DtwubkvvD
         EYg69GKunzA+Iz9MXHZX1YsnXwOOKu89PdVOoQK2Fu8QdolqBJm9zp4r3tXEs7re5x0d
         Ai+ih7HYwHrlj/HpSNsz5DEs9Db2wFqiOJsoKgt78bQ4FgodZpUNCFimeHJYfx6adB2b
         vkBw==
X-Forwarded-Encrypted: i=1; AJvYcCVjMIW+9Y4egk8e26xz+A92NDoncp2v+jTYBK/EMOR8Hfoy5Y4tujOG1fY/1e5hI2pxuaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAymQKRQPhGJbWjto586Vf1Wa6yH2LuU1kERb7rDwbsm1IfjQ
	0/rhxgotd/2qo9leRPk3YXob5Yye4p0JueWOnASsZT5MIrhIzf1BQssFVonkZHPzF5asc8/IEiR
	Obhno+xh3z6MFCKcjnmD7UVR2bYI3aeo=
X-Gm-Gg: ASbGncvCcPQ7zSe+xm7Gr5KtEL9NCufX0CLEBRMnIeMTvjSAqc95D2mSVMsJ6z13syG
	wc/7wFGGuJGAqGTESpSTYWe264E1On+G4BsaGZR+TF8aC7jEny0tpyA3rHg499QtO5zuf5PoIva
	pfPW1lq/ZwuI+zRxBZ94EMgtzvChCBxWglBBYgZWPBgvVlDZoBhwscJ+IWkjk4GwHWpZTlw6S5a
	+P9wrsnX4pMBMSlrgRbq9C6zZaXdSMCDyAo8arC+Zc6sqtx3hsUnLb0LOmVx3etJl2AjIT/qbAg
	g56t3HJNIzkyK3sgBA==
X-Google-Smtp-Source: AGHT+IGJIgBKm5Zc7Fq35d2X4K3n7loddZvBwbt0ysQ5WbEkhug2MTZNEARACUs4PN4xhXGnxUCfwG+vHdvhWXsmaQE=
X-Received: by 2002:a05:6102:3f16:b0:5d5:f544:a88e with SMTP id
 ada2fe7eead31-5db90681e8cmr1755946137.35.1761826770098; Thu, 30 Oct 2025
 05:19:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 05:19:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 05:19:28 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-9-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im> <20251024-b4-pks-odb-loose-backend-v1-9-1a4202273c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Oct 2025 05:19:28 -0700
X-Gm-Features: AWmQ_bmbPQE1DumsbX9tQxqeSQ3fjlELPKLARpT89bzLOqIZwZ5IUGkgp3jUKCg
Message-ID: <CAOLa=ZRXtT=5R1vM=4xcvJtRSNhC=7wqTAstK5QTaD0qbhYZrg@mail.gmail.com>
Subject: Re: [PATCH 09/13] object-file: read objects via the loose object source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c9b6b806425f421c"

--000000000000c9b6b806425f421c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When reading an object via `loose_object_info()` or `map_loose_object()`
> we hand in the whole repository. We then iterate through each of the
> object sources to figure out whether that source has the object in
> question.
>

Okay so earlier these two functions would call `open_loose_object()` and
that function would iterate over all object sources like you mentioned.

> This logic is reversing responsibility though: a specific backend should
> only care about one specific source, where the object sources themselves
> are then managed by the object database.
>
> Refactor the code accordingly by passing an object source to both of
> these functions instead. The different sources are then handled by
> either `do_oid_object_info_extended()`, which sits on the object
> database level, and by `open_istream_loose()`. The latter function
> arguably is still at the wrong level, but this will be cleaned up at a
> later point in time.

And we move this check to a layer above, which can check if any of the
sources contain the object.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 68 ++++++++++++++++++++++-------------------------------------
>  object-file.h | 15 +++++++------
>  odb.c         |  9 ++++++--
>  streaming.c   | 11 +++++++++-
>  4 files changed, 50 insertions(+), 53 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 14daa2bdd90..d9724e3105f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -167,25 +167,22 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
>  }
>
>  /*
> - * Find "oid" as a loose object in the local repository or in an alternate.
> + * Find "oid" as a loose object in given source.
>   * Returns 0 on success, negative on failure.
>   *
>   * The "path" out-parameter will give the path of the object we found (if any).
>   * Note that it may point to static storage and is only valid until another
>   * call to stat_loose_object().
>   */
> -static int stat_loose_object(struct repository *r, const struct object_id *oid,
> +static int stat_loose_object(struct odb_loose_source *source,
> +			     const struct object_id *oid,
>  			     struct stat *st, const char **path)
>  {
> -	struct odb_source *source;
>  	static struct strbuf buf = STRBUF_INIT;
>
> -	odb_prepare_alternates(r->objects);
> -	for (source = r->objects->sources; source; source = source->next) {
> -		*path = odb_loose_path(source, &buf, oid);
> -		if (!lstat(*path, st))
> -			return 0;
> -	}
> +	*path = odb_loose_path(source->source, &buf, oid);
> +	if (!lstat(*path, st))
> +		return 0;
>
>  	return -1;
>  }
> @@ -194,39 +191,24 @@ static int stat_loose_object(struct repository *r, const struct object_id *oid,
>   * Like stat_loose_object(), but actually open the object and return the
>   * descriptor. See the caveats on the "path" parameter above.
>   */
> -static int open_loose_object(struct repository *r,
> +static int open_loose_object(struct odb_loose_source *source,
>  			     const struct object_id *oid, const char **path)
>  {
> -	int fd;
> -	struct odb_source *source;
> -	int most_interesting_errno = ENOENT;
>  	static struct strbuf buf = STRBUF_INIT;
> +	int fd;
>
> -	odb_prepare_alternates(r->objects);
> -	for (source = r->objects->sources; source; source = source->next) {
> -		*path = odb_loose_path(source, &buf, oid);
> -		fd = git_open(*path);
> -		if (fd >= 0)
> -			return fd;
> +	*path = odb_loose_path(source->source, &buf, oid);
> +	fd = git_open(*path);
> +	if (fd >= 0)
> +		return fd;
>
> -		if (most_interesting_errno == ENOENT)
> -			most_interesting_errno = errno;
> -	}
> -	errno = most_interesting_errno;
>  	return -1;
>  }
>
> -static int quick_has_loose(struct repository *r,
> +static int quick_has_loose(struct odb_loose_source *source,
>  			   const struct object_id *oid)
>  {
> -	struct odb_source *source;
> -
> -	odb_prepare_alternates(r->objects);
> -	for (source = r->objects->sources; source; source = source->next) {
> -		if (oidtree_contains(odb_loose_source_cache(source, oid), oid))
> -			return 1;
> -	}
> -	return 0;
> +	return !!oidtree_contains(odb_loose_source_cache(source->source, oid), oid);
>  }
>

These above functions are much simpler now that they have to only worry
about the source level and not the repository level.

[snip]

> diff --git a/odb.c b/odb.c
> index 96059456f20..5dc1e2c7eb0 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -697,13 +697,18 @@ static int do_oid_object_info_extended(struct object_database *odb,
>  		return 0;
>  	}
>
> +	odb_prepare_alternates(odb);
> +
>  	while (1) {
> +		struct odb_source *source;
> +
>  		if (find_pack_entry(odb->repo, real, &e))
>  			break;
>
>  		/* Most likely it's a loose object. */
> -		if (!loose_object_info(odb->repo, real, oi, flags))
> -			return 0;
> +		for (source = odb->sources; source; source = source->next)
> +			if (!odb_loose_source_read_object_info(source, real, oi, flags))
> +				return 0;
>

The iteration over all sources is now moved here, makes sense.

>  		/* Not a loose object; someone else may have just packed it. */
>  		if (!(flags & OBJECT_INFO_QUICK)) {
> diff --git a/streaming.c b/streaming.c
> index 4b13827668e..8e554abd084 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -230,12 +230,21 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
>  			      enum object_type *type)
>  {
>  	struct object_info oi = OBJECT_INFO_INIT;
> +	struct odb_source *source;
> +
>  	oi.sizep = &st->size;
>  	oi.typep = type;
>
> -	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
> +	odb_prepare_alternates(r->objects);
> +	for (source = r->objects->sources; source; source = source->next) {
> +		st->u.loose.mapped = odb_loose_source_map_object(source, oid,
> +								 &st->u.loose.mapsize);
> +		if (st->u.loose.mapped)
> +			break;
> +	}
>  	if (!st->u.loose.mapped)
>  		return -1;
> +
>  	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
>  				    st->u.loose.mapsize, st->u.loose.hdr,
>  				    sizeof(st->u.loose.hdr))) {
>
> --
> 2.51.1.930.gacf6e81ea2.dirty

Same here. The patch looks good.

--000000000000c9b6b806425f421c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9896163234a622d4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rRFY4NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnVZQy85d3l2MnBCRktMMS9zTUhyMlVCZHAxNjZXeAorVnNUU1lCRjRG
NHB5TE42dE5XQmNEWlhFU0lFcHNWUkpzSUJhNStRbUNJUzNNMGZZWENTVXFDN0JGWE5UZGVyCmNT
M1VOZFErV29tKzF0amtQc3c2SE1iVG5uOGlxWkZ1NE9RSjJLdDhjSnBOU2MyWUtnRXFrV3VUczdt
aEFacXoKaWtSTzhQWlZsVGFKQ2M1MWdWcFdIWlo0UVdkZFYzOUp0UEpJRGdIR3Vybko5UTZaZDRD
Rnd6b01VREgyS29UTQp3Unpmd2RtMTlMZGtMencvOU1LK255aEJOSmFBRnhuS3J5eWRGQ2FwVXFw
V3dxejZBVFpYaVQ1RENDanpBaDNlCklxWWhtNnFpeFE5cmpGeUhaSEN4RFNDZmNLbXZBRXNSNE51
ZEt4R0NYYnhoVTc0U0lubVJtSWlyZFQwd0h6eVAKVjhhS3QwNWNFUGZLSEJRVXpYbloyekJLOGRP
VVFBRlEwcUZtSVVoS0t3V05aSXJ6bEFWZUNXQ1U4Z2J4b3VtZwptVWgzbjhmU3V3c3dsRXI3V2hS
bTJKNUNVMkFkM2x1K0UyWUVLZFRNemxiNE8xMU01UWhKSnZTS1A5bVNiRzBuClNwaHQyRmM5OWZs
aDlJRmg1bnBCcmdHcWhIbzdDdWVRVHlnbTFNST0KPXhDdjcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c9b6b806425f421c--
