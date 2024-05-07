Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099615ECCF
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086755; cv=none; b=NWRXdxVGYSp00e+9VQigPquvM49JMdWBM/s9cHsi2tKy0MB2bl6gifQxCy4f/7Kv8DUJsvGX1GXtPazd6uDMKk6Sfo25dFGAnoAs57RZbq4ti+uNgGgw+ddbY+q9ZFIONbmwnvNYWlmBjVq1pq8ljUJOq03z1E8mkdtBTvfCdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086755; c=relaxed/simple;
	bh=cJ9TwxCzQnr0OEebLihro9yJXI4X+kmqw3mrR+XUWTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBOfS6yKxCy1bOi9Rjy623e3hg6VN2cwM1JIIFOBghkPoheW9njTkcb8PeZlS0cXp3UcaROg49JmgoFUjaAGhQ9f2jhwJ6+RPu2vnrD80JkgKmJ608jTJoASb/4vy6zYMdFPiKRtfVt4yvYh+2d9vLCzytazb0BK4coD/X21d9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl+klOrs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl+klOrs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34db6a29998so1801757f8f.0
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086752; x=1715691552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvNmEzsByHto8KVp+Yo82fhdy5ahfz+mIeolAD6GmUo=;
        b=Wl+klOrsEGWs3x/NZvfp8qjll8jPwoUNg7cEzz4rbY6hPWdI9CtTnW8K8BTN8v37oA
         Kc6qRNjDuRvSlpznHcegrG2gzcjgE89xFVrPYENUaFRvmUsXLshBMR6NNCSXVtGurWO9
         iWl4956FDvrg8+Y4MQ67sOKwj8cbE2KfjlNa9Hfux1AOPwALhdkHAjAfnAROYwo/7pOp
         mwPApVID6/VsnQI4O8E0r8S2C2oaEoPFZW4Qa7G7XP1x9ycLBh3Si6rHh71DqwkO4gRA
         mdiBTP6u/64U+Ypih5iXCArORDhfLyjTukgrvr0ko3x1znuFWQ9mh4xXFBplbwzOmY4h
         Agag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086752; x=1715691552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvNmEzsByHto8KVp+Yo82fhdy5ahfz+mIeolAD6GmUo=;
        b=LkWc0/4OitQkQ18cDgdz1GdW0VBTCd1ueaOD93CJrQ9mBPZHGA0y5sjkrxxFmjbHbE
         OZJWqPZ5lMW4BzEIeMOyc9ASPyuukFCYkbzG8RPNRGQMEqsH29dj6rxafPnj3iQQm6ZR
         iwHGmZAFerAEgaN5KQTNB+nnqMCpsEXn7x1YG1UX5btdrWwhyhFVPr/Q9uwN8R6GO2V9
         hvYoULJOwWbLlx4YqeqaGNB4hB/nJ+8RMWuB4kJtRpmsJIQ8a7EeD2DxEnyh8aWGu3t2
         +/CNr2pb2NdnK28ufSL6FBSnPpuZBrKvJ+HQejpRrBCv6CBWi+4lww2ABVcTZCtpCuJg
         d8HQ==
X-Gm-Message-State: AOJu0YzYMEVRvNK4XC7OJcEdoYunBcAeVfglAHANh4AmUkn/zKYttHo7
	muJ9y07NltvKgluuaWDbtwLHRAudUL3f/U119GwC/GYujFTXbSBd
X-Google-Smtp-Source: AGHT+IGXvIcfok1qdLuJ565B5u2gqU7lcV9Jiu3MHkunoIgp3P/ttZCItr+T78Y0KjMTmBE3YFw/5A==
X-Received: by 2002:adf:ef0f:0:b0:34e:89ef:d02a with SMTP id e15-20020adfef0f000000b0034e89efd02amr7771178wro.22.1715086752065;
        Tue, 07 May 2024 05:59:12 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 4/8] refs: move `original_update_refname` to 'refs.c'
Date: Tue,  7 May 2024 14:58:55 +0200
Message-ID: <20240507125859.132116-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com>
References: <20240507060035.28602-1-knayak@gitlab.com>
 <20240507125859.132116-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The files backend and the reftable backend implement
