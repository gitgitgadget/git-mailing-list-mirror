Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2B18FDAF
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181338; cv=none; b=o/lqFqL8Ak0CV7D2nOEFXqH4/p8V1kKD1UNvDhdAfUObRAhOVNJpLy/EH5uGdMh17rlWdDTUMn5SVMM3eSO/JJNGbp18jufopqKdYfpClbnnCTD/eT9XupPsFy3G3M/a5a8tTviBoztDccmYWUCyPJxaL0r+HpRPmielyPoK9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181338; c=relaxed/simple;
	bh=R/hAv+a5Y1fPRgtbu9dvHvLdhN6ob7BKd2EAE5/Gkeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTg9YHnZgrzfkNXVdinkDW61gssy+MH0FeByc9WkX68/Sejqppyu0vt2qAYeKFdopaHf9IbxyrN2ZwHVddQqwu4DrHccnqzSIhlqDJWuOTzNxEsRe3FeDj9UJZ3p+gWK+DrCK7ZNIp+hDUHreblE9+EmP0sdQomzuB4OnS9WEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9EKYcBT; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9EKYcBT"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ea58f008e9so1241816fac.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752181336; x=1752786136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6iYb4btRwmHXZoqnKFsYETCzugwK5EvQotAbizKWsM=;
        b=R9EKYcBTKt8HRExnm8IYkgv0yz2FXw2tEZRjNI5weGsOR+v9H1dxDpEvK4Jq6P0tUQ
         E3PaqW1uuMiJVAcFfJBiJgef4zcysBSQejUebUXh+BzAHMpjvgV9gvEUk9/aAA0gUcG2
         ooNnPzlUajlr4CE5WqohagbmLczjABstLwxvDhqZWsi0zXvjUlSE4RTrNQ1+PttcZ1zU
         XB2vgrOYTDoVb6QxtN9YAMEDlswsyrOr/4EZO4Eb+JXjXGw9HoQgaKtTQNo301T12RK1
         UPhuk07qY1zkbPhFbnvw4VXHL0MADC9OQQccwfppiE/ufsN4Bz/vCXah1GpNDDbm+ZkL
         KkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181336; x=1752786136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6iYb4btRwmHXZoqnKFsYETCzugwK5EvQotAbizKWsM=;
        b=le2EV1Ky9XoYvOpvy6DTfkVerJ5lL2pbTXy3trNu9Kw28OrkV5NpuO0IqbXKtPfM7D
         Oib9KG+YWMSizoGU3aKfzcYfrvffnwDU191JtprcxvbDo38z2+1OPOdSdd5Tl1cNdhsG
         sp8UUZh/6Ga+gnD44IBMuQtGXsKNN6K2zpPHBQuNGIh4GRHlmLYxAeEXqhnr80hPwbl0
         HWfIP27uW+kGlY+5R695w93UrI97tLAjvH4ONiY5bhYOjRdzWEkMIzKf18DZniT4FES0
         wlqv+fYFVcPsYMg5eIxcEm2Pwuk0DJ3ZSUR0eDFEYhNlID0rFL55FSV/uj1O+cZdA6Nm
         bgxw==
X-Gm-Message-State: AOJu0YwMDAkq2SPsGmZzXcrj676jxd/c+AdP/VzxonIK6HGteyAJMP4/
	S5UxULFmWtRcL7MX59cEJ+0G/I+RHngeYXdwAnmChe3Ccvk3Wz6zMGR9qsAhzw==
X-Gm-Gg: ASbGncvqfOVCb9eCN6pGGvwLTGYloCdfL5pRd0/dMhfGVlARBTtW6mYbkoariHwf+mJ
	DIjQp0AW/617tz7EltZ29j7DTtmwpGOGA+ptYnIbvT8f6TZIdIv1SYy9OapIf7ZK8a+J/8lwEPA
	vWZYHoz5/uYF2bn3vM0AGPFgneWPFlbTBdoJh5mFAvZXQ16RhXlXr+lDzd0kGFAn+Q4WwLTmstJ
	Vm908AKd33DSipCHwWVxxtmmEgk5LfAiBXQRTE4K/UTTUVQENrQagHI1Fp04o+6BlSLMCcEVZm5
	qy/1BHEmYRsbv1zx15xA5UnphPVtrQ4ZoQG5mcTRo2u6JNDi2ZkKqGA=
