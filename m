Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB929A9FA
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174452; cv=none; b=trgS55UBwhg0BvzuyWJvN9okjKq//s7NDiX7lCFwSkMURulg6YT6dJfI/lno30y1JJVXkfLD57HobQBLp8/Ms5P7+k75YZCbXuZiEar8y9r2oRy/dzISby7g58S3ZWJYkUgttr4hlPhuuf0HZkqj0HareSsM1NZcy4tgy7aaeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174452; c=relaxed/simple;
	bh=Pme7RoL4F91fvMOe1UH0kgccVP00F042q8IX/Y12iCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCkSNZf45OW3AeL+h5K5sOs/EhBFlBmaz59aGgg3lnHpMUCdgievVDYymzdiyHOS2rDZLw1lMDDrHJv7tQlxQYQWhFZWgZ4EypP4BQ9vvy1Axok3T4KczGZeBYhJ9HPV5ObP00u7vETyF3XnA5SAuMHUUK62H1K6RjJLmsaIk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MujvrNsl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MujvrNsl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26799bf6a2eso5706765ad.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174450; x=1758779250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVZEAdpKR8JgjiTUW+x6WLrqZjtrmF9cqhgLDeqQcMs=;
        b=MujvrNslKqGCKI1TVppErm1Z2hsJqzsPyGKIiVZeqrywItCssTBv2or1c6Ugz6zjhf
         RJljA6yXbzsTHCqJrTtra97ixPy0j5hGyZJEYmV6uxDtuaA/3+V39G3qk2a9HN0xDsjd
         cLxRDzpFpuMQAG/L4q2vbiELoaY4Lq2I2/mlOFpDRYaWWY344nvF4Efnl9ANLRyP/dHc
         Rn1D8qUU6mWwrs+yAm+9Kbu4RDfQLKZg8bWSLsF/9omLNup2zNuK5eYqHNQgT9+zDg/m
         YL2YvjVvZAu1hZmKRnoQj0eNyXqhzeNtsAvZ/xM84jZkDljMy+rFf6wnKEvYMcqyq4pl
         2RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174450; x=1758779250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVZEAdpKR8JgjiTUW+x6WLrqZjtrmF9cqhgLDeqQcMs=;
        b=ak/uVAJEWQH+0idc8tK3MQ/Kpy5M9+6l9Slav9aHNyXRRKX+B8tar86l3iHPOxLtHH
         cZkxqh1lM9MazdUaAvcNi+SwuaRAuCFkgnoXgbkKekxKfcj73i0XBUiWpWqHCU+hf1ow
         8wrRbw/VOovrfNgWGH4b9QFj0OGaz1bsJx7GCMbsqPetxr+hLxCI/N9WbcaqkiKTF5Dz
         rpzvpUgd0mNcP2BFII3RmBKdhSmEBh/1PlIOx54JJuzcDWL24h+o3qm+0GNxLgDQzsR/
         j8wYraWpBd/o/3eQrHk0KHlvrX8RY+bwzdK1jX7JcBIeqrH4RjY5k8DjezFfwzMrFV9+
         46qg==
X-Gm-Message-State: AOJu0YycMAMrzM0NGQD6OONXmL9d0VBP+U9HA6jvVPNgNrEz7AvCkpeD
	w1hXfzbQm/0nJIyaL0tDU3XQlCXVdOWhlXnsMropkDxaYKGhqd1j8W2s3QbReQ==
X-Gm-Gg: ASbGncv27cZIzR8RfRgkP72IjPwBJ1WAJbUMbHAResM/FCtXN8twiCXf5ZNdZ/xQRCV
	073Svi3/PHD0zMy+Y4Y87pmpW9GjND6XL6F5aKdg2qvNqUBqnjsJCqc1i2pXhDrbOBfM5C+G+KL
	Qsz6fw0nPyGUswiTlyrIWyhUfCZq8npMoqUErXr7vAd6T6ysS3PPoVs9Ja455As/FL4GwS4JKD8
	5B/IhXs/rlO8d1mRsf8d9CQ7MHMyuLks6DyovY5T2wcZ3pnHQixvRH9NYvANMSI1D69S4SU7wSY
	LOZxIVkmtA+100Gbc1A4Ai1GlgfRB0KyBHHT2gtXheqFJZe5xgpZVhIfvbgY80EB0TFBpnukRD0
	sIys+x2ndaWqLf+QXtN6MZZqGhJYYncguxgc4wA==
X-Google-Smtp-Source: AGHT+IEi1Skr+8uF7v7xEPN0zu4S5MN3hKvBx/vn6ueXcalDrjTllvVMy7Rs5TzSbrcS4vEX9SF/+A==
X-Received: by 2002:a17:903:1b46:b0:267:e3af:ae67 with SMTP id d9443c01a7336-26811ba71c2mr55884625ad.14.1758174450040;
        Wed, 17 Sep 2025 22:47:30 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:29 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 7/9] builtin/refs: add optimize subcommand
Date: Thu, 18 Sep 2025 11:17:02 +0530
Message-Id: <20250918054704.544254-8-meetsoni3017@gmail.com>
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

As part of the ongoing effort to consolidate reference handling,
introduce a new `optimize` subcommand. This command provides the same
functionality and exit-code behavior as `git pack-refs`, serving as its
modern replacement.

Implement `cmd_refs_optimize` by having it call the `pack_refs_core()`
helper function. This helper was factored out of the original
`cmd_pack_refs` in a preceding commit, allowing both commands to share
the same core logic as independent peers.

Add documentation for the new command. The man page leverages the shared
options file, created in a previous commit, by using the AsciiDoc
`include::` macro to ensure consistency with git-pack-refs(1).

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc | 10 ++++++++++
 builtin/refs.c              | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index d462953fb5..e233f21eeb 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -18,6 +18,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | (<pattern>...)]
+git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 
 DESCRIPTION
 -----------
@@ -38,6 +39,11 @@ list::
 	formatting, and sorting. This subcommand is an alias for
 	linkgit:git-for-each-ref[1] and offers identical functionality.
 
+optimize::
+	Optimizes references to improve repository performance and reduce disk
+	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
+	offers identical functionality.
+
 OPTIONS
 -------
 
@@ -73,6 +79,10 @@ The following options are specific to 'git refs list':
 
 include::for-each-ref-options.adoc[]
 
+The following options are specific to 'git refs optimize':
+
+include::pack-refs-options.adoc[]
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 76224feba4..ae395759bd 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
+#include "pack-refs.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
@@ -14,6 +15,9 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
+#define REFS_OPTIMIZE_USAGE \
+	N_("git refs optimize " PACK_REFS_OPTS)
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -113,6 +117,17 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
 }
 
+static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_optimize_usage[] = {
+		REFS_OPTIMIZE_USAGE,
+		NULL
+	};
+
+	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -122,6 +137,7 @@ int cmd_refs(int argc,
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
+		REFS_OPTIMIZE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -129,6 +145,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
+		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
 		OPT_END(),
 	};
 
-- 
2.34.1

