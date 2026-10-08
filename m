Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9747255B
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452675; cv=none; b=qMPcrj8amE1oI4dA45XbfeOQQmfDg+49jFdvdQinoWwlb7N9hfg9Ngv2KsZQT2KSteTb3HlHhvPUdW0F2avVGhhVHORPtZ/Qb4gwkG1nRJqTPudiAfOgCFuoEqdIs9BAuz79pLv5RvOQ7lbqRLuaDcRLinZ/eL0tEogBFgaNB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452675; c=relaxed/simple;
	bh=nMQuLSBP/dn7GnNVDZupJ6Jn8Qd9FF/0X1/39qsodeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=F23t+i7ArSXg3MLN1UKsxBTlc0jopiRMLZXREVQsl5e3FDmuKokudvsuEVgsHAS+9AewFvx/EjyM/2ZSt7AoxGMOKI6QI1PfZ4yFXvqXuj5+pNjq1E7mcW68z1xbZxcOy2ZU+HmvEOrKJIjD8KC8o3WLLKRtx9/4s4Er6Hfnv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVsjV3xI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVsjV3xI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso440523466b.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452669; x=1792057469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+FIausxhyo5/ISssoBnuspsjy46dhm74XQ29TFEUK4=;
        b=LVsjV3xIRqwOTzqYjiEYDtVkoKnQ32hd7JcmU60Eh8Segn7/56fWOPS3Zlmyilu9Zq
         QPoPnXwi5wBcxAxHDdGUbvAcqhp7CpEEmPBfYZDnrdzX3XQuPK7/Z//IsEBhWpRnr/VK
         iUXJRANyzIa1M2IHj4WOz+i5Msz0HN409bjpXAKAQqSAc6KSW1ntUlWAN+4tlKw2ZUpC
         57gpOBdnAofk0+ViLZ6AfgYElVgXBcaxG6dlD/J4Jz9BGmbsqOo2BiFeL8XtKr3DQkLb
         vJNnjI77i6ZuG0KYw4+7HC19cYiu5xqR5isqoQlJfwlNbw1QAiSRmLkBAGv30Ncq5IBe
         ORvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452669; x=1792057469;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+FIausxhyo5/ISssoBnuspsjy46dhm74XQ29TFEUK4=;
        b=FK+9I3ih8zQkyzxMRgyAgfWxtNy0GBn0v47WnpEQXqZ4wqY/uJVCDiLFxlocTk0PRq
         ji+ipffeHl6FvxMa6InpT5B1K7OM28LyqTOz7XQQvDhP8i9siwGadWyPSeCsO5d8lapn
         QpRWOxermYLhwHjkM475oK0twvthkF2xtvxfVuSKeyQDba2HQ0+mCXKvVwzo418E+gd6
         DLNPS/lf+VEbd5SLuDAJJIsobODy10ggk51Wb/DOTG1CHOdZzsJB1GObbJrHlf92yBSk
         cjwBCQBPTyAcRk5sFK17pW+a8XJ6TCE3e79t6eeyYzpO8Zv7fDm/J4zs1AC8UB3E1e5i
         L4XA==
X-Gm-Message-State: AFq9FYKwqPsQdmav2amlKWqzM+dp+ve/cqY6jz2uvQ8UToKyqLiB/RZh
	i+ifXwEOl5oxi53Y3ZMqiQWZvoJqvD+tGzAeeMg2fvm1xCD6PVBZCtDElGRvKg==
X-Gm-Gg: AYBFou3ikuSOYeQzxpJzik93aHf4ITMOtEVQzaaiVtrir9SeTPp4F6v14X11aLf7PuF
	23CzwMuZI1ngA/jkrjssdGxjRDyPKFjSnAisKtsGYzPNhstkdfy17NEGeNo5QpHeJa1K+uM6haF
	W/Od8lFkLZmaqWQeAUVim2a9BTKQsOmd6fL37pSVe9Ij6gFMrf7FuazSnYv20/0rpMXBJLBMmX8
	aXPHyv/30j22t9s0mYuI5e7dpvkVBUu/NZvGRBt9R66tRwhD2KERK7kHqmIQf/NNvxjeuvdZt2y
	ZLQHu/6L6mFfUEY2Vibs4aRyL8urPBlHABfgEHomUO9C2WeulfkuM2MfUG/akUWl3ar4ZOASfBA
	2PHijixalwhEymLaebDHXXEfx49j+2V5p1N671T+RBnwzfmC7XSvNmCrfHtM/0uvSxdHdp5+xid
	U2vUwwGTwZiXGXgunZkZ6QumhFkT/SEFE8f45/SNiTI+IY402lKxQbN4ygX33o9Ce1W9JoemOGm
	2sYbF4H7+FnfQ0Q22TeQkM1Qv/HDQi3LgAS9RLDVQ301esTvbefvG12yOnKzEU3eYw7+XaAIMAD
	eZ71TlAKn4NtUEmur/rpejrIx7Sv/BpDT9IMh0dZ0Xg4M/zKeQX5eqv4hES2CPkS6W4QfBiKsOa
	YVeb9Kaj/u/TIGdcLaNfKccMn/fgaiU0Q+QOblGTun4E=
