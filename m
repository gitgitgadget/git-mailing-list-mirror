Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AF283FC3
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092039; cv=none; b=QSR1gs2PlwNRbl6tRkhv/ZPGA3T2saM0gvz/jYf0TZaIptg+MiJzdwu6he6Am4HNox1aVKdKc4QlPdhOJSarCG0zGk9hOmri2PJe6rNi6JywMcaJMisptZGGHtnpb5h+omOcm7aWJEUI8X8G9xHJ07oK87QUcKSD0g1zsHwnF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092039; c=relaxed/simple;
	bh=nXSrS/s35bOUT6cKncsAGqoC/21AAYwZI5f/5Vbw0g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jOwonN1EW7M6QIBMN0SQ6mqPq88JRWkHDjDAr2ilAMntqIKy8JsYosJQBF00Ur8xMVuGVsrucu+V/OexK5tLp7SImw+eJTZ3IETrDl8nKtB5Z/tx5DgYfxI2/DyLR1/hGq+H3uGQoTAR5ookL9R9V/3N8DxGxl7p7vdQdFYkS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2w19ic9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2w19ic9"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-639df8d869fso3725191a12.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092036; x=1760696836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/xRH25rj8fEoBWlKWM3RmCiMgGZbhPzCivk9VqBhyY=;
        b=N2w19ic9izYFVn7kqJM2aUYnjEUo0HYwSvnMqvkx90akT9syXj71y5Ve+D0RaHqJLX
         Ha+ZkmL6SAkoqJkHM4nHHS6M/uQAKyOu075NEtHJlRh+QrT8+auxB1tyuhLLOaxh3qcl
         9dGxmo6XM2AzC22RxfckPSKWUbHJVcEqe/taJwk3g9Ce4as5o5HJm2CDVlzEXAhESHZv
         zpPG01Zrk7blX9vJIZvzQTxfkBcgfvVfEk37y3J9FP6SU0/dBI6YNPxA9qMtuyguYKk+
         0+wA1wukdtgXwuHIwLLPnPuwbyjHZhKXb07QRBXoSoBcaIzI8HCWZ9pvwWSbO4f4CpZj
         NujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092036; x=1760696836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/xRH25rj8fEoBWlKWM3RmCiMgGZbhPzCivk9VqBhyY=;
        b=N3Vip3QsbCDwBengse+J8P8EQAyjnmRmL+G4YQDXM1ZM8iXebP+LlAyhW53psSGZ7P
         qjgtMFN5Wd+/qDVZU/MWCWIrDWnJ51Q+8WMX6/A2noX3pqjxeKNdMqUEJDMB0mF+rEC0
         dui2s8618IFRIOrwvPK8XQ9CgH9LgwvAlRnyIOdGxQbgye0/hQbXEOvnRwTB7as2+hAs
         raaEdObY79/Ffxf6wW3v5qYKluJzj1MDMutF03Fp3+/MkAGzbb3PAnkwCuw31Zl9E1NQ
         EKpxxBAum0eFZLGkmqomCk8rptaOqKN8/DZDg4PeWhnI7qPJ2QCLFxUSUxAIIhktg8sp
         /7Hw==
X-Gm-Message-State: AOJu0YymhhBfgVYO/GezOBvu+4ta8R/pk0ziKWIlU6g53WgyzN597qMi
	POUiZdDhbp1n87dQW0KWxX+LzbemM4Ha4JoWiPw9myjfqVa494z3reEQNJmZN1NU
X-Gm-Gg: ASbGncuAKaMQRz9syl/EBTuzi6KeeDJuBk4b3BCM3HDWtgpFIxS4NtCJlTCZ9Y0YPZt
	27a3FH6OA5J0gc+vGnYZcSkIxneOngBPFP0mgINwdC8gZtrKcq8Zj4jI9V7N0VKCEr7HKMMK0iH
	E6hLGXDg6YnXX1gMDbDuZUAole/G6UbFbC8tnbDWvaUO+BPHdj2IZXnY4rJB4kbGNxINjPSHrjJ
	crPfH95QFfrFga4We/Q5K/YKk0obiDNxwiK6v3GZ8nN+wD47vwpOs2MyGFhXDXoRsokdcgFBkhy
	CU5Qa6d8s0SzTXSKLNE19meRPql8S8aVCFulFwE4IR9I997QkWwdhqYcWQJeFchkAVGIvG0DyZw
	8PvT4N/4XsciTzg8mzqge/QVWRbwrZpTkMwNEe/iW2BdxvZg=
