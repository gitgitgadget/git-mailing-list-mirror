Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1C304BD7
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270428; cv=none; b=QRmNAVCoTJ14m7yHA3/fWghhagzXEIGL8qBQCc9MHJBEQ2JfcRCfQ5chkfG1HuW1uaq0dKb26pm30VMzKP4xWRkT587j0+GsuqYM2oW+/Qj33G6Vp3ty6bTZ8sheDORq7dMvvQw2pmccHw0Be+H92AbuF+PgjZdMFlPNr5XmodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270428; c=relaxed/simple;
	bh=qHN3RAZAt1YCNeDWFoVQITcXZF7QjLl0QiyDU8P+RRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvMe10g2OoRm46wjWG3fwoNFT5HSsywa0yzeeW6nrSfmWXMUB1XYyGPcUk46zkdw179irK3xWrfpZgeUppO7UGFza4qb6mvrPrDeu9d9w5oThFQ2//IndHXPEQSlaLGk2r9fXxqGp25h8j/5nRvQ52YD/OFjm9NlSKgHRAg9Ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+LZf5nO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+LZf5nO"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so1559865a91.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270426; x=1758875226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQZ5sRG2u0Wf1FOnyphoFJPga2oq/Xzly+vSdTnDcpM=;
        b=Y+LZf5nOhIKiOtdS0XIep/I+msAi5JWE5Kk5DELzTIMpmMslBUZjAUH4UpfH7w0VJF
         OOQCWuEO0Nf9Fy1cDTOXd/q0DBW6MUSsP4pKQ/fpFNp+LA61SBXuxmBlzPVhMJ5aYIEN
         5Xh3aBJ0IilnvwL/3dvAnpbAtBiP8YCRwsxcGbBcxD8CSNPJXKumQLaGv0wA6ABC4Yuz
         J2Q1L3n6zuOhcJU9DJfLyRYaI7mqjSL61Bn/NyVvXW9r5ccbLztkQ66cHjI+mEInAXqE
         uSnhJZ1QsD1tIwIzCJAyno6z1KklU7161uW3FHVdtPv3tyaRQh1Ut3bq2pDK+ei1qEXV
         MYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270426; x=1758875226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQZ5sRG2u0Wf1FOnyphoFJPga2oq/Xzly+vSdTnDcpM=;
        b=rMVeSIzpIDeCpVyRB4K881EeLpiSfuxf1SGftF2BFF3dTD4vliY3KZi/rWg9GK1Shy
         VGCl2EERNuFx184AwvrnFzKFjIdOmbGaOzlgxCdJEwqLxVi4+hDYtjBmBUTVjRNQ5yZC
         zprAFSkIWznn4dVneVT1zruDH1qSaE6dlwBRN99d66gwO9yMR6JMMurgWC8WH5tPvYfW
         Qn0WuM7WhynYRNIvYh4NxyY8AIEbof5e1P/M1lgMm7xli1XQC8manJffiniMH7mb1vv5
         WlVJD6WZi6tvVDfEe5KenDkzJjLb+oVa1xiyuAFIcNTFA9I5HmUzc5aZWNo+viyp1j9Q
         9WJQ==
X-Gm-Message-State: AOJu0YxBXTq2uH5CmuQC8zfwGhEPEchjiKD/+6ldOlmBGRCE8sYgMwy3
	mqde9JdXSTFzZ5OVcI/psDF+kECgxFQgDn6lDQCVKNEbyd/QAX1cgdTRfEn9wQ==
X-Gm-Gg: ASbGncuEjTptgpH3M8JURf5zZBzzdyuEiGBjidxec9odZ7k3sh8AvTecwylQGwdb3a4
	sZzGL5G5V1fLML9QhK0KLwQ95vzQ3qInG3sWBb5z/mIVim/y4HKVMRRHPu3pLc8g6PsQmJqYCGr
	wKvCUSgC4JPVUWXTuEbM+60AJhfz1CuwMg8Z7ToFhuN9+bk962YUr89N6Ix2uNm4zsQUmUiLXhp
	kQWKE+jNtmNpg7X9bPoKazY0aslXKvsZAFjtAIbWxY9S2W2BCyeTMKOcSj9zoQQwDr4wf7Y7ZDg
	PQH8l41ossLaBMOpo7RSfxu+qUw3pE2NvvRAqgml69253GI5SFFUMUpHl5deCzGeBihTePmUdNi
	eqFYPBCwXaqW7JQHeaG0=
X-Google-Smtp-Source: AGHT+IGW1wgd2JQRPzm0qMXwjsTbqiFHTUWuj0hRW5OVWIkhSuDYyFt2m5bVsc2RPisQuODCOUV7Yw==
X-Received: by 2002:a17:90b:1d49:b0:32f:469:954c with SMTP id 98e67ed59e1d1-3309838e413mr2829304a91.34.1758270426185;
        Fri, 19 Sep 2025 01:27:06 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:27:05 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 5/9] builtin/pack-refs: factor out core logic into a shared library
Date: Fri, 19 Sep 2025 13:56:43 +0530
Message-Id: <20250919082647.535213-6-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
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

