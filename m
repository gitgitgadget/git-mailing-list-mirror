Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28E34041B
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848770; cv=none; b=EiD9+jx0Iul9+60y1N+oSa2gbwdQ0IXpKt/mp+jZCFGKhOqvEdchLPzWdET2LlEOMKhyVZIjVsHpIwM9184xFTN1gZfQgGHsrh4hhruZtX5z7qtAZzoAPNNxqWk/o05eRvk9G1T2Kh3qgGrBFPmFVskV/4yJmjNvRDlmIxn5WUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848770; c=relaxed/simple;
	bh=HNYZ/Xpq5wDNSOfxvED1/6FkeF7PNo1QyxlsX+lO6TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dEIcUZ2qAmGITkadZddYv/KY28QQ0PY0tyEXxXeT994kZq7MeNszuf+MQVIuqgIvo9gae7g1aEcC+LfgYPi1hOoloAt1NKr8Dn6XUvjMkJSKQmdMvVw4Jbvzo/WtqqMKwNqZITiQ5Idkhakkfj9PGIv6fRRVABzd17WWIIbohSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3RKW2nN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3RKW2nN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6aa13a28848so2400940a12.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789848767; x=1790453567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ghPXXhoSk1Py+Potr/OitGlK/giquW6lpJK/tsdY9s=;
        b=s3RKW2nNDMc9iBT8KK4ah9Lurwc20Qq2sE5ikQJb9cv4HaJalUUiMWfsi7Uutvp852
         tPgoRUpgsEgqguIb1TyRKzSEa0dKrmXnRn+DEWB8QwYhP+G1xrPqLWbh6gNBK7N74Fuy
         YKKr5Eg+eMeOcuGhwpGnq2Vx+lsBijniTEVkYKxfRXTxUmuADItcNgLqneGFklWnjTBO
         JtDaia3vABD4OtwlxIhp1+OiFf+wTySH64tbTYz0WS7LBQt3lcLz2IJZeCk0cqmXjm8G
         SglIe1I+UnwxsbR90bLLnaJURYGH36TjNikXGQk75NWs6lw1N/MsUqNt+h0Gxht9lusv
         c9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789848767; x=1790453567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ghPXXhoSk1Py+Potr/OitGlK/giquW6lpJK/tsdY9s=;
        b=2Q+zHrINUSXUPVyFrGZDDB3Th2nWVJq4S2pWXalWDbqhJIKOL+/dZdCOfiGSMMWHG4
         /eqR5R3E97IW+3MeZijd3lcRg3vkdRZqWD540NSvIMgmhM/7f/jpqcbiSpOXvCqi2XTz
         JT610+vHSpuDTMXOZezQa6kZb+YmnYXNOLh72sAeE4wshXvbJ7sKLQIBBt3OETwIDE33
         9ZSvbpbsMUtBwiK/ihtotH/0UInHB+7wZnvpD6sFf6HrmNfP6pUgqvkamJVcGdF6MQcL
         IPqfuCcKhwOZ/bCPx844np7jiqGgQbvtTKoyB3QNNfcj8lawSuLckATbJLNxDuHet5f1
         ZjIQ==
X-Gm-Message-State: AFuF++kvTI/wxvZBfxo7PsZBghPupf8hQdA62/5km+hACWkrKWSKMFzy
	GwW6cBogaSXOm7A57UW9QzRpT5doiWvLp+ygB8AgyaeyItOqpxHzix9ZztRGYlBD
X-Gm-Gg: AYBFou2RH672AilSWd+t7giRtUajgQQgiAUJH1F5ykWD72rlMsRhSS9JdnjAlNqKvDe
	6SAq6ct0tF7A8ncxMsdWZU54o0YM+xDi2m1bAiXeiLfyR55mZGosy1w/iATW0Zvgk+zh/BbuBNf
	F61+1seLSCUmdbvzfyIfoU1fRIzM1CjJ1QxsakYpvWDkjhwW/32Zsjsxet7VtOapRJ49fja4tWC
	z29ab2bthJmm33O7unwRc9fRt0kghVFtd9md8mjmDxaN33BdYGzTlcKXt5z3k3Q3iXxI+rO6uV8
	EAwM32wC5dL3fuf3hqYSzIy+hjO+j8XH+zpKGz1kFbRgxMmYdvSan40BBofjvQr7ONnEGBmW+V4
	C1T3Jr/TBJw0wFOw65skXQQ+lBm23bGA2phQxZSjAHZqzRR8eovQXatyLyx6RTt6pnKp/AJB29/
	itizuYty31V4lFcxtAkTa62IggAxmvtr8k33xY8BxL/cRv2w3luMo0cl21xJrPfR7QhGMzBEKA4
	8ABO/60jbeAUPncg/4MouNgmjn5TMfE0ga3EkE7gv0vnwKEeueSZmgYo6UjRh3o7Gz1pb6pxKFy
	WXN3VLm2UUPuN9LwXZup98bEpVd8PP2QlezpbVROAfMetJQYPLwP3hHRzLcP
X-Received: by 2002:a05:6402:a30c:b0:6aa:1214:65b7 with SMTP id 4fb4d7f45d1cf-6aa36e584a2mr6308322a12.21.1789848766329;
        Sat, 19 Sep 2026 13:12:46 -0700 (PDT)
Received: from localhost.localdomain ([37.31.48.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67d81625sm1723336a12.5.2026.09.19.13.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 13:12:45 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH 1/3] refs: allow callers to supply old OIDs for batch deletion
Date: Sat, 19 Sep 2026 22:11:56 +0200
Message-Id: <20260919201158.43415-2-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260919201158.43415-1-maciej.ciemborowicz@gmail.com>
References: <CACQ=SRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=mK9mXb2Xy9Nw@mail.gmail.com>
 <20260919201158.43415-1-maciej.ciemborowicz@gmail.com>
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
non-null OID to ref_transaction_delete(). Existing callers retain the
unconditional behavior for now.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 bisect.c                  |  2 +-
 builtin/branch.c          |  3 ++-
 builtin/fetch.c           |  2 +-
 builtin/remote.c          |  5 +++--
 builtin/tag.c             |  3 ++-
 refs.c                    | 26 +++++++++++++++-----------
 refs.h                    | 12 ++++++++++--
 t/helper/test-ref-store.c |  2 +-
 8 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/bisect.c b/bisect.c
index 94c7028d2a..9aa3bace9f 100644
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
index 1572a4f9ef..f1abeb681d 100644
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
index c1d7c672f4..d202147b21 100644
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
index de989ea3ba..13d3cc52dd 100644
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
index 06c125b53c..40874a2923 100644
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
index d3caa9a633..a9c5397fd7 100644
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
@@ -3056,36 +3057,39 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
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
-		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, NULL, flags, msg, &err);
+	for (i = 0; i < refnames->nr; i++) {
+		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
+
+		if (old_oid && is_null_oid(old_oid))
+			old_oid = NULL;
+		ret = ref_transaction_delete(transaction, refnames->items[i].string,
+					     old_oid, NULL, flags, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
-				item->string, err.buf);
+				refnames->items[i].string, err.buf);
 			strbuf_reset(&err);
 			failures = 1;
 		}
diff --git a/refs.h b/refs.h
index 71d5c186d0..b76b556cf7 100644
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
index 3866d0aca4..c2c7dfb065 100644
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