X-Google-Smtp-Source: AGHT+IGlEewEznBuOl3cIFYYkeDR2ZVWNIp1qrCRI1yuaWWhO2PtGdtzLHMRbuC0gf3ateJ3U6608w==
X-Received: by 2002:a05:6871:4b09:b0:2e9:1143:584e with SMTP id 586e51a60fabf-2ff271bb0e3mr420983fac.39.1752181335440;
        Thu, 10 Jul 2025 14:02:15 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff1129b381sm464394fac.21.2025.07.10.14.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:02:14 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:56:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] midx: start tracking per object database source
Message-ID: <myg452uza2nwkvoizn7sruvcjxmvkze4x4n3tu4gq5v6fdxkvz@d4ohmdhjkyw7>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>

On 25/07/09 09:54AM, Patrick Steinhardt wrote:
> Multi-pack indices are tracked via `struct multi_pack_index`. This data
> structure is stored as a linked list inside `struct object_database`,
> which is the global database that spans across all of the object
> sources.
> 
> This layout causes two problems:
> 
>   - Multi-pack indices aren't global to an object database, but instead
>     there can be one multi-pack index per source. This creates a
>     mismatch between the on-disk layout and how things are organized in
>     the object database subsystems and makes some parts, like figuring
>     out whether a source has an MIDX, quite awkward.

In a future where there is a separate implementation for each object
source, each multi-pack index is really only relevant for a particular
source. Some source implementations will also not require a midx to
begin with. For organization purposes, tracking a single midx per source
for now seems much more ideal.

>   - Multi-pack indices are an implementation detail of how efficient
>     access for packfiles work. As such, they are neither relevant in the
>     context of loose objects, nor in a potential future where we have
>     pluggable backends.

Agreed.

> Refactor `prepare_multi_pack_index_one()` so that it works on a specific
> source, which allows us to easily store a pointer to the multi-pack
> index inside of it. For now, this pointer exists next to the existing
> linked list we have in the object database. Users will be adjusted in
> subsequent patches to instead use the per-source pointers.

