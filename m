Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCFCD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjIRR75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIRR7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 13:59:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB0121
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:59:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso30535335e9.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059981; x=1695664781; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubMxsbUvW5XykwgiLxu8nvh4K8in8d8MnELnnIs2AaY=;
        b=V0Ma3NNYnanW3Cnmx510cIbUPEEL3iGgZbqSObUgsEk76+RoGTCIiP/p84mO+V1WQ8
         Zly/fJ398dG6je2HmASXJpgEzczb0MBwuUQyVfLBr8UXK78m+5jptuaY3Z6BUWUSleVr
         Qigr5Rn3UFZ6xnjjniBFEtLqlVEEF7Qrmgq9br6DquBCDjwx2WfaetIETMZ8Zc9EgDXO
         IhumlvQzcddGGnCjinWC8yE4hGH3BuYqAhpwhdBgDTJt4str08zUEHZKZT2Kjvu6hkpo
         CKqmFKVmKvkw8nJRkQ3FAzun17fEEYudMkXundJmlP5maquTNcdEqb4qnoE49nYwbnVW
         5YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059981; x=1695664781;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubMxsbUvW5XykwgiLxu8nvh4K8in8d8MnELnnIs2AaY=;
        b=o18WsmrKY5oH+7pqtvH8eA0ZRXb6Y1Fx37XAPzXcAl6yWc9YfOPwE6s7wVLgk8H+sJ
         2HaNaYYVFBLCX0fPUavOJZJk1UJ9MYg5NBnfYMVPKPVkz3j6RU4ijBcSeun/QBEovxkM
         PXPjGWiJey0aDmJe5RvJa9LqtOKg2oTtwRsl4NkkaN8DJb6xjkZ+6Hmg6hC5pYJBlQwa
         gfWr8gDFXaZFxHMBh7NnXViiPrFUMdGYsfKwZ54UUw6KzsmQu/KZCf6lREy5rPL7SUPx
         fsvUtUE2nnd1/5N1FNSG4jJKElASPM8mz3bcT/Ehj9zvn0k4RmUTY16RaUifu/bWZ7GM
         h2LA==
X-Gm-Message-State: AOJu0Yz9wncA1mLat14foL6XnDwYW/luECgFqOWaOl1rEmvBjez+4rbM
        j/891hKCW1Fh/OeEJhrJFYnCIpYH9Zc=
X-Google-Smtp-Source: AGHT+IFDot9zJbxUjuZ7drxPiu00atDCMnoSEobASPzxAI0+8HFr4+H4ZNn4pk3FHKjgkh2tfGZMZw==
X-Received: by 2002:a05:600c:21d7:b0:3fe:d1e9:e6b8 with SMTP id x23-20020a05600c21d700b003fed1e9e6b8mr8222371wmj.12.1695059980876;
        Mon, 18 Sep 2023 10:59:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020adfdc84000000b0031753073abcsm13183737wrj.36.2023.09.18.10.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:59:40 -0700 (PDT)
Message-ID: <a5cb3adc6627622aa8a9eb0605da36429efa5466.1695059978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 17:59:37 +0000
Subject: [PATCH 2/3] refs: move is_packed_transaction_needed out of
 packed-backend.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

It is no longer specific to the packed backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c  | 96 +++++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.c | 95 ------------------------------------------
 refs/packed-backend.h |  9 ----
 3 files changed, 96 insertions(+), 104 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4a6781af783..c0a7e3d375b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2630,6 +2630,101 @@ out:
 	return ret;
 }
 
+
+/*
+ * Return true if `transaction` really needs to be carried out against
+ * the specified packed_ref_store, or false if it can be skipped
+ * (i.e., because it is an obvious NOOP). `ref_store` must be locked
+ * before calling this function.
+ */
+static int is_packed_transaction_needed(struct ref_store *ref_store,
+				 struct ref_transaction *transaction)
+{
+	struct strbuf referent = STRBUF_INIT;
+	size_t i;
+	int ret;
+
+	/*
+	 * We're only going to bother returning false for the common,
+	 * trivial case that references are only being deleted, their
+	 * old values are not being checked, and the old `packed-refs`
+	 * file doesn't contain any of those reference(s). This gives
+	 * false positives for some other cases that could
+	 * theoretically be optimized away:
+	 *
+	 * 1. It could be that the old value is being verified without
+	 *    setting a new value. In this case, we could verify the
+	 *    old value here and skip the update if it agrees. If it
+	 *    disagrees, we could either let the update go through
+	 *    (the actual commit would re-detect and report the
+	 *    problem), or come up with a way of reporting such an
+	 *    error to *our* caller.
+	 *
+	 * 2. It could be that a new value is being set, but that it
+	 *    is identical to the current packed value of the
+	 *    reference.
+	 *
+	 * Neither of these cases will come up in the current code,
+	 * because the only caller of this function passes to it a
+	 * transaction that only includes `delete` updates with no
+	 * `old_id`. Even if that ever changes, false positives only
+	 * cause an optimization to be missed; they do not affect
+	 * correctness.
+	 */
+
+	/*
+	 * Start with the cheap checks that don't require old
+	 * reference values to be read:
+	 */
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if (update->flags & REF_HAVE_OLD)
+			/* Have to check the old value -> needed. */
+			return 1;
+
+		if ((update->flags & REF_HAVE_NEW) && !is_null_oid(&update->new_oid))
+			/* Have to set a new value -> needed. */
+			return 1;
+	}
+
+	/*
+	 * The transaction isn't checking any old values nor is it
+	 * setting any nonzero new values, so it still might be able
+	 * to be skipped. Now do the more expensive check: the update
+	 * is needed if any of the updates is a delete, and the old
+	 * `packed-refs` file contains a value for that reference.
+	 */
+	ret = 0;
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		int failure_errno;
+		unsigned int type;
+		struct object_id oid;
+
+		if (!(update->flags & REF_HAVE_NEW))
+			/*
+			 * This reference isn't being deleted -> not
+			 * needed.
+			 */
+			continue;
+
+		if (!refs_read_raw_ref(ref_store, update->refname, &oid,
+				       &referent, &type, &failure_errno) ||
+		    failure_errno != ENOENT) {
+			/*
+			 * We have to actually delete that reference
+			 * -> this transaction is needed.
+			 */
+			ret = 1;
+			break;
+		}
+	}
+
+	strbuf_release(&referent);
+	return ret;
+}
+
 struct files_transaction_backend_data {
 	struct ref_transaction *packed_transaction;
 	int packed_transaction_needed;
@@ -3294,3 +3389,4 @@ struct ref_storage_be refs_be_files = {
 	.delete_reflog = files_delete_reflog,
 	.reflog_expire = files_reflog_expire
 };
+
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5df7fa8004f..ba895c845c0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1455,101 +1455,6 @@ error:
 	return -1;
 }
 
