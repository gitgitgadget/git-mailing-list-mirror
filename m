Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F754F85C5
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790135; cv=none; b=g3MXdASFY3RzYI02O+xlMLryssjZksqNehHM6boELQxGa7FXXDC7AMdgdJhn58s8XzTReLwo+0EmpebsAzRIgvBTdjOGS07wkA1AAGS5hG48cFYh4YZfjzIxdXHUu9HhiE/iH4uAktfzO2SPXEbXTXLtdrIooLBFyc7c1o67hMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790135; c=relaxed/simple;
	bh=o5eeuFKhyCcbXwAO4d/vR/ZFr9x0F1b0pJqntOXwUi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sjc6S8dDpUeA/CSZYDIvitAnmjzQOkniyNrfR5gzZ8orDAHCRxr/IheoZOvoR8E90pGQ2ndM33D63yH5axCiM7++e1DdEPtAuGDNANlls06V3qWfJifuuUn5fmWWipXpJYRpkd7N+HnMMeop1qkpNueZt+ctwxAHKU6w/zcj5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K8PJfh0m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dMPVs8O3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K8PJfh0m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dMPVs8O3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 687C0EC034B;
	Wed, 30 Sep 2026 13:42:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 13:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790790132; x=1790876532; bh=/4Pc4hSbPD
	PfeZMs7GZH4T91SuGPU2lLQmyYiMHtuzE=; b=K8PJfh0mPHYwgefgSB5fI4Knzm
	hFMWYIk94EQM6UdHbKjrJ5ao37aQ3vHYKwtn4Mzj2InQER9VYvUS/OmR6kV+Vl4A
	TzpOqVRf1tOA273QE15CO9/BumdCclKuO+iGA+x7lIql1MMA6UFs6DwMsVmEe9xc
	JS5jTMVkOLXM1AXxHXMKu1m2y/EYvR1GT8RBkdgOn7Yy6vrNhBLTKpPalR+fIpJt
	QT7eLR/DHiTu/9BHY5iqYBPhn+SKhXTT24xcDU1mWJIjYeqZBwfHIWaVRBSgRI8C
	LCn027siTeNum1N2TG2TMl6afykOUxoNj27Mu1pNuIoLTjddr1jgZbh95iMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790790132; x=1790876532; bh=/4Pc4hSbPDPfeZMs7GZH4T91SuGPU2lLQmy
	YiMHtuzE=; b=dMPVs8O3tnVCB1BG80WiCtRJobkF4OsLPR/rwiM3HXyRllBBPSv
	OFiE5NgspeoBobXFw/BE9l4wMltv1YcW9Hok8dh6xakqFqc5z60B1yRfUezn73DX
	50ocUg0M2731CrirGY1Cyqti4bMCo8NF2L8ofGtCU9RFKaniNziukuqscBtCj9aw
	QJv34UgCoKiB/2aH+JkmNXFTuakCilTMltl4R9brxQjpvw1yBimuS+3q0MnECaLe
	u1IujRPis5V+Vg0l+N55zuSgQb1sWWGdgBfPcNJcHfntv93zQ9ULWhKFQ1XHXku0
	tRWhXY6AMvOicxybBR2h7e8IulJtjFzd6pw==
X-ME-Sender: <xms:9Em9audtE3Sa2HCIYnjqwXRQdhgduhvmyhci-69EkRK4E3jnPMTSyg>
    <xme:9Em9ar6WaHuhHD9E0ZULOzLpZPuYkJE5jHIptj7lwynP_1m_WuC2t1OPZaBumj0Ux
    wRPqhU-rePxN0b3yWpCBAWAiiBZlUlcRv0h2s2vHrPupuelC7Yzlck>
