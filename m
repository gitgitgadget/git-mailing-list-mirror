Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C3280CC1
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757145131; cv=none; b=T90uJF+3K9qQeLPZYBL0IJFZ9Ree7oPQqRQ2HQaGcA1VU5OXXU3PapuPs4AndxYdJexI6AJ3gUs2S0QD2c+CoBfUQaNtjXJvLTiKkHklMx6iMM3pju9mXDD8J8GZIkZhxv/gGioVYBtdh20N3SxzrEIbkXkYUYa0D1YeDqfWBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757145131; c=relaxed/simple;
	bh=lqe8CjTY1k2nL77eN4Xrl3Be6cVn3EiW5kWGvRdI4O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lT7btnCs3bc6mV0zhQnGIbktVQCri9674IkvIEY9GetrsWhkWj5VHakd9P0ES8Ov1Vfj4+gx4sNs04PRvM6lnoRh3A0u4aVAvf+0kXlNH4hvKjGzCfauVHTedAnA7/7iKQUlfA7kXMQNG/IaCE0vHr7DhR/dfk7/H3CcOA7paxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbE+z551; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbE+z551"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b590d819aso2345876a91.3
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757145129; x=1757749929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH2zeFuGoP68ugjA24IEOQzRE4VSGQwW7A+auyVNyQ0=;
        b=nbE+z551IFZoHMufbxAtCJnSkdQLoya+jnTUNMxBAqjW3r/ehjguRQK+NvhxAAFiX4
         bM2tMk7xNGYdJz6/w0b/V8cCw0M7zAtJq0Fo7kGjLBpXIdJRkMeB30brHHwHJtwoBL1z
         Tr6oHbyI2gU/Z4sq0FYDpnVWpaPBfqPPPHsEx0kJ8rP5A79SSF7QiQt6Zz7cdN+asTD7
         YsSz0aTAn93eeS9yGcksiu6ya2Ka+dt6ig5IDiW7YdgzX92rMAw4NWB95xpj8v4BNQpB
         Nw8rR7NDcRaZATr/LuizaIJNJi6fCuluEdlJI9EXkQWwtOGXwg3hplb4BWBSsOUQ1TrR
         XqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757145129; x=1757749929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BH2zeFuGoP68ugjA24IEOQzRE4VSGQwW7A+auyVNyQ0=;
        b=v2k0xh1G4nWOZEAXhg73vSYhgae7JSfs5oi2xQz1glntllNG3Ci6h01eDTFuD9T/uD
         qI4o5L/7MpGkR3UC7HiVFkzCLabAUnL+zpAJXlOyjyOsfrRf67sFwdqsKFGnw9JUr4l/
         cHVmgzGteayWrTbNugfLhEDPEMOI7sa88d6WL+v/dFERDyQlA1VrC0/PRXFbyJtx63f+
         OabfY7yn6DAv6ydFNZW2J2kGed+2XTewmi3sUf2JK2D0AiuR2Ux4jNG4JE0Z3cTdy+/T
         vsWl0y1LO5qoc2KHBuu9Y7OSrH3Xitc8UWUJFDUltUfeADhnlUlDgv9gK9Omrt+DR3I2
         ckKA==
X-Gm-Message-State: AOJu0Yy/VkI1OkgaB95OL5uQKieUOs5sPUJ5o7/om8VyMQ0rI/gz5Uwr
	lJPkc2b80lFvxhxCZCLI2h0whZ2/9oiTC1gWf54/gtAY4O3asxzx+ztz0D+iMA==
X-Gm-Gg: ASbGncsihQ3YeFknGZHE+PRigt3nCqGhQze83r58ftSdL9spg6jSNXoy5bkqyQYn5hj
	oPPGcmBOAhWOZNvAr2aJnmSXVwFocwpgWQRZX9LS8L1gl7vJD5AKAfExy7XXXVhvUaXGjKY/yqK
	WER+uYgYAaU1zTzSXY54yJkR4yIWhYNACMeXkTRD1EOh2tXpHMQ9Uo1ATNcoCfmtkWvz+8TElmv
	pIfe4GQ+pyZ5O+X3l5m/DbBQv5vsyuLy52R72im/fZWAMeQsqFeQkoDu6m7tUa0WDbUlG9N57q8
	0Z3belTZDQe29tjd91znTx/c6aqRQFMbZutcyAoqOI65o6+FbtbTFQFNE2P8GMRDvKmZtChR1lT
	iAMY3F9rob/QmXS+8vdk8QvYY3AEGJg==
X-Google-Smtp-Source: AGHT+IE9ZW7m1+E8cUC/7oZLWHlqFz6EhZuy6LMUWJ+Obt5zJXqKMBH/HG6gW33QCP7YTAp/lBpLcw==
X-Received: by 2002:a17:90b:3cce:b0:32b:cba3:6368 with SMTP id 98e67ed59e1d1-32d43f2f44dmr2275911a91.7.1757145128830;
        Sat, 06 Sep 2025 00:52:08 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bd182256bsm3540929a91.23.2025.09.06.00.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 00:52:08 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 3/5] builtin/refs: add optimize subcommand
Date: Sat,  6 Sep 2025 13:21:45 +0530
Message-Id: <20250906075147.1076656-4-meetsoni3017@gmail.com>
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

As part of the ongoing effort to consolidate reference handling,
introduce a new `optimize` subcommand. This command provides the same
functionality and exit-code behavior as `git pack-refs`, serving
as its modern replacement.

Implement `cmd_refs_optimize` by having it call the `pack_refs_core()`
helper function. This helper was factored out of the original
`cmd_pack_refs` in a preceding commit, allowing both commands to
share the same core logic as independent peers.

Add documentation for the new command. The man page leverages the shared
options file, created in a previous commit, by using the AsciiDoc
`include::` macro to ensure consistency with git-pack-refs(1).

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc | 10 ++++++++++
 builtin/refs.c              | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index e608980711..91cfbc18de 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -18,6 +18,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | <pattern>... ]
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
index 76224feba4..e05fa5b8a6 100644
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
@@ -113,6 +117,16 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
 }
 
+static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_optimize_usage[] = {
+		REFS_OPTIMIZE_USAGE,
+		NULL
+	};
+	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -122,6 +136,7 @@ int cmd_refs(int argc,
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
+		REFS_OPTIMIZE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -129,6 +144,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
+		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
 		OPT_END(),
 	};
 
-- 
2.34.1

