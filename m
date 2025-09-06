Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE12741A6
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757145126; cv=none; b=gCT1bOTHJka0dsnMwPk26nkN1n+RuD2RAX7hbu6fqRk02DkiFV6BDeP2gyP0rKyBgmXS3pE9Us3y0mi9L7FJp9e8DgKJ5lh9+5PCcALPPjL1zHQFmTXiPKdeIS5BsS3g0NynXUVb5HzBCINr6SMfKOrp5LO/ffso0fdzMasxYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757145126; c=relaxed/simple;
	bh=faD+7BB8JhEahIkIhdmKK+0gfYt2/vLqQJaMHE3inas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFJ+EBqwPmBMqoK6gayE+YRlRFWDel55zk+DCfDXwQeAFZaStWDzdbAXq1h2KpXuruIF88KqOswzYZUsraAwe+NiNFqXGnYMZgR/at+//EDYGAgCrsOSt5oqnDza4EaKklUYA9fXBTmCQoWtiKyBiLojTYFRFPKMOVnFpUbJVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5h9ltP/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5h9ltP/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so3452325a91.2
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757145124; x=1757749924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQaNRTWRbGHJ8ZqTTtdcl+UYfULIQGE+SAr66jq2Pw4=;
        b=c5h9ltP/AJYHMMcSRoKI2iAV01FGcTMVTv+BwdW+3llkq7VIgI7Gh46EBYIdWMOsPc
         0SMAfK7gJNlVmEGShjcNQYk0Y6Fw4BhtBNswXoGCsYNQktLkNVAEZu63E40rYeZJ1Ixi
         SSQAjjFMiT3fsb6k7l4qVC+CB2am76xj54vyUkPrIydiGaDnKfRFDwYzk25WTM3/E10e
         qRUNfe3ozc+xQ+kVSoyRVGts8V09WydTL6AkNMlHhFZ3P9goEi6Yf/hYOMn3uwWlm+d7
         kM94OJQJLsV4gD1mAhf352kWnHrT+JRRljqORa319pAdalgCwp/ukz0WOeg175+cXjZY
         CUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757145124; x=1757749924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQaNRTWRbGHJ8ZqTTtdcl+UYfULIQGE+SAr66jq2Pw4=;
        b=o35o4FIWHKhOju81vx0dJR7pT1w37o5KFeEYT8M9gva0taWksWtoz/4WX+vBw59p11
         vfQ1O+bfH3rZw+o8XiQdhrfThK9czNG8Lttjv4u0J6kSzViOb9fvwhPQZ72i969DL+gK
         48EgIGNzih6GMgZG4oSYuutulVM8mhoPNlzvVlmVtMwUECuCkySmHZ/4EOHsrw40xOjm
         V85xmN8bayRQp0CFlQoabAaqlIR0Oi7ZbRfU9KO6dgSToPn7kmSOHAmbPSKqj8rvwFf3
         bTN9u+sE8ts18qogavS8zBcT6zsXyKQvIEC/ytIUqYNtWGFKgs4T+WyjQdHf2bkQ5O3I
         3Kvg==
X-Gm-Message-State: AOJu0YznSQoIApU7IFmpHyRyTWBrISdn/HnmCcRYgvKdn7+tirScCWDS
	9Gk/fMSDzAubp3fTSRwafCL+26cG9Q7LItN718ZWwUh1I4/xBYQOC9Gtf1T4CA==
X-Gm-Gg: ASbGnct9ajUYnhWLAd5W77R4IX4+vjD+SaXfdCJvWsaLy+V0d6kt+7grXAxyOaFJhV1
	FurX4+GlmEndwJWpCb/3LIVW/1nA29ZBfyPU5p8gvVEj8xms7b73Qc4YN1pKngN/c63raflv4H3
	slPvp2Q8Rg3Pp7DykrVAGJ0g+SqVHa3K+pSrW6wRHRyZNBc9zfG3AlDjNerI3+vbd9fGCfUFaNv
	DnhX85iRUQWrrlmwCQtz9pGOQ1vcHMSQjeXySIostitAKJVD8jTBRhC2XVNnWYnO6Qu2UQuclZ4
	tTWUQ2MzwAmf+B6M4IR0X4W05rsf5rHtWXTm5INxLoJIOQLIQt8sUifxMt0ltR/qEQHC5Z9nfIH
	L0r0WfPT9JP212SDQzAKPrFpQMvGpQg==
X-Google-Smtp-Source: AGHT+IEJPKXmLphur704/RASaKox8XzfLO6Fjis+79S3xoQ9B+NCPE5EeyxFGDrc7V2P4WSr3F3QSA==
X-Received: by 2002:a17:90b:3847:b0:329:f22a:cc58 with SMTP id 98e67ed59e1d1-32d43f47341mr2653774a91.12.1757145123568;
        Sat, 06 Sep 2025 00:52:03 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bd182256bsm3540929a91.23.2025.09.06.00.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 00:52:03 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 1/5] builtin/pack-refs: factor out core logic into a shared library
Date: Sat,  6 Sep 2025 13:21:43 +0530
Message-Id: <20250906075147.1076656-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906075147.1076656-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
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
 builtin/pack-refs.c | 55 ++++----------------------------------------
 meson.build         |  1 +
 pack-refs.c         | 56 +++++++++++++++++++++++++++++++++++++++++++++
 pack-refs.h         | 23 +++++++++++++++++++
 5 files changed, 86 insertions(+), 50 deletions(-)
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h

diff --git a/Makefile b/Makefile
index e11340c1ae..5d315e287d 100644
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
index 5e28d0f9e8..f9e0675c64 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,60 +1,15 @@
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
-	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
-
-	clear_ref_exclusions(&excludes);
-	string_list_clear(&included_refs, 0);
-	string_list_clear(&option_excluded_refs, 0);
-	return ret;
+	return pack_refs_core(argc, argv, prefix, repo, pack_refs_usage);
 }
diff --git a/meson.build b/meson.build
index 5dd299b496..0f147f4b13 100644
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
index 0000000000..a1f8ed1c47
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
+	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
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