X-ME-Received: <xmr:9Em9apU94oYn4ju59RvB9zbCyl5d5_co083mwl_tMD8FrH_woNrkBbR2ZVMDlYzt3KwgJEUj6fk9cJT11ZjQaVEZa37xIeQDxy_J>
X-ME-Proxy-Cause: dmFkZTEzP1o5bT00aeo09Dh354Bc8ub3kJXKw4wEu/eTvDLuFHibPIsRxddx4IfRnR8qSl
    TPQz3BIp3uNYvgGYJHgX8OBhKuTkGI9prhXf4SbeXCB8kPn4q5nNK9ELnf9LXULL4JJRQo
    SjQPZ8lkuPTBSm32gG+rAmbXjVxQ+Wfz10eJjC5oyEhnCHyDhxyuqc+w8KWcXQnfs3lApr
    C5FNISwfLd3A9WSJpw3uidfC+IZbqDNuGY436tNtrwexmbwyIM5kabMW4u/EUNjgwKouXF
    X1raQBJpfUtOFclpIpAQUO03IZwuSXMoMCSBAdcF2wk2678/sunaQ2MXblD/Po12ecp0pw
    ie/K+YgIEHsT8fgIZYYahg7kSvCDkyUNnzCERCREmza+BmskwdOakLufiIG4HHq53k4UR5
    jqjm2OHhDgpUoosWYXoiuabEzkVefW4JNhelmUmgSPIVqYBfQZ/86wpjADfA8oTzdKOGp7
    DfYkp7wTZT7aHY44fGA273ephQcqcI9Nkyp3Y41opJ0bU86xjopUTHb97JXjKvMO/4ypwD
    UYoh7zv8jz8KKuNPjVS8IeiguXVR/GK0u0qQaUhK80Gd+E6O46VnM5gL4mir5KH+xWCyCs
    Tna2OcNnqR2pnDrKeMyV50RPlTJklKhqaphp8XJ9zA4WFkJouV0ZouF0QfQA
X-ME-Proxy: <xmx:9Em9ai6G8ZB3u2olOnytADy4i3Mrynjeg2I9c8yHSBVMCJpPzuA--A>
    <xmx:9Em9aspEQbJpEwfbFwJ2AeGRvQ1SKX7ngZgQmHhIdS88n92AqaUMlw>
    <xmx:9Em9atnk_65dVW-_Jv17xTRnAHdW2vkXDMfbEz74750bBqQnYVRD4g>
    <xmx:9Em9agPdo547P0oYhlkUx4owjG489LOZtKhl33d-uQSbyM06q5ECQA>
    <xmx:9Em9avY4wxL65NMOOd5ns843zyiaSJdLjN6c3d4QjftacJkTLJJ1zaRH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 13:42:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Ted Nyman
 <tnyman@openai.com>,  Elijah Newren <newren@github.com>
Subject: Re: [PATCH 1/4] pack-objects: introduce `stdin_packs_context` struct
In-Reply-To: <64bb13e2db2e5c22e842c188e08861d63e99dc77.1790731662.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 29 Sep 2026 20:28:45 -0500")
References: <cover.1790731662.git.me@ttaylorr.com>
	<64bb13e2db2e5c22e842c188e08861d63e99dc77.1790731662.git.me@ttaylorr.com>
Date: Wed, 30 Sep 2026 10:42:10 -0700
Message-ID: <xmqqik3mbpql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

>  static int add_object_entry_from_pack(const struct object_id *oid,
>  				      struct packed_git *p,
>  				      uint32_t pos,
>  				      void *_data)
>  {
> +	struct stdin_packs_context *ctx = _data;
>  	off_t ofs;
>  	struct object_info oi = OBJECT_INFO_INIT;
>  	enum object_type type = OBJ_NONE;
> @@ -3827,7 +3833,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  		die(_("could not get type of object %s in pack %s"),
>  		    oid_to_hex(oid), p->pack_name);
>  	} else if (type == OBJ_COMMIT) {
> -		struct rev_info *revs = _data;
>  		/*
>  		 * commits in included packs are used as starting points
>  		 * for the subsequent revision walk
> @@ -3840,7 +3845,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  		 * However, we'll only add those objects to the packing
>  		 * list after checking `want_object_in_pack()` below.
>  		 */
> -		add_pending_oid(revs, NULL, oid, 0);
> +		add_pending_oid(ctx->revs, NULL, oid, 0);
>  	}
>  
>  	if (!want_object_in_pack(oid, 0, &p, &ofs))
> @@ -3954,8 +3959,9 @@ static int stdin_packs_include_check(struct commit *commit, void *data)
>  }

We used to take _data that is rev_info, but no longer.  We lost decl
for "struct rev_info *revs" and rewrote its only use to directly
reference ctx->revs.  As long as the result compiles, we know there
is no stray reference to "revs" left in this function, so the
rewrite is complete.  It is rare but I love this kind of patch whose
correctness can be seen without reading beyond the context ;-)

>  static void stdin_packs_add_pack_entries(struct strmap *packs,
> -					 struct rev_info *revs)
> +					 struct stdin_packs_context *ctx)
>  {
> +	struct rev_info *revs = ctx->revs;
>  	struct string_list keys = STRING_LIST_INIT_NODUP;
>  	struct string_list_item *item;
>  	struct hashmap_iter iter;
> @@ -3994,15 +4000,14 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
>  		    (info->kind & STDIN_PACK_EXCLUDE_OPEN))
>  			for_each_object_in_pack(info->p,
>  						add_object_entry_from_pack,
> -						revs,
> +						ctx,
>  						ODB_FOR_EACH_OBJECT_PACK_ORDER);
>  	}
>  
>  	string_list_clear(&keys, 0);
>  }

