Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4D51C5B
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915964; cv=none; b=CwfQfIyrQf5Ohb/VeySkR0+fTR6T0tEKc9SiXOKILMVZGH1wE+WhLLbphd8hJ9uycBETUrQxRJKemjrN053zjCb1LB4TVeWPugiJtpdRC/joTfZiglFjIvXg5VKPqJAKmYbZ5R4FTFv+YuX3OKTG06zd82ZgFkr3/PUzClahG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915964; c=relaxed/simple;
	bh=nVOenPa5TCAkuH7FxNo8RRZmkbJrCR/a8jxhUN9r7vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfWO+ti03/8LVj7cBBeV14l5zkhGVWb/zuA+YcgA34/g9uv+5L6g0ujft2DvEQQenBTqLbkVIQC5OWZb2sXJV5D/8TUGfvSvTn3JkrVP9jwOdMhtGXEpbb3OAAY8FjS3zPVXoe3uWUTKZYwIbcJ03sSgyhry9tzIn7xNftDG1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj6mDIzZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj6mDIzZ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56fffd131a8so185714a12.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915960; x=1713520760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLcSe/pY9rc3rV4Zaa7toMLyiHw0HeVXUL8egWJtxOs=;
        b=jj6mDIzZUm0L1ueXM+xRyeqC2vJeScxlsannSKtfSAtClqhrp7I+rrSpbeIgRDqfxh
         j118uGnfzrth3eHI1r3Qa613baQQ4xTMFWUYV6g211qSACZrCE30bO2PjKTfmWDxZ6pq
         2dleWRd8DXNYpIhkwShNmDiog4fhEfeD8BSRWuij+tWrvwktQCqfnz4tWXn+T+nxuyQ2
         WVwoha5Wqvh+gtb74uzS3LDerg66v8TSzQ+cnIEKNuEVIYCW2k1Y0FD1VWN/TK5vlhpw
         SsPaiqY2Wqxh1r8MTRqdmJ64EywLlZXSHMqVhUF/bOKRZshS3PRPQNsqWtFSrt1iSD7f
         pL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915960; x=1713520760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLcSe/pY9rc3rV4Zaa7toMLyiHw0HeVXUL8egWJtxOs=;
        b=VoR4LDNHqUxzkPk/HiVMq/FX5IaRyyDpMPTNw3IESttAsHSSWy3lDooHbTAqqSCWds
         ipLqNmjPYKrRf5Z8YumIJ3Tu6ZhEJOwzGJlFUiQ+T5ysB1gcHdyER1WvNLDcWama+vma
         xkSSFp6aM3p5d9q+80jK8SdIuQVR6BpBihHR7nBui/R5VpzEOCRvsr1AMmYsGPs15Yue
         qOw3oFQxQGaYd1sGmZ67ddGtlsW83WvkUVjlf24FR+AhOfaQEgmfsqPG47Z2r5yDRbYw
         ZjJLwzSGyp2Dfz5SLbdLSU7DZp8Nxsggi0Ch8XEsEDjAf17kqjDA1xlndV4pe4I798cl
         ac9w==
X-Forwarded-Encrypted: i=1; AJvYcCWXQSQXQ3ciKrsoS+FGBwaAgyRQILgiYgHymdZ9Sc9HpLWWVx9kaKVx66cw4espyJ8fcmzB/4zHimgfa3bGuUe9g6m/
X-Gm-Message-State: AOJu0YwxYZdhg4sL+nnfI6TpmTO94oBvr18cS/o/74JTz1l1AnxBlvm2
	Gwp4Bh6OkHeChPLSrhHXN4Klw1ysCPRya6noCLh+oIKh3OmoeWgZ
X-Google-Smtp-Source: AGHT+IFMIEKFZP92nD7rCD/Rvhyg3mXTQmwmUC/O1lkZ7L/oyj9W1US+hHPjRrgxC1pBLtt/ZgfuFg==
X-Received: by 2002:a50:8d4f:0:b0:56e:c5a:c7a9 with SMTP id t15-20020a508d4f000000b0056e0c5ac7a9mr1600998edt.41.1712915960137;
        Fri, 12 Apr 2024 02:59:20 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 1/7] refs: accept symref values in `ref_transaction[_add]_update`
Date: Fri, 12 Apr 2024 11:59:02 +0200
Message-ID: <20240412095908.1134387-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `ref_transaction[_add]_update` functions obtain ref information and
flags to create a `ref_update` and add it to the transaction at hand.

To extend symref support in transactions, we need to also accept the
old and new ref values and process it. In this commit, let's add the
required paramaters to the function and modify all call sites.

