Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3F01F516
	for <e@80x24.org>; Thu, 28 Jun 2018 10:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933017AbeF1KEb (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 06:04:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37836 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeF1KE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 06:04:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so7858923wmh.2
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aF8+2TZbrwr2UiFVOb6g9dMjUnujMF7Oxu1m03KJRZY=;
        b=M0X3B55/t/dk2S5dJopRoj8Nku9C1QQN0V3qZJOp9v1FT/5Z7nqJbjVkrpRVKV2006
         OHtm6YAsXeVeSAuJy7SWiEIjLlJIDPmW1wBBYJtLEfc8xVgxyHMHLZTWpkq0hJnBJFtl
         v+UOfE/0Nq6ofm2/M5bI4UBUkyd+eSCh9dUNW0ymWSt2hDZRpOu/+izC6YOkp5B7on3C
         YL9ewAe1ErtqJ2sf+X6y1sJD5T2kGDzEUgUVareZv5BMtREHftZmyAFu81wOh0Zew4Jo
         Labh0vVuhj38L+ECmPzwZiIFLf0bqhtZUz9neL2aHy0+dzF07UV0+CGlY+OY3LoGzlMK
         JQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aF8+2TZbrwr2UiFVOb6g9dMjUnujMF7Oxu1m03KJRZY=;
        b=PxjqWPO2OkLo6eeAu2k7TkD1f/ZLdcMmmQRcXbzNCdx5N46WpF5J2hR+Mi0kpHm2ps
         jWkDto5kurnRM/35EeP/3HEGy0vvAZfTIyzrwjHKqnNtS6cdHHNudyGbOWV9TOwWcUIi
         Y74nfMESDdZwOr3+ttQsrjbRCxzQEC8WAuEtrKl4NUjfOkkbDnF0EkHP0RNPyrhDbif6
         NrS45Atg+zSLz2lP2xG1GZHcW/iVkn+KuFMdaLbmNTqoZwsgaf57iUa/v9Y8KZ5a3zQw
         3rRPSNjbcOQSzQF0/iGYkFaOn4HeIlPaScfnJV9Lfjf/AdcfZX7XYR1hEC2SzMXitCGz
         P/Kg==
X-Gm-Message-State: APt69E2mQlE87wpLcP+uKZRHRZy+VGw1qktnqSIgevcwSBYbxfmbW1Bg
        Pa4kVZhrekmWHayVLlyCzqqTMaCS
X-Google-Smtp-Source: AAOMgpdE6qW0yvpp+Q0EJVDKPP3088QkophgW1xV3J4/8LEoA3bYr/8kaceZG1RwItUisYh+xBAD7g==
X-Received: by 2002:a1c:387:: with SMTP id 129-v6mr7743583wmd.53.1530180266939;
        Thu, 28 Jun 2018 03:04:26 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id x10-v6sm4857893wrn.25.2018.06.28.03.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 03:04:25 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 1/2] sequencer: make two functions and an enum from sequencer.c public
Date:   Thu, 28 Jun 2018 12:04:10 +0200
Message-Id: <20180628100411.8092-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628100411.8092-1-alban.gruin@gmail.com>
References: <20180626161643.31152-1-alban.gruin@gmail.com>
 <20180628100411.8092-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missing_commit_check_level() and the
enum check_level accessible outside sequencer.c.  check_level is renamed
missing_commit_check_level, and its value names are prefixed by
MISSING_COMMIT_ to avoid namespace pollution.

This will be needed for the rewrite of append_todo_help() from shell to
C, as it will be in a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 22 +++++++++-------------
 sequencer.h |  8 ++++++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a291c91f..cb7ec9807 100644
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
@@ -4223,24 +4223,20 @@ int transform_todos(unsigned flags)
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
@@ -4252,7 +4248,7 @@ define_commit_slab(commit_seen, unsigned char);
  */
 int check_todo_list(void)
 {
-	enum check_level check_level = get_missing_commit_check_level();
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
@@ -4269,7 +4265,7 @@ int check_todo_list(void)
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
-	if (res || check_level == CHECK_IGNORE)
+	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
 	/* Mark the commits in git-rebase-todo as seen */
@@ -4304,7 +4300,7 @@ int check_todo_list(void)
 	if (!missing.len)
 		goto leave_check;
 
-	if (check_level == CHECK_ERROR)
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
 		advise_to_edit_todo = res = 1;
 
 	fprintf(stderr,
diff --git a/sequencer.h b/sequencer.h
index c5787c6b5..ffab798f1 100644
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

