Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CF346E7A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938614; cv=none; b=HgREj9rNNWxT1sMaB8xzczmBYxwSRE0banrTcbTkgn8xd9wzflFvwA/IqGaasKVAfyJehMi0JjBBzc3cUxYGTaezSwIzqyLgke//VXrqoXnqWqH5Sb2CPS4LIY+qBi2SFCjhDTAMItTIiQVgiRjCYaLqpp+WDbAf63E0uEknMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938614; c=relaxed/simple;
	bh=531/z3jt4+3ysXgPzuCY4oNtRjbpteaEJKL2mQgCEi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu1u2GGQwM0vXnIy4bz5H+klN2NRpw/haZKOHipSj1LDvYF5LTvgZY65Ths8oaqeoHEtm0YMO4vtZIDXp8bv0CxsaFjxe4frv0y0URhEBLUro2J2OROszVezTHdpwkay0Y1bHjtLZMpVc3dTpXKEY7KT5P/okSj3/FOXFGg1lsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JOlTS5PL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+LH7cNQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JOlTS5PL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+LH7cNQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AE45EC01AD
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:56:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 06:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790938612; x=1791025012; bh=u1KVcFyA+G
	UUpI+W+WIlIUO+5vZaxpFc+cLqJJjRGp0=; b=JOlTS5PLN6Fuy6HxGbN0NrsSAo
	m+Kb8UO5gB5Wxj4Ow9EV78GebzG8pF4rOJCPdJUQjOsgyiSkNgtDZCMJzoUdRBbY
	4rpAfwTin7ZeGTX6trv6I/QxbW67zrQd0ceZAyWHfhx86+EmOrkva6omsFlyjGNq
	y9ViFo3lQjO0RsqOno2EaBo5e3utZZG0ns8CnE9jxnOzEOLd5oLbOUgqEMJ+WOga
	+xHuwEqW5VIyMLKni4srZDyBycw4nfr5TOEAyD/KlOLV/5ScWk8H6KUNez6RvkIr
	rXs1qPhnoEpM3FTVnEciaVKyvIOX+emaY/AHKC7WNBPSfhpx4BeC+/rxi4kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790938612; x=1791025012; bh=u1KVcFyA+GUUpI+W+WIlIUO+5vZaxpFc+cL
	qJJjRGp0=; b=U+LH7cNQHdXYmNWWNQ70OC6C81DlZe9imnSCVwVEU7w8INYsNni
	5evXRMXcKlP25Ae2HVEOPxDbXf3OVnjl103SjdjizAAfO5K/h7RmzrEInRZMXAXZ
	AuFJ/Pw9vdf9Hf4lBoVyx5PSBJQMWroq3MOXWMF5fgh0M4hE5VRWUl5XwKBaZYZo
	Bwij8XxdYYo+A7yZqeqkXV+RI+d9PvJe+/3YliLwKL/Yqvb98G1af4glO5fqBMja
	UKKNSWGTjdThQKS8kIH5/OOM/QkJ/0tlNza22ggUgo5VbK7m696P4GK4Ehso4ELo
	MvEM4ZJi3hGM0vuMuHdOf23ycHSTFswjnYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790938612; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eAWSFvIo+Yyse6oH1/+wCRroKWxPBgUZHVWmIX6yltcGSaG
	VkmeR99FxX2ZXB3iuwXex2I/gGcZnYYeSoiTCP3sZL4fkT756v41CihJpBVYsTK6
	ktkbbMxl3EMvNmgsXgOxYS4da3WtC4ruZGTtfhuyhzzAG5REqiCHQHOf/3l6krxC
	MjOStl3N0pFRY0nt9p1fh0WbIx9LIt2UZfiD0iB3WAMx6AVXIwaFnYAZc5QNShOU
	eSdj4F7HDonAOaI8f/b+/d2Gi+BMfqGyI08s9l2aqJiX08ngtEJF3PEizEWMBNzP
	iVo92Dk+1NRW3Xacejdsqj114zRZTRkpiry5PRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:llkwkD/q/sqebX+/3LtGRah+vstsZ/wt6TKWycoadjE=:531/z3jt4+3ysXgPzuCY4oNtRjbpteaEJKL2mQgCEi4=;
