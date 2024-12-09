Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EB21B8F5
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742451; cv=none; b=P06gQBVJuZOgtHg3hJG0zxIXSXKQSgFjkax5Kc5TDLsMUA0px146ctL6AYlYclJvtZIu8AwXzf6d1FwQu1r9vQpKjp6KligL7LGFBr3lLZItJmkeyw0BRatksBNtiLOE1O2r8u8NRKyILScbS/sBNsiYui7vB4KQoshdPoiTBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742451; c=relaxed/simple;
	bh=7cR6epBjK5+cted6JKC8pV6nxzM8nDK5/Q4THQFp+hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXUDnxoRby9FG1/kFTG3y8U/Z1R6FJFnLzGUFutS68KXA83jNWSpYWT7tcfLgDFD02wNdfqeCEbJGqCp0HZKyngvxU/RgvNZUovBTawMZTOR4IUiaTnRlXSh2ZCsaElz/lCFhmN9TfQ7cEPdYivk0Xh8WpngVX8yKE5R/q7M5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqc/AlBC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqc/AlBC"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6997f33e4so35582166b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742447; x=1734347247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYHhFcf2edhwtlmaD7CZzQxwc9C/jKZzn5dUQh3fjkc=;
        b=cqc/AlBCVR821o2fkmbcCFC2iHkXJMBd1npAGI50Cc0TAzuxME4Wyb9NkwTyzXvVpU
         KQIjgK97OV2GSjuwVRI4jbHSm8AUXImX6hQ6YjMT9tZJhS0Gj94JSJEUGv+bkibg1hz2
         j6BzrdnP78jsLTPfslF0wy3YyYHKoyjg+9YG652V1mQArCGBRNjmVbg4CgcIsMDflETM
         og7E2ZbP/xM6F1iWH9prAZa+GKX+wvx+172A/WTbtHCtPUPuy6kFpiE7TC0XOB5kGqVg
         ze2ztlRP5/dfU8XVMyt6ssrT0o5dqw9xtnaJBAKDUz4r6FZe59LP3ZV3GhijrY7JD4pN
         qzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742447; x=1734347247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYHhFcf2edhwtlmaD7CZzQxwc9C/jKZzn5dUQh3fjkc=;
        b=MLB68qyH1bTTBBmwAhMIGw6msVHImsCyd/DVchiewZk2i1OOGofAYOOpgFTD/QDd9z
         kQVwC2PLkBTyh+ZTljgOvwv8GqwDTeiXsEdvTNYJgX4y/SB+vE1ypYxjewQ5r3wPa5nj
         4dy0pli+SXiTNsOGWYGpTmagLHieiHdPWX4xZyuBWMpUEG+rY00JQzrSUufdlX/wpwAu
         Vz0ciws7k+xqHUcCw0eufHWwvMu7L74Mtt1Vgbf4eOKZgswxx7gOmt2ymzDUCmOUGk68
         6NBz0M4KZ43tiWpgsFSWt4UJP+ejri9kjjNkDxcHZMOD5e2B5ey99TdyT3Mf0r7+KLuP
         CjxA==
X-Gm-Message-State: AOJu0Yx/8WNRf4o1fESJitTJlZpQFZPYwIcGjrQ78eOn+vBxvdnUSvvA
	kXfuRZOkeJB+SbyEajuv8ZC18BRzb2COfDYWnaLA5GjJHSXLBHDsQHhZQvrK
X-Gm-Gg: ASbGncuENbAcJdqMkNEm9tc4e9j+9wgdMy8TRWSCCf8k9jhejAGGfrodvIngoNUTBfU
	RLtEIVP0hhtpWsjvLdJQnJ6fiOxne4biOnPi62rH6FpLn42rJ/JJKKy4dPhSXRX5u0XLtPtAKNe
	IGo6E2i1zUhqKyDFwibpusr0nDllfJxrCUdiMutx7WjowL8Nf9igvKx/0rndI4zaUqVRPrYtt/6
	NAYpNUzIhmBGrB+Vp3t4J/lEuiIP7PKJ+cClyNci2rfj6/58Jp8cyBBu8Izj4I=
