Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010E2ED84A
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190485; cv=none; b=IsrVH4Vlt8fATGPduJjsnusI6K2cKlyo7z3U4D1T+LTWMBxovR7OFfPdAkjg/KWaB3Fq9r7/ikDNzKMEezdeuk3LfXQWNB7C1gZSaxAhD6sv4RJVlwgoSFAHIq9u9GF60L+SAAhOmO3uzbjpt3geUXsCW/5t5BklznpJVWTWfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190485; c=relaxed/simple;
	bh=xxTKgC+d3PAUx5E45QVCgEeEsfsrRgbg/pU2EwsnP5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELvXQvL68vxTnoOmX+iNHc/LjeogBY72v/yaCNnUNnBM5G/fb5DY4KhS01yiRAnFbAI430bgGoCmFPhmlakcEkySqob4TfoRWJZicGztPoWufdc4mpljDjtyOsOeZXewzcOn23yxrlJVM8cfPuqNl8i+2+9pPUcZB8xXPAk/vFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSX9zoFu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSX9zoFu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47174c8e45so5113460a12.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756190479; x=1756795279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Mgi3P0/fnSNbxBr2N4VCmZ2sMEchZqLIPkDVnzr0mA=;
        b=jSX9zoFulbhANJkzVw9VLIXbC+KVoltMUn+eoN2XoTpNXYQc8EuRb2Rvr1ust2xkj9
         QCxbwd8rylZbwhAngShQ7dRqPR232uaLWsM3s+rOv4A0ZkqO0yzdtF4xDzjRlAJzSYUm
         kCsrKz4DXomFvPK4TAMm6nK5ShfKDSRXx0NofnlS2UM3Uroo+Vga9oAMlI9/3ZF21TcN
         DlHX31hGMdCP0oyFyRDcWHOD9b0tBTm7LRWIAUgcOM0N/NuwdsPsxVnWMX6P9LOPUr1H
         /U1BZDKRTg15CsYnQTxhZ8lftnmosTzh18S/rAvj+g29BrzQrTI6xbriGlmM/kRmPkDH
         jRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190479; x=1756795279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Mgi3P0/fnSNbxBr2N4VCmZ2sMEchZqLIPkDVnzr0mA=;
        b=NTQWkPFDj9bN8O1X/oMlfnRY1Orf5cd0/RuYnUC9dCn8z1MdOo6eSk767uuXmqhSrQ
         dx+2j+BN09GU91aNU6f2p/9RjSyj8cufmZQZi81hnIo+ZBkFQujhB7Rc4HwQFFsBYSZB
         r1neqtxunzX+cKqI3lLICpiT+IyRyqFMldoGVchj79dzGB6gbIz12FerZhHe+CMpZUC3
         y/LEY3C+zOOmGY4c+FJDRxZe2Aj8fEcH//bCvHCHaF/HQEsPTLRbNZZdzdViDGXwh45V
         4CceUhUpGwkHWVhpcXWNh6LXWG6sUh50Cv/1gIDgYraYPOyS2twKLVZlV2CMoiMG9Otq
         jRng==
X-Gm-Message-State: AOJu0YyhwpVg2fiOq2cQdltM4oXSpvyeazFACX9/cH5tCCSBT0i56IVB
	sieoSsSszkqHKu2iNTFYuOMmkgAkZbBZbODEjxifiJvy7Am/wCACmiMvqgECKg==
X-Gm-Gg: ASbGncu8LXAP6+o2fO/J/Y4Dtd4wwDjySQ2hgxra0515+4aP3FX8IUt87CSchf5ABHi
	fO4RC5qQN2pt82ishkRrr5jbJTYTg1PQU69YtVsZ7hE5AuYIyCNqQ8gFB0vwiMH+8+KQck332qd
	KncrZJWveP0hhllgcWSMLQDd+P/GVF2FU/F6QJAGsVzk0zF+YB/itvbzUZWG5E5WcU6B2yN+jPd
	izREpPNqrZTqw2o+d72FUMFfdB3CZRhS0p+Dtz+L+TjyOxXccBD8+BpIzutgQ4v73kC3pjTglSL
	dIh9B3yZ+gKY1xRobAAk8Msv59qBGZ46nibTlfTmjzE/8/X8dpFLf4RuVLcmzpkh5RtarNHvFg+
	wN1BVR6QJRwX4Um/4BfU=
