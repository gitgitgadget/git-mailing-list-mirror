Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31EB393DD1
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679956; cv=none; b=P2Ay4W8kqE0jCUQ54T+ItVG68WhRzvGlcE2G3DvMKhQyqeSInLQW5konFgLOwGC3OaXuod9wVB9woJZtAQTeX2EbPDWqWNwfKxpC5uL0OKWxtHJv/Ci5Pljau6OTXvXF8UyN4jt5WxnkiqV1Guguaz/SA4N8KNggF3o5z5S89Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679956; c=relaxed/simple;
	bh=btAHqV4lAY5So/xsSjs2s9Xx85jGeydWY9vlzhZ4B80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BdslfaW/5SYMA7q4DqCi3FPz8H4LeyVfvC3SdRBt3HpUMhPzt+Pkwwlfg0gkwOxSdYQ7ky3F5Veg7MaVv9cO/w5o2D3zqSuxugcGi0FuP2v6bKB6yXu3pyxa8atlugywrl4WSsFWyLlbcCUW9G6U74ub13zKlENVQX9hpBIypp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgcEfiuG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgcEfiuG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfce3a195so1746588f8f.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679952; x=1777284752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+uO3h+SGTvHW0FNsX3o1j0oqEsV79iBAq9N33ODQ4s=;
        b=NgcEfiuGkhVCdoh/0FDtZz1AiiK5x6L1M7q04QalJ1vtthnzhzDcIQWbXO53SM3sAk
         g4TyU3KIzaPfZ8sp3FguKjmbPgskXDkT5dgpqrWBNtkQXZ8SROC5UvbstNb+z/+p20Dg
         97rVabepS/x38cyDXDwPtOvNrZeSVnBzoYEs6K9muw2zaTsv4asqgox+8sHc4EYHCT6k
         04zytNHOxzKfx+495N8agEUAi7hEUgTC9PZERt94C8MiRR+leX/A8bP4nGwmY9PTMY+X
         F6jnHFihcsrBjsekIZoQO5E8mVGGVe5l0esyQ4Mgf9qhDuoDUErIs94xGxYNOvYEEoVh
         ZaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679952; x=1777284752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+uO3h+SGTvHW0FNsX3o1j0oqEsV79iBAq9N33ODQ4s=;
        b=NaPvhLywFSUA9nYvzWUbilyx0RDe1vQu4x4N2SNOKfWM/Dr2X5G+7rDR+2Yd19nJoI
         Iij5MZEKX537qOTPOkJoa93rhM1e1lE3xrygz8jUzQZwbYuN7XI0E9Rtd2F6R+1dxqek
         dJT6LDhKlsa3Ybi3ZA78IFw7oblGcEdkeX/2kUvr+ieC+BYdj1bW4efGdUmoHxOA39CH
         nSq7rCQjYgc9N4iSgQv30AXbbqzIRlgifcVNP4bcEei5RLyElUS/yuBix8h/oxnTkuWg
         YDMlFMScaSdnZFL/bi0jR6k+9NJlFTxJln3jpjBviF2XBKwGYLCjMJYqrwv0b0+EaZOO
         S9Gg==
X-Gm-Message-State: AOJu0Yw1S5cJ+xPzobtSbgQQbQakUU20FWfe2VFhZPBgaMKmBL5tvfBK
	KNkvnNUuZiDqim59GBANxmEvkHaS5yiqyQ/NfOXhF6BXqJ2Koqmnq2yFAH5+Mg==
X-Gm-Gg: AeBDievww1HYn4osdh+u7LcvfN7Xv6D9lB6m+oopNzbqatbV8sjrOjKVIqJO/Z7rdJ5
	T6jO8k3gdk0LzPWRTsK+BU2txzu9WSd3AMiYPZfhQA0PDZjv6eP5CN2fiX9fXnSGz3FtWwLFU1W
	kq1FzPEUHWdNVSf83iotHBxayFP1BVl1dKWJcEf2xmbCE0/u6o87or0beXwARMXcT6ayuwr6Vq0
	5BzeDTwAIbefCR8zPyc2QKOr3dGlaBLnJSRhtmoZRDIh8R2AxUREb7rtQKHinqNTKr9gzmi8Esk
	OI9L7UCmZM9DuqPVCM1aDbw1qW+MFEQb7ttXpijKkgubTlGyPf9akL1WgRjeqdveSaDJ3qu9kwR
	+I3iR39+kS8/xb42ia2zSIAvxvuKVDAzuwRd8gnuMQuTavGBvWrRlTb2uQRd3gQ6TkFA4iduIxy
	g/T+g2noEM1o/BA7RPJx5jfWwtSkx2ToKkAnv9U80=
