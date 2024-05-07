Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC73631
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061647; cv=none; b=Qi013Zv2IyqoiTz1hTAjyuKFVY+yrPrnJnJASstV16f4qLHwXprP9Ch0VqS39Wz+o04ll0foJ8b+rHJMCYGKlUMA0brR/mBROMFwApg5LTA5Sc7+YSb58b2tLWoIew1NHQ6xegBKrftYlFd4e8kcTubzmVMdz/U2Z0SlLVZT2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061647; c=relaxed/simple;
	bh=AFlRZ9Rc5bj/cUX6VajeB5hUjmVE8Vvirq4FnxELjNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDNcKET9+Uf7vS6/s9++qA6LiPdTo9+urvfXFWCW81uGo0v+GtlbMm6dYQn2+bIbmxCvUfDPHRmSOOawapjGTmPVImpJJAqLzKesojm2HQEhOV4EOz+9W+vlJ/oJhhovKZX7MVqxWzlT4eIOsx50LAMLng0VNVsUkzeQFI9npeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU1S9Tmb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU1S9Tmb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59ad344f7dso507543266b.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061643; x=1715666443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVcbBRvg/USIN0YkTPo9w14Nn4MgZ5TXL8qNbxwNWZc=;
        b=iU1S9TmbmvRHlmIWfO8FoZ3Jupy51tnW35y1D5um5az3xnbCFYymT4nogpQLmiO2mO
         Aqa+L0sTwN5FrU+z4oOjR/3GBnfT2GlspRRE9xn1ZeQX0Rm06NmVorPTtxvmUxPF74L/
         N3WfOiWsZB+U26sj+8dpokFgoKr2/7WNjTC50eNhaRkMghcXCDI/Ci8ioXeTBxyy8N1J
         Ky7NZACuKsz0uGGD6oJQgfCuFNQezrYTh/6JJQHTznwqTJas/gJmUIgVxi/amrBIZm3F
         MJ6qoQTEKPWru9r0OKXyaNFCDgSo5c14a3GJNqx/UbkAnus9G5mygCY13rrUhbdlqoAf
         v8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061643; x=1715666443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVcbBRvg/USIN0YkTPo9w14Nn4MgZ5TXL8qNbxwNWZc=;
        b=OGVmJxpZ8sVSb87JVcIXrx4rzF5BfmK02JXbvjegjJ5eBoTCJyMvXbBXB9JrirnJgF
         ATTpAOiQCYMI5Xd4vMhbVjuGK+Upx4Y3WzSzkzvkBzwAhx7zIxoRCLp25QIyps3tWWA+
         7z8SoGfUsAwI+Du+WouKmCKIQkiOffVB/O0XlRHuEHnVlk29wI0ZGcO7b4VM3EIMaRcs
         xCpGol0grOrnt2CwRB9n/aVEYzfgdM1uPPcJ6oBgDEBlMbADM6N3bSJkYYE42knf0B+8
         ngfgMvf4VRby7KcbOqkSU0rN0Vb08AOEDmOC2YRQWFM+fNCCUrZCAfllUgTWdv/z9CiD
         PHng==
X-Forwarded-Encrypted: i=1; AJvYcCVNKys3oP79FGa8cMgwUgQYFxjTwuCpXqZM2cImSJiDYF4QMSDsn3G42mRYcc030fFoznNwf39UKXx5LTgpj88FTNVC
X-Gm-Message-State: AOJu0YyVMWTL5TKoWtcZRWDfN6iXuAKK961LP9za3tQhbMV6K0pzg6Om
	XHNH6dtBI85zTy/aYBhv2ILKoJ//e6zkelyKsR4kSZBQIs/BLPsv
X-Google-Smtp-Source: AGHT+IHBN6NWg9JQB9W3YxK8z/Pg21kr6u8DFJ4RSTwz1kmijIuyk2+3RQ/SYix/bt6QDNgVd1ktSg==
X-Received: by 2002:a17:906:f1cc:b0:a59:ae9b:c661 with SMTP id gx12-20020a170906f1cc00b00a59ae9bc661mr5033518ejb.40.1715061643022;
        Mon, 06 May 2024 23:00:43 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 0/8] refs: add support for transactional symref updates
