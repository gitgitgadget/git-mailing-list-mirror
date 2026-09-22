Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E239CD19
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079976; cv=none; b=qZEladDbPJtWxaWmfqcV+pa7wDdt79mnVR7uBNUNxYjDhRNzjOnJwDxjZgtoq5Knh8ZGo5JCCssjXQrzpycYksqp3WBm9gD7YFaPDsa+opnbQQHlhVTe4ePvWRxmNYlRbZmc4S5MsU3pzCvHVBvn59qhmJbsFFhPS1XzU7e/7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079976; c=relaxed/simple;
	bh=9YnibNcLy6NB/Tt6DlJfkzvOfplPyCAIAUzshblzSFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+na+pYNfzAKdhrNOiS1X0mVtvzJhlxC+IqL7Ooc+SnXQ4CJH9D92TsVgJO+YDATHeB5GEwaYL5B0oeS50u1w0uJeLOMoKQtaVi6Jf8FM/NzYWcbYy38FtNzq4oIIcaEdHwT+vIqkaIW39gFkG/DSUDh6GmYBbqerfH6fTELDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkSURuGx; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkSURuGx"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15d3so523665566b.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079972; x=1790684772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RjqJa+qTG0M4hn1UJX7QrRyWlKESqSq6VDA/anemsaU=;
        b=MkSURuGxI0C68Jc8FNmBv4w0/aw/cx3EB/8sMQkPg4NTrqxJazubB6YwTeXhm1Yqzg
         7iqVSLaCqCWRtlFxYVXyWCzBc4PZiJ+IotXoMuQ5L25+enkisbAH7sUG4uMVXZvHtdWC
         ol3hh/428TDH/gzKs57TpsLGYGS0ZdXh9y3JOuUhvUnWh9gLDdKX1DfLddGGSNtqXaYd
         gWdX8sQf/nCooapjAZT0D5MavnTm7MzgK6/jteAE4VF2P5l5+WwToTZrrSzXcJBmmclK
         gvPLXKO6f2q466fOzQtrSAQHA58ifi3l/opVQlwHJ4GDAaU3lPNbjU98UL6TjdF47PC2
         HBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079972; x=1790684772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RjqJa+qTG0M4hn1UJX7QrRyWlKESqSq6VDA/anemsaU=;
        b=q2dryQt7VF/B0Ujzzr7V0LrHeIFL4nktjYYw9QUVjsHXCdgZIttDB0hn78VunkDq/H
         50bmsOnX0ZJsPsnSFunpVnJTjtPYjkdgEcuqhe383MGxy+sgO4SKBk5l0QiOJxZNnGGz
         VSxg9kPJZ8/i7QQqjPNG9yM+etjSgv5V7BSx96rUfWXcsmR0Fol4hcvl3z/BK0Kmna1s
         pwlhAPB2UvCnD44KmWh5Z17apgqrzmxZn5akSY+bRnmKMVbGgoaHvsSWlHNAfrJD69zr
         RGk1lcgqkRx7jOYCJeJ/GjPPiWhpfmy5XxuVn+AzdAFcusZYDH1oE4+HfaYmMXhfucKf
         klcQ==
X-Gm-Message-State: AFuF++lCzRChsYAF89ubyaghAxcSvDPiikZPFs/xhh4a5dhuQuIjJ3i2
	zomUEw9/W3YGWyymG+k6srdtlCCOY4kLGMJ6TjuoDFA5cXu7AuRy1QfRF1SXvdTU
X-Gm-Gg: AYBFou2hfY9q57qI3nGd1zLthgUeTgGbYznqH6LwrOu/e05/FChGzhq75LpLbFD44tO
	oCkS7aBgCrDbKCkDgUozeHu1RpFnHG+sBhXPGODYwexRL7nMSDGFLv0/zhrIRswv0pTjwpdn/cS
	RBv0t6nkDitsQ7rl7wZ2mZBRoyYJ/aF10WAFLnDbL8FWqGUEokMI4Dz2yauXBtIzteCqEztAfbv
	oK53nqNq44uMe8rwOYYw1KVmYcK1zFbCoUKJP43AY4T6J7JOtY3X+SABBnSQLfHI4uZ+VkHOMCg
	6WsCYE/68cJ7Cv6/hKmSKPVPkjsX/JUckyqS9RnZYdJ242oZNXuHb5KseideTg4qzV375bfgp8w
	y+oCqD03IpI2/oB1aRwb4K2WSwuouZHNZ5y0HyLZjvsr1Z4TA56sUBl82YRPJrP/3I4Ubpo1X/4
	oGL0na9HvS1zdvArJNkqu2sDk3Xud5rKpmVrwVToZy/y0u8MO4q1vAYkS496fEOUMGxVtlPMeUD
	jwu5sCfC5qTrh6FuieQI/u1oIXlSDlaOOJ4sBRING6I7Pkae2q49dXoTLa6ZhbPRLYDT/t1+EYh
	VgsHkQ7VZWHz7lGda2zJQSB6dW9nY7rc3qQZlmP2YZVv3gxKQyhxGvH2WCA=
