Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA319283C93
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817118; cv=none; b=R4LaLdHjdMkjO77IBG2gVbx6BTXPAsFl5CXRfwbP9/xWufVOr2p4teGLlWJwBNCmrgOeBCen1zhfTuV9/qlOHv2HCxVPtWkn28MS71DrRYEMQDXa0YDEIRt7ulLa8n4dDjThHh5EMVw2loFQRqnd08022wjEG84LsV5QrtY/F3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817118; c=relaxed/simple;
	bh=X0idQCUGt3dU3/dlpe8GWrX856CRG1T7EfFHMkz+aQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE7iZcGJJ9KkAPbOl7bVQgpvw7iaE64DW5o1B1jkDtR1BCUPFrp+x5YWQ5zadECyD3M/6m0ZgdpdyAIxaUUFw4hrMlDdcJOPb2oXwKnDNl0OnZPdvmxEdym+lY1tL2rE2DYsNn+IEE3Fgko5if8S5XrQ63fXBjaL0pQvgMFwSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ntzFSm8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lwspj6D5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ntzFSm8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwspj6D5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B41CC1D00070;
	Wed, 11 Feb 2026 08:38:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 08:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770817115;
	 x=1770903515; bh=3B6DdVe991TN+CaEpxb3GPXDLyA4GEiEQ7n6h7rAb18=; b=
	ntzFSm8XjKxlA/ASwHau4348qP4ycxuF3MqZ98Jbax5zmhWFJNoJdwgyFA7A0/Bs
	CtermXHqeEYRq0XGyGRGqPUWvoCAqQGS3//HT+Hy1QXl07/f4qZ0IZscP6cca0JC
	sMA7N0hOYfecwZpn2iAS2yVIR3Iy9fv03ZsFON/9DNPbpzE1i2Pv5AoIkTJZ7+D5
	bGcferMtQ5J8GQLtiPGNVdfWW5oKemH2DmAvpWyO0cxrCJpScSOtrM59jdW4U09o
	BP/G++5fDaD/8A5QwZnSOwObFDIemzIGlB5qALpTdRBIPpXoaCxfClh/OAcpIvoQ
	VvN/5r22Y1lPx3Z8IKlq9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770817115; x=
	1770903515; bh=3B6DdVe991TN+CaEpxb3GPXDLyA4GEiEQ7n6h7rAb18=; b=l
	wspj6D58XVCQ7J8o3dFFdaMbCApf4s6o7X/757SdV9XxOIOGkNrM7JY0qPUsgnpm
	PR6/SpaIeC3z1lXFM3y37PhD4ajWDYkT+V9X5vjun4KIBRXPQ/4/QffYho+V3axl
	YVuG9ibycRnd5zXXF7wK73213lHAdes0r/QBJKAKupBBhqIjk8HmBEncPCZTTL/3
	l4HIqKCXx8uuy0aFEkd/nbsPuCdEXMP3m60Sdk06KI7x7q1QVe0x0HtwiOL3Ta6v
	HSfL8kb+giRAy9wfdPc2CaSOnmc+a9+xuz/djLQNXu+9E7QQ6rie7J2zHgkHDQAj
	4O6HRfMBv5K8AtTc3KaZQ==
X-ME-Sender: <xms:WoaMaZjys8bafjapgb-WxOdCwtlENPpbPR6tPcLoNs5Kf1Nj2xFuAw>
    <xme:WoaMaVCb4R1zhxDXng-ls7X0lwInVod3Od5iOE63em3V-qVIZJqRgwljSXFxXuHQo
    d41ChzW0NoZGQgT1EPJQD_tA7rOcA89g1vrvge1rtwhGQwQF9eOTQ>
X-ME-Received: <xmr:WoaMaeEOQ2bpO25XQuIUxh5xaYew73QLAX10hSSUJ8Ntv_pSxEe45vRj2f-5ERD5lRsvAgwQ2iA_NwipE4r8X7XjkwHcGpck-gXexCbnAAh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehsrghmohgpphhoghgrtghnihhksehtqddvrdhnvghtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WoaMadKJd3gUQxxI3YnfL2dAksg_Lny-zEtbf9djTRbfcSDBY_-yWg>
    <xmx:WoaMaSmQkYfVVcWewIhBX5fW7vOXfj2gwmO94coLYBFqovvERGEHpw>
    <xmx:WoaMaVSF4UK1dy5Gh9U-wEa-BYxrmpuLHKy_-NFq2E3SgXOpj8dVfg>
    <xmx:WoaMaUJQKmGPK9pbVoC5pg7Z6Xr1j7vSsxi9lWqonTJF-1dBVrmqdQ>
    <xmx:W4aMaRHvUlyS09IwcW8AcHQC5MykC73c0FZJBigORQ0kOQsAkY1HaVAb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 08:38:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b014eb14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 13:38:32 +0000 (UTC)
