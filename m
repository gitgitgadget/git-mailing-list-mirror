Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9EBC677F1
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 20:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBWUzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBWUzH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 15:55:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37514EBD
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:55:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r7so11657311wrz.6
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNw93lSd/GN1jkFYpBRUhEcbTdpObtt4fiCmOmMjZ/c=;
        b=LD3MgQSMi5SGP1L3agt7Q6AtN2EDExyuM54DB/j1hxoZi65dXJkjiS3FV/ymL7PhZd
         0niVgrhKZ6eVaGxIRNowy/zzIpaly4k4CSTW/s6hVc8wP1ZmfUFQPHyA2yxFtXOzGeR/
         RXy2i975KepEZUwIVHLstH0lS59PL0Ihix1ca03Mzq8rCSxJzWfWUNMY0CMj57bHW21W
         sYYUQzleeITgrpCqlkKmbizpsdKTikGq8/48q6eTjdQXXOBFhGhu+nPVm1ILqpTGGhS2
         p4oDydLMyLT+Xp3C+Tgpka4EanwVEnLb5syQy23sLDvlYcSFFvijXPfmou+K1H7Nkj/B
         pdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNw93lSd/GN1jkFYpBRUhEcbTdpObtt4fiCmOmMjZ/c=;
        b=7lN9B2yrjWUVkXf7lHy5jEVx5655f0tlrIa0/GQNSpTpvdeVaSQLEeswrXo/iaUKOd
         zX78YNe1JJzrwEjpXdeMXdyCa5KfyL+ofsMV7R9g6LrxiVd570ZJYfQM+cZJbE5yIGcf
         ZhYPoQ6VtemH1OvyMyomt5b1MSkuV7lxzA74IL9IkVY30V0r+TXSTfYC4m1TKOda/c8z
         dVAtZkBittDHoe0Q4OlnSdNMFpxrMuqIWGHLs8qndmc8gnCDjnDjiABUxYA2LHnmLJpc
         iwp2uFbwl+A2C7RmWbH3gKl+XA6zt0ol83PCMlP439eNd1ds9g03Vw/ZcL/1bfGJIozz
         efpQ==
X-Gm-Message-State: AO0yUKX/+tw9IxzMW1QVJvK5dJJF4oTefAyK7UUoSSBX/TupyfbexXoD
        DEPBCa/oAOQAD5IUFx7+2lyBD8G6wzE=
X-Google-Smtp-Source: AK7set8VQHRxcRMujPDELBpWLoySf8qpZcp/aZhYXNmuezz75PHhIFX0FCMORz7GQsTJJ9km8UIonw==
X-Received: by 2002:adf:efca:0:b0:2bf:b92b:8a8a with SMTP id i10-20020adfefca000000b002bfb92b8a8amr12895493wrp.7.1677185703747;
        Thu, 23 Feb 2023 12:55:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b002c54241b4fesm1771130wrr.80.2023.02.23.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 12:55:03 -0800 (PST)
Message-Id: <b050e7c1a4daf6c65aa9b2b6f44248d7b403918e.1677185702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
References: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 20:55:00 +0000
Subject: [PATCH 1/2] rebase -i: match whole word in is_command()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When matching an unabbreviated command is_command() only does a prefix
match which means it parses "pickled" as TODO_PICK. parse_insn_line()
does error out because is_command() only advances as far as the end of
"pick" so it looks like the command name is not followed by a space but
the error message is "missing arguments for pick" rather than telling
the user that the "pickled" is not a valid command.

Fix this by ensuring the match is follow by whitespace or the end of the
string as we already do for abbreviated commands. The (*bol = p) at the
end of the condition is a bit cute for my taste but I decided to leave
it be for now. Rather than add new tests the existing tests for bad
commands are adapted to use a bad command name that triggers the prefix
matching bug.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 12 ++++++------
 t/lib-rebase.sh               |  2 +-
 t/t3404-rebase-interactive.sh | 12 +++++++-----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65a34f9676c..d19ee189b57 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2479,12 +2479,11 @@ static int is_command(enum todo_command command, const char **bol)
 {
 	const char *str = todo_command_info[command].str;
 	const char nick = todo_command_info[command].c;
-	const char *p = *bol + 1;
+	const char *p = *bol;
 
-	return skip_prefix(*bol, str, bol) ||
-		((nick && **bol == nick) &&
-		 (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
-		 (*bol = p));
+	return (skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
+		(*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
+		(*bol = p);
 }
 
 static int parse_insn_line(struct repository *r, struct todo_item *item,
@@ -2513,7 +2512,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			break;
 		}
 	if (i >= TODO_COMMENT)
-		return -1;
+		return error(_("invalid command '%.*s'"),
+			     (int)strcspn(bol, " \t\r\n"), bol);
 
 	/* Eat up extra spaces/ tabs before object name */
 	padding = strspn(bol, " \t");
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index b57541356bd..1d2f0429aea 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -60,7 +60,7 @@ set_fake_editor () {
 		">")
 			echo >> "$1";;
 		bad)
-			action="badcmd";;
+			action="pickled";;
 		fakesha)
 			test \& != "$action" || action=pick
 			echo "$action XXXXXXX False commit" >> "$1"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 462cefd25df..3862a4301a6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1449,14 +1449,15 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ig
 
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
 	cat >expect <<-EOF &&
-	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
+	error: invalid command '\''pickled'\''
+	error: invalid line 1: pickled $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
 	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
 	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
 	To avoid this message, use "drop" to explicitly remove a commit.
 	EOF
-	head -n4 expect >expect.2 &&
+	head -n5 expect >expect.2 &&
 	tail -n1 expect >>expect.2 &&
 	tail -n4 expect.2 >expect.3 &&
 	test_config rebase.missingCommitsCheck warn &&
@@ -1467,7 +1468,7 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = wa
 			git rebase -i --root &&
 		cp .git/rebase-merge/git-rebase-todo.backup orig &&
 		FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
-		head -n6 actual.2 >actual &&
+		head -n7 actual.2 >actual &&
 		test_cmp expect actual &&
 		cp orig .git/rebase-merge/git-rebase-todo &&
 		FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual.2 &&
@@ -1483,7 +1484,8 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = wa
 
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
 	cat >expect <<-EOF &&
-	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
+	error: invalid command '\''pickled'\''
+	error: invalid line 1: pickled $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
 	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
@@ -1583,7 +1585,7 @@ test_expect_success 'static check of bad command' '
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-		test_i18ngrep "badcmd $(git rev-list --oneline -1 primary~1)" \
+		test_i18ngrep "pickled $(git rev-list --oneline -1 primary~1)" \
 				actual &&
 		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
 				actual &&
-- 
gitgitgadget

