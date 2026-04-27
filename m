Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BF3B4EAA
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286544; cv=none; b=ZVdbfaYjSesuatFnraQCzWqa4wgnnMe3l+iskjYZ05UU6QqCIaOPPKTEAIQY18/2301kNuohHOKo0HxzSzs2wHEf4kY8PpG2Sr427TkKsiV7Qjt392EruAUocm9GfDh9zopDTcxz3AH7wnBGzduhXUFECCk1m9/LP1E9I+IHbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286544; c=relaxed/simple;
	bh=k9svHdq0lQSCWEh45LT4YsUdrz3nCE3ahcL9UGuSFXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9wgGGTOw/8hwU7JKAWzLTOskQbVfc4+HEKKt1sWwjXi+7G5SBE33ybuL6wVNulPN9xRYweD7HkTAd/IibZAkDzOD1hq/1AGa2Xmo52fp/qG1cgDk3sMQc5n9j4lnLk+m3nopD1bKGaQIdssTyhrDU+fEigHjMfbM8XwstFctdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFAUzvZ/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFAUzvZ/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so8350942f8f.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286540; x=1777891340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/bjrW73Qp936EmsDjfTk6kXpsbUOP4FCBt8ieStDys=;
        b=AFAUzvZ//W2PpZFt+J4unMrHL1QUd5i26Wya5dGefmRObwQyj85OxZPhnmRCZhfW9l
         Lrr0lmMnmGNxSCYgEb4rbRSkSccuyeSv7d8INAZpdNt8CTuNZyNZ9+QrehyM+JIZCdF6
         mM2BEWwDEOfNvL7RpN/lrx3thMKM1R9fEwedoz6VnqBrafjCcroCmHcB/QHUfbaavjWZ
         I/m0aVXAmOwMw4sApplhl7YtEeXp50u+KN09KtuOCt/DNhGR1HYIgsGtL1ZMv+emG98y
         lq8hQHcjaB1M7rhrlRMtXSfKNEgjzAN+4CZ7CUGwacLWg5VIKUq1wmhQBbJtHJCeZNRr
         SuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286540; x=1777891340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/bjrW73Qp936EmsDjfTk6kXpsbUOP4FCBt8ieStDys=;
        b=Nj2j63MKoRL21CyKypfQOEdKPRSObWZmmO3W1LBc7ptebWcHBFqnpq5nm6jXeoaC1z
         b+/dfBtlS4W95iSIoZH84z03j6iy9CPTI2c/XxsWCTw2Kn8ZPP8hkLiCIdzUMmMD5qNP
         CuXiaqv0GOfNaoTRMR3dtsN7Hp3eQz1yVX+L9nLuje+/cqfXVa0mRFNaeRwC+0SfRef3
         vGlPkZuKrvDm7wB4EA68EyTdcAIRrGp468+Y6gQ7QsZXeA9OPRSIjmCeogvCNG9gFobr
         ehjhavbZOrTGretyFxC3LUHY3d8RLAB/5jX3wtsg6qkfBgsbcJV1GIotfdFh3cciLF99
         /s1A==
X-Gm-Message-State: AOJu0Ywu9G/jSiwh+njeWe08NC/ATu1oeJ3UAUhxI05UMrlw3ExeGiKY
	XqEJ87FX+4llhf31y6ScQ596Y66NAc/J/gTPjEooSFhBbm10p2+/yvNU6wXETg==
X-Gm-Gg: AeBDiethoE00ih87nV0VIe/LlFkq2I5p9NTbJ1yT3N/gDHLfY/c7vuODweIZ+oXDgje
	jiONEtA6ZWp4xpHpgbyEzWbb4uIQUIGLozZCFggwSwBS1IBqdEPvy2wpYNGfjmdKn8+eiYGflFr
	hwIb7DlQQCgOhKT0D9XLBdoFhMbamDLUtvXrXHu60xJsgTnfnZ5FKjZP53DjUMdyPkUqPSu2TRx
	RuaS/vggKY+AQYPTcTvMixxrr65Sla68ETXupqCat7ciZiDLQWpSaiFYrychQHokn8S3FhIVMSK
	wmsqG54LqaH05n1YfOqdL4o4prtSGrS9jKdVWpnBeqIBtUk/bLgq6Ny/sspiWsOmETAlA8ipUp8
	eNCNVTo2F+8z396rmQtg4aOg+LG9X+OTGZV1x+ouJXgogobOytbwDEQ2EB5Z96zdT/w/6BL+KUw
	bbgqPlbYl24ZoDqcuHymlTwCHU+3fwoZ88N/jaOVJ1
