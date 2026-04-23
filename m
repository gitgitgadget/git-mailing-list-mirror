Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626A3DFC65
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933651; cv=none; b=Xn9gYTX9zIuGH/gdty6a5d5XSJXoJyPRhSNHPbZWEsd0YkWWPXrgJy4ijV2HtfsHJdB9/jg195GEzBiRvl7HWrpeo486kz0sXOC2IwaMSGffuPgF3FywehVCrTrz7WJOlLnXT/XdQg5Yg5wpKZrP19yMrOlDtKOfFfb9WZbTKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933651; c=relaxed/simple;
	bh=jQ59ZUmwDaxcwtYMkldWrGwUN1ab94keehynBRbZQp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYqI5YlJmNUhFOFM7hgOU6L5x2dnLrxhR8LTjZJM2Kub037OJX4+p+4PxlA/ejcIldmyqoOxSd6eFZUn4rPnv5ydjGwxab8pHMyTi8Utgl0OxFZoeFc0qJQCGQTxxH8dw4hwZVeAAAJLPlq0hHZ4lo7hjCYUbT1cvzikdfoucPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLZU0axj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLZU0axj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so104069635e9.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933647; x=1777538447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gl/07pw2m2BgJSAL9BwA3crdB0Ux3ro4NkOlDmStpoY=;
        b=RLZU0axjpm/cMNwzKbbs+ykjq2oOPJ6VsU7JEvynvLAjKHXfog4RFlwCCSzjYFrNaU
         qpaRj9AiVvJMKVcM+/0bQOqn8RXAvPlpsVvg30O2Xn3HbLWep4xcpZu2InTcAdcUKCxy
         eKz7IcNDwRyPyZVrUTvsrgyUdcZkE767/TaQVTDCqbn+Mk4Iz+pp1769S6Eka5B3Kzo4
         727MXhasOhoP4GAWGOa/Jka0frwcZEKCqmF+7YcfMRdv5qvQLNZAjW0hW4jQtNwtR1El
         IFxJV1EpfyI1UDrXGcjE0SfAQ5BlhsFi4cJeCJ2qQtQ6vLNpMs0kk7mx7IlYgL/JWqYt
         WymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933647; x=1777538447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gl/07pw2m2BgJSAL9BwA3crdB0Ux3ro4NkOlDmStpoY=;
        b=R/EhtmypD4hrQ+kbRFPVkHJg1ZE+gHezyRZkcY3ernm1lCRMCXCT1DZMBlkbpIi6p7
         yRz3CcXRiYNbcuwnomSrU2FTP9dTCGuT40syEly+VhoVS/rZhJ2/UwoFH+Y8xl3QHgli
         eBOvobly0nI+8RALWSuPKnFVM9xEAJLzQWWXaNpwSE7dIeEUDl536bRUZZbbBgAqSdKP
         sgG2cLvPSEfmzE+a9C3iC8MmwMEs01unVFFqkmnaagT98NWG+Gi7PfpaVa9pgqZgSG+2
         9EhhM3sj0o9HRRlPF6NF6geLxy6huWMF0PQhgP6AvF8FFjV51XXkY+1HgeqDzpdtq7hr
         Ejkw==
X-Gm-Message-State: AOJu0YyuMu1gm4S1sF9KQ42D13jxamLo6p+DBjOYnvtLRZCRiOMct4es
	n//HbJQighW6uL+RU3Ba/DClk+SRZZntVJkejCqD0owCavxunIzED4vknAW+9g==
X-Gm-Gg: AeBDietBML7k/46eAe/hlHq63jTiX1ZhcAqiR5M032V+MKBY4rVFL4MB32W5Xa+oWSO
	0Mm/h19OEKYv1V//UJHhZD3cBN+68YCjoi3JFno642iu0Gkl+0HX3sj4MvWTc1NNoHhCzLGcko3
	ucCBDlb/MzZ6mDoqP/ug3pt3Uiw69P0lXltZBngNSE6Fs/cuWlGPRhMquzd3Y9D2m7/ms33r+Df
	spCv8sQXAzwsaz1xDXvwIJM+Kp4crWKFHCLpouuu9v01UUYBSUzhy9tHmmmyAeLyZybtHP0TwGI
	HsjkKl0QpR4qSPcduSJqWvx1YsFxHUgTH3kBAbIDphIXHB1N3Z5BgeUB0ZFnOiTEa/IC37AVFwF
	OLYWG5HQAOakvha2xueEe2hKNIZu6B/ZifzZ46EhL4oomQ0O92UFDwNyCgK/U0jv7xl7mHS5ieg
	vWVXEEFFRdmTK+bk8WwAryA6AlcOE6wFJtxGdfNv9B
X-Received: by 2002:a05:600c:33aa:b0:488:ae6c:42c0 with SMTP id 5b1f17b1804b1-488fb742e7fmr226935455e9.7.1776933647367;
        Thu, 23 Apr 2026 01:40:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:37 +0200
Subject: [PATCH v2 8/9] refs: add peeled object ID to the `ref_update`
 struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-8-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8667; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jQ59ZUmwDaxcwtYMkldWrGwUN1ab94keehynBRbZQp8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wX+eL1iTggZoDjYBRMOmUrGhdUlGSC7V
 +ruxswKq/wlTokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsFAAoJED7VnySO
 Rox/0/cMAI1MM48cB/9mjFlqUj+ZK+1bynmzzo81T3kgSL7pyojdpUhbAMWhO7BQkpfD3y8B23F
 7moe4sAfDHGjt7etT2KNIezKxZUxfO7RoX3HRmgvNa5h6yihkZqIT3sF8D4fzyb5U1JZG46CpAW
 uea6iDF+uCxfn7sBX4xDwKui96mbhZrE0YIzbQirpVjZgeof7zaQQqD5ohhJQnjvvwl2eUouFWr
 F+1B50J481oGUnSFk5DhkGASd97i9y6RD40c9oHh5su17Gj2Gyco5NyLkRvta3ZAUJkOk7O+36y
 MQqMCAYFGXG1xCqksRBObTqtvwlfI9ceSC+Ma9ameB5H/ri+ioGji5/Kz0nTOy4fhS68pDxEn6R
 MOLqzVOifZC/4UXb60G+MCax/JC7X1fRnq1PBjkb8P53mpG6vSmwVCQQdQm9KFJXSBaX31EOxak
 SytWDVbtu8enaEvkZkn/PBjIENHnaCbFzwI71ZW0BtogcLC/vnTc4wGmilgPSOBXFpiWeCM7SO5
 QM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Certain reference backend {packed, reftable}, have the ability to also
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
index 6da0cb4f1b..2ed1082d56 100644
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