Date: Tue,  7 May 2024 08:00:27 +0200
Message-ID: <20240507060035.28602-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The patch series takes over from the existing patch series, wherein we
introduced symref-* commands to git-update-ref. Since there was a ton of
discussions on the UX of the patch series and its application, I thought it
would be best to shorten the series and split it into multiple smaller series.

This series adds transactional support for symrefs in the reference db. Then
we switch refs_create_symref() to start using transactions for symref updates.
This allows us to deprecate the create_symref code in the ref_storage_be
interface and remove all associated code which is no longer used.

The split was primarily done so we can merge the non-user facing parts of the
previous series. While pertaining the user facing components into another set
of patches wherein deeper discussion on the UX can be held without worrying
about the internal implementation. Also by using this new functionality in a
pre-existing command, we can leverage the existing tests to catch any
inconsistencies. One of which was how 'git-symbolic-ref' doesn't add reflog for
dangling symrefs, which I've modified my patch to do the same.

We also modify the reference transaction hook to support symrefs. For any symref
update the reference transaction hook will output the value with a 'ref:' prefix.

Previous versions:
V1: https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com
V2: https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.com
V3: https://lore.kernel.org/git/20240423212818.574123-1-knayak@gitlab.com
V4: https://lore.kernel.org/r/20240426152449.228860-1-knayak@gitlab.com
V5: https://lore.kernel.org/r/20240501202229.2695774-1-knayak@gitlab.com
V6: https://lore.kernel.org/r/20240503124115.252413-1-knayak@gitlab.com

Thanks for all the reviews!

Changes since v6:
* Made the check for old/new oid & target more stricter by removing
the exception for null oid's.
* Extracted `ref_update_check_old_target` and `original_update_refname`
to refs.c
* ^This allowed us to generalize the error messages for non-matching
old_target values between files and reftable backend.
* Better line wrapping in code.
* Fixed some grammar in commit messages.

Junio, I've rebased my patches on top of, not sure if there is something else I
missed here:
- ps/ci-python-2-deprecation (2a686e00d2)
- ps/reftable-write-options (f5545b173b)
- ps/pseudo-ref-terminology (ad302a68fd)

Range diff against v6:

1:  a354190905 ! 1:  2a09350661 refs: accept symref values in `ref_transaction_update()`
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      	if (transaction->state != REF_TRANSACTION_OPEN)
      		BUG("update called for transaction that is not open");
      
    -+	if (old_oid && !is_null_oid(old_oid) && old_target)
    ++	if (old_oid && old_target)
     +		BUG("only one of old_oid and old_target should be non NULL");
    -+	if (new_oid && !is_null_oid(new_oid) && new_target)
    ++	if (new_oid && new_target)
     +		BUG("only one of new_oid and new_target should be non NULL");
     +
      	FLEX_ALLOC_STR(update, refname, refname);
