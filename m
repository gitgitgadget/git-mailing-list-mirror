Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2BC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 23:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE56214AF
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 23:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmuK/Hr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDXXiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXXiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 19:38:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BEDC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 16:38:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id bg6so9402185pjb.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ItUTao6VUv1ie5GJfwcpJ4mgovChm3zNfWZV2i6Hz+M=;
        b=QmuK/Hr7IPPQIFVHCCbBa00/Zipg8qV/jEk6/hpT2OIZ3sDixgGKk8Qf9m3o2UV1NP
         uiUTNoDq3vZ0L+JE28Y3sT4WTjr9bfraFpUtA56NXA9yRV3iO82YHHkOU0NjCQRG0hKx
         6/FQEtLNlMXYMzraCCeffHtsm/QU9sqos5qoT4fsZ8ouNpj72Tqz/0U9v/tYbMmT/aEA
         ToDjx1IRUYZX6muNe3kc/Ama66oExuAPp19tVXMDCZQkMNdEYwOASyCv0WV7AIcm281n
         BhiIV64GdFfzLAgJtaTKUUngLkziu4ROnRpeYDNxrr2KCfFQpaU/l6x9zpgyKU1gmgfw
         DY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ItUTao6VUv1ie5GJfwcpJ4mgovChm3zNfWZV2i6Hz+M=;
        b=AiB7alqtxYPRmblov6YHoYEqid6ZSmICC4RAbg9aVxsVWvRH1wOT0JjPpSIMc7Y16D
         doONR/SAXCozLUa/pwSHm0mdl/zHc4tu+tusTnAkvDNfsmw1pB8x4FMHk53lszu+Er+N
         /d2VSSYK86BS+rCWfn1NcdfkoMioBVWi+pgVTumvhxDVlCuXmJ6ebWyJC9VNKpehisvC
         CNdYL1jvRnolAM3SVpGut17R5jxLjthBDrqsabb3HV0edzWfvqaWwhoBaFJr+65MwVNu
         js+YCNSmw/aTPzQOy1XnXlq9suu2WSKlXCfky6cLCulsQ4xhwwLYA5Ik8Z1NrGpFRWyi
         zYSA==
X-Gm-Message-State: AGi0PuYsIQyJaJeGjxeyGEEDZU5BCRSpQSLFRVZtDr5CJf8nbBLYxTGV
        q8YTJvR/4JMoiTjOO6YszTz3mnQn7MHsoHaOupMajFUl6GMjjBZnrWlbSzkg9twPtRNMBw2Uclz
        5tUb7qoO7k8ggZ4EWoFZnG/dWjSkWe3YTq7RsMFnqaB7KYzLvU65Ql0vtZdSdJ3oAcWN6wH34ZQ
        ==
X-Google-Smtp-Source: APiQypJXUty5/dqE2WYQ68JOJUBQFtnmNfTc3XombiwmV8ZcY6EpMUuNnaeyRTxWKEZRss7SgrynAr1o8plSUV95aKM=
X-Received: by 2002:a63:f610:: with SMTP id m16mr11773961pgh.450.1587771484565;
 Fri, 24 Apr 2020 16:38:04 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:38:00 -0700
Message-Id: <20200424233800.200439-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] bugreport: collect list of populated hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Occasionally a failure a user is seeing may be related to a specific
hook which is being run, perhaps without the user realizing. While the
contents of hooks can be sensitive - containing user data or process
information specific to the user's organization - simply knowing that a
hook is being run at a certain stage can help us to understand whether
something is going wrong.

Without a definitive list of hook names within the code, we compile our
own list from the documentation. This is likely prone to bitrot. To
reduce the amount of code humans need to read, we turn the list into a
string_list and iterate over it (as we are calling the same find_hook
operation on each string). However, since bugreport should primarily be
called by the user, the performance loss from massaging the string
seems acceptable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Based on es/bugreport.

 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 643d1b2884..7fe9aef34e 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -28,6 +28,7 @@ The following information is captured automatically:
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
+ - A list of enabled hooks
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 089b939a87..ce32145bce 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -5,6 +5,8 @@
 #include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
+#include "run-command.h"
+
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -33,6 +35,53 @@ static void get_system_info(struct strbuf *sys_info)
 	get_libc_info(sys_info);
 }
 
+static void get_populated_hooks(struct strbuf *hook_info, int nongit)
+{
+	/*
+	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
+	 * so below is a transcription of `git help hooks`. Later, this should
+	 * be replaced with some programmatically generated list (generated from
+	 * doc or else taken from some library which tells us about all the
+	 * hooks)
+	 */
+	const char *hook[] = {
+		"applypatch-msg",
+		"pre-applypatch",
+		"post-applypatch",
+		"pre-commit",
+		"pre-merge-commit",
+		"prepare-commit-msg",
+		"commit-msg",
+		"post-commit",
+		"pre-rebase",
+		"post-checkout",
+		"post-merge",
+		"pre-push",
+		"pre-receive",
+		"update",
+		"post-receive",
+		"post-update",
+		"push-to-checkout",
+		"pre-auto-gc",
+		"post-rewrite",
+		"sendemail-validate",
+		"fsmonitor-watchman",
+		"p4-pre-submit",
+		"post-index-change",
+	};
+	int i;
+
+	if (nongit) {
+		strbuf_addstr(hook_info,
+			"not run from a git repository - no hooks to show\n");
+		return;
+	}
+
+	for (i=0; i < ARRAY_SIZE(hook); i++)
+		if (find_hook(hook[i]))
+			strbuf_addf(hook_info, "%s\n", hook[i]);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -116,6 +165,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, _("System Info"));
 	get_system_info(&buffer);
 
+	get_header(&buffer, "Enabled Hooks");
+	get_populated_hooks(&buffer, nongit_ok);
+
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
-- 
2.26.2.303.gf8c07b1a785-goog

