Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDB520966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933518AbdDGMEh (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:37 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36446 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933492AbdDGMEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:32 -0400
Received: by mail-yb0-f193.google.com with SMTP id l201so2387530ybf.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BxQmq4QnFH8yv5rqJQIkhdlAaV7Zso/ZNBgwnsHJz4k=;
        b=C38CMJNGrO7t9si812MgIp+xGyV3upXMHZZZhVcx3hOfg1oOLCivJwS6PBqPGpoXPF
         XU2iH0F/bh3c1Ed8xdy7DtOANWye/4qq4at7SWIMOTNG8T9zYRfT9NKmzvPDVcSaxt8y
         TTEM9nelMNK3ywA+dkgKKrwX6MYy8v/VZwJRFkmyvY2LNFKfma5CKqCPs0gBON5CyYnr
         Xe7N2TwhAfKGEOiytABAS406qiwB0GspVchwmeAMcs5bp8+yxiwDAfFV63EWhFI4Pq9e
         QNx3e+IymQL0vWuMtHYpXifSYTcwLC25Rog6NugZe3jq9B5O8oSFWS4i0RcPUFX3gVbq
         +PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BxQmq4QnFH8yv5rqJQIkhdlAaV7Zso/ZNBgwnsHJz4k=;
        b=s14qjt5BvO2KWzQJjRvBF74tZ/VzjUw4fEX3itZvtHi+W50b0RebaW1HPgEuZBrBmX
         zS4u2Zd/eawU/BlZ9NTG3aboMexJ9KvZNp4sOrcqfRSOXfoKm1RZGc5DRLpI8wmJuvKt
         jVf+fdh0X0ZPM9i4XRaiczKM+uc+tjaBeScz47Mkr+i6nHu6uH6CmAzrrHy+ljqEdKZS
         L3khcm7b5uQOgiiqAY4pIjKWyXE0cjhTLH3rxxBspuuBeKwdcFP5LTEfVVo0OZDSC0YE
         CopyZQ4Irftv1EBiONzLjveHmDkIw8WgVgZ7KMrJk2CZUSALwEtMeU4xy4h1dk68TMp2
         6OQQ==
X-Gm-Message-State: AFeK/H1nUG6h0Hsd7dMt4aJs32ZwhdzNxYO7E41uPdvIFhMUINliVFHEy1ptYkHoy7kayA==
X-Received: by 10.37.199.135 with SMTP id w129mr12467737ybe.14.1491566671254;
        Fri, 07 Apr 2017 05:04:31 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:30 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 7/8] sub-process: move sub-process functions into separate files
Date:   Fri,  7 Apr 2017 08:03:53 -0400
Message-Id: <20170407120354.17736-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the sub-proces functions into sub-process.h/c.  Add documentation
for the new module in Documentation/technical/api-sub-process.txt

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/technical/api-sub-process.txt |  54 +++++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 119 +---------------------------
 sub-process.c                               | 116 +++++++++++++++++++++++++++
 sub-process.h                               |  46 +++++++++++
 5 files changed, 218 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

diff --git a/Documentation/technical/api-sub-process.txt b/Documentation/technical/api-sub-process.txt
new file mode 100644
index 0000000000..eb5005aa72
--- /dev/null
+++ b/Documentation/technical/api-sub-process.txt
@@ -0,0 +1,54 @@
+sub-process API
+===============
+
+The sub-process API makes it possible to run background sub-processes
+that should run until the git command exits and communicate with it
+through stdin and stdout.  This reduces the overhead of having to fork
+a new process each time it needs to be communicated with.
+
+The sub-processes are kept in a hashmap by command name and looked up
+via the subprocess_find_entry function.  If an existing instance can not
+be found then a new process should be created and started.  When the
+parent git command terminates, all sub-processes are also terminated.
+
+This API is based on the run-command API.
+
+Data structures
+---------------
+
+* `struct subprocess_entry`
+
+The sub-process structure.  Members should not be accessed directly.
+
+Types
+-----
+
+'int(*subprocess_start_fn)(struct subprocess_entry *entry)'::
+
+	User-supplied function to initialize the sub-process.  This is
+	typically used to negoiate the interface version and capabilities.
+
+
+Functions
+---------
+
+`subprocess_start`::
+
+	Start a subprocess and add it to the subprocess hashmap.
+
+`subprocess_stop`::
+
+	Kill a subprocess and remove it from the subprocess hashmap.
+
+`subprocess_find_entry`::
+
+	Find a subprocess in the subprocess hashmap.
+
+`subprocess_get_child_process`::
+
+	Get the underlying `struct child_process` from a subprocess.
+
+`subprocess_read_status`::
+
+	Helper function to read packets looking for the last "status=<foo>"
+	key/value pair.
diff --git a/Makefile b/Makefile
index 9f8b35ad41..add945b560 100644
--- a/Makefile
+++ b/Makefile
@@ -838,6 +838,7 @@ LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += submodule-config.o
+LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
diff --git a/convert.c b/convert.c
index 235a6a5279..baa41da760 100644
--- a/convert.c
+++ b/convert.c
@@ -4,6 +4,7 @@
 #include "quote.h"
 #include "sigchain.h"
 #include "pkt-line.h"