`original_update_refname` to obtain the original refname of the update.
Move it out to 'refs.c' and only expose it internally to the refs
library. This will be used in an upcoming commit to also introduce
another common functionality for the two backends.

We also rename the function to `ref_update_original_update_refname` to
keep it consistent with the upcoming other 'ref_update_*' functions
that'll be introduced.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  9 +++++++++
 refs/files-backend.c    | 21 +++++----------------
 refs/refs-internal.h    |  5 +++++
 refs/reftable-backend.c | 24 +++++++-----------------
 4 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index 9d722d798a..8de43dc0fc 100644
--- a/refs.c
+++ b/refs.c
@@ -2814,3 +2814,12 @@ int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
 {
 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
+
+const char *ref_update_original_update_refname(struct ref_update *update)
+{
+	while (update->parent_update)
+		update = update->parent_update;
+
+	return update->refname;
+}
+
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 74a713090c..25e5d03496 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2423,17 +2423,6 @@ static int split_symref_update(struct ref_update *update,
 	return 0;
 }
 
-/*
- * Return the refname under which update was originally requested.
- */
-static const char *original_update_refname(struct ref_update *update)
-{
-	while (update->parent_update)
-		update = update->parent_update;
-
-	return update->refname;
-}
-
 /*
  * Check whether the REF_HAVE_OLD and old_oid values stored in update
  * are consistent with oid, which is the reference's current value. If
@@ -2450,16 +2439,16 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 	if (is_null_oid(&update->old_oid))
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
-			    original_update_refname(update));
+			    ref_update_original_update_refname(update));
 	else if (is_null_oid(oid))
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference is missing but expected %s",
-			    original_update_refname(update),
+			    ref_update_original_update_refname(update),
 			    oid_to_hex(&update->old_oid));
 	else
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "is at %s but expected %s",
-			    original_update_refname(update),
+			    ref_update_original_update_refname(update),
 			    oid_to_hex(oid),
 			    oid_to_hex(&update->old_oid));
 
@@ -2513,7 +2502,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 		reason = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot lock ref '%s': %s",
-			    original_update_refname(update), reason);
+			    ref_update_original_update_refname(update), reason);
 		free(reason);
 		goto out;
 	}
@@ -2533,7 +2522,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
-						    original_update_refname(update));
+						    ref_update_original_update_refname(update));
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 108f4ec419..617b93a6c8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -749,4 +749,9 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
  */
 struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
 
+/*
+ * Return the refname under which update was originally requested.
+ */
+const char *ref_update_original_update_refname(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6104471199..8bba5d5096 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -581,16 +581,6 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 	return ret;
 }
 
-/*
- * Return the refname under which update was originally requested.
- */
-static const char *original_update_refname(struct ref_update *update)
-{
-	while (update->parent_update)
-		update = update->parent_update;
-	return update->refname;
-}
-
 struct reftable_transaction_update {
 	struct ref_update *update;
 	struct object_id current_oid;
@@ -869,7 +859,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			/* The reference does not exist, but we expected it to. */
 			strbuf_addf(err, _("cannot lock ref '%s': "
 				    "unable to resolve reference '%s'"),
-				    original_update_refname(u), u->refname);
+				    ref_update_original_update_refname(u), u->refname);
 			ret = -1;
 			goto done;
 		}
@@ -941,17 +931,17 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
 			if (is_null_oid(&u->old_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
-					    "reference already exists"),
-					    original_update_refname(u));
+						   "reference already exists"),
+					    ref_update_original_update_refname(u));
 			else if (is_null_oid(&current_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
-					    "reference is missing but expected %s"),
-					    original_update_refname(u),
+						   "reference is missing but expected %s"),
+					    ref_update_original_update_refname(u),
 					    oid_to_hex(&u->old_oid));
 			else
 				strbuf_addf(err, _("cannot lock ref '%s': "
-					    "is at %s but expected %s"),
-					    original_update_refname(u),
+						   "is at %s but expected %s"),
+					    ref_update_original_update_refname(u),
 					    oid_to_hex(&current_oid),
 					    oid_to_hex(&u->old_oid));
 			ret = -1;
-- 
2.43.GIT

