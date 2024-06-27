Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802C1198A17
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501345; cv=none; b=PyDlCw2gE2OLPQRLihf6SzbWHcGmfhE8LqN2nLUAtpWsxw46aQN2J/40HNBCMksxbdyL1eJi0s0/iX1KZpIxISGdNgOmLPZeZZJ+LMYuOYmJMtMW39hFzfuTbbrDGU8sY4Qhxu3ZdpmS59YTuWL9uHYfFfL/MMna9aWzLmHDOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501345; c=relaxed/simple;
	bh=voQLTpFo2dHENNDdW2w0eqZZTUbIcksiE+cLN6MF6cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFvslyDSpBHuZJ8bUCo3Z5AUVg0zVa4tSkRj+lmHMHyK8DUgLA7GJuAdTgDpRA0/o5ExEN/Dbgp7nzDO5siJxe/l237+M59XECjysBg8TMpz/g2q2SMDV6xr8k81vPJ8LrTHosTj3rAlBsR0nU5LioOZp5LPXStdBVn4YHpakSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoxxJmoW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoxxJmoW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7066c9741b7so3935542b3a.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501343; x=1720106143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLPTV5SATk82eS+2oWbSqq87eYYCga3DwhqGe9F+Vxo=;
        b=hoxxJmoWuIc5WzUAW/39bKscpH18EqcB1iV3fNa/9+303V0MVQLgxCyjyk0iU7kF9/
         VCwL3suK/Whb1VTQCEV63NOMo/DyqQfSPsNG426UTsPaqM8wzZange2YCa6y8CeB1R1/
         //zk6XnIwE880EpSyUlmyvLsqJTjm4+VC3P0Kn763G8x9/Dx3+eEIq/QU7qB2w59O4Ih
         tMx8CrSNATD+DR1e+a2/CEI0pZt6bYzvZ2r0IWId12okzMOuowLsVMuZUlwIEUmP4EoZ
         3pu7wob4iSJgtCGYBMl/zUtnbArWrmqScB7pwg342thlq5fcdVqYQPRBHOetnd6GDbLf
         4zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501343; x=1720106143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLPTV5SATk82eS+2oWbSqq87eYYCga3DwhqGe9F+Vxo=;
        b=FIKkNA3k20rInxUYlERm1330IA/v10ij+h6Q6Qe0hTPdiEBlvKQwhjEdj78mUDawXh
         u5KkAfsGK7QQ1Mw5HrWIPfKooh57jc1nowY22U1K+GSzFww8EUBMtqiym9gY4Firw5e8
         8MqUyDPKcvDGiBxXQ+WSwtXYspwuAZrpYv7z6AHXMVd7sID6qW+ri9cUtLkkvavJNwWX
         QGCmw6dCs7mzS9UlkJe/KK4ZGeah6ralD+DB4W9m2EmnOrMOEvrZ63+nr4/2LpZw251l
         ztD0ov1FfHx02GBHP0qU+PW66PZDzyDqzhB/ucfFMZUwWKgjTIXVtk1e6njz2NhvCA1X
         i4VA==
X-Gm-Message-State: AOJu0YwvuMV9WUETITmT2kC3OJfqWa75wehbzfQuPYFEsqBdBpyy1wp0
	vF9rdJoDIW70FJH9DRVC0v4j8M8iVE7uGnbPtYXprGVBJ8T/dVKChGxMHQ==
X-Google-Smtp-Source: AGHT+IG9noX02MslNUH6hBSXEasumLVVkR6WZfw3rAPnWQcrKTZg/VUjVxgLTVxRHJ7DIFfWn8MIHg==
X-Received: by 2002:a05:6a21:339b:b0:1b6:dffa:d6f8 with SMTP id adf61e73a8af0-1bcf7e6b981mr15834840637.3.1719501343141;
        Thu, 27 Jun 2024 08:15:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a5892esm1469308b3a.190.2024.06.27.08.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:15:42 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:15:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 08/12] builtin/refs: add verify subcommand
Message-ID: <Zn2CHJzhLntjqPuG@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++++
 builtin/refs.c             | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

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
index 46dcd150d4..511b0d0f8b 100644
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
@@ -58,15 +63,46 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	struct fsck_refs_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
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
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (verbose)
+		fsck_refs_options.fsck_options.verbose = 1;
+	if (strict)
+		fsck_refs_options.fsck_options.strict = 1;
+
+	git_config(git_fsck_config, &fsck_refs_options.fsck_options);
+	prepare_repo_settings(the_repository);
+
+	return refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
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

