Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38477358D13
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021039; cv=none; b=uVs1V8FYtUBDJTeGouxXceKgSrTlViwKBXEwLcCYbpy84riUnLkemlNn8k79aZ22DIHxGOboCpb5HdP7AfCc2hfDv6ySxPqTk4bdpskjOBfS4IdOdbTqeQyrQuW4kGGZu3SRekBKoOjOZGYEMpYydk8ayUX8wiF5bZhRFbKpQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021039; c=relaxed/simple;
	bh=Ly6d+2vZRrvAVNbvhHc6aiD1ng5FPKfVF7kzjZ0ldjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StpFl2EoOG/jfRo7mLDskiB0nE3T9gp4GQRNLEzYIdhMrb6w8X+x3E/rcL6DYgf+l6rsTMJ2fgUVY5OluBDEUA/iiOWiOgGjz7+qLd23PJxU2oz0b/gcNE/dbTLniGa2igUs7kvbAIEm9Cqsfor71Lyq65NB5d2T/ZH58M7LDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WiisW4UY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0w+MMUa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WiisW4UY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0w+MMUa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E874E7A0116;
	Wed, 21 Jan 2026 13:43:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 13:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769021033; x=1769107433; bh=PnGQ1vGdDU
	aX0zuObxPpcnT6eIZObOPR9ZRCwxzDuWE=; b=WiisW4UY6FauwMKYTGE15CH/VK
	hIzzqqzghC63iS7jlaQEx5TKkc5A1Q6Eh0punK9OXuq46IschRAGoYHZhN3pyPZ7
	YdtmGHc5tmPtiAF3pp2j7whpcsTQd0IwO/ZJxRdtUqOdDCPV6Af+zu14aYPVdI+I
	iWq+ET1rZLu7uDFaMNpQinrtZCx33Pvlvp8IjKFRvI0ADLHqpRs6Is1onLAL0cPm
	jwazqfXq7iYAcqUC4DxQn83OpaqQ4qhvPHZPv7r7aBY7kC1UCYDQa0pSiya0uqnO
	SSvo3JKrxQTThN0l0doYGlLyEQ7pALTm4Dk2YJH55QiDVaKDGwR0YLxBU8ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769021033; x=1769107433; bh=PnGQ1vGdDUaX0zuObxPpcnT6eIZObOPR9ZR
	CwxzDuWE=; b=K0w+MMUangSxZaNA9jSv5tdVXTI16e5wX+sZA239NDvWqdQa9hY
	rLLeSLbKWIKHxc+7mhtZP4RwpQMBY876UFRUH9HNsq42nIO6Nmtibgr/N6881wfZ
	Qw+QRjt+7LzI4ajeuPhXbjOv6UbgDAlFSvo37Yz+tTdxt9X/wRepR0OPQvTWXVdq
	MyyXxH1XtXiYqMW7wE1n5W/kSZar1AjXDg13g4oZch8qqG6oGVb0xvedZ+dfpA9s
	a0C2RlZsf34zAXgPWA70Lh5+xcrvB8QIXaYHeMtf9BTNYfIwOeFs8O1547JIUMAb
	soa/Ch/RKzuTmbJ4uCaQ+q4HCk321L5VjyQ==
X-ME-Sender: <xms:aR5xaTqNAdDDmckl16ghqWU-DSFPyPSbW9mBB61zXDtAOmlsvLLLLw>
    <xme:aR5xaRV_dGp9M0ZOV-0z-L5mb2RC8s01DLB566tM4eyRJ0L0AAGuPIltMkmvRGu1H
    DRnZNP1ywKF8_52Pp1XwgvFzFaVn_oEOUiOLxXMFlQ4FGkCrdvJzg>
