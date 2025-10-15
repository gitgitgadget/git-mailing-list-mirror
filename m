Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EE2FE066
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563524; cv=none; b=Att1jKrymTwrq9ocB2Z83tCj516WfeiY7duVYDD/v4CDILhLnF0B0TMEHgu9I//Q/t2IeqtsV42DGDn1DqN2tJg47+bswzwd740W2jRABtE7VZAukG00nG9bs79/s6noQdu3ezz2qQcUWLFnFa1R7RWAHBlSnGmM9c1H0/y6cBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563524; c=relaxed/simple;
	bh=iX6JjGDMPWs3rj17jga3fIx1NpC53sbetl+dcVixlgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=US6XwXJqhdSMcMa6SMvtViWCjwDkXfjsXwwt2sOhLrBuHsuMVK8/hlXX9nmm422E4zQGkNwEiRqzQBUE0l/Le4b/CueHpWbl551wNJvCaxoB0SmbdiBMoAfXhKyoXLMbYmxbMZ6HXvaa7Jppaw/ruIqkMy3+pjEE1ebrEZ5xGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPWW4qFD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPWW4qFD"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3ee18913c0so4387366b.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563520; x=1761168320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/J7D8pnvtHjA9UcQXb4ITE0om5BSuLqGq0FvJ0OS94=;
        b=LPWW4qFD/6nIR8l9qRxu2TmAlYXr09zsxJvrMF2l30mKtKj+K2yoMQehQCRk/20kJr
         VW/YpMIKEjdZoOqfXbmmdyS7dtU9dkrNkPkTQYS7saCngpKwBBXRGA4Onqzi9/mZSn5p
         w7iZ4sW9wdNgPSPWfYftHCtOeX58mWRyZLm4wr5P4NhKWrbbnq1Pa5iVm+xLS4qjKE3i
         fqVbWxGYrkvxVCYZBo3F+8JtZGKmCCyEhmVQfn/EHpNRoX411bR7KFbEBmshigDVBpux
         fa7huKd9O88yPIdMibwmWvCx40E7FOxQFIFnUiabEBIMfk2F07aMubSNhh+RdIgzg9hC
         Xvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563520; x=1761168320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/J7D8pnvtHjA9UcQXb4ITE0om5BSuLqGq0FvJ0OS94=;
        b=EOZdYm36D745pp2X78nKWj11gSEi33dQyg4G0NkxQVK/SmC48ojsl9d0CRb/ramwyr
         Snk9i/oyWPLuBoSCBYvApTzJv0pwnFjTV4jgl8Kk84nSEk3/S0E1W6QAIzrKKS/nDlvT
         6TcmjwCMbjmrU4RMu1ULP1W7rr5h491BOkleXZDabCjQ9kC5vPoxevMhSXhbIAv8ySAg
         25on36ktrqMqZ61C2+X2k7Zyxqu891Cw0FXRPilF7u7/pcXq6ZJtifqrBh1PXtZ3p+G3
         /3phMqB1wK7MI14mbrPDRLakoJgvas7Chm1htyAoBSGNNt20TolcX6I8j2lDl2cAixFi
         9ZFg==
X-Gm-Message-State: AOJu0YzyIcunqrBMK8CoSuMRB45WTGeO/20aB+80ollmJLVxx9PVWPU6
	k4q/Om1YytjePYLNCFPSkJQhaZRfhdkfMTZeraD1gZJvPXqLNdfqt4Zl1qoaApuU
X-Gm-Gg: ASbGnculqaLBAhXsh+F17KmVL3VN0lbAhPMbPvMM/pMu3ZA9mIEpLSGeRUBbDSJJ3St
	cC19atPbTLrcNE33Ly9YPsD98pydxhLV2mBLd1wyvTS4ISTQuHOku2eLGwJrFqKYrYmT+FyC0jR
	VAIvnza+EfjKw210IdwVKwnzyFunk2qj9qIcJ3WWiLMiHiT9dbKJllrYJux836F+XwXzDYvo2bO
	PMuDJD4loK8NRPA/bo3XvAiYqnblVWQwaWtkU/8P8KEKKukjEH16GxuGkFU1HHIREwpu1q5JTk+
	9ehjJI/V0HezAdR7cMLUbN2Aoxo2SDBFaejc+MOuHdSd85HtF3RmicOoGFykEQHLXDcCA27iYMj
	+ReEPJqwDZ7iVAnDxvvPOTyn//OEOsIlbTTzsXo4NdT6o983UAi5XndAnyXjOpoOUFdQ7MJtmLe
	tgtBMKzgWj
