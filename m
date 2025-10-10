Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46863283129
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092038; cv=none; b=NtU/FhY/3UZQiy+pPN9ZVytkRbTVmyLUvZ8OnkEbqdGKfVj1aymXh4JWExw7WA0b0Dskm/uhCNarBcAVFN6bGZaNIIOQFzvrfDPdfdrbUVewGbuBbHo7saU+9aCdffOuLRINc8q2GBnk5Qw3lOWS/up6IwHi2//AJhsxQC+YZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092038; c=relaxed/simple;
	bh=dk1pNoebbW1efZUcPWg4DZ+0kkwe3EaSJaYB/uw3GCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4ZhIxQz3qI/FOkpCDWFHb4TRY/X8Omus9ejMW31H2uiEwZjA831UoXzWXH4KvYKZK2IVdnb+cw5LRqy5gUL8XuaEFJ4M6xu/Mm3rQb4J7YhqeFRPsvAWg3MX+PZ3CQOozOBBVC/GqeCGrmo0oz2q3iX+2f16k6fBRAr3NUSZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK9PbPyP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK9PbPyP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6394b4ff908so3607640a12.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092034; x=1760696834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0bcRo2iDiiCoXKDki6ZaNo2IzJJ+krXEasb+AGqp7c=;
        b=RK9PbPyPyLlnfyRZD9rJePKTQ29Nh6LBGwtJq20fsCNTDb2ZQaQdkZTXQeGBmhOi2a
         YHRh2s80Ri8N86l8ffMDZ+oMqhxBMUydtHkRurk8nW4j5Iwzk55w9GtPcWS9t2oDYzaD
         Y0d3hSl0TV7J6i5DPYhF3F3MAYItVkybfiEYD7RGXUsTNBJ7yp/jnbP24TWdYvSJwDrw
         MDQ4YFBctCHARw0oGFhzcgVWHr3bEPT3c48dzbd/GXIR7vQnLUemgNLhiIAAFdJwSsI6
         RRxoQCc+3MX3euxIFRPWRY2HiJswOOpcWECgQRmJEDQacneaV0i92zCYG//K2a+otVSO
         uHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092034; x=1760696834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0bcRo2iDiiCoXKDki6ZaNo2IzJJ+krXEasb+AGqp7c=;
        b=ZKAJtdNBOW7AJLozp0UVGvceC9QnbmxXmIsVptLWH5k3YRXseKlCzY1VniIr1d9yVQ
         lYiCVBn/azCpuL4UQyYM9SthsO+gvN4dZd2lC/wAdOJKzaZ/nsxwOUb2axY82fU1s0Ca
         S+9u0lpqXRRp5SnoPtYyYP+5qWhR3yq9ivCoHwwCZzmp7K/kwLixiJrQ8IreD8bBNRSs
         pcC0eq9DVNVOF3PRCpD/p/lp0eo5JSi4UGrfkV9MXULRFMYsTeK2P+174yyjj5GyRS/b
         0ZErBqGW8oWF9vhw42nIa/4Wmxr+nKZ6VP6NMTPGq4hQad8Iqy9a8lX3MW2pVnYT2Aiz
         3q0g==
X-Gm-Message-State: AOJu0YzJWPAgd9X661NFPEv5mx6t8tozYeO5dinThOHAVOTJxYJr60B6
	aslZ4m5atG/IINA+BSRxnnvn4kmZ8Foci68777HfoCijY/Iv1+lMfDUQjZX6NwFR
X-Gm-Gg: ASbGncvec8vXz464jVBtokaciN95nP+mYvMXQhuC41F14FmS9bRMYvS3D4ChXKIkA6o
	jEAfI4z69p6H4FEAL6/O5EY+IkKUVmmF+psZU2n8VcorhXY/uQXljALcKPdJuRK0bD2OIt9La3v
	NSACfKnrxS1vjsfJ81dDlPG/dm6Htbfhf8FkRs48z+NCbPuVKAPPq9N3HZ7KUat0nWrLd/Z423G
	2YmsY/1SfyQkzPbkwJ/jQ77ASR4bKNSk7A7M2RppnkZN3ZAuv7Tl1Mt8zly/BKIe3pWbIAhXZ6j
	yEWDSD81D4WqxIuCNiH+bWRkDbThDLU9q8yc5KT8os2hdUbbaeH3yWvgHtOAzx3chKMIann1rPR
	9m/HiJ5ucD3yyzVlXETxxbClHd15aXAw1FxMSiCc8xRGFdo0xo+d0AYMd3A==
X-Google-Smtp-Source: AGHT+IF5bZx59Vy2eLyrKwMXhIoxx/9Kb7Tl8exmXY5+aXBBtJdP4kEOjqza5jqQKg+JM+jX67owbw==
X-Received: by 2002:a05:6402:35c6:b0:639:f254:bec6 with SMTP id 4fb4d7f45d1cf-639f254c85fmr6453315a12.15.1760092034229;
        Fri, 10 Oct 2025 03:27:14 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:05 +0200
