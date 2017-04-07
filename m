Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EFD20966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933502AbdDGMEe (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:34 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33196 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933480AbdDGMEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:32 -0400
Received: by mail-yw0-f193.google.com with SMTP id p77so4758836ywg.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p1INTSju9Luo8Px7eBc4UB3bx8uuxvFt7MGiUxwLpTo=;
        b=oWhJWQd5mFs+L6fSAgdFYf4CsFwQpVpAYcYMiFCqeRAsZ05oFfoVYxacIGXPAyXMER
         c8Q+UaubniiHJLGFZ4f+jAEy0Zz1iP7Q+bM8oCK1w5p7zFL/UPoWdEpCz5bXuApnm4kf
         alQZzXNrpBqDuy+ArKkAmIbxpiS4Q8e0OALdMehRTmUhh1op+mvfSSRE7KKIty+jfXc4
         ZKBBYbiCZcTQlhBrohuk/IsOyij16ir65cvPIoapBn/KC378j+vGy73JUvh0zPU0eyWk
         2ifkzmkTj4d5iOxNlcAVevgO656sTq+0sUj5tCgf1qDsEszww/gYDncZpqI2y2eVHA0E
         pUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p1INTSju9Luo8Px7eBc4UB3bx8uuxvFt7MGiUxwLpTo=;
        b=IXNMqYY7tiF6hNgXNP8Pul4kgkGnny3pBZT0CK/TTzuhENmivXp8WAWQh8KAIgBUIk
         DLku+gz8Mk2JiFnTjfYdY2VzGTpeO+eaf+vm5L0Vdx3PVSfVBRODj46RQFT/31STEnX7
         JohZJsSWIf6z6qXO5diVJR729oyA/PgPsrmyIxF6O+hOB28VdHblnpTAuBnWdof/fWq/
         Qsc9XeJXXcUm1rlhfLXDBV1ahOFjG2gFMmfu4aWurJMHszohH4woowBfaBdT2E7x5h3v
         PjannYOF6jlczbbNGds4fVC9x9xLuA8ZxpSpG/miVbtHT1nWh/mQY+cBM80dbSpnQTeI
         GB4g==
X-Gm-Message-State: AFeK/H3jl8oBqzKB+ddSoU9CQsuWnBNMR5G2ojkSyQ/YoLenyH3Yi0BUcK+1VckSgcfGCg==
X-Received: by 10.13.223.149 with SMTP id i143mr24898109ywe.32.1491566670233;
        Fri, 07 Apr 2017 05:04:30 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:29 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 6/8] convert: rename reusable sub-process functions
Date:   Fri,  7 Apr 2017 08:03:52 -0400
Message-Id: <20170407120354.17736-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a mechanical rename of the functions that will become the reusable
sub-process module.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/convert.c b/convert.c
index 747c0c363b..235a6a5279 100644
--- a/convert.c
+++ b/convert.c
@@ -507,8 +507,8 @@ struct cmd2process {
 	unsigned int supported_capabilities;
 };
 
-static int cmd_process_map_initialized;
-static struct hashmap cmd_process_map;
+static int subprocess_map_initialized;
+static struct hashmap subprocess_map;
 
 static int cmd2process_cmp(const struct subprocess_entry *e1,
 			   const struct subprocess_entry *e2,
@@ -517,22 +517,22 @@ static int cmd2process_cmp(const struct subprocess_entry *e1,
 	return strcmp(e1->cmd, e2->cmd);
 }
 
-static struct subprocess_entry *find_multi_file_filter_entry(const char *cmd)
+static struct subprocess_entry *subprocess_find_entry(const char *cmd)
 {
 	struct subprocess_entry key;
 
-	if (!cmd_process_map_initialized) {
-		cmd_process_map_initialized = 1;
-		hashmap_init(&cmd_process_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
 		return NULL;
 	}
 
 	hashmap_entry_init(&key, strhash(cmd));
 	key.cmd = cmd;
-	return hashmap_get(&cmd_process_map, &key, NULL);
+	return hashmap_get(&subprocess_map, &key, NULL);
 }
 
-static void read_multi_file_filter_status(int fd, struct strbuf *status)
+static void subprocess_read_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
 	char *line;
@@ -552,7 +552,7 @@ static void read_multi_file_filter_status(int fd, struct strbuf *status)
 	}
 }
 
-static void kill_multi_file_filter(struct subprocess_entry *entry)
+static void subprocess_stop(struct subprocess_entry *entry)
 {
 	if (!entry)
 		return;
@@ -561,14 +561,14 @@ static void kill_multi_file_filter(struct subprocess_entry *entry)
 	kill(entry->process.pid, SIGTERM);
 	finish_command(&entry->process);
 
-	hashmap_remove(&cmd_process_map, entry, NULL);
+	hashmap_remove(&subprocess_map, entry, NULL);
 	free(entry);
 }
 
-static void stop_multi_file_filter(struct child_process *process)
+static void subprocess_exit_handler(struct child_process *process)
 {
 	sigchain_push(SIGPIPE, SIG_IGN);
-	/* Closing the pipe signals the filter to initiate a shutdown. */
+	/* Closing the pipe signals the subprocess to initiate a shutdown. */
 	close(process->in);
 	close(process->out);
 	sigchain_pop(SIGPIPE);
@@ -640,16 +640,16 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 }
 
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
-int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
+int subprocess_start(struct subprocess_entry *entry, const char *cmd,
 	subprocess_start_fn startfn)
 {
 	int err;
 	struct child_process *process;
 	const char *argv[] = { cmd, NULL };
 
-	if (!cmd_process_map_initialized) {
-		cmd_process_map_initialized = 1;
-		hashmap_init(&cmd_process_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
 	}
 
 	entry->cmd = cmd;
@@ -661,11 +661,11 @@ int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
 	process->in = -1;
 	process->out = -1;
 	process->clean_on_exit = 1;
-	process->clean_on_exit_handler = stop_multi_file_filter;
+	process->clean_on_exit_handler = subprocess_exit_handler;
 
 	err = start_command(process);
 	if (err) {
-		error("cannot fork to run external filter '%s'", cmd);
+		error("cannot fork to run subprocess '%s'", cmd);
 		return err;
 	}
 
@@ -673,12 +673,12 @@ int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
 
 	err = startfn(entry);
 	if (err) {
-		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(entry);
+		error("initialization for subprocess '%s' failed", cmd);
+		subprocess_stop(entry);
 		return err;
 	}
 
-	hashmap_add(&cmd_process_map, entry);
+	hashmap_add(&subprocess_map, entry);
 	return 0;
 }
 
@@ -693,7 +693,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
-	entry = (struct cmd2process *)find_multi_file_filter_entry(cmd);
+	entry = (struct cmd2process *)subprocess_find_entry(cmd);
 
 	fflush(NULL);
 
@@ -701,7 +701,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		entry = xmalloc(sizeof(*entry));
 		entry->supported_capabilities = 0;
 
-		if (start_multi_file_filter(&entry->subprocess, cmd, start_multi_file_filter_fn)) {
+		if (subprocess_start(&entry->subprocess, cmd, start_multi_file_filter_fn)) {
 			free(entry);
 			return 0;
 		}
@@ -746,7 +746,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 	if (err)
 		goto done;
@@ -755,7 +755,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 
 done:
@@ -777,7 +777,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter((struct subprocess_entry *)entry);
+			subprocess_stop((struct subprocess_entry *)entry);
+			free(entry);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.0.windows.1.31.g1548525701.dirty

