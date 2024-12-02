Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4521DF27F
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174699; cv=none; b=ct6hlmT8VBz6WIEshV6z5lHVvQbbi1R+7Jl3W9fYfkR1ddUdz2UI8fBbE6iojNFoMURDUhuWk81QwxP5lEZrWytPNJ6FHbSDtAvoMeQ89VZJGaXiMGsmUBQHcGnwYI7rIkloGtmYQbv72J+Sioc25sJNNQG4MfdR3JTRy5aeB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174699; c=relaxed/simple;
	bh=n4PEAGNCx8TnApBMVLxnCi9GGrx+P0Rknqth9iNOes4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiwgClCXwIK/jnXoxw5F02l8N9C/G4mTeNXNO/m1cY+qjV2WDq8orKFVh3wTv1XnCf3OXGZVS060EFtKkLg0LLoM2CoV6WPt0AoJV/k8MPo7MncjjRB4kfo5KN5e6UIfVJIhHvfquz22+xnKMwUilfubXH8JrwnsCUpYsE7BKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IILgzhv8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IILgzhv8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21561f7d135so7965ad.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733174698; x=1733779498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5YnWNHiIsGV/iEcE8P1U9oeduYffuJ3D7stgjFbrkA=;
        b=IILgzhv8d8Vpx7Eeas8BMjHOsQbfsbxWTnoLGc7VoXsycQr5R5J14J/b2O55vrhN8h
         R9/O2yxWYIgi9YhXny31locPwKwKpev8TUFdgUscCx2pd6ZkORKmXQTe481tll8jXETv
         M1SDHxkJLfxRaNI0GFkagdrYDdoQJIoum9/G9eG1RPet2je+6Q9V+RN+9/+z8eW3Mrcg
         dupK7FYM0YTh/RwHhN0lh1DV95nTczKOikc2HO27ipfKrUKyano1VcT1vKPk9OWsXQfX
         TgD4S9Mbk4VmdyBU9R2+Yd1cn+VyTMdlsEMYZ8vflHxvs0YBayxBM8FD2N5jkblDkTWO
         NeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174698; x=1733779498;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5YnWNHiIsGV/iEcE8P1U9oeduYffuJ3D7stgjFbrkA=;
        b=T2ICZ95zuX0Px8QLG+hNVic0EanpkuneZDb15cOpA8+Gij9SbCUqnHFQ2hxTd498sc
         FF/vAKbOA48UPSAkMsDiS9ujN9fQpqzdDHoe3/DpD3j6KoUsJBV2XUpfbuBrOVo2OQDK
         43M9wFxdCdPrSRQy9nNpSUu7VrrxHRRFGXyDfs+/EJfa3G8njdsjvgjyV02QH5sRyM14
         fxFwcXuJ8hykUrdGHAwzEeC4LSgW7EyCg0zUEJABxG72F8E/XULe7KccPrKZmZmDTJr+
         6cv7Mx3jIIQSU0DWH36oOekLNm+O81IcI8mCNobFh1D4cx/Nzf4xG3qoUrpWnIpoC5wK
         qKvA==
X-Gm-Message-State: AOJu0Yx5c/Km5rW2pcNvTQlf4CggZwiqBnnhCmfyH0mktF4mULDBYq8u
	oCNLlBqTRB2gSzMSKIZ6z4mCIQOa+tlkDjsxqie1JbWg1dADksJ33/4NLN26s39oz8MDy/E9Jqd
	e6g==
X-Gm-Gg: ASbGnctapGkXXgewK7JZFyroOJWle5SVGe/ThzPs7t44JHpH0/AD8AxaH9VCLqMC6pl
	KSbWUzhTCyLuJaMaGxgkfNm9AglBWln4z/w+7Sh5knE2SQ0r3lfrh4brsBbCsp28aOukj3Kkwek
	ugOB6XaoXHqFbAYgg0Dd2WIzT8yDVeqk579kdXTcJ7IveH0Enb9F9O1i2ZwOKcft0YHs7WWn6/U
	tg5kCPnUitwsmPPPcM0RxDN6SdMDcs84Oeh6p9qUJvttUw=
X-Google-Smtp-Source: AGHT+IHuTwo22Ir+U0NZVWbsPoSbs4ebQlzB5KGcZdmJVVHljKcv6uWRWFsrPbJd0MhT65pQLCdYuw==
X-Received: by 2002:a17:903:144f:b0:20c:e169:eb8c with SMTP id d9443c01a7336-215bbb2f680mr114245ad.1.1733174697466;
        Mon, 02 Dec 2024 13:24:57 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:bc36:4054:556:4546])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeaf0b3b44sm3246985a91.8.2024.12.02.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:24:56 -0800 (PST)
Date: Mon, 2 Dec 2024 13:24:52 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, hanyang.tony@bytedance.com
Subject: Re: [PATCH 1/3] index-pack: dedup first during outgoing link check
Message-ID: <p5ctagmbwo6qp7ocozx4chitw7byy6yjma4unoebbrfr365ywp@jkdlk3g7fchz>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, hanyang.tony@bytedance.com
References: <cover.1733170252.git.jonathantanmy@google.com>
 <5f0f114dbdf00fe246308490f09b649bd8de242c.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0f114dbdf00fe246308490f09b649bd8de242c.1733170252.git.jonathantanmy@google.com>

