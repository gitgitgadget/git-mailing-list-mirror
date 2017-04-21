Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E35E207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422889AbdDUSin (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:38:43 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33275 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042117AbdDUSiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:38:13 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so2221384qkh.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zi4/lsFwse93afbkQL6Lw7cCofGfM78s4on6TPXNT/8=;
        b=gOCdeWQ3G6q0F8yz1khiuw3dcU15whyqyQXapsrYb2pylfXYkn5M5tTPBPGnZdChjv
         4XyUNwMrwdGxBMdvgpb4DmecpY88xiriCPzvGeh4+pJHDSU54ySitnBdhxnBd9+fCpcc
         rDTXRxj5i1M7RSpQg1gSrVlr1i6F/VD55K5Z1KTvcjoI/l9ayO321DI5m5gGTiPGgb3y
         IyAS0qSGIOlp+s8a4WVKXSC8Os449zroKq0JS2+Rds7Q51rjkNiMW03mUlwm8ZN9WD/n
         LZbh2ub0JpghohUTVdtkc4l/x9ZSgZalJeK0At48wEbH1u1UY2Dagxs4TUQF7oeaS+iD
         rRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zi4/lsFwse93afbkQL6Lw7cCofGfM78s4on6TPXNT/8=;
        b=J0XeXAS/D4xGJ4lEeC/EJCQUEx9KfJuXrne8o3T4LXXrhBBDIfT5s0GcCeZiEAOw7y
         m12tz+pAfLJ4FkinChzzct0gpkumSpJ32wR4V39BxaMnVJ29ORU0ICxPxTdTXEhasgrx
         Ya+NKVrv8AuYT5UDzJxeO7/9k0QREIfirsCEtVXut/7ihFnYMEKf0Fll2YuEL2Osk7dv
         KEOLwlnH4Np/A75AIl8jlEyPCbhCkD0htkOCUiFiNDlwZPWyotyULEQA9RBeXKbL8+MR
         GAU94qpIFHsl7lwkpMKd8gyxgGaH6jyfMM5hLEAhvT9O46Majcg9rPHE3LrkXsC0riqd
         UCaQ==
X-Gm-Message-State: AN3rC/5O7k0N4Httn2VO3583UCS0jdCsvgRSIIwbsJbDEIW+0pCJfNKU
        5ngs3pqzYrFJxgTu9V8=
X-Received: by 10.55.4.6 with SMTP id 6mr13588454qke.222.1492795612306;
        Fri, 21 Apr 2017 10:26:52 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:51 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 5/8] convert: Update generic functions to only use generic data structures
Date:   Fri, 21 Apr 2017 13:26:08 -0400
Message-Id: <20170421172611.12152-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update all functions that are going to be moved into a reusable module
so that they only work with the reusable data structures.  Move code
that is specific to the filter out into the filter specific functions.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/convert.c b/convert.c
index bfb19beed5..d15b10a3c5 100644
--- a/convert.c
+++ b/convert.c
@@ -556,7 +556,6 @@ static void kill_multi_file_filter(struct hashmap *hashmap, struct subprocess_en
 	finish_command(&entry->process);
 
 	hashmap_remove(hashmap, entry, NULL);
-	free(entry);
 }
 
 static void stop_multi_file_filter(struct child_process *process)
@@ -570,14 +569,15 @@ static void stop_multi_file_filter(struct child_process *process)
 	finish_command(process);
 }
 
-static int start_multi_file_filter_fn(struct cmd2process *entry)
+static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
 	int err;
+	struct cmd2process *entry = (struct cmd2process *)subprocess;
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
-	struct child_process *process = &entry->subprocess.process;
-	const char *cmd = entry->subprocess.cmd;
+	struct child_process *process = &subprocess->process;
+	const char *cmd = subprocess->cmd;
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -629,17 +629,16 @@ static int start_multi_file_filter_fn(struct cmd2process *entry)
 	return err;
 }
 
-static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
+typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
+int start_multi_file_filter(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+	subprocess_start_fn startfn)
 {
 	int err;
-	struct cmd2process *entry;
 	struct child_process *process;
 	const char *argv[] = { cmd, NULL };
 
-	entry = xmalloc(sizeof(*entry));
-	entry->subprocess.cmd = cmd;
-	entry->supported_capabilities = 0;
-	process = &entry->subprocess.process;
+	entry->cmd = cmd;
+	process = &entry->process;
 
 	child_process_init(process);
 	process->argv = argv;
@@ -649,22 +648,23 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	process->clean_on_exit = 1;
 	process->clean_on_exit_handler = stop_multi_file_filter;
 
-	if (start_command(process)) {
+	err = start_command(process);
+	if (err) {
 		error("cannot fork to run external filter '%s'", cmd);
-		return NULL;
+		return err;
 	}
 
 	hashmap_entry_init(entry, strhash(cmd));
 
-	err = start_multi_file_filter_fn(entry);
+	err = startfn(entry);
 	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(hashmap, &entry->subprocess);
-		return NULL;
+		kill_multi_file_filter(hashmap, entry);
+		return err;
 	}
 
 	hashmap_add(hashmap, entry);
-	return entry;
+	return 0;
 }
 
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
@@ -689,9 +689,13 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	fflush(NULL);
 
 	if (!entry) {
-		entry = start_multi_file_filter(&cmd_process_map, cmd);
-		if (!entry)
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (start_multi_file_filter(&cmd_process_map, &entry->subprocess, cmd, start_multi_file_filter_fn)) {
+			free(entry);
 			return 0;
+		}
 	}
 	process = &entry->subprocess.process;
 
@@ -765,6 +769,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 */
 			error("external filter '%s' failed", cmd);
 			kill_multi_file_filter(&cmd_process_map, &entry->subprocess);
+			free(entry);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.0.windows.1.33.g243d9b384c