X-ME-Received: <xmr:aR5xaaBU5qMjEAaAM-dPXRTKjfW9fGFk5j44tVtkh_Cw6yDn3uB3uedHH0r-VhizAVUK-biWfYNSustXpdwqNSR3d1ceOan96oP9BWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aR5xad03h2ATmQSmBHqCPQ3FQTXHbQzDW7RRyo7Pl_U-SY8eQv_9yg>
    <xmx:aR5xaU0m9SGVwTT-PFpo686iu8U_A0BLMQ136Pc0x8vQ--x2trecLA>
    <xmx:aR5xaaCb9lkuLvgn6eKPz9BxosDxiIKyNWtaWB0AnXAlUlzurOqNgA>
    <xmx:aR5xab55WiPtI8TaOlhv_GItL5yk36vrUYItsyQlmDqyYBXqTMnn5A>
    <xmx:aR5xaZbhVgp2njkf7jnq8zSC6zg2qZg5RcSs2EIIGCfyB5AwfxCRqFDr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:43:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  newren@gmail.com
Subject: Re: [PATCH v3 6/6] fetch: delay user information post committing of
 transaction
In-Reply-To: <67808128-5f41-4ae5-b224-a76048cd82c8@gmail.com> (Phillip Wood's
	message of "Wed, 21 Jan 2026 16:21:20 +0000")
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
	<20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-6-e0edb29acbef@gmail.com>
	<67808128-5f41-4ae5-b224-a76048cd82c8@gmail.com>
Date: Wed, 21 Jan 2026 10:43:51 -0800
Message-ID: <xmqqldhqu7q0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +struct ref_update_display_info {
>> +	bool failed;
>> +	char success_code;
>> +	char fail_code;
>> +	const char *summary;
>> +	const char *fail_detail;
>> +	const char *success_detail;
>> +	const char *ref;
>> +	const char *remote;
>> +	struct object_id old_oid;
>> +	struct object_id new_oid;
>> +};
>
> I was expecting that we'd pass around a struct like
>
> struct ref_update_display_info_array {
> 	size_t alloc, nr;
> 	ref_update_display_info *info;
> };
>
> rather than passing a pointer, count pair as separate parameters. That 
> would also allow us to use ALLOC_GROW() rather than reallocating the 
> array each time we append to it which is rather inefficient.
>
> Thanks

Indeed.  That sounds like a sensible way to keep track of them.

