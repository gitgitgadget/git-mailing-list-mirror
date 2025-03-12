Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37520C003
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766796; cv=none; b=lluj3FRPpL/5ouizkK6bFZlbkFz9D/Ux8Vus3k/PqbtiQgpHTHanLu6+1n34heBc2iw+1bEazFPzD5JnN1/YWJnONKVyoFbM69dSHHjK45TYfCSATJZ923JZy9LIF/NO1/86eMvwJD9nX+uSWDod+3Iw5H4XUgWLN03kIm3L9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766796; c=relaxed/simple;
	bh=fokJI3p14n/tfPe0WVwtGzZgrKchF7LfJvhttWIxXi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVjoMqz1FpduKYcRpZK7rkNLmL1rszthZGVyYW74yqINNAcQZhrxmLbfJCUSL8gPj+0vRYVw2yJA1WeEf6TYpFWVDZo0bhsOJCvBupGUHbGljHSsD0EVHGfIUdRtVXyvG8eqPauAzTS1IAq9po/CFHsnt5b1PVaIkhvgEBaIxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mR2WZZJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6xjQRRHO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mR2WZZJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6xjQRRHO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 26F6111402A2;
	Wed, 12 Mar 2025 04:06:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Mar 2025 04:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741766793; x=1741853193; bh=fLbOYyt/c6
	NQxKTvrdCKZLElkhK4LVI+9xiYCp/JH58=; b=mR2WZZJ0YUEHnFcljjdeXCRC3v
	AxK93JAI5u5WIhZvI81EldjR2ndFoeW2S7u3WbyA9/RD2Cs0JZxuq6FVrTgxtWPD
	e89/NjupBHGKsB9v52leh14tcd9OsHCYP2KMvEO+1ZfCyQsMAKAQOE32/xYi3xqQ
	2HM8fFT+G4iJmRNZYr0anOBh5r6x1Q9XML3bMgzcGFRRfgTlwF0TWmXOEcaS12mS
	PW4YBIIoNPwc/FzQ4g4zPITrwGRVlosu7smUR+DZjyHqHzJUcIQwpn2Kq1FQtegO
	J+Lec7GmTUfJZPp13jcizhDcIBIoRdqNNiNhJfbSn2uzCqrbiQfNuYPQGn9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741766793; x=1741853193; bh=fLbOYyt/c6NQxKTvrdCKZLElkhK4LVI+9xi
	YCp/JH58=; b=6xjQRRHOZgaPcM+9pPUn/P82rT1EQkpQ7G8C66JiO2RflIp1Jq8
	Z8Oem+/GCdWZgAJPrNZAu5uGT6U+CAg6JxyFfPPqDERfQ8QQ1iOziuPRnUgqscXb
	oVsmw0gDd51uTapOIQubhovBVv6CWTfCATnHGIYmsDFwwN1tOBVfjr/Q9LkubRj/
	a69tkMx/VJF4vpL67ollsvzCQE3fDC0LR93R75dPX/hz7RCXIR0p2mIO+08MGd5n
	DRAP4x0RpGiuv7mpMQpgSTm/gJgdGhk0q1ZM1C6qX/+/j2uq8hjg17AvtmkT0T7f
	OS8NCl5BgJKD9L7o/QDvF29tgftDHyiCusA==
X-ME-Sender: <xms:iEDRZ5h2Dyfh2qwAcXLxkcj4V0vMYioRz6W1OcEXd3vQtJgwp6fKgA>
    <xme:iEDRZ-AqOPJdgQGNZ0cbzdg89ot6tYtLYspxwf7dQkKbR4O0MWMMFzaC8tkEazAMm
    dZj6x5XIIKbqwROUA>
X-ME-Received: <xmr:iEDRZ5HZT1ZzgFXYMBk46J8qNpES-6YV73fFuCG4BtJaQHWFx-7yqBLDFtvUlisNfYg6AL61GuDF1hWtSFCIMEv52fEB10aGrUJXG8p7zSlD7kh-Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iEDRZ-RUBxLPAfHpwoSquHmedzEB4lY6jrfBo7pxmhCyXLOecvSS0g>
    <xmx:iEDRZ2zB13l1aQAZiQ93JmoRw1zQHB5d-DkEszjcvhQl_DlV4WZ5BA>
    <xmx:iEDRZ07_GjH0a_rGBTLCU1c_2AQew6ZKyNmv7Z5n8lIo6li5ig0JRg>
    <xmx:iEDRZ7xZZJwisb740kJMN_fCN4eFlfh3XY11xMYOu77--ttq6RrS1Q>
    <xmx:iEDRZ6_A-lbvoKkang8tr9rszu1gP16st3nxEb0jZjiWR7XRHTCaKt6T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 04:06:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36d00aaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 08:06:29 +0000 (UTC)
