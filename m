Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B16155A53
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528557; cv=none; b=iD5nV2fboXaTTEjtxRFESzclPxL49EqwadhNtTtbyM8fic/bBYwKGnynWtHKh6vCtlV4S3yjAECOEfJxer8qN9EnfIEhAazJq1qLAKRTYYDTDhyBRTGzTdPNXOEKw3/r3j6VuFsPlBfET09DeHgzk3CvzfY9B/+l87kjNtV9iIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528557; c=relaxed/simple;
	bh=6d61Anp3Kp/9/1huA3xDxnt+MvLHoIELZi8n9WaVS6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdoeXyk28pbzEThgVUTAQsAMvvhACGxNOfnD56nVZx0ym+aAdFUc+WtrwFTqCABrU6tzClcDhQ0pK7hgInXrMKQ9bYXzs+XLLezLh7HtLrNzA0eX429K+yafK2NYF3RjEnRetoKbhHQkTEYQi9/gL5S/eCyWWWaVTEWrKmfWRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1GtE8Dr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1GtE8Dr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb72eb3143so18846995ad.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720528555; x=1721133355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9IXlDPlVIOI4L2itB+k7ZM0AF8EoOJdC+X4nNdkM1A=;
        b=C1GtE8DrFIfdSEcwAYzBoiGhrRzLWI2g/QCzuTORsCd/sXKNp2t+7no2CKm03WxzgU
         zWJ+NKiQsHnhSDKLyJptOwK53NagMoQkK3cW0GkxQQ1Q6jbSMkJN0CKZdKIGaFiKl7Nw
         CjUi34bOt73FJ71l6q0dRxqq2hDoqbpB/fNyliC5fBFLvZ8ILiKM9jHnFZM6M5+QkTj4
         rXeQ5cX0Fb+9Eba3qRGvBTpiiVk22U8TyJIo3cWSiS3+CPj7+I15Ngl65mjJU3OLaX8O
         HxREW5wZxRNNWkAkmpx8sX4ghH1SenupD2Yh+X62Oigg/jZQHNB8WjVjxKmaCW+P8pRd
         z5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528555; x=1721133355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9IXlDPlVIOI4L2itB+k7ZM0AF8EoOJdC+X4nNdkM1A=;
        b=scB738lPxZAWovmdfyskO1DnaiqTCamRH8s1uZUP/GahOWiwcgURNLhUGlYYuoNfQU
         rLH1K9oXYHK1zg/jtgIkUlTY/xYGMvD5iR23g81s5mjqsAJVRfy6BgMy0nJrgDU6CJfi
         dEkOzt/exBX+NoApkzXxbBXORbwY5h2QeECH771crnQDWi8PgwF96UrcoN3naxgOCXT7
         Jdt2GwISRyc/npo7Vpt1+WKRixK+WlzsSk5agPnI8UoTSYgdVuPrtiYoCJe2xKZ5OCYw
         Jt/xGk3PTghG4E/m+UTj6Qt2/TDrTveym0r/4jwJZLL5DKwNPrHN0wd5ZJRjaBO1688l
         vAzQ==
X-Gm-Message-State: AOJu0YzX7kgPmpKkcLDvdEMN54ZRtA0f3KgsiY/vNnUhFkXgNpY3lpXl
	AvqLLWJN1ci76bbqrxV9q/52oZciUgOnF/HpewAGHndLO19v8s9/LR+Mrz95
X-Google-Smtp-Source: AGHT+IEe6nqVa2bnijzo8WrM2XoLQY0D8xHX+ylkZzr44PVw72zfRpXTVi0pbpHOndofvEIsnIqTfQ==
X-Received: by 2002:a17:902:c411:b0:1fb:2ebc:d17a with SMTP id d9443c01a7336-1fbb801cec1mr32680995ad.23.1720528552931;
        Tue, 09 Jul 2024 05:35:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6e1fsm15025395ad.133.2024.07.09.05.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:35:52 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:35:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v9 5/9] builtin/refs: add verify subcommand
Message-ID: <Zo0up3jKBHy-6GRh@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0sQCBqyxX8dJ-f@ArchLinux>

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
index 46dcd150d4..baa96f5b3f 100644
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
+	oidset_clear(&fsck_refs_options.skip_oids);
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