X-Google-Smtp-Source: AGHT+IGG/t7PjiinfWcRs1DqA4NC5z/0CB4WM1MUP7WS+n4KcCWyWT83JWfzTPgWrsy6xhHQJlYwvA==
X-Received: by 2002:a17:906:1da1:b0:aa6:33cf:b389 with SMTP id a640c23a62f3a-aa63a09beffmr1047699166b.34.1733742446734;
        Mon, 09 Dec 2024 03:07:26 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:26 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Dec 2024 12:07:19 +0100
Subject: [PATCH 5/7] refs: introduce the `ref_transaction_update_reflog`
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-5-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12796;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=7cR6epBjK5+cted6JKC8pV6nxzM8nDK5/Q4THQFp+hU=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnVs9nUC4aA8kuB8KWiMLJcOQXW2odEaMtyO/7c
 GMgwsFceEyJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZwAKCRA+1Z8kjkaM
 f02KC/4ud6Ozt2iAZW1hKiN2SXGyAcmvRKvS235hyF7IquCU0NZwKqapBplNOWwnMvkT7ioomgc
 gQ3YZMCW1+kYSW4yIF6y6fTjO7UHxOHcO1buL5F/LmcLAgLHGtbTbTEUY0Lkl82OLurBPM/t7Dt
 c0YzfyQIb4+etVhP/SMIp3cVApCfPVrvAhMmyyfdm6C2xodisnA0bUBqX8TQbB3ygmDfxOJ3q8C
 xHwhvM8NX0b2FtP4ySals/S9SOCivjDr91gvgT/5MJbsCQHNKXJlxZKEqpmlIsC6z68/LDitphb
 lhF3yvhavZo/9Oj2MAUSQeMQhBr37iNfwjJ5H7G9BDXvU6sBp9RBDC7zosqF1kVocfXOwQ9aqOC
 ivhQUt81O7EBFl/lJoTd11itiogs3YDIJxQ5ty5K8Ule3/KQ8Yu3w4qWWN0YKwwgUGvUqQKyClu
 TH+krJnGoL64vgqYPAMlqdjtZgO4Nlrm6N7aosGVh5BXCDExISIfyah+KMTCwJpFz73cI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a new function `ref_transaction_update_reflog`, for clients to
add a reflog update to a transaction. While the existing function
`ref_transaction_update` also allows clients to add a reflog entry, this
function does a few things more, It:
  - Enforces that only a reflog entry is added and does not update the
  ref itself.
  - Allows the users to also provide the committer information. This
  means clients can add reflog entries with custom committer
  information.

A follow up commit will utilize this function to add reflog support to
`git refs migrate`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 89 +++++++++++++++++++++++++++++++++++++------------
 refs.h                  | 12 +++++++
 refs/files-backend.c    | 48 +++++++++++++++-----------
 refs/refs-internal.h    | 16 +++++----
 refs/reftable-backend.c |  6 ++--
 5 files changed, 122 insertions(+), 49 deletions(-)

diff --git a/refs.c b/refs.c
index 732c236a3fd0cf324cc172b48d3d54f6dbadf4a4..602a65873181a90751def525608a7fa7bea59562 100644
--- a/refs.c
+++ b/refs.c
@@ -1160,13 +1160,15 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-struct ref_update *ref_transaction_add_update(
-		struct ref_transaction *transaction,
-		const char *refname, unsigned int flags,
-		const struct object_id *new_oid,
-		const struct object_id *old_oid,
-		const char *new_target, const char *old_target,
-		const char *msg)
+struct ref_update *ref_transaction_add_update(struct ref_transaction *transaction,
+					      const char *refname,
+					      unsigned int flags,
+					      const struct object_id *new_oid,
+					      const struct object_id *old_oid,
+					      const char *new_target,
+					      const char *old_target,
+					      const char *committer_info,
+					      const char *msg)
 {
 	struct ref_update *update;
 
@@ -1190,8 +1192,15 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if ((flags & REF_HAVE_OLD) && old_oid)
 		oidcpy(&update->old_oid, old_oid);
-	if (!(flags & REF_SKIP_CREATE_REFLOG))
+	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
+		if (committer_info) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addstr(&sb, committer_info);
+			update->committer_info = strbuf_detach(&sb, NULL);
+		}
+
 		update->msg = normalize_reflog_message(msg);
