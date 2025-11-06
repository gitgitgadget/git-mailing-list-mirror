Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A61C1F02
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417363; cv=none; b=fpgcq9LJIy+LapxfSHphA+rSnoNM8QDrVVsTvRyvl2OoHTI7tY0XkUGyx7P3BilAmlgxqPQU30brB0I+cybmxX7EI3MsnwebWmLQl3QmwP/t53uftBDbfhpEENwBo7CLgxAIFOadQ4mOxOiyxAXYJ/GoBpYYYRLoXVc/WYXXtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417363; c=relaxed/simple;
	bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVPzKGYEmTLGpBQyqrze2mDkr8RLelMoA5RaE0wGxj9h5/5+O63VT+yVqchn7JNWryROkdrALGSAdsejS05tmu5x6cWF2oXb0JnxMChwSTCEpNXNL/bMoTvz6pxpJ4WVtAS5hiBUyqcSbHwxz9bF/E3NRRNLvtz995O5SXJ/fMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhgQNQPl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhgQNQPl"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7272012d30so108596766b.2
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417359; x=1763022159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=MhgQNQPlCuf48uJt7RGKDuPu6UeCgczz/ehdoO1txA7z+BDWF7zguhhNRf6jgL1YRZ
         DmzY61QVbULZXqgzQPOFOxbkBM8/CfLYFXw4tJNk1MeqLu1aRIF6D4wZz079zIOGU6cg
         GONhMHwvvTeoBTySqf21HjGrE+S93Fe0YIrAKE02P2w7zd0HvcVI+bUOnckRqNslw8Gc
         pi4dlgmdSvRa/T2JvDOd1PXypZrAMeppi27lIUdfuh2j2+05Us/QDFc5fDIZc48l603l
         5G8OI63yvEHuOhsQWOGjyPFW6fKKYAEHGvkHnu6eiSskvjx6dqQVcraFieSN9AK0rQaQ
         ynfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417359; x=1763022159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=ZrVQ9kgdhVeefFVqpd8LPttBtMYa3iT09HFgiFhzfkCTBb/KZo+P6WKC19Spp/SvBo
         ETjeppwaLFrdbzCnHCtclCXuDJysod13O8IkiWvGGndUusJaFOVIeMciuW5VmIixy4mp
         acn0DAgWk3vNlDQjgMaG7gTpAVX8gH7ORECi8JjgHFfAxWBkeqKjF39KCe4tKUU4Ssvf
         dE7SWFipxbsGBqwHlutzdXGvmn2E0lVeyYjgZn8clAIgwNeVqntoY/c86mEz8/4YFnuk
         cMqldJB7b9Lv++2h9oANqd/EOwdjVO4GkKM0v8y5VJy5XpHTGHQZqY2Lw6W1oJJtVaKB
         zOmw==
X-Gm-Message-State: AOJu0YwoDpcx0VeENuEX1FDP1g8CTWsa6hbDNNFfi3Yde6nkexfE6skF
	OW8X7azeM0Q3v7sK4uqKdI88uQXof4vGOZ5DZ4UqfOZw5CrcY2x9x5IuHX+VUT85
X-Gm-Gg: ASbGncvwWp57zTbbXjQTe7DLxADdDLfd7ew71ebhCkTRKa1QxNOB6omBPnBPtiKluQS
	f6diJ3hwVCTk+7zaqN/3zeJ6G5e2kqrDvkWXJWA3FzsiwA9IZnwlL3/DtZDm0nKjjLrI5drYYH1
	RVZ6bcFPW0y0pmePKw4Khnc8MMqcVB2yhlrWD3vFN7uCcOqj3cAJqVgyhmtqPEOgWwoFp8K7PWR
	YwxmyGsaQnAJvdHJfOCRlQC2Z79eTM7spcn72Tck3espSBxOqZw8juAymDSG3R51O6nMEpwwMFt
	45p3iqkhHnHfbX1oJ9bqcg8eraxhHLUInZK2t2qrilLh0mvzWxELdh7SjEKNtxu4R2Lchd6yzix
	dN1dN26xJCQ6WPJNPSlQdlqvkqAZvkFrKrPFTMdYXnLHjwO8Rj0riXmu85RDEo8yn+DqB+j8DDb
	0MJBXX5E1T5H2TFEw=
