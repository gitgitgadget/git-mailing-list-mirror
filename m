Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF14336EC5
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514867; cv=none; b=GLwZ8vX+tOTH9DqU3NQXcuHRATfUMrxiCIa9w6+WPOZ/GeqJVnByFMt/FIcV4QSwCW2Z6vT/L7YiInfBs8WoyBzBeoE3203HaVjhlJAAJ16pp4Y8TnlIcDLS2XEhIiI18MhQhPYMssocLNxeMwFZBmExyZk2Ror6RwRV49jwjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514867; c=relaxed/simple;
	bh=us7PNMSLpJDfTcDJizVbLePBLn89WLcMHWebtBCYOxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH2k7BvTaAc2P/sS8T6NBjsDjY3YVSkshpqHjRbjN9KO5KAcjCXWuU9i3g28YrYWit1X0+95zc/g+wRg07ZXeCEnpYTEPqlVlAuSjgdRCaWYv1dS8/uGkj9vkvVTIl3nhxMGtSW4SYNSkIJvCheB0qhQAKU7tDk4G1gdy9dZkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fteq5Eo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iC8V97No; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fteq5Eo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iC8V97No"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 071C91400142;
	Wed, 12 Aug 2026 02:07:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 02:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786514860; x=1786601260; bh=1cVC9flelG
	jMSdp7JWtJF/4ZUidgMK5scD8Zs5ur3hY=; b=Fteq5Eo0AzW612p1LD9rR0dXG5
	M9HGu1D1ecw7Rd/HdX/l0n9UoGoDnO6fZE416tFWKNHsvYdPWXApNLOXITj3bwdd
	avp34q9IMkwYoVHSXz4hQfmrjVobzwJ0QoMTa8hc+jIG8k2qE7McnugwXXdbrjd+
	Dy/KdSi6LRo6cUNgsH2vquxLJrnnWQxgLN2XBqIS1fNPtA++nh6hcgXO5sX47p3A
	rMcwjXz5aGaK5Au2EIGzLekFiyDKBhjB2wKZC6WTlWHUItlmNVgpKwFqp+tKtzMz
	cLhMsOONeBt/pCrES8LrHgjeep8I/D9RUF2qhKSA0V5g/sK1RmrFyd5BZ6fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786514860; x=1786601260; bh=1cVC9flelGjMSdp7JWtJF/4ZUidgMK5scD8
	Zs5ur3hY=; b=iC8V97No+0U+IKRAHQMPZ0xDgXYSypcD8b5bG7R1EPazTxXREAw
	nZI7VYc2X0utP4zBNmd74d+V6ALmn8DTa5Gke8Sd3a780hXLdWrcQo2pYv5qOEjD
	FUKrglOpRAC8xNaWoPfXqfbuinaL5mDjHQW3hp3Wxd48ZAaps9FYjnV9bnco5NzT
	Fhde62ziEUndGGJ4gI5YiUnxJmvFaAnShXhCSYPkE9xwPQ1ZHFP5oAdy54c3Ecpk
	slQF1epZoIt4ghhopkR1uVWdaHZO3QSEdbSOmJXs2NajjzQ8f7MQZIcLhlNva2zM
	ikcTuDemgUFQCfya46uqO47XevCyoNAKjxA==
X-ME-Sender: <xms:qw18auc_KnzwccpY7xtk-4NCB5LZnpK3ABrn6mA-JSWnJpZTBFHFMg>
    <xme:qw18avq2LMA8hx_AqCqC9ukxge9QpDnI2YIedx7lm536IxeJg1ryWNL6AW_DiDKMI
    -_f-BvWv201FDcrpevQkbEKGKYCAy05OaRsVcTiFzbGpqXVnDLd58M>
X-ME-Received: <xmr:qw18as6MZK7yKt4I3KvhzwFWPiovg4wtQ8xTZTfTn7Q2NeMBHypuMBECRwQ522s8X0x-aPxALGEj5zlcdC6KCPSuC5SgyXzBPhJaaWwz5g>
X-ME-Proxy-Cause: dmFkZTEFa/Zscvf1FdRmme3iU9S/R9bSS5hRr3TT4us3bRgS/Dd2WssknzTZsrBVpIb7cY
    lpx+HautICEUXOmq1Qv+MwTyiGxndQyxmlh9qapmLgKNQtIkkRduM+LB444XCANg4B3XYW
    ydGhDkC1lvxrg+mVaBOHVtCPWbTeJ6j363YnmW1kIdmX5Fdmn8jEXemj0nJdlUlmJ96lGG
    r/gTC/AzuyB03pIN5d5JEV/IHMg2kMpkeaVHhjrIZuosbf8rHAqCfP0bPeZXJJhI+GLsT9
    bzSUsCmhKtlaZ8IAEOuNf7xFjD+ZbUBImS7f5Xj5A8MMP7hI63dSvShi5a/MrlDHHYKMF/
    Wz2skvaqedqVU1MWt8zRzK9/mWO3nPTVTbHtgKiQwMds1s+UzD5CcKkf6KkZfMtQ1yIY9N
    Jn23F2bMkXkXxig28pPuUBT1WB28ctE8PqhrKHtwy0np7bs6iYtd2JbbD3zM+MrLwPSukX
    yZ8qsgmtV2Y/oUKfhkQX26xquNxUbOUYv5Yuw1ArXr6u3Vq/H7YF7YocPaDFUTUOGefFpU
    zSLwqHab2i4U++Ke2YG5PWLwkWFBHMmvVnO+2jrUBQwkpPcOXZuBRoQCxIFVJJSTn5XQRy
    QssD9nGIbtkR0xBeWFPSQTUEmAD6tBDYo2c1xgLkS5LMEMqvJE8OJwB3wDug