+	}
 
 	return update;
 }
@@ -1199,20 +1208,29 @@ struct ref_update *ref_transaction_add_update(
 static int transaction_refname_verification(const char *refname,
 					    const struct object_id *new_oid,
 					    unsigned int flags,
+					    unsigned int reflog,
 					    struct strbuf *err)
 {
 	if (flags & REF_SKIP_REFNAME_VERIFICATION)
 		return 0;
 
 	if (is_pseudo_ref(refname)) {
-		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
-			    refname);
+		if (reflog)
+			strbuf_addf(err, _("refusing to update reflog for pseudoref '%s'"),
+				    refname);
+		else
+			strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+				    refname);
 		return -1;
 	} else if ((new_oid && !is_null_oid(new_oid)) ?
 		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 		 !refname_is_safe(refname)) {
-		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
-			    refname);
+		if (reflog)
+			strbuf_addf(err, _("refusing to update reflog with bad name '%s'"),
+				    refname);
+		else
+			strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
+				    refname);
 		return -1;
 	}
 
@@ -1238,7 +1256,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	ret = transaction_refname_verification(refname, new_oid, flags, err);
+	ret = transaction_refname_verification(refname, new_oid, flags, 0, err);
 	if (ret)
 		return ret;
 
@@ -1255,18 +1273,47 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
-	ref_transaction_add_update(transaction, refname, flags,
-				   new_oid, old_oid, new_target,
-				   old_target, msg);
+	ref_transaction_add_update(transaction, refname, flags, new_oid,
+				   old_oid, new_target, old_target, NULL, msg);
+	return 0;
+}
+
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info, unsigned int flags,
+				  const char *msg, unsigned int index,
+				  struct strbuf *err)
+{
+	struct ref_update *update;
+	int ret;
+
+	assert(err);
+
+	ret = transaction_refname_verification(refname, new_oid, flags, 1, err);
+	if (ret)
+		return ret;
+
+	flags |= REF_LOG_ONLY | REF_NO_DEREF;
+
+	update = ref_transaction_add_update(transaction, refname, flags,
+					    new_oid, old_oid, NULL, NULL,
+					    committer_info, msg);
+	/*
+	 * While we do set the old_oid value, we unset the flag to skip
+	 * old_oid verification which only makes sense for refs.
+	 */
+	update->flags &= ~REF_HAVE_OLD;
+	update->index = index;
+
 	return 0;
 }
 
 int ref_transaction_create(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const char *new_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+			   const char *refname, const struct object_id *new_oid,
+			   const char *new_target, unsigned int flags,
+			   const char *msg, struct strbuf *err)
 {
 	if (new_oid && new_target)
 		BUG("create called with both new_oid and new_target set");
diff --git a/refs.h b/refs.h
index a5bedf48cf6de91005a7e8d0bf58ca98350397a6..b86d2cd87be33f7bb1b31fce711d6c7c8d9491c9 100644
--- a/refs.h
+++ b/refs.h
@@ -727,6 +727,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
+/*
+ * Similar to `ref_transaction_update`, but this function is only for adding
+ * a reflog updates. Supports providing custom committer information.
+ */
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info, unsigned int flags,
+				  const char *msg, unsigned int index,
+				  struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9c929c1ac33bc62a75620e684a809d46b574f1c6..32975e0fd7a03ab8ddf99c0a68af99921d3f5090 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1268,10 +1268,10 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	transaction = ref_store_transaction_begin(&refs->base, 0, &err);
 	if (!transaction)
 		goto cleanup;
-	ref_transaction_add_update(
-			transaction, r->name,
-			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(), &r->oid, NULL, NULL, NULL);
+	ref_transaction_add_update(transaction, r->name,
+				   REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD |
+				   REF_IS_PRUNING, null_oid(), &r->oid, NULL,
+				   NULL, NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
@@ -2418,7 +2418,7 @@ static int split_head_update(struct ref_update *update,
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			NULL, NULL, update->committer_info, update->msg);
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2482,7 +2482,8 @@ static int split_symref_update(struct ref_update *update,
 			transaction, referent, new_flags,
 			update->new_target ? NULL : &update->new_oid,
 			update->old_target ? NULL : &update->old_oid,
-			update->new_target, update->old_target, update->msg);
+			update->new_target, update->old_target, NULL,
+			update->msg);
 
 	new_update->parent_update = update;
 
@@ -2911,11 +2912,11 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					packed_transaction;
 			}
 