X-Google-Smtp-Source: AGHT+IF8jKITtH1SAj1WU0WWlc0Uf/vb2XMLS3BSNWS1jcrbz0Ya7sz5NAU4h9fH2299kgw63tTSdw==
X-Received: by 2002:a17:906:f590:b0:b3d:656b:9088 with SMTP id a640c23a62f3a-b50abfccfa8mr3330423466b.54.1760563520051;
        Wed, 15 Oct 2025 14:25:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:980b:e8aa:7473:ef22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa082sm315854766b.50.2025.10.15.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:25:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 15 Oct 2025 23:25:08 +0200
Subject: [PATCH 3/4] refs: rename 'pack_refs_opts' to 'refs_optimize_opts'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-refs-code-cleanup-v1-3-550fdd8a3b41@gmail.com>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
In-Reply-To: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8172; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=iX6JjGDMPWs3rj17jga3fIx1NpC53sbetl+dcVixlgo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjwETuIdLa0Pew5MNOkrGjp5RvkSyevcabEO
 tNLIxFVvJuInYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo8BE7AAoJED7VnySO
 Rox/aHoL/2eHnbJBXjj14wfEMjYikuq+cRAa4la0QodR6lyKSHdlQCyM9aPpbu7KxO6bJVFQMGO
 FrpERoHfFl4HcPOug+UTSZabUm+T/Ft+YVPQ7XsBnrGSNQRhCA48b2MReYtGcrp4S3z0DcaaeCv
 jyR0UjiHj3lzTdKW0ZmRAgo7wAPbHbLE9ytHR9CoMu4vTjqr1MEKa5Tu1L3/4Q20Lb91niaHgRj
 41xoO5YufC4WaBdEwoItaMdC9dp5LQjRzQz7pmjIn1rYZ7HI5Ufu7NYpTGrbktOH7j7D4+eWFE2
 OoRTnmb+MowRvzqku7bHl0m4h54whqRFEvXG+JbFNuZqYIB8SjiBxP32FfEUiZ4KjJqnwH0d8Ql
 P7l9X3O1PgI9eEklD6L1V1mTCPQEMCPsC+rdP1pmfmFC9Szz3g974rnuRX7K0MI+IWVmCOTn2HH
 jT+DtcFtVvwFjbxXyeBTutgSwtwZkglK0ZRPAEHYcxTzOzlMD6/kIUwn6Fq9T4InpOnu4BfABS6
 x4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit removed all references to 'pack_refs()' within
the refs subsystem. Continue this cleanup by also renaming
'pack_refs_opts' to 'refs_optimize_opts' and the respective flags
accordingly. Keeping the naming consistent will make the code easier to
maintain.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 pack-refs.c             |  8 ++++----
 refs.c                  |  2 +-
 refs.h                  | 16 ++++++++--------
 refs/debug.c            |  2 +-
 refs/files-backend.c    | 10 +++++-----
 refs/packed-backend.c   |  2 +-
 refs/refs-internal.h    |  2 +-
 refs/reftable-backend.c |  4 ++--
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 1a5e07d8b8..d0ffed93c1 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -14,10 +14,10 @@ int pack_refs_core(int argc,
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_refs_opts = {
+	struct refs_optimize_opts pack_refs_opts = {
 		.exclusions = &excludes,
 		.includes = &included_refs,
-		.flags = PACK_REFS_PRUNE,
+		.flags = REFS_OPTIMIZE_PRUNE,
 	};
 	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
@@ -26,8 +26,8 @@ int pack_refs_core(int argc,
 
 	struct option opts[] = {
 		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
-		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
-		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
+		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), REFS_OPTIMIZE_PRUNE),
+		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), REFS_OPTIMIZE_AUTO),
 		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
 			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
diff --git a/refs.c b/refs.c
index b9a4a60646..0d0831f29b 100644
--- a/refs.c
+++ b/refs.c
@@ -2313,7 +2313,7 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
 	refs->gitdir = xstrdup(path);
 }
 
-int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
+int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts)
 {
 	return refs->be->optimize(refs, opts);
 }