Date: Wed, 11 Feb 2026 14:38:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Samo =?utf-8?B?UG9nYcSNbmlr?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Subject: Re: [PATCH v4 2/2] shallow: handling fetch relative-deepen
Message-ID: <aYyGTmS6fEb2QfBU@pks.im>
References: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
 <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
 <e9b20ae06fd2c7f2c6b73c9f093a23c812227b7e.1768602661.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9b20ae06fd2c7f2c6b73c9f093a23c812227b7e.1768602661.git.gitgitgadget@gmail.com>

On Fri, Jan 16, 2026 at 10:31:01PM +0000, Samo Pogačnik via GitGitGadget wrote:
> diff --git a/shallow.c b/shallow.c
> index 497a25836b..1a32808865 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -130,11 +130,12 @@ static void free_depth_in_slab(int **ptr)
>  {
>  	FREE_AND_NULL(*ptr);
>  }
> -struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
> -		int shallow_flag, int not_shallow_flag)
> +struct commit_list *get_shallow_commits(struct object_array *heads,
> +					struct object_array *shallows, int *deepen_relative,
> +					int depth, int shallow_flag, int not_shallow_flag)
>  {
> -	size_t i = 0;
> -	int cur_depth = 0;
> +	size_t i = 0, j;

We can declare `j` in the loop itself, as it's not used anywhere else.

> @@ -168,16 +169,30 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  		}
>  		parse_commit_or_die(commit);
>  		cur_depth++;
> -		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
> -		    (is_repository_shallow(the_repository) && !commit->parents &&
> -		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
> -		     graft->nr_parent < 0)) {
> -			commit_list_insert(commit, &result);
> -			commit->object.flags |= shallow_flag;
> -			commit = NULL;
> -			continue;
> +		if (shallows) {
> +			for (j = 0; j < shallows->nr; j++)
> +				if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
> +					if ((!cur_depth_shallow) || (cur_depth < cur_depth_shallow))

The additional braces around the respective conditions are not needed.

> +						cur_depth_shallow = cur_depth;
> +
> +			if ((is_repository_shallow(the_repository) && !commit->parents &&
> +			     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
> +			     graft->nr_parent < 0)) {
> +				commit = NULL;
> +				continue;
> +			}

This block here is almost the same as the one below. But there's some
confusing parts:

  - Why don't we update `result` at all?

  - Why don't we set the `shallow_flag`?

  - Why don't we have to check for the passed-in depth?

All of these parts feel somewhat surprising to me, as the function now
behaves so wildly different depending on whether or not `shallows` was
passed.

I guess this is because we really only care about `cur_depth_shallow`?

> diff --git a/upload-pack.c b/upload-pack.c
> index 2d2b70cbf2..4232eef34f 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -704,54 +704,11 @@ error:
>  	return -1;
>  }
>  
> -static int get_reachable_list(struct upload_pack_data *data,
> -			      struct object_array *reachable)
> +static void get_shallows_depth(struct upload_pack_data *data)

I think this function is rather pointless, as there is only a single
caller and we only end up forwarding to `get_shallow_commits()`. Let's
inline it.

> @@ -881,29 +838,14 @@ static void deepen(struct upload_pack_data *data, int depth)
>  			struct object *object = data->shallows.objects[i].item;
>  			object->flags |= NOT_SHALLOW;
>  		}
> -	} else if (data->deepen_relative) {
> -		struct object_array reachable_shallows = OBJECT_ARRAY_INIT;
> -		struct commit_list *result;
> -
> -		/*
> -		 * Checking for reachable shallows requires that our refs be
> -		 * marked with OUR_REF.
> -		 */
> -		refs_head_ref_namespaced(get_main_ref_store(the_repository),
> -					 check_ref, data);
> -		for_each_namespaced_ref_1(check_ref, data);
> -
> -		get_reachable_list(data, &reachable_shallows);
> -		result = get_shallow_commits(&reachable_shallows,
> -					     depth + 1,
> -					     SHALLOW, NOT_SHALLOW);
> -		send_shallow(data, result);
> -		free_commit_list(result);
> -		object_array_clear(&reachable_shallows);
>  	} else {
>  		struct commit_list *result;
>  
> -		result = get_shallow_commits(&data->want_obj, depth,
> +		if (data->deepen_relative)
> +			get_shallows_depth(data);

Okay, so here we now essentially call `get_shallow_commits()` twice. The
first time we compute `data->deepen_relative`, only to then pass it back
to `get_shallow_commits()` a second time. That feels quite strange to
me. Can't we have `get_shallow_commits()` handle this for us directly in
a single call?

> +		result = get_shallow_commits(&data->want_obj, NULL, NULL,
> +					     data->deepen_relative + depth,
>  					     SHALLOW, NOT_SHALLOW);
>  		send_shallow(data, result);
>  		free_commit_list(result);

Thanks!

Patrick