X-Received: by 2002:a17:907:720b:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c2a1569a563mr1187923366b.3.1790079971517;
        Tue, 22 Sep 2026 05:26:11 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c54f30dsm77322566b.17.2026.09.22.05.26.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 05:26:11 -0700 (PDT)
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
Subject: [PATCH v3 0/3] refs: report old OIDs for batched deletions
Date: Tue, 22 Sep 2026 14:26:06 +0200
Message-Id: <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows up on the reference-transaction bug report at [1].

The reference-transaction hook receives zero as both the old and new OID
when branch, tag, fetch, and remote delete refs through refs_delete_refs().
Those callers already know the values that they selected for deletion.

Teach refs_delete_refs() to accept a parallel array of expected old OIDs and
pass them into the transaction. Besides making hook records useful, this
restores conditional deletion for branch and tag and adds it to pruning
without additional ref reads. Use REF_TRANSACTION_ALLOW_FAILURE for
non-atomic batches so a concurrent change rejects only that deletion while
unrelated stale refs are still removed. Atomic fetches retain their
all-or-nothing behavior.

Changes since v2:

 * Rebase onto master at d38352cd43.
 * Use REF_TRANSACTION_ALLOW_FAILURE for conditional batch deletion and
   report individual rejections.
 * Clarify how the parallel refname and old-OID arrays correspond, and skip
   their length check when there are no refs to delete.
 * Document null OIDs as the unconditional-deletion sentinel needed for
   broken refs.
 * Append tag OIDs in collect_tags() instead of making a second pass.
 * Build the fetch refname/OID arrays only for non-atomic pruning and fix the
   atomic-path formatting.
 * Replace deprecated test_create_repo calls, clean up test repositories,
   remove unnecessary packed-ref setup, and cover partial prune failure.

The full test suite passes with DEVELOPER=1. The focused tests also pass with
SHA-1 and SHA-256 using both the files and reftable backends.

[1] https://lore.kernel.org/git/CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com/

Maciej Ciemborowicz (3):
  refs: allow callers to supply old OIDs for batch deletion
  branch, tag: retain old OIDs in batched deletions
  fetch, remote: retain old OIDs when pruning refs

 bisect.c                         |   2 +-
 builtin/branch.c                 |   7 +-
 builtin/fetch.c                  |  21 ++++--
 builtin/remote.c                 |  37 +++++++--
 builtin/tag.c                    |  28 +++++--
 refs.c                           |  54 +++++++++++---
 refs.h                           |  13 +++-
 t/helper/test-ref-store.c        |   2 +-
 t/t1416-ref-transaction-hooks.sh | 124 +++++++++++++++++++++++++++++++
 9 files changed, 250 insertions(+), 38 deletions(-)

