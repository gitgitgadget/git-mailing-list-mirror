Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0151F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKNQgA (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:36:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51171 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfKNQf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:35:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so6354950wmh.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 08:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WxU4SeXdurZ1TPeD9f9Z89k0K8utP21xtvYrayuM6ds=;
        b=Asj4TiAkouTkmK48/ygw5F3k8Z+gHPb5+EnQ59DHtLb+Nc5FfWjYEuM9NglEIqL7rJ
         DmUlUQgZTU6XTk2q4WWHeCmGNQaaCd7hIxleRosGoAoGTxSrdljsM2ZxlZWDgtJc5z0s
         oVI8OOY2o8qXrdg+iichzsTFBDFFpdUrRmozFY7sThCVZWb8iPhkzPF4zURwOSscYYiY
         xih7eEgFkuJ30dRa9esAPoyYEtVMgcOtJoVZRPDN1r+JhBglo6HO3tLYObz4c2lpCbnl
         hegGpYkeGFthgKBG1HXXrX9tKP5TLri+GyqRV/D6ah7v28lOOUn+dzKGx54rTaSbWPXE
         4p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxU4SeXdurZ1TPeD9f9Z89k0K8utP21xtvYrayuM6ds=;
        b=gk93f/y67G62xitNIQ91fCrDIvtlMFz3wPVWkPPKF9VlDQCw0buxSd9lI2emYDSkog
         d1JKotde9yeT/W2vRIeCVUjQbY6G6+C9/u2Q5x/lQ+p2dxatXpav8rpIY7P/Tbd5Gpei
         DrF/gxXvA40e1Ok2QMsJwG6WFifRYYCYCUB+Lt4I0YdybFSpU+M18xB6x2pidt3n2YFC
         NVXuFSkTeb9F405OBkfmrH3QtpaXyQkd8m/NpwfMgyIOXFgYo7uddzg0WQlBlgsEiT6F
         lThkhp+2FKsE57mVkNjDduvsC42bVlDvK2t6mpHwbdK3TS70yzD3crD+jPnq2rPPR7FT
         XAdA==
X-Gm-Message-State: APjAAAVqv8Am2Ktp8qtN+vZmk1RIy4/yt6J0Icfwn3qveEhKjbpc6Fyy
        muR/A/GlciyHQ1F8BBkHuUIIhqgyvOY=
X-Google-Smtp-Source: APXvYqzI0stFv10MCQZxRgRDpYwJTYF/REqIamfxtyeroQQp+pYCgUKB6Uy4iOhp6SXivpRyqWh50w==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr9137902wmg.93.1573749354464;
        Thu, 14 Nov 2019 08:35:54 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id h124sm7429008wme.30.2019.11.14.08.35.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:35:53 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] rebase -i: allow --edit-todo with --exec
Date:   Thu, 14 Nov 2019 17:35:49 +0100
Message-Id: <20191114163549.7648-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191114163549.7648-1-rybak.a.v@gmail.com>
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using rebase, option --exec can be used, for example, to run tests
after every commit created by rebase.  When using interactive rebase, I
don't always know, if I would want to run something against each commit
before I start rebasing.  Sometimes, I realize this only after doing
some editing in the middle of the rebase.  To do that, I have to
manually edit the todo file.  Additing exec command by hand or
semi-automatically is cumbersome and error prone.  Especially if the
file is big or complex, e.g. when option --rebase-merges is used.

Allow using the --edit-todo action of git rebase with option --exec.
New test is based on test 'rebase --edit-todo can be used to modify
todo'.  Contents of todo file are checked using set_cat_todo_editor
similarly to what test 'respects rebase.abbreviateCommands with fixup,
squash and exec' does.

Remove unnecessary braces around call to usage_with_options, while we're
here.

TODO: Still need better validation of options. With current
      implementation, the following is not rejected:

	git rebase --edit-todo -x 'git show HEAD' --autostash

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-rebase.txt  |  3 ++-
 builtin/rebase.c              | 16 +++++++++++++---
 t/t3404-rebase-interactive.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 639a4179d1..b5db5e80d4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
+'git rebase' (--continue | --skip | --abort | --quit |
+	--edit-todo [--exec<cmd>] | --show-current-patch)
 
 DESCRIPTION
 -----------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27507d3cf6..1ee55b48e7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -33,7 +33,8 @@ static char const * const builtin_rebase_usage[] = {
 		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
-	N_("git rebase --continue | --abort | --skip | --edit-todo"),
+	N_("git rebase --continue | --abort | --skip | "
+		"--edit-todo [--exec <cmd>]"),
 	NULL
 };
 
@@ -409,6 +410,11 @@ static int run_rebase_interactive(struct rebase_options *opts,
 		break;
 	}
 	case ACTION_EDIT_TODO:
+		if (opts->cmd) {
+			ret = add_exec(opts->cmd);
+			if (ret)
+				break;
+		}
 		ret = edit_todo_file(flags);
 		break;
 	case ACTION_SHOW_CURRENT_PATCH: {
@@ -1565,15 +1571,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
-	if (action != ACTION_NONE && total_argc != 2) {
+	if (action != ACTION_NONE && action != ACTION_EDIT_TODO &&
+	    total_argc != 2)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
-	}
 
 	if (argc > 2)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (action == ACTION_EDIT_TODO && argc > 0)
+		usage_with_options(builtin_rebase_usage,
+				   builtin_rebase_options);
+
 	if (options.type == REBASE_PRESERVE_MERGES)
 		warning(_("git rebase --preserve-merges is deprecated. "
 			  "Use --rebase-merges instead."));
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d2dfbe46b9..5decb8570e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1082,6 +1082,38 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_success 'rebase --edit-todo can be used with -x' '
+	test_when_finished "reset_rebase" &&
+	git reset --hard &&
+	git checkout no-conflict-branch^0 &&
+	cat >expected <<-EOF &&
+	pick $(git rev-list --abbrev-commit -1 HEAD^) L
+	exec git show HEAD
+	pick $(git rev-list --abbrev-commit -1 HEAD) M
+	exec git show HEAD
+	EOF
+	set_fake_editor &&
+	FAKE_LINES="1 edit 2 3 4" git rebase -i HEAD~4 &&
+	set_cat_todo_editor &&
+	test_must_fail git rebase --edit-todo -x "git show HEAD" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'rebase --edit-todo -x does not allow other arguments' '
+	test_when_finished "reset_rebase" &&
+	git reset --hard &&
+	git checkout no-conflict-branch^0 &&
+	cat >expected <<-EOF &&
+	pick $(git rev-list --abbrev-commit -1 HEAD^) L
+	exec git show HEAD
+	pick $(git rev-list --abbrev-commit -1 HEAD) M
+	exec git show HEAD
+	EOF
+	set_fake_editor &&
+	FAKE_LINES="1 edit 2 3 4" git rebase -i HEAD~4 &&
+	test_must_fail git rebase --edit-todo -x "git show HEAD" --autostash
+'
+
 test_expect_success 'rebase -i produces readable reflog' '
 	git reset --hard &&
 	git branch -f branch-reflog-test H &&
-- 
2.24.0.windows.2

