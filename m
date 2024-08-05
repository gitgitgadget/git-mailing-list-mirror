Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EF15EFAF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876350; cv=none; b=uOOwRTMRYkN5TolXIoYYQr18FkKolxblWqFi1EqyhyQnzn9q3OR4yzuxbaB3KvevzE3ddHnqOZ8vwVHg7TGAKSRtblEd2HxlLd+nfQXvf6WPl0cMvH1w678nZEZ13IP4Tyn0a/ljGX8vyWoppC2nrTJHBEvCuB9InCBhbkQ9kRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876350; c=relaxed/simple;
	bh=v+Rq14jH54S3uAhHiT7P0b+alMdK5ypEQGdtNA2VIUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtrbDe+lpmWbOaarxNYyhs0knoi3cnvRjx49+z1DFe++jrJZgRw1N1/93UNbc0WiRAQF5eB3WGXrn+In1s0DenrExoDkVVQjjKoW5WWhmhtxG0tEkZ6KfZ180wkYb70/Q3rJ9U46Op6bEjyQo7LxG5OLTCz2zA5vwetrRpmg310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/qXeWFk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/qXeWFk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71871d5e087so8165641a12.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876347; x=1723481147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rn6Jl93ozareS6sNo9PKC2R8rRYCzYW2VxDK0LtyPOQ=;
        b=J/qXeWFkGiVQ6YgaUcJTIDQSjZmTPQqP9IxqoQAbHFQab7D5uluKU2zgmI6r1Qx8uD
         hImEu9UtzpfBWZ7YnJ/VmD/c2nJVYBrExFH7/9Wgi3Mf4r30DdzkSHm2vBCgqeSBby1i
         siePOx2CIJ5u670seZ9sh7BEUaaRoKZqHuv1z5N6VatxvKIIjWZwvqC5RJ/tViQ5YGYr
         OhwLWzz71I/aE492Z2QJ0GEG/1VVBd8HbTcr8Bi4YWuLZtmdXoSKWr5Q1Z6ZWjqj7XxO
         IhIcIcx2IeQoRmaXlTG5NF/xwkWl0gytDP7vTkOKtWcwaEy5SHlYrHx0L/1Ha96ZrqqQ
         aZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876347; x=1723481147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn6Jl93ozareS6sNo9PKC2R8rRYCzYW2VxDK0LtyPOQ=;
        b=YJn4ILa97bDmE+nB88snbT4oA1CuYcnh71bAua4zRtNea/cu+APbDlFj73k/S2bx33
         eTjfBkPaCfrURoDJGe76jDF7pTH/Q7PlRTrGIBLOcqaFhHfP3z+/hHKeDa/LuPOtXsi+
         HuHRQQ6RXg6NZb5oxJlmlUsYaLI+VF8lLPEZpx76q8K1I7zX7eRE1YHBJf4C+FPoqbaK
         aMNIGuXU6LsCrXjcnQFPDMuakDOxB5j4SqznL2jG8qqi5Hy0n/ZPad/tQnHsE24E7qYz
         utpEr5uL+K6Udpf2BMRWzxTSFeVb2CHub1ThqWy1P7vDDRVtyXq6lksxX07BwXYVmB8A
         Qpuw==
X-Gm-Message-State: AOJu0Yw7Vg9PKFCZZR2ogcQihyN5V51It9tMyu+/t3V+YS3JVo/Zy2e9
	wt9xYyopj6HbyH5f6LWNKTImI/M2wCcHNExcRst4Sfh/uq3qaUUooa7OCw==
X-Google-Smtp-Source: AGHT+IEU/N4uXgtSSj6fnJBcNc9DIraT5Q6dDHAQd3cSc5tkYfiVNSeqYHzUHguJBjOI1H4m96Jdhg==
X-Received: by 2002:a05:6a20:1581:b0:1c4:919f:3677 with SMTP id adf61e73a8af0-1c6996592bdmr17495049637.42.1722876347476;
        Mon, 05 Aug 2024 09:45:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed17c76sm5595957b3a.180.2024.08.05.09.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:45:47 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:46:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 7/9] builtin/refs: add verify subcommand
Message-ID: <ZrEB16WGGc28dxu2@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

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
index 38554b626e..7eb5cdefdd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1333,6 +1333,17 @@ int fsck_finish(struct fsck_options *options)
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
2.46.0

