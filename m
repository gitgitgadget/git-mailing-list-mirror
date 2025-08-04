Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11253242D9E
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299403; cv=none; b=px/88t5RioIFN7AH0mtjiIcTO0E/65+VDEfQ+vSkIGeIhIhO47OiHppVqOZjLv93yLhfyL72hwaAyLNrCHMc+NWIcSimPUezW9gErhIFyVqE/jSOaTjTdoDYyMzE/isYpAXCz9j5k1HOkj8MD3XK1Z2Wfnc5gaM87QD2HcH5UvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299403; c=relaxed/simple;
	bh=O03ox2OTdC+Pr8/JR3Kv6NY57XZn7dd4WT+2p1tL49g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FvXjrKwrXSOQWgAkspk8VYeeO0socckz+vWzYOPa2p0z/FsdRiTdkoWaEUbOCWhHwbPl/LndEdu3DfX7whVWS3P4IlinQk8npss/w+MA2vLk2zUSJMGy622XyYbESt0F1Su5X4iKB9si5FkBqHjt9VsPlMASRHJ4d2jsnTS1C+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoidUc1q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoidUc1q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24049d1643aso28842065ad.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299401; x=1754904201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQKN0buZM9w2wNPDazxNz7Eqlmchl9jQe1BzYvMCZM=;
        b=HoidUc1qrQwtnlrYOF0n/S5PFE+Hd8yvwrtBT8HKz/neBnroTLKiBQydux3oz/uebN
         Gwluh3jdDTONXLbd/ayWtUvVT+OgXZ8+EvFLJgY+sEVS+kjyRGiKmn8NZwDnuF2222Qp
         sY7yzxZ6hl8MbWTQIZz612M4Ro9aqzckooNMOU6xsf84t7EVyD/vkrwy9twVV3adbA3f
         n5R/h2Ppl+/Z0ELa73U8HjDRKLLZMy3xie8P5YR5T8wSz+BctKnHigkctqCZNNd7c2fQ
         6tixSEMR29Cde3x9cTc7pB2O53+JezVCk7BFcN6RshnqPVJV1rPlULEnbx2aP+NR/lOR
         z5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299401; x=1754904201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPQKN0buZM9w2wNPDazxNz7Eqlmchl9jQe1BzYvMCZM=;
        b=XOZwk+JalZKcCwAbOxDkeHmX4yFCu8MMAqLzT1Y+nhVIKkuR+3OaxTpk/x+TaIuvx0
         nnuG4FD5DwaSkK+EUh+OFC8LdTX2ZPXLSt2+ySgDVJ9C4OI/J2MGCEmuUAft/vFe+wQQ
         LMI58CCmjedY25LubKdb4dF+006EOwZpB1bm4E014ThQtecdJR4XHabinR1ZVRChL+tS
         5O4gUNJRcLHe8BPg/Hj5+EcbqcUGfjSuXiZzmbHLK+NgM290Qn4avO+EERdyvuJ49+Ug
         LSJ/EnvweG1BaeP+3UigxPtUhXjJuKGBxYmIRwHp3fk0PGQ7VVwm9OwfcCyDdhEGtORI
         ylZw==
X-Gm-Message-State: AOJu0Yz2tssBvLRqkqqsRjIulQc4UH077aWaIIY0aOAlzZzUZNaMi6NB
	knBJJ6GPE4Si4VKz5ZoOWHIzJB3iWtfk84wUtYDI3OhWaSf5PZmot14r0l1imlCw
X-Gm-Gg: ASbGnctF65k1VnOD+mZu7rfzFr9dUPvFh+h4foSPCycTY7ytTTQrBX5iT/WE9r9bA06
	yva6JR7ftIewVxBSsKC04Lav/0Zdd3GXrn8ZRvAXPqaMZecrmDW0fJa/NnLitjGgChee4y8cssK
	IuG9ShVmkefikNer7h0dZK1geMj2ZYj+NtpxncrNHXKTd7CsGhZeM+kz9mHR341KtoHbZymgQCH
	fHUYTUeEuLwjLCvsaOLcb9LsAdEuSn//9eV8XWL3D+s0t0za36owVZalf2NMMncHhlFgaOWEpDB
	XsqL6mCbGsPmixqg7OFR9WdD+Hdhg26gsOhiLLcvSIAnhndQQ1NI90lSTVovFFBoNXe2+QLTFMQ
	cX04XqcFM3GKnsOx0MZQ=
X-Google-Smtp-Source: AGHT+IEciLOUUezgBYMxU/lB3P7Y652NurIeRRbSoUtkjOMrDuurmbJ245cYb0QWuf86GIBj2wuhEw==
X-Received: by 2002:a17:903:183:b0:224:10a2:cae7 with SMTP id d9443c01a7336-24247028ac8mr135833035ad.40.1754299400952;
        Mon, 04 Aug 2025 02:23:20 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm106205565ad.4.2025.08.04.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:23:20 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	John Cai <johncai86@gmail.com>
Subject: [GSoC][RFC PATCH v5 4/6] builtin/refs: add list subcommand
Date: Mon,  4 Aug 2025 14:52:53 +0530
Message-Id: <20250804092255.1092973-5-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804092255.1092973-1-meetsoni3017@gmail.com>
References: <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250804092255.1092973-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's reference management is distributed across multiple commands. As
part of an ongoing effort to consolidate and modernize reference
handling, introduce a `list` subcommand under the `git refs` umbrella as
a replacement for `git for-each-ref`.

Implement `cmd_refs_list` by having it call the `for_each_ref_core()`
helper function. This helper was factored out of the original
`cmd_for_each_ref` in a preceding commit, allowing both commands to
share the same core logic as independent peers.

Add documentation for the new command. The man page leverages the shared
options file, created in a previous commit, by using the AsciiDoc
`include::` macro to ensure consistency with git-for-each-ref(1).

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc | 16 ++++++++++++++++
 builtin/refs.c              | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 4d6dc994f9..ee563aa7e0 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -11,6 +11,13 @@ SYNOPSIS
 [synopsis]
 git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
+git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
+	      [(--sort=<key>)...] [--format=<format>]
+	      [--include-root-refs] [ --stdin | <pattern>... ]
+	      [--points-at=<object>]
+	      [--merged[=<object>]] [--no-merged[=<object>]]
+	      [--contains[=<object>]] [--no-contains[=<object>]]
+	      [--exclude=<pattern> ...]
 
 DESCRIPTION
 -----------
@@ -26,6 +33,11 @@ migrate::
 verify::
 	Verify reference database consistency.
 
+list::
+	List references in the repository with support for filtering,
+	formatting, and sorting. This subcommand is an alias for
+	linkgit:git-for-each-ref[1] and offers identical functionality.
+
 OPTIONS
 -------
 
@@ -57,6 +69,10 @@ The following options are specific to 'git refs verify':
 --verbose::
 	When verifying the reference database consistency, be chatty.
 
+The following options are specific to 'git refs list':
+
+include::for-each-ref-options.adoc[]
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 998d2a2c1c..848a7c9072 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -6,6 +6,7 @@
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
+#include "for-each-ref.h"
 
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
@@ -101,6 +102,17 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_list(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_list_usage[] = {
+		N_("git refs list " COMMON_USAGE_FOR_EACH_REF),
+		NULL
+	};
+
+	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -109,12 +121,14 @@ int cmd_refs(int argc,
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
+		"git refs list " COMMON_USAGE_FOR_EACH_REF,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
+		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_END(),
 	};
 
-- 
2.34.1

