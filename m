Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6712038C3
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393713; cv=none; b=FwD9C/TLOkQ53Jw3zBbf0pyP9gpRTAZZLcwb6cblOoPPQv5J6WG8dzW9A3UTnjPbFgYo/ZlOFY21PtIul5M74vwZwl7Rq9QP6aGB2lmE/rWCEHj/rTiMhtlfOAiKlOGFvfo1wHt7RBbj8/76uRotgktudq43m+Vt3OtTKq1oIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393713; c=relaxed/simple;
	bh=U9Z5mcaUJ488C/NVr9dg0Q9QKn65CwYXcsqycmeLMNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKr84cB2eprplPPue1xAV9v2ZdjSDmeUBRptbeREki0iYy+eh0DclP6XvZt+udn7dLczu8wRuWbCDF8HPoKL4OGBUbyqBC3ULhdbNnSe9LF9OtYNa5XYN5f/K7MbNuRMK/JNVQwK1GGCOTupNzyxhDI5cvLGUG9RJQj1WOACuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UTm49LWA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aoU3MKcN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UTm49LWA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aoU3MKcN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 218A211401AA;
	Tue, 12 Nov 2024 01:41:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 12 Nov 2024 01:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731393709; x=1731480109; bh=MF7TwBQcYV
	AdGkW6o0oOBjxIfeUjfrnF60ekT64g1UU=; b=UTm49LWAT6oLVAtAOlYfrRToIx
	pUWZNXX1bppr0flEtQ8jWrlvlCwEenSJpLSdbTVbBkmW66xYHn/VJpZmOudgSB2Y
	+mS8ZlkKS0aqP4t+6bM66PyRScXSKCs0UHFvmGa//YlDYO/SdWOOIVkcvg9S1ZTg
	h2dmfmix3iP3TLH/RFh+NNWRqmLpCb/TIL12VMqVDWPyqXZN97wxVAeBKCSRrAEc
	TQoolyvi8EFwEHNG0xnNoDmI7LU5uBzheSLM+VgohEA30aOsD7TLYwN+lApN7LFc
	J+AU1dBZdZBGua1YI7u5FTgWSgMD607w0JH1IEtsIeeSQiVdUaTl2m0AkgTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731393709; x=1731480109; bh=MF7TwBQcYVAdGkW6o0oOBjxIfeUjfrnF60e
	kT64g1UU=; b=aoU3MKcN0iqMqZL+Xq8LB+8i6PA3bcGRz+/L1FRp69zdAymqsxN
	ma4eYS4NcWyl2qeB5xbzigkqk8lOJOzHLaue3dVxOac3/2Z6MsMq3pen/hea7Psu
	fRU6T0IusibSldwIWZ2YozGHEno/FYe/bbAm/zZeKQ+QW8jhtFj/hDedaM/64Cf3
	HhwjfJctZ9NnqyLDpN+A3Rz0HzFGJwNDMu/GWwOkS+ZtGJXo4uo3NbHSVAyhALbZ
	yOV/HHCVLw9/fe/9LoJFaousrwHhTseRVKp9QoUJ3xLXIfHNjQba34zB4dhvMHoK
	7aMjoqBgC5SDV1YUFClB2JPD+Z5Vmsj1ZSw==
X-ME-Sender: <xms:rfgyZzu0Y_SG2Aa0OKCq87ZJ82BIBl0_NuMxplGzVjMdZaWEW76Jnw>
    <xme:rfgyZ0fbujqt4qoRWiAeTrlQUoJN2AfVXKvj425GxGB7gQ-hmS2w-vY-HQGLYKfri
    oVEQFxwQUl8e-KvrQ>
X-ME-Received: <xmr:rfgyZ2x_ZZG1IllN4N99_AXvMUbU9NnGr53NpWtH8Qgxx-8Ob-QVje40JlYOFAPsWYk1RAy3MXvvFmeMD8bJMbsMkjCSYjLDASN9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rfgyZyO1JX1X005IEU51Kukm5AcErPqvAGBbthAyuaR3pAT2QXTRkA>
    <xmx:rfgyZz9WU7z35lvgAN2ildX6cgfVPPTIrSmGy40E8_YuAGXjMOPTVA>
    <xmx:rfgyZyXv8rNd20nQnSQBFAe17__Sv45zhgOoYaW_V8iW33hYRMtRXg>
    <xmx:rfgyZ0eiBOBW7Rbxe9AgCK7wjf_HdWusyyiFd9uB6zHYP_-5O_jaUw>
    <xmx:rfgyZ2Y02oXDMNpFnceSPh5pCxNDenAibhWqpCUSOMZe2HbVu1QhUawW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 01:41:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/8] refs/reftable: handle reloading stacks in the
 reftable backend
