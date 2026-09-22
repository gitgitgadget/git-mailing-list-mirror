Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDE28CF5F
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116288; cv=none; b=GZut3FZZsPA9ihehGpqDJerLpP+7Z+LD+TwejIaXkOd+yrHEmDhpv/3lbnIiH6Hh9Jh0eDwYZI4yEeVaoWnJvPHUvhIeBvMUbqjuBbXzqbcriEnyS1oYyI9Gcz9IkMU+6DmxprOQdZK6Ga1GttMIZEGA+RoIz9LIZIMe5PdsA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116288; c=relaxed/simple;
	bh=GCsJ/UaginsLpPS98fhFcCbtL68a760qDaHHj0UcWRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lulB5Siae7tGZCXx2g+rsAgL9jD+6D9+BGTGd8+Qhu3n3A+U9rQwUbufnf1fGam9Wh4BG8H+MLNviEVHbD5Bba8fdxdc4f07C6llzzicQJMQFrXsVyfHJxxIIGtQPGl/QN44ESxsaVOGzxfa5nBeH++HLDCp6+6DWsVuvfmVAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+Ia+kFw; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+Ia+kFw"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985fba28bso455322a12.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790116272; x=1790721072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUu0TR6OJ66N5ZyeOfI+/pFEAsPvZO2rJA4EQnwqvDU=;
        b=Q+Ia+kFw/98+QqJi/hvfxPTKy6E5JJ8NaMucBivO+8uCg7FZx6r82XLLXzvXO5AtcR
         sU9mehJvz7kL140P+7fFMrErhcEjZN6UX7EN5tHt6kgOCl98doyknVeJZUD8oOtA+sNa
         a3/tZxaAfXCMezpxQ8tI8TI+DWszjiLMXrrBdnjgDsUwcY4iTap57/qSyLhCvAJFNnnn
         dYJsHGj+uC5WjXUwbMJPMuTKvXn/rwVMoxxNiQseeEaLXxYMsFlYI2LV/wwGtq31qany
         90grSsxYtrvAKgVbmRXKDnsSAJ2Ny5xQ9bTI3vYRH3ZQsBQ6NEt6EuAFW2Pz9NT8qm5Z
         xPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116272; x=1790721072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUu0TR6OJ66N5ZyeOfI+/pFEAsPvZO2rJA4EQnwqvDU=;
        b=MylAc5rdUCCzHKAVyKPATMNCldR/DXXLRbnxewkj9xsYNWFSt7gQIbi/sRXIS05jBA
         8jY8e6UJOy+0XEQzxVoDvU0lkWOcWSia7w1oht/aOiQWs1WlwL+WwQbYNHjIFT4U0iHn
         QS+wfF/XBGXVQesjkhtHwyzn+qmV9sW5T5YF2vLHSNnen72e+rlTSvqNH3rOI9JznlBO
         aJSeqdmh6I7MSAXfctFHHACuhH83IKb0r9NKRdHpX9lv2vS49UgDLOR8oQpydmJNjp9k
         wMEDR1N4QS/bROKHETaiHjmp+k8uM0qtu6o8PzG8NXugL/hXFpqxHzA3Af5Q2Q2Ol/hp
         P71Q==
X-Gm-Message-State: AFuF++mk7/DUf+8aossmBbrhPoO/++B/q8Dcv7j3FWZ7An7kKbnwnQ6P
	QC2Kmo9gm1dujiWd96iVsB1zqdUaaZUs4+wnJ5Q/d3knX7uWXRHsp4Lv3sOUHHHt
X-Gm-Gg: AYBFou1BIRBjxrvkB+AiTO5/JbuBPLbLqanxHGHQUa/JBGrkgfzcn9QQteGOBQY7NxY
	uIMpf7PzCLnTtjSlAjvk84wibUitvr6IHF2dX8ow0yGs1LKqj8wFTnwb72TvUakxlPb3oDYyS2J
	XfWNHpbTGLC2BWXuq8aAoWmVv7o9odwLYWN1L7x4ldckqBfdYAr/CdX2ST0nc6uVW6uO1bAPICx
	PMa6Fe7woTjruZNHy+vSJukhrp3BFcxj8a7YK5Ug/UTBALZZ0fMtJtt51P0kgAnU4R7iqV0uufU
	geI8YCYxiI3o1RapV4ux0kGkGd2vGgGDNZT6tPLQRaaWpZF1gCCna9v+s9nQ1AtXU2kzRImu5mK
	vNUmxHClCEnQsQb+2SXKGk7Z432RK/tE3vonVNZRomyao/oDkdeQ6yI+uSUvxNxAsGOr9tlkz5k
	B+hzbJlbg86sGQdga7bVYaQiCiHqZT4vljGFuZDLVuEJ6sbHFUK0ZLfvfJ06BKns6FsT5b5imJE
	2f1kEaML2NxWaF/ou091HJ6UUQh03FCZN/3jpagdWxhvTk87xuf2opIxH/ADB+SsKznILsNnXjl
	RIbZHf5XvyWpbKdYRAsPEM7Oa6TtxqOQ/HwOQAhHp0cUcL2o
X-Received: by 2002:a17:907:86a0:b0:c15:f26a:3438 with SMTP id a640c23a62f3a-c2aae1520b0mr48209066b.24.1790116271776;
        Tue, 22 Sep 2026 15:31:11 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5524sm20847566b.21.2026.09.22.15.31.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 15:31:11 -0700 (PDT)
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
Subject: [PATCH v4 1/3] refs: allow callers to supply old OIDs for batch deletion
Date: Wed, 23 Sep 2026 00:31:08 +0200
Message-Id: <f4a9d065c34451a5f6ade6a6c365baa18adeb780.1790113781.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790079917.git.maciej.ciemborowicz@gmail.com> <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
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
index a613148fc..c9f259d04 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -351,7 +351,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	}
 
 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
-	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
+			     &refs_to_delete, NULL, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d..b662216bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1486,7 +1486,7 @@ static int prune_refs(struct display_state *display_state,
 		} else {
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
-						  0);
+						  NULL, 0);
 		}
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3b..56b06845b 100644
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
+					   NULL, 0);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
diff --git a/builtin/tag.c b/builtin/tag.c
index 06c125b53..40874a292 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -122,7 +122,8 @@ static int delete_tags(const char **argv)
 	struct string_list_item *item;
 
 	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
+			     &refs_to_delete, NULL, REF_NO_DEREF))
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

