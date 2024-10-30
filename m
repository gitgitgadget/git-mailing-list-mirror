Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3841E9064
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323379; cv=none; b=DELV3Ol0aAg8rgybYHNRb+9JOVplY3zp8vRR6aHm4e2ngNK1AWd/eIyxNJxrGBim83HFQDA8ohun1n6O4ztQ8PFlE4Uu/OefjTPyDe1dM4J3Qv1sN6jXKrcMhID6f72c/e+YHkSC8uK8N5VWUvZd8r/l8+AB61q41T3BC6U85mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323379; c=relaxed/simple;
	bh=zX23I6ZJ2Qbl4iDYcuKsNh4goYz3uMWe4XgX1XFwN7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBqR++mXpywfDqjbYOQ1Yau3b7lsuix8tg9n6oKpqRF+8yXNgJrr68MjUuTTnzSZ6Q5RAiC3/h9x+7fzY324jWSWFqvFJM9TuMbdFzy9fMIVzdg+9C5+3VkdSKDG9tYMY5IaohVfagRCPZMg6dzRDWZA4vftDx3cReR0/5nKcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38qKK9A+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38qKK9A+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca03687fdso25855ad.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730323377; x=1730928177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmwOhEVliv5gUZSsADKUgRFMW+A/rgX1vRIwfbPlvps=;
        b=38qKK9A++dcGvYj7+znzZ+SvGFhs8+s5zzkHiK8Qi5aiTd+ebd6pbIA8EdMpTfWrDX
         b80NJV7Am204Rubg2EoNPfLeOjVuYaiE8Bj/945FfLsHqXeNvnH8dSBSZmmK0QxHl6ls
         EUOe8p9FGsuUpdj4l9MfxEmO6aprTr2mamcabUyu3igv671SjTh268kuwUSFNVI11oUg
         gVCGVK2afpnPZN0yWI+Mx1qKG97YQrlHj2LVX8Zx0Qd+bf0lYetxexJh/YbCigDfitIp
         ZNoAk9ItwXkLcj7wJqMCZszABfztWria+Wz2UTgWTjhycNqlyfKjxh79eULK9BGgk/NP
         y5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323377; x=1730928177;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmwOhEVliv5gUZSsADKUgRFMW+A/rgX1vRIwfbPlvps=;
        b=pdgrYC7POx6WQ5D+LdiaPMQwui1J1a4uwyObmJoGc9vcq8VMcCBxTOhxaUVCOiQ+mT
         /4XdiGNnyI9LsxfdPkVNmjBJkJKD3cGiMNm1MScWxxML8i4E+0G3N9Z/4nwlqxMeM3Oo
         9fPjE3/PB5m2NWQQWazb3omwZvETtrqWItfGEsagyOjdr1vRaLXLJJi58gdb+TAk1KEJ
         9Rtr6cGob5ugcb8/bnHhq6RAGPAWoo7am67ljbAAhehnT9ko/dj3LsbXYshibpABAmpi
         3bHR+jFpK5naCfXqd74NxvtR8dqaHgjNSOkyx7sAJT2k0SEDq59yYGAkjUdwLMT2LcYA
         tiVA==
X-Gm-Message-State: AOJu0YwL+j8Av3KVMqlozFbeH5LwYRFn8C2pHr3YRTAiQDRCfhNGy9Ej
	1Okq/ssbErLglofFFIRSNbVUDa9x6ASspceOOeqQtMmLpQLMpinvhU/E19BUjiemG5GWbRUBYk6
	Hsg==
X-Gm-Gg: ASbGncvQEAoJQR4hRal8hTzJ7/probNTPxr4zwccpsTAeAAGAbi59BpMoQt5cE5R2JI
	hiFQZV5CQAwPBbpBqcLmAGOW8bemgT/g3b2udUFJjp5IH0sp7K4MG9QIlkX2bCVAzQqexTvFn2F
	lpUvmFw8YHEA3sLfkgLC5kjL3LvqVJaFWPWQX17lmvPVfoTIYKXpifAxfYPcOTLCGLcn3PcrcTt
	e2Q/CGhVtge/0K6WnJM2rBPEaf/+f1laSdu1/ckjHj53lll
X-Google-Smtp-Source: AGHT+IHkYSzlHBmLBy1m68zasY+1rrpxbtoKIrQjdgh7snubn8goEpRFsIpccWTNt+dpr29J2hb71A==
X-Received: by 2002:a17:902:ea04:b0:20c:e8df:2500 with SMTP id d9443c01a7336-21105425e13mr252925ad.3.1730323376761;
        Wed, 30 Oct 2024 14:22:56 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e2cb:194a:36bf:6b07])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1eb391sm77782b3a.57.2024.10.30.14.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:22:56 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:22:52 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch-pack: warn if in commit graph but not obj db
Message-ID: <bzhg2a7mv2xrbahk6o5kpijx4dxmpkm4wrrjhatetowjdowout@hesucnp6cikf>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20241003223546.1935471-1-emilyshaffer@google.com>
 <cover.1730235646.git.jonathantanmy@google.com>
 <1027ff2cb7d9af5cc9ce6b653d28150457db8703.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027ff2cb7d9af5cc9ce6b653d28150457db8703.1730235646.git.jonathantanmy@google.com>

