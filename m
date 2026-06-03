Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DF3B19BA
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530579; cv=none; b=XDkkHyCb/Y1NCJk1JfkNoJgIoV/xid3QmXYjVI97/ZRpemwVJcn7/CKZGKrKXZtVrTp0ACbpilosZmf2e+jQBVAusrBKcd5us/BB+CHrQwPowSszFZ+Hum3xkY+1265sdfeq73Z9m0Fb+LwSqPIZkpvMJNrGvAmh0v5yVkHwSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530579; c=relaxed/simple;
	bh=iZPWLn84+d9X9+K2Gxpb50hHmTGYglvJqUSFdsvVE6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMd0O+0CEx7z6rJpsGrssoZlMriHKpOd3usLzfotIwMdNiUr/kXIHhFapNFlUSVFBqQRBLdGwndP0PNZd+5PXYvPykJM9HE5zIe27SBpk15zSKr8tOM09PuskUmCAMzW0Wh56/G8Fym+YHSRH4ub4HblgTaNSDYe5x5YCCIbg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zcpms8OI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObyRKNI/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zcpms8OI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObyRKNI/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1B2714000B1;
	Wed,  3 Jun 2026 19:49:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 03 Jun 2026 19:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780530576; x=1780616976; bh=7Z5Wlz6r6v
	PrIHvpjeVwab31Gf3Z1lEbg1l73AsWXnE=; b=Zcpms8OIn9PlmDqbHzfJEUxy8n
	BCRJ2XYt/wyjLwE8JzFwHNk/Vo0+JtYKYxuFOnqbjXuAX4vQnNP27sbW4CNoR6cU
	0w3TeuJPSJ/QTwKjjHNX0eZYLyAMul5XK7kZrQXkd3Orb5UeOPVTnH+ZMUfCYQig
	UcbtDGO4HwmEGFn/UnDUZ4woohS0mtN7pMcH6Fj5GRj5IgXFvk6cWyuSdqmoL2/i
	m7/s4mIt44WFWTpPHjwzr6loq6bb3GBNtVXwUI9/3yQLPWTgGnbIHYzz/iIoMxbJ
	aIIorEXZsp3nea/B3kLhxdMQY09ajSHWh4sTuqx79Lh1Rcgxhih+h+va7+BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780530576; x=1780616976; bh=7Z5Wlz6r6vPrIHvpjeVwab31Gf3Z1lEbg1l
	73AsWXnE=; b=ObyRKNI/AzetN1ap0d5lcIY/6Mw04i9ZDRDftRYT31bM7AlE9Vw
	CQQ7GCDf/eHYy1LsMfUfWV3YgI5hZo08hK954rO39uHUA4+TGRT1KSQYfWTm8wyq
	wc28oFCLJt1ihXUVu9Udt5gVQrKYiegt5PweqBjqxymHmMAOLczXsZDnLiruFbMk
	0gxaRtUKdk0Lbpv0iwVOEc1X0ocfHarHOY2AhcDUyuJ1uhhXbjYLWjBc4gwhE1dA
	nK7gAL7ht/0I6kHAf1dQ+33eDBJKcj9JSy75rN3TAwxjvLTdA5bRdxG4oZHZ+h3r
	1H2uBsqQjakL2Tkt1yXuvXiBO8/SuFVYpKQ==
X-ME-Sender: <xms:kL0garpfQ5zDGAMu66-iUy1S2gVl-zSD1IEocDaIOXdOPP8OaZp8DA>
    <xme:kL0gasqeV_-jd5y1VILN1v7JlJwGsuHUuGDMvHlVadXhd0NAzmAjXSaA-gbcw1spf
    UwSDmdI-OtHC9TGP-c0Yf7NpQXLDfLNH82I0fBBEIpbZvx95ztk>
X-ME-Received: <xmr:kL0gatMlGm2R8y9RYJLNHiY07Uab7Vr7QHvrG8vNy0xv3wNyOuxIJIuNQUN_Ia5AHmS7vqrVq82ORSObkwRYpG9SHXEYBfgWakzu>
X-ME-Proxy-Cause: dmFkZTEo3oohiXXS0o0OZBUJphzm4JrBPpwO/8smT8Fssj32V2Gm2qgcs1vbVtr4LtjGjB
    rrRYsrUK4z5WhsQaWYrLjU6ZpvvrxF/i8pcBNco7Z3XaO43gFsjMals6xTFQtDOLDZ4Vht
    w8l6rjkPLsi/rZ3BtwViJD/esz0rLv1kemb1KCOhFJh33D9BULmHmgKvdf2J300f1GafZU
    uHDAYv3jorQj0Cec0SioNDebQbApuo+tPA/1Ahek1ynC9MxEmh9Un8VnIL5+ttcdMlJd8y
    qE76oP+DDkxxTInTxHmqjrl87ndCiFlUYCI07ZQz9AasBKjdptqdjIpVyBBoSvf++7acFu
    HEXtB6o8YUt32MTCvXWTzlCk59Cuo0ypyY5Ac+kIGp3vDFb9OeCo/QB63F5fjByg6nrEYQ
    gmHS3SbhN6nTPJlCzytYR+7knUYQ2L/Qg4vFPOaYS8lcDvv6l7blBF8lhFmqA0UQxacJDq
    wTBMYBl6Jt7xNiZIT7EDfxrwVIMsiADUlX3h7ASI0YIxaioFleXa5jt9m1nr4lk5D58Jx4
    sl73AnVvNm2Fk/TGqJK6PiagSsUOKkI3DV5tvxbIxlvuw+x8zywXxSDnPpecN5Ru70KB2E
    YNjQvLWnZTIw7+Cc1aaq3ZkD/5h17hC5BpRfi3+FsExW3kXaHcCVS3gKQ4Eg