X-Google-Smtp-Source: AGHT+IGWGh97urcuSsdiOHEg6c/9/w7NStMwWdxyIW509Sf7V49tdZ8+cn2ciioH3esGrHhFref8TQ==
X-Received: by 2002:a17:907:6e8e:b0:b04:6546:345a with SMTP id a640c23a62f3a-b50ac4db267mr1129423666b.52.1760092035602;
        Fri, 10 Oct 2025 03:27:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:07 +0200
Subject: [PATCH 3/9] refs: rename 'pack_refs_opts' to 'optimize_refs_opts'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-3-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8296; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nXSrS/s35bOUT6cKncsAGqoC/21AAYwZI5f/5Vbw0g0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo339PSQF4Z3cilxmmlmRURo0R8YjvUdmIu
 FYhp9lc6dcIMIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N9/AAoJED7VnySO
 Rox/GGUL/0bkuDbZqPakbVwT0SIM6pt/dI5CxAs8Bz5ZdSCWa+EY/SW86KmY2wVCKD1tt+HxI8p
 qqt9TCQMcrfLSIdxrN6VK3++3k/FENpDAQyuflUOK6bOML2sAwBtEE58CDnjpHazmMP/C2i5Nh2
 5urdKza37reZZLpWVp/zGgcHWREwYhaMpwL9+6CnrlialKcQeBP6oyB8mxzhKpZ2e4QcRFPg1IT
 IHoZ4TxYbSy8nVi7pQscJVjSEpp94cSTQZRngl+SPuMfhsBs+yZaz1ayx6+AhN2ucNbE+MbQwZz
 hGg8lJsLBuUflLOHyKvg2+/dD+IPMcL0OP/xzgP3QzFfLadLrJyhZDNbTmkYBmFQ9bjXwaWtv2b
 Tpij0IbFzSDNffXTflW0vmyUMzZzSNEUfQbnqI5EMCuxKZ/YYULmOuy3XFQc1xgyEDs7103k9UT
 gs4Z0lKuGCl5Nx8An5IuHGpqR0mOl6oqj1ksJyh2NuxLAZBsztw5Qlh31YUxvjoHuZ3k64//bS5
 XY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit removed all references to 'pack_refs()' within
the refs subsystem. Continue this cleanup by also renaming
'pack_refs_opts' to 'optimize_refs_opts' and the respective flags
accordingly. Keeping the naming consistent will make the code easier to
maintain.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 pack-refs.c             |  8 ++++----
 refs.c                  |  2 +-
 refs.h                  | 18 +++++++++---------
 refs/debug.c            |  2 +-
 refs/files-backend.c    | 10 +++++-----
 refs/packed-backend.c   |  2 +-
 refs/refs-internal.h    |  2 +-
 refs/reftable-backend.c |  4 ++--
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 1a5e07d8b8..fee77fbf9f 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -14,10 +14,10 @@ int pack_refs_core(int argc,
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_refs_opts = {
+	struct optimize_refs_opts pack_refs_opts = {
 		.exclusions = &excludes,
 		.includes = &included_refs,
-		.flags = PACK_REFS_PRUNE,
+		.flags = OPTIMIZE_REFS_PRUNE,
 	};
 	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
@@ -26,8 +26,8 @@ int pack_refs_core(int argc,
 
 	struct option opts[] = {
 		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
-		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
-		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
+		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), OPTIMIZE_REFS_PRUNE),
+		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), OPTIMIZE_REFS_AUTO),
 		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
 			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
diff --git a/refs.c b/refs.c
index 77dc1ab501..514fb85af2 100644
--- a/refs.c
+++ b/refs.c
@@ -2312,7 +2312,7 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
 	refs->gitdir = xstrdup(path);
 }
 
-int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
+int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts)
 {
 	return refs->be->optimize(refs, opts);
 }
