Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90ACD1F42B
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH1QC0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43290 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeH1QC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so1348516wre.10
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ci0b0hKTXJ27fywPAFboWgSlKxhCqDrCuCHNRU1drGM=;
        b=sflf1WRlnec4ZllLR/WrVkUqEwfN4MIG3sigWSPIKuJhvcX88taeeT+yH7WDrSTg42
         AZWxv1I3df5D4hqIs08gA3R6k8a8ioUkqFT/UdyPHfPygqaLAhL6eE1Cu9hH8RcUS5tZ
         Oe7N++PxPa3d4zIuLAjsVUwdR0/0xdZr9wr1Hf+xBR+bVpl8fpsV8PRBmwcRlJ/sBaqu
         G5q+m4ryNWbCvvDsLaNxvAPhr7NEGyoOdxToqLSo7t4zleAIfYVcpqAgQHKqgGT3OkPs
         C5qoVg+Gup3W6w51p/oLwVKJ24JpgqUjtqqt6L0tfu/0de13jvaIS/h9c43FmJNErmK9
         brDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ci0b0hKTXJ27fywPAFboWgSlKxhCqDrCuCHNRU1drGM=;
        b=MaRAhp6lhEMePul1uSdTzgNKn15CCGhrJuRDskzRDDT1QEsLjEcslVSY6kEPGnvSvq
         whYIh5sBIrx70tDlpTD1wXMbA9Yd6bLUrYusSotlrG+7yCihrfqWyFkSQcyISE+qyq/Z
         ATs4cw441s1IH3MitiNvPWaBgqiHjuvw2RxGD9neU47FzKzQQaFKvfEEMxEsBHDF9GIk
         hkADRM0Q8iqS7Z2Pguk70xH5RlkZ9qssUDsbcty1MXPO7ntFVqig3WZO6OAjHG6Y30l/
         NpdDbXdw66NGTX8Hr55Nlnt3wXity8+3k4nA8e4uAEUlt5r+JK47BC0mCKY8tNFUlpAO
         sbIg==
X-Gm-Message-State: APzg51DVysV+5P4iJ01XxBdBphFeXLKtd0SmvGhUv/x1V1hCJY+Cb6WZ
        s4g+vhOPSeGS1cdgblk22Jj/JQvf
X-Google-Smtp-Source: ANB0VdaTbOlWcyHYd48rhGbn7mwK4aE2MgU+RrrdMmx6GPtePQRhabSc4usOeGJAS1N1vrUwm+vFeQ==
X-Received: by 2002:adf:db51:: with SMTP id f17-v6mr931526wrj.212.1535458262164;
        Tue, 28 Aug 2018 05:11:02 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:01 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 01/20] sequencer: make three functions and an enum from sequencer.c public
Date:   Tue, 28 Aug 2018 14:10:26 +0200
Message-Id: <20180828121045.14933-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missing_commit_check_level(),
write_message() and the enum check_level accessible outside sequencer.c,
renames check_level to missing_commit_check_level, and prefixes its
value names by MISSING_COMMIT_ to avoid namespace pollution.

This function and this enum will eventually be moved to
rebase-interactive.c and become static again, so no special attention
was given to the naming.

This will be needed for the rewrite of append_todo_help() from shell to
C, as it will be in a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v6.

 sequencer.c | 26 +++++++++++---------------
 sequencer.h | 11 +++++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 16c1411054..dd1b060863 100644
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
@@ -373,8 +373,8 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static int write_message(const void *buf, size_t len, const char *filename,
-			 int append_eol)
+int write_message(const void *buf, size_t len, const char *filename,
+		  int append_eol)
 {
 	struct lock_file msg_file = LOCK_INIT;
 
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
index c5787c6b56..792e448b67 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
+const char *rebase_path_todo(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
@@ -57,6 +58,15 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
+enum missing_commit_check_level {
+	MISSING_COMMIT_CHECK_IGNORE = 0,
+	MISSING_COMMIT_CHECK_WARN,
+	MISSING_COMMIT_CHECK_ERROR
+};
+
+int write_message(const void *buf, size_t len, const char *filename,
+		  int append_eol);
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
@@ -79,6 +89,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
+enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.18.0