Range-diff against v2:
1:  2e36ce00e ! 1:  3315d5f47 refs: allow callers to supply old OIDs for batch deletion
    @@ Metadata
      ## Commit message ##
         refs: allow callers to supply old OIDs for batch deletion
     
    -    refs_delete_refs() currently performs unconditional deletions. Thus callers
    -    cannot preserve old values that they have already resolved, and
    -    reference-transaction hooks consequently see a null old OID.
    +    refs_delete_refs() performs unconditional deletions, so callers cannot
    +    preserve old values that they have already resolved. Consequently,
    +    reference-transaction hooks see a null old OID.
     
    -    Add an optional oid_array whose entries correspond to the refnames. Pass each
    -    non-null OID to ref_transaction_delete(). Supplying an OID makes the deletion
    -    conditional: if the ref changed after the caller resolved it, the transaction
    -    fails instead of deleting the new value. Existing callers that pass NULL
    -    retain the unconditional behavior.
    +    Let callers provide an optional array of expected old OIDs in parallel with
    +    the refname list. When the array is provided, delete the ref at position N
    +    only if it still points at the OID at position N. A null OID requests an
    +    unconditional deletion for refs whose old value cannot be resolved, such as
    +    broken refs.
    +
    +    Use REF_TRANSACTION_ALLOW_FAILURE when old OIDs are supplied. This retains
    +    the helper's best-effort behavior: an old-OID mismatch rejects that deletion
    +    while independent deletions in the batch can still proceed.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ bisect.c: int bisect_clean_state(void)
      	unlink_or_warn(git_path_bisect_log());
     
      ## builtin/branch.c ##
    -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
    - 		free(target);
    +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
      	}
      
    --	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
    -+	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
    + 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
    +-	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
    ++	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
     +			     &refs_to_delete, NULL, REF_NO_DEREF))
      		ret = 1;
      
    @@ refs.c
      #include "object.h"
      #include "path.h"
     @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
    + 	}
      }
      
    ++struct delete_refs_rejection_data {
    ++	int failures;
    ++};
    ++
    ++static void delete_refs_rejection_handler(const char *refname,
    ++					  const struct object_id *old_oid UNUSED,
    ++					  const struct object_id *new_oid UNUSED,
    ++					  const char *old_target UNUSED,
    ++					  const char *new_target UNUSED,
    ++					  enum ref_transaction_error err,
    ++					  const char *details,
    ++					  void *cb_data)
    ++{
    ++	struct delete_refs_rejection_data *data = cb_data;
    ++
    ++	warning(_("could not delete reference %s: %s"), refname,
    ++		details ? details : ref_transaction_error_msg(err));
    ++	data->failures = 1;
    ++}
    ++
      int refs_delete_refs(struct ref_store *refs, const char *logmsg,
     -		     struct string_list *refnames, unsigned int flags)
     +		     struct string_list *refnames,
     +		     const struct oid_array *old_oids,
     +		     unsigned int flags)
      {
    ++	struct delete_refs_rejection_data rejection_data = { 0 };
      	struct ref_transaction *transaction;
      	struct strbuf err = STRBUF_INIT;
     -	struct string_list_item *item;
    @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
      	int ret = 0, failures = 0;
      	char *msg;
      
    -+	if (old_oids && old_oids->nr != refnames->nr)
    -+		BUG("refname and old OID counts do not match");
      	if (!refnames->nr)
      		return 0;
    ++	if (old_oids && old_oids->nr != refnames->nr)
    ++		BUG("refname and old OID counts do not match");
      
      	msg = normalize_reflog_message(logmsg);
      
    @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
     -	 * individual updates can't fail, so we can pack all of the
     -	 * updates into a single transaction.
     -	 */
    - 	transaction = ref_store_transaction_begin(refs, 0, &err);
    +-	transaction = ref_store_transaction_begin(refs, 0, &err);
    ++	transaction = ref_store_transaction_begin(refs,
    ++			old_oids ? REF_TRANSACTION_ALLOW_FAILURE : 0, &err);
      	if (!transaction) {
      		ret = error("%s", err.buf);
      		goto out;
    @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
      		if (ret) {
      			warning(_("could not delete reference %s: %s"),
      				item->string, err.buf);
    +@@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
    + 			      refnames->items[0].string, err.buf);
    + 		else
    + 			error(_("could not delete references: %s"), err.buf);
    +-	}
    ++	} else if (old_oids)
    ++		ref_transaction_for_each_rejected_update(transaction,
    ++						 delete_refs_rejection_handler,
    ++						 &rejection_data);
    + 
    + out:
    ++	if (rejection_data.failures)
    ++		failures = 1;
    + 	if (!ret && failures)
    + 		ret = -1;
    + 	ref_transaction_free(transaction);
     
      ## refs.h ##
     @@
    @@ refs.h: int refs_delete_ref(struct ref_store *refs, const char *msg,
      /*
     - * Delete the specified references. If there are any problems, emit
     + * Delete the specified references. If old_oids is non-NULL, it must contain
    -+ * an entry for each refname, in the same order. Each non-null entry is used
    -+ * to verify the current value of the corresponding reference before deleting
    -+ * it. A null entry disables verification for that reference.
    ++ * an entry for each refname, in the same order. Each non-null OID is used to
    ++ * verify the current value of the corresponding reference before deleting
    ++ * it. A null OID requests an unconditional deletion, which allows callers to
    ++ * include broken refs whose old value cannot be resolved.
     + *
     + * If there are any problems, emit
       * errors but attempt to keep going (i.e., the deletes are not done in
2:  e8b867f8e ! 2:  2065188aa branch, tag: retain old OIDs in batched deletions
    @@ Commit message
         delete_ref(). This prevented the command from deleting a ref that another
         process had changed after it was inspected.
     
    -    The conversion to batched deletion dropped those old OIDs. Besides making the
    -    deletions unconditional, this causes reference-transaction hooks to report
    -    zero as both the old and new OID.
    +    The conversion to batched deletion dropped those old OIDs. Besides making
    +    the deletions unconditional, this causes reference-transaction hooks to
    +    report zero as both the old and new OID.
     
         Both commands still resolve the old OIDs before starting the deletion. Pass
    -    those values to refs_delete_refs(). This restores the old race protection and
    -    lets hooks receive useful old values without adding any ref reads. If a ref
    -    changes concurrently, the transaction fails and preserves the new value.
    +    those values to refs_delete_refs(). This restores the old race protection
    +    and lets hooks receive useful old values without adding ref reads. If a ref
    +    changes concurrently, reject its deletion and preserve the new value.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ builtin/branch.c
      #include "remote.h"
      #include "parse-options.h"
      #include "branch.h"
    -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
    +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
      	struct strbuf bname = STRBUF_INIT;
      	enum interpret_branch_kind allowed_interpret;
      	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
    @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      	struct string_list_item *item;
      	int branch_name_pos;
      	const char *fmt_remotes = "refs/remotes/%s";
    -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
    +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
      		}
      
      		item = string_list_append(&refs_to_delete, name);
     +		oid_array_append(&old_oids, &oid);
    - 		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
    - 				    : (flags & REF_ISSYMREF) ? target
    + 		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
    + 				    : (ref_flags & REF_ISSYMREF) ? target
      				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
    -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
    - 	}
    +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
      
    - 	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
    + 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
    + 	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
     -			     &refs_to_delete, NULL, REF_NO_DEREF))
     +			     &refs_to_delete, &old_oids, REF_NO_DEREF))
      		ret = 1;
      
      	for_each_string_list_item(item, &refs_to_delete) {
    -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
    +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
      		free(describe_ref);
      	}
      	string_list_clear(&refs_to_delete, 0);
    @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      	strbuf_release(&bname);
     
      ## builtin/tag.c ##
    -@@ builtin/tag.c: static int delete_tags(const char **argv)
    +@@ builtin/tag.c: static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
    + 	return had_error;
    + }
    + 
    ++struct tags_to_delete {
    ++	struct string_list refs;
    ++	struct oid_array old_oids;
    ++};
    ++
    + static int collect_tags(const char *name UNUSED, const char *ref,
    + 			const struct object_id *oid, void *cb_data)
    + {
    +-	struct string_list *ref_list = cb_data;
    ++	struct tags_to_delete *data = cb_data;
    ++	struct string_list_item *item;
    + 
    +-	string_list_append(ref_list, ref);
    +-	ref_list->items[ref_list->nr - 1].util = oiddup(oid);
    ++	item = string_list_append(&data->refs, ref);
    ++	item->util = oiddup(oid);
    ++	oid_array_append(&data->old_oids, oid);
    + 	return 0;
    + }
    + 
    + static int delete_tags(const char **argv)
      {
      	int result;
    - 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
    -+	struct oid_array old_oids = OID_ARRAY_INIT;
    +-	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
    ++	struct tags_to_delete data = {
    ++		.refs = STRING_LIST_INIT_DUP,
    ++		.old_oids = OID_ARRAY_INIT,
    ++	};
      	struct string_list_item *item;
      
    - 	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
    -+	for_each_string_list_item(item, &refs_to_delete)
    -+		oid_array_append(&old_oids, item->util);
    +-	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
    ++	result = for_each_tag_name(argv, collect_tags, &data);
      	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
     -			     &refs_to_delete, NULL, REF_NO_DEREF))
    -+			     &refs_to_delete, &old_oids, REF_NO_DEREF))
    ++			     &data.refs, &data.old_oids, REF_NO_DEREF))
      		result = 1;
      
    - 	for_each_string_list_item(item, &refs_to_delete) {
    +-	for_each_string_list_item(item, &refs_to_delete) {
    ++	for_each_string_list_item(item, &data.refs) {
    + 		const char *name = item->string;
    + 		struct object_id *oid = item->util;
    + 		if (!refs_ref_exists(get_main_ref_store(the_repository), name))
     @@ builtin/tag.c: static int delete_tags(const char **argv)
    + 
      		free(oid);
      	}
    - 	string_list_clear(&refs_to_delete, 0);
    -+	oid_array_clear(&old_oids);
    +-	string_list_clear(&refs_to_delete, 0);
    ++	string_list_clear(&data.refs, 0);
    ++	oid_array_clear(&data.old_oids);
      	return result;
      }
      
3:  6aebfac97 ! 3:  3f3062252 fetch, remote: retain old OIDs when pruning refs
    @@ Commit message
         fetch, remote: retain old OIDs when pruning refs
     
         get_stale_heads() records the current value of each stale local ref in its
    -    new_oid member. The pruning paths discard that value and request unconditional
    -    deletion, so reference-transaction hooks receive a null old OID.
    +    new_oid member. The pruning paths discard that value and request
    +    unconditional deletion, so reference-transaction hooks receive a null old
    +    OID.
     
    -    Carry the recorded values into the deletion transactions. Besides giving the
    -    hooks useful values, this stops a stale scan from deleting a ref that another
    -    process updated before the transaction acquired its locks. A concurrent
    -    change now makes the prune fail and preserves the new value.
    +    Pass the recorded values into the deletion transactions. If a ref changes
    +    after the stale scan, reject that deletion and preserve the new value.
    +    Non-atomic pruning uses refs_delete_refs(), whose partial-failure mode still
    +    deletes unaffected stale refs. An atomic fetch remains all-or-nothing.
     
    -    This reuses data collected while finding stale refs and therefore requires no
    -    additional ref reads. Do not print deletion status when a non-atomic prune
    -    fails its old-OID check.
    +    Reuse values collected while finding stale refs, avoiding additional ref
    +    reads. Avoid reporting deletion status when pruning encounters a rejected
    +    update.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
      	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
      	struct strbuf err = STRBUF_INIT;
      	struct string_list refnames = STRING_LIST_INIT_NODUP;
    -+	struct oid_array old_oids = OID_ARRAY_INIT;
    - 
    +-
     -	for (ref = stale_refs; ref; ref = ref->next)
    -+	for (ref = stale_refs; ref; ref = ref->next) {
    - 		string_list_append(&refnames, ref->name);
    -+		oid_array_append(&old_oids, &ref->new_oid);
    -+	}
    +-		string_list_append(&refnames, ref->name);
    ++	struct oid_array old_oids = OID_ARRAY_INIT;
      
      	if (!dry_run) {
      		if (transaction) {
      			for (ref = stale_refs; ref; ref = ref->next) {
     -				result = ref_transaction_delete(transaction, ref->name, NULL,
    +-								NULL, 0, "fetch: prune", &err);
     +				result = ref_transaction_delete(transaction, ref->name,
    -+							&ref->new_oid,
    - 								NULL, 0, "fetch: prune", &err);
    ++							&ref->new_oid, NULL, 0,
    ++							"fetch: prune", &err);
      				if (result)
      					goto cleanup;
    -@@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
    + 			}
      		} else {
    ++			for (ref = stale_refs; ref; ref = ref->next) {
    ++				string_list_append(&refnames, ref->name);
    ++				oid_array_append(&old_oids, &ref->new_oid);
    ++			}
      			result = refs_delete_refs(get_main_ref_store(the_repository),
      						  "fetch: prune", &refnames,
     -						  NULL, 0);
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
      	}
      
      	if (verbosity >= 0) {
    + 		int summary_width = transport_summary_width(stale_refs);
    + 
    ++		if (!refnames.nr)
    ++			for (ref = stale_refs; ref; ref = ref->next)
    ++				string_list_append(&refnames, ref->name);
    + 		for (ref = stale_refs; ref; ref = ref->next) {
    + 			display_ref_update(display_state, '-', _("[deleted]"), NULL,
    + 					   _("(none)"), ref->name,
     @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
      
      cleanup:
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
      
     -	for_each_string_list_item(item, &states.stale)
     -		string_list_append(&refs_to_prune, item->util);
    +-	string_list_sort(&refs_to_prune);
     +	for_each_string_list_item(item, &states.stale) {
     +		struct stale_ref *stale_ref = item->util;
    -+		struct string_list_item *to_prune;
     +
    -+		to_prune = string_list_append(&refs_to_prune, stale_ref->name);
    -+		to_prune->util = &stale_ref->oid;
    ++		string_list_append(&refs_to_prune, stale_ref->name);
    ++		oid_array_append(&old_oids, &stale_ref->oid);
     +	}
    - 	string_list_sort(&refs_to_prune);
    -+	for_each_string_list_item(item, &refs_to_prune)
    -+		oid_array_append(&old_oids, item->util);
      
     -	if (!dry_run)
     +	if (!dry_run) {
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'branch deletion rejects a
      '
      
     +test_expect_success 'hook gets old values when pruning remote refs' '
    -+	test_create_repo empty.git --bare &&
    -+	test_create_repo prune &&
    -+	git -C prune remote add origin ../empty.git &&
    -+	test_commit -C prune one &&
    -+	one=$(git -C prune rev-parse HEAD) &&
    -+	test_commit -C prune two &&
    -+	two=$(git -C prune rev-parse HEAD) &&
    -+	git -C prune update-ref refs/remotes/origin/remote-prune-z "$one" &&
    -+	git -C prune update-ref refs/remotes/origin/remote-prune-a "$two" &&
    -+	git -C prune pack-refs --all &&
    ++	test_when_finished "rm -rf empty.git prune" &&
    ++	git init --bare empty.git &&
    ++	git init prune &&
    ++	(
    ++		cd prune &&
    ++		git remote add origin ../empty.git &&
    ++		git commit --allow-empty -m one &&
    ++		one=$(git rev-parse HEAD) &&
    ++		git commit --allow-empty -m two &&
    ++		two=$(git rev-parse HEAD) &&
    ++		git update-ref refs/remotes/origin/remote-prune-z "$one" &&
    ++		git update-ref refs/remotes/origin/remote-prune-a "$two"
    ++	) &&
     +	test_hook -C prune reference-transaction <<-\EOF &&
     +		if test "$1" = committed
     +		then
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'branch deletion rejects a
     +	EOF
     +	(
     +		cd prune &&
    ++		one=$(git rev-parse HEAD^) &&
    ++		two=$(git rev-parse HEAD) &&
     +		git remote prune origin &&
     +		git update-ref refs/remotes/origin/fetch-prune "$one" &&
     +		git fetch --prune origin &&
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'branch deletion rejects a
     +
     +test_expect_success 'remote prune rejects a concurrent update' '
     +	test_when_finished "rm -rf race-empty.git race-prune" &&
    -+	test_create_repo race-empty.git --bare &&
    -+	test_create_repo race-prune &&
    -+	test_commit -C race-prune one &&
    -+	one=$(git -C race-prune rev-parse HEAD) &&
    -+	test_commit -C race-prune two &&
    -+	two=$(git -C race-prune rev-parse HEAD) &&
    -+	git -C race-prune remote add origin ../race-empty.git &&
    -+	git -C race-prune update-ref refs/remotes/origin/race "$one" &&
    ++	git init --bare race-empty.git &&
    ++	git init race-prune &&
    ++	(
    ++		cd race-prune &&
    ++		git commit --allow-empty -m one &&
    ++		one=$(git rev-parse HEAD) &&
    ++		git commit --allow-empty -m two &&
    ++		two=$(git rev-parse HEAD) &&
    ++		git remote add origin ../race-empty.git &&
    ++		git update-ref refs/remotes/origin/race "$one" &&
    ++		git update-ref refs/remotes/origin/other "$one"
    ++	) &&
     +	test_hook -C race-prune reference-transaction <<-\EOF &&
     +		marker=$(git rev-parse --git-path prune-race-once)
     +		if test "$1" = preparing && test ! -e "$marker"
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'branch deletion rejects a
     +		fi
     +		exit 0
     +	EOF
    -+	test_must_fail git -C race-prune remote prune origin >out 2>err &&
    -+	test "$two" = "$(git -C race-prune rev-parse refs/remotes/origin/race)" &&
    -+	! grep "\[pruned\]" out
    ++	(
    ++		cd race-prune &&
    ++		two=$(git rev-parse HEAD) &&
    ++		test_must_fail git remote prune origin >out 2>err &&
    ++		test_cmp_rev "$two" refs/remotes/origin/race &&
    ++		test_must_fail git rev-parse --verify refs/remotes/origin/other &&
    ++		test_grep ! "\[pruned\]" out
    ++	)
     +'
     +
      test_expect_success 'hook allows updating ref if successful' '

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
2.39.3 (Apple Git-146)

