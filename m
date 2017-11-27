Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF15120A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdK0Ezn (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:55:43 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:42003 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdK0Ezk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:55:40 -0500
Received: by mail-io0-f193.google.com with SMTP id u42so34915652ioi.9
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 20:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=clo24kbaVI3pZ/VjYdsx61FIBkkkMfuKLRxrTTK8JSg=;
        b=umlv+SKdr1dFLLlv7kgg2buVmy+vjsgCYSuk4za11JUFOtIlyQxgCcDL0ziGhAqfOe
         jF3VFb0r86x6deZMvjdh/S+RC8D5BH+5yGBkEfzfXTR3N0woq7bte0obzG4/cK1G+n3Q
         PEROH8iWE3AY1n2PvuzJX432PHRGys/HJIl/TJKTQKfn/nzQTXcOIh+iRLOl+UrcLf7I
         xsfH56NyxwnU4gkvcqp+6Eun9gx1rBsIQm0x50favVvKAl8eCwgmTVSgXFZF/orRuUP4
         jiS1PUZ0KbRfGRqGcRxbIjZRaWG+RNB13zlNYhP//xNYmMHa2iydHWGnHLjLtXxjn/lX
         bE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=clo24kbaVI3pZ/VjYdsx61FIBkkkMfuKLRxrTTK8JSg=;
        b=go/3W/HbuYN+Vwkn9PFxw8DUdtbSteePJyKKuu9PfM8FzqJoC0co/Ijt3h6Mo7WxBN
         5Hlr7zyP32Nd9Kshwoufkb2ETABSean+Iw71xpx9ImC4gAAnT/yl9m2J8fuZmX4Xedpa
         bBXg0b3AImCCEEJdnpygo5iA6C9AJkod0xB0IPoy1H7WLVaclFXBCvd5P1NVakU4oW/C
         xf8er5bllCjVV9wJFneYK1Semh0wyuZE4kNx//IEvaoT6GDu8KDR6hfUr1LE1HxYtEwO
         VRVeNuunXNKUHNYv7cn46rog1Yhvum3rWCMXLWaAvMDtRVH47flJudN2qDbAy9mKzdzi
         T9EQ==
X-Gm-Message-State: AJaThX7BhcBeOgBBI/0WFCvzbq5rDgm1LgFawGMf0/Wvlt2e5A8aNXvK
        WsJz/YheMfcSscW3X1DliSgW9AUt
X-Google-Smtp-Source: AGs4zMZq5rGnbPzzH1Ge1qZxDFZn/yJVFeHixrs9uUbjefaQJ5o1d02IESbbC7WqwHGVzROpD3ACYA==
X-Received: by 10.107.164.225 with SMTP id d94mr39817246ioj.175.1511758539477;
        Sun, 26 Nov 2017 20:55:39 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm4606305ioe.13.2017.11.26.20.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 20:55:39 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, avarab@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 4/5] rebase -i: learn to abbreviate command names
Date:   Sun, 26 Nov 2017 23:55:13 -0500
Message-Id: <20171127045514.25647-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.0.321.g19bf2bb99cee.dirty
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
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
 Documentation/rebase-config.txt | 19 +++++++++++++++
 builtin/rebase--helper.c        | 10 +++++---
 sequencer.c                     | 54 +++++++++++++++++++++++++++++------------
 sequencer.h                     |  4 +--
 4 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index 30ae08cb5a4b..0820b60f6e12 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -30,3 +30,22 @@ rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for the
 	todo list during an interactive rebase.  The format will
 	automatically have the long commit hash prepended to the format.
+
+rebase.abbreviateCommands::
+	If set to true, `git rebase` will use abbreviated command names in the
+	todo list resulting in something like this:
+
+-------------------------------------------
+	p deadbee The oneline of the commit
+	p fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
+
+	instead of:
+
+-------------------------------------------
+	pick deadbee The oneline of the commit
+	pick fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
+	Defaults to false.
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 9d94c874c5bb..7b1fe825a877 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,7 +12,7 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	int keep_empty = 0;
+	int keep_empty = 0, abbreviate_commands = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
@@ -43,6 +43,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
 	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
@@ -56,11 +57,12 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
+		return !!sequencer_make_script(keep_empty, abbreviate_commands,
+					       stdout, argc, argv);
 	if (command == SHORTEN_SHA1S && argc == 1)
