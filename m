Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6651F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeGJMRQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55876 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeGJMRO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id v128-v6so6850737wme.5
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yv1xUreVBKnVDxrlMLm06GMgtyk1GFRj8+9CsgNtEJk=;
        b=T5fkira+XQXv/+Bdqm/AbqEsC4pnYpvEzSxvIkkdduzTKfWRNoWCNFiKWIqrxWvxfi
         /DaznVNivC37IXG8mOEXpX+vYGgRIYtScv+mQvVtJs9y1vi3Pzs8tFqXfEXkjfw6IOoO
         s17BayNIPpOFH2UwLz3DIKhgf+5OpFg7OjJGwEBHLYTzABXX7UT+ZzWUoJuEx6MnDOKb
         Udl26dq2JVHqnOVTM8IIEseXZjAuJPQRzx20dZ4UqL6dFaU/3pI/+2HHihyRg1ySqjSM
         B9BE6CytnPoNP721Ju7iUZ2O2vfisMumLpy73ECHuQsnmYLmoaP9YSHA/fpqqN8rGByH
         1vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yv1xUreVBKnVDxrlMLm06GMgtyk1GFRj8+9CsgNtEJk=;
        b=AkaWU0pcb93uEqBIcu0m0bvtiTiz6YjrgSihJyRCAD5ZE852LKzZwyyUQNijXCUKKf
         IXdG6SvszwSLgXHAJdyXjgk4apbYyjCm/r+XcDzx8i1UjQ4DWsysqGl7tzDFWjEAcy6G
         tGYbBXpkkzpZVKObdHRtro//uhOhHCMxBSRhAg9rBiy1i7jIb1hwg8/r2IvRgWX+YCJO
         pS3kFBsyuH1MPler0Wchfqvnt1xNoWGhwn5fl9bzKfssJYJPr9jqHOYFmpFjooWBb2tI
         TRT04lVaEsn7sK5B02oRNT/MUW+yO91dlhr48aQeQuPClZlxwp91IaTghVLm/kzywTdn
         ycNw==
X-Gm-Message-State: APt69E28XBi+Eaf7yXyVsTxB7godzaXu7mU4YcH3WvoJwmtKwgevs3CA
        8/PuNJEc+5lfrnBG7ODLSxHtkodb
X-Google-Smtp-Source: AAOMgpcEHurfG516VnGDTQXfNQ2nHTYrND+GT3NsAZIXQg5pRCWgq1if0yds49iL4VkuAr0LFt7TiA==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr15321663wmd.44.1531225033049;
        Tue, 10 Jul 2018 05:17:13 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:12 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 01/13] sequencer: make two functions and an enum from sequencer.c public
Date:   Tue, 10 Jul 2018 14:15:45 +0200
Message-Id: <20180710121557.6698-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missing_commit_check_level() and the
enum check_level accessible outside sequencer.c.  check_level is renamed
missing_commit_check_level, and its value names are prefixed by
MISSING_COMMIT_ to avoid namespace pollution.

This function and this enum will eventually be moved to
rebase-interactive.c and become static again, so no special attention
was given to the naming.

This will be needed for the rewrite of append_todo_help() from shell to
C, as it will be in a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Unchanged from v2.

 sequencer.c | 22 +++++++++-------------
 sequencer.h |  8 ++++++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5354d4d51..57fd58bc1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -51,7 +51,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * the lines are processed, they are removed from the front of this
  * file and written to the tail of 'done'.
  */
-static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4221,24 +4221,20 @@ int transform_todos(unsigned flags)
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
@@ -4250,7 +4246,7 @@ define_commit_slab(commit_seen, unsigned char);
  */
 int check_todo_list(void)
 {
-	enum check_level check_level = get_missing_commit_check_level();
+	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct strbuf missing = STRBUF_INIT;
@@ -4267,7 +4263,7 @@ int check_todo_list(void)
 	advise_to_edit_todo = res =
 		parse_insn_buffer(todo_list.buf.buf, &todo_list);
 
-	if (res || check_level == CHECK_IGNORE)
+	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
 
 	/* Mark the commits in git-rebase-todo as seen */
@@ -4302,7 +4298,7 @@ int check_todo_list(void)
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