-			ref_transaction_add_update(
-					packed_transaction, update->refname,
-					REF_HAVE_NEW | REF_NO_DEREF,
-					&update->new_oid, NULL,
-					NULL, NULL, NULL);
+			ref_transaction_add_update(packed_transaction,
+						   update->refname,
+						   REF_HAVE_NEW | REF_NO_DEREF,
+						   &update->new_oid, NULL, NULL,
+						   NULL, NULL, NULL);
 		}
 	}
 
@@ -3080,10 +3081,12 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		}
 
 		/*
-		 * packed-refs don't support symbolic refs and root refs, so we
-		 * have to queue these references via the loose transaction.
+		 * packed-refs don't support symbolic refs, root refs and reflogs,
+		 * so we have to queue these references via the loose transaction.
 		 */
-		if (update->new_target || is_root_ref(update->refname)) {
+		if (update->new_target ||
+		    is_root_ref(update->refname) ||
+		    (update->flags & REF_LOG_ONLY)) {
 			if (!loose_transaction) {
 				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
 				if (!loose_transaction) {
@@ -3092,15 +3095,22 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 				}
 			}
 
-			ref_transaction_add_update(loose_transaction, update->refname,
-						   update->flags & ~REF_HAVE_OLD,
-						   update->new_target ? NULL : &update->new_oid, NULL,
-						   update->new_target, NULL, NULL);
+			if (update->flags & REF_LOG_ONLY)
+				ref_transaction_add_update(loose_transaction, update->refname,
+							   update->flags, &update->new_oid,
+							   &update->old_oid, NULL, NULL,
+							   update->committer_info, update->msg);
+			else
+				ref_transaction_add_update(loose_transaction, update->refname,
+							   update->flags & ~REF_HAVE_OLD,
+							   update->new_target ? NULL : &update->new_oid, NULL,
+							   update->new_target, NULL, update->committer_info,
+							   NULL);
 		} else {
 			ref_transaction_add_update(packed_transaction, update->refname,
 						   update->flags & ~REF_HAVE_OLD,
 						   &update->new_oid, &update->old_oid,
-						   NULL, NULL, NULL);
+						   NULL, NULL, update->committer_info, NULL);
 		}
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f5c733d099f0c6f1076a25f4f77d9d5eb345ec87..82c1387d1e6ab3658b31fe99c95f98645ff1ebf1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -156,13 +156,15 @@ int ref_update_reject_duplicates(struct string_list *refnames,
  * dereferenced if the REF_HAVE_NEW and REF_HAVE_OLD bits,
  * respectively, are set in flags.
  */
-struct ref_update *ref_transaction_add_update(
-		struct ref_transaction *transaction,
-		const char *refname, unsigned int flags,
-		const struct object_id *new_oid,
-		const struct object_id *old_oid,
-		const char *new_target, const char *old_target,
-		const char *msg);
+struct ref_update *ref_transaction_add_update(struct ref_transaction *transaction,
+					      const char *refname,
+					      unsigned int flags,
+					      const struct object_id *new_oid,
+					      const struct object_id *old_oid,
+					      const char *new_target,
+					      const char *old_target,
+					      const char *committer_info,
+					      const char *msg);
 
 /*
  * Transaction states.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index c008f20be719fec3af6a8f81c821cb9c263764d7..b2e3ba877de9e59fea5a4d066eb13e60ef22a32b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1078,7 +1078,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			new_update = ref_transaction_add_update(
 					transaction, "HEAD",
 					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
+					&u->new_oid, &u->old_oid, NULL, NULL, NULL,
+					u->msg);
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
@@ -1161,7 +1162,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					transaction, referent.buf, new_flags,
 					u->new_target ? NULL : &u->new_oid,
 					u->old_target ? NULL : &u->old_oid,
-					u->new_target, u->old_target, u->msg);
+					u->new_target, u->old_target,
+					u->committer_info, u->msg);
 
 				new_update->parent_update = u;
 

-- 
2.47.1

