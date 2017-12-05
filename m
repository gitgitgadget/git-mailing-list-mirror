Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7F920A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbdLERxK (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:53:10 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:43354 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdLERw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:58 -0500
Received: by mail-it0-f66.google.com with SMTP id u62so3596331ita.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhD3kpObny7ulQxj69+rKZdX+Au5iIWbNeU0ZNMJ7QM=;
        b=G5MWDf4xMviz5r2cWGm3xAcWCoT4JeercGd2UGj1YnHeniIQXKW3MYalwA3ziFtWOU
         5f+/uHtTWfIc3nf17VKaGWq3XS8m0Hpy/ET2OIcQbDeaHOl0Wksbgped43do9ZE2Mfdz
         c1xFRs1HAuT8j057rosqtv9x2+UM7/4b8e9CfCiOxl1MHAS0mzY1M9PM84E3BI4llQHm
         krCGEtcpRiflik+T8qjFfVFzQsh3+s3R5sfI4zyorw2nCr2YUl9ZBDntSQ+EWGhRW0dU
         AnH6VM9JdUi+VqTXBWlX3XtZNFovlOQ0KkVPh/5RgSL7SMzr18IgI0dJV5VXbAKkSF4A
         bztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhD3kpObny7ulQxj69+rKZdX+Au5iIWbNeU0ZNMJ7QM=;
        b=QrpbRArnQMQoWQ1WSs+45r1sb3GHidnD4mtPjXl98ftLsgcfRjfgamItJjfHeC0blc
         1kPpWWY7zuG3mTdg2O8k4PiGofIQ0WwkiSEV9sxPtcM/ZQlsEda84JyjAYc1MFNmgwr0
         hDmWBhirQH/fz/VYg3Zj7Huwg6byoCNJyqIYvErG/fPwrL6wbkJw/srYX6GEJZE3pTtb
         +3RqIhxwoAEwVwJILFs9bXz3RbMpnXVJTqfK4IuH986Rvu4SUvF0tbeNz785SUh58BzN
         ivf8nnQgjeRymTHeQ1dxb2kRRVPD7bfppbnRMb/kGdmrTUUWnoAkYvBSiCt+JDSeOm8o
         Eg/w==
X-Gm-Message-State: AJaThX69jxLbJMAUmxVTKYqG936BPiETIu123yJ1VOoYYhi9fyHe1oco
        yElnEAL+Ug3nKC6KnEyaffEn2xZs6Zc=
X-Google-Smtp-Source: AGs4zMa+8ZlJcz/lUwjKGzEKmxObcmyO6y7XP/S1Ynm7UxXAE0MBfrn3+o694DoJVlKmVlGEbSOwDQ==
X-Received: by 10.107.11.85 with SMTP id v82mr29232966ioi.198.1512496376883;
        Tue, 05 Dec 2017 09:52:56 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:56 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 8/9] rebase -i: learn to abbreviate command names
Date:   Tue,  5 Dec 2017 12:52:34 -0500
Message-Id: <20171205175235.32319-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git rebase -i` already know how to interpret single-letter command
names. Teach it to generate the todo list with these same abbreviated
names.

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/rebase-config.txt | 20 ++++++++++++++++++++
 builtin/rebase--helper.c        |  3 +++
 sequencer.c                     | 16 ++++++++++++++--
 sequencer.h                     |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index 30ae08cb5a4b..42e1ba757564 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -30,3 +30,23 @@ rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for the
 	todo list during an interactive rebase.  The format will
 	automatically have the long commit hash prepended to the format.
+
+rebase.abbreviateCommands::
+	If set to true, `git rebase` will use abbreviated command names in the
+	todo list resulting in something like this:
++
+-------------------------------------------
+	p deadbee The oneline of the commit
+	p fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
++
+instead of:
++
+-------------------------------------------
+	pick deadbee The oneline of the commit
+	pick fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
++
+Defaults to false.
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 4229ea0dc122..7daee544b7b4 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,6 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0;
+	int abbreviate_commands = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
@@ -43,6 +44,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
 	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
@@ -52,6 +54,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			builtin_rebase_helper_usage, PARSE_OPT_KEEP_ARGV0);
 
 	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
+	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	if (command == CONTINUE && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index 892d242f6966..115085d39ca8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -795,6 +795,13 @@ static const char *command_to_string(const enum todo_command command)
 	die("Unknown command: %d", command);
 }
 
+static const char command_to_char(const enum todo_command command)
+{
+	if (command < TODO_COMMENT && todo_command_info[command].c)
+		return todo_command_info[command].c;
+	return comment_line_char;
+}
+
 static int is_noop(const enum todo_command command)
 {
 	return TODO_NOOP <= command;
@@ -2453,6 +2460,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	struct rev_info revs;
 	struct commit *commit;
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
+	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 
 	init_revisions(&revs, NULL);
 	revs.verbose_header = 1;
@@ -2485,7 +2493,8 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 		strbuf_reset(&buf);
 		if (!keep_empty && is_original_commit_empty(commit))
 			strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
+		strbuf_addf(&buf, "%s %s ", insn,
+			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, &buf);
 		strbuf_addch(&buf, '\n');
 		fputs(buf.buf, out);
@@ -2558,7 +2567,10 @@ int transform_todos(unsigned flags)
 		}
 
 		/* add command to the buffer */
-		strbuf_addstr(&buf, command_to_string(item->command));
+		if (flags & TODO_LIST_ABBREVIATE_CMDS)
+			strbuf_addch(&buf, command_to_char(item->command));
+		else
+			strbuf_addstr(&buf, command_to_string(item->command));
 
 		/* add commit id */
 		if (item->commit) {
diff --git a/sequencer.h b/sequencer.h
index 212426c44548..81f6d7d393fd 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -47,6 +47,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
+#define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
-- 
2.15.1.280.g10402c1f5b5c