X-ME-Sender: <xms:9I2_al_lIJgmKLZUMBY6WirBjCoCJPc7abfrYuX077omEzlqTMiS9A>
    <xme:9I2_agvE14wbhkO-jqrwnKodyLDK6feu1stHLZFfARHIwYKRakunEd8FkM9pwlGHi
    3Pmwaa6JDVCc-0Nc_ZRWyiUeQaXiwxoZ9FEKxI7AC-52xCpV9mSaXU>
X-ME-Received: <xmr:9I2_aoBoDoRpvlOmo6tXOFkkpJfPzpKY-qsUtX3cmaKozR_5pVF7gA>
X-ME-Proxy-Cause: dmFkZTFjce1Je17GwX9ywhGuRX47uK7ofG6V+DrGQJ4bHvLuorYb/ixK2FcaXSquYYViON
    K6CFxvbH38t3R3Ks+jL69yOoaQLyYvqrW10iagKwQsRN0mGCpMy/2gRNpq7Aq9q/LaS0Ef
    LtBH+mRuJIUTm79JPS1ma1X9j05FisdtIvdeE3pGdha5lW/iMls6TBJY/9CG07pG905KTb
    cQm6sFYFNCWVBXr1wKOgwz7oqR1EX4d6IsSFIS+orgzI6oWq3zcUEAnuxAjp33R5ym6+4d
    1hQMi6gM/lsgiBgw2DmV8FjQVAAmLTRhQFoJ7eun6pUSxCIFZzaKmf4ocVWXucGoeyTLUb
    lVcwG1K6tDtyh049hdcd0OTxc2wNudWlT4YR3MTr5DQOzl/b3hDiD6O8YqCjW7YaaBKwjQ
    oiJm3KcNK1bLXTBRzxc9Tlka1yfpPybn6QnomY3a3kbcMsr+iGeOkg0J6YtS4m9MBLoK75
    V3Ns9gnkBJfXVEw4wM/HYcxBm/b4FgMWqLWAYo5oex4TL0K75Kv67quzwxvqc6psCrtRq/
    S1Bhj2AZcWAPkeMk2nqFHm4EiT1D0Gg4p8Hmju1PUSJBLGdqoI4ymzqY64hSbYxDHxt99j
    DiOzK8rBXiMWNkOnBLqrxp7Rj3FAnBiH5EoZMB5oHmQ/tfih2PNcShnyvWhA
X-ME-Proxy: <xmx:9I2_aoWMJVtRSwN73Cgy3S7Vlzx5u2ahLZsupoXJ6utj0Y8JU3Qn9Q>
    <xmx:9I2_amCIGRmEwgZaWrb1Q-2QHw-A3JAEnosT57epwEJmmPaxSit95w>
    <xmx:9I2_ar-ee-cq5ANNHWdgoTXPgP3YG2m3pyHC0uLdETiozEvTXVq9sg>
    <xmx:9I2_atFEQSJNQbxXORDqShun5yX_SRiS0Eh8OtZpKQD0Lqms9kQRww>
    <xmx:9I2_arguGWGVzEl3xolwS-iWF2WR4pBwkOYAbVdvaCKeO2653M8nh_p3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 06:56:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca7dd49a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 10:56:48 +0000 (UTC)
Date: Fri, 2 Oct 2026 12:56:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com
Subject: Re: [PATCH v2] refs: run copy and rename through transactions
Message-ID: <ar-N7SA63fN_xx9P@pks.im>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <20260923133651.74120-1-maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923133651.74120-1-maciej.ciemborowicz@gmail.com>

On Wed, Sep 23, 2026 at 03:36:51PM +0200, Maciej Ciemborowicz wrote:
> Reference copy and rename operations bypass the transaction API.
> Consequently, the reference-transaction hook sees only the source deletion
> with the files backend and no useful update with the reftable backend.
> 
> Represent both operations as reference transactions containing their
> logical updates. A rename is a deletion of the old reference and creation
> of the new reference in the same transaction. Attach operation-specific
> state to the destination update instead of making copy or rename a property
> of the entire transaction.

Sorry, but what does this last sentence mean? What is the consequence
of it?

> Retain backend-specific reflog handling: the files backend stages its
> existing rename procedure across prepare, finish and abort, while reftable
> stages an addition while holding the stack lock. Suppress hooks for the
> files backend's nested deletion transactions so that callers observe one
> logical transaction.

The fact that we retain the backend-specific logic is not really
interesting by itself. The way more interesting question is _why_ we
retain it. Or asked differently, why can't we make this whole mechanism
completely agnostic of the backend and implement this via pure
transactions?