X-Received: by 2002:a17:907:72c9:b0:c2e:32a4:f516 with SMTP id a640c23a62f3a-c317c10e885mr499512866b.42.1791452668820;
        Thu, 08 Oct 2026 02:44:28 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([192.166.203.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c318ae45e19sm114188366b.61.2026.10.08.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:44:28 -0700 (PDT)
Message-Id: <150349f9d01e89ed460ed3bd4590139e1e524e67.1791452597.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791452597.git.maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 08 Oct 2026 11:44:18 +0200
Subject: [PATCH v4 3/4] refs: run copy and rename through ordinary
 transactions
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Copy and rename currently bypass reference transactions. A hook sees the
source deletion with files and sees neither endpoint with reftable.
Queue the source and destination as ordinary updates instead, with the
destination referring to its source update.

Read and lock the source during prepare, then replay its history through
the explicit reflog API. Keep this state per update so multiple
independent operations and ordinary updates can share a transaction. Do
not reject source changes made before locking: preparing is advisory,
while prepared sees the values read under lock and unchanged on-disk
refs and reflogs.

For files D/F and case-only renames, the source prevents locking a loose
destination. Queue the destination in packed-refs, protected by the
source lock (and an ancestor lock when needed). Suppress hooks for this
physical child transaction only. Keep source logs until finish and use
the staged replacements so a veto needs no rollback writes. During
finish, retain a unique backup of a D/F source log until its destination
log is installed, and restore it if installation fails.

Preserve the backends' distinct final reflog records. Forced reftable
copies now replace destination history instead of retaining unrelated
destination entries. Add regression tests for hooks, full histories,
HEAD, source races, mixed transactions, lock and installation errors,
restoration and cleanup, and a reproducible performance test.

Replaying history costs O(N) time and memory. In a local no-hook
benchmark with 10,000 entries, files rename takes about 17 ms versus 5
ms before, and reftable rename about 54 ms versus 44 ms. Short-history
operations remain within roughly 1 ms. This trades the files
constant-time rename for staging that does not expose partial changes to
a prepared hook.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 Documentation/githooks.adoc     |  10 +
 refs.c                          | 163 +++++++++++++--
 refs.h                          |  16 ++
 refs/files-backend.c            | 225 +++++++++++++++++++-
 refs/refs-internal.h            |  13 ++
 refs/reftable-backend.c         |  37 +++-
 t/helper/test-ref-store.c       |  36 ++++
 t/meson.build                   |   1 +
 t/perf/p1424-ref-copy-rename.sh |  48 +++++
 t/t1424-ref-copy-transaction.sh | 352 ++++++++++++++++++++++++++++++++
 10 files changed, 881 insertions(+), 20 deletions(-)
 create mode 100755 t/perf/p1424-ref-copy-rename.sh
 create mode 100755 t/t1424-ref-copy-transaction.sh

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 145642bf05..245fec3b70 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -518,6 +518,16 @@ distinguish these cases, you can inspect the current value of
 references are not resolved: `<ref-name>` will reflect the symbolic reference
 itself rather than the object it points to.
 
+Copying or renaming a reference is reported as one transaction. A rename
+reports the deletion of the source and the update of the destination;
+a copy reports only the destination update. Copying the reflog does not
+produce additional hook input. In the "preparing" state, the old values
+are unspecified (all zeroes), and the destination's new value is the
+source value read before locking. In subsequent states, these operations
+report the old values and the source value read under lock. Thus, a
+"preparing" hook may change the source before it is copied or renamed.
+A "prepared" hook still sees the original references and reflogs on disk.
+
 For symbolic reference updates the `<old_value>` and `<new-value>`
 fields could denote references instead of objects. A reference will be
 denoted with a 'ref:' prefix, like `ref:<ref-target>`.
diff --git a/refs.c b/refs.c
index c02da9d966..df682e0e26 100644
--- a/refs.c
+++ b/refs.c
@@ -3181,28 +3181,165 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 	return ret;
 }
 
+static int transaction_copy_ref(struct ref_transaction *transaction,
+				const char *oldref, const char *newref,
+				unsigned int source_flags, const char *logmsg,
+				struct strbuf *err)
+{
+	struct ref_update *source, *destination;
+	struct object_id oid;
+	int type;
+
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		BUG("copy added to a prepared transaction");
+	if (!refs_resolve_ref_unsafe(transaction->ref_store, oldref,
+			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &oid, &type)) {
+		strbuf_addf(err, _("refname %s not found"), oldref);
+		return -1;
+	}
+	if (type & REF_ISSYMREF) {
+		strbuf_addf(err, _("refname %s is a symbolic ref, copying or renaming it is not supported"), oldref);
+		return -1;
+	}
+	if (!strcmp(oldref, newref))
+		return 0;
+	if (!transaction_refname_valid(newref, &oid, REF_NO_DEREF, err))
+		return -1;
+	if (transaction->flags & (REF_TRANSACTION_FLAG_INITIAL | REF_TRANSACTION_ALLOW_FAILURE)) {
+		strbuf_addstr(err, _("copy and rename require an all-or-nothing, non-initial transaction"));
+		return -1;
+	}
+
+	/* This value describes the request to 'preparing'; locks decide the value used. */
+	source = ref_transaction_add_update(transaction, oldref,
+			REF_NO_DEREF | REF_COPY_SOURCE | source_flags,
+			(source_flags & REF_HAVE_NEW) ? null_oid(transaction->ref_store->repo->hash_algo) : NULL,
+			NULL, NULL, NULL, NULL, NULL, logmsg);
+	destination = ref_transaction_add_update(transaction, newref,
+			REF_NO_DEREF | REF_HAVE_NEW,
+			&oid, NULL, NULL, NULL, NULL, NULL, logmsg);
+	destination->copy_from = source;
+	return ref_transaction_replace_reflog(transaction, newref, err);
+}
+
+int ref_transaction_copy(struct ref_transaction *transaction,
+			 const char *oldref, const char *newref,
+			 const char *logmsg, struct strbuf *err)
+{
+	return transaction_copy_ref(transaction, oldref, newref,
+				    REF_LOG_ONLY | REF_SKIP_CREATE_REFLOG, logmsg, err);
+}
+
+int ref_transaction_rename(struct ref_transaction *transaction,
+			   const char *oldref, const char *newref,
+			   const char *logmsg, struct strbuf *err)
+{
+	return transaction_copy_ref(transaction, oldref, newref,
+				    REF_HAVE_NEW, logmsg, err);
+}
+
+int ref_update_record_copy_source(struct ref_update *update,
+				  const struct object_id *oid,
+				  struct strbuf *err)
+{
+	if ((update->type & REF_ISSYMREF) || is_null_oid(oid)) {
+		strbuf_addf(err, _("'%s' is not an existing direct reference"), update->refname);
+		return -1;
+	}
+	oidcpy(&update->old_oid, oid);
+	update->flags |= REF_HAVE_OLD;
+	return 0;
+}
+
+struct copy_reflog_data {
+	struct ref_transaction *transaction;
+	const char *refname;
+	struct strbuf *err;
+};
+
+static int copy_reflog_entry(const char *refname UNUSED,
+			     struct object_id *old_oid, struct object_id *new_oid,
+			     const char *committer, timestamp_t timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+	struct copy_reflog_data *data = cb_data;
+	struct strbuf ident = STRBUF_INIT;
+	int ret;
+
+	strbuf_addf(&ident, "%s %" PRItime " %+05d", committer, timestamp, tz);
+	ret = ref_transaction_update_reflog(data->transaction, data->refname,
+			new_oid, old_oid, ident.buf, message,
+			data->transaction->max_index + 1, data->err);
+	strbuf_release(&ident);
+	return ret;
+}
+
+int ref_transaction_prepare_copy(struct ref_transaction *transaction,
+				 struct ref_update *update,
+				 struct strbuf *err)
+{
+	struct ref_update *source = update->copy_from;
+	struct copy_reflog_data data = { transaction, update->refname, err };
+	struct object *object;
+	int ret;
+
+	oidcpy(&update->new_oid, &source->old_oid);
+	object = parse_object(transaction->ref_store->repo, &update->new_oid);
+	if (!object || (is_branch(update->refname) && object->type != OBJ_COMMIT)) {
+		strbuf_addf(err, _("cannot copy object %s to '%s'"),
+			    oid_to_hex(&update->new_oid), update->refname);
+		return -1;
+	}
+	if (object->type == OBJ_TAG &&
+	    !peel_object(transaction->ref_store->repo, &update->new_oid,
+			 &update->peeled, PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE))
+		update->flags |= REF_HAVE_PEELED;
+
+	if (!refs_reflog_exists(transaction->ref_store, source->refname))
+		return 0;
+	ret = refs_for_each_reflog_ent(transaction->ref_store, source->refname,
+				       copy_reflog_entry, &data);
+	if (ret && !err->len)
+		strbuf_addf(err, _("cannot read reflog for '%s'"), source->refname);
+	return ret;
+}
+
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
-	char *msg;
-	int retval;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = ref_store_transaction_begin(refs, 0, &err);
+	int ret = -1;
 
-	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->rename_ref(refs, oldref, newref, msg);
-	free(msg);
-	return retval;
+	if (!transaction ||
+	    ref_transaction_rename(transaction, oldref, newref, logmsg, &err))
+		goto out;
+	ret = transaction->nr ? ref_transaction_commit(transaction, &err) : 0;
+out:
+	if (ret)
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return ret;
 }
 
 int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