The two paramaters added are `new_ref` and `old_ref`. The `new_ref` is
used to denote what the reference should point to when the transaction
is applied. Some functions allow this parameter to be NULL, meaning that
the reference is not changed, or `""`, meaning that the reference should
be deleted.

The `old_ref` denotes the value of that the reference must have before
the update. Some functions allow this parameter to be NULL, meaning that
the old value of the reference is not checked, or `""`, meaning that the
reference must not exist before the update. A copy of this value is made
in the transaction.

The handling logic of these parameters will be added in consequent
commits as we implement symref-{create, update, delete, verify}.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 branch.c                |  2 +-
 builtin/fast-import.c   |  5 +++--
 builtin/fetch.c         |  2 +-
 builtin/receive-pack.c  |  1 +
 builtin/replace.c       |  2 +-
 builtin/tag.c           |  1 +
 builtin/update-ref.c    |  1 +
 refs.c                  | 15 ++++++++++-----
 refs.h                  |  9 ++++++++-
 refs/files-backend.c    | 12 ++++++------
 refs/refs-internal.h    | 14 ++++++++++++++
 refs/reftable-backend.c |  4 ++--
 sequencer.c             |  9 +++++----
 walker.c                |  2 +-
 14 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/branch.c b/branch.c
index 621019fcf4..3ebcfdca65 100644
--- a/branch.c
+++ b/branch.c
@@ -627,7 +627,7 @@ void create_branch(struct repository *r,
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
-					0, msg, &err) ||
+					NULL, NULL, 0, msg, &err) ||
 		ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 782bda007c..6a0b39de32 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1634,7 +1634,7 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, &b->oid, &old_oid,
-				   0, msg, &err) ||
+				   NULL, NULL, 0, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -1675,7 +1675,8 @@ static void dump_tags(void)
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name.buf,
-					   &t->oid, NULL, 0, msg, &err)) {
+					   &t->oid, NULL, NULL, NULL,
+					   0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5857d860db..66840b7c5b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -668,7 +668,7 @@ static int s_update_ref(const char *action,
 
 	ret = ref_transaction_update(transaction, ref->name, &ref->new_oid,
 				     check_old ? &ref->old_oid : NULL,
-				     0, msg, &err);
+				     NULL, NULL, 0, msg, &err);
 	if (ret) {
 		ret = STORE_REF_ERROR_OTHER;
 		goto out;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56d8a77ed7..ebea1747cb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1595,6 +1595,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_update(transaction,
 					   namespaced_name,
 					   new_oid, old_oid,
+					   NULL, NULL,
 					   0, "push",
 					   &err)) {
 			rp_error("%s", err.buf);
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..7690687b0e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -201,7 +201,7 @@ static int replace_object_oid(const char *object_ref,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, repl, &prev,
-				   0, NULL, &err) ||
+				   NULL, NULL, 0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		res = error("%s", err.buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 9a33cb50b4..40a65fdebc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -660,6 +660,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, &object, &prev,
+				   NULL, NULL,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
 				   reflog_msg.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e46afbc46d..21fdbf6ac8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -204,6 +204,7 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 
 	if (ref_transaction_update(transaction, refname,
 				   &new_oid, have_old ? &old_oid : NULL,
+				   NULL, NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
diff --git a/refs.c b/refs.c
index 55d2e0b2cb..967c81167e 100644
--- a/refs.c
+++ b/refs.c
@@ -1228,6 +1228,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const char *new_ref, const char *old_ref,
 		const char *msg)
 {
 	struct ref_update *update;
@@ -1253,6 +1254,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
+			   const char *new_ref, const char *old_ref,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
@@ -1280,7 +1282,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
-				   new_oid, old_oid, msg);
+				   new_oid, old_oid, new_ref, old_ref, msg);
 	return 0;
 }
 
@@ -1295,7 +1297,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), flags, msg, err);
+				      null_oid(), NULL, NULL, flags,
+				      msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
@@ -1308,7 +1311,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		BUG("delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      flags, msg, err);
+				      NULL, NULL, flags,
+				      msg, err);
 }
 
 int ref_transaction_verify(struct ref_transaction *transaction,
@@ -1321,6 +1325,7 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 		BUG("verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
+				      NULL, NULL,
 				      flags, NULL, err);
 }
 
