Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF13F329E
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901669; cv=none; b=NgevPmnsUL6ZI75xYnC+YtvtIYSBDqt0JzowIgLfj9zM3v2KOfRRHUCvCp1YdqAEE76/hFQTzwol/MY0WnZgz4g45XixPWmF/xPebz1GZI8302A//+vFM5mIKOS7DhwVHClNc130Kq/hXs/3a/w9XwJTH66RzMmWbLkbRNqJUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901669; c=relaxed/simple;
	bh=rDS/jYh7wMA56GXZ2iLd0wkFm4LWkvwpOaR/8gUOstY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrMS4pOEES+mw8N6X++aE/upnBft/biZ/xv6uS38f+sAQLIfrwO5nJB/EXd3x/aJp9eJycWpE2lEjbkPMuISAtKjUFb78UzVIKYKwwkZnyi/uqCF8rT78g/7PVfGNSf6W695gA0pzI5XG8kQz+joPyim9oS/Y5kQtL5oTmFZUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD3k2uKu; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD3k2uKu"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so308164266b.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789901666; x=1790506466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmmaU70nIql99oIwNfIJ0D9I51o/d4MeL3H835T+UvA=;
        b=QD3k2uKu1c6a8cgu3jmqc8JxaIqqFM89VZ2z9kloT8Sn6FuZ55JZ4o/uUfRZuEbzb+
         xei3ILVhdGgc8fbLYyTvW/RI/VI6g4hLaPKkHTMP78qToLbBJPccZiRPIAlPCcNsdR7R
         fFyKu/h0lyAPC9kqEx74PTE3rKa9lRLbli1U2LgpWHW1n0TX2bk0Hjc33vQCX7rBkbae
         a+t5Xodo8JsAqGKgPcDITW7tIQPgd+ybgU2X2ajh4bD1h7j/O3fo4KWHcDwjhcO+LGIg
         bPDZtbdNpy/ROsS9v0evOFLCPl36YBs735gmYcyT2/205UBWOAh0QeliTtC5MmAGWYRl
         m4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789901666; x=1790506466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RmmaU70nIql99oIwNfIJ0D9I51o/d4MeL3H835T+UvA=;
        b=J9ea/Znj44ag4uPPGcRA7MAbZpYjAIscB5b3M1lEwXRqUTUhglt7VyHml+o952UEN9
         dp69EeKO0b6NF5KVXgtUs/IdZ/EYMB8azmf17i+o8wyHWbFU2IPvVdJp0P7t1f+6h9Av
         UYgi6PsF0WCdgHKCax08lTAzrx0TOq6dAe/e9Wg26P4GxeiWHmHbWV2fVmGTwlk636+w
         TmLFzPkVgXKf2yZYk2wtlFTcuxDU7K5j9GSGCarEPoGi8Rp6qnk539AjCNuPCLhJRHgC
         YMfEtPkGojrUIKBiow4lyqHSmaWvFp7DGenonjnLJIbPlgIZCFfaQzfkKwJG1Vmy43rm
         9MEQ==
X-Gm-Message-State: AFuF++llDuPy877A6j2EdOWgN1Kx0fFdt4Gyxg1zOHBGS5n9inc/L2+D
	7gNv61Bi+YEpkQZw5IZE1LmRfIloqo+kEbT9orrzUkGTJkRZvBQbgq9GjAUiVNzX
X-Gm-Gg: AYBFou2YhUTwQNQuGeIbMmuumlpCdPf19iMuBvR0LIe2Uovt+jYspH70HnIglKbbrPa
	EcwkpuhI+AWg5B7fOgQqh3zo/d9dTdzaBXUl7dv/oU4snH2r8Ja7RBG2J42hVA+QqPOXQb3iFtf
	PbEaIAEyg9H2fjlrzZPSukF+S8ZywZhHY3Bp3qcrIGp2T+E9YChWIYyZVKGmfPXuWH4/eOwoefs
	L5SsuamNLtNMnFDzckJw37MrZfPYMdNMHTNtLc+K++gonf71S2NGtTIDovWgzSdSvyA44AK3n6o
	05ywd6REJTjGTB9rFFvCUDF6ZaUj3MA6NdXws51LXn4M+sm8b8hbqSX0upr7YM+RgPvmU7er6JV
	vTlFAOrCwbpg1R7Ga7S27EXN1rV1lVdMc7/jXWGbs4jPnmOUaMqdB3ta5K916bg4sFtn2az727O
	o5NMI1oxjPtqONMLyD7DPWqn8+SB/EZ43+74PBXwI3VI8HGqcpTRJezPtiZqBXiolga+cT/85Me
	ILgyp6ql7VvT6hRjv9rPhrlJ/bf07RD2g944FI0O+7nIp4Dg+6fPdh3MOH4jqmfAKTNNPcPVvP4
	GaO7XwJWVGXz8iJb8Y9K+Sb3/W8E75WYaigmAqr6buWllrhy7t/sN9Ax7sPfe1jTOVa4