X-Google-Smtp-Source: AGHT+IE3NOzKmyf2fjZQDfeg9eszDjbg6WImDqL3bkN8Ilo4f4yL3WyxvDp6z/WbY84YJCmsiJ4MXw==
X-Received: by 2002:a17:907:6eac:b0:b72:5d9c:b47b with SMTP id a640c23a62f3a-b72654ddcf0mr572573366b.36.1762417359383;
        Thu, 06 Nov 2025 00:22:39 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:107:48a1:df96:bd1c:78ca:785c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893360f6sm160577566b.10.2025.11.06.00.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:22:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 06 Nov 2025 09:22:32 +0100
Subject: [PATCH v3 3/5] refs: add a `optimize_required` field to `struct
 ref_storage_be`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-3-d611a2a95cf5@gmail.com>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6999; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkMWsh8T3YCRS8f4W4zQqKBvtSugstI6Udo2
 nww9w8+oXDfZIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpDFrIAAoJED7VnySO
 Rox/Wm4MAJfbP/4OQBfbNOfn3x7m9aAHknYFY4YEXtzOhouiMHMFHRHsvct4jxx3SGoutue5uCA
 Yyp+EBRe9fAh0IeF3ba3wlczPYbYxRP87Z2aO39jfrwhoI54gvRJ9Rcc03xl2g37IrUaMTT6Nay
 nC3tkirsWb637p9ayERIcezjolivq8aSKQsrR/G5imkl5UpDPLykGxoajxxiB89W5a6zwIp/lvK
 6JhiWN2f2wj2GRnxi25PfsIsZJlIEgLzY/OxVL5mT16f7zU87SrwBnOYt4960MWZcMm5PAuD1T7
 iW8TtCCH4l3dklAQPb758a5oedhJQbYvclQ5xsUDgh2yOvw8Q/tLnLsdN5Dmqi8gHKByaMx2V7j
 MqHvWSa3jnl7EvqWMPrRmMCBt5F3rHBxGA8UKgMkTBdmwvby4/c+R6tngZnQ7qThR3sxY2G2HoX
 MIvPZ0FdRH36xBJzvjzD6wnbhReHmLWjKqYuy6NDKm92diOT13PHqW+8oUjIDwjeJKxA1kXpw56
 +s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

To allow users of the refs namespace to check if the reference backend
requires optimization, add a new field `optimize_required` field to
`struct ref_storage_be`. This field is of type `optimize_required_fn`
which is also introduced in this commit.

Modify the debug, files, packed and reftable backend to implement this
field. A following commit will expose this via 'git pack-refs' and 'git
refs optimize'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  7 +++++++
 refs.h                  |  7 +++++++
 refs/debug.c            | 13 +++++++++++++
 refs/files-backend.c    | 11 +++++++++++
 refs/packed-backend.c   | 13 +++++++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c | 25 +++++++++++++++++++++++++
 7 files changed, 82 insertions(+)

diff --git a/refs.c b/refs.c
index 0d0831f29b..5583f6e09d 100644
--- a/refs.c
+++ b/refs.c
@@ -2318,6 +2318,13 @@ int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts)
 	return refs->be->optimize(refs, opts);
 }
 
+int refs_optimize_required(struct ref_store *refs,
+			   struct refs_optimize_opts *opts,
+			   bool *required)
+{
+	return refs->be->optimize_required(refs, opts, required);
+}
+
 int reference_get_peeled_oid(struct repository *repo,
 			     const struct reference *ref,
 			     struct object_id *peeled_oid)
diff --git a/refs.h b/refs.h
index 6b05bba527..d9051bbb04 100644
--- a/refs.h
+++ b/refs.h
@@ -520,6 +520,13 @@ struct refs_optimize_opts {
  */
 int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts);
 