Subject: [PATCH 1/9] refs: move to using the '.optimize' functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-1-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5652; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=dk1pNoebbW1efZUcPWg4DZ+0kkwe3EaSJaYB/uw3GCY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo339PjBv4vmVRl8htNWJiqR3xbJiC51apR
 TC2VES/mYpceIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N9/AAoJED7VnySO
 Rox/2fQL/Ro+wMlLSNQtmigbItGB0cSiYnlx8W4Ui7Uab1r1IUYAnvKzbnElwDDdwI6Lnq3iS17
 gp7NM7RyXO7F/BWgzFSxKL64Z/rS9Shh6HdbD87TwCq8l479voCimZxQXFoZwIAXm7dHmqychI4
 HumZpygG7HYg7B7Wq6K4l1GI5Tn3fLM+KR3lbJgG8XFoEDpbktV/xlh2qROKOw/zhexunYHsMhv
 uPBBxglO3f45/O4t5tBKCDny3MKZOZCM2UirX6c01s5+Pr03SNzcDtqrCk+HlJyNafDyQ77d7vw
 pgWWfK7gcVmrbbjfvQV2Yc9Uis3aXYCDo46KMYqKIHX99So+yFINud/hjag+k6gLCbFgUF9KMgk
 fbd1trNZ/svezlFi0VMPA2lUVnUj5MwVvyWiTBlN+ENBiZEGB2vDwbKgYecjCgJDF4/KHtYIxJ6
 zG0Oz8SKwn0liHm5mQZFlm5/hudROsS12AnmJ5nN0Nqy2hyoGsO46FiI6O45V9/A3d3mnWLkiQ8
 BU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `struct ref_store` variable, exposes two ways to optimize a reftable
backend:

  1. pack_refs
  2. optimize

The former was specific to the 'files' + 'packed' refs backend. The
latter is more generic and covers all backends. While the naming is
different, both these tend to perform the same functionality.

In the following commit, we will consolidate this code to only maintain
the 'optimize' functions. In preparation, modify the backends to also do
the same, by moving to supporting the 'optimize' function. All users of
the refs subsystem already use the 'optimize' function so there is no
changes needed on the callee side.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            |  8 ++++----
 refs/files-backend.c    | 14 ++------------
 refs/packed-backend.c   |  6 +++---
 refs/reftable-backend.c | 13 +++----------
 4 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 162c24e5cc..67a0bcc57b 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -117,11 +117,11 @@ static int debug_transaction_abort(struct ref_store *refs,
 	return res;
 }
 
-static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
+static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
-	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
+	int res = drefs->refs->be->optimize(drefs->refs, opts);
+	trace_printf_key(&trace_refs, "optimize: %d\n", res);
 	return res;
 }
 
@@ -431,7 +431,7 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_finish = debug_transaction_finish,
 	.transaction_abort = debug_transaction_abort,
 
-	.pack_refs = debug_pack_refs,
+	.optimize = debug_optimize,
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4cda57981..0b81bd7f74 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1445,8 +1445,8 @@ static int should_pack_refs(struct files_ref_store *refs,
 	return 0;
 }
 
-static int files_pack_refs(struct ref_store *ref_store,
-			   struct pack_refs_opts *opts)
+static int files_optimize(struct ref_store *ref_store,
+			  struct pack_refs_opts *opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1513,15 +1513,6 @@ static int files_pack_refs(struct ref_store *ref_store,
 	return 0;
 }
 
-static int files_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
-{
-	/*
-	 * For the "files" backend, "optimizing" is the same as "packing".
-	 * So, we just call the existing worker function for packing.
-	 */
-	return files_pack_refs(ref_store, opts);
-}
-
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3972,7 +3963,6 @@ struct ref_storage_be refs_be_files = {
 	.transaction_finish = files_transaction_finish,
 	.transaction_abort = files_transaction_abort,
 
-	.pack_refs = files_pack_refs,
 	.optimize = files_optimize,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1ab0c50393..20cf9fab18 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1773,8 +1773,8 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 	return ret;
 }
 
-static int packed_pack_refs(struct ref_store *ref_store UNUSED,
-			    struct pack_refs_opts *pack_opts UNUSED)
+static int packed_optimize(struct ref_store *ref_store UNUSED,
+			   struct pack_refs_opts *pack_opts UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
@@ -2129,7 +2129,7 @@ struct ref_storage_be refs_be_packed = {
 	.transaction_finish = packed_transaction_finish,
 	.transaction_abort = packed_transaction_abort,
 
-	.pack_refs = packed_pack_refs,
+	.optimize = packed_optimize,
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0b7ec3ae15..59018b93d1 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1699,11 +1699,11 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	return ret;
 }
 
-static int reftable_be_pack_refs(struct ref_store *ref_store,
-				 struct pack_refs_opts *opts)
+static int reftable_be_optimize(struct ref_store *ref_store,
+				struct pack_refs_opts *opts)
 {
 	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "pack_refs");
+		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "optimize_refs");
 	struct reftable_stack *stack;
 	int ret;
 
@@ -1732,12 +1732,6 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_optimize(struct ref_store *ref_store,
-				struct pack_refs_opts *opts)
-{
-	return reftable_be_pack_refs(ref_store, opts);
-}
-
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2715,7 +2709,6 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_finish = reftable_be_transaction_finish,
 	.transaction_abort = reftable_be_transaction_abort,
 
-	.pack_refs = reftable_be_pack_refs,
 	.optimize = reftable_be_optimize,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,

-- 
2.51.0