2:  0d9c5b9804 = 2:  9e76b768b9 files-backend: extract out `create_symref_lock()`
3:  e0219ffd31 = 3:  c1d1c5a651 refs: support symrefs in 'reference-transaction' hook
-:  ---------- > 4:  d7d455c9b6 refs: move `original_update_refname` to 'refs.c'
4:  b22c59c722 ! 5:  1c00cd69c6 refs: add support for transactional symref updates
    @@ Commit message
         updates. While this is exposed to users via 'git-update-ref' and its
         '--stdin' mode, it is also used internally within various commands.
     
    -    However, we never supported transactional updates of symrefs. Let's add
    -    support for symrefs in both the 'files' and the 'reftable' backend.
    +    However, we do not support transactional updates of symrefs. This commit
    +    adds support for symrefs in both the 'files' and the 'reftable' backend.
     
         Here, we add and use `ref_update_has_null_new_value()`, a helper
         function which is used to check if there is a new_value in a reference
         update. The new value could either be a symref target `new_target` or a
         OID `new_oid`.
     
    -    With this, now transactional updates (verify, create, delete, update)
    -    can be used for:
    +    We also add another common function `ref_update_check_old_target` which
    +    will be used to check if the update's old_target corresponds to a
    +    reference's current target.
    +
    +    Now transactional updates (verify, create, delete, update) can be used
    +    for:
         - regular refs
         - symbolic refs
         - conversion of regular to symbolic refs and vice versa
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      
      	ref_transaction_add_update(transaction, refname, flags,
      				   new_oid, old_oid, new_target,
    -@@ refs.c: int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
    - {
    - 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
    +@@ refs.c: const char *ref_update_original_update_refname(struct ref_update *update)
    + 	return update->refname;
      }
    -+
    + 
     +int ref_update_has_null_new_value(struct ref_update *update)
     +{
     +	return !update->new_target && is_null_oid(&update->new_oid);
     +}
    -
    - ## refs/files-backend.c ##
    -@@ refs/files-backend.c: static const char *original_update_refname(struct ref_update *update)
    - 	return update->refname;
    - }
    - 
    -+/*
    -+ * Check whether the old_target values stored in update are consistent
    -+ * with current_target, which is the symbolic reference's current value.
    -+ * If everything is OK, return 0; otherwise, write an error message to
    -+ * err and return -1.
    -+ */
    -+static int check_old_target(struct ref_update *update,
    -+			    const char *current_target,
    -+			    struct strbuf *err)
    ++
    ++int ref_update_check_old_target(const char *referent, struct ref_update *update,
    ++				struct strbuf *err)
     +{
     +	if (!update->old_target)
     +		BUG("called without old_target set");
     +
    -+	if (!strcmp(update->old_target, current_target))
    ++	if (!strcmp(referent, update->old_target))
     +		return 0;
     +
    -+	if (!strcmp(current_target, ""))
    -+		strbuf_addf(err, "cannot lock ref '%s': "
    ++	if (!strcmp(referent, ""))
    ++		strbuf_addf(err, "verifying symref target: '%s': "
     +			    "reference is missing but expected %s",
    -+			    original_update_refname(update),
    ++			    ref_update_original_update_refname(update),
     +			    update->old_target);
     +	else
    -+		strbuf_addf(err, "cannot lock ref '%s': "
    ++		strbuf_addf(err, "verifying symref target: '%s': "
     +			    "is at %s but expected %s",
    -+			    original_update_refname(update),
    -+			    current_target, update->old_target);
    -+
    ++			    ref_update_original_update_refname(update),
    ++			    referent, update->old_target);
     +	return -1;
     +}
    -+
    - /*
    -  * Check whether the REF_HAVE_OLD and old_oid values stored in update
    -  * are consistent with oid, which is the reference's current value. If
    +
    + ## refs/files-backend.c ##
    +@@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
    + 
    + 	new_update = ref_transaction_add_update(
    + 			transaction, referent, new_flags,
    +-			&update->new_oid, &update->old_oid,
    +-			NULL, NULL, update->msg);
    ++			update->new_target ? NULL : &update->new_oid,
    ++			update->old_target ? NULL : &update->old_oid,
    ++			update->new_target, update->old_target, update->msg);
    + 
    + 	new_update->parent_update = update;
    + 
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      
      	files_assert_main_repository(refs, "lock_ref_for_update");
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     +			}
     +
     +			if (update->old_target) {
    -+				if (check_old_target(update, referent.buf, err)) {
    ++				if (ref_update_check_old_target(referent.buf, update, err)) {
     +					ret = TRANSACTION_GENERIC_ERROR;
     +					goto out;
     +				}
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     +		 * be set for symrefs, but we're strict about its usage.
     +		 */
     +		if (update->old_target) {
    -+			if (check_old_target(update, referent.buf, err)) {
    ++			if (ref_update_check_old_target(referent.buf, update, err)) {
     +				ret = TRANSACTION_GENERIC_ERROR;
     +				goto out;
     +			}
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     -	    !(update->flags & REF_DELETING) &&
     -	    !(update->flags & REF_LOG_ONLY)) {
     +	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
    -+		if (create_symref_lock(refs, lock, update->refname, update->new_target, err)) {
    ++		if (create_symref_lock(refs, lock, update->refname,
    ++				       update->new_target, err)) {
     +			ret = TRANSACTION_GENERIC_ERROR;
     +			goto out;
     +		}
    @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
      			if (commit_ref(lock)) {
     
      ## refs/refs-internal.h ##
    -@@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct repository *repo,
    +@@ refs/refs-internal.h: struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
       */
    - struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
    + const char *ref_update_original_update_refname(struct ref_update *update);
      
     +/*
     + * Helper function to check if the new value is null, this
    @@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct re
     + * ref or a symbolic ref.
     + */
     +int ref_update_has_null_new_value(struct ref_update *update);
    ++
    ++/*
    ++ * Check whether the old_target values stored in update are consistent
    ++ * with the referent, which is the symbolic reference's current value.
    ++ * If everything is OK, return 0; otherwise, write an error message to
    ++ * err and return -1.
    ++ */
    ++int ref_update_check_old_target(const char *referent, struct ref_update *update,
    ++				struct strbuf *err);
     +
      #endif /* REFS_REFS_INTERNAL_H */
     
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		 */
     -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
     +		if (u->old_target) {
    -+			if (strcmp(referent.buf, u->old_target)) {
    -+				if (!strcmp(referent.buf, ""))
    -+					strbuf_addf(err, "verifying symref target: '%s': "
    -+						    "reference is missing but expected %s",
    -+						    original_update_refname(u),
    -+						    u->old_target);
    -+				else
    -+					strbuf_addf(err, "verifying symref target: '%s': "
    -+						    "is at %s but expected %s",
    -+						    original_update_refname(u),
    -+						    referent.buf, u->old_target);
    ++			if (ref_update_check_old_target(referent.buf, u, err)) {
     +				ret = -1;
     +				goto done;
     +			}
     +		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
      			if (is_null_oid(&u->old_oid))
      				strbuf_addf(err, _("cannot lock ref '%s': "
    - 					    "reference already exists"),
    + 						   "reference already exists"),
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
      		 * - `core.logAllRefUpdates` tells us to create the reflog for
      		 *   the given ref.
      		 */
     -		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
    -+		if ((u->flags & REF_HAVE_NEW) && !(u->type & REF_ISSYMREF) && ref_update_has_null_new_value(u)) {
    ++		if ((u->flags & REF_HAVE_NEW) &&
    ++		    !(u->type & REF_ISSYMREF) &&
    ++		    ref_update_has_null_new_value(u)) {
      			struct reftable_log_record log = {0};
      			struct reftable_iterator it = {0};
      
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
     -			log = &logs[logs_nr++];
     -			memset(log, 0, sizeof(*log));
     -
    --			fill_reftable_log_record(log);
    +-			fill_reftable_log_record(log, &committer_ident);
     -			log->update_index = ts;
     -			log->refname = xstrdup(u->refname);
     -			memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
     +				log = &logs[logs_nr++];
     +				memset(log, 0, sizeof(*log));
     +
    -+				fill_reftable_log_record(log);
    ++				fill_reftable_log_record(log, &committer_ident);
     +				log->update_index = ts;
     +				log->refname = xstrdup(u->refname);
    -+				memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
    -+				memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
    ++				memcpy(log->value.update.new_hash,
    ++				       u->new_oid.hash, GIT_MAX_RAWSZ);
    ++				memcpy(log->value.update.old_hash,
    ++				       tx_update->current_oid.hash, GIT_MAX_RAWSZ);
     +				log->value.update.message =
     +					xstrndup(u->msg, arg->refs->write_options.block_size / 2);
     +			}
5:  636bf5ce98 ! 6:  027106cfe6 refs: use transaction in `refs_create_symref()`
    @@ refs.c: int refs_create_symref(struct ref_store *refs,
      
      int create_symref(const char *ref_target, const char *refs_heads_master,
     
    - ## t/t0610-reftable-basics.sh ##
    -@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: creating symbolic ref fails with F/D confl
    - 	git init repo &&
    - 	test_commit -C repo A &&
    - 	cat >expect <<-EOF &&
    --	error: unable to write symref for refs/heads: file/directory conflict
    -+	error: ${SQ}refs/heads/main${SQ} exists; cannot create ${SQ}refs/heads${SQ}
    - 	EOF
    - 	test_must_fail git -C repo symbolic-ref refs/heads refs/heads/foo 2>err &&
    - 	test_cmp expect err
    -
      ## t/t1416-ref-transaction-hooks.sh ##
     @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
      	test_cmp expect target-repo.git/actual
6:  07fb23374f = 7:  6939406143 refs: rename `refs_create_symref()` to `refs_update_symref()`
7:  5c05813bcc ! 8:  bc787b903b refs: remove `create_symref` and associated dead code
    @@ refs/reftable-backend.c: struct write_create_symref_arg {
     -		.value.symref = (char *)create->target,
     -		.update_index = ts,
     -	};
    +-	struct ident_split committer_ident = {0};
     -	struct reftable_log_record log = {0};
     -	struct object_id new_oid;
     -	struct object_id old_oid;
    +-	const char *committer_info;
     -	int ret;
     -
     -	reftable_writer_set_limits(writer, ts, ts);
     -
    +-	ret = refs_verify_refname_available(&create->refs->base, create->refname,
    +-					    NULL, NULL, create->err);
    +-	if (ret < 0)
    +-		return ret;
    +-
     -	ret = reftable_writer_add_ref(writer, &ref);
     -	if (ret)
     -		return ret;
    @@ refs/reftable-backend.c: struct write_create_symref_arg {
     -	    !should_write_log(&create->refs->base, create->refname))
     -		return 0;
     -
    --	fill_reftable_log_record(&log);
    +-	committer_info = git_committer_info(0);
    +-	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
    +-		BUG("failed splitting committer info");
    +-
    +-	fill_reftable_log_record(&log, &committer_ident);
     -	log.refname = xstrdup(create->refname);
     -	log.update_index = ts;
     -	log.value.update.message = xstrndup(create->logmsg,
    @@ refs/reftable-backend.c: struct write_create_symref_arg {
     -	struct reftable_ref_store *refs =
     -		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_symref");
     -	struct reftable_stack *stack = stack_for(refs, refname, &refname);
    +-	struct strbuf err = STRBUF_INIT;
     -	struct write_create_symref_arg arg = {
     -		.refs = refs,
     -		.stack = stack,
     -		.refname = refname,
     -		.target = target,
     -		.logmsg = logmsg,
    +-		.err = &err,
     -	};
     -	int ret;
     -
    @@ refs/reftable-backend.c: struct write_create_symref_arg {
     -
     -done:
     -	assert(ret != REFTABLE_API_ERROR);
    --	if (ret)
    --		error("unable to write symref for %s: %s", refname,
    --		      reftable_error_str(ret));
    +-	if (ret) {
    +-		if (err.len)
    +-			error("%s", err.buf);
    +-		else
    +-			error("unable to write symref for %s: %s", refname,
    +-			      reftable_error_str(ret));
    +-	}
    +-
    +-	strbuf_release(&err);
     -	return ret;
     -}
     -

Karthik Nayak (8):
  refs: accept symref values in `ref_transaction_update()`
  files-backend: extract out `create_symref_lock()`
  refs: support symrefs in 'reference-transaction' hook
  refs: move `original_update_refname` to 'refs.c'
  refs: add support for transactional symref updates
  refs: use transaction in `refs_create_symref()`
  refs: rename `refs_create_symref()` to `refs_update_symref()`
  refs: remove `create_symref` and associated dead code

 Documentation/githooks.txt       |  14 ++-
 branch.c                         |   2 +-
 builtin/branch.c                 |   2 +-
 builtin/fast-import.c            |   5 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   1 +
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   1 +
 builtin/update-ref.c             |   1 +
 builtin/worktree.c               |   2 +-
 refs.c                           | 119 ++++++++++++++----
 refs.h                           |  20 ++-
 refs/debug.c                     |  13 --
 refs/files-backend.c             | 208 +++++++++++++++++--------------
 refs/packed-backend.c            |   1 -
 refs/refs-internal.h             |  40 +++++-
 refs/reftable-backend.c          | 202 +++++++++---------------------
 sequencer.c                      |   9 +-
 t/helper/test-ref-store.c        |   2 +-
 t/t1416-ref-transaction-hooks.sh |  23 ++++
 walker.c                         |   2 +-
 21 files changed, 373 insertions(+), 298 deletions(-)

-- 
2.43.GIT