+/*
+ * Check if refs backend can be optimized by calling 'refs_optimize'.
+ */
+int refs_optimize_required(struct ref_store *ref_store,
+			   struct refs_optimize_opts *opts,
+			   bool *required);
+
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
diff --git a/refs/debug.c b/refs/debug.c
index 2defd2d465..36f8c58b6c 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -124,6 +124,17 @@ static int debug_optimize(struct ref_store *ref_store, struct refs_optimize_opts
 	return res;
 }
 
+static int debug_optimize_required(struct ref_store *ref_store,
+				   struct refs_optimize_opts *opts,
+				   bool *required)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->optimize_required(drefs->refs, opts, required);
+	trace_printf_key(&trace_refs, "optimize_required: %s, res: %d\n",
+			 required ? "yes" : "no", res);
+	return res;
+}
+
 static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
 			    const char *newref, const char *logmsg)
 {
@@ -431,6 +442,8 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_abort = debug_transaction_abort,
 
 	.optimize = debug_optimize,
+	.optimize_required = debug_optimize_required,
+
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a1e70b1c10..6e0c9b340a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1512,6 +1512,16 @@ static int files_optimize(struct ref_store *ref_store,
 	return 0;
 }
 
+static int files_optimize_required(struct ref_store *ref_store,
+				   struct refs_optimize_opts *opts,
+				   bool *required)
+{
+	struct files_ref_store *refs = files_downcast(ref_store, REF_STORE_READ,
+						      "optimize_required");
+	*required = should_pack_refs(refs, opts);
+	return 0;
+}
+
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3982,6 +3992,7 @@ struct ref_storage_be refs_be_files = {
 	.transaction_abort = files_transaction_abort,
 
 	.optimize = files_optimize,
+	.optimize_required = files_optimize_required,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 10062fd8b6..19ce4d5872 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1784,6 +1784,17 @@ static int packed_optimize(struct ref_store *ref_store UNUSED,
 	return 0;
 }
 
+static int packed_optimize_required(struct ref_store *ref_store UNUSED,
+				    struct refs_optimize_opts *opts UNUSED,
+				    bool *required)
+{
+	/*
+	 * Packed refs are already optimized.
+	 */
+	*required = false;
+	return 0;
+}
+
 static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store UNUSED)
 {
 	return empty_ref_iterator_begin();
@@ -2130,6 +2141,8 @@ struct ref_storage_be refs_be_packed = {
 	.transaction_abort = packed_transaction_abort,
 
 	.optimize = packed_optimize,
+	.optimize_required = packed_optimize_required,
+
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dee42f231d..c7d2a6e50b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -424,6 +424,11 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct refs_optimize_opts *opts);
+
+typedef int optimize_required_fn(struct ref_store *ref_store,
+				 struct refs_optimize_opts *opts,
+				 bool *required);
+
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
@@ -549,6 +554,7 @@ struct ref_storage_be {
 	ref_transaction_abort_fn *transaction_abort;
 
 	optimize_fn *optimize;
+	optimize_required_fn *optimize_required;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index c23c45f3bf..a3ae0cf74a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1733,6 +1733,29 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_optimize_required(struct ref_store *ref_store,
+					 struct refs_optimize_opts *opts,
+					 bool *required)
+{
+	struct reftable_ref_store *refs = reftable_be_downcast(ref_store, REF_STORE_READ,
+							       "optimize_refs_required");
+	struct reftable_stack *stack;
+	bool use_heuristics = false;
+
+	if (refs->err)
+		return refs->err;
+
+	stack = refs->worktree_backend.stack;
+	if (!stack)
+		stack = refs->main_backend.stack;
+
+	if (opts->flags & REFS_OPTIMIZE_AUTO)
+		use_heuristics = true;
+
+	return reftable_stack_compaction_required(stack, use_heuristics,
+						  required);
+}
+
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2756,6 +2779,8 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_abort = reftable_be_transaction_abort,
 
 	.optimize = reftable_be_optimize,
+	.optimize_required = reftable_be_optimize_required,
+
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 

-- 
2.51.0

