Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF3BE4E
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622871; cv=none; b=S/yOBYYhHOetyhqmI+QJZ8S7QYmLAIadxT7GkKvwh2T9GymQs598wFzZIxg0A4p438lDtUm2fDcWo/25Ged3fbv2LCoyhj6FU/NUrwJTIUhLkFfiGfnr4d/Uqq0JESALQDYaklZ9VOQQ+Isxp8YU2vuckUdaa/z1YD1TqN+pU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622871; c=relaxed/simple;
	bh=UiyeBYt6HIoYnScaprDPupBgl+1w70TSkJMqhjZHSSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO6SnUeUdnHm79tkGK+W9/0A+yshnLOnmXGj3FKDecztV8D3x9yrsQOpoOd20OGzNiwV106SGzpBewAPoARpHEndvfiX9BREJIEy38uR22lbSHaYsWtiWflsOzlkJax7xmZTfjwM+2rukaXr2KqxFM/M10vvQo68fLmW69AE9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMFAe8tR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMFAe8tR"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-765590154b4so3273435a12.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622868; x=1721227668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTffXF7c2AB4J9IzNq+H9eDFxDONI3crm2A7XjDHAlY=;
        b=cMFAe8tRv/+TttecqM8B9Kpi+lYoGRsL8mECpuczspdlRzx6zvzwjZXEqseEiHNhp+
         9lriwpIxc6mV17DW3Udvdq4azkyDcE4O/2BJBPleXZp0OUzNQN9chnsz10OOTamnnZ4S
         fMaQxttvL7/HJGPOsnrcOSeLtCARNSXiE4nZi/KH8F75NgXTVj7QrUXyvbT0L09EXkHg
         gnWgtdwBlN5G6c0YIx8R1NqXGKLvP4MzSvchlKca8/ke9cBAwDyOTcZfuWYFo2jftKhV
         +hywFuB6qFynOVkl7nxHHfPNtumL8KNVUWRywTge4H8Rv/CQEOsshdUUcEZtCIyKlr2R
         jYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622868; x=1721227668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTffXF7c2AB4J9IzNq+H9eDFxDONI3crm2A7XjDHAlY=;
        b=ntLcDA7RqUmR6KvEPJMNs8xT63W2nZvLsl6WFlu9XKCgxEhr8snl8bbnetp/cpiEhH
         /bhxQ5KRc8RuCzdf67+Lk/7rTp5WqXYatq85hnKhTGrRKhVCUWCiiUKdne5BrYqPNY2t
         rE66/3yCzt4ZLT0kfnN9/4aD5ZyhHz0+69v1QXQm6Iu2ZYFJcGCrXnGphOKqYoPt10IL
         VeWMdsqejxjScUslfyxa+f1QoXB3aI3IXl6ScwG6fMoleeznJe6wU0iJ9jWAsrVlybbB
         +Yq/y6C1FJf+PLXfBFciUMaQhdHB+Gp5A8XgyUxVzKwXRYpMAORCjFGAjFfio+6FL7ot
         Irlw==
X-Gm-Message-State: AOJu0YzT1d1bciqIaG5eI3C6IRE7mtWh1gRVyXV6KC2ZlsfEcb+ZupF+
	Ndmx8rSy8imBSPmknsQYkXuNDVj2BaqzUXcOE4aWJNuMUAEEZaujwuWvPQ==
X-Google-Smtp-Source: AGHT+IF0K9XrMsaY0Xru5U0rgPZ/BNXNtRP1uav1fHSB0uTCqnqCOYCK51MKpoX0Elj9gJt3fggXaw==
X-Received: by 2002:a17:90b:d97:b0:2c9:73ff:6a0c with SMTP id 98e67ed59e1d1-2ca35c4ef5emr4572385a91.20.1720622868479;
        Wed, 10 Jul 2024 07:47:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca344c250esm3873275a91.3.2024.07.10.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:47:48 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:47:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 06/10] builtin/refs: add verify subcommand and
 verbose_refs for "fsck_options"
Message-ID: <Zo6fFS7xzFwWKrEW@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency and also this subcommand will
be used as the entry point of checking refs for "git-fsck(1)". Last, add
"verbose_refs" field into "fsck_options" to indicate whether we should
print verbose messages when checking refs consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++
 builtin/refs.c             | 44 ++++++++++++++++++++++++++++++++++++++
 fsck.h                     |  1 +
 3 files changed, 58 insertions(+)

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
index 46dcd150d4..599b526786 100644
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
+	int ret;
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
+	 * Explicitly free the allocated array and "skip_oids" set
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
 
diff --git a/fsck.h b/fsck.h
index fe5d4d2ad9..ef1f1ed15e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -147,6 +147,7 @@ struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
+	unsigned verbose_refs:1;
 	enum fsck_msg_type *msg_type;
 	struct oidset skip_oids;
 	struct oidset gitmodules_found;
-- 
2.45.2