X-Google-Smtp-Source: AGHT+IE1MeHGuvviU3k5Nj/j0rXBDky3GUxEW9amDqZWjYNY8oHwqf2hW2bWCsr432vnwMyRnxM5iA==
X-Received: by 2002:a17:902:d60d:b0:246:44c0:a8ec with SMTP id d9443c01a7336-24644c0b418mr162483305ad.35.1756190478766;
        Mon, 25 Aug 2025 23:41:18 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889ddc6sm86442025ad.159.2025.08.25.23.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:41:18 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 1/4] builtin/refs: add 'exists' subcommand
Date: Tue, 26 Aug 2025 12:11:07 +0530
Message-Id: <20250826064110.10540-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826064110.10540-1-meetsoni3017@gmail.com>
References: <20250823060012.540433-1-meetsoni3017@gmail.com>
 <20250826064110.10540-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the ongoing effort to consolidate reference handling,
introduce a new `exists` subcommand. This command provides the same
functionality and exit-code behavior as `git show-ref --exists`, serving
as its modern replacement.

The logic for `show-ref --exists` is minimal. Rather than creating a
shared helper function which would be overkill for ~20 lines of code,
its implementation is intentionally duplicated here. This contrasts with
`git refs list`, where sharing the larger implementation of
`for-each-ref` was necessary.

Documentation for the new subcommand is also added to the `git-refs(1)`
man page.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc |  7 ++++++
 builtin/refs.c              | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index e608980711..5d2032b318 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -18,6 +18,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | <pattern>... ]
+git refs exists <ref>
 
 DESCRIPTION
 -----------
@@ -38,6 +39,12 @@ list::
 	formatting, and sorting. This subcommand is an alias for
 	linkgit:git-for-each-ref[1] and offers identical functionality.
 
+exists::
+	Check whether the given reference exists. Returns an exit code of 0 if
+	it does, 2 if it is missing, and 1 in case looking up the reference
+	failed with an error other than the reference being missing. This does
+	not verify whether the reference resolves to an actual object.
+
 OPTIONS
 -------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 76224feba4..91548783b7 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "worktree.h"
 #include "for-each-ref.h"
+#include "refs/refs-internal.h"
 
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
@@ -14,6 +15,9 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
+#define REFS_EXISTS_USAGE \
+	N_("git refs exists <ref>")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -113,6 +117,48 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
 }
 
+static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
+{
+	struct strbuf unused_referent = STRBUF_INIT;
+	struct object_id unused_oid;
+	unsigned int unused_type;
+	int failure_errno = 0;
+	const char *ref;
+	int ret = 0;
+	const char * const exists_usage[] = {
+		REFS_EXISTS_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, exists_usage, 0);
+	if (argc != 1)
+		die(_("'git refs exists' requires a reference"));
+
+	ref = *argv++;
+	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+			      &unused_oid, &unused_referent, &unused_type,
+			      &failure_errno)) {
+		if (failure_errno == ENOENT || failure_errno == EISDIR) {
+			error(_("reference does not exist"));
+			ret = 2;
+		} else {
+			errno = failure_errno;
+			error_errno(_("failed to look up reference"));
+			ret = 1;
+		}
+
+		goto out;
+	}
+
+out:
+	strbuf_release(&unused_referent);
+	return ret;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -122,6 +168,7 @@ int cmd_refs(int argc,
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
+		REFS_EXISTS_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -129,6 +176,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
+		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
 		OPT_END(),
 	};
 
-- 
2.34.1