Date: Wed, 12 Mar 2025 09:06:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: add new merge_ort_generic() function
Message-ID: <Z9FAgCSCZSJnzv9d@pks.im>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <9f73e54224d55b40faeb5d68ebd7ff0c13d69c7b.1741362522.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f73e54224d55b40faeb5d68ebd7ff0c13d69c7b.1741362522.git.gitgitgadget@gmail.com>

On Fri, Mar 07, 2025 at 03:48:40PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
> index d6f61359965..62834c30e9e 100644
> --- a/merge-ort-wrappers.c
> +++ b/merge-ort-wrappers.c
> @@ -64,3 +68,63 @@ int merge_ort_recursive(struct merge_options *opt,
>  
>  	return tmp.clean;
>  }
> +
> +static struct commit *get_ref(struct repository *repo,
> +			      const struct object_id *oid,
> +			      const char *name)
> +{
> +	struct object *object;
> +
> +	object = deref_tag(repo, parse_object(repo, oid),
> +			   name, strlen(name));
> +	if (!object)
> +		return NULL;
> +	if (object->type == OBJ_TREE)
> +		return make_virtual_commit(repo, (struct tree*)object, name);
> +	if (object->type != OBJ_COMMIT)
> +		return NULL;
> +	if (repo_parse_commit(repo, (struct commit *)object))
> +		return NULL;
> +	return (struct commit *)object;
> +}

This is an exact copy of the same function in "merge-recursive.c".

> +int merge_ort_generic(struct merge_options *opt,
> +		      const struct object_id *head,
> +		      const struct object_id *merge,
> +		      int num_merge_bases,
> +		      const struct object_id *merge_bases,
> +		      struct commit **result)
> +{
> +	int clean;
> +	struct lock_file lock = LOCK_INIT;
> +	struct commit *head_commit = get_ref(opt->repo, head, opt->branch1);
> +	struct commit *next_commit = get_ref(opt->repo, merge, opt->branch2);
> +	struct commit_list *ca = NULL;
> +
> +	if (merge_bases) {
> +		int i;
> +		for (i = 0; i < num_merge_bases; ++i) {
> +			struct commit *base;
> +			if (!(base = get_ref(opt->repo, &merge_bases[i],
> +					     oid_to_hex(&merge_bases[i]))))
> +				return error(_("Could not parse object '%s'"),
> +					     oid_to_hex(&merge_bases[i]));
> +			commit_list_insert(base, &ca);
> +		}
> +	}
> +
> +	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
> +	clean = merge_ort_recursive(opt, head_commit, next_commit, ca,
> +				    result);
> +	free_commit_list(ca);
> +	if (clean < 0) {
> +		rollback_lock_file(&lock);
> +		return clean;
> +	}
> +
> +	if (write_locked_index(opt->repo->index, &lock,
> +			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> +		return error(_("Unable to write index."));
> +
> +	return clean ? 0 : 1;
> +}

There are two differences here:

  - We use `error()` instead of the custom `err()` function that
    "merge-recursive.c" uses. I'm happy to see us using standard error
    reporting.

  - We don't have the check for `num_merge_bases == 1`. I have no idea
    why we don't have it, and it's likely that other readers may be
    puzzled in the same way. So this is something I'd expect to see
    explained in the commit message.

Other than that this function looks identical.

> diff --git a/merge-ort.c b/merge-ort.c
> index 46e78c3ffa6..b4ff24403a1 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -5186,6 +5186,8 @@ static void merge_ort_internal(struct merge_options *opt,
>  		ancestor_name = "empty tree";
>  	} else if (merge_bases) {
>  		ancestor_name = "merged common ancestors";
> +	} else if (opt->ancestor) {
> +		ancestor_name = opt->ancestor;
>  	} else {
>  		strbuf_add_unique_abbrev(&merge_base_abbrev,
>  					 &merged_merge_bases->object.oid,
> @@ -5275,8 +5277,13 @@ void merge_incore_recursive(struct merge_options *opt,
>  {
>  	trace2_region_enter("merge", "incore_recursive", opt->repo);
>  
> -	/* We set the ancestor label based on the merge_bases */
> -	assert(opt->ancestor == NULL);
> +	/*
> +	 * We set the ancestor label based on the merge_bases...but we
> +	 * allow one exception through so that builtin/am can override
> +	 * with its constructed fake ancestor.
> +	 */
> +	assert(opt->ancestor == NULL ||
> +	       (merge_bases && !merge_bases->next));
>  
>  	trace2_region_enter("merge", "merge_start", opt->repo);
>  	merge_start(opt, result);

These two hunks look related to my above observation that we don't have
the check for `num_merge_bases == 1`, as in "merge-recursive.c" we used
to set `opt->ancestor = "constructed merge base" if so.

Patrick