@@ -1335,8 +1340,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 
 	t = ref_store_transaction_begin(refs, &err);
 	if (!t ||
-	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
-				   &err) ||
+	    ref_transaction_update(t, refname, new_oid, old_oid, NULL, NULL,
+				   flags, msg, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		ret = 1;
 		ref_transaction_free(t);
diff --git a/refs.h b/refs.h
index d278775e08..645fe9fdb8 100644
--- a/refs.h
+++ b/refs.h
@@ -696,13 +696,19 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
 
+/*
+ * The reference update is considered to be done on a symbolic reference. This
+ * ensures that we verify, delete, create and update the ref correspondingly.
+ */
+#define REF_SYMREF_UPDATE (1 << 12)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                                  \
 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
-	 REF_SKIP_REFNAME_VERIFICATION)
+	 REF_SKIP_REFNAME_VERIFICATION | REF_SYMREF_UPDATE )
 
 /*
  * Add a reference update to transaction. `new_oid` is the value that
@@ -722,6 +728,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
+			   const char *new_ref, const char *old_ref,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea0..e4d0aa3d41 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1198,7 +1198,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(), &r->oid, NULL);
+			null_oid(), &r->oid, NULL, NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
@@ -1292,7 +1292,7 @@ static int files_pack_refs(struct ref_store *ref_store,
 		 * packed-refs transaction:
 		 */
 		if (ref_transaction_update(transaction, iter->refname,
-					   iter->oid, NULL,
+					   iter->oid, NULL, NULL, NULL,
 					   REF_NO_DEREF, NULL, &err))
 			die("failure preparing to create packed reference %s: %s",
 			    iter->refname, err.buf);
@@ -2309,7 +2309,7 @@ static int split_head_update(struct ref_update *update,
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			NULL, NULL, update->msg);
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2372,7 +2372,7 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			NULL, NULL, update->msg);
 
 	new_update->parent_update = update;
 
@@ -2763,7 +2763,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					packed_transaction, update->refname,
 					REF_HAVE_NEW | REF_NO_DEREF,
 					&update->new_oid, NULL,
-					NULL);
+					NULL, NULL, NULL);
 		}
 	}
 
@@ -3048,7 +3048,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		ref_transaction_add_update(packed_transaction, update->refname,
 					   update->flags & ~REF_HAVE_OLD,
 					   &update->new_oid, &update->old_oid,
-					   NULL);
+					   NULL, NULL, NULL);
 	}
 
 	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 56641aa57a..4c5fe02687 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -124,6 +124,19 @@ struct ref_update {
 	 */
 	struct object_id old_oid;
 
+	/*
+	 * If (flags & REF_SYMREF_UPDATE), set the reference to this
+	 * value (or delete it, if `new_ref` is an empty string).
+	 */
+	const char *new_ref;
+
+	/*
+	 * If (type & REF_SYMREF_UPDATE), check that the reference
+	 * previously had this value (or didn't previously exist,
+	 * if `old_ref` is an empty string).
+	 */
+	const char *old_ref;
+
 	/*
 	 * One or more of REF_NO_DEREF, REF_FORCE_CREATE_REFLOG,
 	 * REF_HAVE_NEW, REF_HAVE_OLD, or backend-specific flags.
@@ -173,6 +186,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const char *new_ref, const char *old_ref,
 		const char *msg);
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1cda48c504..6104471199 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -829,7 +829,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			new_update = ref_transaction_add_update(
 					transaction, "HEAD",
 					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, u->msg);
+					&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
@@ -908,7 +908,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, u->msg);
+						&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
 				new_update->parent_update = u;
 
 				/*
diff --git a/sequencer.c b/sequencer.c
index 2c19846385..af1b25692b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -616,7 +616,7 @@ static int fast_forward_to(struct repository *r,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn && !is_rebase_i(opts) ?
-				   null_oid() : from,
+				   null_oid() : from, NULL, NULL,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1248,7 +1248,7 @@ int update_head_with_reflog(const struct commit *old_head,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", new_head,
 				   old_head ? &old_head->object.oid : null_oid(),
-				   0, sb.buf, err) ||
+				   NULL, NULL, 0, sb.buf, err) ||
 	    ref_transaction_commit(transaction, err)) {
 		ret = -1;
 	}
@@ -3764,8 +3764,9 @@ static int do_label(struct repository *r, const char *name, int len)
 	} else if (repo_get_oid(r, "HEAD", &head_oid)) {
 		error(_("could not read HEAD"));
 		ret = -1;
-	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
-					  NULL, 0, msg.buf, &err) < 0 ||
+	} else if (ref_transaction_update(transaction, ref_name.buf,
+					  &head_oid, NULL, NULL, NULL,
+					  0, msg.buf, &err) < 0 ||
 		   ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ret = -1;
diff --git a/walker.c b/walker.c
index c0fd632d92..1b3df43906 100644
--- a/walker.c
+++ b/walker.c
@@ -324,7 +324,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, refname.buf,
-					   oids + i, NULL, 0,
+					   oids + i, NULL, NULL, NULL, 0,
 					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
-- 
2.43.GIT

