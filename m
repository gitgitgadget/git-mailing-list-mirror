Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AEF3B05AF
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197490; cv=none; b=oiNkop4JP9/tJJzrlaN2I/IXp8C8Adhn/0SUeF/LAfCRaSxcPSGvpj+iF2mj0EBoOlYMzoWqkyAJcKQXdgX+wwe9kZsAwFSmyKmjhlGmjNFLisLJmTDsWPK8lBO5Wf27aeatx2YYA5tzsu9Jw48KBKF0h86nnESuRf86l0UZuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197490; c=relaxed/simple;
	bh=GJcgCF06rav/VrFkh9cK0yvwyeST4QXPf+VFwsTR2cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsBk6J37Z+S6ObtYt/2ktvjvUzXlTaTRSabKZ5bwrTTvl3kj08pdd8rWeGZHwi+iYieC0XHp4fYjaqxOjOq5lYDRs0GfL7oV825FUs9LN6DbpSOIqzHDQfWrpPnTHC46HjjnajFPomBYr1fN4028K/uqbx/7SjV8jcQhWs211YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS/zvywG; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS/zvywG"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso2649459a12.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197486; x=1790802286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78QRabKOkpzipta1uBVU6U40HtfNl2658plOmjTIJH4=;
        b=DS/zvywGkMcr9ZY+qr42/brln6pVnDmGPPJ74nKyssCX6auUKPwpV0bk8fXav5n+Vr
         NdOCqAwUg06SI1NnVPAjWiczodfb9Q8wbHNAvYKU+gfeRssuSrQGNkTB8CCnzig4Gilr
         onNYNx6FwaajXW5ibEW8mUHsACoiytGsrfhQq8nM9d+caq8WeOIfL2qg41iPkpxlKwb0
         Ll9WkIWwao133kSL8O1KV5JznlIRaO4r1nZNw7/wMmnjZvZwPlktQgf2i8AVyj9G7JNs
         vo9+B9a6E42U+7E6GWRw4B6pG+djUdOjQORSkJP6//TCNs/xh2u/uJxELMN7+9eLwsWc
         Inaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197486; x=1790802286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=78QRabKOkpzipta1uBVU6U40HtfNl2658plOmjTIJH4=;
        b=UmWmX2yLS17APzF59zGictrcQqnUXea3L+y+W8erR5gFxaDuemS2VqGlLwg4qzv9kQ
         u0V2RdzP0bOkWbkdlTEiuNkq3gUPe3uflndWUDBF6NgukqFj6ZYfOSXvQ0FlLXSjH7ct
         /4Xdu75rcTutXfKu3m7p5aBtDZJA4n+nA0c3qdFnRJelO9wQCFx0ACyzWqlv5neWSYt0
         oOBQ1QwZ/SZ+5Bv3jayBC/XzSet8Lkfofm+p4lXtTwy4QoIDsp/Br/rJT32PEbb48Wvc
         baf4r6PMx/zYTU1qdVMWuSroylW17GX/6tCARkbTKPWQZuzq8IOI8SLa6RSBuR3nF4MI
         Y/3g==
X-Gm-Message-State: AFuF++mSfH+F9sVmCs9kbDbNlllfzehcC4kp44zXWWwNpR86U4z37AEU
	wGrqiluMsYumg+vL1GmJZgk8IhO7XL1i1zJw4a8A/BwsJPIWQKUslkBMTU1YFAf7
X-Gm-Gg: AYBFou038z+QZzvuoPZOsmgp9r2Or0UKnhLj7diUUlR3ljkVSzxlXv3VDoXV2XxO6A+
	W7WGb3M+ccW8bOiUBN+qPbXqZseyqon5clsa7GcoemF8c+rgIWcrJyVrULEazDc8XrnM/4Y/ayV
	8ab+778VDZRLajRd8dM5/lpLXZyznKSbxzSlxrnhJ7SntmChH5mU0MthVv/EDhtDsIiv/P6mZw3
	fPsh0BTxlSZhYrPp+fnWtHxNss6O6pT0igZYmp7hUhd0ljMgpeI0kpXApvGNMchbeOIeSN9EX2g
	pfwa6spIcAY4sIADChNKYliXWqiIWeO66fwBN8ozB9094TiyFHUiB8798JHtIW1LmCJLz6w0z3B
	VZV/u9xn2Qgvdl0CMN2AuSee6VXi54rUIbuca8GmINMXONG8F7N6diVY8JExxLe1BhuJFL/Iydf
	Opy/R+ABbKZvVEcMgNK7ajRwvGL7kZHw3DVq8/oOus6LfCVWvbESr/w5ACYUp6M3TNA1bRcbTFy
	QHgtomkEo3emOE7k4du9xtqd6NSwvIfNMlsqvmJCVpW/Rxs3p9TUYGwEGDtuTb3BzWjHv2TsU9a
	5irlM29AptIAg5q10nYGqnDuxa/3onz/7EdHzqWPXeCuJ1Z4dg5CpwL4qBQ=