Looking at `prepare_multi_pack_index_one()`, this function is
responsible for checking if a multi-pack index is already loaded in the
linked list and, if not, loading/inserting it into the list. So now we
will want it to handle setting up the object source midx as well.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c     | 19 +++++++++++--------
>  midx.h     |  7 ++++---
>  odb.h      | 11 +++++++++--
>  packfile.c |  4 +++-
>  4 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/midx.c b/midx.c
> index 3c5bc821730..a91231bfcdf 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -724,28 +724,29 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
>  	return 0;
>  }
>  
> -int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
> +int prepare_multi_pack_index_one(struct odb_source *source, int local)
>  {
> +	struct repository *r = source->odb->repo;
>  	struct multi_pack_index *m;
> -	struct multi_pack_index *m_search;
>  
>  	prepare_repo_settings(r);
>  	if (!r->settings.core_multi_pack_index)
>  		return 0;
>  
> -	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
> -		if (!strcmp(object_dir, m_search->object_dir))
> -			return 1;

We are able to avoid searching the linked list because we know if the
source already has a multi_pack_index it must also be inserted into the
linked list. Makes sense.

> -	m = load_multi_pack_index(r, object_dir, local);
> +	if (source->multi_pack_index)
> +		return 1;
>  
> +	m = load_multi_pack_index(r, source->path, local);
>  	if (m) {
>  		struct multi_pack_index *mp = r->objects->multi_pack_index;
>  		if (mp) {
>  			m->next = mp->next;
>  			mp->next = m;
> -		} else
> +		} else {
>  			r->objects->multi_pack_index = m;
> +		}
> +		source->multi_pack_index = m;

We still insert the multi-pack index into the list, but more importantly
we now store it in the source it pertains to. It is a bit awkward that
source now points to a list of midx when we really only care about the
first entry, but I suspect that will be addressed later in the series by
doing away with the list entirely.

> +
>  		return 1;
>  	}
>  
> @@ -837,6 +838,8 @@ void clear_midx_file(struct repository *r)
>  	if (r->objects && r->objects->multi_pack_index) {
>  		close_midx(r->objects->multi_pack_index);
>  		r->objects->multi_pack_index = NULL;
> +		for (struct odb_source *source = r->objects->sources; source; source = source->next)
> +			source->multi_pack_index = NULL;
>  	}
>  
>  	if (remove_path(midx.buf))
> diff --git a/midx.h b/midx.h
> index 9d1374cbd58..b1626a9a7c4 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -3,11 +3,12 @@
>  
>  #include "string-list.h"
>  
> +struct bitmapped_pack;
> +struct git_hash_algo;
>  struct object_id;
> +struct odb_source;
>  struct pack_entry;
>  struct repository;
> -struct bitmapped_pack;
> -struct git_hash_algo;
>  
>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>  #define MIDX_VERSION 1
> @@ -123,7 +124,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
>  int midx_contains_pack(struct multi_pack_index *m,
>  		       const char *idx_or_pack_name);
>  int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
> -int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
> +int prepare_multi_pack_index_one(struct odb_source *source, int local);
>  
>  /*
>   * Variant of write_midx_file which writes a MIDX containing only the packs
> diff --git a/odb.h b/odb.h
> index e922f256802..8e79c7be520 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -9,10 +9,11 @@
>  #include "string-list.h"
>  #include "thread-utils.h"
>  
> +struct multi_pack_index;
>  struct oidmap;
>  struct oidtree;
> -struct strbuf;
>  struct repository;
> +struct strbuf;
>  
>  /*
>   * Compute the exact path an alternate is at and returns it. In case of
> @@ -55,6 +56,13 @@ struct odb_source {
>  	/* Map between object IDs for loose objects. */
>  	struct loose_object_map *loose_map;
>  
> +	/*
> +	 * private data
> +	 *
> +	 * should only be accessed directly by packfile.c and midx.c
> +	 */
> +	struct multi_pack_index *multi_pack_index;
> +
>  	/*
>  	 * This is a temporary object store created by the tmp_objdir
>  	 * facility. Disable ref updates since the objects in the store
> @@ -75,7 +83,6 @@ struct odb_source {
>  };
>  
>  struct packed_git;
> -struct multi_pack_index;
>  struct cached_object_entry;
>  
>  /*
> diff --git a/packfile.c b/packfile.c
> index af9ccfdba62..16efc2fdca3 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -372,6 +372,8 @@ void close_object_store(struct object_database *o)
>  	if (o->multi_pack_index) {
>  		close_midx(o->multi_pack_index);
>  		o->multi_pack_index = NULL;
> +		for (struct odb_source *source = o->sources; source; source = source->next)
> +			source->multi_pack_index = NULL;

Ok, so cleanup of the multi-pack index is still handled by recursively
iterating through the global list via `cose_midx()`, but we now unset
the midx in each source. Looks good.

-Justin

>  	}
>  
>  	close_commit_graph(o);
> @@ -1037,7 +1039,7 @@ static void prepare_packed_git(struct repository *r)
>  	odb_prepare_alternates(r->objects);
>  	for (source = r->objects->sources; source; source = source->next) {
>  		int local = (source == r->objects->sources);
> -		prepare_multi_pack_index_one(r, source->path, local);
> +		prepare_multi_pack_index_one(source, local);
>  		prepare_packed_git_one(r, source->path, local);
>  	}
>  	rearrange_packed_git(r);
> 
> -- 
> 2.50.1.327.g047016eb4a.dirty
> 
> 
