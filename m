Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA533C24
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259615; cv=none; b=hZ0h3OlIW8E2u04C9yHZDvvBYzVpXxk5yruJrfVaEcrqbUsAz8ZttEJ5vs2q+B5MKaoMhwbNqzoC3Paweov5uelRoFW08tTuk0LAJ1ok2SQdEK/KC3zsQs5X4mX0Oz3n/mpK0JnaTSQzP2wYjjsW6GWN/tlw8ri96iAwVHgBseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259615; c=relaxed/simple;
	bh=2DuRd7FQzyKCWqT7nnB5wpt5BwLILAM0oGKgRm9Czls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jmm7Zq320C75yaKpFiX7xkZDY22FgQEKkgQfeZ93hpFHGzZaatc9gg/l5cgKfXFmEGSbX/PdYgPel6teGXUjj694G+2aOcUTVyUTvApY2V0R9UAlv8LtsjETH/4xgO9f03m3kJ7tnYVZ6//fXYXWFueRNPymBpUgFTw308fsk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2QM2nsT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2QM2nsT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ff1cd07f56so13332915ad.2
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259612; x=1722864412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TzRbnkNxH+PXwm2oTg2CJHt6kIiw+he4/q1ZQq7Ru4=;
        b=H2QM2nsTQzUwtynyGpnC3lC7PUXG5abuFxKhwVt7JDAMblDp92IZbzWMU4sm/DxydZ
         3McLyRVV6r+M4FWlBeoRLExnrCfa+KwJAPLhIKBzckOU98nIt4T3fWzcL9W3K5e+7Pta
         MALRGFUmLgFiU8GWGE39BCrxsukz50cYL7eSjRUN9JIwOj4GxMA0PZPAlNkUAmqBGIMe
         LfdnkX+86FIFNhUHvyvjyN71gSKUAU/xUJxDcaqWydp7h2FzKG2muL3g3+w5KUIYrqY8
         7ADem5p6Yu8S9TgccP5GX+c/DfdWsbjpfALiSIhBz9HfOPqtWhQ55PUFONBLrq787h42
         JAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259612; x=1722864412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TzRbnkNxH+PXwm2oTg2CJHt6kIiw+he4/q1ZQq7Ru4=;
        b=KXMtDbZMnl6L/cqG5zK95UEOwIr/q/43eR+YkOnCqxYnGbcQxZZ8b9XKDwjH3rWyR+
         QDifmNoFXHuFzyhbr15P1b1f1G4gTkx8aVy62cMKNKvfcNMZezvzppJ1hq4PDFdH1XOs
         0fzS/dt4tdabsM+K/R1uTrFneh0SlCUtVEqbptRlLEcwBopG6LeorFsAeK/CQpG5NDCi
         kcxiu+a0AgiscKoNcW4ika4ih6+2kZ17XeJ5Xa2B4grI6X2LzrX4IifbAU9ZNEarQlsP
         V3vBDdpgORpBwXtAlAugG8fYqHpTgxzs0E737J+yT8ZM/libHSKpho82aFtzGdLYvUUx
         VptA==
X-Gm-Message-State: AOJu0Yysa8q5UoU7WRKGwybw5Zbi+BVKvmynxJdh6JTmEr3hwxIVIUJ7
	zOuNOWoKMC63kwB79qmQd6IudsjzpgI3mSF/hj/hUlltYLyYAnAmjTKONQ==
X-Google-Smtp-Source: AGHT+IEEIBX91Mqf85rlajN/HGu0Eb7ax3q0aWJ3bXwnUmBsprF6pwHjuRq2lg2ogVAXd4ZU57X4CQ==
X-Received: by 2002:a17:902:fd4c:b0:1fb:8864:e20 with SMTP id d9443c01a7336-1ff048384a4mr77523115ad.23.1722259612383;
        Mon, 29 Jul 2024 06:26:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1258sm82689165ad.147.2024.07.29.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:26:51 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:27:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 06/10] git refs: add verify subcommand
Message-ID: <ZqeYsNtl90N1fVDy@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency and also this subcommand will
be used as the entry point of checking refs for "git-fsck(1)". Last, add
"verbose" field into "fsck_options" to indicate whether we should print
verbose messages when checking refs and objects consistency.

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
index 46dcd150d4..4831c9e28e 100644
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
+		usage(_("'git refs verify' takes no arguments"));
+
+	if (verbose)
+		fsck_refs_options.verbose = 1;
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
index a4a4ba88ee..b03dba442e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -155,6 +155,7 @@ struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
+	unsigned verbose:1;
 	enum fsck_msg_type *msg_type;
 	struct oidset skip_oids;
 	struct oidset gitmodules_found;
-- 
2.45.2