>
> Phillip
>
>> +static struct ref_update_display_info *ref_update_display_info_append(
>> +					   struct ref_update_display_info **list,
>> +					   size_t *count,
>> +					   char success_code,
>> +					   char fail_code,
>> +					   const char *summary,
>> +					   const char *success_detail,
>> +					   const char *fail_detail,
>> +					   const char *ref,
>> +					   const char *remote,
>> +					   const struct object_id *old_oid,
>> +					   const struct object_id *new_oid)
>> +{
>> +	struct ref_update_display_info *info;
>> +	size_t index = *count;
>> +
>> +	(*count)++;
>> +	REALLOC_ARRAY(*list, *count);
>> +
>> +	info = &(*list)[index];
>> +
>> +	info->failed = false;
>> +	info->success_code = success_code;
>> +	info->fail_code = fail_code;
>> +	info->summary = xstrdup(summary);
>> +	info->success_detail = xstrdup_or_null(success_detail);
>> +	info->fail_detail = xstrdup_or_null(fail_detail);
>> +	info->remote = xstrdup(remote);
>> +	info->ref = xstrdup(ref);
>> +
>> +	oidcpy(&info->old_oid, old_oid);
>> +	oidcpy(&info->new_oid, new_oid);
>> +
>> +	return info;
>> +}
>> +
>> +static void ref_update_display_info_set_failed(struct ref_update_display_info *info)
>> +{
>> +	info->failed = true;
>> +}
>> +
>> +static void ref_update_display_info_free(struct ref_update_display_info *info)
>> +{
>> +	free((char *)info->summary);
>> +	free((char *)info->success_detail);
>> +	free((char *)info->fail_detail);
>> +	free((char *)info->remote);
>> +	free((char *)info->ref);
>> +}
>> +
>> +static void ref_update_display_info_display(struct ref_update_display_info *info,
>> +					    struct display_state *display_state,
>> +					    int summary_width)
>> +{
>> +	display_ref_update(display_state,
>> +			   info->failed ? info->fail_code : info->success_code,
>> +			   info->summary,
>> +			   info->failed ? info->fail_detail : info->success_detail,
>> +			   info->remote, info->ref, &info->old_oid,
>> +			   &info->new_oid, summary_width);
>> +}
>> +
>>   static int update_local_ref(struct ref *ref,
>>   			    struct ref_transaction *transaction,
>> -			    struct display_state *display_state,
>>   			    const struct ref *remote_ref,
>> -			    int summary_width,
>> -			    const struct fetch_config *config)
>> +			    const struct fetch_config *config,
>> +			    struct ref_update_display_info **display_list,
>> +			    size_t *display_count)
>>   {
>>   	struct commit *current = NULL, *updated;
>>   	int fast_forward = 0;
>> @@ -877,41 +952,56 @@ static int update_local_ref(struct ref *ref,
>>   
>>   	if (oideq(&ref->old_oid, &ref->new_oid)) {
>>   		if (verbosity > 0)
>> -			display_ref_update(display_state, '=', _("[up to date]"), NULL,
>> -					   remote_ref->name, ref->name,
>> -					   &ref->old_oid, &ref->new_oid, summary_width);
>> +			ref_update_display_info_append(display_list, display_count,
>> +						       '=', '=', _("[up to date]"),
>> +						       NULL, NULL, ref->name,
>> +						       remote_ref->name, &ref->old_oid,
>> +						       &ref->new_oid);
>>   		return 0;
>>   	}
>>   
>>   	if (!update_head_ok &&
>>   	    !is_null_oid(&ref->old_oid) &&
>>   	    branch_checked_out(ref->name)) {
>> +		struct ref_update_display_info *info;
>>   		/*
>>   		 * If this is the head, and it's not okay to update
>>   		 * the head, and the old value of the head isn't empty...
>>   		 */
>> -		display_ref_update(display_state, '!', _("[rejected]"),
>> -				   _("can't fetch into checked-out branch"),
>> -				   remote_ref->name, ref->name,
>> -				   &ref->old_oid, &ref->new_oid, summary_width);
>> +		info = ref_update_display_info_append(display_list, display_count,
>> +						      '!', '!', _("[rejected]"),
>> +						      NULL, _("can't fetch into checked-out branch"),
>> +						      ref->name, remote_ref->name,
>> +						      &ref->old_oid, &ref->new_oid);
>> +		ref_update_display_info_set_failed(info);
>>   		return 1;
>>   	}
>>   
>>   	if (!is_null_oid(&ref->old_oid) &&
>>   	    starts_with(ref->name, "refs/tags/")) {
>> +		struct ref_update_display_info *info;
>> +
>>   		if (force || ref->force) {
>>   			int r;
>> +
>>   			r = s_update_ref("updating tag", ref, transaction, 0);
>> -			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
>> -					   r ? _("unable to update local ref") : NULL,
>> -					   remote_ref->name, ref->name,
>> -					   &ref->old_oid, &ref->new_oid, summary_width);
>> +
>> +			info = ref_update_display_info_append(display_list, display_count,
>> +							      't', '!', _("[tag update]"), NULL,
>> +							      _("unable to update local ref"),
>> +							      ref->name, remote_ref->name,
>> +							      &ref->old_oid, &ref->new_oid);
>> +			if (r)
>> +				ref_update_display_info_set_failed(info);
>> +
>>   			return r;
>>   		} else {
>> -			display_ref_update(display_state, '!', _("[rejected]"),
>> -					   _("would clobber existing tag"),
>> -					   remote_ref->name, ref->name,
>> -					   &ref->old_oid, &ref->new_oid, summary_width);
>> +			info = ref_update_display_info_append(display_list, display_count,
>> +							      '!', '!', _("[rejected]"), NULL,
>> +							      _("would clobber existing tag"),
>> +							      ref->name, remote_ref->name,
>> +							      &ref->old_oid, &ref->new_oid);
>> +			ref_update_display_info_set_failed(info);
>>   			return 1;
>>   		}
>>   	}
>> @@ -921,6 +1011,7 @@ static int update_local_ref(struct ref *ref,
>>   	updated = lookup_commit_reference_gently(the_repository,
>>   						 &ref->new_oid, 1);
>>   	if (!current || !updated) {
>> +		struct ref_update_display_info *info;
>>   		const char *msg;
>>   		const char *what;
>>   		int r;
>> @@ -941,10 +1032,15 @@ static int update_local_ref(struct ref *ref,
>>   		}
>>   
>>   		r = s_update_ref(msg, ref, transaction, 0);
>> -		display_ref_update(display_state, r ? '!' : '*', what,
>> -				   r ? _("unable to update local ref") : NULL,
>> -				   remote_ref->name, ref->name,
>> -				   &ref->old_oid, &ref->new_oid, summary_width);
>> +
>> +		info = ref_update_display_info_append(display_list, display_count,
>> +						      '*', '!', what, NULL,
>> +						      _("unable to update local ref"),
>> +						      ref->name, remote_ref->name,
>> +						      &ref->old_oid, &ref->new_oid);
>> +		if (r)
>> +			ref_update_display_info_set_failed(info);
>> +
>>   		return r;
>>   	}
>>   
>> @@ -960,6 +1056,7 @@ static int update_local_ref(struct ref *ref,
>>   	}
>>   
>>   	if (fast_forward) {
>> +		struct ref_update_display_info *info;
>>   		struct strbuf quickref = STRBUF_INIT;
>>   		int r;
>>   
>> @@ -967,29 +1064,46 @@ static int update_local_ref(struct ref *ref,
>>   		strbuf_addstr(&quickref, "..");
>>   		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
>>   		r = s_update_ref("fast-forward", ref, transaction, 1);
>> -		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
>> -				   r ? _("unable to update local ref") : NULL,
>> -				   remote_ref->name, ref->name,
>> -				   &ref->old_oid, &ref->new_oid, summary_width);
>> +
>> +		info = ref_update_display_info_append(display_list, display_count,
>> +						      ' ', '!', quickref.buf, NULL,
>> +						      _("unable to update local ref"),
>> +						      ref->name, remote_ref->name,
>> +						      &ref->old_oid, &ref->new_oid);
>> +		if (r)
>> +			ref_update_display_info_set_failed(info);
>> +
>>   		strbuf_release(&quickref);
>>   		return r;
>>   	} else if (force || ref->force) {
>> +		struct ref_update_display_info *info;
>>   		struct strbuf quickref = STRBUF_INIT;
>>   		int r;
>> +
>>   		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
>>   		strbuf_addstr(&quickref, "...");
>>   		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
>>   		r = s_update_ref("forced-update", ref, transaction, 1);
>> -		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
>> -				   r ? _("unable to update local ref") : _("forced update"),
>> -				   remote_ref->name, ref->name,
>> -				   &ref->old_oid, &ref->new_oid, summary_width);
>> +
>> +		info = ref_update_display_info_append(display_list, display_count,
>> +						      '+', '!', quickref.buf, _("forced update"),
>> +						      _("unable to update local ref"),
>> +						      ref->name, remote_ref->name,
>> +						      &ref->old_oid, &ref->new_oid);
>> +
>> +		if (r)
>> +			ref_update_display_info_set_failed(info);
>> +
>>   		strbuf_release(&quickref);
>>   		return r;
>>   	} else {
>> -		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forward"),
>> -				   remote_ref->name, ref->name,
>> -				   &ref->old_oid, &ref->new_oid, summary_width);
>> +		struct ref_update_display_info *info;
>> +		info = ref_update_display_info_append(display_list, display_count,
>> +						      '!', '!', _("[rejected]"), NULL,
>> +						      _("non-fast-forward"),
>> +						      ref->name, remote_ref->name,
>> +						      &ref->old_oid, &ref->new_oid);
>> +		ref_update_display_info_set_failed(info);
>>   		return 1;
>>   	}
>>   }
>> @@ -1103,17 +1217,15 @@ static int store_updated_refs(struct display_state *display_state,
>>   			      int connectivity_checked,
>>   			      struct ref_transaction *transaction, struct ref *ref_map,
>>   			      struct fetch_head *fetch_head,
>> -			      const struct fetch_config *config)
>> +			      const struct fetch_config *config,
>> +			      struct ref_update_display_info **display_list,
>> +			      size_t *display_count)
>>   {
>>   	int rc = 0;
>>   	struct strbuf note = STRBUF_INIT;
>>   	const char *what, *kind;
>>   	struct ref *rm;
>>   	int want_status;
>> -	int summary_width = 0;
>> -
>> -	if (verbosity >= 0)
>> -		summary_width = transport_summary_width(ref_map);
>>   
>>   	if (!connectivity_checked) {
>>   		struct check_connected_options opt = CHECK_CONNECTED_INIT;
>> @@ -1218,8 +1330,9 @@ static int store_updated_refs(struct display_state *display_state,
>>   					  display_state->url_len);
>>   
>>   			if (ref) {
>> -				rc |= update_local_ref(ref, transaction, display_state,
>> -						       rm, summary_width, config);
>> +				rc |= update_local_ref(ref, transaction, rm,
>> +						       config, display_list,
>> +						       display_count);
>>   				free(ref);
>>   			} else if (write_fetch_head || dry_run) {
>>   				/*
>> @@ -1227,12 +1340,11 @@ static int store_updated_refs(struct display_state *display_state,
>>   				 * would be written to FETCH_HEAD, if --dry-run
>>   				 * is set).
>>   				 */
>> -				display_ref_update(display_state, '*',
>> -						   *kind ? kind : "branch", NULL,
>> -						   rm->name,
>> -						   "FETCH_HEAD",
>> -						   &rm->new_oid, &rm->old_oid,
>> -						   summary_width);
>> +
>> +				ref_update_display_info_append(display_list, display_count,
>> +							       '*', '*', *kind ? kind : "branch",
>> +							       NULL, NULL, "FETCH_HEAD", rm->name,
>> +							       &rm->new_oid, &rm->old_oid);
>>   			}
>>   		}
>>   	}
>> @@ -1300,7 +1412,9 @@ static int fetch_and_consume_refs(struct display_state *display_state,
>>   				  struct ref_transaction *transaction,
>>   				  struct ref *ref_map,
>>   				  struct fetch_head *fetch_head,
>> -				  const struct fetch_config *config)
>> +				  const struct fetch_config *config,
>> +				  struct ref_update_display_info **display_list,
>> +				  size_t *display_count)
>>   {
>>   	int connectivity_checked = 1;
>>   	int ret;
>> @@ -1322,7 +1436,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
>>   
>>   	trace2_region_enter("fetch", "consume_refs", the_repository);
>>   	ret = store_updated_refs(display_state, connectivity_checked,
>> -				 transaction, ref_map, fetch_head, config);
>> +				 transaction, ref_map, fetch_head, config,
>> +				 display_list, display_count);
>>   	trace2_region_leave("fetch", "consume_refs", the_repository);
>>   
>>   out:
>> @@ -1493,7 +1608,9 @@ static int backfill_tags(struct display_state *display_state,
>>   			 struct ref_transaction *transaction,
>>   			 struct ref *ref_map,
>>   			 struct fetch_head *fetch_head,
>> -			 const struct fetch_config *config)
>> +			 const struct fetch_config *config,
>> +			 struct ref_update_display_info **display_list,
>> +			 size_t *display_count)
>>   {
>>   	int retcode, cannot_reuse;
>>   
>> @@ -1515,7 +1632,7 @@ static int backfill_tags(struct display_state *display_state,
>>   	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>>   	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
>>   	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
>> -					 fetch_head, config);
>> +					 fetch_head, config, display_list, display_count);
>>   
>>   	if (gsecondary) {
>>   		transport_disconnect(gsecondary);
>> @@ -1641,6 +1758,7 @@ struct ref_rejection_data {
>>   	bool conflict_msg_shown;
>>   	bool case_sensitive_msg_shown;
>>   	const char *remote_name;
>> +	struct strmap *rejected_refs;
>>   };
>>   
>>   static void ref_transaction_rejection_handler(const char *refname,
>> @@ -1681,6 +1799,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>>   			      refname, ref_transaction_error_msg(err));
>>   	}
>>   
>> +	strmap_put(data->rejected_refs, refname, NULL);
>>   	*data->retcode = 1;
>>   }
>>   
>> @@ -1690,6 +1809,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>>    */
>>   static int commit_ref_transaction(struct ref_transaction **transaction,
>>   				  bool is_atomic, const char *remote_name,
>> +				  struct strmap *rejected_refs,
>>   				  struct strbuf *err)
>>   {
>>   	int retcode = ref_transaction_commit(*transaction, err);
>> @@ -1701,6 +1821,7 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
>>   			.conflict_msg_shown = 0,
>>   			.remote_name = remote_name,
>>   			.retcode = &retcode,
>> +			.rejected_refs = rejected_refs,
>>   		};
>>   
>>   		ref_transaction_for_each_rejected_update(*transaction,
>> @@ -1729,6 +1850,10 @@ static int do_fetch(struct transport *transport,
>>   	struct fetch_head fetch_head = { 0 };
>>   	struct strbuf err = STRBUF_INIT;
>>   	int do_set_head = 0;
>> +	struct ref_update_display_info *display_list = NULL;
>> +	struct strmap rejected_refs = STRMAP_INIT;
>> +	size_t display_count = 0;
>> +	int summary_width = 0;
>>   
>>   	if (tags == TAGS_DEFAULT) {
>>   		if (transport->remote->fetch_tags == 2)
>> @@ -1853,7 +1978,7 @@ static int do_fetch(struct transport *transport,
>>   	}
>>   
>>   	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
>> -				   &fetch_head, config)) {
>> +				   &fetch_head, config, &display_list, &display_count)) {
>>   		retcode = 1;
>>   		goto cleanup;
>>   	}
>> @@ -1876,7 +2001,7 @@ static int do_fetch(struct transport *transport,
>>   			 * the transaction and don't commit anything.
>>   			 */
>>   			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
>> -					  &fetch_head, config))
>> +					  &fetch_head, config, &display_list, &display_count))
>>   				retcode = 1;
>>   		}
>>   
>> @@ -1886,8 +2011,12 @@ static int do_fetch(struct transport *transport,
>>   	if (retcode)
>>   		goto cleanup;
>>   
>> +	if (verbosity >= 0)
>> +		summary_width = transport_summary_width(ref_map);
>> +
>>   	retcode = commit_ref_transaction(&transaction, atomic_fetch,
>> -					 transport->remote->name, &err);
>> +					 transport->remote->name,
>> +					 &rejected_refs, &err);
>>   	/*
>>   	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
>>   	 * continue to fetch head and perform other post-fetch operations.
>> @@ -1965,7 +2094,17 @@ static int do_fetch(struct transport *transport,
>>   	 */
>>   	if (retcode && !atomic_fetch && transaction)
>>   		commit_ref_transaction(&transaction, false,
>> -				       transport->remote->name, &err);
>> +				       transport->remote->name,
>> +				       &rejected_refs, &err);
>> +
>> +	for (size_t i = 0; i < display_count; i++) {
>> +		struct ref_update_display_info *info = &display_list[i];
>> +
>> +		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
>> +			ref_update_display_info_set_failed(info);
>> +		ref_update_display_info_display(info, &display_state, summary_width);
>> +		ref_update_display_info_free(info);
>> +	}
>>   
>>   	if (retcode) {
>>   		if (err.len) {
>> @@ -1980,6 +2119,9 @@ static int do_fetch(struct transport *transport,
>>   
>>   	if (transaction)
>>   		ref_transaction_free(transaction);
>> +
>> +	free(display_list);
>> +	strmap_clear(&rejected_refs, 0);
>>   	display_state_release(&display_state);
>>   	close_fetch_head(&fetch_head);
>>   	strbuf_release(&err);
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 45595991c8..29e2f17608 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -1893,6 +1893,7 @@ test_expect_success 'pushing non-commit objects should report error' '
>>   
>>   		tagsha=$(git rev-parse test^{tag}) &&
>>   		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
>> +		test_grep "! \[remote rejected\] $tagsha -> branch (invalid new value provided)" err &&
>>   		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
>>   	)
>>   '
>> 