X-Received: by 2002:a17:906:dc90:b0:c29:57c4:cb92 with SMTP id a640c23a62f3a-c2ac228849fmr29199666b.0.1790197486001;
        Wed, 23 Sep 2026 14:04:46 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae60e4c8sm189325366b.26.2026.09.23.14.04.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 14:04:45 -0700 (PDT)
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
Subject: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch deletion
Date: Wed, 23 Sep 2026 23:04:40 +0200
Message-Id: <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com> <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refs_delete_refs() performs unconditional deletions, so callers cannot
preserve old values that they have already resolved. Consequently,
reference-transaction hooks see a null old OID.

Let callers provide an optional array of expected old OIDs in parallel with
the refname list. Delete the ref at position N only if it still points at
the OID at position N. Treat a null OID as an unconditional deletion in
ref_transaction_delete(), allowing callers to include broken refs whose old
value cannot be resolved.

refs_delete_refs() has always promised best-effort deletion. Always use
REF_TRANSACTION_ALLOW_FAILURE and report rejected updates so one failure
does not prevent independent refs in the batch from being deleted. Let
callers request the exact set of failed refs when they need to report
partial results. This also completes the conversion that was missed when
batched transaction failure support was introduced.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 bisect.c                  |  2 +-
 builtin/branch.c          |  3 +-
 builtin/fetch.c           |  2 +-
 builtin/remote.c          |  5 +--
 builtin/tag.c             |  3 +-
 refs.c                    | 67 +++++++++++++++++++++++++++++++--------
 refs.h                    | 31 +++++++++++++-----
 t/helper/test-ref-store.c |  2 +-
 8 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9cbb3dc67..c8ab16d1e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1206,7 +1206,7 @@ int bisect_clean_state(void)
 	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
 				  "bisect: remove", &refs_for_removal,
-				  REF_NO_DEREF);
+				  NULL, NULL, REF_NO_DEREF);
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc..baccefc77 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -351,7 +351,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	}
 
 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
-	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
+			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d..11caa6b4a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1486,7 +1486,7 @@ static int prune_refs(struct display_state *display_state,
 		} else {
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
-						  0);
+						  NULL, NULL, 0);
 		}
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3b..840c842e2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1073,7 +1073,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 	if (!result)
 		result = refs_delete_refs(get_main_ref_store(the_repository),
 					  "remote: remove", &branches,
-					  REF_NO_DEREF);
+					  NULL, NULL, REF_NO_DEREF);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
@@ -1645,7 +1645,8 @@ static int prune_remote(const char *remote, int dry_run)
 
 	if (!dry_run)
 		result |= refs_delete_refs(get_main_ref_store(the_repository),
-					   "remote: prune", &refs_to_prune, 0);
+					   "remote: prune", &refs_to_prune,
+					   NULL, NULL, 0);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
diff --git a/builtin/tag.c b/builtin/tag.c
index 06c125b53..40157e834 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -122,7 +122,8 @@ static int delete_tags(const char **argv)
 	struct string_list_item *item;
 
 	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
+			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
 		result = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
diff --git a/refs.c b/refs.c
index 92d5df5b7..13ee2d459 100644
--- a/refs.c
+++ b/refs.c
@@ -16,6 +16,7 @@
 #include "refs/refs-internal.h"
 #include "hook.h"
 #include "object-name.h"
+#include "oid-array.h"
 #include "odb.h"
 #include "object.h"
 #include "path.h"
@@ -1523,7 +1524,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	if (old_oid && is_null_oid(old_oid))
-		BUG("delete called with old_oid set to zeros");
+		old_oid = NULL;
 	if (old_oid && old_target)
 		BUG("delete called with both old_oid and old_target set");
 	if (old_target && !(flags & REF_NO_DEREF))
@@ -3069,39 +3070,73 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 	}
 }
 
