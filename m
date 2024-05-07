Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C23155A55
	for <git@vger.kernel.org>; Tue,  7 May 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097010; cv=none; b=u2XNrTk44f0IaQKFeHZ3KEKJnFxTCKIyX2rjYD+SmvRTNJXyMBFuQ+fPX8O+du+JMJWCwUTEDkNpjcecuug815Oln35/JPZvre5t2KTygYuhRCwQ9oVLyTLkUDhC+qfKwqqDGSs6kVSKD3CUnTVLhyHMVkAgHz2JbQg/h3GEQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097010; c=relaxed/simple;
	bh=1mWaOtZ3UDMFPHloqmnPdsOYX7zwQjc5dmGezHo3lew=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ltXBTm5lgALeZZXKgm3YzKbQRiLqlNzkfu7buJyap+OYwP2NnkTay1yVaXAJ4iqtcVf2Jndy3NGN9xdzJIz5jewSwd3vv3VNUqxe+65w3JYrzABfZBXsuS42EmC1AhGTOPNjRSNOXEPDiq+0iFDZQErZOGj2yD/uoj/DLnyVNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ33++Yf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ33++Yf"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e30c625178so30624431fa.1
        for <git@vger.kernel.org>; Tue, 07 May 2024 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715097007; x=1715701807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq8QgbXlsNX79LHOU1I9TYkabSFxNVsKkiKOGUZv56U=;
        b=GJ33++Yfj9bNz6sheC+fjx9+3PoK4zsaGlrVNomSKD7SB2y+4moP9ssMJSgeMcvKlF
         sjjTshr8TbZPj1pXH4L7OIV3icab59d60Ub7gUrjBJmjFTpxY7sOgJOV64gNdQLzuGAS
         IS4ezPsaFf9T/W/bG+L/NQd1vh67ZhAmELUfAFCuDWqh0N4Zk+j+oxrklRaWsyMtpEoN
         AVG2FBVBSigi6NT/F8o/W9jnrnm+k1rL4rovai0gvHHt3rCWaeb04WXy0QLu3vWrCWCB
         gxOFhuagXyyTQlO4h6TjFrPHp7AlF7TziUgYeJ293mLNqZjwrzFhMz5w7uqvzwkEa4SR
         xVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097007; x=1715701807;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq8QgbXlsNX79LHOU1I9TYkabSFxNVsKkiKOGUZv56U=;
        b=A7RvBZXo/FMD2pjVeMIhIZCj63+s+gTND0R//bcOdg4eXbzIb/UN9ivXIZR/HT49g0
         ihWyq5ZbAmWsKA8eCkJMNJVdvVpQAWv+btacKvk0P8LWozlnOC1irP6ykHy5ernrsqXN
         ZtwgMSFJODvQZcF1czOoA4habhQcf6nl44dGBRcXxb8ZuHeyvX4C/b5dvjvSBNqH5o/D
         v6hHEJhvioSd5LmWsAE0/YMT8JngcBLBKoUYCcZ6H/gzHgxeSB7CzkUnmxPq5IF6ghFG
         wAJw7aa7f+uumNaIpm/p+8ePB2mw8PWWe27UgySstIS5gUOyXs/lWOJu7b/RjnYTXqLR
         toBQ==
X-Gm-Message-State: AOJu0Yw20paTVblGgIoXFgudfNuU22LKEh1VQZMOmjsGmJZ1DehSMG9t
	hUYqBAA/Fbr28sKizQPfXEq0rY9XusaukgVxtSgnkzuoowk/sRAH
X-Google-Smtp-Source: AGHT+IEDwxMSRmqNiywiwIyzoWqc244cnbIpFUAnTdHqBo4aabqokG4KiZPbkZjmZaa7X0y9exn5yA==
X-Received: by 2002:a2e:beac:0:b0:2da:e7f7:7315 with SMTP id a44-20020a2ebeac000000b002dae7f77315mr9093471ljr.45.1715097006300;
        Tue, 07 May 2024 08:50:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b0041be609b1c7sm23745938wmg.47.2024.05.07.08.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:50:06 -0700 (PDT)