diff --git a/refs.h b/refs.h
index 04e917fec0..d2630af97f 100644
--- a/refs.h
+++ b/refs.h
@@ -500,15 +500,15 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 
 /*
  * Flags for controlling behaviour of refs_optimize()
- * PACK_REFS_PRUNE: Prune loose refs after packing
- * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
- *                 result are decided by the ref backend. Backends may ignore
- *                 this flag and fall back to a normal repack.
+ * REFS_OPTIMIZE_PRUNE: Prune loose refs after packing
+ * REFS_OPTIMIZE_AUTO: Pack refs on a best effort basis. The heuristics and end
+ *                     result are decided by the ref backend. Backends may ignore
+ *                     this flag and fall back to a normal repack.
  */
-#define PACK_REFS_PRUNE (1 << 0)
-#define PACK_REFS_AUTO  (1 << 1)
+#define REFS_OPTIMIZE_PRUNE (1 << 0)
+#define REFS_OPTIMIZE_AUTO  (1 << 1)
 
-struct pack_refs_opts {
+struct refs_optimize_opts {
 	unsigned int flags;
 	struct ref_exclusions *exclusions;
 	struct string_list *includes;
@@ -518,7 +518,7 @@ struct pack_refs_opts {
  * Optimize the ref store. The exact behavior is up to the backend.
  * For the files backend, this is equivalent to packing refs.
  */
-int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
+int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts);
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/debug.c b/refs/debug.c
index 40cd1d9c15..2defd2d465 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -116,7 +116,7 @@ static int debug_transaction_abort(struct ref_store *refs,
 	return res;
 }
 
-static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
+static int debug_optimize(struct ref_store *ref_store, struct refs_optimize_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = drefs->refs->be->optimize(drefs->refs, opts);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 92d90fc508..2f60395cd2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1355,7 +1355,7 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
  */
 static int should_pack_ref(struct files_ref_store *refs,
 			   const struct reference *ref,
-			   struct pack_refs_opts *opts)
+			   struct refs_optimize_opts *opts)
 {
 	struct string_list_item *item;
 
@@ -1383,7 +1383,7 @@ static int should_pack_ref(struct files_ref_store *refs,
 }
 
 static int should_pack_refs(struct files_ref_store *refs,
-			    struct pack_refs_opts *opts)
+			    struct refs_optimize_opts *opts)
 {
 	struct ref_iterator *iter;
 	size_t packed_size;
@@ -1391,7 +1391,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	size_t limit;
 	int ret;
 
-	if (!(opts->flags & PACK_REFS_AUTO))
+	if (!(opts->flags & REFS_OPTIMIZE_AUTO))
 		return 1;
 
 	ret = packed_refs_size(refs->packed_ref_store, &packed_size);
@@ -1445,7 +1445,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 }
 
 static int files_optimize(struct ref_store *ref_store,
-			  struct pack_refs_opts *opts)
+			  struct refs_optimize_opts *opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1488,7 +1488,7 @@ static int files_optimize(struct ref_store *ref_store,
 			    iter->ref.name, err.buf);
 
 		/* Schedule the loose reference for pruning if requested. */
-		if ((opts->flags & PACK_REFS_PRUNE)) {
+		if ((opts->flags & REFS_OPTIMIZE_PRUNE)) {
 			struct ref_to_prune *n;
 			FLEX_ALLOC_STR(n, name, iter->ref.name);
 			oidcpy(&n->oid, iter->ref.oid);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 20cf9fab18..0aa0ff6701 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1774,7 +1774,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 }
 
 static int packed_optimize(struct ref_store *ref_store UNUSED,
-			   struct pack_refs_opts *pack_opts UNUSED)
+			   struct refs_optimize_opts *pack_opts UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fc5149df5b..dee42f231d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -423,7 +423,7 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int optimize_fn(struct ref_store *ref_store,
-			struct pack_refs_opts *opts);
+			struct refs_optimize_opts *opts);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 43cc66a48e..c23c45f3bf 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1701,7 +1701,7 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 }
 
 static int reftable_be_optimize(struct ref_store *ref_store,
-				struct pack_refs_opts *opts)
+				struct refs_optimize_opts *opts)
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "optimize_refs");
@@ -1715,7 +1715,7 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 	if (!stack)
 		stack = refs->main_backend.stack;
 
-	if (opts->flags & PACK_REFS_AUTO)
+	if (opts->flags & REFS_OPTIMIZE_AUTO)
 		ret = reftable_stack_auto_compact(stack);
 	else
 		ret = reftable_stack_compact_all(stack, NULL);

-- 
2.51.0

