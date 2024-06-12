Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5B16D4FF
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182458; cv=none; b=pxlMWNCDfFo6hgZliFnbfFjHuwqjgTG15u1KCGbMkLk8dHyfMNzDaOkvwyoZttWh+CBl8v9hzkvRjgCIwcQxMjYtzlDSDsmwFr4xqfaG3oNzhGHp67TvWuzUiww37EmwfQpp7SBMUjZsKpXfOnSidSGhVfAjDB7yONxVbJ9x5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182458; c=relaxed/simple;
	bh=1CnMWowf4t7+W1FR8Kw2Mg/FCZXtdakCe5eFMRI7g+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlzQt66f2wrtncxhBspiZLnbYDpS972BNwibeVpcS1kP/fsNY/uN1NOPXwuyDIP3WQ6PENlWmD9BufolpIu40lyP4LIfH7yKg33rDWIWhxePepByHGBn3rbVA8KfiVpzfHt0O+4z3KtbyxUhNAdwmGj0h2JdImdBEBGX/eS4SpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB/FTuFe; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB/FTuFe"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6818e31e5baso5413864a12.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182456; x=1718787256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrO6T0D0pZQGFO+M/+bNOKq5Yopzh5cajPS8m99LEJU=;
        b=cB/FTuFe4eWnH3ELtMXc7v8p0CUw+ZSpALYLfVFNUyfZ8CO/Oqndd+idNhDDsw3li2
         PhPONn+8T5KO9t94FUVZhhAGWbAxQ5aSCYtNT927B1FZr0FkTkZDP/Iubs6RHbbaGxry
         o2kHReURtsWhoG8f89Ofn6lDG4/A8WQUe43mkGHqXQzDano/BPmLfXakHYaa5/GZqZV6
         t75fA/9T4cfDvChxLdYWOjo2OeEwR/fLl0v8kVukyj2SZ1GeMxgtxI5ZbRFU+PoccWO7
         3S89kgOcTPyKRkVtKs7dzyno6Fg7lnf3dCrVWG//kKaPVx3SfscxFH9nIyHjEO01/QZM
         fURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182456; x=1718787256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrO6T0D0pZQGFO+M/+bNOKq5Yopzh5cajPS8m99LEJU=;
        b=v9cS0I12/lnaaZ9s1MGeyF4pAZMAwFhmW0GRxo/GeTzYnnjNl/kD7PaopnglxlloTN
         Zv6bpSkc1UKwlaHRtQNL1BonlbyjykkYyzXTOMSUSKd8yY4ui6Dwo4TeaH+iZsDZi+nC
         KqXGJXbCapsclgHdkSNp7lq/R7SIwknXO5mR0H3IWC2vabhQwvvDAukP98xUq4Bg+E4l
         vIwxxduTMBTqsqFJVN/DsV2wzyDmAyXkz1JzCEsIr/DNBPmIPWEyQYMUYsRLTa89R3UG
         rSd0h8XXh6DSECVsfYWWNSDzq4Dm5Q2GapkSghBmN6EZyCdbrAjyklGuvnw0YY037D7e
         cXRg==
X-Gm-Message-State: AOJu0Yy16267VB1Ws/EjyZQuNa7F3bfI4wAdxLkT973HOKwiVnq2prVC
	bG0zDtk9jt9s0pEV/PfyAjTodgsXbY6E+jwpeXfq+nJ7YR+QxKKiw9NT3NiV
X-Google-Smtp-Source: AGHT+IHjMGN94vF2DAROk3TyuVQzzD5gHqLHsHQl3l7e8azOcMte4A0nbQKBrOs7khoj5+xKFj8kOQ==
X-Received: by 2002:a05:6a21:33a8:b0:1b8:7de9:6e3f with SMTP id adf61e73a8af0-1b8a9c79cc0mr1510001637.53.1718182455877;
        Wed, 12 Jun 2024 01:54:15 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:15 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 3/7] builtin/refs: add verify subcommand
Date: Wed, 12 Jun 2024 16:53:45 +0800
Message-ID: <20240612085349.710785-4-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 11 ++++++++++
 builtin/refs.c             | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 5b99e04385..f9d36ea19d 100644
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
 
@@ -39,6 +43,13 @@ include::ref-storage-format.txt[]
 	can be used to double check that the migration works as expected before
 	performing the actual migration.
 
+--strict::
+	Enable more strict checking, every WARN severity for the `Fsck Messages`
+	be seen as ERROR.
+
+--verbose::
+	When verifying the reference database consistency, be chatty.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..82ed0d57c1 100644
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
@@ -58,15 +63,55 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	const char * const verify_usage[] = {
+		REFS_VERIFY_USAGE,
+		NULL,
+	};
+	int ret = 0;
+	unsigned int verbose = 0, strict = 0;
+	struct fsck_refs_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (verbose)
+		fsck_refs_options.verbose = 1;
+	if (strict)
+		fsck_refs_options.strict = 1;
+
+	git_config(git_fsck_refs_config, &fsck_refs_options);
+	prepare_repo_settings(the_repository);
+
+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+
+	/*
+	 * Explicitly free the allocated array. This is necessary because
+	 * this program is executed as child process of git-fsck(1) and the
+	 * allocated array may not freed when git-fsck(1) aborts somewhere.
+	 */
+	free(fsck_refs_options.msg_type);
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