X-Received: by 2002:a5d:588f:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43fe3dfd4aemr19095895f8f.39.1776679952005;
        Mon, 20 Apr 2026 03:12:32 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:12:04 +0200
Subject: [PATCH 6/8] refs: move object parsing to the generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-6-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8386; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=btAHqV4lAY5So/xsSjs2s9Xx85jGeydWY9vlzhZ4B80=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl/ACXmoZoEF7MhAPdLrjCPeaLh+HOelSWH
 zg+nD/iEpFg3YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fwAAAoJED7VnySO
 Rox/bvgL/3NZ1qdKxmIdWq3ccMxec5PHgV7o+OG+seEejHNZ9fKBrnWVdHI63VfkHZqN4lQyzl+
 W2HICI6ClNE05mMnVF1PPUtZbJjPG3mLrnyeHROAi76E5jbovQKX+O3EXZgM40FL7hvhwYxB93c
 YxhzA1+5hRwhFlzlpCWMbHmUMOxIaEt41TtZ7nc7voRRk3PuR/FuhMz7cstqniSQCa5JLON9ZA0
 O/1OBTuoJhHFAzKy5bQula/14+l9s833jA91iHA+2HMJwx1Tx/v/LDh961QRkkdABRVRNrf62ZL
 M93Kj0DYrrNBoWE8+T8pFe8mDvvca6UeOXSjA4QbHIX0Y2j+ycwskpQfPpPUG8TsxQ9HIJMMXXi
 l6Fw/hMcLm/8nj5+J1crDh7FVFrActHLFpI0rjvXvqu27u2yw3nsS3xrKz8vSt3zCqFeA9wmGU4
 7BOQ3f1NTj6uDL/CK76YZkK1vbKwCN6fHR+39BGA+lOjJTuXEJVHmuDQkdmS9SmgdOTQwxVVnJ8
 aU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Regular reference updates made via reference transactions validate that
the provided object ID exists in the object database, this is done by
calling 'parse_object()'. This check is done independently by the
backends.

Let's move this to the generic layer, ensuring the backends only have to
care about reference storage and not about validation of the object IDs.
With this also remove the 'REF_TRANSACTION_ERROR_INVALID_NEW_VALUE'
error type as its no longer used.

Since we don't iterate over individual references in
`ref_transaction_prepare()`, we add this check to
`ref_transaction_update()`. This means that the validation is done as
soon as an update is queued, without needing to prepare the
transaction. It can be argued that this is more ideal, since this
validation has no dependency on the reference transaction being
prepared.

It must be noted that the change in behavior means that this error
cannot be ignored even with usage of batched updates, since this happens
when the update is being added to the transaction. But since the caller
gets specific error codes, they can either abort the transaction or
continue adding other updates to the transaction.

Modify 'builtin/receive-pack.c' to now capture the error type so that
the error propagated to the client stays the same. Also remove two of
the tests which validates batch-updates with invalid new_oid.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c  | 22 +++++++++++++---------
 refs.c                  | 18 ++++++++++++++++++
 refs/files-backend.c    | 28 ++--------------------------
 refs/reftable-backend.c | 19 -------------------
 4 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 878aa7f0ed..0fb3d57de8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1641,8 +1641,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			ret = NULL; /* good */
 		}
 		strbuf_release(&err);
-	}
-	else {
+	} else {
+		enum ref_transaction_error err_type;
 		struct strbuf err = STRBUF_INIT;
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si)) {
@@ -1650,14 +1650,18 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			goto out;
 		}
 
