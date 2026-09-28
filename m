Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7248C3E3
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587137; cv=pass; b=c68HK92f4s96QF3bmN0mePqQjFCCYqvFIG9cC/CAkaBoAm3M2I7pEJrb0SqSQ4lQax3jHt+LNy2/is69Lt3NLWy/l6GOGf3EBtVbLUvSmA/SFrSdoU2om8I1bru0SuYIJ8B2q65CZzYDJ4AM1yXIYq4aoIpMXYREc9NngLib+xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587137; c=relaxed/simple;
	bh=lBvAogz3c9Yvgue1Na4oq6ylwBfgNoFuo3EMuDeIE3c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=dt462RWy4zS4n5viYbwVzuDhhWOAAPret0jSxjJrzEitT5gFmfs8OCQJk6PDRrpaqbxgBZiE4C1uAmhu8x5TVa67lPQ4GwZPWzJ1ICdNo44dF765L7K8X/vn1CNif35eRn+OT7OXGiWNwK167oRWaJJLqTwVPlbf0XGT4N/kLWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY6BYJWn; arc=pass smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY6BYJWn"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-986e0b83340so1752347241.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 02:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790587135; cv=none;
        d=google.com; s=arc-20260327;
        b=RP0o667e5rvzKSSvsyLWEf85flLNS7R3B4zGiaDzttmvoxWcwHsbuI7Vvg8jaAHcoF
         Y4jPdwqP0vWYzlsrv6Hg8JESQiY0mQpjAgmklmeeGPQJe/MFEeCVfYDTRdpraSbPR1nr
         N4ndtDoL9GD7zDtSi4bLPUhlOhJ9ym1k0H+cEsfDi3PM/t3lAfIc53foAcTPqBNaZ1If
         wUKRDW41hjdoUlrAv3hb5Uojjdp2iRDdDPAZskIS2K59JWoHCWxV5Sks4SjesbXKHf+F
         DnThfTPqGfQyO3yL3lp7JadJ5ob2e2GxBvjCVhbc9kAccl4lZJEYaofBGPljLTCDtpmR
         hRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=FvIqFkDcKzZavElWX/dgekBl+h5bovMY8eoFjmwmviw=;
        fh=qes495DYmYfjCbJH35T9Q8ZMZogvUXWP0pOvGj1YMQ4=;
        b=IKqF5uaIDjH541cG6zI4TKPUVbJRbJvAGqYjjtC8p3yiUZ6D2C2ceaLyITLcdPIbp2
         kKQdSBfkpHIn1PiI+aJdN5p6ULNx5rX4hSuNrtlWkdG2VvibqK4m7BxESUNbnJ20NT/r
         e0uXwZJaFvV5pRu174atKguVVbQlyWH+apQqNDXG61kkl13MT4jClHc6QivC+jn+GdDE
         Kit369TuBNEolh5l84yvuSq4YZXCdUCHVXo6SEe9Lc30p59tTq9iMvqgJIc5G+uLdE8J
         juBL4lMaPQE1eR6gAt3rS1flq+fu7t4uwbcPLkFuyUxYmvL2seuqcWfAjGpyOGma7z9v
         fCrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790587135; x=1791191935; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvIqFkDcKzZavElWX/dgekBl+h5bovMY8eoFjmwmviw=;
        b=nY6BYJWnqWXWc9/WemuNKgWw1ZTDB8qiwroIu3vJ2bRb5uDl9SqcNNkMVk053z0YvA
         M8XeNmJ6OxlX6VWoccDVwb3fP2pzMwnIozhlgcWxmhmB1Jqmzl1bezBJRRvqNk1K9kn3
         9qLLaGCB3U5F6bgLE1NMdox+3U7TH8QYF/TImdd07HLpwGdp/makPBkQ/U+8dQAaNXn6
         BayLbBqBYXmar2rSjnvfym4U0hJLvdv7GfxjlOpsBi7PdTFxWMXfC0n5m8aSkwE4hL1V
         DriFnB02is8RTGTUfklAi1QrkK+11VdjWT3GT49YMl8d5SAtUPmKCcBRtK2ewZqxMAjx
         YBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587135; x=1791191935;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvIqFkDcKzZavElWX/dgekBl+h5bovMY8eoFjmwmviw=;
        b=hO3SQFAc4u54ZCopHlfSGhJYLV1aPg9lvasiNy2L64nHU2HjCgQBtE5zOmPTqhJQtl
         JzU7ro8mI5sKS/o6lz1SFv2EY4fWYcx+boeil/7OAHlyNLmkIgtNWTJTUA+51Kcn6tf6
         ddv3T8W35zm4dEq/OdSl2SQo9XQLa9KRTqxM3hCjzmGE/YwI4gvPTSbSYoB2mVvx2OuO
         ZDX/ziCgEAoMDT6p4JGxKchYzFVEX+hT0xYGSkrTcHju7Tc0hQtnSUraO1WD6ycaQVnz
         qmpEvCXKp/X2GxP3rcA1RCEtxvN/8Scekh6N9SnWKORFYNncBMB1D72HM5AJWZhq6XB0
         57nQ==
