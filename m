Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245B566C42
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931457; cv=none; b=BNC5rNJHn5Ba73NWF5F2m1YAY0T/ux9lKHAOWSOBoaFXhNlsP8KXGDOuS+n5TLROmH6xO8o4CXHsO0Z4v//6jLnNdFtW0ddVXKNu4wF7mY2CUpCLIMNDEfLK7HYclfub77Aan9N4T4cM/Mn/TFSKzZx34RBNT14nniSRFY/UVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931457; c=relaxed/simple;
	bh=MmUA8U5pfH8x7OaVQfCfH16Y+j3d4t3f4FNf2fkfwsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cew9n2rru1B3pIuPfOOg+PxzSIQg1L1YecrTq4yGe/bAZf3lyl4QuePgcKKiev450JKjDHupN8JVxl6Cl5NIGXe0jZE9GZ6BVGqtexPhbfnVvqzWsblKQccYGalewkOHcgBbilI9JSAnC/3f+xQlOYkC336xhBGi4SAYJC1k1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEv96F+O; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEv96F+O"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-48eee44b908so2059583fac.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791931455; x=1792536255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ec9DyzqwrwQ2n6hwz+0TPB5JX1rLfg8F028Pe0DEQFs=;
        b=pEv96F+O8neWTLmvIVUQ0r76F7IZGmMdc0SbuJPTZAQC1Zd2EZgpsl5cz4dOyT1yaN
         oA7FX0VjB23eW+VI4gAp0DfTKXMdxKm70nBCeSxsAswCbSqSMrJZoEr1y26Apa0fwEXg
         c6Ya1GV+HrqokSBR/S+HlumLu4ybFu+vISyFsc2Cy7iblQ+OZX9CeEFK2b3kxxM9Sv/b
         gf2anbIE9ehXDSd7sz/JnMrwBBjBPJYo/g5xFL7VIgI3cX5iZ6CmrU0bk0XDWnqwSyDO
         LCuujFRnx+OUfKk6bu19AQW5KnFCxro5qygycloB3p0Asz4K5e1nL6FHGAr+sAeZpdJp
         jvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931455; x=1792536255;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ec9DyzqwrwQ2n6hwz+0TPB5JX1rLfg8F028Pe0DEQFs=;
        b=ZOS4CbmJl0qYXbkFm5/UegorQusvyqPrrwKdnPSuLaDL458ORqnDe/OU3GnGeMVZqZ
         6iJk3SnIrDe8qy5BPQwlK2SRapMzESbfe6Tj1XIYPEqe9WBVAxpMOthhZvQ/T6/Stufy
         sEgQw9QOAWB83v5WS/0eaUPp7G+SCQ24jwKwv+ho5b9Fvvfcg+ySR95Pk1UsSBK5Jjcw
         8saceh4VcEZq31PqZbz4cc3kIWl8cZHVpnHdOgDmE3t0yjISuY1TKIXn6y6Ei2pDgrO4
         mbOPQ1DO/tezio2zuZ7P4nf7gDzDJ82XvtS3U+f2/rUZ0xGOv+wc8btPQiYiu9qU2qpc
         EKqw==
X-Gm-Message-State: AFq9FYIpL5dKfu0HtVL6znYH2qYf/ynKHfe65HwQo8vCFhFOGlZDaehI
	0spH7K11DzcsMabNEHmxPOenhonhGDtMALy4Gt0+nFHMS+6IFUBXeA74dMgJqQ==
X-Gm-Gg: AYBFou23F4Sov2beZUds/yPGs4zJddGumCpJ25GKApqHHJNyQsuCBT8VnYnvBOxOnCP
	FkmnHd20t/cArVD7Wo3Hyys1GS2GA4DULGtWTdcTVXJqA6/XfOJXRnnIVSKwmvwYGh6E5q2DjQS
	vMXRnm7x3TW+Pa/czxwHkyfW1s+yvxcps7fnelh5KWhqAjJQfBApfoSZRNEH3/PMRbC3CyfR5vY
	lLy80JV+Y3X9uL8q9S04dWtmjsXze7kpLu7jmpFD2gi3Hp2WgMii9bxekQcqL493M9bkkbDR97h
	EJrbBFMGn42V//cGmoztwbSnww1cBPKhhT0WG9RMY8bCt8B1DXL1Ho/dc13R7mfP5crsFcY41sv
	CBX0P7OCNwRZvKGKYA8wr52uO6Ho760NMpNoTUmBYDl6usWXnppAD+fmJx3owYVMXq4pCmD0M9M
	VZQjKp54mgYTVzUxZA/iyT3quNIOAagiLpORA3I1c+JZPYxHW4/UeYzcHnYyHCr5ungahoQqtzw
	yRdIHV+HcotagzmUiB2lIw=
X-Received: by 2002:a05:6808:f8c:b0:4cc:c2aa:6c6a with SMTP id 5614622812f47-50c4dfb8c4emr11666536b6e.19.1791931454764;
        Tue, 13 Oct 2026 15:44:14 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c167544b5sm15578689b6e.3.2026.10.13.15.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 15:44:14 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:44:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 5/5] odb/source: drop `local` flag