-		    const char *newref, const char *logmsg)
+			   const char *newref, const char *logmsg)
 {
-	char *msg;
-	int retval;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = ref_store_transaction_begin(refs, 0, &err);
+	int ret = -1;
 
-	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->copy_ref(refs, oldref, newref, msg);
-	free(msg);
-	return retval;
+	if (!transaction ||
+	    ref_transaction_copy(transaction, oldref, newref, logmsg, &err))
+		goto out;
+	ret = transaction->nr ? ref_transaction_commit(transaction, &err) : 0;
+out:
+	if (ret)
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return ret;
 }
 
 const char *ref_update_original_update_refname(struct ref_update *update)
diff --git a/refs.h b/refs.h
index b0b2b0e4fd..eba5025351 100644
--- a/refs.h
+++ b/refs.h
@@ -952,6 +952,22 @@ int ref_transaction_replace_reflog(struct ref_transaction *transaction,
 				    const char *refname,
 				    struct strbuf *err);
 
+/*
+ * Queue a copy or rename of a direct reference and its reflog. The source is
+ * read again under lock during prepare; changes made by the preparing hook
+ * are included. An existing destination is overwritten without dereferencing
+ * it. Several independent copies, renames and ordinary updates may be queued
+ * together. Each destination (and each source being renamed) must be unique.
+ * Initial transactions and transactions allowing individual failures are not
+ * supported. On failure, discard the transaction.
+ */
+int ref_transaction_copy(struct ref_transaction *transaction,
+			 const char *oldref, const char *newref,
+			 const char *logmsg, struct strbuf *err);
+int ref_transaction_rename(struct ref_transaction *transaction,
+			   const char *oldref, const char *newref,
+			   const char *logmsg, struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 36ecd21ed7..ffdc112f9a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -74,6 +74,12 @@ extern int ignore_case;
  */
 #define REF_LOG_VIA_SPLIT (1 << 14)
 
+/* A D/F or case-only rename cannot lock a loose destination beside its source. */
+#define REF_NEEDS_PACK (1 << 18)
+
+/* The source reflog was removed to make room for its rename destination. */
+#define REF_RENAMED_LOG (1 << 19)
+
 struct ref_lock {
 	char *ref_name;
 	struct lock_file lk;
@@ -788,6 +794,37 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 	lock->count = 1;
 	files_ref_path(refs, &ref_file, refname);
 
+	if (update->copy_from && (update->copy_from->flags & REF_HAVE_NEW)) {
+		const char *source = update->copy_from->refname;
+		size_t source_len = strlen(source), dest_len = strlen(refname);
+		int source_is_parent = starts_with(refname, source) && refname[source_len] == '/';
+		int dest_is_parent = starts_with(source, refname) && source[dest_len] == '/';
+		int same_path = repo_ignore_case(refs->base.repo) && !strcasecmp(source, refname);
+
+		if (source_is_parent || dest_is_parent || same_path) {
+			struct string_list skip = STRING_LIST_INIT_NODUP;
+
+			string_list_insert(&skip, source);
+			ret = refs_verify_refname_available(&refs->base, refname,
+							   extras, &skip, 0, err);
+			string_list_clear(&skip, 0);
+			if (ret)
+				goto error_return;
+			/* The existing source and its lock protect a child or case-only destination. */
+			if (dest_is_parent && repo_hold_lock_file_for_update_timeout(
+					refs->base.repo, &lock->lk, ref_file.buf, LOCK_NO_DEREF,
+					get_files_ref_lock_timeout_ms(refs->base.repo)) < 0) {
+				unable_to_lock_message(ref_file.buf, errno, err);
+				ret = REF_TRANSACTION_ERROR_GENERIC;
+				goto error_return;
+			}
+			oidclr(&lock->old_oid, refs->base.repo->hash_algo);
+			update->flags |= REF_NEEDS_PACK;
+			ret = 0;
+			goto out;
+		}
+	}
+
 retry:
 	switch (safe_create_leading_directories(refs->base.repo, ref_file.buf)) {
 	case SCLD_OK:
@@ -2538,7 +2575,8 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
 
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
-			update->flags | REF_LOG_ONLY | REF_NO_DEREF | REF_LOG_VIA_SPLIT,
+			(update->flags & ~REF_COPY_SOURCE) |
+			REF_LOG_ONLY | REF_NO_DEREF | REF_LOG_VIA_SPLIT,
 			&update->new_oid, &update->old_oid, &update->peeled,
 			NULL, NULL, update->committer_info, update->msg);
 	new_update->parent_update = update;
@@ -2677,6 +2715,7 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
 
 struct staged_reflog {
 	struct tempfile *file;
+	struct tempfile *source_log;
 	struct ref_update **updates;
 	size_t nr, alloc;
 };
@@ -2789,6 +2828,155 @@ static int install_reflog(const char *path, void *data)
 	return ret;
 }
 
+static int move_reflog(const char *path, void *data)
+{
+	struct tempfile *tempfile = data;
+	int ret = rename(get_tempfile_path(tempfile), path);
+
+	if (ret && errno == ENOTDIR)
+		errno = EISDIR;
+	return ret;
+}
+
+static int stage_source_reflog(struct files_ref_store *refs,
+			       struct ref_update *update,
+			       struct staged_reflog *log,
+			       struct strbuf *err)
+{
+	struct strbuf source = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	int ret = -1;
+
+	files_reflog_path(refs, &source, update->copy_from->refname);
+	if (!refs_reflog_exists(&refs->base, update->copy_from->refname)) {
+		ret = 0;
+		goto out;
+	}
+	files_reflog_path(refs, &path, "refs/.tmp-reflog-source-XXXXXX");
+	log->source_log = mks_tempfile_m(path.buf, 0666);
+	if (!log->source_log || close_tempfile_gently(log->source_log) ||
+	    rename(source.buf, get_tempfile_path(log->source_log))) {
+		strbuf_addf(err, "cannot stage source reflog '%s': %s",
+			    update->copy_from->refname, strerror(errno));
+		goto out;
+	}
+	try_remove_empty_parents(refs, update->copy_from->refname,
+				 REMOVE_EMPTY_PARENTS_REFLOG);
+	update->copy_from->flags |= REF_RENAMED_LOG;
+	ret = 0;
+
+out:
+	if (ret)
+		delete_tempfile(&log->source_log);
+	strbuf_release(&source);
+	strbuf_release(&path);
+	return ret;
+}
+
+static int restore_source_reflog(struct files_ref_store *refs,
+				 struct ref_update *update,
+				 struct staged_reflog *log,
+				 struct strbuf *err)
+{
+	struct strbuf source = STRBUF_INIT;
+	int ret;
+
+	if (!log->source_log)
+		return 0;
+	files_reflog_path(refs, &source, update->copy_from->refname);
+	ret = raceproof_create_file(refs, source.buf, move_reflog,
+				    log->source_log);
+	if (ret) {
+		struct strbuf recovery = STRBUF_INIT;
+
+		strbuf_addf(err, "; cannot restore source reflog '%s': %s",
+			    update->copy_from->refname, strerror(errno));
+		strbuf_addf(&recovery, "%s.recovery",
+			    get_tempfile_path(log->source_log));
+		if (rename_tempfile(&log->source_log, recovery.buf))
+			strbuf_addf(err, "; cannot preserve its backup: %s",
+				    strerror(errno));
+		else
+			strbuf_addf(err, "; backup saved as '%s'", recovery.buf);
+		strbuf_release(&recovery);
+	} else {
+		delete_tempfile(&log->source_log);
+	}
+	strbuf_release(&source);
+	return ret;
+}
+
+static int check_reflog_symlink(struct files_ref_store *refs,
+				const char *refname, struct strbuf *err)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct stat st;
+	int ret = 0;
+
+	files_reflog_path(refs, &path, refname);
+	if (!lstat(path.buf, &st)) {
+		if (S_ISLNK(st.st_mode)) {
+			strbuf_addf(err, "reflog for %s is a symlink", refname);
+			ret = -1;
+		}
+	} else if (errno != ENOENT && errno != ENOTDIR) {
+		strbuf_addf(err, "cannot stat reflog for %s: %s", refname, strerror(errno));
+		ret = -1;
+	}
+	strbuf_release(&path);
+	return ret;
+}
+
+static struct ref_update *find_update_with_flag(struct ref_transaction *transaction,
+						const char *refname,
+						unsigned int flag)
+{
+	size_t i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if ((update->flags & flag) && !strcmp(update->refname, refname))
+			return update;
+	}
+	return NULL;
+}
+
+static int prepare_copy_reflog(struct files_ref_store *refs,
+			       struct ref_transaction *transaction,
+			       struct ref_update *update, struct strbuf *err)
+{
+	enum log_refs_config config = files_ref_store_write_options(refs)->log_all_ref_updates;
+	int source_has_log;
+	int write_log;
+
+	if (check_reflog_symlink(refs, update->copy_from->refname, err) ||
+	    check_reflog_symlink(refs, update->refname, err))
+		return -1;
+	source_has_log = refs_reflog_exists(&refs->base, update->copy_from->refname);
+	/* A copy without source history only appends to an existing destination log. */
+	if (!source_has_log && !(update->copy_from->flags & REF_HAVE_NEW)) {
+		struct ref_update *replacement = find_update_with_flag(
+			transaction, update->refname, REF_REPLACE_REFLOG);
+
+		if (!replacement)
+			BUG("copy destination without a reflog replacement");
+		replacement->flags &= ~REF_REPLACE_REFLOG;
+	}
+	if (config == LOG_REFS_UNSET)
+		config = is_bare_repository(refs->base.repo) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+	write_log = source_has_log || should_autocreate_reflog(config, update->refname) ||
+		(!(update->copy_from->flags & REF_HAVE_NEW) &&
+		 refs_reflog_exists(&refs->base, update->refname));
+	if (ref_transaction_prepare_copy(transaction, update, err))
+		return -1;
+	if (!write_log)
+		return 0;
+	return ref_transaction_update_reflog(transaction, update->refname,
+			&update->new_oid, &update->new_oid, NULL, update->msg,
+			transaction->max_index + 1, err);
+}
+
 /*
  * Prepare for carrying out update:
  * - Lock the reference referred to by update.
@@ -2819,6 +3007,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
 	backend_data = transaction->backend_data;
+	if (update->copy_from && prepare_copy_reflog(refs, transaction, update, err))
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	if ((update->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(update))
 		update->flags |= REF_DELETING;
@@ -2828,6 +3018,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 		if (ret)
 			goto out;
 	}
+	if (update->copy_from)
+		update->flags |= REF_SKIP_CREATE_REFLOG;
 
 	lock = strmap_get(&backend_data->ref_locks, update->refname);
 	if (lock) {
@@ -2849,6 +3041,17 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 	}
 
 	update->backend_data = lock;
+	if (update->copy_from) {
+		oidcpy(&update->old_oid, &lock->old_oid);
+		if (update->type & REF_ISSYMREF)
+			update->old_target = xstrdup(referent.buf);
+		update->flags |= REF_HAVE_OLD;
+	}
+	if ((update->flags & REF_COPY_SOURCE) &&
+	    ref_update_record_copy_source(update, &lock->old_oid, err)) {
+		ret = REF_TRANSACTION_ERROR_GENERIC;
+		goto out;
+	}
 
 	if (update->flags & REF_LOG_VIA_SPLIT) {
 		struct ref_lock *parent_lock;
@@ -2974,7 +3177,7 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 		update->flags |= REF_NEEDS_COMMIT;
 	} else if ((update->flags & REF_HAVE_NEW) &&
 		   !(update->flags & REF_DELETING) &&
-		   !(update->flags & REF_LOG_ONLY)) {
+		   !(update->flags & (REF_LOG_ONLY | REF_NEEDS_PACK))) {
 		if (!(update->type & REF_ISSYMREF) &&
 		    oideq(&lock->old_oid, &update->new_oid)) {
 			/*
@@ -3003,7 +3206,7 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 			}
 		}
 	}
-	if (!(update->flags & REF_NEEDS_COMMIT)) {
+	if (!(update->flags & (REF_NEEDS_COMMIT | REF_NEEDS_PACK))) {
 		/*
 		 * We didn't call write_ref_to_lockfile(), so
 		 * the lockfile is still open. Close it to
@@ -3054,6 +3257,7 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 			struct staged_reflog *log = entry->value;
 
 			delete_tempfile(&log->file);
+			delete_tempfile(&log->source_log);
 			free(log->updates);
 			free(log);
 		}
@@ -3162,7 +3366,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			goto cleanup;
 		}
 
-		if (update->flags & REF_DELETING &&
+		if (update->flags & (REF_DELETING | REF_NEEDS_PACK) &&
 		    !(update->flags & REF_LOG_ONLY) &&
 		    !(update->flags & REF_IS_PRUNING) &&
 		    !is_root_ref(update->refname)) {
@@ -3189,6 +3393,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					REF_HAVE_NEW | REF_NO_DEREF,
 					&update->new_oid, NULL, NULL,
 					NULL, NULL, NULL, NULL);
+			if (update->copy_from || (update->flags & REF_COPY_SOURCE))
+				packed_transaction->flags |= REF_TRANSACTION_FLAG_INTERNAL;
 		}
 	}
 
@@ -3481,11 +3687,18 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		struct ref_update *operation;
 		struct staged_reflog *log;
 
 		if (!(update->flags & REF_REPLACE_REFLOG))
 			continue;
 		log = strmap_get(&backend_data->reflog_files, update->refname);
+		operation = find_update_with_flag(transaction, update->refname,
+						  REF_NEEDS_PACK);
+		if (operation && stage_source_reflog(refs, operation, log, err)) {
+			ret = -1;
+			goto cleanup;
+		}
 		strbuf_reset(&sb);
 		files_reflog_path(refs, &sb, update->refname);
 		if (!log->file) {
@@ -3499,6 +3712,8 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		if (ret) {
 			strbuf_addf(err, "cannot replace reflog '%s': %s",
 				    update->refname, strerror(errno));
+			if (operation)
+				restore_source_reflog(refs, operation, log, err);
 		}
 		if (ret)
 			goto cleanup;
@@ -3563,7 +3778,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
-		    !(update->flags & REF_IS_PRUNING)) {
+		    !(update->flags & (REF_IS_PRUNING | REF_RENAMED_LOG))) {
 			strbuf_reset(&sb);
 			files_reflog_path(refs, &sb, update->refname);
 			if (!unlink_or_warn(sb.buf))
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 19fdf39d1d..2746ce5b49 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -52,6 +52,9 @@ struct ref_transaction;
 /* Replace a reflog with the explicit log-only updates in the transaction. */
 #define REF_REPLACE_REFLOG (1 << 16)
 
