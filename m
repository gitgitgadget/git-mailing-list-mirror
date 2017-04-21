Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77128207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422794AbdDUSc2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:32:28 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35026 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041922AbdDUScY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:32:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id o36so12939022qtb.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CaMTTV9DFztlfvBSgFf6U7lrQVXgdbtyACUXGHktX+w=;
        b=OTEJ53zOMkOz4mYJIG7Vt9tCO1sxq8qg4+RlzEhXG2k9lSmDj6ZdvStNsjPhFcql6T
         pDOieq8j9jrvd/YEfjGIpj7+iWSAqp8Fx53JorLowMJlqbnaqi0i6RoDeRVo5O9eaTYC
         rXr56QsxVWxXtLSPNwft5GYBkyscmnk6ZIXuZeWDj3i6+jF/8K/LiElZsl1W0DK/yEI6
         7T1mUILwXM5Zn6f7WLdxCZJYvdL0dAudzhvBzc3aZYQSUKtnfW3Zn8SNI/pvTTUWZkBO
         EdyiNGY0puGDJmad5Dg4hHAzzuP/ewOrLP3NJvNGxWlw+amXz0mVOcr8OJIehfE7s3OI
         LbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CaMTTV9DFztlfvBSgFf6U7lrQVXgdbtyACUXGHktX+w=;
        b=EksZOvaE/t3o8hWgWh7dY6772nH80L0P0kOsAkGP6KJ7S739AzHq59EZ1V6t7y0HvV
         zrRL4/6sAoECNOVUUnXpWlMP9bXl2skwkrpplB8Td6sLyiG/kc7X5sggEP44HOkPWTtu
         0SPqNspRe2c58mSHZtWWvkBrVwkqaCVeWvqJwixfjC0VVRTRXQ1UWNNYlHqYKxM4Wsxm
         YEhFLam2xffhzxPbMzZ9Wk0s58zAX1kUPkP8/i52M3cx8DqJCgzK0dEbT87q11lbTNDl
         ftGJCSwOEkMUIOdo1f7CCamJhzT5Ny778N7R+2wAjbl+nQ4cDOrLf4eHjVKAlYhN8c2g
         0uGg==
X-Gm-Message-State: AN3rC/41RvI40kBTR7+jb0zHi/QgirtsnuVXMjnkxth83GlEm96w5Y5l
        +dDfgcEwUVVceGIhlA4=
X-Received: by 10.200.43.17 with SMTP id 17mr13444531qtu.199.1492795615802;
        Fri, 21 Apr 2017 10:26:55 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:55 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 7/8] sub-process: move sub-process functions into separate files
Date:   Fri, 21 Apr 2017 13:26:10 -0400
Message-Id: <20170421172611.12152-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the sub-proces functions into sub-process.h/c.  Add documentation
for the new module in Documentation/technical/api-sub-process.txt

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/technical/api-sub-process.txt |  59 ++++++++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 104 +---------------------------
 sub-process.c                               | 102 +++++++++++++++++++++++++++
 sub-process.h                               |  49 +++++++++++++
 5 files changed, 212 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

diff --git a/Documentation/technical/api-sub-process.txt b/Documentation/technical/api-sub-process.txt
new file mode 100644
index 0000000000..793508cf3e
--- /dev/null
+++ b/Documentation/technical/api-sub-process.txt
@@ -0,0 +1,59 @@
+sub-process API
+===============
+
+The sub-process API makes it possible to run background sub-processes
+for the entire lifetime of a Git invocation. If Git needs to communicate
+with an external process multiple times, then this can reduces the process
+invocation overhead. Git and the sub-process communicate through stdin and
+stdout.
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
+	typically used to negotiate the interface version and capabilities.
+
+
+Functions
+---------
+
+`cmd2process_cmp`::
+
+	Function to test two subprocess hashmap entries for equality.
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
index eb1a1a7cff..97c87fb647 100644
--- a/Makefile
+++ b/Makefile
@@ -840,6 +840,7 @@ LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += submodule-config.o
+LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
diff --git a/convert.c b/convert.c
index cfae45aeee..79d04907a5 100644
--- a/convert.c
+++ b/convert.c
@@ -4,6 +4,7 @@
 #include "quote.h"
 #include "sigchain.h"
 #include "pkt-line.h"
+#include "sub-process.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -496,12 +497,6 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
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
@@ -510,65 +505,6 @@ struct cmd2process {
 static int subprocess_map_initialized;
 static struct hashmap subprocess_map;
 
-static int cmd2process_cmp(const struct subprocess_entry *e1,
-			   const struct subprocess_entry *e2,
-			   const void *unused)
-{
-	return strcmp(e1->cmd, e2->cmd);
-}
-
-static struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const char *cmd)
-{
-	struct subprocess_entry key;
-
-	hashmap_entry_init(&key, strhash(cmd));
-	key.cmd = cmd;
-	return hashmap_get(hashmap, &key, NULL);
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
-static void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
-{
-	if (!entry)
-		return;
-
-	entry->process.clean_on_exit = 0;
-	kill(entry->process.pid, SIGTERM);
-	finish_command(&entry->process);
-
-	hashmap_remove(hashmap, entry, NULL);
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
@@ -629,44 +565,6 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	return err;
 }
 
-typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
-int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
-	subprocess_start_fn startfn)
-{
-	int err;
-	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
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
-		subprocess_stop(hashmap, entry);
-		return err;
-	}
-
-	hashmap_add(hashmap, entry);
-	return 0;
-}
-
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
 				   int fd, struct strbuf *dst, const char *cmd,
 				   const unsigned int wanted_capability)
diff --git a/sub-process.c b/sub-process.c
new file mode 100644
index 0000000000..536b60cced
--- /dev/null
+++ b/sub-process.c
@@ -0,0 +1,102 @@
+/*
+ * Generic implementation of background process infrastructure.
+ */
+#include "sub-process.h"
+#include "sigchain.h"
+#include "pkt-line.h"
+
+int cmd2process_cmp(const struct subprocess_entry *e1,
+			   const struct subprocess_entry *e2,
+			   const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const char *cmd)
+{
+	struct subprocess_entry key;
+
+	hashmap_entry_init(&key, strhash(cmd));
+	key.cmd = cmd;
+	return hashmap_get(hashmap, &key, NULL);
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
+void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
+{
+	if (!entry)
+		return;
+
+	entry->process.clean_on_exit = 0;
+	kill(entry->process.pid, SIGTERM);
+	finish_command(&entry->process);
+
+	hashmap_remove(hashmap, entry, NULL);
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
+int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+	subprocess_start_fn startfn)
+{
+	int err;
+	struct child_process *process;
+	const char *argv[] = { cmd, NULL };
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
+		subprocess_stop(hashmap, entry);
+		return err;
+	}
+
+	hashmap_add(hashmap, entry);
+	return 0;
+}
diff --git a/sub-process.h b/sub-process.h
new file mode 100644
index 0000000000..a88e782bfc
--- /dev/null
+++ b/sub-process.h
@@ -0,0 +1,49 @@
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
+int cmd2process_cmp(const struct subprocess_entry *e1,
+	const struct subprocess_entry *e2, const void *unused);
+
+typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
+int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn);
+
+void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry);
+
+struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const char *cmd);
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
2.12.0.windows.1.33.g243d9b384c

