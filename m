Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78682D7801
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174447; cv=none; b=kbeMKJED81U1kpxzP8O57MXxaku4f0ndUnpybOjgGzjXmobMGEbLw46LrJRrzUKfNWV2pkFVBy2HLSf9e+yHI7lkDzkqx2fFvP841elZ+eJA0ytt8BGAg+pYO7dmMhABMbOjbF5DLq1HJ1v19VHmzdN9xIzrk5oazbk1El5h5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174447; c=relaxed/simple;
	bh=qHN3RAZAt1YCNeDWFoVQITcXZF7QjLl0QiyDU8P+RRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YIrHivytqBg4jLrCus+z8ZNs8ROMqD3mtQ1lb1DgBXd+lI+pbxW7nhXiFlkLxxgK3ePgroFUx02dK7aXcrWzYPp/2R/2dWIPkG0kWD2alnZgsVAkypxOlAWUWIYObHFCQoAbKMxwlWKGri9q7mVGWiJCCWH9pC+dwB9U6dB2i1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXIAcqhp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXIAcqhp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-25669596955so5540825ad.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174445; x=1758779245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQZ5sRG2u0Wf1FOnyphoFJPga2oq/Xzly+vSdTnDcpM=;
        b=fXIAcqhpZRozIg6cPLZTjm/FHfoB2qnntOMv8FuLGIX8zcbsvCNJ6VCRZ+Qth22qcz
         kuh8qRyo9Vw3c7n/iFEVCqiL9LfZtq70vVuYxGSRnxnP99LW2lXCusNY5VFHGkLGs1Ds
         tnnOIsIl+RRlaekHvAQkZmd6JDiBVbONL09IQ55awwAMB1rt6KVmfRQm2ctCTJbt6+jG
         9m51dC9BcmTW/+sQhzzOJKm1x3Q4E9hx/lX/SKg307EXfF+CS16A/dOqPlb7IETxH3Hs
         b0a5J42yrd5z1+WTtsrMnEgRrj/Kt06I3eNa2HcykUQjYSp4o6dpxdGLTejJ/KPLosDw
         DBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174445; x=1758779245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQZ5sRG2u0Wf1FOnyphoFJPga2oq/Xzly+vSdTnDcpM=;
        b=tboffSpLAU6URiuO2urzJWbBjXtqceTHEXd0Tn+YGXf+ve5nPU2ec+7jyi2OKFSzg/
         4X+/lUGv6sb2J8Ezus9gO3q9jCZ8VJJMZTbrdWOvKRlXegKQ8tw6tVBv+qp1UCsMBBw+
         wp/fV8YxxxCFqP/rtLD+2NKgSmHkmSu6VNCmg8Hb+spx+wIWGuFMG/VKAiM2K/VDQHdo
         Ou3W5976XmpkOlLVYATtSOTennCJsmw01Z1K5fkC3KDGutbfU/2X1siXCQJa6UMVC0RK
         TKO58I2qhETAKk4Ewxu+KSfz1iNTaV07VZ1FBrqUzrOovDNPNAj/YbpJgiL4CFv2owZ7
         cKMg==
X-Gm-Message-State: AOJu0YyvMh1wpUcFRqsp78qnCQEsWoZ5KyGisuDT48Ir++CWd3XFUv7S
	NUaecc71YU7Mipca0UF7tRJ1GM5RDhws7s0e7rVkd7aENTyk62T0ulVx5dNsjg==
X-Gm-Gg: ASbGnct5KvScZ7Ca6Yqw0WGS6oKd705O2wO8CKJpLI16NoiJPyANdtjB39iDD2q8PRc
	d4NCKF0Ld3EHuuwQE/yALqcruTIFm39Wp9orcnwXCUTq6OMotXimdGK4AUnWqRlQP7hk41VuAoi
	MtFqUpOIcyHBweHhZNy6bQ7PjbhGHMsGr4+52v3D29a+VFfcnNMAO2TE9PyeyvzWyXMg1pCYT5+
	LPG/k2FMh9YzNLmoqLX6egX/zEBJNsG1dhiAtI2NTMPrgq22OIfCGBLi2mTi3ArD1zE/9LSCc8L
	pqG80wUQHJGxqmfBkcOZ39nNTXX0P17WfBrun57e1Oj38sqXkMsxiYj3gbZG2p9bxfCBYCs6eSt
	x65eHQwETHyrTlrtvyoF6n4Ch0Lkqy5vX0Beqmg==
X-Google-Smtp-Source: AGHT+IFGq0ROqg1PisI+hH7CuWce1pHZyLbslSWjvOo0FvAXhPsxWDB14iEYfzddq/TtXPcPhi8KVg==
X-Received: by 2002:a17:903:b0b:b0:24c:82ad:a503 with SMTP id d9443c01a7336-268139f9675mr49776635ad.41.1758174444779;
        Wed, 17 Sep 2025 22:47:24 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:24 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 5/9] builtin/pack-refs: factor out core logic into a shared library
Date: Thu, 18 Sep 2025 11:17:00 +0530
Message-Id: <20250918054704.544254-6-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
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

Split the original `builtin/pack-refs.c` file into two parts:

- A new shared library file, `pack-refs.c`, which contains the
  core option parsing and packing logic in a new `pack_refs_core()`
  helper function.

