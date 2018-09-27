Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68051F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeI1EU4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:20:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34710 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeI1EU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:20:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id z4-v6so2855385wrb.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ngUDtohThwk0HJVrv/FyDBSPP/VInNQ/cfxq9bqg/Js=;
        b=JOfRxt58jjtwrxeqQv8n5FQNuHg7nuhrtoeg+N1EqopCpjmQ6hlc8bOnPu/sQ7WwA2
         OUg+iUN2bmzi+Dq5WIk0QjwM/hn5WIoGCt6sEmHfpYvi773wrT1PjgCITos14RM0lE1m
         IkiygtuovAyLfrbWqx68LHhrai6AL916kGHX0Wsh0SHNAXL/PUcM5XhOAmSiXSt/EGuV
         rUQHYSmyt4jq+T5ywxy3fLMrkk8RsUyb2v8yo2bJTB2ckY35FPSzT1bDh5oTpv/v/HGB
         zfUZdfA2GoC8Goq+iJhdvuubou8AAtogZGgXqTwfkywb4HIZz670bJ45v96R8jRCgzHm
         EHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngUDtohThwk0HJVrv/FyDBSPP/VInNQ/cfxq9bqg/Js=;
        b=VMn1Zob86oaEbBBtYlQelRLxduILgANszvgQoSrn1lNDQUEL9zRGj3W0jfrsNNOB87
         UzJ9Vv4y5H7ggARHVFj1BD/VhJHxbjkE0Vq6n4YofNfp9lDojcLuqhbBQ3FBoWdIoi1X
         XybfyrMpf5ChzmN3pDMYhTkkDdJyyYQBlY1Ge49kjWPPQr87mMGNxmjvmxUMAu8lnsR3
         MeVB/uhK64YQlT+yMv2pqagAXyZVZOetKirGbjVsVyfy7cimxM1eKMe/ZG/WY0ADujzl
         VSVvQ/q849P0D+sMZYMAelR+iu4MPqPmo67hoXxWL52yAPIowNrjcqvEQ5btcTSGhRfL
         VC/Q==
X-Gm-Message-State: ABuFfoh8/cEzAgIfGbJAKNT3go4kW1Wii9122ZVU0x66aHZ76Hsy3ZSB
        Jx7iXhb/vIgikIms+WjrbagThArw
X-Google-Smtp-Source: ACcGV63A4/J5BA6pnVLeMO0zSS06hayufhlF2owNDTLvVFgBpup33P1ivQrTNKjsrfX7XILN+SfFGg==
X-Received: by 2002:adf:ac13:: with SMTP id v19-v6mr10191605wrc.135.1538085628887;
        Thu, 27 Sep 2018 15:00:28 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:28 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 01/20] sequencer: make three functions and an enum from sequencer.c public
Date:   Thu, 27 Sep 2018 23:55:51 +0200
Message-Id: <20180927215610.32210-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
No changes since v7.

 sequencer.c | 26 +++++++++++---------------
 sequencer.h | 11 +++++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ddb41a62d9..c24d37dfb1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -53,7 +53,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * the lines are processed, they are removed from the front of this
  * file and written to the tail of 'done'.
  */
-static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -377,8 +377,8 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static int write_message(const void *buf, size_t len, const char *filename,
-			 int append_eol)
+int write_message(const void *buf, size_t len, const char *filename,
+		  int append_eol)
 {
 	struct lock_file msg_file = LOCK_INIT;
 
@@ -4422,24 +4422,20 @@ int transform_todos(unsigned flags)
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
@@ -4451,7 +4447,7 @@ define_commit_slab(commit_seen, unsigned char);
  */
 int check_todo_list(void)
 {
-	enum check_level check_level = get_missing_commit_check_level();
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
@@ -4468,7 +4464,7 @@ int check_todo_list(void)
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
-	if (res || check_level == CHECK_IGNORE)
+	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
 	/* Mark the commits in git-rebase-todo as seen */
@@ -4503,7 +4499,7 @@ int check_todo_list(void)
 	if (!missing.len)
 		goto leave_check;
 
-	if (check_level == CHECK_ERROR)
+	if (check_level == MISSING_COMMIT_CHECK_ERROR)
 		advise_to_edit_todo = res = 1;
 
 	fprintf(stderr,
diff --git a/sequencer.h b/sequencer.h
index c986bc8251..579de9127b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -8,6 +8,7 @@ struct commit;
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
+const char *rebase_path_todo(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
@@ -62,6 +63,15 @@ struct replay_opts {
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
@@ -84,6 +94,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
+enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.19.0

