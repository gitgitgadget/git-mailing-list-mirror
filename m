Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE9C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiHJXfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHJXe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913D98FD5C
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i128-20020a1c3b86000000b003a536d58f73so1840037wma.4
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mARxQC56HROeHfnGhKZI2tZ091Okd3Z5usLlYR6Qcug=;
        b=dmXSfnrqe4My7C8LsZZ+jd4qsweTkKhTPBY7myC3Gt3OKzPdID28+dW0PKJ6ZyZqqP
         tDSZdnOZkBwnm0tjrL0fpJqZzHrQJGmTeDO4UhOLW/1OV3ZYsRnXJnHU0xeP+8E0JWzB
         8NOMIeqaZiI8gRfVB8uAcEKWbFr4cBrS+S26oI9ODTZvN0TNqDRcVk332GwFg/LPzM8r
         hCtyLkbMn7+mG9MUF4Nw8oHIt+UwlujkMgnF4PuTx0JoJHUwsuUKJ62/2/h6yre85Su4
         At7/zGXS867ohTykBksswlQ4VSiG0I1+P5wDbd8aF9yrn304BHveB//zn01jeZBelOwi
         R9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mARxQC56HROeHfnGhKZI2tZ091Okd3Z5usLlYR6Qcug=;
        b=wSPU9AJIBwhSaAThWQZBF+86Gyhs9yS1LSOgfS7RvCiBTGrhwpGUizSFFdtH+ZbTPU
         H/eVqNTyU0HtPgPz62rcusGEbkQIsk9UeFg+FjdmCRW8rBec7EJV1ahgt/iaq86HQXlT
         3piSXhU4H35TGFlJrYjcjgeAYuQ8eJ/9q6kOuPc2gM2uutUOhhIl+f1UWNuN75qcPrxM
         31zCK42Cq1YKGfxsifPsWtxJ6WFkDiFTFFdSvnTJXMumVY/5XiA8Ot9eFnND5jD2rAgA
         +UAW4or5lVPJsSbPPO/XlzCqYRgaVhO2LEDC+/B85H1rto9QV8dOsXl6jdmp9ztLtPN7
         mjfQ==
X-Gm-Message-State: ACgBeo1EoPJLo5ar1CNOb8pYzrQ/8zP7SfGKQDtNqo9HAr5iXLFte74G
        Dl/FYHa2K3hwn8edD7N8LkISxlzzCw0=
X-Google-Smtp-Source: AA6agR5sfVRXgEVA5DyJEfUoxm0soikC2oK0+KH1XyHmOWz4Xl5Z9lW/WVOkEU5LvfuNTvm0/bqKOg==
X-Received: by 2002:a1c:f603:0:b0:3a5:23ca:3e7c with SMTP id w3-20020a1cf603000000b003a523ca3e7cmr3827385wmc.38.1660174482382;
        Wed, 10 Aug 2022 16:34:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17-20020adfec11000000b0021ee0e233d9sm17204866wrn.96.2022.08.10.16.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:42 -0700 (PDT)
Message-Id: <1a1eb2c980635415c04d5c8d9a62bd972482d7dc.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:31 +0000
Subject: [PATCH v3 09/11] builtin/bugreport.c: create '--diagnose' option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create a '--diagnose' option for 'git bugreport' to collect additional
information about the repository and write it to a zipped archive.

The '--diagnose' option behaves effectively as an alias for simultaneously
running 'git bugreport' and 'git diagnose'. In the documentation, users are
explicitly recommended to attach the diagnostics alongside a bug report to
provide additional context to readers, ideally reducing some back-and-forth
between reporters and those debugging the issue.

Note that '--diagnose' may take an optional string arg (either 'stats' or
'all'). If specified without the arg, the behavior corresponds to running
'git diagnose' without '--mode'. As with 'git diagnose', this default is
intended to help reduce unintentional leaking of sensitive information).
Users can also explicitly specify '--diagnose=(stats|all)' to generate the
respective archive created by 'git diagnose --mode=(stats|all)'.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-bugreport.txt | 18 +++++++++++++
 builtin/bugreport.c             | 27 ++++++++++++++++---
 t/t0091-bugreport.sh            | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index d8817bf3cec..eca726e5791 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+		[--diagnose[=<mode>]]
 
 DESCRIPTION
 -----------