+#include "sub-process.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -496,86 +497,11 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 #define CAP_CLEAN    (1u<<0)
 #define CAP_SMUDGE   (1u<<1)
 
-struct subprocess_entry {
-	struct hashmap_entry ent; /* must be the first member! */
-	const char *cmd;
-	struct child_process process;
-};
-
 struct cmd2process {
 	struct subprocess_entry subprocess; /* must be the first member! */
 	unsigned int supported_capabilities;
 };
 
-static int subprocess_map_initialized;
-static struct hashmap subprocess_map;
-
-static int cmd2process_cmp(const struct subprocess_entry *e1,
-			   const struct subprocess_entry *e2,
-			   const void *unused)
-{
-	return strcmp(e1->cmd, e2->cmd);
-}
-
-static struct subprocess_entry *subprocess_find_entry(const char *cmd)
-{
-	struct subprocess_entry key;
-
-	if (!subprocess_map_initialized) {
-		subprocess_map_initialized = 1;
-		hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
-		return NULL;
-	}
-
-	hashmap_entry_init(&key, strhash(cmd));
-	key.cmd = cmd;
-	return hashmap_get(&subprocess_map, &key, NULL);
-}
-
-static void subprocess_read_status(int fd, struct strbuf *status)
-{
-	struct strbuf **pair;
-	char *line;
-	for (;;) {
-		line = packet_read_line(fd, NULL);
-		if (!line)
-			break;
-		pair = strbuf_split_str(line, '=', 2);
-		if (pair[0] && pair[0]->len && pair[1]) {
-			/* the last "status=<foo>" line wins */
-			if (!strcmp(pair[0]->buf, "status=")) {
-				strbuf_reset(status);
-				strbuf_addbuf(status, pair[1]);
-			}
-		}
-		strbuf_list_free(pair);
-	}
-}
-
-static void subprocess_stop(struct subprocess_entry *entry)
-{
-	if (!entry)
-		return;
-
-	entry->process.clean_on_exit = 0;
-	kill(entry->process.pid, SIGTERM);
-	finish_command(&entry->process);
-
-	hashmap_remove(&subprocess_map, entry, NULL);
-	free(entry);
-}
-
-static void subprocess_exit_handler(struct child_process *process)
-{
-	sigchain_push(SIGPIPE, SIG_IGN);
-	/* Closing the pipe signals the subprocess to initiate a shutdown. */
-	close(process->in);
-	close(process->out);
-	sigchain_pop(SIGPIPE);
-	/* Finish command will wait until the shutdown is complete. */
-	finish_command(process);
-}
-
 static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
 	int err;
@@ -639,49 +565,6 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	return err;
 }
 
-typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
-int subprocess_start(struct subprocess_entry *entry, const char *cmd,
-	subprocess_start_fn startfn)
-{
-	int err;
-	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
-
-	if (!subprocess_map_initialized) {
-		subprocess_map_initialized = 1;
-		hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
-	}
-
-	entry->cmd = cmd;
-	process = &entry->process;
-
-	child_process_init(process);
-	process->argv = argv;
-	process->use_shell = 1;
-	process->in = -1;
-	process->out = -1;
-	process->clean_on_exit = 1;
-	process->clean_on_exit_handler = subprocess_exit_handler;
-
-	err = start_command(process);
-	if (err) {
-		error("cannot fork to run subprocess '%s'", cmd);
-		return err;
-	}
-
-	hashmap_entry_init(entry, strhash(cmd));
-
-	err = startfn(entry);
-	if (err) {
-		error("initialization for subprocess '%s' failed", cmd);
-		subprocess_stop(entry);
-		return err;
-	}
-
-	hashmap_add(&subprocess_map, entry);
-	return 0;
-}
-
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
 				   int fd, struct strbuf *dst, const char *cmd,
 				   const unsigned int wanted_capability)
