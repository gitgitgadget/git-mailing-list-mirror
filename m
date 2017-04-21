Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CC5207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041962AbdDUSd5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:33:57 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34372 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041648AbdDUSdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:33:49 -0400
Received: by mail-qt0-f195.google.com with SMTP id y33so12932021qta.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxHEsKUDLCu8racyY2x4EO2wUTMxGCFMRIOSSxQ1VWA=;
        b=fvQgla6QaoFpITDIBkl7hR7GTEbYyEoj+4fUoWifzEqxO48aECKfjninrr4evXW0pP
         4cc5M52b/zDN5gjIQdr1UtGqD9q9nnsCCSesl9Df8kFrz/UVsATlig/YAlg1/b/3l8MQ
         o//6aHPzzVD+3WbV0UQ5ryjK0JJcGPWOddanD3c5YIZKjlAYz0EXjABajbw0gAr0OctX
         ZvQHmsUGOsCM/bUQ7qCNyn3Vmv+xhhM3cjnNOladNJ3IddbHCHfJweSnKygTxkd/4ZO1
         VUCnkHJmwdHw6QPjY9PQsKe743TILCk6b35CsIom0irZLL0I1UNm69MS3SV/s/NJYSj6
         E1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxHEsKUDLCu8racyY2x4EO2wUTMxGCFMRIOSSxQ1VWA=;
        b=hw/KttHZCWrTecKp7n9aB4x+C3CISg8vFwjsbpa9h6p4CL36sol3BmQmVMfUNWkuzN
         paW8oRC010tCROJjsMM4ndErqjPZFYogkulQzvNg5/2YHy+8C7SzMUSMg91ts4GNnttB
         c5n9G+TeOWMiUTd2pSNzb8Err8B1LfSax6mTbzzht0iaNiCJonFpLFfraayElC8eu7pD
         rcpBv5PA9SJx9/gxg7Be8dk27Li7pUJR3gDgtqzAsaKLKhCQpN0ibv+kF2o2Fl0xua9U
         6+cgEMMh4YDf7gh0p6O83dmZZL+rTSq+5/r6Jbzrl4L/w3FomARNOoR770mMiwQDkvID
         9vEg==
X-Gm-Message-State: AN3rC/4e5O71x6DY+xNcWghQvKaeeQA95D6Uu0w6CQp1pODTq7MmLI6P
        264FCZKU3JZMJEteYYY=
X-Received: by 10.237.33.161 with SMTP id l30mr13766331qtc.85.1492795614225;
        Fri, 21 Apr 2017 10:26:54 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:53 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 6/8] convert: rename reusable sub-process functions
Date:   Fri, 21 Apr 2017 13:26:09 -0400
Message-Id: <20170421172611.12152-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a mechanical rename of the functions that will become the reusable
sub-process module.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/convert.c b/convert.c
index d15b10a3c5..cfae45aeee 100644
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
@@ -517,7 +517,7 @@ static int cmd2process_cmp(const struct subprocess_entry *e1,
 	return strcmp(e1->cmd, e2->cmd);
 }
 
-static struct subprocess_entry *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
+static struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const char *cmd)
 {
 	struct subprocess_entry key;
 
@@ -526,7 +526,7 @@ static struct subprocess_entry *find_multi_file_filter_entry(struct hashmap *has
 	return hashmap_get(hashmap, &key, NULL);
 }
 
-static void read_multi_file_filter_status(int fd, struct strbuf *status)
+static void subprocess_read_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
 	char *line;
@@ -546,7 +546,7 @@ static void read_multi_file_filter_status(int fd, struct strbuf *status)
 	}
 }
 
-static void kill_multi_file_filter(struct hashmap *hashmap, struct subprocess_entry *entry)
+static void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
 {
 	if (!entry)
 		return;
@@ -558,10 +558,10 @@ static void kill_multi_file_filter(struct hashmap *hashmap, struct subprocess_en
 	hashmap_remove(hashmap, entry, NULL);
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
@@ -630,7 +630,7 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 }
 
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
-int start_multi_file_filter(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
 	subprocess_start_fn startfn)
 {
 	int err;
@@ -646,11 +646,11 @@ int start_multi_file_filter(struct hashmap *hashmap, struct subprocess_entry *en
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
 
@@ -658,8 +658,8 @@ int start_multi_file_filter(struct hashmap *hashmap, struct subprocess_entry *en
 
 	err = startfn(entry);
 	if (err) {
-		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(hashmap, entry);
+		error("initialization for subprocess '%s' failed", cmd);
+		subprocess_stop(hashmap, entry);
 		return err;
 	}
 
@@ -678,12 +678,12 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
-	if (!cmd_process_map_initialized) {
-		cmd_process_map_initialized = 1;
-		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
 		entry = NULL;
 	} else {
-		entry = (struct cmd2process *)find_multi_file_filter_entry(&cmd_process_map, cmd);
+		entry = (struct cmd2process *)subprocess_find_entry(&subprocess_map, cmd);
 	}
 
 	fflush(NULL);
@@ -692,7 +692,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		entry = xmalloc(sizeof(*entry));
 		entry->supported_capabilities = 0;
 
-		if (start_multi_file_filter(&cmd_process_map, &entry->subprocess, cmd, start_multi_file_filter_fn)) {
+		if (subprocess_start(&subprocess_map, &entry->subprocess, cmd, start_multi_file_filter_fn)) {
 			free(entry);
 			return 0;
 		}
@@ -737,7 +737,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 	if (err)
 		goto done;
@@ -746,7 +746,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 
 done:
@@ -768,7 +768,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&cmd_process_map, &entry->subprocess);
+			subprocess_stop(&subprocess_map, &entry->subprocess);
 			free(entry);
 		}
 	} else {
-- 
2.12.0.windows.1.33.g243d9b384c