In-Reply-To: <bab837e3733a982973bb96eedca15d073089693a.1730792627.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 5 Nov 2024 10:12:02 +0100")
References: <cover.1730732881.git.ps@pks.im> <cover.1730792627.git.ps@pks.im>
	<bab837e3733a982973bb96eedca15d073089693a.1730792627.git.ps@pks.im>
Date: Tue, 12 Nov 2024 15:41:48 +0900
Message-ID: <xmqqo72l54yb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static int backend_for(struct reftable_backend **out,
> +		       struct reftable_ref_store *store,
> +		       const char *refname,
> +		       const char **rewritten_ref,
> +		       int reload)
>  {
> +	struct reftable_backend *be;
>  	const char *wtname;
>  	int wtname_len;
>  
> -	if (!refname)
> -		return &store->main_backend;
> +	if (!refname) {
> +		be = &store->main_backend;
> +		goto out;
> +	}
>  
>  	switch (parse_worktree_ref(refname, &wtname, &wtname_len, rewritten_ref)) {
>  	case REF_WORKTREE_OTHER: {
>  		static struct strbuf wtname_buf = STRBUF_INIT;
>  		struct strbuf wt_dir = STRBUF_INIT;
> -		struct reftable_backend *be;
>  
>  		/*
>  		 * We're using a static buffer here so that we don't need to
> @@ -162,7 +166,7 @@ static struct reftable_backend *backend_for(struct reftable_ref_store *store,
>  		}
>  
>  		strbuf_release(&wt_dir);
> -		return be;
> +		goto out;

An interesting part of this function is not shown in the above
context, but we look up an existing backend from a strmap, and
allocate one if there isn't.  In either case, be points at the
backend to use.  Now be is not local to this block, we can access it
after jumping to "out" label.

> +out:
> +	if (reload) {
> +		int ret = reftable_stack_reload(be->stack);
> +		if (ret)
> +			return ret;
> +	}
> +	*out = be;
> +
> +	return 0;
>  }

> @@ -828,17 +845,17 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
>  {
>  	struct reftable_ref_store *refs =
>  		reftable_be_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
> -	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
> +	struct reftable_backend *be;
>  	int ret;
>  
>  	if (refs->err < 0)
>  		return refs->err;
>  
> -	ret = reftable_stack_reload(stack);
> +	ret = backend_for(&be, refs, refname, &refname, 1);
>  	if (ret)
>  		return ret;

This one chooses to reload, so that the next one, i.e.
"without-reload", would not read stale information?

> -	ret = read_ref_without_reload(refs, stack, refname, oid, referent, type);
> +	ret = read_ref_without_reload(refs, be->stack, refname, oid, referent, type);


The following bit is curious.

> +	ret = backend_for(&be, refs, update->refname, NULL, 0);
> +	if (ret)
> +		return ret;
> +

We locate one without reloading, and ...

>  	/*
>  	 * Search for a preexisting stack update. If there is one then we add
>  	 * the update to it, otherwise we set up a new stack update.
>  	 */
>  	for (i = 0; !arg && i < tx_data->args_nr; i++)
> -		if (tx_data->args[i].stack == stack)
> +		if (tx_data->args[i].be == be)
>  			arg = &tx_data->args[i];
>  	if (!arg) {

... only when we cannot reuse preexisting one, ...

>  		struct reftable_addition *addition;
>  
> -		ret = reftable_stack_reload(stack);
> +		ret = backend_for(&be, refs, update->refname, NULL, 1);
>  		if (ret)
>  			return ret;

... instead of directly doing reload on the instance we already
have, we do another _for() to locate one, this time reload set to 1.

That looks like doing some redundant work?  I am confused.

> @@ -1048,7 +1070,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  		goto done;
>  	}
>  
> -	ret = read_ref_without_reload(refs, backend_for(refs, "HEAD", NULL)->stack, "HEAD",
> +	ret = backend_for(&be, refs, "HEAD", NULL, 0);
> +	if (ret)
> +		goto done;
> +
> +	ret = read_ref_without_reload(refs, be->stack, "HEAD",
>  				      &head_oid, &head_referent, &head_type);

This now takes into account the possibility that backend_for() might
fail.  The original code would have segfaulted when it happened, I
guess.

> @@ -1057,10 +1083,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *u = transaction->updates[i];
>  		struct object_id current_oid = {0};
> -		struct reftable_stack *stack;
>  		const char *rewritten_ref;
>  
> -		stack = backend_for(refs, u->refname, &rewritten_ref)->stack;
> +		ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
> +		if (ret)
> +			goto done;

Ditto, we would have segfaulted in the next hunk when stack got NULL
here ...

> @@ -1116,7 +1143,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  			string_list_insert(&affected_refnames, new_update->refname);
>  		}
>  
> -		ret = read_ref_without_reload(refs, stack, rewritten_ref,
> +		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
>  					      &current_oid, &referent, &u->type);

... here.

> @@ -1831,10 +1858,9 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
>  {
>  	struct reftable_ref_store *refs =
>  		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
> -	struct reftable_stack *stack = backend_for(refs, newrefname, &newrefname)->stack;
> +	struct reftable_backend *be;
>  	struct write_copy_arg arg = {
>  		.refs = refs,
> -		.stack = stack,
>  		.oldname = oldrefname,
>  		.newname = newrefname,
>  		.logmsg = logmsg,
> @@ -1845,10 +1871,11 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = reftable_stack_reload(stack);
> +	ret = backend_for(&be, refs, newrefname, &newrefname, 1);
>  	if (ret)
>  		goto done;

We used to grab "stack" upfront and then called reload here; we now
do backend_for() and let it do the reload as well, so they should be
equivalent.

> -	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
>  	struct reftable_log_record log = {0};
>  	struct reftable_iterator it = {0};
> +	struct reftable_backend *be;
>  	int ret;
>  
>  	if (refs->err < 0)
>  		return refs->err;
>  
> -	ret = reftable_stack_init_log_iterator(stack, &it);
> +	ret = backend_for(&be, refs, refname, &refname, 0);
> +	if (ret)
> +		goto done;
> +
> +	ret = reftable_stack_init_log_iterator(be->stack, &it);

Again, other than the fact that the new code carefully prepares for
the case where backend_for() fails to find be, the versions of the
code with and without the patch are equivalent.

> @@ -2052,16 +2083,20 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
>  {
>  	struct reftable_ref_store *refs =
>  		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent");
> -	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
>  	struct reftable_log_record *logs = NULL;
>  	struct reftable_iterator it = {0};
> +	struct reftable_backend *be;
>  	size_t logs_alloc = 0, logs_nr = 0, i;
>  	int ret;
>  
>  	if (refs->err < 0)
>  		return refs->err;
>  
> -	ret = reftable_stack_init_log_iterator(stack, &it);
> +	ret = backend_for(&be, refs, refname, &refname, 0);
> +	if (ret)
> +		goto done;
> +
> +	ret = reftable_stack_init_log_iterator(be->stack, &it);

Ditto.

> @@ -2101,20 +2136,20 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
>  {
>  	struct reftable_ref_store *refs =
>  		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
> -	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
>  	struct reftable_log_record log = {0};
>  	struct reftable_iterator it = {0};
> +	struct reftable_backend *be;
>  	int ret;
>  
>  	ret = refs->err;
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = reftable_stack_reload(stack);
> +	ret = backend_for(&be, refs, refname, &refname, 1);
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = reftable_stack_init_log_iterator(stack, &it);
> +	ret = reftable_stack_init_log_iterator(be->stack, &it);
>  	if (ret < 0)
>  		goto done;

Ditto.

Overall they seem to be mostly equivalent, except that the new code
is a bit more careful against failing backend_for().  One part of
the code confused me (and still I am unsure), but other than that it
was a pleasant read.

Thanks.