> Record and verify the source and destination values after taking backend
> locks. This rejects concurrent changes instead of applying a rename or copy
> that differs from the payload shown to the preparing hook. Preserve D/F
> renames and restore overwritten references and reflogs when a prepared hook
> rejects the operation.

Is this new behaviour? Is this retaining old behaviour? I have no clue.

> Add tests covering rename, copy, forced updates, both directions of D/F
> conflicts, concurrent updates and prepared-hook rollback.

This sentence doesn't really add much value to the message.

How does all of this impact performance?

> diff --git a/refs.c b/refs.c
> index 92d5df5b7..f036ae4b9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1027,6 +1029,15 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>  	return 0;
>  }
>  
> +int refs_delete_ref(struct ref_store *refs, const char *msg,
> +		    const char *refname,
> +		    const struct object_id *old_oid,
> +		    unsigned int flags)
> +{
> +	return refs_delete_ref_with_transaction_flags(refs, msg, refname,
> +						      old_oid, flags, 0);
> +}
> +
>  static void copy_reflog_msg(struct strbuf *sb, const char *msg)
>  {
>  	char c;

Refactorings like these could easily go into a separate commit to make
this easier to review.

> @@ -2710,7 +2747,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  		return REF_TRANSACTION_ERROR_GENERIC;
>  
>  	/* Preparing checks before locking references */
> -	ret = run_transaction_hook(transaction, "preparing");
> +	ret = transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
> +		run_transaction_hook(transaction, "preparing");
>  	if (ret) {
>  		ref_transaction_abort(transaction, err);
>  		die(_(abort_by_ref_transaction_hook), "preparing");

Instead of teaching every site to conditionally call
`run_transaction_hook()` only when the flag is not set, can't we adapt
the function itself to skip?

In any case, this is another change that could easily be split out into
a separate commit.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 71628550f..c28228116 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2962,6 +3059,14 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  	struct ref_transaction *packed_transaction = NULL;
>  
>  	assert(err);
> +	{
> +		struct ref_update *operation =
> +			ref_transaction_copy_or_rename_update(transaction);
> +
> +		if (operation)
> +			return files_copy_or_rename_ref(ref_store, operation,
> +							transaction);
> +	}
>  
>  	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
>  		goto cleanup;

I know this is a construct that AI loves, but that's not following our
coding style.

> @@ -3333,6 +3442,40 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  
>  
>  	assert(err);
> +	{
> +		struct ref_update *update =
> +			ref_transaction_copy_or_rename_update(transaction);
> +
> +		if (update) {
> +			struct ref_copy_or_rename_update *operation =
> +				update->copy_or_rename;
> +			struct files_copy_or_rename_transaction_data *data =
> +				transaction->backend_data;
> +			int special_ret;
> +
> +			special_ret = commit_ref_update(refs, data->lock, &data->orig_oid,
> +							operation->logmsg, 0, err);
> +			if (special_ret) {
> +				error("unable to write current sha1 into %s: %s",
> +				      update->refname, err->buf);
> +				data->lock = NULL;
> +				files_transaction_abort(ref_store, transaction, err);
> +				return special_ret;
> +			} else if (data->destination_log_backed_up) {
> +				struct strbuf path = STRBUF_INIT;
> +
> +				files_reflog_path(refs, &path, TMP_RENAMED_LOG_DESTINATION);
> +				if (unlink(path.buf) < 0 && errno != ENOENT)
> +					warning_errno("unable to remove '%s'", path.buf);
> +				strbuf_release(&path);
> +			}
> +			free(data->destination_target);
> +			free(data);
> +			transaction->backend_data = NULL;
> +			transaction->state = REF_TRANSACTION_CLOSED;
> +			return special_ret;
> +		}
> +	}
>  
>  	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
>  		return files_transaction_finish_initial(refs, transaction, err);

Yeah...

> @@ -3476,11 +3619,105 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  
>  static int files_transaction_abort(struct ref_store *ref_store,
>  				   struct ref_transaction *transaction,
> -				   struct strbuf *err UNUSED)
> +				   struct strbuf *err)
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, 0, "ref_transaction_abort");
>  
> +	{
> +		struct ref_update *update =
> +			ref_transaction_copy_or_rename_update(transaction);

... really?

Sorry, but I'm going to stop reading here. This is not in a state that
is reviewable and has way too much stuff that is obviously generated by
an AI without much thought being put into it by the author. I don't want
to invest my time into a topic where the author has obviously not spent
their time thinking about it, either.

Patrick
