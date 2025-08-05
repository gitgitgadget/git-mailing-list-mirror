Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A0265626
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386105; cv=none; b=WcVRe//STu7dVgCyWa7cjr0Nt4NNvVGpM3UvXxcrKMoIdDeecVwW030hFG1NPPrik9fFbwt5cq0U4kn/x14n5MpVFxWSNDFx3KLW0xPlOV48uXyh1Ll+cGaJM64vTfqDRilj44Y2S3v7133OeXuvUTZjFLh5CKK9crshG7N6Qu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386105; c=relaxed/simple;
	bh=XjD7zolI0Yby5SrMYlT6olQOlur7fWcnjBDxc1Cxkk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSuRqS91msnlGHs89iIucJr+9goDviIX4Wi/vECRNuQnsvfbU1KTji0pZbLdbrst2Qtyumph1bAQhuMsID89EN/lTDjqN68HzWwsCEiDOSyuMJMPfp8AokvR4e473aHbt3g/IJAydlAnJ6NtOutGgg5aAuMFHA3ytneO5cEOsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR2dWErH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR2dWErH"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bd041c431so4318502b3a.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754386103; x=1754990903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFx7TosHSpFSAYlOSzIZlLKrO2G+e9IjCOpV/abCiRQ=;
        b=VR2dWErHONHUDc89V2LhdKsXEngRm3lg2L8XEwqhJdXIDImGk857UTzSiu4EDwfE/U
         VWVjZL1O0ZbxpZ17EoBl2BaPckSfWWAOX2XdgCzaigEC0wvXe0aT+wRDti8E2l3hwEXa
         xwk56cNQzyf2iPhfqzqxZW5Ql2f43sz8t8Eh1E0LLlBo9glE5A+x7GX/t06ifDT0TnoS
         H1aBz2hvTZtf+owKil3dFr2sYiqKOrZeue/Q8TwD0KmIeHJybFh84jjv5pr/S5W/n461
         bcPqx18ObLRif9+hmXrzT2l1SnczTe4YWRIOfEUBSE3ak9lJQVyLXlXib4SqwB7AMtra
         tlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386103; x=1754990903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFx7TosHSpFSAYlOSzIZlLKrO2G+e9IjCOpV/abCiRQ=;
        b=bvEHVqaLdpOFh6wN5pDFlEPubq4d6Cq4JkLGDYpGNs2pQLLJIpWBKm4EzrvDBjKXsh
         z+nA7EejvfhE7zKvbuyGS+X69KxYhU98mhEXyIFbmpOstBTOWfnM8Fks4/ZZkVkgSnNN
         zsOLbdwIYIF7y2fOs6WfuePmMyRYvrTs23/j2MxyOEhks3FzXfRT8wQVN/fjR2pMH8go
         socfWxjtbkE0M8+CTmZi0xCzQVLs21tZXC4n2bQQ/O6czm6GUlLKLZwllGcvmw4mVA2f
         xcHQqaxsng+4Y7BB5Hv5YDT2LDZpIr5uSxvDkdLqCbzn/EnDcRvIohfalsdjMaITmP7R
         pSZA==
X-Gm-Message-State: AOJu0YzVEKTG9fV7BX7USS/mBGo5rTSmLplr4XZbuxL6r28aptcu3zeY
	AkZu21Sz5UHsisoDypkHu7W7z7IFXAS7bycOjPHl6mIIfkKoP3EbhRZ+3voTCQ==
X-Gm-Gg: ASbGnct20mN3akR+1FONjs2WcuE02oOSN7g1Br5JZuvUDu6KrFbddS2Xt8eVOF8AZ5o
	IUk7zBZioTIjEMakg97xjGa6FMH41VDHqSs2wsc6K9HfPAgdeIFNDugnqzjMoAiuX3SamX+vTky
	wRcJchQEiMOBbZ5jukQy2PIL1oTloI3JDCjH4DiTxCQKZVuTqbMc0PiffqnmQ6U+2yYnhKCg08H
	FHAYuh/9A/3ZP5MdDmWzBi44aGxPnilPIsnzir7PD6U5I46uEYTyGdcLoR96xytc5dWf0jcan51
	zhh41lb8dgg+fZ5Yp+Ete8F4+XK5V7ZgaAvvh6Yvv1fgr+UHQbtB6ba56QPddr0bm+hcrmmWSVH
	+D5UILEs8at9K0RWcpJo69f88DSMpTg==
X-Google-Smtp-Source: AGHT+IEYS273nbTcGzDeIMPI9HByYVgKUvKFUKQ2EqOiM2z0W+xiVu/k6WRLI27ZjQFMFWMmB4HYsg==
X-Received: by 2002:a05:6a00:3e25:b0:76b:92ac:27cc with SMTP id d2e1a72fcca58-76bec0dad9fmr15439916b3a.0.1754386102601;
        Tue, 05 Aug 2025 02:28:22 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm12465691b3a.58.2025.08.05.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:28:22 -0700 (PDT)
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
Subject: [GSoC][PATCH v6 4/6] builtin/refs: add list subcommand
Date: Tue,  5 Aug 2025 14:57:56 +0530
Message-Id: <20250805092758.5321-5-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805092758.5321-1-meetsoni3017@gmail.com>
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
 <20250805092758.5321-1-meetsoni3017@gmail.com>
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
index 4d6dc994f9..e608980711 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -11,6 +11,13 @@ SYNOPSIS
 [synopsis]
 git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
+git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
+		   [(--sort=<key>)...] [--format=<format>]
+		   [--include-root-refs] [--points-at=<object>]
+		   [--merged[=<object>]] [--no-merged[=<object>]]
+		   [--contains[=<object>]] [--no-contains[=<object>]]
+		   [(--exclude=<pattern>)...] [--start-after=<marker>]
+		   [ --stdin | <pattern>... ]
 
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
index c7ad0a2963..76224feba4 100644
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