X-ME-Proxy: <xmx:kL0gaty6waNdDo_3Db1BJ5hZOr3oKuG4N7A9uq_tOtevfOmyZZMC5w>
    <xmx:kL0gamttb38WcngSWEniJlJRnTUWrwwcqDgops76js3Kw31Fx00J2g>
    <xmx:kL0gam4G-lUZUBaZ04HuZkoriFFgXYHQ1iwhJsUwW2MvJ-5vOuQrYw>
    <xmx:kL0galSkjhZU9vrJiGKvKbmASDF6IGbFaDC4pSOdothUE4dt06Zdcg>
    <xmx:kL0gasuxBNB2wnvW6qWqYNUzHZDQ0XEsm9L5gqqkz80X827y42TNMjAq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 19:49:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Pablo Sabater <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v2 4/9] reset: introduce dry-run mode
In-Reply-To: <20260603-b4-pks-history-drop-v2-4-742cb5b5176d@pks.im> (Patrick
	Steinhardt's message of "Wed, 03 Jun 2026 18:14:03 +0200")
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
	<20260603-b4-pks-history-drop-v2-4-742cb5b5176d@pks.im>
Date: Thu, 04 Jun 2026 08:49:34 +0900
Message-ID: <xmqqv7bzqj5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit we'll add add another caller to `reset_head()`

add add?

> that wants to perform a dry-run check of whether it would be possible to
> udpate the index and working tree when moving to a new commit. Introduce

udpate?

> a new flag that lets the caller perform this operation.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reset.c | 44 +++++++++++++++++++++++++++++++++-----------
>  reset.h |  6 ++++++
>  2 files changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/reset.c b/reset.c
> index 9ff14f5ed1..a8d7eea4d6 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -92,11 +92,14 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
>  	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
>  	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
> +	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
>  	struct object_id *head = NULL, head_oid;
>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>  	struct lock_file lock = LOCK_INIT;
>  	struct unpack_trees_options unpack_tree_opts = { 0 };
>  	struct tree *tree;
> +	struct index_state scratch_index = INDEX_STATE_INIT(r);
> +	struct index_state *istate;
>  	const char *action;
>  	int ret = 0, nr = 0;
>  
> @@ -109,7 +112,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  	if (opts->branch_msg && !opts->branch)
>  		BUG("branch reflog message given without a branch");
>  
> -	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
> +	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
>  		ret = -1;
>  		goto leave_reset_head;
>  	}
> @@ -124,16 +127,36 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  	if (!oid)
>  		oid = &head_oid;
>  
> -	if (refs_only)
> -		return update_refs(r, opts, oid, head);
> +	if (refs_only) {
> +		if (!dry_run)
> +			return update_refs(r, opts, oid, head);
> +		return 0;
> +	}
> +
> +	if (dry_run) {
> +		if (read_index_from(&scratch_index, r->index_file, r->gitdir) < 0 ||
> +		    index_state_unmerged_to_stage0(&scratch_index) < 0) {
> +			ret = error(_("could not read index"));
> +			goto leave_reset_head;
> +		}
> +
> +		istate = &scratch_index;
> +	} else {
> +		if (repo_read_index_unmerged(r) < 0) {
> +			ret = error(_("could not read index"));
> +			goto leave_reset_head;
> +		}
> +		istate = r->index;
> +	}
>  
>  	action = reset_hard ? "reset" : "checkout";
>  	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
>  	unpack_tree_opts.head_idx = 1;
> -	unpack_tree_opts.src_index = r->index;
> -	unpack_tree_opts.dst_index = r->index;
> +	unpack_tree_opts.src_index = istate;
> +	unpack_tree_opts.dst_index = istate;
>  	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
> -	unpack_tree_opts.update = 1;
> +	unpack_tree_opts.update = !dry_run;
> +	unpack_tree_opts.dry_run = dry_run;
>  	unpack_tree_opts.merge = 1;
>  	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
>  	unpack_tree_opts.skip_cache_tree_update = 1;
> @@ -141,11 +164,6 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  	if (reset_hard)
>  		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
>  
> -	if (repo_read_index_unmerged(r) < 0) {
> -		ret = error(_("could not read index"));
> -		goto leave_reset_head;
> -	}
> -
>  	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
>  		ret = error(_("failed to find tree of %s"),
>  			    oid_to_hex(&head_oid));
> @@ -162,6 +180,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  		goto leave_reset_head;
>  	}
>  
> +	if (dry_run)
> +		goto leave_reset_head;
> +
>  	tree = repo_parse_tree_indirect(r, oid);
>  	if (!tree) {
>  		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
> @@ -181,6 +202,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  leave_reset_head:
>  	rollback_lock_file(&lock);
>  	clear_unpack_trees_porcelain(&unpack_tree_opts);
> +	release_index(&scratch_index);
>  	while (nr)
>  		free((void *)desc[--nr].buffer);
>  	return ret;
> diff --git a/reset.h b/reset.h
> index 97ced2601e..9f696382c1 100644
> --- a/reset.h
> +++ b/reset.h
> @@ -21,6 +21,12 @@ enum reset_head_flags {
>  
>  	/* Update ORIG_HEAD as well as HEAD */
>  	RESET_HEAD_ORIG_HEAD = (1 << 4),
> +
> +	/*
> +	 * Perform a dry-run by performing the operation without updating
> +	 * any user-visible state.
> +	 */
> +	RESET_HEAD_DRY_RUN = (1 << 5),
>  };
>  
>  struct reset_head_opts {