X-Received: by 2002:a17:907:6d17:b0:c24:e1e9:69c with SMTP id a640c23a62f3a-c2a1547f6c4mr679417366b.0.1789901665575;
        Sun, 20 Sep 2026 03:54:25 -0700 (PDT)
Received: from localhost.localdomain (138.54.classcom.pl. [195.150.54.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35239469sm170989666b.6.2026.09.20.03.54.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 03:54:25 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/3] refs: allow callers to supply old OIDs for batch deletion
Date: Sun, 20 Sep 2026 12:54:20 +0200
Message-Id: <5c96a5a1ebafd49a301c5c1dc77a2e19d6677ab0.1789901584.git.maciej.ciemborowicz@gmail.com>
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

refs_delete_refs() currently performs unconditional deletions. Thus callers
cannot preserve old values that they have already resolved, and
reference-transaction hooks consequently see a null old OID.

Add an optional oid_array whose entries correspond to the refnames. Pass each
non-null OID to ref_transaction_delete(). Supplying an OID makes the deletion
conditional: if the ref changed after the caller resolved it, the transaction
fails instead of deleting the new value. Existing callers that pass NULL
retain the unconditional behavior.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 bisect.c                  |  2 +-
 builtin/branch.c          |  3 ++-
 builtin/fetch.c           |  2 +-
 builtin/remote.c          |  5 +++--
 builtin/tag.c             |  3 ++-
 refs.c                    | 23 ++++++++++++++---------
 refs.h                    | 12 ++++++++++--
 t/helper/test-ref-store.c |  2 +-
 8 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index 94c7028d2..9aa3bace9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1203,7 +1203,7 @@ int bisect_clean_state(void)
 	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
 				  "bisect: remove", &refs_for_removal,
-				  REF_NO_DEREF);
+				  NULL, REF_NO_DEREF);
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9e..f1abeb681 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -322,7 +322,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
+			     &refs_to_delete, NULL, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1d7c672f..d202147b2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1467,7 +1467,7 @@ static int prune_refs(struct display_state *display_state,
 		} else {
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
-						  0);
+						  NULL, 0);
 		}
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3b..13d3cc52d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1073,7 +1073,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 	if (!result)
 		result = refs_delete_refs(get_main_ref_store(the_repository),
 					  "remote: remove", &branches,
-					  REF_NO_DEREF);
+					  NULL, REF_NO_DEREF);
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
index d3caa9a63..9c593baea 100644
--- a/refs.c
+++ b/refs.c
@@ -18,6 +18,7 @@
 #include "refs/refs-internal.h"
 #include "hook.h"
 #include "object-name.h"
+#include "oid-array.h"
 #include "odb.h"
 #include "object.h"
 #include "path.h"
@@ -3056,33 +3057,37 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 }
 
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
-		     struct string_list *refnames, unsigned int flags)
+		     struct string_list *refnames,
+		     const struct oid_array *old_oids,
+		     unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	struct string_list_item *item;
+	size_t i;
 	int ret = 0, failures = 0;
 	char *msg;
 
+	if (old_oids && old_oids->nr != refnames->nr)
+		BUG("refname and old OID counts do not match");
 	if (!refnames->nr)
 		return 0;
 
 	msg = normalize_reflog_message(logmsg);
 
-	/*
-	 * Since we don't check the references' old_oids, the
-	 * individual updates can't fail, so we can pack all of the
-	 * updates into a single transaction.
-	 */
 	transaction = ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction) {
 		ret = error("%s", err.buf);
 		goto out;
 	}
 
-	for_each_string_list_item(item, refnames) {
+	for (i = 0; i < refnames->nr; i++) {
+		struct string_list_item *item = &refnames->items[i];
+		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
+
+		if (old_oid && is_null_oid(old_oid))
+			old_oid = NULL;
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, NULL, flags, msg, &err);
+					     old_oid, NULL, flags, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
diff --git a/refs.h b/refs.h
index 71d5c186d..b76b556cf 100644
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
@@ -613,13 +614,20 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    unsigned int flags);
 
 /*
- * Delete the specified references. If there are any problems, emit
+ * Delete the specified references. If old_oids is non-NULL, it must contain
+ * an entry for each refname, in the same order. Each non-null entry is used
+ * to verify the current value of the corresponding reference before deleting
+ * it. A null entry disables verification for that reference.
+ *
+ * If there are any problems, emit
  * errors but attempt to keep going (i.e., the deletes are not done in
  * an all-or-nothing transaction). msg and flags are passed through to
  * ref_transaction_delete().
  */
 int refs_delete_refs(struct ref_store *refs, const char *msg,
-		     struct string_list *refnames, unsigned int flags);
+		     struct string_list *refnames,
+		     const struct oid_array *old_oids,
+		     unsigned int flags);
 
 /** Delete a reflog */
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3866d0aca..c2c7dfb06 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -140,7 +140,7 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	result = refs_delete_refs(refs, msg, &refnames, flags);
+	result = refs_delete_refs(refs, msg, &refnames, NULL, flags);
 	string_list_clear(&refnames, 0);
 	return result;
 }
-- 
2.39.3 (Apple Git-146)

