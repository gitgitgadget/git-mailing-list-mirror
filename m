Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A7CE79CE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbjITNDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjITNDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:03:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31967B6
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d20548adso6519597f8f.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214976; x=1695819776; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWedQr/+opezm4QkLTiyseZXW0o+WDI9ahFXmtVcnuc=;
        b=iddzdHPm3MIkFn04qaLgap02LGx1+ctlPsj8NpGL5s5IqfVBr+Wd7++QN0gUzyVp1w
         U73ucO85ro3u7bp9pprbjMhMEKKy9T7K+cmd2XdM1OhQBh8g9aIyOWn5w+Cy1xl9PO/M
         Fa2PpK9h8+zTdSegX8QYaDrvHm2mUMe/uCc5wARKOjqV0om8h9FotJWJg/jA+9JqvSlE
         8PnO2qnoYN3Vfc4BOIDk9Cw0SupdOQTx6P8xkuizsV7mNZyCHvC2Zn11CNBFcztXctZ9
         GMpe2F26Cer2nyTOaqazVDF63kYPtyaKtd4Y3saqcE2jfJ69p99RPKDISZM+VQIqOcro
         nkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214976; x=1695819776;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWedQr/+opezm4QkLTiyseZXW0o+WDI9ahFXmtVcnuc=;
        b=r2kmFU+ZGu5bXBEOmNkfpHDV4yiTiwNeQIMtutRElSuYWkkP6EnCScvThLBgYsPPnl
         dT6Y90WZT4fhsGlT74AIjq+L6L9ylCtDEmtEkOS9F+Fj72AdEjZtE5GOjNvvEbgt2oV+
         PWqeN5v5WyrsLsMSyIX+uVX/A4Yt6wlgPe5Sx6++vU9RoH53Zv2JBt5+IBBkmA2gdbbM
         FJjGDt7Z0zEZ1t79IvWLxvabo82KFVaHxVTMdBP9Tyx972Rz122r0jdWkeHIFBxvyCx3
         KTAsOT/R0J/3pSwpqmFbf0aI3O7frPUauCkSRe13kWaZKi+ibi2fDk4+gJKnDbrU/wn7
         Telg==
X-Gm-Message-State: AOJu0YwvRiaQ+aujjkydtUOOI+IaeAOEU3D6kVCswbJwy58gQxHQ/A4J
        JTfftxKv9xaSMVQZNV2ub2sXy6bOZAo=
X-Google-Smtp-Source: AGHT+IGVR4cFBysqzWcqowoD+5txe1Z4Q71IGPbzGhp8pkEgpDDHhtFW0WPwxFzuPnJ75AK/Sk29+g==
X-Received: by 2002:adf:f08f:0:b0:320:6d6:3167 with SMTP id n15-20020adff08f000000b0032006d63167mr2279381wro.47.1695214974951;
        Wed, 20 Sep 2023 06:02:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d64e3000000b003215c6e30cbsm7746869wri.104.2023.09.20.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:02:54 -0700 (PDT)
Message-ID: <0b8919b05c43667df1a2163719ec979a07bb9588.1695214968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
        <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 13:02:46 +0000
Subject: [PATCH v2 4/6] refs: move is_packed_transaction_needed out of
 packed-backend.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

It is no longer specific to the packed backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c  | 94 ++++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.c | 95 -------------------------------------------
 refs/packed-backend.h |  9 ----
 3 files changed, 94 insertions(+), 104 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 43c1882be3c..5d288bf38bb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2630,6 +2630,100 @@ out:
 	return ret;
 }
 
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
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8b27f1afe5..2017d117c13 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1445,101 +1445,6 @@ error:
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

