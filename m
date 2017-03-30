Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098B820966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934308AbdC3Pyt (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:49 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36486 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934029AbdC3Pyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:46 -0400
Received: by mail-qk0-f195.google.com with SMTP id r142so6889751qke.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rJIZ6voRQJknZBlzNWm4vbMSaow507NsIozuqvdwXUI=;
        b=eNjcFu/emKD9x8yop63aFTnmkLellp1xHmncZ3Q76KYOoVVS4nJKVTyXBnAh1MEKDs
         32ZIULIK6lpeRoQzWtRLLTUOuPUNVfRTJvqVDkV/SG9Acp0Pxzv9ySrSXN5ZkzGJ8bHJ
         +89o1QfQA0pt4EuHTKlRuTMP3QvVjMY70WOtcz6tvegfJigW/nWW9ahqCztqGZUtuOiV
         CdLGhaXcvvOk8LCJgH9tZxj3dJMTvlSkv98aWJjQjhySVGTVeCUigysfWLGPnEEMu0s1
         TYB5g5SxCmN7fCQzAeax/hU4s3zgzW+GZkqNQOYz71lxgOhAE9at9o2phrppCfYHcF8v
         bPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rJIZ6voRQJknZBlzNWm4vbMSaow507NsIozuqvdwXUI=;
        b=IHnPEDHMlMp3pyODLlS2X0NHE5bZXA3OqQo6u9ZS/83Z9MZhXRJ/43D3cM1FdBLjai
         2X0NEd+oUGav7tLUAWH9W/YrbLOdDK8/uFG2uNEaMgXxFajLgaTe+F9zjAalFQMKbwGW
         QqkBMckTmxjYM6cxx2bB6Lluly9TR0o8sG3kGmCettKWwS/Kvn/LOON74kDOKIZ+C0iR
         Oc8AS5gfah5NBf8Gh8FDeaDoqB6w3YrDyOylbaFPxB8CeN7zdHFlaJiNfutCh6Q80Lz7
         uXKpPyZ/1Uh18ITM1aaSIt9QeJYf/umH+hzDzVo8aoQCHcAfSqATq9HoHS5xPeUfvPEx
         rhPg==
X-Gm-Message-State: AFeK/H31YX87owZTWjhVZzW10E4uLtjN0NMs/4/DOIih84lO62dmvr7+MG016Cai1t/MUg==
X-Received: by 10.55.149.66 with SMTP id x63mr372914qkd.277.1490889274848;
        Thu, 30 Mar 2017 08:54:34 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:34 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 6/8] convert: rename reusable sub-process functions
Date:   Thu, 30 Mar 2017 11:54:15 -0400
Message-Id: <20170330155417.8928-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a mechanical rename of the functions that will become the reusable
sub-process module.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/convert.c b/convert.c
index 747c0c363b..f68a7be622 100644
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
@@ -561,11 +561,11 @@ static void kill_multi_file_filter(struct subprocess_entry *entry)
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
 	/* Closing the pipe signals the filter to initiate a shutdown. */
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
@@ -661,7 +661,7 @@ int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
 	process->in = -1;
 	process->out = -1;
 	process->clean_on_exit = 1;
-	process->clean_on_exit_handler = stop_multi_file_filter;
+	process->clean_on_exit_handler = subprocess_exit_handler;
 
 	err = start_command(process);
 	if (err) {
@@ -674,11 +674,11 @@ int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
 	err = startfn(entry);
 	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(entry);
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
2.12.1.gvfs.1.18.ge47db72