X-Forwarded-Encrypted: i=1; AKwUvBybI6A9iVaJDm6q6I49eY2KfTbpgY/GzWkbwOuIvfOIgSz9AwZJVLgfbN15b5SLRQCuX+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2JTqv3Mzi4TE08yJ8Hs5hKyXIZAjnuHzY6NOlB+mH9KxHLn5i
	TTF94kYymgd6srLOahVqY0W4o03Pr6duKNQNx1reERl6JTM9GYb5SNu5Xc+OIqY+paiKc6KB5EL
	m6w30DiV5oaeg/ngnOv2fOQ1EZulut4w=
X-Gm-Gg: AYBFou0n6CMp4Nc1p84QobsTcU+kgCXfD+lKjW+BgAVZ0SlrdlckFSw+Bj7/EqyXhug
	guj5zf0bYiUunCZmcTdDWx/oodO+7h+FGi7/kPQQTH13ey7+/41ZvXcj6v8kNTBtXrOPuckh5Ht
	wN5ZwuT+2a5AU/pd/NDvC9QiEIAqYpHkPq/WdPMPysk46Vy2B4IMDrtLX/LQZcbPMqEkLrGVnUR
	Ywf1GZd+IxoJY5eb3E8T7TnQg72MaWlpr5uKHxC+6DnYttu6oc01u6J8ez7EsufYmN+GtJXiFCn
	27SWlsS4tjKwfE0QHrzBD3Yig5R4b1R4fKBQtOsL6ROjGils439ZE3x4olJNBVFTvuCamWFn7s0
	qyPHCM81Orj+aYbKMU4qJUO/9Qi80AC5XVSkyJHYDmeeU
X-Received: by 2002:a05:6102:1916:b0:7b2:43df:ca61 with SMTP id
 ada2fe7eead31-7b243dfe7e9mr2311935137.30.1790587135013; Mon, 28 Sep 2026
 02:18:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 09:18:52 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 09:18:52 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-6-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-6-11499557cf31@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 09:18:52 +0000
X-Gm-Features: AclHuK9FrTglcKeLZCMZ4TKm6iLJReQ3X-WUeQ_fVk81ySzatC0_Z6QV81gjN6M
Message-ID: <CAOLa=ZQ_+Ofya1q01fpZjd_wDn=tk8YxbQWNxhFHya47hFRp-Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] repository: adapt `repo_clear()` to fully reset the repository
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001f58c9065c878e82"

--0000000000001f58c9065c878e82
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `repo_clear()` can be used to clear a repository's state.
> The way it's written though it's quite easy for it to accidentally leak
> some state because we don't make sure to clear the whole structure.
>
> Refactor the function to set the whole repository to all-zeroes to avoid
> any kind of leaking state. While at it, make it a bit more robust when
> called on an already-blank repository.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  repository.c | 37 ++++++++++++++++++-------------------
>  repository.h |  2 +-
>  2 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/repository.c b/repository.c
> index b857e1c580..e67ff00550 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -374,60 +374,57 @@ void repo_clear(struct repository *repo)
>  	struct hashmap_iter iter;
>  	struct strmap_entry *e;
>
> -	FREE_AND_NULL(repo->gitdir);
> -	FREE_AND_NULL(repo->commondir);
> -	FREE_AND_NULL(repo->prefix);
> -	FREE_AND_NULL(repo->graft_file);
> -	FREE_AND_NULL(repo->index_file);
> -	FREE_AND_NULL(repo->worktree);
> -	FREE_AND_NULL(repo->submodule_prefix);
> -	FREE_AND_NULL(repo->ref_storage_payload);
> +	free(repo->gitdir);
> +	free(repo->commondir);
> +	free(repo->prefix);
> +	free(repo->graft_file);
> +	free(repo->index_file);
> +	free(repo->worktree);
> +	free(repo->submodule_prefix);
> +	free(repo->ref_storage_payload);
>
>  	odb_free(repo->objects);
> -	repo->objects = NULL;
>
>  	if (repo->parsed_objects)
>  		parsed_object_pool_clear(repo->parsed_objects);
> -	FREE_AND_NULL(repo->parsed_objects);
> +	free(repo->parsed_objects);
>
>  	repo_settings_clear(repo);
>  	repo_config_values_clear(&repo->config_values_private_);
>
>  	if (repo->config) {
>  		git_configset_clear(repo->config);
> -		FREE_AND_NULL(repo->config);
> +		free(repo->config);
>  	}
>
> -	if (repo->submodule_cache) {
> +	if (repo->submodule_cache)
>  		submodule_cache_free(repo->submodule_cache);
> -		repo->submodule_cache = NULL;
> -	}
>
>  	if (repo->index) {
>  		discard_index(repo->index);
> -		FREE_AND_NULL(repo->index);
> +		free(repo->index);
>  	}
>
>  	if (repo->hook_config_cache) {
>  		hook_cache_clear(repo->hook_config_cache);
> -		FREE_AND_NULL(repo->hook_config_cache);
> +		free(repo->hook_config_cache);
>  	}
>  	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
>  	string_list_clear(&repo->disabled_events, 0);
>
>  	if (repo->promisor_remote_config) {
>  		promisor_remote_clear(repo->promisor_remote_config);
> -		FREE_AND_NULL(repo->promisor_remote_config);
> +		free(repo->promisor_remote_config);
>  	}
>
>  	if (repo->remote_state) {
>  		remote_state_clear(repo->remote_state);
> -		FREE_AND_NULL(repo->remote_state);
> +		free(repo->remote_state);
>  	}
>
>  	if (repo->refs_private) {
>  		ref_store_release(repo->refs_private);
> -		FREE_AND_NULL(repo->refs_private);
> +		free(repo->refs_private);
>  	}
>
>  	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
> @@ -439,6 +436,8 @@ void repo_clear(struct repository *repo)
>  	strmap_clear(&repo->worktree_ref_stores, 1);
>
>  	repo_clear_path_cache(&repo->cached_paths);
> +
> +	memset(repo, 0, sizeof(*repo));