X-ME-Proxy: <xmx:qw18alqLA_J2_fUfTb4_pxRGZeLKairTMRtkY6lp17OVT02GgVeOiQ>
    <xmx:qw18auisDije0R-eEQLaw7WggHHIXJV9bnJO60vhkKW7ejtiCKwUBQ>
    <xmx:qw18avKPCd4E0Q2wlKL4XezvzJjB8d1rQ6kLkRqsy8Q6ltgYULlplw>
    <xmx:qw18auC_UB7cBaRl9eDqAXyduzu8gcVmDdjJPGPqRouvYKf7ce93pg>
    <xmx:rA18arodjf3PRn8OYjQcQU5rMoKRw7FTPnbVvssPUmCliQCC-MsUSlP1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 02:07:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5c22cc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 06:07:38 +0000 (UTC)
Date: Wed, 12 Aug 2026 08:07:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/9] odb/transaction: add transaction finalize
 interface
Message-ID: <anwNp8cbCOOuI7nK@pks.im>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811175415.2044235-3-jltobler@gmail.com>

On Tue, Aug 11, 2026 at 12:54:08PM -0500, Justin Tobler wrote:
> When committing an ODB transaction via `odb_transaction_commit()`, the
> staged objects are made visible and the underlying transaction is freed
> at the same time. Coupling these two steps does not leave room for any
> post-commit transaction operations to be introduced though. Such a
> capability is useful if an ODB transaction backend needs to hold on to
> lockfiles after transaction commit until references are updated, as is
> the case with the existing "files" backend in git-receive-pack(1).
> 
> Stop freeing the transaction in `odb_transaction_commit()` and introduce
> `odb_transaction_finalize()` to explicitly clean up the transaction
> accordingly. Note that the finalize interface also provides an optional
> callback for any backend-specific deferred cleanup. In a subsequent
> commit, the "files" transaction backend will use this to remove ".keep"
> files generated for packfiles received via git-receive-pack(1) after
> references have been updated. In preparation for this, the
> `odb_transaction_finalize()` call site in git-receive-pack(1) is made
> after the reference updates are finished.
> 
> All other callers commit a transaction and immediately finalize it with
> no work in between and cannot meaningfully recover should either step
> fail, so introduce an `odb_transaction_commit_and_finalize_or_die()`

"step fail"? I guess this ought to just read "fail"?

