Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A542D3A74
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193815; cv=none; b=IX8taAgNhWG5eyzT1ROAtCGTR0OM1OTyHmjqnoJArX1QnlnjsDLXUAEjUZ+doouEgfrv0Wzd48IKZdwN0Wri3k60ZxX6e6SDtwrfkozkM+5kywV/NET4/qaabqLJtcPhB7A5VZYiuYHHIVyhTMFAlFgqVY0xpPIlGDMrkaS0Ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193815; c=relaxed/simple;
	bh=JVRzbHucHnkhFWy/Hno2HBxbu54Zo6gFk+mKOKXLuMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TVtdr/3Ho26REWeeu6HwWBuJCEQLZfc20zRLQ1wk3jOpkyhrs1jscQ0wfpIuqsbjfqXL0IvrOQR8H9CNQDDKBUs3qZkBf/Sq/qiypDFJAkN+FY7wWFxMrZtoo8pkcWt98ytXmiMhbLDoWx0CVSdJOEOkcTEmTE2Y6u/FwRULKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwrxFrtO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwrxFrtO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771eecebb09so1491782b3a.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756193813; x=1756798613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIZu1BOm1KW6CSCAjuEXZwEfxI8pu50fmL2TsPS1NX8=;
        b=mwrxFrtOkQ/YyP/HBQ1iWwcAWBZAF9Av4TWDJ2zkh+0VHC7I0C0iIpJs8DDewkODMu
         sibPSZXIqtjp3gdTGkONjzGQycbTG+NSYzWR6RzNyfFAR/yreJIK6CCIYNnTpvNuqbKL
         qWISCYy0zWE+Rx7PkEZf6r5nz9E63HhzcCJAyMRwTZ1OcNT3MS/PD1/iQZs6iXeUsXz6
         D8F+G91OgMadjtMcXkjXsz8K+ZIoMMiP+BfFH6lXpg55K+A95Nn/9SRaPUGJsRmi34DF
         /+89T5kU15a9UqW8YvN8xwir8PyM3JsGMy6kgh/LnWnkFx/KpsPkYAi0RSn1CM4tMR6f
         yFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193813; x=1756798613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIZu1BOm1KW6CSCAjuEXZwEfxI8pu50fmL2TsPS1NX8=;
        b=jBPSg2jjwEOvDawzjntiPRlcRbUZRf1I6qfdNrjlAqjnMW7lpPzofuwL6/6dGJf6Ka
         npZ8JdS5n2VcoZc4yFKzpC7Y0tRb7hB1MVN2edWZgZ0eszWPlkqKw/h7IYcGCdjHgB0g
         nGeufagV/+D874DR/g4qZmm8iL2ZhKxWWf1vG4tqSwK6bgFkfQ99Wdvrs0yD64IIFB6e
         Qkqbt7N71RTq1my7A33zSp0LqdCO1VqbwWuuuonqEeYpSmA7IACiwyAWRcGpwS3L0S2O
         f3y9TXRGV7VQUJdDqsP/5S7PR8EcBoOpDq5tq5XPZ3Rt7TWreKJPl+QxW72dZw4zEASQ
         ep/Q==
X-Gm-Message-State: AOJu0Yy+vL+Ib70vshPkgF9/a+AthUKMf6Ruz0AeaFAGpRUDRa68ckD9
	asNUBnid1fayLxekJRF424RWFEWn/wtQfITm4DvSGzrvwXQ2Sybvu4xAX1y5og==
X-Gm-Gg: ASbGncs1ZZcb2+Bt+ybNz+bMpIDFeKcagFUouEf6ZVQhHZe6GTYmGoTJbP6dz57kbYz
	6FeGotM47Ls5GvngEmdOFZSw1pG1TVCeZWe560z/iIw2g/RljEL5Sx+nHG72eRmjnJWZCyW66iG
	TCzTskDM1K6h1qX3Z7cEw75G5qIomIFTp4IBlT1JmxrPo5eoj+lVTevuas2QETH8yD4ZnD2eZE0
	zURQkI19VTSkhM0vSAuusUusS46a1R0XWgG1f9Mcz8a4g5XjjK9ONPs2QePy759zEOm9XjM1+ci
	F5PtPqPOZ0yN4lxIJu5FdyRyLyIVOl5gka2M4Gxj47NX1wvFhLW3C2I4GbKwUVZkc3wxaUw0qHu
	3bCQFyCJhai77que/M1oSAh4dN2hsCg==
