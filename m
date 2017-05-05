Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EF3207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbdEEP2u (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35097 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbdEEP2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:46 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so1229468qtb.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ygrwS9vX0ElA5bJ4DDovY5U1WkeGb72HQGVRaYEp+1Q=;
        b=vfYLPjeV9mhrSyymsg0S9JvcTqSLttCBLm3N6WBBGi6a3uZ6B1M6uANTvBQeT5BdSb
         bGl6l4L7Ob8Ya1lro1Zz36fEulo27gHFiRVEtB7eEEaH/OrBDtQyFF5djRuRbfGRGACr
         JhpXeOPAJHZA/ucwXvxymk4Ru8TP0L+WJUTzGHEnL9ouZwk6Bmz16ybQ+QwgpzBZnunK
         k3Iax/ikHkd7zBpwaUsxyXguHk242MrobvcQCDTY4pPtiSwvku2DIQMtjFaHh2unEA5u
         frVRURI/xZq83dB+TfWJK7GLYLyQ4gzZUvD80t6R+EvVPZfZ/XCYeGV6bf0BvHow1OKE
         /n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ygrwS9vX0ElA5bJ4DDovY5U1WkeGb72HQGVRaYEp+1Q=;
        b=rQrBYKO2QHikvAxDurYKnLFwEl0HOfdWjW88b9aEt7fYFAfcDZvVTNMxjigv3dtERP
         zqgVGbnokVpd4BhmN7w5p+pNH8pZH52a+2syaJIcbrLVB1XsF2vHic6+y9EK458XtXSz
         qmixf1VuKEfvUIcIMrXzaycVbTKIs0VQ++DIh5xP7U4RAEDijS8m3OTgQYDR2Q14vSfo
         hjC8fDmeFsLQpue2qlxPaxZYkbdiUbQTVNakaIMYqEYF7zcSKZ0RDd2s396/RXaSk7UX
         FcW33hW5F94g/opZ6TUs9KF9V1lZkiyO5OPiQd9Mzes5W692R88Iwnhyii5u+2Z36tso
         iZ4w==
X-Gm-Message-State: AN3rC/40BlwX+NPAQzZ9BnuyAOgBkpf61MFhsGFC5q8K6Xu7E9XcLYwL
        HcHbY+u9a98QNA==
X-Received: by 10.237.52.162 with SMTP id x31mr42497298qtd.263.1493998125127;
        Fri, 05 May 2017 08:28:45 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:44 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 07/10] convert: Update generic functions to only use generic data structures
Date:   Fri,  5 May 2017 11:27:59 -0400
Message-Id: <20170505152802.6724-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
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
index 5876218347..7d05dcb4aa 100644
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
2.12.2.gvfs.2.20.g3624a68d62.dirty

