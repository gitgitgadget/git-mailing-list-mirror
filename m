Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765513A272
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698688; cv=none; b=QoK3XBWp8McL8xU+RkKLz/MmT5b/6o7Ff3/+NiU6v4NVzy+IsAZunYU6hql+w2UOO9WapGS4k6nfpsOsdtMxOnXlUVat1y6TtHF2e+OvqnfG1ig9q51WOvKI0G8oD63yfHPEt0DhIyQIcbGCRcCDSBrlat2hfsnp8cOKeZziSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698688; c=relaxed/simple;
	bh=XI22TGKBeHYYUn3ML0pOThJDTLkoIu/BlwAPdaaY08M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=flBMdSBtzB4oGBi9svUKn1tRoT0SzX2g5vfiIIHE21s4RuNj0D4ERbDSOYW+p8kFz+3RW6oNcqmYPBjK9ZuCKYveMzH/5taRQ95Erhy92njNTXlzT0jTG1LknoURTL5jbbfIVmVLb9+kPjYLbUHKhCHJW4TiE4rN5wjV4fSIVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhTnjZ79; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhTnjZ79"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c0dbd2866so2706378fac.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698686; x=1719303486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAzyoLDUwblS9B3WzVkzP8yUAdzvWiY9NUaBGo4A4s0=;
        b=bhTnjZ79mo3lDxBFXtv3wLlG/9lXHO5QwEmBjemqtr7qPb71gMgEW6aZgRuw8QUjgm
         T82XroBjM/DCKJG5sdUhWvIbzaQ/8+HNv1c7e9B/ySGD4nVhUdpSBlH0PQpAjAwtUEk/
         zqOFW1Agrg3Z5/aSx5Y0w7OhrZ+0sKI6GCtadbr4i9Xa+Pj1gmSGocDYopE8ljoDMctW
         0v9wMKqqhHF2dEtfkxjiCGy8WG3JG1Qk2GccGHHz0wBrqZMqBT6Ej1IDU8zyXzOhEjNW
         9PWBsRslhN9jOeRq/tl30OIy7qlSPw70ZxVV00h8zKQZrLBYSFbmpC8fDEDpjsIvu7t0
         037g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698686; x=1719303486;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAzyoLDUwblS9B3WzVkzP8yUAdzvWiY9NUaBGo4A4s0=;
        b=E/jAcAPeaR8uQ9pUbWivL/2iHqOmJ0WUveS7vyVXKE4CHBT4c5xDXLYVtejFjL+oM4
         OKiWvqZrFYQo+DSU51ghslONATYAyo3JykcQ0VPqvs5sNq0JgaS++pYiaMzUiTBp1yco
         bXaVd3+HwbjiZ9/wX82G1L+VHYAfB9oCxZ/tr9xHTfkHWKiRwc0+PABO96znHE52CA2i
         uN/BrgXEFz9JpBy5MCVUv6GOBTGzx9Th5nwi05RQjCwe33CDn+lON5wr3P6qfJEncnws
         KLp3LMU9u43te/1uxhc9H0W8Qb7JBnGmU6cQrnAnuYlilb/jm4hV2wrHBana0c+Q37yk
         52AQ==
X-Gm-Message-State: AOJu0YzNTUwjXBRnKs1UaY4QCBiDAnAjrMBRObiy5noUZHtxgS3SfRQs
	CXcgZzAUfXTy1CrWhRpE9F9XUzWWHCemCkdbwAI2w4IzYknEs/Dw3FezQg==
X-Google-Smtp-Source: AGHT+IECW3tRDIBV6XZfsgXqjWKBXV+7+DCDbm9KpLFA4vKSymqR2+fgJomUT8+fPZrwsFds/8r3pA==
X-Received: by 2002:a05:6870:9725:b0:254:ada1:aa29 with SMTP id 586e51a60fabf-258429d808amr13050747fac.27.1718698685990;
        Tue, 18 Jun 2024 01:18:05 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ef260437sm4714869b3a.85.2024.06.18.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:18:05 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:18:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/7] builtin/refs: add verify subcommand
Message-ID: <ZnFCu7kDjjoNr9dr@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++
 builtin/refs.c             | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 5b99e04385..16b518ecce 100644
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