-		return !!transform_todo_ids(1);
+		return !!transform_todo_ids(1, abbreviate_commands);
 	if (command == EXPAND_SHA1S && argc == 1)
-		return !!transform_todo_ids(0);
+		return !!transform_todo_ids(0, abbreviate_commands);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index 810b7850748e..aa01e8bd9280 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -795,6 +795,13 @@ static const char *command_to_string(const enum todo_command command)
 	die("Unknown command: %d", command);
 }
 
+static const char command_to_char(const enum todo_command command)
+{
+	if (command < TODO_COMMENT && todo_command_info[command].c)
+		return todo_command_info[command].c;
+	return -1;
+}
+
 static int is_noop(const enum todo_command command)
 {
 	return TODO_NOOP <= command;
@@ -1242,15 +1249,16 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return 0;
 	}
 
-	for (i = 0; i < TODO_COMMENT; i++)
+	for (i = 0; i < TODO_COMMENT; i++) {
 		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
 			item->command = i;
 			break;
-		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
+		} else if (bol[1] == ' ' && *bol == command_to_char(i)) {
 			bol++;
 			item->command = i;
 			break;
 		}
+	}
 	if (i >= TODO_COMMENT)
 		return -1;
 
@@ -2443,8 +2451,8 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	strbuf_release(&sob);
 }
 
-int sequencer_make_script(int keep_empty, FILE *out,
-		int argc, const char **argv)
+int sequencer_make_script(int keep_empty, int abbreviate_commands, FILE *out,
+			  int argc, const char **argv)
 {
 	char *format = NULL;
 	struct pretty_print_context pp = {0};
@@ -2483,7 +2491,9 @@ int sequencer_make_script(int keep_empty, FILE *out,
 		strbuf_reset(&buf);
 		if (!keep_empty && is_original_commit_empty(commit))
 			strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
+		strbuf_addf(&buf, "%s %s ",
+			    abbreviate_commands ? "p" : "pick",
+			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, &buf);
 		strbuf_addch(&buf, '\n');
 		fputs(buf.buf, out);
@@ -2539,7 +2549,7 @@ int add_exec_commands(const char *command)
 	return 0;
 }
 
-int transform_todo_ids(int shorten_ids)
+int transform_todo_ids(int shorten_ids, int abbreviate_commands)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -2575,19 +2585,33 @@ int transform_todo_ids(int shorten_ids)
 			todo_list.items[i + 1].offset_in_buf :
 			todo_list.buf.len;
 
-		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
-			fwrite(p, eol - bol, 1, out);
-		else {
+		if (item->command >= TODO_EXEC && item->command != TODO_DROP) {
+			if (!abbreviate_commands || command_to_char(item->command) < 0) {
+				fwrite(p, eol - bol, 1, out);
+			} else {
+				const char *end_of_line = strchrnul(p, '\n');
+				p += strspn(p, " \t"); /* skip whitespace */
+				p += strcspn(p, " \t"); /* skip command */
+				fprintf(out, "%c%.*s\n",
+					command_to_char(item->command),
+					(int)(end_of_line - p), p);
+			}
+		} else {
 			const char *id = shorten_ids ?
 				short_commit_name(item->commit) :
 				oid_to_hex(&item->commit->object.oid);
-			int len;
 
-			p += strspn(p, " \t"); /* left-trim command */
-			len = strcspn(p, " \t"); /* length of command */
-
-			fprintf(out, "%.*s %s %.*s\n",
-				len, p, id, item->arg_len, item->arg);
+			if (abbreviate_commands) {
+				fprintf(out, "%c %s %.*s\n",
+					command_to_char(item->command),
+					id, item->arg_len, item->arg);
+			} else {
+				int len;
+				p += strspn(p, " \t"); /* left-trim command */
+				len = strcspn(p, " \t"); /* length of command */
+				fprintf(out, "%.*s %s %.*s\n",
+					len, p, id, item->arg_len, item->arg);
+			}
 		}
 	}
 	fclose(out);
diff --git a/sequencer.h b/sequencer.h
index a2715e6c7589..cee8394673de 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,11 +45,11 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-int sequencer_make_script(int keep_empty, FILE *out,
+int sequencer_make_script(int keep_empty, int abbreviate_commands, FILE *out,
 		int argc, const char **argv);
 
 int add_exec_commands(const char *command);
-int transform_todo_ids(int shorten_ids);
+int transform_todo_ids(int shorten_ids, int abbreviate_commands);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.15.0.321.g19bf2bb99cee.dirty