- The original `builtin/pack-refs.c`, which is now a thin wrapper
  responsible only for defining the `git pack-refs` command and
  calling the shared helper.

A new `pack-refs.h` header is also introduced to define the public
interface for this shared logic.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Makefile            |  1 +
 builtin/pack-refs.c | 54 ++++---------------------------------------
 meson.build         |  1 +
 pack-refs.c         | 56 +++++++++++++++++++++++++++++++++++++++++++++
 pack-refs.h         | 23 +++++++++++++++++++
 5 files changed, 86 insertions(+), 49 deletions(-)
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h

diff --git a/Makefile b/Makefile
index 555b7f4dc3..f51297ffc3 100644
--- a/Makefile
+++ b/Makefile
@@ -1094,6 +1094,7 @@ LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-mtimes.o
 LIB_OBJS += pack-objects.o
+LIB_OBJS += pack-refs.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index dfcf664524..3446b84cda 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,60 +1,16 @@
 #include "builtin.h"
-#include "config.h"
-#include "environment.h"
 #include "gettext.h"
-#include "parse-options.h"
-#include "refs.h"
-#include "revision.h"
-
-static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"),
-	NULL
-};
+#include "pack-refs.h"
 
 int cmd_pack_refs(int argc,
 		  const char **argv,
 		  const char *prefix,
 		  struct repository *repo)
 {
-	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
-	struct string_list included_refs = STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_refs_opts = {
-		.exclusions = &excludes,
-		.includes = &included_refs,
-		.flags = PACK_REFS_PRUNE,
-	};
-	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
-	struct string_list_item *item;
-	int pack_all = 0;
-	int ret;
-
-	struct option opts[] = {
-		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
-		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
-		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
-		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
-			N_("references to include")),
-		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
-			N_("references to exclude")),
-		OPT_END(),
+	static char const * const pack_refs_usage[] = {
+		N_("git pack-refs " PACK_REFS_OPTS),
+		NULL
 	};
-	repo_config(repo, git_default_config, NULL);
-	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
-		usage_with_options(pack_refs_usage, opts);
-
-	for_each_string_list_item(item, &option_excluded_refs)
-		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
-
-	if (pack_all)
-		string_list_append(pack_refs_opts.includes, "*");
-
-	if (!pack_refs_opts.includes->nr)
-		string_list_append(pack_refs_opts.includes, "refs/tags/*");
-
-	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
 
-	clear_ref_exclusions(&excludes);
-	string_list_clear(&included_refs, 0);
-	string_list_clear(&option_excluded_refs, 0);
-	return ret;
+	return pack_refs_core(argc, argv, prefix, repo, pack_refs_usage);
 }
diff --git a/meson.build b/meson.build
index e8ec0eca16..cedaadad2e 100644
--- a/meson.build
+++ b/meson.build
@@ -407,6 +407,7 @@ libgit_sources = [
   'pack-check.c',
   'pack-mtimes.c',
   'pack-objects.c',
+  'pack-refs.c',
   'pack-revindex.c',
   'pack-write.c',
   'packfile.c',
diff --git a/pack-refs.c b/pack-refs.c
new file mode 100644
index 0000000000..1a5e07d8b8
--- /dev/null
+++ b/pack-refs.c
@@ -0,0 +1,56 @@
+#include "builtin.h"
+#include "config.h"
+#include "environment.h"
+#include "pack-refs.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "revision.h"
+
+int pack_refs_core(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo,
+		   const char * const *usage_opts)
+{
+	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
+	struct string_list included_refs = STRING_LIST_INIT_NODUP;
+	struct pack_refs_opts pack_refs_opts = {
+		.exclusions = &excludes,
+		.includes = &included_refs,
+		.flags = PACK_REFS_PRUNE,
+	};
+	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+	int pack_all = 0;
+	int ret;
+
+	struct option opts[] = {
+		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
+		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
+		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
+			N_("references to include")),
+		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
+			N_("references to exclude")),
+		OPT_END(),
+	};
+	repo_config(repo, git_default_config, NULL);
+	if (parse_options(argc, argv, prefix, opts, usage_opts, 0))
+		usage_with_options(usage_opts, opts);
+
+	for_each_string_list_item(item, &option_excluded_refs)
+		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
+
+	if (pack_all)
+		string_list_append(pack_refs_opts.includes, "*");
+
+	if (!pack_refs_opts.includes->nr)
+		string_list_append(pack_refs_opts.includes, "refs/tags/*");
+
+	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
+
+	clear_ref_exclusions(&excludes);
+	string_list_clear(&included_refs, 0);
+	string_list_clear(&option_excluded_refs, 0);
+	return ret;
+}
diff --git a/pack-refs.h b/pack-refs.h
new file mode 100644
index 0000000000..5de27e7da8
--- /dev/null
+++ b/pack-refs.h
@@ -0,0 +1,23 @@
+#ifndef PACK_REFS_H
+#define PACK_REFS_H
+
+struct repository;
+
+/*
+ * Shared usage string for options common to git-pack-refs(1)
+ * and git-refs-optimize(1). The command-specific part (e.g., "git refs optimize ")
+ * must be prepended by the caller.
+ */
+#define PACK_REFS_OPTS \
+	"[--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"
+
+/*
+ * The core logic for pack-refs and its clones.
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

