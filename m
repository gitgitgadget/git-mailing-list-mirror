Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7C5C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 22:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D664206E6
	for <git@archiver.kernel.org>; Mon, 11 May 2020 22:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWgQzPhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgEKWOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgEKWOh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 18:14:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B63C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 15:14:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d206so13231818ybh.7
        for <git@vger.kernel.org>; Mon, 11 May 2020 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=SBc/iXKO1eIBtpMwXLOOOwxf2jSe/mWV8tRlWYtubKc=;
        b=vWgQzPhVqWpk7BluCKIywy92Dn/vu1A/tBWlfSyS1AhyQSORm5j+1VNPg//2CpIwoG
         Ojn2FLQveFu3rIPI+8iXc6g6+df8jdJ1OZsgTwJ+7wlU98FDzYpKA1rFG9iVYY0UcKgd
         QlVbfp6YLthVT2cb31iA5AZWgCgRXhPwU3QHGHZl+9O/HJpuFYKiJmesP6W5cUr8dZBb
         a8dKCqhm2TGURQhYrqI6l59o31RjutSda9qOTK/ENMo5nIGP8AEENRRAb792iE8W/Tmi
         EXxUcnsC1m2BVySsf6ob7EUQEm/eGBU5MzzCpglYVdtqob6M9V05CfcG+V90Q3TwXpT7
         Cp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=SBc/iXKO1eIBtpMwXLOOOwxf2jSe/mWV8tRlWYtubKc=;
        b=P8UTZFZXLuS+KTL9V0SbV8Sju6cVA4Kd+3klEOH3IkQiplDUAD5Lj8vUR9kjckMdMW
         63l0F9E2K0+W3Uvu2Lo4w7vvMPo5pPy/jrrTQdHTAkvHCqCFAd2YN2q0J7HMWrvkzk1F
         4elQoM0vbHU1wvFC7RTP2EkNtTrvWAcoAPWDKvJbGnYGDSunlp5uyO6WM66l/EtI+zga
         qDGREQwpnGHu7R9lEZAtx2Fv6HgPkHVJMRwo+pcILU1lbV0FPyv9Up2ZI/Xv6tan3fRE
         oC2/g5dRE4Q/upV9Hj99t2El5D+KkovfOfZKc5QW7TdnT8rtRUOr0gfczObPa5d1KbRI
         8veQ==
X-Gm-Message-State: AGi0PuYjYxtTFoxB0Q6xqJB1ZwbjN0nLJefJA6dxgZ8Gnv0gdxfEzpe3
        gWeln/WKrSZsdvSbGqkugpSPFc3i//9OLmf8Y7izoAeA1e+YRP53wejf+9Ey8QzAzF12tODCY52
        k1n4yZyBuHaPRddG4vpEGIr+l5GlBP+DrGaBmOHR+zJjuh3y5LGv5k94ksWeLrnm5HrYuTw61CA
        ==
X-Google-Smtp-Source: APiQypJZ8juhAubi2ueZhk8KHMCHUhoBk4gRbkKisVZd44021ZbC5PfyvLkNb4HN3JN6avXrB9BC7WOvqij5k/u7VHw=
X-Received: by 2002:a25:c6cc:: with SMTP id k195mr17044278ybf.485.1589235274434;
 Mon, 11 May 2020 15:14:34 -0700 (PDT)
Date:   Mon, 11 May 2020 15:14:30 -0700
In-Reply-To: <20200508005357.223058-1-emilyshaffer@google.com>
Message-Id: <20200511221430.174122-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v5] bugreport: collect list of populated hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=" 
        <congdanhqx@gmail.com>
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
own list from the documentation. This is likely prone to bitrot, but
designing a single source of truth for acceptable hooks is too much
overhead for this small change to the bugreport tool.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
The only change since v4 is to uncomment the heredoc, meaning the hook
names will be correctly injected into the test hooks.

I chose not to implement Danh's suggestion of multiline grep:
https://lore.kernel.org/git/20200511212205.GI77802@google.com

Tests passed:
https://github.com/nasamuffin/git/actions/runs/101874479

Thanks, all.
 - Emily

 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
 t/t0091-bugreport.sh            | 15 ++++++++++
 3 files changed, 68 insertions(+)

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
index acacca8fef..aa8a489c35 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -3,6 +3,8 @@
 #include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
+#include "run-command.h"
+
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -31,6 +33,53 @@ static void get_system_info(struct strbuf *sys_info)
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
+	static const char *hook[] = {
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
+			_("not run from a git repository - no hooks to show\n"));
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hook); i++)
+		if (find_hook(hook[i]))
+			strbuf_addf(hook_info, "%s\n", hook[i]);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -114,6 +163,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, _("System Info"));
 	get_system_info(&buffer);
 
+	get_header(&buffer, _("Enabled Hooks"));
+	get_populated_hooks(&buffer, nongit_ok);
+
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 2e73658a5c..526304ff95 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -57,5 +57,20 @@ test_expect_success 'can create leading directories outside of a git dir' '
 	nongit git bugreport -o foo/bar/baz
 '
 
+test_expect_success 'indicates populated hooks' '
+	test_when_finished rm git-bugreport-hooks.txt &&
+	test_when_finished rm -fr .git/hooks &&
+	rm -fr .git/hooks &&
+	mkdir .git/hooks &&
+	for hook in applypatch-msg prepare-commit-msg.sample
+	do
+		write_script ".git/hooks/$hook" <<-EOF || return 1
+		echo "hook $hook exists"
+		EOF
+	done &&
+	git bugreport -s hooks &&
+	grep applypatch-msg git-bugreport-hooks.txt &&
+	! grep prepare-commit-msg git-bugreport-hooks.txt
+'
 
 test_done
-- 
2.26.2.645.ge9eca65c58-goog