-		if (ref_transaction_update(transaction,
-					   namespaced_name,
-					   new_oid, old_oid,
-					   NULL, NULL,
-					   0, "push",
-					   &err)) {
+		err_type = ref_transaction_update(transaction,
+						  namespaced_name,
+						  new_oid, old_oid,
+						  NULL, NULL,
+						  0, "push",
+						  &err);
+		if (err_type) {
 			rp_error("%s", err.buf);
-			ret = "failed to update ref";
+			if (err_type == REF_TRANSACTION_ERROR_GENERIC)
+				ret = "failed to update ref";
+			else
+				ret = ref_transaction_error_msg(err_type);
 		} else {
 			ret = NULL; /* good */
 		}
diff --git a/refs.c b/refs.c
index 39fef1cca0..bbe19155f4 100644
--- a/refs.c
+++ b/refs.c
@@ -1416,6 +1416,24 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
+	if ((flags & REF_HAVE_NEW) && !new_target && !is_null_oid(new_oid) &&
+	    !(flags & REF_SKIP_OID_VERIFICATION) && !(flags & REF_LOG_ONLY)) {
+		struct object *o = parse_object(transaction->ref_store->repo, new_oid);
+
+		if (!o) {
+			strbuf_addf(err,
+				    _("trying to write ref '%s' with nonexistent object %s"),
+				    refname, oid_to_hex(new_oid));
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
+		}
+
+		if (o->type != OBJ_COMMIT && is_branch(refname)) {
+			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
+				    oid_to_hex(new_oid), refname);
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
+		}
+	}
+
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
 				   old_target, NULL, msg);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 407b97cc44..0e2bbe37a0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -19,7 +19,6 @@
 #include "../iterator.h"
 #include "../dir-iterator.h"
 #include "../lockfile.h"
-#include "../object.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
@@ -1589,7 +1588,6 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
 							struct ref_lock *lock,
 							const struct object_id *oid,
-							int skip_oid_verification,
 							struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
@@ -1737,7 +1735,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1755,7 +1753,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto rollbacklog;
 	}
 
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, REF_SKIP_CREATE_REFLOG, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1999,32 +1997,11 @@ static int files_log_ref_write(struct files_ref_store *refs,
 static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
 							struct ref_lock *lock,
 							const struct object_id *oid,
-							int skip_oid_verification,
 							struct strbuf *err)
 {
 	static char term = '\n';
-	struct object *o;
 	int fd;
 
-	if (!skip_oid_verification) {
-		o = parse_object(refs->base.repo, oid);
-		if (!o) {
-			strbuf_addf(
-				err,
-				"trying to write ref '%s' with nonexistent object %s",
-				lock->ref_name, oid_to_hex(oid));
-			unlock_ref(lock);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
-			strbuf_addf(
-				err,
-				"trying to write non-commit object %s to branch '%s'",
-				oid_to_hex(oid), lock->ref_name);
-			unlock_ref(lock);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-	}
 	fd = get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), refs->base.repo->hash_algo->hexsz) < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
@@ -2828,7 +2805,6 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 		} else {
 			ret = write_ref_to_lockfile(
 				refs, lock, &update->new_oid,
-				update->flags & REF_SKIP_OID_VERIFICATION,
 				err);
 			if (ret) {
 				char *write_err = strbuf_detach(err, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bdc3e0aa19..fdf7336c0f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1081,25 +1081,6 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		return 0;
 	}
 
-	/* Verify that the new object ID is valid. */
-	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
-	    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
-	    !(u->flags & REF_LOG_ONLY)) {
-		struct object *o = parse_object(refs->base.repo, &u->new_oid);
-		if (!o) {
-			strbuf_addf(err,
-				    _("trying to write ref '%s' with nonexistent object %s"),
-				    u->refname, oid_to_hex(&u->new_oid));
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-
-		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
-			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
-				    oid_to_hex(&u->new_oid), u->refname);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-	}
-
 	/*
 	 * When we update the reference that HEAD points to we enqueue
 	 * a second log-only update for HEAD so that its reflog is

-- 
2.53.GIT

