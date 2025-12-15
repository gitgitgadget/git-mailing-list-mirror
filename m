Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2F232395
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834251; cv=none; b=T/3/WBzDxpg/uulEr9qHyVilYA5UNXVIYMPkMVudHy1kgcL3wFM9QBwSRMOhIaZoe+VdLh25K4cTr8miaX7hxKgO+DRJdT45X9THhhIBu0NXsJHb9s0p7TYey20ZcL3EiXgcD0bq6/4rrCW/lhChf7hSJGI2fjNeLBOO+nZ5Ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834251; c=relaxed/simple;
	bh=ZV6V5XsIVOBb8tPHsIi0wOa2xdMh0VIaxDRmdveTmcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6Jx57OxxZ6rTXwPGmCsdy6E4Vx6rAsBfSq3ZSOTsoyyZgZALQWymlJdncjlgRBUjv7khGaXmqg1FIfsplzputy+K5E4kZ+i1epdKznJDhZGv0JjNdglk/ahDbkc1WBFpQJZ/sVBKV6zVa6Nk1k0quOxDjAwqqkjiwPaLik7at8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKpYip7+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKpYip7+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4557e6303a5so930590b6e.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 13:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765834248; x=1766439048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uiOKssm+iX+4wgH8487yojARLH4D72LmGBBwCuPmYE=;
        b=UKpYip7+ByXOJgTezG3WWr9NniA29QgSzCXOsaqVZbvJkqyMCweR4hLcvHp3G86sAF
         nRmCup3aVVZLWvJCja4yj3JccRc8cqeECVumQZhzbi39aJMWHhBNaUKsR/mfoRwv57eW
         P8YapwLtkMm4M+lRIK3o+SBKRPozzu8xArAdl0H5eDtz4vOekuRmNZY1enTz0QErOUVa
         j76UJiCrwKS3jjP5eZ8Ri82zh1S4/83lv7ICseBBIa1Nw8QfElBMr6yblypFgn5AAzZW
         6YNqPDAjIRC14blhcxR8pn2Xd4/3pGh7/+no25DIozuxFyqhSU/YbxzUyI8JyysGi556
         zXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765834248; x=1766439048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uiOKssm+iX+4wgH8487yojARLH4D72LmGBBwCuPmYE=;
        b=cBFifaeotbi1dJOqbM6xXSiRt0LVrn0i5lOOQURrIYgca2ADMniKopqDDpK7Xy5ZRv
         crNq46dXauCMmvzxcRJZUXOAHjCSksYeZI1WAtC855CRWTXLMDVSD2DQnPh+woM8EhYi
         UmrKUz2j2hxmwtRA8H7RKXM+ME6pXMKV7gkaTaCifqNaL8pIrGH59Ly7FWtRZIvc59HN
         AlQRDs6Kw+xuR6EP7VbmuKiXheNpythANWUqydZ3RA3z3x935A9U511kmhVTVhpauSZs
         J9+vFK/StAzjkhBLhzklm3JhE2YE6Ptgu88MwnnaDjflFUkD0jpr/v9kBwu19DhJvaCE
         fFoA==
X-Gm-Message-State: AOJu0YxpXBr0S3BN7uSOdR96muopGqU9HmiAjAN7wEEyD0eDKdUS+gGq
	FnwHqdz+MMNg0yumJ07kt4drSGY8nms/7DerhjxUYMWxlnUC1njbrhnt0TiqHw==
X-Gm-Gg: AY/fxX4Lv1asTRf3Wa7qbdECA+TnANNHFKroz/BHDLmpF/eaGyNFbcg70eLopdkeEVA
	w29UNfYy6w8XNTFEwWh/yfWofQJd/ZbdAk86Lf2qITpKX4D339dvbO/8f1WFd1YUVMVdF3FptHP
	CgRwurMf7Ws6hicZ/ZWCIOK1AlotMctHWqyCmrpge/TvY6teGhRX4t7InG5mRj5mTNkuBXE/+Hu
	vZ5h67SergYRy29cGkRH2zDffiR4hZQaBi7y5pgm12Pfm+EhU4rj+q/HyjsgGBi8sBzD9MOEOwl
	FDQsLPCOPQWkSGhre/hYSYJmLspJp1a/vTKFQPIhEvirpDanThXiCl10hnaqWMA1Jj52lDuQp0M
	Zqzuo2Mvn3SIpWAAVxyY0JjHqykIaquGkni1p59nyHVhjNGa898dWnXhqUfQU/dTkyz0CYUSoL1
	6hovaM6pyi5Sf5xRA=