diff --git a/refs.h b/refs.h
index c6c955d78d..58b222ac02 100644
--- a/refs.h
+++ b/refs.h
@@ -500,15 +500,15 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 
 /*
  * Flags for controlling behaviour of refs_optimize()
- * PACK_REFS_PRUNE: Prune loose refs after packing
- * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
- *                 result are decided by the ref backend. Backends may ignore
- *                 this flag and fall back to a normal repack.
+ * OPTIMIZE_REFS_PRUNE: Prune loose refs after packing
+ * OPTIMIZE_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
+ *                     result are decided by the ref backend. Backends may ignore
+ *                     this flag and fall back to a normal repack.
  */
-#define PACK_REFS_PRUNE (1 << 0)
-#define PACK_REFS_AUTO  (1 << 1)
+#define OPTIMIZE_REFS_PRUNE (1 << 0)
+#define OPTIMIZE_REFS_AUTO  (1 << 1)
 
-struct pack_refs_opts {
+struct optimize_refs_opts {
 	unsigned int flags;
 	struct ref_exclusions *exclusions;
 	struct string_list *includes;
@@ -518,9 +518,9 @@ struct pack_refs_opts {
  * Optimize the ref store. The exact behavior is up to the backend.
  * For the files backend, this is equivalent to packing refs.
  *
- * flags: Combination of the above PACK_REFS_* flags.
+ * flags: Combination of the above OPTIMIZE_REFS_* flags.
  */
-int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
+int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts);
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/debug.c b/refs/debug.c
index 67a0bcc57b..260d7457db 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -117,7 +117,7 @@ static int debug_transaction_abort(struct ref_store *refs,
 	return res;
 }
 
-static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
+static int debug_optimize(struct ref_store *ref_store, struct optimize_refs_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = drefs->refs->be->optimize(drefs->refs, opts);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0b81bd7f74..1c37899006 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1356,7 +1356,7 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
  */
 static int should_pack_ref(struct files_ref_store *refs,
 			   const struct reference *ref,
-			   struct pack_refs_opts *opts)
+			   struct optimize_refs_opts *opts)
 {
 	struct string_list_item *item;
 
@@ -1384,7 +1384,7 @@ static int should_pack_ref(struct files_ref_store *refs,
 }
 
 static int should_pack_refs(struct files_ref_store *refs,
-			    struct pack_refs_opts *opts)
+			    struct optimize_refs_opts *opts)
 {
 	struct ref_iterator *iter;
 	size_t packed_size;
@@ -1392,7 +1392,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	size_t limit;
 	int ret;
 
-	if (!(opts->flags & PACK_REFS_AUTO))
+	if (!(opts->flags & OPTIMIZE_REFS_AUTO))
 		return 1;
 
 	ret = packed_refs_size(refs->packed_ref_store, &packed_size);
@@ -1446,7 +1446,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 }
 
 static int files_optimize(struct ref_store *ref_store,
-			  struct pack_refs_opts *opts)
+			  struct optimize_refs_opts *opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1489,7 +1489,7 @@ static int files_optimize(struct ref_store *ref_store,
 			    iter->ref.name, err.buf);
 
 		/* Schedule the loose reference for pruning if requested. */
-		if ((opts->flags & PACK_REFS_PRUNE)) {
+		if ((opts->flags & OPTIMIZE_REFS_PRUNE)) {
 			struct ref_to_prune *n;
 			FLEX_ALLOC_STR(n, name, iter->ref.name);
 			oidcpy(&n->oid, iter->ref.oid);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 20cf9fab18..acaa5a6e57 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1774,7 +1774,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 }
 
 static int packed_optimize(struct ref_store *ref_store UNUSED,
-			   struct pack_refs_opts *pack_opts UNUSED)
+			   struct optimize_refs_opts *pack_optsa UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fc5149df5b..4ef2422729 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -423,7 +423,7 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int optimize_fn(struct ref_store *ref_store,
-			struct pack_refs_opts *opts);
+			struct optimize_refs_opts *opts);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 59018b93d1..d77714366a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1700,7 +1700,7 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 }
 
 static int reftable_be_optimize(struct ref_store *ref_store,
-				struct pack_refs_opts *opts)
+				struct optimize_refs_opts *opts)
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "optimize_refs");
@@ -1714,7 +1714,7 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 	if (!stack)
 		stack = refs->main_backend.stack;
 
-	if (opts->flags & PACK_REFS_AUTO)
+	if (opts->flags & OPTIMIZE_REFS_AUTO)
 		ret = reftable_stack_auto_compact(stack);
 	else
 		ret = reftable_stack_compact_all(stack, NULL);

-- 
2.51.0

