Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8F1AACC
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445765; cv=none; b=CkLv4kdeR/pMQoZjWdahLeV+UFIXmXNsIRvEKksi9oKU0LYZ/c+qRhtpyfcgHG0rIFKeqRge6xUN40Wo6UFVAL/89/bTPdpF3QleKOxZ4/BNr4OyzApC+2p6b9kEGCyTS6VpqDJE3XOUM3/HulHgIUe9nyV0nqev16I0Z+pcXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445765; c=relaxed/simple;
	bh=D6ETxbtTkMy/f2wA+nHwj2LARo1b8hVS/P1KC22Z0H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYG5QwQuYm7BTDbI+NtM2pPLKUyWUaeSKngmPVW89mR3ZzOddBO3CuaLoLGDqMjQ7qsOvxzVRFDH5+uPMPYi1wos7nGgbxMEAYnQ0/ShTJZ0pO+m2RnEVToLhgzIdLuFIuXQ9rlVfMzPXj7o2n9oHVr2BVnul/sWxR3AuHKUCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj7tRFHV; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj7tRFHV"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25dfb580d1fso1921801fac.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445762; x=1721050562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Om4m+E104fYydmOLrPhJ06tXqIyGWOces33eHq6kRRc=;
        b=Mj7tRFHVE8YTwlf9KBM7IkobBst2bhQ9IBXXZhiVnSmRRgcXdwtVDgsp5y6dkV/FLd
         gsE798ZAD4vqsLZrIkRbRsygUqXnHcmgzI0Hr1r5r7MJHm18gmGsb4FtFwOsgWBcrJQm
         Lh1371zhqTyB/Ub6eBrbtz8v7nbQ49FdQtzWQ5m7wcy0zymKTw5ECaENxVOCr0UjrNH7
         kRZC0kMt+mhZZ35AuSuYeeJBjJU2vYRIzi3J9wiYSmEVyqqT7RnxhDL7R1BSx1VjT60c
         4Mh21YzNqCf1PR67UYhVXlTe9u55BCGaVdKPiF8OcwH2+HfHVQp1rwntG/V8epEIdBHf
         6LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445762; x=1721050562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om4m+E104fYydmOLrPhJ06tXqIyGWOces33eHq6kRRc=;
        b=wckPlK+xArAAeBjjjDwTo3I4KcxcuMJ6A98kLQ83e2kzDD2Ex3eLelojoETgF3Z2O5
         tMneMOKy6zRiwzrG9OFOrfTMOj5GGPsOAvbIBwuSxGR2GwbZpvhljldY42cvo1Jv3FDa
         CFl+DU5uHSFwQt0BrozELqDYBkRTGoOaeHbhNfHKxbQWRsLLqX9JuNlLpkK0IVAi9E2w
         vmeJm3LN/yaKF3WCY5PCrDPpOEr5r1M8B9YY/Ru0QfWXpS+CcEwuC9irbpiOGML/OhoD
         ZjCJdx8OiXVyYMcL9wdJQwa8KXdXt5dTVkaSLYFav1IcB+d/w4pMej8rtBa9RvJ8hmtm
         ONMA==
X-Gm-Message-State: AOJu0YwRtJUntGNQyoqO7b27ngMHWd9mnTUmL+pPEqe0ucTE7vWAsUq2
	kbifd6/jMjoEKXmwAbYVBIcYCdzN1pYWkc6wAG3AkSjr1SKVJ9xHeEiACfBj
X-Google-Smtp-Source: AGHT+IH4fIrlTTcfHKXRPcEoYVd2k4Oz5n1HUBBH04O+FCk2xLXAKxoCGltPCZnyQvdX2huPSD7PBA==
X-Received: by 2002:a05:6870:5490:b0:25c:7c8d:e2f2 with SMTP id 586e51a60fabf-25e2bf1e478mr9312027fac.56.1720445762391;
        Mon, 08 Jul 2024 06:36:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b21827837sm3993118b3a.26.2024.07.08.06.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:36:01 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:36:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v8 5/9] builtin/refs: add verify subcommand
Message-ID: <ZovrQVtf3lXO86oE@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++
 builtin/refs.c             | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 5b99e04385..1244a85b64 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git refs migrate' --ref-format=<format> [--dry-run]
+'git refs verify' [--strict] [--verbose]
 
 DESCRIPTION
 -----------
@@ -22,6 +23,9 @@ COMMANDS
 migrate::
 	Migrate ref store between different formats.
 
+verify::
+	Verify reference database consistency.
+
 OPTIONS
 -------
 
@@ -39,6 +43,15 @@ include::ref-storage-format.txt[]
 	can be used to double check that the migration works as expected before
 	performing the actual migration.
 
+The following options are specific to 'git refs verify':
+
+--strict::
+	Enable more strict checking, every WARN severity for the `Fsck Messages`
+	be seen as ERROR. See linkgit:git-fsck[1].
+
+--verbose::
+	When verifying the reference database consistency, be chatty.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..74720f5e0d 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,4 +1,6 @@
 #include "builtin.h"
+#include "config.h"
+#include "fsck.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "repository.h"
@@ -7,6 +9,9 @@
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--dry-run]")
 
+#define REFS_VERIFY_USAGE \
+	N_("git refs verify [--strict] [--verbose]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 {
 	const char * const migrate_usage[] = {
@@ -58,15 +63,54 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	const char * const verify_usage[] = {
+		REFS_VERIFY_USAGE,
+		NULL,
+	};
+	unsigned int verbose = 0, strict = 0;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
+		OPT_END(),
+	};
+	int ret = 0;
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (verbose)
+		fsck_refs_options.verbose_refs = 1;
+	if (strict)
+		fsck_refs_options.strict = 1;
+
+	git_config(git_fsck_config, &fsck_refs_options);
+	prepare_repo_settings(the_repository);
+
+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+
+	/*
+	 * Explicitly free the allocated array and "oid_skiplist"
+	 */
+	free(fsck_refs_options.msg_type);
+	oidset_clear(&fsck_refs_options.oid_skiplist);
+	return ret;
+}
+
 int cmd_refs(int argc, const char **argv, const char *prefix)
 {
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
+		REFS_VERIFY_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
+		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_END(),
 	};
 
-- 
2.45.2