+struct delete_refs_rejection_data {
+	int failures;
+	struct string_list *failed_refs;
+};
+
+static void delete_refs_rejection_handler(const char *refname,
+					  const struct object_id *old_oid UNUSED,
+					  const struct object_id *new_oid UNUSED,
+					  const char *old_target UNUSED,
+					  const char *new_target UNUSED,
+					  enum ref_transaction_error err,
+					  const char *details,
+					  void *cb_data)
+{
+	struct delete_refs_rejection_data *data = cb_data;
+
+	warning(_("could not delete reference %s: %s"), refname,
+		details ? details : ref_transaction_error_msg(err));
+	data->failures++;
+	if (data->failed_refs)
+		string_list_insert(data->failed_refs, refname);
+}
+
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
-		     struct string_list *refnames, unsigned int flags)
+		     struct string_list *refnames,
+		     const struct oid_array *old_oids,
+		     struct string_list *failed_refs,
+		     unsigned int flags)
 {
+	struct delete_refs_rejection_data rejection_data = {
+		.failed_refs = failed_refs,
+	};
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	struct string_list_item *item;
-	int ret = 0, failures = 0;
+	size_t i;
+	int ret = 0;
 	char *msg;
 
 	if (!refnames->nr)
 		return 0;
+	if (old_oids && old_oids->nr != refnames->nr)
+		BUG("refname and old OID counts do not match");
+	if (failed_refs && !failed_refs->strdup_strings)
+		BUG("failed ref list does not duplicate strings");
 
 	msg = normalize_reflog_message(logmsg);
 
-	/*
-	 * Since we don't check the references' old_oids, the
-	 * individual updates can't fail, so we can pack all of the
-	 * updates into a single transaction.
-	 */
-	transaction = ref_store_transaction_begin(refs, 0, &err);
+	transaction = ref_store_transaction_begin(refs,
+						  REF_TRANSACTION_ALLOW_FAILURE, &err);
 	if (!transaction) {
 		ret = error("%s", err.buf);
 		goto out;
 	}
 
-	for_each_string_list_item(item, refnames) {
+	for (i = 0; i < refnames->nr; i++) {
+		struct string_list_item *item = &refnames->items[i];
+		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
+
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, NULL, flags, msg, &err);
+					     old_oid, NULL, flags, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
 			strbuf_reset(&err);
-			failures = 1;
+			rejection_data.failures++;
+			if (failed_refs)
+				string_list_insert(failed_refs, item->string);
 		}
 	}
 
@@ -3113,9 +3148,13 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		else
 			error(_("could not delete references: %s"), err.buf);
 	}
+	if (!ret)
+		ref_transaction_for_each_rejected_update(transaction,
+							 delete_refs_rejection_handler,
+							 &rejection_data);
 
 out:
-	if (!ret && failures)
+	if (!ret && rejection_data.failures)
 		ret = -1;
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
diff --git a/refs.h b/refs.h
index 9979446d1..43f7a32f2 100644
--- a/refs.h
+++ b/refs.h
@@ -9,6 +9,7 @@
 struct fsck_options;
 struct object_id;
 struct ref_store;
+struct oid_array;
 struct strbuf;
 struct string_list;
 struct string_list_item;
@@ -623,13 +624,26 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    unsigned int flags);
 
 /*
- * Delete the specified references. If there are any problems, emit
- * errors but attempt to keep going (i.e., the deletes are not done in
- * an all-or-nothing transaction). msg and flags are passed through to
- * ref_transaction_delete().
+ * Delete the specified references. If old_oids is non-NULL, it must contain
+ * an entry for each refname, in the same order. Each non-null OID is used to
+ * verify the current value of the corresponding reference before deleting
+ * it. A null OID requests an unconditional deletion, which allows callers to
+ * include broken refs whose old value cannot be resolved.
+ *
+ * If failed_refs is non-NULL, it must be initialized with
+ * STRING_LIST_INIT_DUP. The names of individual updates that cannot be queued
+ * or are rejected while processing the best-effort batch are inserted into
+ * it. A transaction-wide failure is returned without populating the list.
+ *
+ * If there are any problems, emit errors but attempt to keep going (i.e.,
+ * the deletes are not done in an all-or-nothing transaction). msg and flags
+ * are passed through to ref_transaction_delete().
  */
 int refs_delete_refs(struct ref_store *refs, const char *msg,
-		     struct string_list *refnames, unsigned int flags);
+		     struct string_list *refnames,
+		     const struct oid_array *old_oids,
+		     struct string_list *failed_refs,
+		     unsigned int flags);
 
 /** Delete a reflog */
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
@@ -956,9 +970,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Add a reference deletion to transaction. If old_oid is non-NULL,
- * then it holds the value that the reference should have had before
- * the update (which must not be null_oid).
+ * Add a reference deletion to transaction. If old_oid is non-NULL and not
+ * null_oid, then it holds the value that the reference should have had before
+ * the update. Passing null_oid is equivalent to passing NULL and disables the
+ * old value check.
  *
  * See the above comment "Reference transaction updates" for more
  * information.
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index db58f0058..29945f2b8 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -132,7 +132,7 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	result = refs_delete_refs(refs, msg, &refnames, flags);
+	result = refs_delete_refs(refs, msg, &refnames, NULL, NULL, flags);
 	string_list_clear(&refnames, 0);
 	return result;
 }
-- 
2.39.3 (Apple Git-146)