X-Google-Smtp-Source: AGHT+IG/MMzlEvWaihQolH/5SU6zAcst+qYTyn4bwjtKSAYjw+rHCfXocB+2e3xMoj+sFa62MM66Pw==
X-Received: by 2002:a05:6808:6a82:b0:450:3584:cda5 with SMTP id 5614622812f47-455aca0c2dbmr6717054b6e.55.1765834247907;
        Mon, 15 Dec 2025 13:30:47 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598b9966dsm7259012b6e.9.2025.12.15.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:30:47 -0800 (PST)
Date: Mon, 15 Dec 2025 15:30:44 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] packfile: create store via its owning source
Message-ID: <7rbnw67kn3xe3mpkpssiy22ewvjihzteole3sjhosocqo4sr7a@cig7o2dauljd>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-1-433aac465295@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-1-433aac465295@pks.im>

On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> In subsequent patches we're about to move the packfile store from the
> object database layer into the object database source layer. Once done,
> we'll have one packfile store per source, where the source is owning the
> store.
> 
> Prepare for this future and refactor `packfile_store_new()` to be
> initialized via an object database source instead of via the object
> database itself.

Makes sense.

> This refactoring leads to a weird in-between state where the store is
> owned by the object database but created via the source. But this makes
> subsequent refactorings easier because we can now start to access the
> owning source of a given store.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/packfile.c b/packfile.c
> index c88bd92619..0a05a10daa 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -876,7 +876,7 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
>  
>  	p = strmap_get(&store->packs_by_path, key.buf);
>  	if (!p) {
> -		p = add_packed_git(store->odb->repo, idx_path,
> +		p = add_packed_git(store->source->odb->repo, idx_path,
>  				   strlen(idx_path), local);
>  		if (p)
>  			packfile_store_add_pack(store, p);
> @@ -1068,8 +1068,8 @@ void packfile_store_prepare(struct packfile_store *store)
>  	if (store->initialized)
>  		return;
>  
> -	odb_prepare_alternates(store->odb);
> -	for (source = store->odb->sources; source; source = source->next) {
> +	odb_prepare_alternates(store->source->odb);
> +	for (source = store->source->odb->sources; source; source = source->next) {

huh so IIUC, even though there is a packfile store per ODB source, we
will add the alternate sources to the same packfile store? This is feels
very awkward, but is maybe part of the "weird in-between state" you
mentioned in the commit message.

>  		prepare_multi_pack_index_one(source);
>  		prepare_packed_git_one(source);
>  	}
[snip]
> diff --git a/packfile.h b/packfile.h
> index 59d162a3f4..33cc1c1654 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -77,7 +77,7 @@ struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
>   * A store that manages packfiles for a given object database.
>   */
>  struct packfile_store {
> -	struct object_database *odb;
> +	struct odb_source *source;

The packfile store now stores a reference to the object source instead
of the ODB itself. The ODB source has a reference to the ODB so
callsites that were orginally referencing the ODB can still go through
the source. Makes sense.

>  	/*
>  	 * The list of packfiles in the order in which they have been most
> @@ -129,9 +129,9 @@ struct packfile_store {
>  
>  /*
>   * Allocate and initialize a new empty packfile store for the given object
> - * database.
> + * database source.
>   */
> -struct packfile_store *packfile_store_new(struct object_database *odb);
> +struct packfile_store *packfile_store_new(struct odb_source *source);

The packfile store is now initialized with the ODB source. Looks good.

-Justin
