Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FB13B5B4
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525270; cv=none; b=MGjHWbGjJrAR/2yjCJvvB5bE+juSJoGSym+VKXRb5KpnccYag/fPAnndYYt4EQgyjfBQHDk8beR2wo1eTAmTwprvXhfR33q2cqDNMRZxi4NgoVXxEbbO99k2UB6R2uygiZwa4EEmetq657oQmLaSLNHe7bsMvS3/f0SpI8M+1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525270; c=relaxed/simple;
	bh=Jm2pdyQ7I9rvWFaqMSm/tEfHY61bIwDyVRZZlejuAtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8ExSNnGLCUnhbc+SUYWTYB5DBBW8nnNjS+lXR76P8nwL27fCUqfGa0mIGxHKpPJ912YcNQmP6FuPjJbGqq6yY5HV4zJk+PNngNnjz2HD8Uvp/U7aIj6GRCo+/E8ziN1cMCDXv/fEWIvjzCApFeqly+J3U9J0DSSnGMbXGoZjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5udNF5c; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5udNF5c"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d162eef54so5048871b3a.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525268; x=1723130068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyG5FQCLGW11SDTBZMG1MOK2SbJZBc0+KogJHuEE/8U=;
        b=a5udNF5c2dnMW7EG5y7gytx4IqaCpqRybZOyfPQfLCacCBa2gsrRWbo38RHkqvTUU8
         vaVY1XSqNDgVE4HqWtGsaAl1wFyvsRIvKDEViJkZeRbbTd76AgWh8r4tg4sS0jOKVe9o
         ZtBN6WdDFVpdyFT19E8mKZ/BMLfSw9pBLawASMnaifi6EFnDeazOfOQXZUUxjH94nLLm
         0flFPMBCuTKHyZUwvLRzjv1cmijmmAhuzXrZcFvgc0+FN1RriVduzNOp42CpkN+tvHAV
         EUCCiQYbizcp1qO+O5/w/5m47JGgFdRiVrDSatbBFZcFcB1knu2EDak6c7b3xsXIixIp
         onMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525268; x=1723130068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyG5FQCLGW11SDTBZMG1MOK2SbJZBc0+KogJHuEE/8U=;
        b=VenclVaIRW57Xv87uBlsxfenvWontC/SppzI8EPIzMFDQmRiz/0qjbX9lLrjfW0/lU
         ZBDIhq4dYO03u5mRCDOuebHkVSPyHtk4xDR4hdzJ4r+EBQc6nQUVNEjowF72dlFeZUjt
         FxMTMOeOvR6bKzuRJB8j8xZBhYVeG/7Zao0ItL7QQbcPAcLWKa3ErAw0xrOhSF2VEMPl
         Rc7YvQOu1kQw0RmNfTmU+Ro4x/i1GjAuJawrTs0ULzGNMVteKhtK8dTgaCPHixdr3qGQ
         Yf3IlADFo2xIFHER+obSFk5r4LfyI1y0TwH4Q34zKb0yPGFDSGz2pFp5eGH/7LqKlJcv
         ayVw==
X-Gm-Message-State: AOJu0Yx8ju3tdSuybFEV44KFBgZs43J7rKh0llnpWqGFe5R9/5ch93en
	X5JOPVF/X38gtEfNksV9jvq6szlnsFXEQAj6TWRmZeFhtzSxeq12K4+d9g==
X-Google-Smtp-Source: AGHT+IG33idTsquYZzy1zF3YsGEPpntA6rK0bc3u7qn+dvQzyhHP2kOhApb6VIB7VTxcKgUXUHJF1A==
X-Received: by 2002:a05:6a20:6a24:b0:1c4:b62f:feb2 with SMTP id adf61e73a8af0-1c699559ce2mr815482637.18.1722525267756;
        Thu, 01 Aug 2024 08:14:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead812eaasm11629816b3a.105.2024.08.01.08.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:14:26 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:14:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 08/11] builtin/refs: add verify subcommand
Message-ID: <Zqumaq_iwFkwMU6z@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency and also this subcommand will
be used as the entry point of checking refs for "git-fsck(1)".

Add "verbose" field into "fsck_options" to indicate whether we should
print verbose messages when checking refs and objects consistency.

Remove bit-field for "strict" field, this is because we cannot take
address of a bit-field which makes it unhandy to set member variables
when parsing the command line options.

The "git-fsck(1)" declares "fsck_options" variable with "static"
identifier which avoids complaint by the leak-checker. However, in
"git-refs verify", we need to do memory clean manually. Thus add
"fsck_options_clear" function in "fsck.c" to provide memory clean
operation.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++++
 builtin/refs.c             | 34 ++++++++++++++++++++++++++++++++++
 fsck.c                     | 11 +++++++++++
 fsck.h                     |  8 +++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 5b99e04385..ce31f93061 100644
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
+	Enable stricter error checking. This will cause warnings to be
+	reported as errors. See linkgit:git-fsck[1].
+
+--verbose::
+	When verifying the reference database consistency, be chatty.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..131f98be98 100644
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
@@ -58,15 +63,44 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	const char * const verify_usage[] = {
+		REFS_VERIFY_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "verbose", &fsck_refs_options.verbose, N_("be verbose")),
+		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
+		OPT_END(),
+	};
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("'git refs verify' takes no arguments"));
+
+	git_config(git_fsck_config, &fsck_refs_options);
+	prepare_repo_settings(the_repository);
+
+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+
+	fsck_options_clear(&fsck_refs_options);
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
 
diff --git a/fsck.c b/fsck.c
index 0a870fcec0..d5e7c88eab 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1336,6 +1336,17 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
+void fsck_options_clear(struct fsck_options *options)
+{
+	free(options->msg_type);
+	oidset_clear(&options->skip_oids);
+	oidset_clear(&options->gitmodules_found);
+	oidset_clear(&options->gitmodules_done);
+	oidset_clear(&options->gitattributes_found);
+	oidset_clear(&options->gitattributes_done);
+	kh_clear_oid_map(options->object_names);
+}
+
 int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
diff --git a/fsck.h b/fsck.h
index 2002590f60..d551a9fe86 100644
--- a/fsck.h
+++ b/fsck.h
@@ -153,7 +153,8 @@ struct fsck_ref_report {
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
-	unsigned strict:1;
+	unsigned strict;
+	unsigned verbose;
 	enum fsck_msg_type *msg_type;
 	struct oidset skip_oids;
 	struct oidset gitmodules_found;
@@ -231,6 +232,11 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Clear the fsck_options struct, freeing any allocated memory.
+ */
+void fsck_options_clear(struct fsck_options *options);
+
 /*
  * Report an error or warning for refs.
  */
-- 
2.45.2

