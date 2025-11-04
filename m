Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA722AC17
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245853; cv=none; b=QYyOj5syRl5IpbvEtHyax9BI4o+mHu1xqtMo7ErFZd/unX2yXiq4/Azl5Dw4u3Q9JR6sT+pImD7zicShvNfd0AVLYNr75QjDLlzcxbxqIL+OB9m7nTqxKTgcXCdHgCEEh0/96heI/5dLlz0ihjZt6xhW0sf+KyYIXICE2wvCwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245853; c=relaxed/simple;
	bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leQ6D2KW03MNCsFas3zPSVw1qZbsWno2x8ZIU6+OpoVh8Vy7BaqBQYpp3nBg7OhzxgkzqOrb+AfSfFeb5hP+IdpuUKmID27/LI2iz3WcxeYM+B3NvGFEhcws0HoGJlxZ37eofptOe2Jvui+DOe61Lj13n61Coja1yspcjQwPCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYFGOReI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYFGOReI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47728f914a4so26719145e9.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245849; x=1762850649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=nYFGOReICSlO48LJCzXASIXpmlqhQwy5Rlq0DfUW40l8UfW4a1peSEToo3AHrVzyYD
         KHXIzI5NCjEB6MjxuH1TFsZc3ooZwoYY3wiEhxxwriOWVbFAzcpzJccUP/KbwrULKiPb
         3+F4JKT7g2iitcuWqi84RIJG4FMoXwQhr0RVmtlI4KAf+hQ6qk3gJtm0AvV8+FdabMlm
         Hb8kBeAtLDfKxyfZFWRQOho5ydyLg2mW1f5WEBurxrblGGUG7PcuEAF8KvhN8NiuuMvh
         LPUivsrDjolZomcpNcDyRYnN4bVO80tCeYhOcolJ/+Qdb5OHbsVmBDp2CaMgpnntNSml
         psBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245849; x=1762850649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKIszrkWH8ph1EwVmrLJMf196QFWho2f6S3UmtCTlHM=;
        b=IbiSb4mqICjiYyd9DjXXLGFnhaP/jwt/uxE7U8L3FHHCk2/LETHAlQx38Dhj1C/cNm
         GiwujRFlUDpxOsymckPQP0nlXgeapWpz8+TqjaP/sl/UH26blGr0B2OkANONatmtusfl
         5l5ULM7D+jHn7rgsno4L/5aARyx8kV/aqufoLALhTqh0+qlcMFBZJz95K+JZEq9smGyY
         uMxw6JPZlwy3KaKMt6eWkcLPPQTNKDJW5VxThfNgq97giPlyfrRJjcsxkGM27MUulZ72
         fd4Dt3t5sAgnqkgq44amB9nwuvnj8erV08oVDdw/jLxVZ5s9/cwoLVPovfzw7JL5ZCJk
         61kQ==
X-Gm-Message-State: AOJu0YzydlkJKdyi+Guzn56vVfHYqTlaybXk9O7ih1e9qquT2Dw0XlrS
	jDknXaifeiB6kqSlFciWycA6GtOqwAzd3yiWwIGfI2N1XsmaPmG20F4a
X-Gm-Gg: ASbGncvOV//8iD/J8jtLRj+ISfiNOYEG3vVCYRJ7eaLpzwo41TtCh2+0mhCoeBCkTjz
	pgmaYfnkhs5iRm0gA5pspc19RmxOxjfEF/pmP4zyyZkC1RN2oA14IuHqAK/U0dOX5iTpoBf8YnQ
	6d8tPCn8puwupAW9WDnv9EcEqUlYEf0+z55BWSLEVanGaA1ra8He5MmXlEcHxAGguoZsnV+jLPX
	AF5hdhkvNK9h7jgnFB5vRZ517/e18Q5H3jRzMw7dlv9ApdShhIyWyv7A1iSNdPDxVQ1pX3I9dX0
	TIGPTrdUfjCkGxSf3lKJ/Umr/jbW3cNGtIsmcmjSewGoXUbEHeqrm33/TXJqP074YfH46TQhloc
	9Cnpy+hImjTCHNFY124D2H9YmoMwZwBNCwCHYKzZxgJY47mDszCCUW5RYGeUtVdS2t6VsfFrcw9
	bpuvc2
X-Google-Smtp-Source: AGHT+IEI73ONiGSIy39TRpOr7RCgHAdIS3bczmpZoMT/2ce5k9jjxMt5wyRR7NUaiG8d0322lJJ+ZQ==
X-Received: by 2002:a05:600d:831c:b0:477:542a:7ed1 with SMTP id 5b1f17b1804b1-477542a7ee4mr22629135e9.19.1762245849204;
        Tue, 04 Nov 2025 00:44:09 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:b03:96aa:b9b4:f746:b8e9:7f4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm193379035e9.13.2025.11.04.00.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:44:08 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 04 Nov 2025 09:43:58 +0100
Subject: [PATCH v2 3/5] refs: add a `optimize_required` field to `struct
 ref_storage_be`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-3-303462a9e4ed@gmail.com>
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
In-Reply-To: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6999; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qtI9EBYSAJFff7tYAur3spynrpjDCd3witMtp9uUbJI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkJvNTkOD2QtQr1nL2UWq9M1QW9wsAomqxnC
 JgKZC0BJiIcMYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpCbzUAAoJED7VnySO
 Rox/6UEL+gP+c0jS6UQnZhfAQQbCQaQJDp9VE40XIBHTCvvB6oPMUSYaewXEHj9+0lV7lx3xn8d
 /aydZZ9G2JHpswETyYRP8SAIoo0TTzZUECqoSDVYwOR96QbJJAfj9FyD1SlknWgwJvsy0v3SeDA
 lvBEHiObkAMBgLEThKkogqDqVYLTrXMpm8i1xcTFLk70rlWhqBI/yF4OKtjiTXF0Ohul8QAo3Pr
 SU2l8JQefgpF/gEXRT1ihnurmPWmQyd3t0vEMW+K22z+aGDxdxD9i5skHy91kL9jJ/jSVsz+yBd
 v1d1qYJ6ffOjUO87N+BdkqmkYZYj8Go6wS2xTo4hhMf7LU7bSKb8go8qXQk/tm7l8bW6yUz22Ra
 w+JZkyDHopgprWMiBDvOF70gl3uxTiw0xFX76KHL4erNGmeckpPeVXRBSMtjj7Y+Wf728W0m3a3
 ZGgAB2jO2hd6nScSl7Ad4jVYqliV+V+izzCe81ztxFNBzM555bKAHwkAzkKlkPcZ0m5hnBP4FS3
 2w=
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