X-Received: by 2002:a05:6000:290b:b0:441:1fa5:457f with SMTP id ffacd0b85a97d-4411fa54aecmr41169428f8f.28.1777286540108;
        Mon, 27 Apr 2026 03:42:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:09 +0200
Subject: [PATCH v3 8/9] refs: add peeled object ID to the `ref_update`
 struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-8-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8668; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=k9svHdq0lQSCWEh45LT4YsUdrz3nCE3ahcL9UGuSFXQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPYDPIV2bN0j09O8yrlhZNSYUz91gvElJT
 EdL97+L5YyllokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z2AAAoJED7VnySO
 Rox/+oIL/jzfO1iKyCEGB+1hqUTnhx2fJr1C1ig6HcyKJdILbVza8EHk1EkTFS1kTqIhHo29XJ3
 LsEMVd/TZMfMIn168M72uwsks5zatPI5ntA6EBJIUIvZycpyfv4vCXUTZBLVMs/cHCo8Lr8NSJr
 QLJ7Jh9RITPLO0KVbvyzvRTBrsQldCBNTi9UqUmZvllwDSZ/rmwyOiT1twD9AT5OXP7xTNEf5Ix
 Z/RCpKdRsI5J5o+mulULvYU1R3/BhBUSYTfs994aL98ETQEbYhR2Fagzr4vakOTDmh1ItaAjHcy
 XYOoDUZ410CKwfp7OJwmFbcJESxnZXyRvhXJrydLxZJsBvDjVaUc309/Jr3iNJJyLXKXbu+ZEM3
 bBcZS29vjeQfnW1gz1TWkTiaTpZhPwT4CC8+BqKyqlJkGHDUgM6XtOYMi94qvar8JMjglm/NwRZ
 KR69zb/k78ozg2w8cDbgrgfJJnpNR51Vcpv+D8JyyV7dFiGcYXaKHk9doWiSHQzGjTWDzUpldF5
 fQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Certain reference backends {packed, reftable}, have the ability to also
store the peeled object ID for a reference pointing to a tag object.
This has the added benefit that during retrieval of such references, we
also obtain the peeled object ID without having to use the ODB.

To provide this functionality, each backend independently calls the ODB
to obtain the peeled OID. To move this functionality to the generic
layer, there must be support infrastructure to pass in a peeled OID for
reference updates.

Add a `peeled` field to the `ref_update` structure and modify
`ref_transaction_add_update()` to receive and copy this object ID to the
`ref_update` structure. Finally, modify `ref_transaction_update()` to
peel tag objects and pass the peeled OID to
`ref_transaction_add_update()`.

Update all callers of these functions with the new function parameters.
Callers which only add reflog updates, need to only pass in NULL, since
for reflogs, we don't store peeled OIDs. Reference deletions also only
need to pass in NULL. For others, pass along the peeled OID if
available.

In a following commit, we'll modify the backends to use this peeled OID
instead of parsing it themselves.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 15 +++++++++++++--
 refs/files-backend.c    | 20 ++++++++++++--------
 refs/refs-internal.h    | 14 ++++++++++++++
 refs/reftable-backend.c |  6 +++---
 4 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 662a9e6f9e..0648df2b6c 100644
--- a/refs.c
+++ b/refs.c
@@ -1307,6 +1307,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const struct object_id *peeled,
 		const char *new_target, const char *old_target,
 		const char *committer_info,
 		const char *msg)
@@ -1339,6 +1340,8 @@ struct ref_update *ref_transaction_add_update(
 		update->committer_info = xstrdup_or_null(committer_info);
 		update->msg = normalize_reflog_message(msg);
 	}
