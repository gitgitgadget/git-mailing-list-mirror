Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731848E0E7
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116170; cv=none; b=fgU6k8TRJw1N/MapbJRVWsAt6NY3/Tmuo6x9K+wBVAabsPXVDBzV82+ITVOKyCUKYiS80xtaDQVEsqTyacnY8HVeSOek+u3jj2/Gu2UdUVWrNPInWl+bEUqsi+VwFu+Fh8z4kAEaZ93vYHBVUIkfqID+EsbDF6fxd/mm7h2EHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116170; c=relaxed/simple;
	bh=YHYOvcKsEJqDuBtojjU7L97vE9LyKq93eCypZdh3bIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ePDHd/adVh/fODJJ84lZvkYdqSdgLsPNI7O64zl3s20Lf69pJYBUnNoFL+/CQd5eZ1AEHsEVYds4gS8L5tE7tVsxwIE4N2K+ClWFE8ftVYZl1OU9FnoTDh7pRRD6V2naf2y3BTVVXJauAt3eQVCy2lxuGyRfMAFXaaK12qWuPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bebmFzDP; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bebmFzDP"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c254fa663bfso49297366b.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790116153; x=1790720953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tpktt/Vgzyd8xUsKs91a7nbz1OiSd0IeiL63uWs92g=;
        b=bebmFzDPQLPf9bDiLRzxExB1TEpGH9QrGRp2P5fwLeCWdzBZI52zSMtqAKbYZYjQPJ
         hpux8hKoSj1icUpv/meAo9tkpLhPcWtcw4s+osUExLWeLQ1S0GMg0m02WCX4CDcutNBo
         4YsbPM96KfJMIc3FPamtcSe99yrtpPA031wnplJ1sOUcmO0qZxf5WH/VlY2iP6ybh1VH
         uhlSWrve5GT5LYFwMO56PvV8st8c5LF9xxXFuxNylTnlkoYH66q6lWQ1Y02dkYPhxJNE
         ENSypY6RTOE15aTB+Pjk4dVxMMcazlG3TJpV0nLvw4/ql1phEBwDBLxAuhZCF/nwn6Uu
         hQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116153; x=1790720953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tpktt/Vgzyd8xUsKs91a7nbz1OiSd0IeiL63uWs92g=;
        b=ExMJnH8gveRgCsL0i4CCtsyvK3ueeqTT4QfQ2MPysCquto+9zWwaptdQDa8hnIQ++O
         veNc2WaUfZfL7LifxJYzA67TB50rMXFAqOTOm8zGN8G5Z0Gxr+bDS6BqmmkoVkuUQ5nE
         XF4iWUKCTpbFlSAB2vDi4gf5C6PTpXe9G063sXH7n9/dJB+uFwcERNgiVdwHIvdHFyF7
         tgU92VjUKK5FU6z6rujMIJoFTmgZxsOpnz8XP/mLdysTMRCb4e3oR0iYaetVR41nJ/+4
         yKNVo3O2rybxPKGj8YBuS5cluNVtFfmcFzM7S3X350SZ4FSPsywPvvn2zzuoPc5q4CF6
         Z8zw==
X-Gm-Message-State: AFuF++ntKuM1fLFz+t28ZrKNaLAX8uCMe4+uSJvZ9o4G3OSXXTE5c24M
	bjs8CjtiRA3n1HSV9TAkFP3mh04hP6QJjKV0HyRVgaZj9die9ulwGyYfaswKI+/T
X-Gm-Gg: AYBFou2mAyIQ2wO6OLK+gYezF0XZenGk/OY9w5mrInfDiBsQiKeaQC9eDX+5dTywNIq
	vwxwTyguL5i55ffDAtOZ8WuCfiJUooK7LVwn2gNyTVhPQI/faR/dz3JhTaxMoE7d2iZl9s29cuF
	HSbDvmfzeGgIIs/mAct6MA4JC9RaggXecgh8kaniysoJzRtF7/t0el8HDNbwXR2axsV1d+llrUK
	JCYubt0Gcbikqit1ITI1FqfAIahmFYo9JgsH90WvJgAp9x8Wg68Jkk8d45wEBl9Ukoiwp3reflR
	LSVzrh3lPLAIgIg2kv6BBtrzxycIqtqx9BBjUReUvGVtqjSo6ZJ4O0uOF5X/6qiuCZbp3HYlrVQ
	75NlFCGnBDg22oeZsAkxKacHmiBKXgccRHs7ClgjWdttfx6WJ/ocYRUYsQT8tClcCL+9nw1C3iY
	NM9hrdyafR04aPTnuVwVTLcU6G3MwG0dEuntroTISdUaIC/pB/i/pS0iWOTXfQUvsD/ILi/T7o1
	oMlalvFhagIqwStgXb5RYvkRpp5ZTverpRJK8z6jOoyIXAUXdu6EL40zzVH2Rd83T22CgpiYIc9
	tuQMdC9P1QVZyIFZlUWT5MY5qBgwt6DB4CGWss2pUc1o4vBc