Message-ID: <as6palGWxRlky0bS@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-5-b7030ff2b26f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-5-b7030ff2b26f@pks.im>

On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> The `local` flag indicates whether a given `struct odb_source` is a
> local source or not, where "local" is defined as being the object
> directory that is directly attached to the current repository. But now
> that alternates are handled in the "files" backend, this property is not
> something that even makes sense anymore to have on the generic source.
> 
> In fact, we already have a partial replacement for this field in `struct
> odb_files_dir`. The only other site that requires it is the packed
> object database source, because it propagates the bit into the packfiles
> it is opening.
> 
> Drop the flag from `struct odb_source` and instead move it into the
> packed source.
> 
> Note that we stop considering the `local` bit when iterating through all
> loose objects with the `ODB_FOR_EACH_OBJECT_LOCAL_ONLY` flag. This is
> fine though, as we already handle the flag in the "files" backend
> itself, where we skip over any object directory that is not marked as
> local.

I do wish we could also drop ODB_FOR_EACH_OBJECT_LOCAL_ONLY. This flag
also feels rather leaky to me. I guess though we still need a way to
ignore objects from certain sources when iterating over all sources such
as the inmemory source.

Overall, I happy to see the `local` field dropped from the generic ODB
source structure, but IMO is does make each `for_each_object` callback
handling of the ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag a bit ambiguous and
awkward.

Naive question: Do all odb_for_each_object() call sites that use the
ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag have "files" backend specific
reasons to do so?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index 868e723c81..75cf29fa9d 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -161,8 +161,12 @@ static int odb_source_inmemory_for_each_object(struct odb_source *source,
>  	};
>  	struct object_id null_oid = { 0 };
>  
> -	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) ||
> -	    (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local))
> +	/*
> +	 * In-memory objects are neither promisor objects nor do they live in
> +	 * the local object directory, so there is nothing to iterate over.
> +	 */
> +	if (opts->flags & (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY |
> +			   ODB_FOR_EACH_OBJECT_LOCAL_ONLY))

So for the inmemory source, we don't want to iterate over the objects at
all if we are only interested in "local" objects.

Naive question: Are there any scenarios where we even would iterate over
an inmemory source and only be interested in "local" objects?

>  		return 0;
>  	if (!inmemory->objects)
>  		return 0;
> @@ -369,7 +373,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
>  	struct odb_source_inmemory *source;
>  
>  	CALLOC_ARRAY(source, 1);
> -	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
> +	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source");
>  
>  	source->base.free = odb_source_inmemory_free;
>  	source->base.close = odb_source_inmemory_close;
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 180ce7403f..50cb388c35 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -464,8 +464,6 @@ static int odb_source_loose_for_each_object(struct odb_source *source,
>  	/* There are no loose promisor objects, so we can return immediately. */
>  	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY))
>  		return 0;
> -	if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
> -		return 0;

Ok, the "loose" backend callback already doesn't need to care about the
ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag because it is handled at the "files"
layer.

>  	if (opts->prefix)
>  		return oidtree_each(odb_source_loose_cache(loose, opts->prefix),
> @@ -1108,13 +1106,12 @@ static int odb_source_loose_fsck(struct odb_source *source,
>  }
>  
>  struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
> -					      const char *path,
> -					      bool local)
> +					      const char *path)
>  {
>  	struct odb_source_loose *loose;
>  
>  	CALLOC_ARRAY(loose, 1);
> -	odb_source_init(&loose->base, odb, ODB_SOURCE_LOOSE, path, local);
> +	odb_source_init(&loose->base, odb, ODB_SOURCE_LOOSE, path);
>  
>  	loose->base.free = odb_source_loose_free;
>  	loose->base.close = odb_source_loose_close;
[snip]
> diff --git a/odb/source-packed.h b/odb/source-packed.h
> index a0f6b5096d..e8a7b08fbb 100644
> --- a/odb/source-packed.h
> +++ b/odb/source-packed.h
> @@ -41,6 +41,13 @@ struct odb_source_packed {
>  	 */
>  	struct strmap packs_by_path;
>  
> +	/*
> +	 * Whether this store is part of the local object directory of the
> +	 * owning repository. Packfiles loaded via this store inherit this
> +	 * flag via `pack_local`. Stores for alternates are not local.
> +	 */
> +	bool local;

Here the local flag is moved to the "packed" backend...

> +
>  	/*
>  	 * Whether packfiles have already been populated with this store's
>  	 * packs.
> diff --git a/odb/source.c b/odb/source.c
> index b25ef14df8..4155fc22da 100644
[snip]
> diff --git a/odb/source.h b/odb/source.h
> index 0cfe762376..8b839caa39 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -58,14 +58,6 @@ struct odb_source {
>  	/* The type used by this source. */
>  	enum odb_source_type type;
>  
> -	/*
> -	 * Figure out whether this is the local source of the owning
> -	 * repository, which would typically be its ".git/objects" directory.
> -	 * This local object directory is usually where objects would be
> -	 * written to.
> -	 */
> -	bool local;

...and here the local flag is dropped from the generic source layer.

The patch overall looks reasonable and seems to be moving us in the
right direction.

-Justin
