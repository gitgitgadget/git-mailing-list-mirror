Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080F15A84A
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847253; cv=none; b=d3y9aClMWMDPfGaIjCxcyWBIMpuEQAjwwu9iQeZ/PG7WesFmN07K7G9IHafi4JUXHO9AHlTrv3zAE7GPhkxFtCl8rHWWZWYGfPX34Y94gAsGr9eTxdsHjC5s3isYOM+4TxTa1PvJ2hHsrvpmxqCMS1pUFuNSK+3dwzO0P9AYo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847253; c=relaxed/simple;
	bh=N+5AK2TMcZvgnkSoO5vGTo33oNwPi/2ZyJpiTQorZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxwgEilXm1ZONvEq3Ay/H9ljI6T5m7rLwKgJBPzvLViSLrE9iWupJP1il4/51ov4L8GFnhJWaUc1ixcWuQmtDFQH5/bUAXXANGWyIOWKadtRsD8pFF7PY252BuCn5gN9O/TuOheRk0RWga+FqMjfQBKFlKKDLIx8tgm52EsOmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2dtSkRx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2dtSkRx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9aa039327so17084575ad.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847251; x=1720452051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjsZoLtXp2baCjFDVQFv5b+O8fbHb6Fh+G4q54LKTlY=;
        b=T2dtSkRxQ1SvZpnhhRLfjmmH8YZJle+j5As/ZYyHiHbMP8Te8c2sVlN3XK2dzITJlH
         P7R8N37RnYiRrkMjwrVtEgstPzhGtNBteZsmsiA1YmlIB1N2PYx4pAsmCysucwJgoqM3
         D7kbPFqF5T53bNvNpsVHu4YZAhfImM8K0cOIiUxCbvSawl+eq6fJocMPLMf8kkYn4EYh
         m4OuK8iWTaz3UeNN3J709bIoXA8OnzGBav46pDrkBCBOnLRUfRrPIyw9ZzqDQQvJqW9O
         h2xY4POsN4pdguJsa8k4F0vojoiDXBkJf4nMGerAev4YJP7L8ozYaJtGC2pZ1Gy00ewB
         SPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847251; x=1720452051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjsZoLtXp2baCjFDVQFv5b+O8fbHb6Fh+G4q54LKTlY=;
        b=Fjjilm4KVp5xwLSeKY6yjxOxKihiQMcmYkOyHXKb8ziWIqoo8h3KuWscWpsocNPxzU
         x5cYJTyJnjBRdt6lBVjpD91mpADcSpbP+ZYczFioY3zzBsMu+p/Pu2ykPqm14UoPIx4m
         gm8gzS0gypSiTqp2k9gQ4dsiw2/iW6rmCSleYw8rXpZZrIFMXAsx8ejpotG4+rLrIL5Z
         kV9CQ4W0nlsOLTEorcFTutiJCovcjXtWKKwg2Xf/v3QdnVqNHc/AuvuB9HrZBiRbRdvB
         mMyPKOr6SdrXZ183+MtdK5F/kchEE+zZpaeZOPSRi74AUWv+KiaF7Mggt9lUsLodTDeL
         fjMQ==
X-Gm-Message-State: AOJu0YxAHDiEQcL0SQwVi84muFG1a9FH9Qr+g4+qXVt6bUc8/EsSLilU
	gS35IV5wfiR2PUBuWvPxHqpQSbTuozgxGTu2b7qYvVW31x+J6i1ckR1CRQ==
X-Google-Smtp-Source: AGHT+IG11I4zYm482sHnlxp0vjVOpzZ8G/ozLM4z0uQQ+TqDDAIw60umwwzx23lHWnGsdDIX3ywxbg==
X-Received: by 2002:a17:902:e74d:b0:1f7:2135:ce6d with SMTP id d9443c01a7336-1fadbc746a8mr36568885ad.18.1719847251021;
        Mon, 01 Jul 2024 08:20:51 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2197sm66199865ad.63.2024.07.01.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:20:50 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:20:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 07/11] builtin/refs: add verify subcommand
Message-ID: <ZoLJUOy7LLbWj3k0@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

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
index 46dcd150d4..34371573f7 100644
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
+		fsck_refs_options.refs_options.verbose = 1;
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