@@ -31,6 +32,10 @@ The following information is captured automatically:
  - A list of enabled hooks
  - $SHELL
 
+Additional information may be gathered into a separate zip archive using the
+`--diagnose` option, and can be attached alongside the bugreport document to
+provide additional context to readers.
+
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
 is unreadable. In this kind of scenario, it may be helpful to manually gather
@@ -49,6 +54,19 @@ OPTIONS
 	named 'git-bugreport-<formatted suffix>'. This should take the form of a
 	strftime(3) format string; the current local time will be used.
 
+--no-diagnose::
+--diagnose[=<mode>]::
+	Create a zip archive of supplemental information about the user's
+	machine, Git client, and repository state. The archive is written to the
+	same output directory as the bug report and is named
+	'git-diagnostics-<formatted suffix>'.
++
+Without `mode` specified, the diagnostic archive will contain the default set of
+statistics reported by `git diagnose`. An optional `mode` value may be specified
+to change which information is included in the archive. See
+linkgit:git-diagnose[1] for the list of valid values for `mode` and details
+about their usage.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9de32bc96e7..530895be55f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -5,6 +5,7 @@
 #include "compat/compiler.h"
 #include "hook.h"
 #include "hook-list.h"
+#include "diagnose.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
@@ -59,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
+	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
 	NULL
 };
 
@@ -98,16 +99,21 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	int report = -1;
 	time_t now = time(NULL);
 	struct tm tm;
+	enum diagnose_mode diagnose = DIAGNOSE_NONE;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
+	size_t output_path_len;
 
 	const struct option bugreport_options[] = {
+		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
+			       N_("create an additional zip archive of detailed diagnostics (default 'stats')"),
+			       PARSE_OPT_OPTARG, option_parse_diagnose),
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
-			   N_("specify a destination for the bugreport file")),
+			   N_("specify a destination for the bugreport file(s)")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
-			   N_("specify a strftime format suffix for the filename")),
+			   N_("specify a strftime format suffix for the filename(s)")),
 		OPT_END()
 	};
 
@@ -119,6 +125,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 					    option_output ? option_output : "");
 	strbuf_addstr(&report_path, prefixed_filename);
 	strbuf_complete(&report_path, '/');
+	output_path_len = report_path.len;
 
 	strbuf_addstr(&report_path, "git-bugreport-");
 	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
@@ -133,6 +140,20 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		    report_path.buf);
 	}
 
+	/* Prepare diagnostics, if requested */
+	if (diagnose != DIAGNOSE_NONE) {
+		struct strbuf zip_path = STRBUF_INIT;
+		strbuf_add(&zip_path, report_path.buf, output_path_len);
+		strbuf_addstr(&zip_path, "git-diagnostics-");
+		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+		strbuf_addstr(&zip_path, ".zip");
+
+		if (create_diagnostics_archive(&zip_path, diagnose))
+			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
+
+		strbuf_release(&zip_path);
+	}
+
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 08f5fe9caef..b6d2f591acd 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -78,4 +78,52 @@ test_expect_success 'indicates populated hooks' '
 	test_cmp expect actual
 '
 
+test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose -o report -s test >out &&
+
+	zip_path=report/git-diagnostics-test.zip &&
+	grep "Available space" out &&
+	test_path_is_file "$zip_path" &&
+
+	# Check zipped archive content
+	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out &&
+
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [0-9][0-9]*" out &&
+
+	# Should not include .git directory contents by default
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+'
+
+test_expect_success UNZIP '--diagnose=stats excludes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose=stats -o report -s test >out &&
+
+	# Includes pack quantity/size info
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	# Does not include .git directory contents
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+'
+
+test_expect_success UNZIP '--diagnose=all includes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose=all -o report -s test >out &&
+
+	# Includes .git directory contents
+	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
+
+	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
+	test_file_not_empty out
+'
+
 test_done
-- 
gitgitgadget

