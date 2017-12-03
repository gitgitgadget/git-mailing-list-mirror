Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4A420C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbdLCWSX (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:23 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:43207 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdLCWSF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:18:05 -0500
Received: by mail-it0-f67.google.com with SMTP id u62so8423684ita.2
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iLmweHMOI8yVB/LmnXQBPGw4w/1Hxpf6MGDyEVl5aQ8=;
        b=rtjrLGjlZRKegYe5U1vgVr8xzMPyDAL2BWXKmlliCWLNzKcX0p985vJWrCnqGgvmPH
         3m+fDZsMy+kDxDj3nyfuZRoWI1sPxlPbnSvl71FZ0oAxUubQaFuwYQS11vLYouFhwnsk
         TkI5REc06tphLIM/C4iJnJ0YckGgaGd5bvBWzWiab1dxzQHF0JGAdbhJkCgEXXzHjkKd
         Q3qgbC9JeiR8AtSRXDnx7Kd0LtU86SfudYFYFslm0fCYEyk+F0gDqN8N+/umgkIpywRh
         xRJ65DPyg4do5UANwmKTVr4iVQbkoZCvJhZivgYiYUPl3hQGoyu6GC+kk973T+YtGHDP
         qX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iLmweHMOI8yVB/LmnXQBPGw4w/1Hxpf6MGDyEVl5aQ8=;
        b=ZZg+ThxTD3zxSZrT3QCb26Uh5l97N3FlETdxSH/45elFGvbEwtmmvBUsWcFiIa1/1l
         HIBZ7MEyB6ll0PwCQAB5BuT2dTU33KmkBpitCtsa1IhjfENJ3sH8sqjKmwoxF9gNsthl
         IVMYB1dyUP5OnJq4SqdG+zdiJqVu4mXzPD5HwbFmubWYH/BNwOtswC9S2tZloAS0zEqM
         4UKr6H3bpnJ+LzzL/brEGcYEEY6YYOmAKdxtO2TFbzoo3XOcjhbk+ZLuYEDG1FoA5van
         /5DP2IwBHAkcHupcT8dsH5r2vcjwE0BQD8FLRcZz9VscHA2fWuG8aekoOLZIbQvUXQHi
         lafA==
X-Gm-Message-State: AKGB3mIelePzCd15eOqQEWZTrjKwsxIZ6VtYcTOcX6dw5Aj4X7yFkvIb
        Dyb2X6OnKhW+VQFioK2mLDVT6Zn4
X-Google-Smtp-Source: AGs4zMYa3S2KS3Gz8Gkv2ZegHtRB9X/yUjXhIwmyGwsas5jL7SkfPrRWjIcf7QKmX8WMutuh+41nRA==
X-Received: by 10.36.90.11 with SMTP id v11mr2107392ita.127.1512339484801;
        Sun, 03 Dec 2017 14:18:04 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:18:04 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 8/9] rebase -i: learn to abbreviate command names
Date:   Sun,  3 Dec 2017 17:17:20 -0500
Message-Id: <20171203221721.16462-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
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
index 03337e1484a2..2c51ddcfd3dd 100644
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
 	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTED_IDS : 0;
 
 	if (command == CONTINUE && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index bd047737082d..b752dcc52982 100644
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
@@ -2558,7 +2567,10 @@ int transform_todo_insn(unsigned flags)
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
index e4a9d2419883..468ee79fb72d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -47,6 +47,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
 #define TODO_LIST_SHORTED_IDS (1U << 1)
+#define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
-- 
2.15.1.280.g10402c1f5b5c