X-Received: by 2002:a17:907:6ea6:b0:c25:47a4:fedc with SMTP id a640c23a62f3a-c2aadeb2aa7mr53457066b.2.1790116152949;
        Tue, 22 Sep 2026 15:29:12 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae64ddf9sm19937466b.35.2026.09.22.15.29.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 15:29:12 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH v4 0/3] refs: report old OIDs for batched deletions
Date: Wed, 23 Sep 2026 00:29:10 +0200
Message-Id: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Okay, I will keep trying. I believe this version addresses all comments
from the previous round, and I hope I have not missed anything.

This follows up on the reference-transaction bug report at [1].

The reference-transaction hook receives zero as both the old and new OID
when branch, tag, fetch, and remote delete refs through refs_delete_refs().
Those callers already know the values that they selected for deletion.

Teach refs_delete_refs() to accept a parallel array of expected old OIDs and
pass them into the transaction. Besides making hook records useful, this
restores conditional deletion for branch and tag and adds it to pruning
without additional ref reads. Non-atomic batches preserve best-effort
behavior, while atomic fetches remain all-or-nothing.

Changes since v3:

 * Rebase onto master at 3bc0341127 (Git 2.56-rc2).
 * Always use REF_TRANSACTION_ALLOW_FAILURE in refs_delete_refs(), including
   unconditional batches, and always inspect rejected updates.
 * Count individual failures directly and remove the redundant failures
   variable.
 * Treat a null old OID as an unconditional deletion in
   ref_transaction_delete(), instead of requiring each caller to convert it.
 * Let refs_delete_refs() return the exact set of individually failed refs.
 * Continue reporting successful fetch and remote prune deletions after a
   partial failure, while omitting rejected refs from deletion and dangling
   symref reports.
 * Add coverage for partial fetch pruning as well as remote pruning.

The full test suite passes. The focused reference-transaction tests also
pass with SHA-1 and SHA-256 using both the files and reftable backends.

[1] https://lore.kernel.org/git/CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com/

Maciej Ciemborowicz (3):
  refs: allow callers to supply old OIDs for batch deletion
  branch, tag: retain old OIDs in batched deletions
  fetch, remote: retain old OIDs when pruning refs

 bisect.c                         |   2 +-
 builtin/branch.c                 |   7 +-
 builtin/fetch.c                  |  30 ++++--
 builtin/remote.c                 |  47 +++++++--
 builtin/tag.c                    |  28 ++++--
 refs.c                           |  67 ++++++++++---
 refs.h                           |  31 ++++--
 t/helper/test-ref-store.c        |   2 +-
 t/t1416-ref-transaction-hooks.sh | 160 +++++++++++++++++++++++++++++++
 9 files changed, 324 insertions(+), 50 deletions(-)

