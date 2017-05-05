Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5DA8207FF
	for <e@80x24.org>; Fri,  5 May 2017 15:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbdEEP2u (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36566 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbdEEP2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:47 -0400
Received: by mail-qt0-f194.google.com with SMTP id j13so1229921qta.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z+l8G/ErT0eMc51NF61pCDUeuHEgAM5sr/8F3MDpp90=;
        b=V8uQm4C9HKjZCk5+aAVPCAA6RlzaCyhUIrkb2Jdm+1kI+L71rRAScjlh2ETABIA/uV
         MRRFbrqOKYmZUeUK+qE9/y6eUS3aNUH1559QmFedfFPZa/FaotW5oLKpopEE8XkG09Du
         FeLzVguRHZhho1f1TPFuOxreDHhSVBXwgHkZsJ16/gJNzPjFSc6YS0B7H+064e44TEO9
         c9pZ8cllftmmQrB3FWADzY+6gQ5cwpoirSicWV8asouo2dcD10FWnIyyXQ43NImtftbx
         Q77I8Hjg5ygF3DSguUA0JJbxsUZa46o928Tv+TBJ7aYlLE76dINIgfSiml7aK+itJr4L
         2ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z+l8G/ErT0eMc51NF61pCDUeuHEgAM5sr/8F3MDpp90=;
        b=Ew6Na2eJVwycj0Fq/gG4oRPpWgi08MVm+2j9sWq36Uf1LEkK+fCfPOlyVLOxV8+PE2
         DbHM8o8VXsPhHUEjPRQn3iYpqOWpiJ4UNqO6WEGHlHNYv1NvNtjkrFaAK/PccLxZsSLQ
         U/kWgGRntfLA0hSZqoL2bE2KSi5TO4cV7zLmVTc6Gj1c3mDcrxmf9KEt3QyVLGs6VrF0
         k9IiLLZpndQ7x6xfJJupoQ9n00XvNm0kP3JmAyzmqhe63FSk1as3AcPIp8nnbLJGBq6X
         KuDVXZr05byqOefhzbR8r1eaoew7TPZLdpu8YoCuOrPaeMbEcSb02WkfPUS55qU/xUg/
         OFYQ==
X-Gm-Message-State: AODbwcAVkThSKR6L/T1A0rc5+MHxnhiN8GKHD2t0AoNNHAQUV/xQYEaC
        DRRbwjU2dmUP2Q==
X-Received: by 10.200.50.67 with SMTP id y3mr3915126qta.27.1493998126927;
        Fri, 05 May 2017 08:28:46 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:45 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 08/10] convert: rename reusable sub-process functions
Date:   Fri,  5 May 2017 11:28:00 -0400
Message-Id: <20170505152802.6724-9-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
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
index 7d05dcb4aa..84c4ff8a01 100644
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
2.12.2.gvfs.2.20.g3624a68d62.dirty