The reason we swap `FREE_AND_NULL()` with `free()` is because we anyways
set everything to 0. Okay.

Or was this referring to the 'already blank' repository? Since
FREE_AND_NULL() can already handle NULL values.

>  }
>
>  int repo_read_index(struct repository *repo)
> diff --git a/repository.h b/repository.h
> index 11f5c2ed10..2a348012e8 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -258,6 +258,7 @@ void repo_set_ref_storage_format(struct repository *repo,
>  void initialize_repository(struct repository *repo);
>  RESULT_MUST_BE_USED
>  int repo_init(struct repository *r, const char *gitdir, const char *worktree);
> +void repo_clear(struct repository *repo);
>
>  /*
>   * Initialize the repository 'subrepo' as the submodule at the given path. If
> @@ -273,7 +274,6 @@ int repo_submodule_init(struct repository *subrepo,
>  			struct repository *superproject,
>  			const char *path,
>  			const struct object_id *treeish_name);
> -void repo_clear(struct repository *repo);
>

This is a purely cosmetic move to bring it closer to `repo_init()`,
right? I think it makes sense.

>  /*
>   * Populates the repository's index from its index_file, an index struct will
>
> --
> 2.56.0.rc2.329.gd58861e689.dirty

--0000000000001f58c9065c878e82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1557db1022ff9378_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xNk1Qb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWthREFDTFpCT05KSG5GS3VEZHhZYUVybW9XMS9hMQpNeWZESTY2NWc3
V2RrUVkvd2hVdmVkRkg5aGpXcitMWVZkNU8rbUdOZU91djRsYTZoQVkwTW9EMlF3eVU1dE9YCi8w
ek9ndzY3bzhFUnA0eVU4Z2NmU0w1UENIbzNLbnNmQTdmK2lMV0hnRXAyTGxPU1lIcGdDL1N3OGZX
K004d1YKYlB4dTIrRi9qMVFDbE1rODE0YjBUTmRtL1A2ZTl5a0ZzNEZISHpBNVNWc0p5SWsrM1RS
ZWRwaW5jVkZmUDlBVAorZmVHZktuRWp5U2ZURmpuTjhxOU4wcE9KU2VsUHpPQnhpUFpsTjg0SExh
Y1ZmNnpDUjlkQTh4b2xRZ0xYSmFVCmNWSjFBT1hrTUlXaXMzRGpJa3ZiUTRNWmYwbTJUUkl4R0V2
cGQ4d1lrbkwxcG5UV09acHlBQXVpUHV4ak1QdUQKZ2RIYWFZenQvWDZ6U0x3NlF2VVJtSVlncllN
UGdMZ2lKNEJ2VXo0bVVuZlJzTlVnSG5rQ1pzZ0FyZGtiaDc1Zwo3N3E3NTVQYm1oTVc2a1NKY0E4
ekdqRytFTVJQa0VGT2dEOCsvWDdMSElZV2pqcm0vQlVldG0xckl0T2lmWUVtClBJNDdCZFN2YVgr
ei9hVkZTcGlpeTRua3JEODN5RWEyajhRM3Q3cz0KPXVWRDUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001f58c9065c878e82--