-int is_packed_transaction_needed(struct ref_store *ref_store,
-				 struct ref_transaction *transaction)
-{
-	struct packed_ref_store *refs = packed_downcast(
-			ref_store,
-			REF_STORE_READ,
-			"is_packed_transaction_needed");
-	struct strbuf referent = STRBUF_INIT;
-	size_t i;
-	int ret;
-
-	if (!is_lock_file_locked(&refs->lock))
-		BUG("is_packed_transaction_needed() called while unlocked");
-
-	/*
-	 * We're only going to bother returning false for the common,
-	 * trivial case that references are only being deleted, their
-	 * old values are not being checked, and the old `packed-refs`
-	 * file doesn't contain any of those reference(s). This gives
-	 * false positives for some other cases that could
-	 * theoretically be optimized away:
-	 *
-	 * 1. It could be that the old value is being verified without
-	 *    setting a new value. In this case, we could verify the
-	 *    old value here and skip the update if it agrees. If it
-	 *    disagrees, we could either let the update go through
-	 *    (the actual commit would re-detect and report the
-	 *    problem), or come up with a way of reporting such an
-	 *    error to *our* caller.
-	 *
-	 * 2. It could be that a new value is being set, but that it
-	 *    is identical to the current packed value of the
-	 *    reference.
-	 *
-	 * Neither of these cases will come up in the current code,
-	 * because the only caller of this function passes to it a
-	 * transaction that only includes `delete` updates with no
-	 * `old_id`. Even if that ever changes, false positives only
-	 * cause an optimization to be missed; they do not affect
-	 * correctness.
-	 */
-
-	/*
-	 * Start with the cheap checks that don't require old
-	 * reference values to be read:
-	 */
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-
-		if (update->flags & REF_HAVE_OLD)
-			/* Have to check the old value -> needed. */
-			return 1;
-
-		if ((update->flags & REF_HAVE_NEW) && !is_null_oid(&update->new_oid))
-			/* Have to set a new value -> needed. */
-			return 1;
-	}
-
-	/*
-	 * The transaction isn't checking any old values nor is it
-	 * setting any nonzero new values, so it still might be able
-	 * to be skipped. Now do the more expensive check: the update
-	 * is needed if any of the updates is a delete, and the old
-	 * `packed-refs` file contains a value for that reference.
-	 */
-	ret = 0;
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-		int failure_errno;
-		unsigned int type;
-		struct object_id oid;
-
-		if (!(update->flags & REF_HAVE_NEW))
-			/*
-			 * This reference isn't being deleted -> not
-			 * needed.
-			 */
-			continue;
-
-		if (!refs_read_raw_ref(ref_store, update->refname, &oid,
-				       &referent, &type, &failure_errno) ||
-		    failure_errno != ENOENT) {
-			/*
-			 * We have to actually delete that reference
-			 * -> this transaction is needed.
-			 */
-			ret = 1;
-			break;
-		}
-	}
-
-	strbuf_release(&referent);
-	return ret;
-}
-
 struct packed_transaction_backend_data {
 	/* True iff the transaction owns the packed-refs lock. */
 	struct string_list updates;
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index ade3c8a5ac4..51a3b6a332a 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -17,13 +17,4 @@ struct ref_store *packed_ref_store_create(struct repository *repo,
 					  const char *gitdir,
 					  unsigned int store_flags);
 
-/*
- * Return true if `transaction` really needs to be carried out against
- * the specified packed_ref_store, or false if it can be skipped
- * (i.e., because it is an obvious NOOP). `ref_store` must be locked
- * before calling this function.
- */
-int is_packed_transaction_needed(struct ref_store *ref_store,
-				 struct ref_transaction *transaction);
-
 #endif /* REFS_PACKED_BACKEND_H */
-- 
gitgitgadget