On 2024.10.29 14:11, Jonathan Tan wrote:
> When fetching, there is a step in which sought objects are first checked
> against the local repository; only objects that are not in the local
> repository are then fetched. This check first looks up the commit graph
> file, and returns "present" if the object is in there.
> 
> However, the action of first looking up the commit graph file is not
> done everywhere in Git, especially if the type of the object at the time
> of lookup is not known. This means that in a repo corruption situation,
> a user may encounter an "object missing" error, attempt to fetch it, and
> still encounter the same error later when they reattempt their original
> action, because the object is present in the commit graph file but not in
> the object DB.
> 
> Therefore, detect when this occurs and print a warning. (Note that
> we cannot proceed to include this object in the list of objects to
> be fetched without changing at least the fetch negotiation code:
> what would happen is that the client will send "want X" and "have X"
> and when I tested at $DAYJOB with a work server that uses JGit, the
> server reasonably returned an empty packfile. And changing the fetch
> negotiation code to only use the object DB when deciding what to report
> as "have" would be an unnecessary slowdown, I think.)
> 
> This was discovered when a lazy fetch of a missing commit completed with
> nothing actually fetched, and the writing of the commit graph file after
> every fetch then attempted to read said missing commit, triggering a
> lazy fetch of said missing commit, resulting in an infinite loop with no
> user-visible indication (until they check the list of processes running
> on their computer). With this fix, at least a warning message will be
> printed. Note that although the repo corruption we discovered was caused
> by a bug in GC in a partial clone, the behavior that this patch teaches
> Git to warn about applies to any repo with commit graph enabled and with
> a missing commit, whether it is a partial clone or not.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 22 +++++++++++++++++++---
>  object.h     |  2 +-
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6728a0d2f5..5a0020366b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -57,6 +57,7 @@ static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
>  #define ALTERNATE	(1U << 1)
>  #define COMMON		(1U << 6)
>  #define REACH_SCRATCH	(1U << 7)
> +#define COMPLETE_FROM_COMMIT_GRAPH	(1U << 8)

We're defining a new flag, and we note it in object.h as well below, so
looks good so far.


>  /*
>   * After sending this many "have"s if we do not get any new ACK , we
> @@ -123,15 +124,18 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
>  }
>  
>  static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
> -					       int mark_tags_complete)
> +					       int mark_additional_complete_information)

We're already marking some completion flags here, so we're just making
the parameter name more descriptive, OK.


>  {
>  	enum object_type type;
>  	struct object_info info = { .typep = &type };
>  	struct commit *commit;
>  
>  	commit = lookup_commit_in_graph(the_repository, oid);
> -	if (commit)
> +	if (commit) {
> +		if (mark_additional_complete_information)
> +			commit->object.flags |= COMPLETE_FROM_COMMIT_GRAPH;
>  		return commit;
> +	}

We already have a case where we're checking the commit graph, so we can
also mark the commit complete here... well, not the original "COMPLETE"
flag since we don't want to change behavior, but our new
COMPLETE_FROM_COMMIT_GRAPH flag. Sounds good.


>  
>  	while (1) {
>  		if (oid_object_info_extended(the_repository, oid, &info,
> @@ -143,7 +147,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>  
>  			if (!tag->tagged)
>  				return NULL;
> -			if (mark_tags_complete)
> +			if (mark_additional_complete_information)
>  				tag->object.flags |= COMPLETE;
>  			oid = &tag->tagged->oid;
>  		} else {
> @@ -809,6 +813,14 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	save_commit_buffer = old_save_commit_buffer;
>  }
>  
> +static void warn_in_commit_graph_only(const struct object_id *oid)
> +{
> +	warning(_("You are attempting to fetch %s, which is in the commit graph file but not in the object database."),
> +		oid_to_hex(oid));
> +	warning(_("This is probably due to repo corruption."));
> +	warning(_("If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object."));
> +}
> +

Here's the new warning. As mentioned in my reply to the cover letter, I
feel like it makes more sense to die(), but I don't feel too strongly
about it.


>  /*
>   * Returns 1 if every object pointed to by the given remote refs is available
>   * locally and reachable from a local ref, and 0 otherwise.
> @@ -830,6 +842,10 @@ static int everything_local(struct fetch_pack_args *args,
>  				      ref->name);
>  			continue;
>  		}
> +		if (o->flags & COMPLETE_FROM_COMMIT_GRAPH) {
> +			if (!has_object(the_repository, remote, 0))
> +				warn_in_commit_graph_only(remote);
> +		}

And now that we're checking what's local, we issue our warning if we
have an object missing from the DB but mentioned in the commit graph.
Seems fine, although I wonder if it makes more sense to fail earlier. It
looks like the only place we do the
`mark_additional_complete_information` checks is in `mark_complete()`,
so should we just check this condition there? No strong feelings either
way, just curious.


>  		print_verbose(args, _("already have %s (%s)"), oid_to_hex(remote),
>  			      ref->name);
>  	}
> diff --git a/object.h b/object.h
> index 17f32f1103..196e489253 100644
> --- a/object.h
> +++ b/object.h
> @@ -65,7 +65,7 @@ void object_array_init(struct object_array *array);
>  /*
>   * object flag allocation:
>   * revision.h:               0---------10         15               23------27
> - * fetch-pack.c:             01    67
> + * fetch-pack.c:             01    6-8
>   * negotiator/default.c:       2--5
>   * walker.c:                 0-2
>   * upload-pack.c:                4       11-----14  16-----19
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
> 