X-Google-Smtp-Source: AGHT+IHKcmNMY6b4aBbSZfAJs9/2c2Fi5brEFPThbBJDqpSrYhQLPt+/tU5UoHLZBJ5ehly3eeLQTQ==
X-Received: by 2002:a05:6a00:190e:b0:757:ca2b:48a3 with SMTP id d2e1a72fcca58-7702fa048d1mr19531124b3a.9.1756193812607;
        Tue, 26 Aug 2025 00:36:52 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbe1sm4046216b3a.27.2025.08.26.00.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:36:52 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 1/5] builtin/pack-refs: factor out core logic into a helper
Date: Tue, 26 Aug 2025 13:06:41 +0530
Message-Id: <20250826073645.1074397-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826073645.1074397-1-meetsoni3017@gmail.com>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of `git pack-refs` is monolithic within
`cmd_pack_refs()`, making it impossible to share its logic with other
commands. To enable code reuse for the upcoming `git refs optimize`
subcommand, refactor the core logic into a shared helper function.

Introduce a new `pack-refs.h` header to define the public interface
for this shared logic. It contains the declaration for a new helper
function, `pack_refs_core()`, and a macro for the common usage
options.

Move the option parsing and packing logic from `cmd_pack_refs()` into a
new helper function named `pack_refs_core()`. This helper is made
generic by accepting the command's usage string as a parameter.

The original `cmd_pack_refs()` is simplified to a thin wrapper that
is only responsible for defining its specific usage array and calling
the shared helper.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/pack-refs.c | 31 ++++++++++++++++++++-----------
 pack-refs.h         | 22 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 11 deletions(-)
 create mode 100644 pack-refs.h

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 5e28d0f9e8..7c4d7854c8 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -2,19 +2,16 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "pack-refs.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
 
-static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"),
-	NULL
-};
-
-int cmd_pack_refs(int argc,
-		  const char **argv,
-		  const char *prefix,
-		  struct repository *repo)
+int pack_refs_core(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo,
+		   const char * const *usage_opts)
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
@@ -39,8 +36,8 @@ int cmd_pack_refs(int argc,
 		OPT_END(),
 	};
 	repo_config(repo, git_default_config, NULL);
-	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
-		usage_with_options(pack_refs_usage, opts);
+	if (parse_options(argc, argv, prefix, opts, usage_opts, 0))
+		usage_with_options(usage_opts, opts);
 
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
@@ -58,3 +55,15 @@ int cmd_pack_refs(int argc,
 	string_list_clear(&option_excluded_refs, 0);
 	return ret;
 }
+
+int cmd_pack_refs(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo)
+{
+	static char const * const pack_refs_usage[] = {
+		N_("git pack-refs " PACK_REFS_OPTS),
+		NULL
+	};
+	return pack_refs_core(argc, argv, prefix, repo, pack_refs_usage);
+}
diff --git a/pack-refs.h b/pack-refs.h
new file mode 100644
index 0000000000..ba51d154e3
--- /dev/null
+++ b/pack-refs.h
@@ -0,0 +1,22 @@
+#ifndef PACK_REFS_H
+#define PACK_REFS_H
+
+struct repository;
+/*
+ * Shared usage string for options common to git-pack-refs(1)
+ * and git-refs-optimize(1). The command-specific part (e.g., "git refs optimize ")
+ * must be prepended by the caller.
+ */
+#define PACK_REFS_OPTS \
+	"[--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"
+
+/*
+ * The core logic for pack-refs and its clones
+ */
+int pack_refs_core(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo,
+		   const char * const *usage_opts);
+
+#endif /* PACK_REFS_H */
-- 
2.34.1