Ditto.

> -static void stdin_packs_read_input(struct rev_info *revs,
> -				   enum stdin_packs_mode mode)
> +static void stdin_packs_read_input(struct stdin_packs_context *ctx)

We used to take two separately, but now we can take them in one package.

>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	struct strmap packs = STRMAP_INIT;
> @@ -4017,7 +4022,7 @@ static void stdin_packs_read_input(struct rev_info *revs,
>  			continue;
>  		else if (*key == '^')
>  			kind = STDIN_PACK_EXCLUDE_CLOSED;
> -		else if (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
> +		else if (*key == '!' && ctx->mode == STDIN_PACKS_MODE_FOLLOW)
>  			kind = STDIN_PACK_EXCLUDE_OPEN;
>  
>  		if (kind != STDIN_PACK_INCLUDE)
> @@ -4082,19 +4087,23 @@ static void stdin_packs_read_input(struct rev_info *revs,
>  		info->p = p;
>  	}
>  
> -	stdin_packs_add_pack_entries(&packs, revs);
> +	stdin_packs_add_pack_entries(&packs, ctx);
>  
>  	strbuf_release(&buf);
>  	strmap_clear(&packs, 1);
>  }

The same argument tells us that this is the right refactoring as
long as the result compiles.

> -static void add_unreachable_loose_objects(struct rev_info *revs);
> +static void add_unreachable_loose_objects(struct stdin_packs_context *ctx);
>  
>  static void read_stdin_packs(struct repository *repo,
>  			     enum stdin_packs_mode mode, int rev_list_unpacked)
>  {
>  	int prev_fetch_if_missing = repo->fetch_if_missing;
>  	struct rev_info revs;
> +	struct stdin_packs_context ctx = {
> +		.revs = &revs,
> +		.mode = mode,
> +	};
>  
>  	/*
>  	 * The revision walk may hit objects that are promised, only. As the
> @@ -4131,9 +4140,9 @@ static void read_stdin_packs(struct repository *repo,
>  		 */
>  		ignore_packed_keep_in_core_open = 1;
>  	}
> -	stdin_packs_read_input(&revs, mode);
> +	stdin_packs_read_input(&ctx);
>  	if (rev_list_unpacked)
> -		add_unreachable_loose_objects(&revs);
> +		add_unreachable_loose_objects(&ctx);
>  
>  	if (prepare_revision_walk(&revs))
>  		die(_("revision walk setup failed"));

Ditto.

> @@ -4541,7 +4550,7 @@ static void add_objects_in_unpacked_packs(void)
>  static int add_loose_object(const struct object_id *oid, const char *path,
>  			    void *data)
>  {
> -	struct rev_info *revs = data;
> +	struct stdin_packs_context *ctx = data;
>  	enum object_type type = odb_read_object_info(the_repository->objects, oid, NULL);
>  
>  	if (type < 0) {
> @@ -4563,8 +4572,8 @@ static int add_loose_object(const struct object_id *oid, const char *path,
>  		add_object_entry(oid, type, "", 0);
>  	}
>  
> -	if (revs && type == OBJ_COMMIT)
> -		add_pending_oid(revs, NULL, oid, 0);
> +	if (ctx && type == OBJ_COMMIT)
> +		add_pending_oid(ctx->revs, NULL, oid, 0);
>  
>  	return 0;
>  }

This one, ...

> @@ -4574,10 +4583,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
>   * add_object_entry will weed out duplicates, so we just add every
>   * loose object we find.
>   */
> -static void add_unreachable_loose_objects(struct rev_info *revs)
> +static void add_unreachable_loose_objects(struct stdin_packs_context *ctx)
>  {
>  	for_each_loose_file_in_source(the_repository->objects->sources,
> -				      add_loose_object, NULL, NULL, revs);
> +				      add_loose_object, NULL, NULL, ctx);
>  }

... together with the change to add_unreachable_loose_objects()
here, it is not immediately obvious if we do not have to worry about
the case where (ctx && !ctx->revs).

Given that 'struct stdin_packs_context' is a new structure, the fact
that the instantiation on the stack in read_stdin_packs() is the only
one that can give us a non-NULL 'ctx' pointer we can see in this
patch means that a non-NULL 'ctx' cannot have a NULL '.revs' pointer
in it.  Again, as long as this patch alone compiles, we know this
refactoring is correct.

It is not clear to me what the implication of assuming a non-NULL
'ctx' always means a non-NULL 'ctx->revs' is for the code health in
the longer term, though.

Thanks.
