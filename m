Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06F306B27
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270433; cv=none; b=QhdwCOTJLmBPARgiw6cvH9Uu2dcFw7sgcOxw2jgrlVQ3VR44mJbMmrhYbWL9jK0Omuyfbh/qXy9o9sfW5d0O0nwndWdShKRUgeK44FmcyV6D92vQC1VeRMLRbBxWBCuFvkwhekcKZzOQlr+20cbGH2l7X1yTFKRprUAKvidWrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270433; c=relaxed/simple;
	bh=hnmgJ6eA0l6t2gPWUCQOy6kLDlFgFmFQr12mTI0sjIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHl6DPVpSnPl5R+xqjTR4qZplCbdW6bDGXwNYWJKCjckThdK2IchWxB3/PHNObiWsddBz7sMyiPTDVSzjiyYGX9yi9ovM3xx75QQnA8rZQODaw9UskxXkQ+Sk7wBCMnaR91xzMa7c/3iP2XhrwIjPRbmJGZli+ThqqQZlVONAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKmZMLbt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKmZMLbt"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5506b28c98so925228a12.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270431; x=1758875231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znfMJRKEPSBLVf6WmT6aa6CarCOQYozqB9kvFeygjbk=;
        b=WKmZMLbtj//OUf4quBZRRoA6Kc4Qg5C+6Ui1BeiwzoPYEOOzlQPEG5KjqTFxbHrC1t
         DACSLEe/riKEgn6p+jqB0/wFWlDURyWYEG5UtvDm47AjkkO9bOOW/Dy+E749myO8uNhl
         55s6e1l76jsE0n6RFj+zTwNDHe5YjS6lAQ8kQJl1t32a7+z20mAzmtjZsTOEdlayOA/d
         w50GFWvrBYsQRH71DDEq33QgWtc2fimwqSDA8NsfM3pnuhD9Du1G7SbwB7ZNcy4rOqHt
         vtW3BzxWDW18at7zedzGBXDoDhbHF4XKlLwyuLLh5ccVG/v6lCFtduPyG3aQWn5mtpWY
         0kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270431; x=1758875231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znfMJRKEPSBLVf6WmT6aa6CarCOQYozqB9kvFeygjbk=;
        b=USyK03SqRSClhAT8HksQAJGyVPnNmbPWK7tL2wr19HDRKbSfUA6Z523YAoErzixowU
         NBX/EbF2hN0OGUY/7PD0iD4TKPdi+LpmaX3f8CVvH3CKtJ1nOdNoiHej+eWaXMVg1zLs
         GXrdB1AzPPpRM1571QFoay1yJWbJChFq5QPUz0YI2m+pYnYNT24s05xrBBMvy++NO+Jx
         s2nn7TEe/cczM8W89XyZ1QXTAyiqfhRatl5syW9wqO/QX+6v9+33CZc9ttuKaPMLaGTc
         YfTkusquDorq+1jIfcrvBsJxYg7aNJLMN08S/dNBIvBjzv3NLYgWgIYMh23yTHmeo6w9
         EGgA==
X-Gm-Message-State: AOJu0YyJSetq+CpPgqBqtS749vkhpg3w1TOVcpjadY/Oj8Y2RfGFSQGC
	RnMS6ZXm+NIsBOIU5WMtJKUH1QqqdNwcQxgB3LQON/U8OgNhB2CTBK0RnRHIEQ==
X-Gm-Gg: ASbGncviMEKH02a1MMaJ5thAsd7nIkMmgfHL4CFAZ3hnjZdBoFKUqXiIQlJiGvm1AM3
	P3a6OvwjfTB8E1wdRLyBEMXH3Rc7Qi2rTbiGcaALqencGYvuUnbXV94HdUpkPjQegVCz23tdcZw
	c6LhsEeWGKc7bNSCcN6XAbjAUDwVNiOiqZsvsv/dpOz4tf3eFJXRAE6GuiVp8wR+UJgB59G1xeI
	tV28VNGV5iG5gMkL6f939d09tqprsB5MQ8ipCyfNIj8kp8RgenVuT4zqDMsj+OJ/BbHly9mYdG2
	4FiBTn2w5wdMUVbtujmcoYfXI7qMC8J+GReN8skmqb0zSU9BCZy21ezWqRuiS4y/Nd87TcB29/m
	dgGpODZmjU5aLEwJ+2Bw=
X-Google-Smtp-Source: AGHT+IGc1yeVxDVwcor3GVDKGp7cdnQ6iM+iUVE59VhCOsSsuVJlelgau8uxGlZWSixQ8quk1Vaivg==
X-Received: by 2002:a17:90b:53c7:b0:32e:a60d:93e2 with SMTP id 98e67ed59e1d1-33097ff6462mr2862808a91.11.1758270431338;
        Fri, 19 Sep 2025 01:27:11 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:27:10 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 7/9] builtin/refs: add optimize subcommand
Date: Fri, 19 Sep 2025 13:56:45 +0530
Message-Id: <20250919082647.535213-8-meetsoni3017@gmail.com>
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
index 76224feba4..785f476e4b 100644
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
+			     struct repository *repo)
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