+/* A source whose value and reflog are consumed by a later update. */
+#define REF_COPY_SOURCE (1 << 17)
+
 /*
  * Return the length of time to retry acquiring a loose reference lock
  * before giving up, in milliseconds:
@@ -161,6 +164,9 @@ struct ref_update {
 	 */
 	struct ref_update *parent_update;
 
+	/* The source is queued first, so backends lock it before the destination. */
+	struct ref_update *copy_from;
+
 	const char refname[FLEX_ARRAY];
 };
 
@@ -193,6 +199,13 @@ struct ref_update *ref_transaction_add_update(
 		const char *committer_info,
 		const char *msg);
 
+int ref_update_record_copy_source(struct ref_update *update,
+				  const struct object_id *oid,
+				  struct strbuf *err);
+int ref_transaction_prepare_copy(struct ref_transaction *transaction,
+				 struct ref_update *update,
+				 struct strbuf *err);
+
 /*
  * Transaction states.
  *
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 203b111f3d..72c1596c11 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1076,6 +1076,22 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 	struct object_id current_oid = {0};
 	const char *rewritten_ref;
 
+	if (u->copy_from) {
+		const struct object_id *zero = null_oid(refs->base.repo->hash_algo);
+
+		if (ref_transaction_prepare_copy(transaction, u, err))
+			return REF_TRANSACTION_ERROR_GENERIC;
+		if ((u->copy_from->flags & REF_HAVE_NEW) &&
+		    ref_transaction_update_reflog(transaction, u->refname,
+				zero, &u->new_oid, NULL, u->msg,
+				transaction->max_index + 1, err))
+			return REF_TRANSACTION_ERROR_GENERIC;
+		if (ref_transaction_update_reflog(transaction, u->refname,
+				&u->new_oid, zero, NULL, u->msg,
+				transaction->max_index + 1, err))
+			return REF_TRANSACTION_ERROR_GENERIC;
+	}
+
 	/*
 	 * There is no need to reload the respective backends here as
 	 * we have already reloaded them when preparing the transaction
@@ -1126,15 +1142,27 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 
 		ref_transaction_add_update(
 			transaction, "HEAD",
-			u->flags | REF_LOG_ONLY | REF_NO_DEREF,
+			(u->flags & ~REF_COPY_SOURCE) |
+			REF_LOG_ONLY | REF_NO_DEREF,
 			&u->new_oid, &u->old_oid, &u->peeled, NULL, NULL,
 			NULL, u->msg);
 	}
+	if (u->copy_from)
+		u->flags |= REF_SKIP_CREATE_REFLOG;
 
 	ret = reftable_backend_read_ref(be, rewritten_ref,
 					&current_oid, referent, &u->type);
 	if (ret < 0)
 		return REF_TRANSACTION_ERROR_GENERIC;
+	if (u->copy_from) {
+		oidcpy(&u->old_oid, &current_oid);
+		if (u->type & REF_ISSYMREF)
+			u->old_target = xstrdup(referent->buf);
+		u->flags |= REF_HAVE_OLD;
+	}
+	if ((u->flags & REF_COPY_SOURCE) &&
+	    ref_update_record_copy_source(u, &current_oid, err))
+		return REF_TRANSACTION_ERROR_GENERIC;
 	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
 		struct string_list_item *item;
 		/*
@@ -1319,6 +1347,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
 	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
+	struct string_list renamed_sources = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
 	struct reftable_backend *be;
 	struct object_id head_oid;
@@ -1338,6 +1367,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	 * that will be modified during the transaction.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		if (update->copy_from && (update->copy_from->flags & REF_HAVE_NEW))
+			string_list_insert(&renamed_sources, update->copy_from->refname);
 		ret = prepare_transaction_update(NULL, refs, tx_data,
 						 transaction->updates[i], err);
 		if (ret)
@@ -1390,7 +1422,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	}
 
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
-					     &transaction->refnames, NULL,
+					     &transaction->refnames, &renamed_sources,
 					     transaction,
 					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
 					     err);
@@ -1411,6 +1443,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
 	string_list_clear(&refnames_to_check, 1);
+	string_list_clear(&renamed_sources, 0);
 
 	return ret;
 }
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7ce10c28af..ec7728334c 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -185,6 +185,41 @@ static int cmd_reflog_transaction(struct ref_store *refs, const char **argv)
 	return ret;
 }
 
+static int cmd_copy_transaction(struct ref_store *refs, const char **argv)
+{
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = ref_store_transaction_begin(refs, 0, &err);
+	int ret = !transaction;
+
+	while (!ret && *argv) {
+		const char *operation = *argv++;
+		const char *source = notnull(*argv++, "source");
+		const char *destination = notnull(*argv++, "destination");
+
+		if (!strcmp(operation, "rename"))
+			ret = ref_transaction_rename(transaction, source, destination, "rename", &err);
+		else if (!strcmp(operation, "copy"))
+			ret = ref_transaction_copy(transaction, source, destination, "copy", &err);
+		else if (!strcmp(operation, "update")) {
+			struct object_id oid;
+
+			if (get_oid_hex(destination, &oid))
+				die("invalid object ID: %s", destination);
+			ret = ref_transaction_update(transaction, source, &oid,
+						     NULL, NULL, NULL, 0, "update", &err);
+		} else {
+			die("unknown operation: %s", operation);
+		}
+	}
+	if (!ret)
+		ret = ref_transaction_commit(transaction, &err);
+	if (ret)
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return ret;
+}
+
 static int each_ref(const struct reference *ref, void *cb_data UNUSED)
 {
 	printf("%s %s 0x%x\n", oid_to_hex(ref->oid), ref->name, ref->flags);
@@ -348,6 +383,7 @@ static struct command commands[] = {
 	{ "delete-refs", cmd_delete_refs },
 	{ "rename-ref", cmd_rename_ref },
 	{ "reflog-transaction", cmd_reflog_transaction },
+	{ "copy-transaction", cmd_copy_transaction },
 	{ "for-each-ref", cmd_for_each_ref },
 	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
 	{ "resolve-ref", cmd_resolve_ref },
diff --git a/t/meson.build b/t/meson.build
index fb5266cd0d..36d47c92c4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -218,6 +218,7 @@ integration_tests = [
   't1421-reflog-write.sh',
   't1422-show-ref-exists.sh',
   't1423-ref-backend.sh',
+  't1424-ref-copy-transaction.sh',
   't1425-reflog-transaction.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
diff --git a/t/perf/p1424-ref-copy-rename.sh b/t/perf/p1424-ref-copy-rename.sh
new file mode 100755
index 0000000000..a901129b00
--- /dev/null
+++ b/t/perf/p1424-ref-copy-rename.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='Copy and rename references with short and long reflogs'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+for entries in 10 10000
+do
+	export entries
+	test_expect_success "setup $entries reflog entries" '
+		git init --ref-format=files "repo-$entries" &&
+		(
+			cd "repo-$entries" &&
+			test_commit A &&
+			git branch source &&
+			oid=$(git rev-parse HEAD) &&
+			awk -v oid="$oid" -v count="$entries" '\''
+				BEGIN {
+					for (i = 0; i < count; i++)
+						printf "%s %s A <a@example.com> %d +0000\tentry %d\n", oid, oid, 1700000000 + i, i
+				}
+			'\'' >.git/logs/refs/heads/source &&
+			if test "$GIT_TEST_DEFAULT_REF_FORMAT" = reftable
+			then
+				git refs migrate --ref-format=reftable
+			fi
+		)
+	'
+
+	test_perf "copy $entries reflog entries (10 operations)" '
+		for i in $(test_seq 10)
+		do
+			git -C "repo-$entries" branch -C source destination || return 1
+		done
+	'
+
+	test_perf "rename $entries reflog entries (10 operations)" '
+		for i in $(test_seq 5)
+		do
+			git -C "repo-$entries" branch -m source renamed &&
+			git -C "repo-$entries" branch -m renamed source || return 1
+		done
+	'
+done
+
+test_done
diff --git a/t/t1424-ref-copy-transaction.sh b/t/t1424-ref-copy-transaction.sh
new file mode 100755
index 0000000000..4c7592795f
--- /dev/null
+++ b/t/t1424-ref-copy-transaction.sh
@@ -0,0 +1,352 @@
+#!/bin/sh
+
+test_description='reference transactions for copy and rename'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+snapshot () {
+	git for-each-ref --format="%(refname) %(objectname) %(symref)" >"$1.refs" &&
+	for ref in HEAD refs/heads/source refs/heads/destination
+	do
+		if git reflog exists "$ref"
+		then
+			test-tool ref-store main for-each-reflog-ent "$ref"
+		else
+			echo missing
+		fi >"$1.$(basename "$ref").log" || return 1
+	done
+}
+
+compare_snapshot () {
+	for suffix in refs HEAD.log source.log destination.log
+	do
+		test_cmp "$1.$suffix" "$2.$suffix" || return 1
+	done
+}
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	A=$(git rev-parse A) &&
+	B=$(git rev-parse B)
+'
+
+for operation in rename copy
+do
+	test_expect_success "$operation reports one logical transaction" '
+		test_when_finished "git config --unset core.hooksPath" &&
+		git branch -f source "$A" &&
+		git branch -f destination "$B" &&
+		mkdir -p hooks &&
+		write_script hooks/reference-transaction <<-\EOF &&
+			echo "$1" >>actual &&
+			cat >>actual
+		EOF
+		git config core.hooksPath hooks &&
+		>actual &&
+		test-tool ref-store main copy-transaction "$operation" refs/heads/source refs/heads/destination &&
+		{
+			echo preparing &&
+			if test "$operation" = rename
+			then
+				echo "$ZERO_OID $ZERO_OID refs/heads/source"
+			fi &&
+			echo "$ZERO_OID $A refs/heads/destination" &&
+			for state in prepared committed
+			do
+				echo "$state" &&
+				if test "$operation" = rename
+				then
+					echo "$A $ZERO_OID refs/heads/source"
+				fi &&
+				echo "$B $A refs/heads/destination" || return 1
+			done
+		} >expect &&
+		test_cmp expect actual
+	'
+
+	for state in preparing prepared
+	do
+		test_expect_success "$operation rejected at $state leaves refs and full reflogs unchanged" '
+			test_when_finished "git config --unset core.hooksPath" &&
+			git branch -f source "$A" &&
+			git branch -f destination "$B" &&
+			git symbolic-ref HEAD refs/heads/source &&
+			test_when_finished "git -c core.hooksPath=/dev/null symbolic-ref HEAD refs/heads/main" &&
+			snapshot before &&
+			write_script hooks/reference-transaction <<-EOF &&
+				test "\$1" != "$state"
+			EOF
+			git config core.hooksPath hooks &&
+			test_must_fail test-tool ref-store main copy-transaction "$operation" refs/heads/source refs/heads/destination &&
+			snapshot after &&
+			compare_snapshot before after
+		'
+	done
+done
+
+test_expect_success 'prepared hook sees old refs and cannot modify the source' '
+	test_when_finished "git config --unset core.hooksPath" &&
+	git branch -f source "$A" &&
+	git branch -f destination "$B" &&
+	write_script hooks/reference-transaction <<-EOF &&
+		test "\$1" = prepared || exit 0
+		git rev-parse refs/heads/source >source-seen &&
+		git rev-parse refs/heads/destination >destination-seen &&
+		if git -c core.hooksPath=/dev/null -c core.filesRefLockTimeout=0 \
+			update-ref refs/heads/source $B
+		then
+			exit 1
+		fi
+	EOF
+	git config core.hooksPath hooks &&
+	git branch -M source destination &&
+	echo "$A" >expect &&
+	test_cmp expect source-seen &&
+	echo "$B" >expect &&
+	test_cmp expect destination-seen &&
+	test_cmp_rev "$A" destination
+'
+
+test_expect_success 'preparing may update source and its reflog' '
+	test_when_finished "git config --unset core.hooksPath" &&
+	git branch source "$A" &&
+	write_script hooks/reference-transaction <<-EOF &&
+		test "\$1" = preparing || exit 0
+		git -c core.hooksPath=/dev/null update-ref -m concurrent refs/heads/source $B
+	EOF
+	git config core.hooksPath hooks &&
+	git branch -M source destination &&
+	test_cmp_rev "$B" destination &&
+	git reflog show --format=%gs destination >actual &&
+	test_grep concurrent actual
+'
+
+test_expect_success 'rename without a source reflog can be rejected without losing destination history' '
+	test_when_finished "git config --unset core.hooksPath" &&
+	git -c core.logAllRefUpdates=false branch source "$A" &&
+	test_must_fail git reflog exists refs/heads/source &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/destination >before &&
+	write_script hooks/reference-transaction <<-\EOF &&
+		test "$1" != prepared
+	EOF
+	git config core.hooksPath hooks &&
+	test_must_fail git branch -M source destination &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/destination >after &&
+	test_cmp before after
+'
+
+for names in "parent parent/child" "child/branch child"
+do
+	set -- $names
+	from=$1 to=$2
+	test_expect_success "D/F rename $from to $to can be aborted and committed" '
+		test_when_finished "git config --unset core.hooksPath" &&
+		git branch "$from" "$A" &&
+		test-tool ref-store main for-each-reflog-ent "refs/heads/$from" >before &&
+		write_script hooks/reference-transaction <<-EOF &&
+			test "\$1" = prepared || exit 0
+			git rev-parse refs/heads/$from >seen
+			exit 1
+		EOF
+		git config core.hooksPath hooks &&
+		test_must_fail git branch -m "$from" "$to" &&
+		echo "$A" >expect &&
+		test_cmp expect seen &&
+		test_cmp_rev "$A" "$from" &&
+		test-tool ref-store main for-each-reflog-ent "refs/heads/$from" >after &&
+		test_cmp before after &&
+		git -c core.hooksPath=/dev/null branch -m "$from" "$to" &&
+		test_cmp_rev "$A" "$to"
+	'
+done
+
+test_expect_success REFFILES,POSIXPERM 'D/F reflog installation failure restores source history' '
+	test_when_finished "chmod u+w .git/logs/refs/heads" &&
+	test_when_finished "git config --unset core.hooksPath" &&
+	git branch rollback/branch "$A" &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/rollback/branch >before &&
+	write_script hooks/reference-transaction <<-\EOF &&
+		test "$1" = prepared || exit 0
+		chmod a-w .git/logs/refs/heads
+	EOF
+	git config core.hooksPath hooks &&
+	test_must_fail git branch -m rollback/branch rollback &&
+	chmod u+w .git/logs/refs/heads &&
+	test_cmp_rev "$A" rollback/branch &&
+	test_must_fail git show-ref --verify refs/heads/rollback &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/rollback/branch >after &&
+	test_cmp before after
+'
+
+test_expect_success 'multiple renames, a copy and an ordinary update compose' '
+	git branch first "$A" &&
+	git branch second "$B" &&
+	git branch third "$A" &&
+	test-tool ref-store main copy-transaction \
+		rename refs/heads/first refs/heads/first-new \
+		rename refs/heads/second refs/heads/second-new \
+		copy refs/heads/third refs/heads/third-new \
+		update refs/heads/fourth "$B" &&
+	test_must_fail git show-ref --verify refs/heads/first &&
+	test_must_fail git show-ref --verify refs/heads/second &&
+	test_cmp_rev "$A" first-new &&
+	test_cmp_rev "$B" second-new &&
+	test_cmp_rev "$A" third-new &&
+	test_cmp_rev "$A" third &&
+	test_cmp_rev "$B" fourth
+'
+
+test_expect_success 'copy preserves complete source history and replaces destination history' '
+	git branch history-source "$A" &&
+	git update-ref -m history-step refs/heads/history-source "$B" &&
+	git branch history-destination "$B" &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/history-source >before &&
+	git branch -C history-source history-destination &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/history-source >after &&
+	test_cmp before after &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/history-destination >copied &&
+	sed "$ d" copied >history &&
+	test_cmp before history &&
+	test_grep "Branch: copied refs/heads/history-source to refs/heads/history-destination" copied
+'
+
+test_expect_success 'packed rename reports no internal transactions' '
+	test_when_finished "git config --unset core.hooksPath" &&
+	git branch packed-source "$A" &&
+	git pack-refs --all &&
+	write_script hooks/reference-transaction <<-\EOF &&
+		echo "$1" >>states
+		cat >/dev/null
+	EOF
+	git config core.hooksPath hooks &&
+	git branch -m packed-source packed-destination &&
+	printf "%s\n" preparing prepared committed >expect &&
+	test_cmp expect states
+'
+
+test_expect_success REFFILES 'unrelated forced copies use independent reflog staging files' '
+	test_when_finished "git config --unset core.hooksPath" &&
+	git branch nested-a "$A" &&
+	git branch nested-b "$B" &&
+	git branch outer-a "$A" &&
+	git branch outer-b "$B" &&
+	write_script hooks/reference-transaction <<-\EOF &&
+		test "$1" = prepared || exit 0
+		git -c core.hooksPath=/dev/null branch -C nested-a nested-b
+	EOF
+	git config core.hooksPath hooks &&
+	git branch -C outer-a outer-b &&
+	test_cmp_rev "$A" outer-b &&
+	test_cmp_rev "$A" nested-b
+'
+
+test_expect_success REFFILES 'rename with reflogs disabled does not create a reflog' '
+	git -c core.logAllRefUpdates=false branch no-log "$A" &&
+	git -c core.logAllRefUpdates=false branch -m no-log still-no-log &&
+	test_must_fail git reflog exists refs/heads/still-no-log
+'
+
+test_expect_success REFFILES 'copy without source history retains existing destination history' '
+	git -c core.logAllRefUpdates=false branch no-copy-log "$A" &&
+	git branch existing-copy-log "$B" &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/existing-copy-log >before &&
+	git branch -C no-copy-log existing-copy-log &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/existing-copy-log >after &&
+	sed "$ d" after >history &&
+	test_cmp before history
+'
+
+test_expect_success REFFILES,CASE_INSENSITIVE_FS 'case-only rename retains history and supports abort' '
+	test_when_finished "git config --unset core.hooksPath" &&
+	git branch case-source "$A" &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/case-source >before &&
+	write_script hooks/reference-transaction <<-\EOF &&
+		test "$1" != prepared
+	EOF
+	git config core.hooksPath hooks &&
+	test_must_fail git branch -M case-source CASE-SOURCE &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/case-source >after &&
+	test_cmp before after &&
+	git -c core.hooksPath=/dev/null branch -M case-source CASE-SOURCE &&
+	git for-each-ref --format="%(refname)" refs/heads/CASE-SOURCE >actual &&
+	echo refs/heads/CASE-SOURCE >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success REFFILES,SYMLINKS 'symlink source reflog is rejected without changing refs' '
+	git branch symlink-source "$A" &&
+	mv .git/logs/refs/heads/symlink-source saved-log &&
+	ln -s "$PWD/saved-log" .git/logs/refs/heads/symlink-source &&
+	test_must_fail git branch -m symlink-source symlink-destination &&
+	test_cmp_rev "$A" symlink-source &&
+	test_must_fail git show-ref --verify refs/heads/symlink-destination
+'
+
+for operation in copy rename
+do
+	test_expect_success "$operation over HEAD referent preserves HEAD history" '
+		git branch -f head-source "$A" &&
+		git update-ref refs/heads/main "$B" &&
+		test-tool ref-store main for-each-reflog-ent HEAD >before &&
+		test-tool ref-store main copy-transaction "$operation" refs/heads/head-source refs/heads/main &&
+		test-tool ref-store main for-each-reflog-ent HEAD >after &&
+		sed "$ d" after >history &&
+		test_cmp before history &&
+		test_cmp_rev "$A" HEAD
+	'
+done
+
+test_expect_success 'preparing may delete source but cannot cause a partial rename' '
+	test_when_finished "git config --unset core.hooksPath" &&
+	git branch race-source "$A" &&
+	write_script hooks/reference-transaction <<-\EOF &&
+		test "$1" = preparing || exit 0
+		git -c core.hooksPath=/dev/null update-ref -d refs/heads/race-source
+	EOF
+	git config core.hooksPath hooks &&
+	test_must_fail git branch -m race-source race-destination &&
+	test_must_fail git show-ref --verify refs/heads/race-source &&
+	test_must_fail git show-ref --verify refs/heads/race-destination
+'
+
+test_expect_success 'copy cannot replace a D/F-conflicting source' '
+	git branch conflict-source "$A" &&
+	test_must_fail git branch -c conflict-source conflict-source/child &&
+	test_cmp_rev "$A" conflict-source &&
+	test_must_fail git show-ref --verify refs/heads/conflict-source/child
+'
+
+test_expect_success REFFILES,POSIXPERM 'unreadable source reflog leaves refs and history unchanged' '
+	git branch unreadable "$A" &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/unreadable >before &&
+	test_when_finished "chmod u+r .git/logs/refs/heads/unreadable" &&
+	chmod a-r .git/logs/refs/heads/unreadable &&
+	test_must_fail git branch -m unreadable readable &&
+	chmod u+r .git/logs/refs/heads/unreadable &&
+	test_cmp_rev "$A" unreadable &&
+	test_must_fail git show-ref --verify refs/heads/readable &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/unreadable >after &&
+	test_cmp before after
+'
+
+test_expect_success REFFILES 'destination lock failure preserves source and destination history' '
+	git branch -f source "$A" &&
+	git branch -f destination "$B" &&
+	snapshot before &&
+	test_when_finished "rm -f .git/refs/heads/destination.lock" &&
+	>.git/refs/heads/destination.lock &&
+	test_must_fail git -c core.filesRefLockTimeout=0 branch -M source destination &&
+	snapshot after &&
+	compare_snapshot before after
+'
+
+test_expect_success REFFILES 'staged reflog files are cleaned up after success and abort' '
+	find .git/logs -name ".tmp-reflog-*" >actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
2.39.3 (Apple Git-146)

