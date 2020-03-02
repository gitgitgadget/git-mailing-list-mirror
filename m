Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE0C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DB921739
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDFvBDPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCBXEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:04:16 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:58274 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 18:04:16 -0500
Received: by mail-pj1-f74.google.com with SMTP id ca1so519094pjb.7
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 15:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zpn/NOdEG/r8l3Vr/mYk2qmngwBLogxV7LJuAfzZPlU=;
        b=wDFvBDPTEBglmqB+LzKwPCG5lAbGU6Y4NZ04jiVonUSSotHtXuC94JeMq0hFggKPet
         MxDFVYZ/+9Nmzt+xxKhOcH+rswRKebNNKW0JVdWK2Gl5huyHACSN6oKtfXsKpwG4xEy2
         9BKcv+TJefO1FyGXM/aOyDtHC/OmQXgI+hczNv5fS9PFKabE0dqxSB8OU2Skxiek716e
         07Q0sw2NNHiohhQW4dODRPt+WfG55WE6nOn67Eqh6R/cPdnUPqWlbFf+/PgFQqZ788t1
         L8ypXpJABo4DHbeFvFK+Ov6AYATjPoRhubkTxuLq5S/OYEbz6vBz5YbzD5wMorksMKBF
         qvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zpn/NOdEG/r8l3Vr/mYk2qmngwBLogxV7LJuAfzZPlU=;
        b=udZiglWE36jfg55Qi1mVAwvqxeJGjlGCpicpwrHRxPZzvQ0xFRPBaFDnnH2rLs1SRA
         kDOOgViKv8oYp5Mp2c+zczN3vHL+SwG6UU0gLxlaFdNF/h05gwK+rdnNpjtA5mOuaT5+
         pZ1SH1mOqUBrbdA0hwyEZNvC/pZH0qeNYHP8RvonBgCBIry1roykDpmk10siv0NfDZ/4
         LVcO9vnpV7czYRBj/SB9ccOr9Y/X5stzNIt8wYSWxgRkIzlZUHzsQx8JrWdcFPznuSST
         /617mzVfUwJvtQfj8dEMgVzZa2ISvLbr+RY+EiGTtwWN+ePOYF+I4fzmCvJOTGDgVowx
         ehyg==
X-Gm-Message-State: ANhLgQ3KaRu2Iky5PRFTcbS45kAP6kFAXiggBH+C1L/mhinfK5pIcUPL
        Lgc/xkdDtxN+lqBbtMZdgnB1ODN6aPthIXTOZnUgIQV/3X+eJqKFXfTDGwwp4vp9rHxeRsj4NSn
        z1S1i7W8zeKLbQdsN/unBojNcOZwk2x/YJRzJd60vo90aNn+EnjT9e5hhAv+xm33NWHeJgLQSWA
        ==
X-Google-Smtp-Source: ADFU+vs9rb6cyGJseDxw3SDLMTvMWxhen+IRA4KLsrVgtkeADVQHelmG7uMLKUMRgw+htugbrVzsqZ972mg//ieVpcw=
X-Received: by 2002:a63:ef03:: with SMTP id u3mr1103529pgh.77.1583190254795;
 Mon, 02 Mar 2020 15:04:14 -0800 (PST)
Date:   Mon,  2 Mar 2020 15:03:58 -0800
In-Reply-To: <20200302230400.107428-1-emilyshaffer@google.com>
Message-Id: <20200302230400.107428-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200302230400.107428-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 3/5] bugreport: gather git version and build info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Knowing which version of Git a user has and how it was built allows us
to more precisely pin down the circumstances when a certain issue
occurs, so teach bugreport how to tell us the same output as 'git
version --build-options'.

It's not ideal to directly call 'git version --build-options' because
that output goes to stdout. Instead, wrap the version string in a helper
within help.[ch] library, and call that helper from within the bugreport
library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  4 +++
 bugreport.c                     | 19 +++++++++++++-
 help.c                          | 46 ++++++++++++++++++++-------------
 help.h                          |  1 +
 4 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 1f9fde5cde..f44ae8cbe7 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -23,6 +23,10 @@ The following information is requested from the user:
  - Expected behavior
  - Actual behavior
 
+The following information is captured automatically:
+
+ - 'git version --build-options'
+
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
 is unreadable. In this kind of scenario, it may be helpful to manually gather
diff --git a/bugreport.c b/bugreport.c
index f473d606f2..c20437dc6a 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -1,8 +1,17 @@
-#include "builtin.h"
+#include "cache.h"
 #include "parse-options.h"
 #include "stdio.h"
 #include "strbuf.h"
 #include "time.h"
+#include "help.h"
+
+static void get_system_info(struct strbuf *sys_info)
+{
+	/* get git version from native cmd */
+	strbuf_addstr(sys_info, _("git version:\n"));
+	get_version_info(sys_info, 1);
+	strbuf_complete_line(sys_info);
+}
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
@@ -32,6 +41,11 @@ static int get_bug_template(struct strbuf *template)
 	return 0;
 }
 
+static void get_header(struct strbuf *buf, const char *title)
+{
+	strbuf_addf(buf, "\n\n[%s]\n", title);
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -79,6 +93,9 @@ int cmd_main(int argc, const char **argv)
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
+	get_header(&buffer, _("System Info"));
+	get_system_info(&buffer);
+
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
diff --git a/help.c b/help.c
index a21487db77..1de9c0d589 100644
--- a/help.c
+++ b/help.c
@@ -622,8 +622,32 @@ const char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
+void get_version_info(struct strbuf *buf, int show_build_options)
+{
+	/*
+	 * The format of this string should be kept stable for compatibility
+	 * with external projects that rely on the output of "git version".
+	 *
+	 * Always show the version, even if other options are given.
+	 */
+	strbuf_addf(buf, "git version %s\n", git_version_string);
+
+	if (show_build_options) {
+		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
+		if (git_built_from_commit_string[0])
+			strbuf_addf(buf, "built from commit: %s\n",
+			       git_built_from_commit_string);
+		else
+			strbuf_addstr(buf, "no commit associated with this build\n");
+		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
+		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
+		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+	}
+}
+
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf buf = STRBUF_INIT;
 	int build_options = 0;
 	const char * const usage[] = {
 		N_("git version [<options>]"),
@@ -637,25 +661,11 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	/*
-	 * The format of this string should be kept stable for compatibility
-	 * with external projects that rely on the output of "git version".
-	 *
-	 * Always show the version, even if other options are given.
-	 */
-	printf("git version %s\n", git_version_string);
+	get_version_info(&buf, build_options);
+	printf("%s", buf.buf);
+
+	strbuf_release(&buf);
 
-	if (build_options) {
-		printf("cpu: %s\n", GIT_HOST_CPU);
-		if (git_built_from_commit_string[0])
-			printf("built from commit: %s\n",
-			       git_built_from_commit_string);
-		else
-			printf("no commit associated with this build\n");
-		printf("sizeof-long: %d\n", (int)sizeof(long));
-		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
-		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
-	}
 	return 0;
 }
 
diff --git a/help.h b/help.h
index 9071894e8c..500521b908 100644
--- a/help.h
+++ b/help.h
@@ -37,6 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 int is_in_cmdlist(struct cmdnames *cmds, const char *name);
 void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+void get_version_info(struct strbuf *buf, int show_build_options);
 
 /*
  * call this to die(), when it is suspected that the user mistyped a
-- 
2.25.0.265.gbab2e86ba0-goog

