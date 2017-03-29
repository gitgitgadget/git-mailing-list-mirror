Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C6620958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbdC2PyW (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:54:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32873 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbdC2PyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:54:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id r45so2545418qte.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rvwbA58FtUUga5FYjRZ+edb8w9pSHZYxYuHDJi3DtJo=;
        b=NDqV1GKKhN7dhOBwtnpz242RFC9kMRuadvimsKGuVtfDzBzDC5Q20ZL5EETkA8L7qg
         tiSuv8kKAyPJ/EwGgn8KE6LU8X+Xq7byW+/K666llu06dpHKLzIsg5Hzb5V8KTfZpgq+
         V3VDbrDGsBITFoDIwhJVSv2nvOjimyWJcmG41XQERpLEPOV3X5reYnghd57Tihb1ia71
         TtolWVdDP47OP2XSlTwCse22oqEts7MJuyLd0FrbtWzb4FaKmxSsqITz/LnBnRmDofGD
         QxCv9wRXB70pnNUrJkuVV//uDEzqTGzXppXyECUeH3w3msQwq13FHq8HnHh48yn3Duwl
         ag3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rvwbA58FtUUga5FYjRZ+edb8w9pSHZYxYuHDJi3DtJo=;
        b=ZU/7AVQXIg96h0NuyXf4RilZzMjYPlruSrPagCazs/Loh1V7TBnqNbnexkwiCTiqy6
         q5SfgzAHEXQm4jEeivbUL2cO+ZK9nmt9HcoSoGus9xtq+F0o9fezxh+IN3aByb5JT8YX
         r72IVGlsZqXUQ1FfM3ooECnzwRtjyOKl50hwAgA29mVvYUZiLOrDyV/KnfH61Sp1WAmX
         ziQllPGy9g1YDQ68GRFBWevAIf8AOelmyEn++gL9Kh4SitU6++dcO6rGSIX6cLOvCVGA
         okgsZmMALhRYCHV18T0SMZYesmhY/9BAFw8Jrz0z1mA9s7MKpdcvvVmir3CLf8KPqNG3
         PVTg==
X-Gm-Message-State: AFeK/H3lYP4Di4EZwcHw80SNNcdlwg2TM40WhYcdAHOgkdTrPqPV2hCyi9g9DEjODLtnWg==
X-Received: by 10.200.41.33 with SMTP id y30mr1279085qty.47.1490802857776;
        Wed, 29 Mar 2017 08:54:17 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o92sm5148566qkh.48.2017.03.29.08.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 08:54:17 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v3 6/8] convert: rename reusable sub-process functions
Date:   Wed, 29 Mar 2017 11:53:28 -0400
Message-Id: <20170329155330.12860-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170329155330.12860-1-benpeart@microsoft.com>
References: <20170329155330.12860-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a mechanical rename of the functions that will become the reusable
sub-process module.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/convert.c b/convert.c
index 77966e246b..8e9223f48a 100644
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
@@ -561,10 +561,10 @@ static void kill_multi_file_filter(struct subprocess_entry *entry)
 	kill(entry->process.pid, SIGTERM);
 	finish_command(&entry->process);
 
-	hashmap_remove(&cmd_process_map, entry, NULL);
+	hashmap_remove(&subprocess_map, entry, NULL);
 }
 
-static void stop_multi_file_filter(struct child_process *process)
+static void subprocess_exit_handler(struct child_process *process)
 {
 	sigchain_push(SIGPIPE, SIG_IGN);
 	/* Closing the pipe signals the filter to initiate a shutdown. */
@@ -639,16 +639,16 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
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
@@ -660,7 +660,7 @@ int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
 	process->in = -1;
 	process->out = -1;
 	process->clean_on_exit = 1;
-	process->clean_on_exit_handler = stop_multi_file_filter;
+	process->clean_on_exit_handler = subprocess_exit_handler;
 
 	err = start_command(process);
 	if (err) {
@@ -673,11 +673,11 @@ int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
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
 
@@ -692,7 +692,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
-	entry = (struct cmd2process *)find_multi_file_filter_entry(cmd);
+	entry = (struct cmd2process *)subprocess_find_entry(cmd);
 
 	fflush(NULL);
 
@@ -700,7 +700,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		entry = xmalloc(sizeof(*entry));
 		entry->supported_capabilities = 0;
 
-		if (start_multi_file_filter(&entry->subprocess, cmd, start_multi_file_filter_fn)) {
+		if (subprocess_start(&entry->subprocess, cmd, start_multi_file_filter_fn)) {
 			free(entry);
 			return 0;
 		}
@@ -745,7 +745,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 	if (err)
 		goto done;
@@ -754,7 +754,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 
 done:
@@ -776,7 +776,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter((struct subprocess_entry *)entry);
+			subprocess_stop((struct subprocess_entry *)entry);
 			free(entry);
 		}
 	} else {
-- 
2.12.1.gvfs.1.18.ge47db72