Message-ID: <9d4c4850-6d73-472c-9ab1-fe5f6f4657d8@gmail.com>
Date: Tue, 7 May 2024 16:50:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 0/8] refs: add support for transactional symref updates
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <20240507060035.28602-1-knayak@gitlab.com>
 <20240507125859.132116-1-knayak@gitlab.com>
Content-Language: en-US
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 07/05/2024 13:58, Karthik Nayak wrote:
> Changes since v6:
> * Made the check for old/new oid & target more stricter by removing
> the exception for null oid's.
> * Extracted `ref_update_check_old_target` and `original_update_refname`
> to refs.c
> * ^This allowed us to generalize the error messages for non-matching
> old_target values between files and reftable backend.
> * Better line wrapping in code.
> * Fixed some grammar in commit messages.

Thanks for re-rolling - these changes address all of my comments on v6 
and the range-diff below looks good.

Best Wishes

Phillip

> Range diff against v6:
> 
> 1:  a354190905 ! 1:  defc1b3521 refs: accept symref values in `ref_transaction_update()`
>      @@ refs.c: struct ref_update *ref_transaction_add_update(
>        	if (transaction->state != REF_TRANSACTION_OPEN)
>        		BUG("update called for transaction that is not open");
>        
>      -+	if (old_oid && !is_null_oid(old_oid) && old_target)
>      ++	if (old_oid && old_target)
>       +		BUG("only one of old_oid and old_target should be non NULL");
>      -+	if (new_oid && !is_null_oid(new_oid) && new_target)
>      ++	if (new_oid && new_target)
>       +		BUG("only one of new_oid and new_target should be non NULL");
>       +
>        	FLEX_ALLOC_STR(update, refname, refname);
> 2:  0d9c5b9804 = 2:  54bb78a27c files-backend: extract out `create_symref_lock()`
> 3:  e0219ffd31 = 3:  c16b7c5da0 refs: support symrefs in 'reference-transaction' hook
> -:  ---------- > 4:  2d268f12cc refs: move `original_update_refname` to 'refs.c'
> 4:  b22c59c722 ! 5:  7db3a2245f refs: add support for transactional symref updates
>      @@ Commit message
>           updates. While this is exposed to users via 'git-update-ref' and its
>           '--stdin' mode, it is also used internally within various commands.
>       
>      -    However, we never supported transactional updates of symrefs. Let's add
>      -    support for symrefs in both the 'files' and the 'reftable' backend.
>      +    However, we do not support transactional updates of symrefs. This commit
>      +    adds support for symrefs in both the 'files' and the 'reftable' backend.
>       
>           Here, we add and use `ref_update_has_null_new_value()`, a helper
>           function which is used to check if there is a new_value in a reference
>           update. The new value could either be a symref target `new_target` or a
>           OID `new_oid`.
>       
>      -    With this, now transactional updates (verify, create, delete, update)
>      -    can be used for:
>      +    We also add another common function `ref_update_check_old_target` which
>      +    will be used to check if the update's old_target corresponds to a
>      +    reference's current target.
>      +
>      +    Now transactional updates (verify, create, delete, update) can be used
>      +    for:
>           - regular refs
>           - symbolic refs
>           - conversion of regular to symbolic refs and vice versa
>      @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
>        
>        	ref_transaction_add_update(transaction, refname, flags,
>        				   new_oid, old_oid, new_target,
>      -@@ refs.c: int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
>      - {
>      - 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
>      +@@ refs.c: const char *ref_update_original_update_refname(struct ref_update *update)
>      + 	return update->refname;
>        }
>      -+
>      +
>       +int ref_update_has_null_new_value(struct ref_update *update)
>       +{
>       +	return !update->new_target && is_null_oid(&update->new_oid);
>       +}
>      -
>      - ## refs/files-backend.c ##
>      -@@ refs/files-backend.c: static const char *original_update_refname(struct ref_update *update)
>      - 	return update->refname;
>      - }
>      -
>      -+/*
>      -+ * Check whether the old_target values stored in update are consistent
>      -+ * with current_target, which is the symbolic reference's current value.
>      -+ * If everything is OK, return 0; otherwise, write an error message to
>      -+ * err and return -1.
>      -+ */
>      -+static int check_old_target(struct ref_update *update,
>      -+			    const char *current_target,
>      -+			    struct strbuf *err)
>      ++
>      ++int ref_update_check_old_target(const char *referent, struct ref_update *update,
>      ++				struct strbuf *err)
>       +{
>       +	if (!update->old_target)
>       +		BUG("called without old_target set");
>       +
>      -+	if (!strcmp(update->old_target, current_target))
>      ++	if (!strcmp(referent, update->old_target))
>       +		return 0;
>       +
>      -+	if (!strcmp(current_target, ""))
>      -+		strbuf_addf(err, "cannot lock ref '%s': "
>      ++	if (!strcmp(referent, ""))
>      ++		strbuf_addf(err, "verifying symref target: '%s': "
>       +			    "reference is missing but expected %s",
>      -+			    original_update_refname(update),
>      ++			    ref_update_original_update_refname(update),
>       +			    update->old_target);
>       +	else
>      -+		strbuf_addf(err, "cannot lock ref '%s': "
>      ++		strbuf_addf(err, "verifying symref target: '%s': "
>       +			    "is at %s but expected %s",
>      -+			    original_update_refname(update),
>      -+			    current_target, update->old_target);
>      -+
>      ++			    ref_update_original_update_refname(update),
>      ++			    referent, update->old_target);
>       +	return -1;
>       +}
>      -+
>      - /*
>      -  * Check whether the REF_HAVE_OLD and old_oid values stored in update
>      -  * are consistent with oid, which is the reference's current value. If
>      +
>      + ## refs/files-backend.c ##
>      +@@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
>      +
>      + 	new_update = ref_transaction_add_update(
>      + 			transaction, referent, new_flags,
>      +-			&update->new_oid, &update->old_oid,
>      +-			NULL, NULL, update->msg);
>      ++			update->new_target ? NULL : &update->new_oid,
>      ++			update->old_target ? NULL : &update->old_oid,
>      ++			update->new_target, update->old_target, update->msg);
>      +
>      + 	new_update->parent_update = update;
>      +
>       @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
>        
>        	files_assert_main_repository(refs, "lock_ref_for_update");
>      @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
>       +			}
>       +
>       +			if (update->old_target) {
>      -+				if (check_old_target(update, referent.buf, err)) {
>      ++				if (ref_update_check_old_target(referent.buf, update, err)) {
>       +					ret = TRANSACTION_GENERIC_ERROR;
>       +					goto out;
>       +				}
>      @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
>       +		 * be set for symrefs, but we're strict about its usage.
>       +		 */
>       +		if (update->old_target) {
>      -+			if (check_old_target(update, referent.buf, err)) {
>      ++			if (ref_update_check_old_target(referent.buf, update, err)) {
>       +				ret = TRANSACTION_GENERIC_ERROR;
>       +				goto out;
>       +			}
>      @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
>       -	    !(update->flags & REF_DELETING) &&
>       -	    !(update->flags & REF_LOG_ONLY)) {
>       +	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
>      -+		if (create_symref_lock(refs, lock, update->refname, update->new_target, err)) {
>      ++		if (create_symref_lock(refs, lock, update->refname,
>      ++				       update->new_target, err)) {
>       +			ret = TRANSACTION_GENERIC_ERROR;
>       +			goto out;
>       +		}
>      @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
>        			if (commit_ref(lock)) {
>       
>        ## refs/refs-internal.h ##
>      -@@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>      +@@ refs/refs-internal.h: struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
>         */
>      - struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
>      + const char *ref_update_original_update_refname(struct ref_update *update);
>        
>       +/*
>       + * Helper function to check if the new value is null, this
>      @@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct re
>       + * ref or a symbolic ref.
>       + */
>       +int ref_update_has_null_new_value(struct ref_update *update);
>      ++
>      ++/*
>      ++ * Check whether the old_target values stored in update are consistent
>      ++ * with the referent, which is the symbolic reference's current value.
>      ++ * If everything is OK, return 0; otherwise, write an error message to
>      ++ * err and return -1.
>      ++ */
>      ++int ref_update_check_old_target(const char *referent, struct ref_update *update,
>      ++				struct strbuf *err);
>       +
>        #endif /* REFS_REFS_INTERNAL_H */
>       
>      @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
>        		 */
>       -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
>       +		if (u->old_target) {
>      -+			if (strcmp(referent.buf, u->old_target)) {
>      -+				if (!strcmp(referent.buf, ""))
>      -+					strbuf_addf(err, "verifying symref target: '%s': "
>      -+						    "reference is missing but expected %s",
>      -+						    original_update_refname(u),
>      -+						    u->old_target);
>      -+				else
>      -+					strbuf_addf(err, "verifying symref target: '%s': "
>      -+						    "is at %s but expected %s",
>      -+						    original_update_refname(u),
>      -+						    referent.buf, u->old_target);
>      ++			if (ref_update_check_old_target(referent.buf, u, err)) {
>       +				ret = -1;
>       +				goto done;
>       +			}
>       +		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
>        			if (is_null_oid(&u->old_oid))
>        				strbuf_addf(err, _("cannot lock ref '%s': "
>      - 					    "reference already exists"),
>      + 						   "reference already exists"),
>       @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>        		 * - `core.logAllRefUpdates` tells us to create the reflog for
>        		 *   the given ref.
>        		 */
>       -		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
>      -+		if ((u->flags & REF_HAVE_NEW) && !(u->type & REF_ISSYMREF) && ref_update_has_null_new_value(u)) {
>      ++		if ((u->flags & REF_HAVE_NEW) &&
>      ++		    !(u->type & REF_ISSYMREF) &&
>      ++		    ref_update_has_null_new_value(u)) {
>        			struct reftable_log_record log = {0};
>        			struct reftable_iterator it = {0};
>        
>      @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
>       +				fill_reftable_log_record(log);
>       +				log->update_index = ts;
>       +				log->refname = xstrdup(u->refname);
>      -+				memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
>      -+				memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
>      ++				memcpy(log->value.update.new_hash,
>      ++				       u->new_oid.hash, GIT_MAX_RAWSZ);
>      ++				memcpy(log->value.update.old_hash,
>      ++				       tx_update->current_oid.hash, GIT_MAX_RAWSZ);
>       +				log->value.update.message =
>       +					xstrndup(u->msg, arg->refs->write_options.block_size / 2);
>       +			}
> 5:  636bf5ce98 = 6:  354ebbe17f refs: use transaction in `refs_create_symref()`
> 6:  07fb23374f = 7:  c8a23b3454 refs: rename `refs_create_symref()` to `refs_update_symref()`
> 7:  5c05813bcc = 8:  fa1b8f445b refs: remove `create_symref` and associated dead code
> 
> 
> Karthik Nayak (8):
>    refs: accept symref values in `ref_transaction_update()`
>    files-backend: extract out `create_symref_lock()`
>    refs: support symrefs in 'reference-transaction' hook
>    refs: move `original_update_refname` to 'refs.c'
>    refs: add support for transactional symref updates
>    refs: use transaction in `refs_create_symref()`
>    refs: rename `refs_create_symref()` to `refs_update_symref()`
>    refs: remove `create_symref` and associated dead code
> 
>   Documentation/githooks.txt       |  14 ++-
>   branch.c                         |   2 +-
>   builtin/branch.c                 |   2 +-
>   builtin/fast-import.c            |   5 +-
>   builtin/fetch.c                  |   2 +-
>   builtin/receive-pack.c           |   1 +
>   builtin/replace.c                |   2 +-
>   builtin/tag.c                    |   1 +
>   builtin/update-ref.c             |   1 +
>   builtin/worktree.c               |   2 +-
>   refs.c                           | 119 ++++++++++++++----
>   refs.h                           |  20 ++-
>   refs/debug.c                     |  13 --
>   refs/files-backend.c             | 208 +++++++++++++++++--------------
>   refs/packed-backend.c            |   1 -
>   refs/refs-internal.h             |  40 +++++-
>   refs/reftable-backend.c          | 183 +++++++++------------------
>   sequencer.c                      |   9 +-
>   t/helper/test-ref-store.c        |   2 +-
>   t/t0610-reftable-basics.sh       |   2 +-
>   t/t1416-ref-transaction-hooks.sh |  23 ++++
>   walker.c                         |   2 +-
>   22 files changed, 374 insertions(+), 280 deletions(-)
> 
