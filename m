Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7AB207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037371AbdDUS0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:26:50 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34075 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036979AbdDUS0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:26:46 -0400
Received: by mail-qk0-f194.google.com with SMTP id d80so8414738qke.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hWA72IsxOfKB9pZFpHe90EvQqKJFxlPqhllmuSmiQ88=;
        b=HT9O3MGv/T8n7xjT3k+Xn9qMU37CasuebNXpzJmgMeG7GqMl6/648W3ChYExOgfi+b
         evCqyR1bZgIwJkON0G5eGfDdE2YR2YWOjTXxSRe5/LwH5QtEOvsPJPkuX5PPr+jHHrsV
         XnAgUJa2HZt+NvGKPoEk18AxELpRHTjSIIMwpmGUzTE/h9ayRYcSFgBtgk/ZVoyl4z2y
         RJGw5bMeOnsDb7zkEvVUk1UWwm9lyUb3Z7LDGqF/CdSV03dfGaPXpTrXbGPQgv4ZOdMy
         fWcMWSd1z1zYKSwAW87lwvC2FoZacYxMo0KIVx2HpyuZYYoMkzPuMKIw2HIYuFdqRXqq
         7dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hWA72IsxOfKB9pZFpHe90EvQqKJFxlPqhllmuSmiQ88=;
        b=CT8WlFdqbdodeUbyuigV3gHHsbo4XEa1nepKEkQgAtzuubS6uqX5m2y/fgaC/oarfi
         NFaT1SXo9xImJnvYc5UdBZEY/gtENLZDPKI7d5NRSTAQy0F9IrLrvjWWc9jpRIm+h3O4
         RpsEAlPfrw6804BuQZS+JeTYscGSPF/3HNdVeJ8VLW0Eaakq8FfNqrMIbEULZGLNLU/4
         q7GIAgL5ZjdqgieX16M6FL/v1wf7NBQP6/cH0cE5xA84Eyjau3sWqgXNwAU7qBLZ3rvf
         eQNLF5zxlRIOQcfpv4H6qqQSGpJbvz5VsaxtVlXmh24+Ks/sYkW771BuT7lcbx5PFGre
         jbkQ==
X-Gm-Message-State: AN3rC/41lzLPizdajvdBIaGUvLP1/1qpuD+gBO4k4Th/ZwBSHltg1UPl
        3yyKBKMFOq4no/6GQFw=
X-Received: by 10.55.51.81 with SMTP id z78mr14747052qkz.100.1492795610333;
        Fri, 21 Apr 2017 10:26:50 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:49 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 4/8] convert: Separate generic structures and variables from the filter specific ones
Date:   Fri, 21 Apr 2017 13:26:07 -0400
Message-Id: <20170421172611.12152-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To enable future reuse of the filter.<driver>.process infrastructure,
split the cmd2process structure into two separate parts.

subprocess_entry will now contain the generic data required to manage
the creation and tracking of the child process in a hashmap. Also move
all knowledge of the hashmap into the generic functions.

cmd2process is a filter protocol specific structure that is used to
track the negotiated capabilities of the filter.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/convert.c b/convert.c
index 36401fe087..bfb19beed5 100644
--- a/convert.c
+++ b/convert.c
@@ -496,26 +496,31 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 #define CAP_CLEAN    (1u<<0)
 #define CAP_SMUDGE   (1u<<1)
 
-struct cmd2process {
+struct subprocess_entry {
 	struct hashmap_entry ent; /* must be the first member! */
-	unsigned int supported_capabilities;
 	const char *cmd;
 	struct child_process process;
 };
 
+struct cmd2process {
+	struct subprocess_entry subprocess; /* must be the first member! */
+	unsigned int supported_capabilities;
+};
+
 static int cmd_process_map_initialized;
 static struct hashmap cmd_process_map;
 
-static int cmd2process_cmp(const struct cmd2process *e1,
-			   const struct cmd2process *e2,
+static int cmd2process_cmp(const struct subprocess_entry *e1,
+			   const struct subprocess_entry *e2,
 			   const void *unused)
 {
 	return strcmp(e1->cmd, e2->cmd);
 }
 
-static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
+static struct subprocess_entry *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
 {
-	struct cmd2process key;
+	struct subprocess_entry key;
+
 	hashmap_entry_init(&key, strhash(cmd));
 	key.cmd = cmd;
 	return hashmap_get(hashmap, &key, NULL);
@@ -541,7 +546,7 @@ static void read_multi_file_filter_status(int fd, struct strbuf *status)
 	}
 }
 
-static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
+static void kill_multi_file_filter(struct hashmap *hashmap, struct subprocess_entry *entry)
 {
 	if (!entry)
 		return;
@@ -571,8 +576,8 @@ static int start_multi_file_filter_fn(struct cmd2process *entry)
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
-	struct child_process *process = &entry->process;
-	const char *cmd = entry->cmd;
+	struct child_process *process = &entry->subprocess.process;
+	const char *cmd = entry->subprocess.cmd;
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -632,9 +637,9 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	const char *argv[] = { cmd, NULL };
 
 	entry = xmalloc(sizeof(*entry));
-	entry->cmd = cmd;
+	entry->subprocess.cmd = cmd;
 	entry->supported_capabilities = 0;
-	process = &entry->process;
+	process = &entry->subprocess.process;
 
 	child_process_init(process);
 	process->argv = argv;
@@ -654,7 +659,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	err = start_multi_file_filter_fn(entry);
 	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(hashmap, entry);
+		kill_multi_file_filter(hashmap, &entry->subprocess);
 		return NULL;
 	}
 
@@ -678,7 +683,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
 		entry = NULL;
 	} else {
-		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
+		entry = (struct cmd2process *)find_multi_file_filter_entry(&cmd_process_map, cmd);
 	}
 
 	fflush(NULL);
@@ -688,7 +693,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		if (!entry)
 			return 0;
 	}
-	process = &entry->process;
+	process = &entry->subprocess.process;
 
 	if (!(wanted_capability & entry->supported_capabilities))
 		return 0;
@@ -759,7 +764,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&cmd_process_map, entry);
+			kill_multi_file_filter(&cmd_process_map, &entry->subprocess);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.0.windows.1.33.g243d9b384c

