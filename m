Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700731F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeGaTls (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:41:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38189 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbeGaTls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:41:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so4102901wmi.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=avJczSGTPZxC9SPZro58pTWdFUp5yGKHu4ryLciVRZ0=;
        b=gY9FXRKOZoblG+6C9Wb2tz7s8oosKCYIVnyY+iMg52W4fckpKBcB9vLp+Ig62yvsbU
         JFYGwDeIbaA0ssUbw+OAJ0/y5SdpElvvYsZzoIrvv2svu6hSQAF3oz53bOPGjzNV4Ud5
         ALDqaiGBbTffRLb++GpY87fdXLyK76iH1T9gSSaLBCoqnmjAl1kL4/kbzN2W8kJ1BMx1
         A2fzb5K9dUC6mLmDrGsDkMyQKc3QhGKXYpLewwjNiL9o6lhQeJDrXeAlM1U3RqsVzNWW
         hDXrqEqwW0cAvP72oyZ+R8kMzogTuOHIozz8t5tp8rZJPSt2wvWIv5MGvAxR3RckPONZ
         Sr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=avJczSGTPZxC9SPZro58pTWdFUp5yGKHu4ryLciVRZ0=;
        b=P3VMBGHFAseYDouMkqYnuhMKvluBEMi4wDBJ+Vt0SD+tFGuOPex3yac+EB0JCp3TAa
         uh9e2C8+iAowuT/c6MRjOBo3Fn9LRGPK7rY0aL08pIDXbbS2xpKsLM+D5FJjtCvJ6Wf/
         9EKEnrbIMNHyYQ9Lzj4gLSJwQi+1zUgaVX9HQ/sRyUVyRUOzKnVWDo15Pg1nql2IqLm8
         vQSB7gBSyVzxFQgfBFsKBfPQ93XpibmmQs8WpnpW002lOWSyHB3UMNhiGXVbSehiHR+C
         eauW3gkdHVTARweR+Xi1+dEcyHGypcw6F6KmBUxzat87oy4Cs9B0gd8KKNNKSHo4xwBK
         uwrA==
X-Gm-Message-State: AOUpUlG3/HXRat2BRmrUo+IL6dUYumKd4wsYhAYf+DN+3c9Tac7pbrFr
        htxM6EWoa8E7kNT0XLDIrMfnZ8Eo
X-Google-Smtp-Source: AAOMgpc0P7Sx8YDhtNrQDfnOzcGwXL6lRgRAqRmBJ9vRJIyVibRYh8dnnO0h1X5Wi8E4Fq5z+FeFLg==
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr449114wmh.151.1533060019403;
        Tue, 31 Jul 2018 11:00:19 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:18 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 01/20] sequencer: make two functions and an enum from sequencer.c public
Date:   Tue, 31 Jul 2018 19:59:44 +0200
Message-Id: <20180731180003.5421-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missing_commit_check_level() and the
enum check_level accessible outside sequencer.c, renames check_level to
missing_commit_check_level, and prefixes its value names by
MISSING_COMMIT_ to avoid namespace pollution.

This function and this enum will eventually be moved to
rebase-interactive.c and become static again, so no special attention
was given to the naming.

This will be needed for the rewrite of append_todo_help() from shell to
C, as it will be in a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v4.

 sequencer.c | 22 +++++++++-------------
 sequencer.h |  8 ++++++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 16c1411054..8eff526584 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -52,7 +52,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * the lines are processed, they are removed from the front of this
  * file and written to the tail of 'done'.
  */
-static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4249,24 +4249,20 @@ int transform_todos(unsigned flags)
 	return i;
 }
 
-enum check_level {
-	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
-};
-
-static enum check_level get_missing_commit_check_level(void)
+enum missing_commit_check_level get_missing_commit_check_level(void)
 {
 	const char *value;
 
 	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
 			!strcasecmp("ignore", value))
-		return CHECK_IGNORE;
+		return MISSING_COMMIT_CHECK_IGNORE;
 	if (!strcasecmp("warn", value))
-		return CHECK_WARN;
+		return MISSING_COMMIT_CHECK_WARN;
 	if (!strcasecmp("error", value))
-		return CHECK_ERROR;
+		return MISSING_COMMIT_CHECK_ERROR;
 	warning(_("unrecognized setting %s for option "
 		  "rebase.missingCommitsCheck. Ignoring."), value);
-	return CHECK_IGNORE;
+	return MISSING_COMMIT_CHECK_IGNORE;
 }
 
 define_commit_slab(commit_seen, unsigned char);
@@ -4278,7 +4274,7 @@ define_commit_slab(commit_seen, unsigned char);
  */
 int check_todo_list(void)
 {
-	enum check_level check_level = get_missing_commit_check_level();
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
@@ -4295,7 +4291,7 @@ int check_todo_list(void)
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
-	if (res || check_level == CHECK_IGNORE)
+	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
 	/* Mark the commits in git-rebase-todo as seen */
@@ -4330,7 +4326,7 @@ int check_todo_list(void)
 	if (!missing.len)
 		goto leave_check;
 
-	if (check_level == CHECK_ERROR)
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
 		advise_to_edit_todo = res = 1;
 
 	fprintf(stderr,
diff --git a/sequencer.h b/sequencer.h
index c5787c6b56..ffab798f1e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
+const char *rebase_path_todo(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
@@ -57,6 +58,12 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
+enum missing_commit_check_level {
+	MISSING_COMMIT_CHECK_IGNORE = 0,
+	MISSING_COMMIT_CHECK_WARN,
+	MISSING_COMMIT_CHECK_ERROR
+};
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
@@ -79,6 +86,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
+enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.18.0