+	if (flags & REF_HAVE_PEELED)
+		oidcpy(&update->peeled, peeled);
 
 	/*
 	 * This list is generally used by the backends to avoid duplicates.
@@ -1392,6 +1395,8 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 						  unsigned int flags, const char *msg,
 						  struct strbuf *err)
 {
+	struct object_id peeled;
+
 	assert(err);
 
 	if ((flags & REF_FORCE_CREATE_REFLOG) &&
@@ -1432,10 +1437,16 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 				    oid_to_hex(new_oid), refname);
 			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
+
+		if (o->type == OBJ_TAG) {
+			if (!peel_object(transaction->ref_store->repo, new_oid, &peeled,
+					 PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE))
+				flags |= REF_HAVE_PEELED;
+		}
 	}
 
 	ref_transaction_add_update(transaction, refname, flags,
-				   new_oid, old_oid, new_target,
+				   new_oid, old_oid, &peeled, new_target,
 				   old_target, NULL, msg);
 
 	return 0;
@@ -1462,7 +1473,7 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 		return -1;
 
 	update = ref_transaction_add_update(transaction, refname, flags,
-					    new_oid, old_oid, NULL, NULL,
+					    new_oid, old_oid, NULL, NULL, NULL,
 					    committer_info, msg);
 	update->index = index;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f20f580fbc..d0896d0e37 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1325,7 +1325,8 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(the_hash_algo), &r->oid, NULL, NULL, NULL, NULL);
+			null_oid(the_hash_algo), &r->oid, NULL, NULL, NULL,
+			NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
@@ -2468,7 +2469,7 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF | REF_LOG_VIA_SPLIT,
-			&update->new_oid, &update->old_oid,
+			&update->new_oid, &update->old_oid, &update->peeled,
 			NULL, NULL, update->committer_info, update->msg);
 	new_update->parent_update = update;
 
@@ -2530,8 +2531,8 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
 			transaction, referent, new_flags,
 			update->new_target ? NULL : &update->new_oid,
 			update->old_target ? NULL : &update->old_oid,
-			update->new_target, update->old_target, NULL,
-			update->msg);
+			&update->peeled, update->new_target, update->old_target,
+			NULL, update->msg);
 
 	new_update->parent_update = update;
 
@@ -2994,7 +2995,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			ref_transaction_add_update(
 					packed_transaction, update->refname,
 					REF_HAVE_NEW | REF_NO_DEREF,
-					&update->new_oid, NULL,
+					&update->new_oid, NULL, NULL,
 					NULL, NULL, NULL, NULL);
 		}
 	}
@@ -3200,19 +3201,22 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 			if (update->flags & REF_LOG_ONLY)
 				ref_transaction_add_update(loose_transaction, update->refname,
 							   update->flags, &update->new_oid,
-							   &update->old_oid, NULL, NULL,
+							   &update->old_oid, &update->peeled,
+							   NULL, NULL,
 							   update->committer_info, update->msg);
 			else
 				ref_transaction_add_update(loose_transaction, update->refname,
 							   update->flags & ~REF_HAVE_OLD,
 							   update->new_target ? NULL : &update->new_oid, NULL,
-							   update->new_target, NULL, update->committer_info,
+							   &update->peeled, update->new_target,
+							   NULL, update->committer_info,
 							   NULL);
 		} else {
 			ref_transaction_add_update(packed_transaction, update->refname,
 						   update->flags & ~REF_HAVE_OLD,
 						   &update->new_oid, &update->old_oid,
-						   NULL, NULL, update->committer_info, NULL);
+						   &update->peeled, NULL, NULL,
+						   update->committer_info, NULL);
 		}
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d103387ebf..307dcb277b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -39,6 +39,13 @@ struct ref_transaction;
  */
 #define REF_LOG_ONLY (1 << 7)
 
+/*
+ * The reference contains a peeled object ID. This is used when the
+ * new_oid is pointing to a tag object and the reference backend
+ * wants to also store the peeled value for optimized retrieval.
+ */
+#define REF_HAVE_PEELED (1 << 15)
+
 /*
  * Return the length of time to retry acquiring a loose reference lock
  * before giving up, in milliseconds:
@@ -92,6 +99,12 @@ struct ref_update {
 	 */
 	struct object_id old_oid;
 
+	/*
+	 * If the new_oid points to a tag object, set this to the peeled
+	 * object ID for optimized retrieval without needed to hit the odb.
+	 */
+	struct object_id peeled;
+
 	/*
 	 * If set, point the reference to this value. This can also be
 	 * used to convert regular references to become symbolic refs.
@@ -169,6 +182,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const struct object_id *peeled,
 		const char *new_target, const char *old_target,
 		const char *committer_info,
 		const char *msg);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 444b0c24e5..b0c010387d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1107,8 +1107,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		ref_transaction_add_update(
 			transaction, "HEAD",
 			u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-			&u->new_oid, &u->old_oid, NULL, NULL, NULL,
-			u->msg);
+			&u->new_oid, &u->old_oid, &u->peeled, NULL, NULL,
+			NULL, u->msg);
 	}
 
 	ret = reftable_backend_read_ref(be, rewritten_ref,
@@ -1194,7 +1194,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 				transaction, referent->buf, new_flags,
 				u->new_target ? NULL : &u->new_oid,
 				u->old_target ? NULL : &u->old_oid,
-				u->new_target, u->old_target,
+				&u->peeled, u->new_target, u->old_target,
 				u->committer_info, u->msg);
 
 			new_update->parent_update = u;

-- 
2.53.GIT

