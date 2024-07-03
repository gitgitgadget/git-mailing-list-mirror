Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593817B435
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015089; cv=none; b=ZMCOzGEYM8gLZvMxQULbeQMt324fSD26KpprRUNEpzeO68h2q6K08FZ4aWyBSbWs2/CvW2841jwCcbVnJ7P1c3OR/SscnnBp5M/bXaI0mx18sWtSVwwOcafaYimSwmEmVzWhDm8JdZfN/aPz7WatLESzP7VFyie9wJOp3nhN7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015089; c=relaxed/simple;
	bh=D6ETxbtTkMy/f2wA+nHwj2LARo1b8hVS/P1KC22Z0H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMKbKxYSci1XdtsAQbKKLHv5aiaW8WlIcOhxHwzRXZ4SOqNhkLy8ykuHlJC0QQFja3gPXBpPOz0UYwZxAlH/7IytAJyVSOnvrwowxnvmNXCowXX7zLoEgyknfadOrsWTVXl6GyMHcsVBy+ZXRUx+u9u+DTABnKZkLcQGDpt0rig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJYdpCkE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJYdpCkE"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7515437ff16so1631018a12.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015086; x=1720619886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Om4m+E104fYydmOLrPhJ06tXqIyGWOces33eHq6kRRc=;
        b=SJYdpCkE/9z2YKCFDCYCFvNB3dVG7uSObwy8nS2FTLqP12bYEtUD07N/JWG9QkjyYH
         yeiP7ipG972yG0TtYo/mzaooeeVv69r3Sg+BaXk4GlcR9eWPjkF87NRACQQAo2bu7M+q
         URdR07BvbUwnDjPdUCT4lY0YSmCzWsL/F4BeODACGlo1z1RQtOzo+KbWDvdcoyWw4p6j
         IO1WXVXFtOFI64wfkzBmQpJHxc4JVdd5EWCBslu3IQ62vcgNCkG6Dmy55lkgdG5tkLnh
         4qtG7xCqj4RU+EogI3N8oYWP1/YnPLtpn/3noq//o3povu3Fmm8i6LDbkq1NI/mtDQR/
         nIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015086; x=1720619886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om4m+E104fYydmOLrPhJ06tXqIyGWOces33eHq6kRRc=;
        b=nDF2H9Nl3fW/xbu610tRy1EvQUlCkIinxHj+W50O/OHu6bqVFL9Gdgiyu5KIU7++3t
         RSPvrqqUDC1b9uq19dUbBfhMtchbycAy04riZBfLCv5T7YbyvYNNRKJ88X59u3iiJiQJ
         rnmDqik9LToi7D1bpBfx4pVzo9RHZSVPsaUXIH6hNvU4VTIs6AyMJ2DKoKqC7HeGBsyv
         pms2MAKxQLEvEdL9ECZcEtFSIqFXJQVTpC1iYpLqRaCQQs/rRUXItIoGbtS/PvSZJ0VL
         0kmKUaVqkHarrLpKV/qkSR24Q1Hj/ysUBsWVeaip57m5HsYla0DlooOJUuYb3CHCDGI0
         IT+Q==
X-Gm-Message-State: AOJu0YwAtYyqJ2NI33VhA2niZAsQdLMM46/qwvbeHufsvKBqUEeu4ARd
	PdbME9nSn3QzUaEYH2iT/KtCyMwIymYv+n1VdCTaPl0ueEXtp2k07GbftN9K
X-Google-Smtp-Source: AGHT+IGxtBi6LqkNF+9V/VjwXa52g0BCyusJ7yVFDuqoaTyIsU7pN0CrVPv3MPh0nuIEyQklhBhpaw==
X-Received: by 2002:a05:6a20:3a99:b0:1bd:251a:b657 with SMTP id adf61e73a8af0-1bef6241910mr12580904637.52.1720015086378;
        Wed, 03 Jul 2024 06:58:06 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c96f76b09fsm1951485a91.16.2024.07.03.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:58:05 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:58:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 5/9] builtin/refs: add verify subcommand
Message-ID: <ZoVY7lbtMQZzjm7x@ArchLinux>
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