Range-diff against v3:
1:  3315d5f47 ! 1:  f4a9d065c refs: allow callers to supply old OIDs for batch deletion
    @@ Commit message
         reference-transaction hooks see a null old OID.
     
         Let callers provide an optional array of expected old OIDs in parallel with
    -    the refname list. When the array is provided, delete the ref at position N
    -    only if it still points at the OID at position N. A null OID requests an
    -    unconditional deletion for refs whose old value cannot be resolved, such as
    -    broken refs.
    +    the refname list. Delete the ref at position N only if it still points at
    +    the OID at position N. Treat a null OID as an unconditional deletion in
    +    ref_transaction_delete(), allowing callers to include broken refs whose old
    +    value cannot be resolved.
     
    -    Use REF_TRANSACTION_ALLOW_FAILURE when old OIDs are supplied. This retains
    -    the helper's best-effort behavior: an old-OID mismatch rejects that deletion
    -    while independent deletions in the batch can still proceed.
    +    refs_delete_refs() has always promised best-effort deletion. Always use
    +    REF_TRANSACTION_ALLOW_FAILURE and report rejected updates so one failure
    +    does not prevent independent refs in the batch from being deleted. Let
    +    callers request the exact set of failed refs when they need to report
    +    partial results. This also completes the conversion that was missed when
    +    batched transaction failure support was introduced.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ bisect.c: int bisect_clean_state(void)
      	result = refs_delete_refs(get_main_ref_store(the_repository),
      				  "bisect: remove", &refs_for_removal,
     -				  REF_NO_DEREF);
    -+				  NULL, REF_NO_DEREF);
    ++				  NULL, NULL, REF_NO_DEREF);
      	string_list_clear(&refs_for_removal, 0);
      	unlink_or_warn(git_path_bisect_ancestors_ok());
      	unlink_or_warn(git_path_bisect_log());
    @@ builtin/remote.c: static int rm(int argc, const char **argv, const char *prefix,
      		result = refs_delete_refs(get_main_ref_store(the_repository),
      					  "remote: remove", &branches,
     -					  REF_NO_DEREF);
    -+					  NULL, REF_NO_DEREF);
    ++					  NULL, NULL, REF_NO_DEREF);
      	string_list_clear(&branches, 0);
      
      	if (skipped.nr) {
    @@ refs.c
      #include "odb.h"
      #include "object.h"
      #include "path.h"
    +@@ refs.c: int ref_transaction_delete(struct ref_transaction *transaction,
    + 			   struct strbuf *err)
    + {
    + 	if (old_oid && is_null_oid(old_oid))
    +-		BUG("delete called with old_oid set to zeros");
    ++		old_oid = NULL;
    + 	if (old_oid && old_target)
    + 		BUG("delete called with both old_oid and old_target set");
    + 	if (old_target && !(flags & REF_NO_DEREF))
     @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
      	}
      }
      
     +struct delete_refs_rejection_data {
     +	int failures;
    ++	struct string_list *failed_refs;
     +};
     +
     +static void delete_refs_rejection_handler(const char *refname,
    @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
     +
     +	warning(_("could not delete reference %s: %s"), refname,
     +		details ? details : ref_transaction_error_msg(err));
    -+	data->failures = 1;
    ++	data->failures++;
    ++	if (data->failed_refs)
    ++		string_list_insert(data->failed_refs, refname);
     +}
     +
      int refs_delete_refs(struct ref_store *refs, const char *logmsg,
     -		     struct string_list *refnames, unsigned int flags)
     +		     struct string_list *refnames,
     +		     const struct oid_array *old_oids,
    ++		     struct string_list *failed_refs,
     +		     unsigned int flags)
      {
    -+	struct delete_refs_rejection_data rejection_data = { 0 };
    ++	struct delete_refs_rejection_data rejection_data = {
    ++		.failed_refs = failed_refs,
    ++	};
      	struct ref_transaction *transaction;
      	struct strbuf err = STRBUF_INIT;
     -	struct string_list_item *item;
    +-	int ret = 0, failures = 0;
     +	size_t i;
    - 	int ret = 0, failures = 0;
    ++	int ret = 0;
      	char *msg;
      
      	if (!refnames->nr)
      		return 0;
     +	if (old_oids && old_oids->nr != refnames->nr)
     +		BUG("refname and old OID counts do not match");
    ++	if (failed_refs && !failed_refs->strdup_strings)
    ++		BUG("failed ref list does not duplicate strings");
      
      	msg = normalize_reflog_message(logmsg);
      
    @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
     -	 */
     -	transaction = ref_store_transaction_begin(refs, 0, &err);
     +	transaction = ref_store_transaction_begin(refs,
    -+			old_oids ? REF_TRANSACTION_ALLOW_FAILURE : 0, &err);
    ++						  REF_TRANSACTION_ALLOW_FAILURE, &err);
      	if (!transaction) {
      		ret = error("%s", err.buf);
      		goto out;
    @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
     +		struct string_list_item *item = &refnames->items[i];
     +		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
     +
    -+		if (old_oid && is_null_oid(old_oid))
    -+			old_oid = NULL;
      		ret = ref_transaction_delete(transaction, item->string,
     -					     NULL, NULL, flags, msg, &err);
     +					     old_oid, NULL, flags, msg, &err);
      		if (ret) {
      			warning(_("could not delete reference %s: %s"),
      				item->string, err.buf);
    + 			strbuf_reset(&err);
    +-			failures = 1;
    ++			rejection_data.failures++;
    ++			if (failed_refs)
    ++				string_list_insert(failed_refs, item->string);
    + 		}
    + 	}
    + 
     @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
    - 			      refnames->items[0].string, err.buf);
      		else
      			error(_("could not delete references: %s"), err.buf);
    --	}
    -+	} else if (old_oids)
    + 	}
    ++	if (!ret)
     +		ref_transaction_for_each_rejected_update(transaction,
    -+						 delete_refs_rejection_handler,
    -+						 &rejection_data);
    ++							 delete_refs_rejection_handler,
    ++							 &rejection_data);
      
      out:
    -+	if (rejection_data.failures)
    -+		failures = 1;
    - 	if (!ret && failures)
    +-	if (!ret && failures)
    ++	if (!ret && rejection_data.failures)
      		ret = -1;
      	ref_transaction_free(transaction);
    + 	strbuf_release(&err);
     
      ## refs.h ##
     @@
    @@ refs.h: int refs_delete_ref(struct ref_store *refs, const char *msg,
      
      /*
     - * Delete the specified references. If there are any problems, emit
    +- * errors but attempt to keep going (i.e., the deletes are not done in
    +- * an all-or-nothing transaction). msg and flags are passed through to
    +- * ref_transaction_delete().
     + * Delete the specified references. If old_oids is non-NULL, it must contain
     + * an entry for each refname, in the same order. Each non-null OID is used to
     + * verify the current value of the corresponding reference before deleting
     + * it. A null OID requests an unconditional deletion, which allows callers to
     + * include broken refs whose old value cannot be resolved.
     + *
    -+ * If there are any problems, emit
    -  * errors but attempt to keep going (i.e., the deletes are not done in
    -  * an all-or-nothing transaction). msg and flags are passed through to
    -  * ref_transaction_delete().
    ++ * If failed_refs is non-NULL, it must be initialized with
    ++ * STRING_LIST_INIT_DUP. The names of individual updates that cannot be queued
    ++ * or are rejected while processing the best-effort batch are inserted into
    ++ * it. A transaction-wide failure is returned without populating the list.
    ++ *
    ++ * If there are any problems, emit errors but attempt to keep going (i.e.,
    ++ * the deletes are not done in an all-or-nothing transaction). msg and flags
    ++ * are passed through to ref_transaction_delete().
       */
      int refs_delete_refs(struct ref_store *refs, const char *msg,
     -		     struct string_list *refnames, unsigned int flags);
     +		     struct string_list *refnames,
     +		     const struct oid_array *old_oids,
    ++		     struct string_list *failed_refs,
     +		     unsigned int flags);
      
      /** Delete a reflog */
      int refs_delete_reflog(struct ref_store *refs, const char *refname);
    +@@ refs.h: int ref_transaction_create(struct ref_transaction *transaction,
    + 			   struct strbuf *err);
    + 
    + /*
    +- * Add a reference deletion to transaction. If old_oid is non-NULL,
    +- * then it holds the value that the reference should have had before
    +- * the update (which must not be null_oid).
    ++ * Add a reference deletion to transaction. If old_oid is non-NULL and not
    ++ * null_oid, then it holds the value that the reference should have had before
    ++ * the update. Passing null_oid is equivalent to passing NULL and disables the
    ++ * old value check.
    +  *
    +  * See the above comment "Reference transaction updates" for more
    +  * information.
     
      ## t/helper/test-ref-store.c ##
     @@ t/helper/test-ref-store.c: static int cmd_delete_refs(struct ref_store *refs, const char **argv)
    @@ t/helper/test-ref-store.c: static int cmd_delete_refs(struct ref_store *refs, co
      		string_list_append(&refnames, *argv++);
      
     -	result = refs_delete_refs(refs, msg, &refnames, flags);
    -+	result = refs_delete_refs(refs, msg, &refnames, NULL, flags);
    ++	result = refs_delete_refs(refs, msg, &refnames, NULL, NULL, flags);
      	string_list_clear(&refnames, 0);
      	return result;
      }
2:  2065188aa ! 2:  918c97d2b branch, tag: retain old OIDs in batched deletions
    @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
      	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
      	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
     -			     &refs_to_delete, NULL, REF_NO_DEREF))
    -+			     &refs_to_delete, &old_oids, REF_NO_DEREF))
    ++			     &refs_to_delete, &old_oids, NULL, REF_NO_DEREF))
      		ret = 1;
      
      	for_each_string_list_item(item, &refs_to_delete) {
    @@ builtin/tag.c: static int for_each_tag_name(const char **argv, each_tag_name_fn
     +	result = for_each_tag_name(argv, collect_tags, &data);
      	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
     -			     &refs_to_delete, NULL, REF_NO_DEREF))
    -+			     &data.refs, &data.old_oids, REF_NO_DEREF))
    ++			     &data.refs, &data.old_oids, NULL, REF_NO_DEREF))
      		result = 1;
      
     -	for_each_string_list_item(item, &refs_to_delete) {
3:  3f3062252 ! 3:  6f34853c7 fetch, remote: retain old OIDs when pruning refs
    @@ Commit message
         Non-atomic pruning uses refs_delete_refs(), whose partial-failure mode still
         deletes unaffected stale refs. An atomic fetch remains all-or-nothing.
     
    -    Reuse values collected while finding stale refs, avoiding additional ref
    -    reads. Avoid reporting deletion status when pruning encounters a rejected
    -    update.
    +    Continue reporting successful non-atomic deletions when another deletion is
    +    rejected, but do not report the rejected ref as deleted or use it when
    +    checking for newly dangling symrefs. Use the rejected-ref list returned by
    +    refs_delete_refs() so reporting reflects the transaction result without
    +    additional ref reads.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
     -
     -	for (ref = stale_refs; ref; ref = ref->next)
     -		string_list_append(&refnames, ref->name);
    ++	struct string_list deleted_refs = STRING_LIST_INIT_NODUP;
    ++	struct string_list failed_refs = STRING_LIST_INIT_DUP;
     +	struct oid_array old_oids = OID_ARRAY_INIT;
      
      	if (!dry_run) {
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
     -				result = ref_transaction_delete(transaction, ref->name, NULL,
     -								NULL, 0, "fetch: prune", &err);
     +				result = ref_transaction_delete(transaction, ref->name,
    -+							&ref->new_oid, NULL, 0,
    -+							"fetch: prune", &err);
    ++								&ref->new_oid, NULL, 0,
    ++								"fetch: prune", &err);
      				if (result)
      					goto cleanup;
      			}
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
      			result = refs_delete_refs(get_main_ref_store(the_repository),
      						  "fetch: prune", &refnames,
     -						  NULL, 0);
    -+						  &old_oids, 0);
    ++						  &old_oids, &failed_refs, 0);
    ++			if (result && !failed_refs.nr)
    ++				goto cleanup;
      		}
    -+		if (result)
    -+			goto cleanup;
      	}
      
    - 	if (verbosity >= 0) {
    +@@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
      		int summary_width = transport_summary_width(stale_refs);
      
    -+		if (!refnames.nr)
    -+			for (ref = stale_refs; ref; ref = ref->next)
    -+				string_list_append(&refnames, ref->name);
      		for (ref = stale_refs; ref; ref = ref->next) {
    ++			if (string_list_has_string(&failed_refs, ref->name))
    ++				continue;
    ++
      			display_ref_update(display_state, '-', _("[deleted]"), NULL,
      					   _("(none)"), ref->name,
    -@@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
    + 					   &ref->new_oid, &ref->old_oid,
    + 					   summary_width);
    ++			string_list_append(&deleted_refs, ref->name);
    + 		}
    +-		string_list_sort(&refnames);
    ++		string_list_sort(&deleted_refs);
    + 		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
    +-					   stderr, "   ", dry_run, &refnames);
    ++					   stderr, "   ", dry_run, &deleted_refs);
    + 	}
      
      cleanup:
      	string_list_clear(&refnames, 0);
    ++	string_list_clear(&deleted_refs, 0);
    ++	string_list_clear(&failed_refs, 0);
     +	oid_array_clear(&old_oids);
      	strbuf_release(&err);
      	free_refs(stale_refs);
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
      	int result = 0;
      	struct ref_states states = REF_STATES_INIT;
      	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
    ++	struct string_list pruned_refs = STRING_LIST_INIT_NODUP;
    ++	struct string_list failed_refs = STRING_LIST_INIT_DUP;
     +	struct oid_array old_oids = OID_ARRAY_INIT;
      	struct string_list_item *item;
      
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
      		result |= refs_delete_refs(get_main_ref_store(the_repository),
      					   "remote: prune", &refs_to_prune,
     -					   NULL, 0);
    -+					   &old_oids, 0);
    -+		if (result)
    ++					   &old_oids, &failed_refs, 0);
    ++		if (result && !failed_refs.nr)
     +			goto cleanup;
     +	}
      
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
     -		const char *refname = item->util;
     +		struct stale_ref *stale_ref = item->util;
     +		const char *refname = stale_ref->name;
    ++
    ++		if (string_list_has_string(&failed_refs, refname))
    ++			continue;
      
      		if (dry_run)
      			printf_ln(_(" * [would prune] %s"),
     @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
    + 		else
    + 			printf_ln(_(" * [pruned] %s"),
    + 			       abbrev_ref(refname, "refs/remotes/"));
    ++		string_list_append(&pruned_refs, refname);
    + 	}
    + 
      	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
    - 				   stdout, " ", dry_run, &refs_to_prune);
    +-				   stdout, " ", dry_run, &refs_to_prune);
    ++				   stdout, " ", dry_run, &pruned_refs);
      
     +cleanup:
      	string_list_clear(&refs_to_prune, 0);
    ++	string_list_clear(&pruned_refs, 0);
    ++	string_list_clear(&failed_refs, 0);
     +	oid_array_clear(&old_oids);
      	free_remote_ref_states(&states);
      	return result;
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'branch deletion rejects a
     +	)
     +'
     +
    -+test_expect_success 'remote prune rejects a concurrent update' '
    ++test_expect_success 'remote prune reports deletions around a concurrent update' '
     +	test_when_finished "rm -rf race-empty.git race-prune" &&
     +	git init --bare race-empty.git &&
     +	git init race-prune &&
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'branch deletion rejects a
     +		test_must_fail git remote prune origin >out 2>err &&
     +		test_cmp_rev "$two" refs/remotes/origin/race &&
     +		test_must_fail git rev-parse --verify refs/remotes/origin/other &&
    -+		test_grep ! "\[pruned\]" out
    ++		test_grep "\[pruned\].*origin/other" out &&
    ++		test_grep ! "\[pruned\].*origin/race" out &&
    ++		test_grep "could not delete reference refs/remotes/origin/race" err
    ++	)
    ++'
    ++
    ++test_expect_success 'fetch prune reports deletions around a concurrent update' '
    ++	test_when_finished "rm -rf fetch-empty.git fetch-prune" &&
    ++	git init --bare fetch-empty.git &&
    ++	git init fetch-prune &&
    ++	(
    ++		cd fetch-prune &&
    ++		git commit --allow-empty -m one &&
    ++		one=$(git rev-parse HEAD) &&
    ++		git commit --allow-empty -m two &&
    ++		git remote add origin ../fetch-empty.git &&
    ++		git update-ref refs/remotes/origin/race "$one" &&
    ++		git update-ref refs/remotes/origin/other "$one"
    ++	) &&
    ++	test_hook -C fetch-prune reference-transaction <<-\EOF &&
    ++		marker=$(git rev-parse --git-path prune-race-once)
    ++		if test "$1" = preparing && test ! -e "$marker"
    ++		then
    ++			>"$marker"
    ++			git update-ref refs/remotes/origin/race HEAD
    ++		fi
    ++		exit 0
    ++	EOF
    ++	(
    ++		cd fetch-prune &&
    ++		two=$(git rev-parse HEAD) &&
    ++		test_must_fail git fetch --prune origin >out 2>err &&
    ++		test_cmp_rev "$two" refs/remotes/origin/race &&
    ++		test_must_fail git rev-parse --verify refs/remotes/origin/other &&
    ++		test_grep "\[deleted\].*origin/other" err &&
    ++		test_grep ! "\[deleted\].*origin/race" err &&
    ++		test_grep "could not delete reference refs/remotes/origin/race" err
     +	)
     +'
     +
-- 
2.39.3 (Apple Git-146)