> helper that performs both and dies on error. Call sites are updated
> accordingly.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  builtin/add.c            |  4 ++--
>  builtin/receive-pack.c   |  1 +
>  builtin/unpack-objects.c |  2 +-
>  builtin/update-index.c   |  4 ++--
>  cache-tree.c             |  2 +-
>  object-file.c            |  2 +-
>  odb/transaction.c        | 14 ++++++++++++++
>  odb/transaction.h        | 23 +++++++++++++++++++++++
>  read-cache.c             |  2 +-
>  9 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 60ffbede2b..ad418a5952 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -393,7 +393,7 @@ int cmd_add(int argc,
>  	char *seen = NULL;
>  	char *ps_matched = NULL;
>  	struct lock_file lock_file = LOCK_INIT;
> -	struct odb_transaction *transaction;
> +	struct odb_transaction *transaction = NULL;
>  
>  	repo_config(repo, add_config, NULL);
>  
> @@ -600,7 +600,7 @@ int cmd_add(int argc,
>  
>  	if (chmod_arg && pathspec.nr)
>  		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
> -	odb_transaction_commit(transaction);
> +	odb_transaction_commit_and_finalize_or_die(transaction);
>  
>  finish:
>  	if (write_locked_index(repo->index, &lock_file,
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index d74b787148..ed1edcbe93 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2720,6 +2720,7 @@ int cmd_receive_pack(int argc,
>  		use_keepalive = KEEPALIVE_ALWAYS;
>  		execute_commands(commands, unpack_status, &si, transaction,
>  				 &push_options);
> +		odb_transaction_finalize(transaction);
>  		delete_tempfile(&pack_lockfile);
>  		sigchain_push(SIGPIPE, SIG_IGN);
>  		if (report_status_v2)
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 4263edfbec..d6a2d616d9 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -603,7 +603,7 @@ static void unpack_all(void)
>  		unpack_one(i);
>  		display_progress(progress, i + 1);
>  	}
> -	odb_transaction_commit(transaction);
> +	odb_transaction_commit_and_finalize_or_die(transaction);
>  	stop_progress(&progress);
>  
>  	if (delta_list)
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 241abd4332..b25d4ecb10 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1156,7 +1156,7 @@ int cmd_update_index(int argc,
>  			 * a transaction.
>  			 */
>  			if (transaction && verbose) {
> -				odb_transaction_commit(transaction);
> +				odb_transaction_commit_and_finalize_or_die(transaction);
>  				transaction = NULL;
>  			}
>  
> @@ -1224,7 +1224,7 @@ int cmd_update_index(int argc,
>  	/*
>  	 * By now we have added all of the new objects
>  	 */
> -	odb_transaction_commit(transaction);
> +	odb_transaction_commit_and_finalize_or_die(transaction);
>  
>  	if (split_index > 0) {
>  		if (repo_config_get_split_index(the_repository) == 0)
> diff --git a/cache-tree.c b/cache-tree.c
> index d92f513286..a220372a42 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -538,7 +538,7 @@ int cache_tree_update(struct index_state *istate, int flags)
>  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
>  		       "", 0, &skip, flags);
>  	if (!inflight)
> -		odb_transaction_commit(transaction);
> +		odb_transaction_commit_and_finalize_or_die(transaction);
>  	trace2_region_leave("cache_tree", "update", istate->repo);
>  	trace_performance_leave("cache_tree_update");
>  	if (i < 0)
> diff --git a/object-file.c b/object-file.c
> index ec35c318bc..4d03c167d5 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -965,7 +965,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  								  xsize_t(st->st_size),
>  								  oid);
>  			if (!inflight)
> -				odb_transaction_commit(transaction);
> +				odb_transaction_commit_and_finalize_or_die(transaction);
>  		} else {
>  			ret = hash_blob_stream(&stream,
>  					       the_repository->hash_algo, oid,
> diff --git a/odb/transaction.c b/odb/transaction.c
> index dab7da6a9a..9e9a982778 100644
> --- a/odb/transaction.c
> +++ b/odb/transaction.c
> @@ -33,6 +33,20 @@ int odb_transaction_commit(struct odb_transaction *transaction)
>  
>  	ret = transaction->commit(transaction);
>  	transaction->source->odb->transaction = NULL;
> +
> +	return ret;
> +}
> +
> +int odb_transaction_finalize(struct odb_transaction *transaction)
> +{
> +	int ret = 0;
> +
> +	if (!transaction)
> +		return 0;
> +
> +	if (transaction->finalize)
> +		ret = transaction->finalize(transaction);
> +
>  	free(transaction);
>  
>  	return ret;
> diff --git a/odb/transaction.h b/odb/transaction.h
> index 4cb2eafcbf..6ed39b3d0e 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -22,6 +22,13 @@ struct odb_transaction {
>  	 */
>  	int (*commit)(struct odb_transaction *transaction);
>  
> +	/*
> +	 * Optional ODB source specific callback invoked when the transaction
> +	 * needs to perform any deferred cleanup after objects have been
> +	 * committed. Returns 0 on success, a negative error code otherwise.
> +	 */
> +	int (*finalize)(struct odb_transaction *transaction);
> +
>  	/*
>  	 * This callback is expected to write the given object stream into
>  	 * the ODB transaction. Note that for now, only blobs support streaming.
> @@ -75,6 +82,22 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
>   */
>  int odb_transaction_commit(struct odb_transaction *transaction);
>  
> +/*
> + * Finalizes an ODB transaction, performing any deferred cleanup and freeing it.
> + * Must be called for every successfully started transaction. Note that, if the
> + * specified transaction is NULL, the function is a no-op. Returns 0 on success,
> + * a negative error code otherwise.
> + */
> +int odb_transaction_finalize(struct odb_transaction *transaction);
> +
> +static inline void odb_transaction_commit_and_finalize_or_die(struct odb_transaction *transaction)
> +{
> +	if (odb_transaction_commit(transaction))
> +		die(_("failed to commit ODB transaction"));
> +	if (odb_transaction_finalize(transaction))
> +		die(_("failed to finalize ODB transaction"));
> +}
> +
>  /*
>   * Writes the object in the provided stream into the transaction. The resulting
>   * object ID is written into the out pointer. Returns 0 on success, a negative
> diff --git a/read-cache.c b/read-cache.c
> index 6c449f393d..0cd0ef85ec 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -4049,7 +4049,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
>  		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
>  	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
>  	if (!inflight)
> -		odb_transaction_commit(transaction);
> +		odb_transaction_commit_and_finalize_or_die(transaction);
>  
>  	release_revisions(&rev);
>  	return !!data.add_errors;
> -- 
> 2.55.0.424.g13c7afec21
> 