diff --git a/sub-process.c b/sub-process.c
new file mode 100644
index 0000000000..60bb650012
--- /dev/null
+++ b/sub-process.c
@@ -0,0 +1,116 @@
+/*
+ * Generic implementation of background process infrastructure.
+ */
+#include "sub-process.h"
+#include "sigchain.h"
+#include "pkt-line.h"
+
+static int subprocess_map_initialized;
+static struct hashmap subprocess_map;
+
+static int cmd2process_cmp(const struct subprocess_entry *e1,
+			   const struct subprocess_entry *e2,
+			   const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+struct subprocess_entry *subprocess_find_entry(const char *cmd)
+{
+	struct subprocess_entry key;
+
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
+		return NULL;
+	}
+
+	hashmap_entry_init(&key, strhash(cmd));
+	key.cmd = cmd;
+	return hashmap_get(&subprocess_map, &key, NULL);
+}
+
+void subprocess_read_status(int fd, struct strbuf *status)
+{
+	struct strbuf **pair;
+	char *line;
+	for (;;) {
+		line = packet_read_line(fd, NULL);
+		if (!line)
+			break;
+		pair = strbuf_split_str(line, '=', 2);
+		if (pair[0] && pair[0]->len && pair[1]) {
+			/* the last "status=<foo>" line wins */
+			if (!strcmp(pair[0]->buf, "status=")) {
+				strbuf_reset(status);
+				strbuf_addbuf(status, pair[1]);
+			}
+		}
+		strbuf_list_free(pair);
+	}
+}
+
+void subprocess_stop(struct subprocess_entry *entry)
+{
+	if (!entry)
+		return;
+
+	entry->process.clean_on_exit = 0;
+	kill(entry->process.pid, SIGTERM);
+	finish_command(&entry->process);
+
+	hashmap_remove(&subprocess_map, entry, NULL);
+}
+
+static void subprocess_exit_handler(struct child_process *process)
+{
+	sigchain_push(SIGPIPE, SIG_IGN);
+	/* Closing the pipe signals the subprocess to initiate a shutdown. */
+	close(process->in);
+	close(process->out);
+	sigchain_pop(SIGPIPE);
+	/* Finish command will wait until the shutdown is complete. */
+	finish_command(process);
+}
+
+int subprocess_start(struct subprocess_entry *entry, const char *cmd,
+	subprocess_start_fn startfn)
+{
+	int err;
+	struct child_process *process;
+	const char *argv[] = { cmd, NULL };
+
+	if (!subprocess_map_initialized) {
+		subprocess_map_initialized = 1;
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
+	}
+
+	entry->cmd = cmd;
+	process = &entry->process;
+
+	child_process_init(process);
+	process->argv = argv;
+	process->use_shell = 1;
+	process->in = -1;
+	process->out = -1;
+	process->clean_on_exit = 1;
+	process->clean_on_exit_handler = subprocess_exit_handler;
+
+	err = start_command(process);
+	if (err) {
+		error("cannot fork to run subprocess '%s'", cmd);
+		return err;
+	}
+
+	hashmap_entry_init(entry, strhash(cmd));
+
+	err = startfn(entry);
+	if (err) {
+		error("initialization for subprocess '%s' failed", cmd);
+		subprocess_stop(entry);
+		return err;
+	}
+
+	hashmap_add(&subprocess_map, entry);
+	return 0;
+}
diff --git a/sub-process.h b/sub-process.h
new file mode 100644
index 0000000000..0cf1760a0a
--- /dev/null
+++ b/sub-process.h
@@ -0,0 +1,46 @@
+#ifndef SUBPROCESS_H
+#define SUBPROCESS_H
+
+#include "git-compat-util.h"
+#include "hashmap.h"
+#include "run-command.h"
+
+/*
+ * Generic implementation of background process infrastructure.
+ * See Documentation/technical/api-background-process.txt.
+ */
+
+ /* data structures */
+
+struct subprocess_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *cmd;
+	struct child_process process;
+};
+
+/* subprocess functions */
+
+typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
+int subprocess_start(struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn);
+
+void subprocess_stop(struct subprocess_entry *entry);
+
+struct subprocess_entry *subprocess_find_entry(const char *cmd);
+
+/* subprocess helper functions */
+
+static inline struct child_process *subprocess_get_child_process(
+		struct subprocess_entry *entry)
+{
+	return &entry->process;
+}
+
+/*
+ * Helper function that will read packets looking for "status=<foo>"
+ * key/value pairs and return the value from the last "status" packet
+ */
+
+void subprocess_read_status(int fd, struct strbuf *status);
+
+#endif
-- 
2.12.0.windows.1.31.g1548525701.dirty

