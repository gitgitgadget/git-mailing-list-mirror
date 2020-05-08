Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1904C35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 00:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0869208CA
	for <git@archiver.kernel.org>; Fri,  8 May 2020 00:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBU5uTMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHAyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEHAyH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 20:54:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CA1C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 17:54:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r18so9560386ybg.10
        for <git@vger.kernel.org>; Thu, 07 May 2020 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=wfa9NEvwjio7nTg6iqA/8JeSu38G7Qp4CMIhhIE1/+o=;
        b=dBU5uTMdJ4zpgt+NzWOWNDqu1lLlApk68c1i9ZSZbo2qDcHKuNIt9+GH6Prviv0J3u
         xI+IEjIJvkIIKa2sJFn1AM5GSJ/1ed4p3qUH1kJxDSivZGjeEzmpHwp5gWoQ2sSXt20B
         3VEAC9J7crkx+QwUvUC2EyhsUzJcaZE5/3pR0gAGrVSDprzAExvFgT83c9DRC0nl/UC3
         Ak3VgjMUtFohq+BRgqQItonDPlFmbHMNs9LNMoBpXfySSETYua4tYbV6UN03ZsvzinYO
         QyCLQgZ0OzUNnF7GHTTrEvcEmbxsU/DU+6DEm1jb/f3ClMm/vrpNwlYR/3GeGRfIuz0r
         rlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=wfa9NEvwjio7nTg6iqA/8JeSu38G7Qp4CMIhhIE1/+o=;
        b=U+1eFKxjRAfuDzbpVefuxl9gjCdx5/V0HLkjGbdI3WJXPYtdx13s8FFC/Ts9QX3c9U
         11weaCsWrdJlzqkK+i66MoGnTt+NxcTEpfAsmJYA80gDMRhaSelf80d4Huk6uAoiGWU8
         8+nlB7Kp1FoVSxHaLawwqmQ7TuoXTJabgb2SpA2zqG8Dty2BdShmYp5F71/NclMPMdnp
         Zwe9pgkA0xBNXFYYa75u5YwnRWgHZRPYC2Dw5jkTjUBMEhKS+NpBoOaXJMYE+4DMnpxF
         ZbqvbxgLTOZROXNklDUFyweB2GtwtT8L+3YzhjozC2HP1BTs26c4Hr2kiakFC06bExQg
         t/4g==
X-Gm-Message-State: AGi0PuahUrXa5OyogGwrVd+WKpBjtvVE86aoF2Jj4GayK8Ot4M0/d+Ml
        aAe5AMJ47SOkL/l0yPi0ALUKg/P22mUZmmC+uR9iJZYVNskIlpkCfj5mmT0FJRbYb85V05thnXx
        QWQwzHj7mPZI2zmGngyl/Fo9sARvyMPgf16ZO3n3Vi1KlvIeFfxzvEDW+seFJyEI2TJRarFkacQ
        ==
X-Google-Smtp-Source: APiQypIMC/c9QmpTGngR0oKMZLjFa5O4UzFDsLYJjLRsPdonYbeai7Aor6eViFdbf1QCIQFOp8aaroDDmKGYz+oQtR8=
X-Received: by 2002:a25:d90f:: with SMTP id q15mr523642ybg.46.1588899246274;
 Thu, 07 May 2020 17:54:06 -0700 (PDT)
Date:   Thu,  7 May 2020 17:53:57 -0700
In-Reply-To: <20200430012425.209122-1-emilyshaffer@google.com>
Message-Id: <20200508005357.223058-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v4] bugreport: collect list of populated hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
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
Since v3, squashed Junio's suggestion
(https://lore.kernel.org/git/xmqqwo5wpqvg.fsf@gitster.c.googlers.com)
but kept the test_when_finished cleanup lines to try to avoid leaving
junk for later tests.

CI: https://github.com/nasamuffin/git/actions/runs/98568890, which seems
like it might be flaky. Have failed a couple because of downloads timing
out... but I'm on top of next from a while ago, so I might be missing
some extra Actions topics?

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
index 2e73658a5c..ff317cce68 100755
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
+		write_script ".git/hooks/$hook" <<-\EOF || return 1
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