On 2024.12.02 12:18, Jonathan Tan wrote:
> Commit c08589efdc (index-pack: repack local links into promisor packs,
> 2024-11-01) fixed a bug with what was believed to be a negligible
> decrease in performance [1] [2]. But at $DAYJOB, with at least one repo,
> it was found that the decrease in performance was very significant.
> 
> Looking at the patch, whenever we parse an object in the packfile to
> be indexed, we check the targets of all its outgoing links for its
> existence. However, this could be optimized by first collecting all such
> targets into an oidset (thus deduplicating them) before checking. Teach
> Git to do that.
> 
> On a certain fetch from the aforementioned repo, this improved
> performance from approximately 7 hours to 24m47.815s. This number will
> be further reduced in a subsequent patch.
> 
> [1] https://lore.kernel.org/git/CAG1j3zGiNMbri8rZNaF0w+yP+6OdMz0T8+8_Wgd1R_p1HzVasg@mail.gmail.com/
> [2] https://lore.kernel.org/git/20241105212849.3759572-1-jonathantanmy@google.com/
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 95babdc5ea..8e7d14c17e 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -155,11 +155,11 @@ static int input_fd, output_fd;
>  static const char *curr_pack;
>  
>  /*
> - * local_links is guarded by read_mutex, and record_local_links is read-only in
> - * a thread.
> + * outgoing_links is guarded by read_mutex, and record_outgoing_links is
> + * read-only in a thread.
>   */
> -static struct oidset local_links = OIDSET_INIT;
> -static int record_local_links;
> +static struct oidset outgoing_links = OIDSET_INIT;
> +static int record_outgoing_links;
>  
>  static struct thread_local_data *thread_data;
>  static int nr_dispatched;

We're renaming the oidset and flag because our purpose is now more
general. OK.


> @@ -812,18 +812,12 @@ static int check_collison(struct object_entry *entry)
>  	return 0;
>  }
>  
> -static void record_if_local_object(const struct object_id *oid)
> +static void record_outgoing_link(const struct object_id *oid)
>  {
> -	struct object_info info = OBJECT_INFO_INIT;
> -	if (oid_object_info_extended(the_repository, oid, &info, 0))
> -		/* Missing; assume it is a promisor object */
> -		return;
> -	if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
> -		return;
> -	oidset_insert(&local_links, oid);
> +	oidset_insert(&outgoing_links, oid);
>  }

We're now unconditionally recording linked objects, and this logic has
been moved below. Looks good.


> -static void do_record_local_links(struct object *obj)
> +static void do_record_outgoing_links(struct object *obj)
>  {
>  	if (obj->type == OBJ_TREE) {
>  		struct tree *tree = (struct tree *)obj;
> @@ -837,16 +831,16 @@ static void do_record_local_links(struct object *obj)
>  			 */
>  			return;
>  		while (tree_entry_gently(&desc, &entry))
> -			record_if_local_object(&entry.oid);
> +			record_outgoing_link(&entry.oid);
>  	} else if (obj->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *) obj;
>  		struct commit_list *parents = commit->parents;
>  
>  		for (; parents; parents = parents->next)
> -			record_if_local_object(&parents->item->object.oid);
> +			record_outgoing_link(&parents->item->object.oid);
>  	} else if (obj->type == OBJ_TAG) {
>  		struct tag *tag = (struct tag *) obj;
> -		record_if_local_object(get_tagged_oid(tag));
> +		record_outgoing_link(get_tagged_oid(tag));
>  	}
>  }
>  
> @@ -896,7 +890,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  		free(has_data);
>  	}
>  
> -	if (strict || do_fsck_object || record_local_links) {
> +	if (strict || do_fsck_object || record_outgoing_links) {
>  		read_lock();
>  		if (type == OBJ_BLOB) {
>  			struct blob *blob = lookup_blob(the_repository, oid);
> @@ -928,8 +922,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  				die(_("fsck error in packed object"));
>  			if (strict && fsck_walk(obj, NULL, &fsck_options))
>  				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
> -			if (record_local_links)
> -				do_record_local_links(obj);
> +			if (record_outgoing_links)
> +				do_record_outgoing_links(obj);
>  
>  			if (obj->type == OBJ_TREE) {
>  				struct tree *item = (struct tree *) obj;
> @@ -1781,7 +1775,7 @@ static void repack_local_links(void)
>  	struct object_id *oid;
>  	char *base_name;
>  
> -	if (!oidset_size(&local_links))
> +	if (!oidset_size(&outgoing_links))
>  		return;
>  
>  	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
> @@ -1795,8 +1789,14 @@ static void repack_local_links(void)
>  	if (start_command(&cmd))
>  		die(_("could not start pack-objects to repack local links"));
>  
> -	oidset_iter_init(&local_links, &iter);
> +	oidset_iter_init(&outgoing_links, &iter);
>  	while ((oid = oidset_iter_next(&iter))) {
> +		struct object_info info = OBJECT_INFO_INIT;
> +		if (oid_object_info_extended(the_repository, oid, &info, 0))
> +			/* Missing; assume it is a promisor object */
> +			continue;
> +		if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
> +			continue;
>  		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
>  		    write_in_full(cmd.in, "\n", 1) < 0)
>  			die(_("failed to feed local object to pack-objects"));

We've moved our logic to skip promisor objects here, after potential
objects have been recorded to the oidset and thus deduped. Now we
`continue` the loop to skip promisor objects, whereas before we had an
early return to avoid recording them in the first place. Seems
straightforward.

> @@ -1899,7 +1899,7 @@ int cmd_index_pack(int argc,
>  			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
>  				; /* nothing to do */
>  			} else if (skip_to_optional_arg(arg, "--promisor", &promisor_msg)) {
> -				record_local_links = 1;
> +				record_outgoing_links = 1;
>  			} else if (starts_with(arg, "--threads=")) {
>  				char *end;
>  				nr_threads = strtoul(arg+10, &end, 0);
> -- 
> 2.47.0.338.g60cca15819-goog
> 
> 
