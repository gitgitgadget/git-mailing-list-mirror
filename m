Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC5C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649C76103B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbhJGU2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242051AbhJGU1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DBEC06176F
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so22757952wra.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5exphT6h+URglsf993xFNfVsiL87l/ydaIf8LdF1rco=;
        b=ZJ3OXGiNdBxGpiPr9jod6YF3mWArczRS1rEUvymJwTjoNQ5tFXinUpOPLwS19HZ+UT
         SaEFiAaJFyXb9rtrFGINuCCsKxtcUFpJUd4f1kpGPloXKY4lEhZgE13/NCqwML8Ks1SN
         XvBHqc5i7oyIRjyuwhEkeHSH2LsBvXFKMwlwUmnsg0h+X/V9SZujXcQoKJnwMbo2Hlat
         HWAZynQIGTNIkZ7ic/QAQV5ZIXk782EBPwvoXfb4KJyyHku25v77gho7OnrSzZf8OUVr
         ct2ZaaB8AZYOxP4WIJBS1u0fFQPAFne5dBUbUZjYn6nmYJQK6QhZJSZxrNTewYbQFsTK
         mc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5exphT6h+URglsf993xFNfVsiL87l/ydaIf8LdF1rco=;
        b=UvFFeEjySw1Vgfb6UMKJ662kuevD789fuf9u0ebflP661yh8Xf9RHpz/kAVcLRQ2Rb
         jpLwrEuWUGVRhBa6mUHAGytyJ02MIu8EGKFBkafruVFXC5NSMrw7pyQir9IMSxW/BrJt
         hSJAVw+9xHb2hdTfxt5r35F/8E3BbV/31zEOD9mnkeY3HkwBqLL0aEqO0dz7qYau0bQO
         vf6HgS3YEPJqx3Bf0F74uspljIuPm5TWopeqyqpUqc+LyPmNrLmYAqd9qgnyIA5ezc0u
         xWMEdr4Qi9RNJqEyOVQqBqKpMUZZMNzDBVFiVNdX3TTY3NuFoVd78L8S+hY2yzj6s0l1
         UxbA==
X-Gm-Message-State: AOAM532DObYaSaFEsBfNQ6EpM/3rrO8RDEiCVHmtEIqxqibTIGu/TtAT
        6Y57wokTDlQZeX14UbOl3yPxMtfwhwY=
X-Google-Smtp-Source: ABdhPJzVDPC6QqOTFaiOD0oXcmfk0s5dA8DdkAj9XlKF9ya4nd6s68f3BaFZgrwS8JflzFwx2F46kQ==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr8152122wru.33.1633638330135;
        Thu, 07 Oct 2021 13:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm315645wmi.47.2021.10.07.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:29 -0700 (PDT)
Message-Id: <55dacc6760f9e7679957ed2055e664f1c8a0615f.1633638316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:25:13 +0000
Subject: [PATCH v4 17/19] reftable: implement stack, a mutable database of
 reftable files.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |    1 +
 reftable/reftable-stack.h |  128 ++++
 reftable/stack.c          | 1396 +++++++++++++++++++++++++++++++++++++
 reftable/stack.h          |   41 ++
 reftable/stack_test.c     |  953 +++++++++++++++++++++++++
 t/helper/test-reftable.c  |    1 +
 6 files changed, 2520 insertions(+)
 create mode 100644 reftable/reftable-stack.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c

diff --git a/Makefile b/Makefile
index 6c652fcacbd..29344440715 100644
--- a/Makefile
+++ b/Makefile
@@ -2459,6 +2459,7 @@ REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/refname_test.o
+REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
new file mode 100644
index 00000000000..1b602dda58a
--- /dev/null
+++ b/reftable/reftable-stack.h
@@ -0,0 +1,128 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_STACK_H
+#define REFTABLE_STACK_H
+
+#include "reftable-writer.h"
+
+/*
+ * The stack presents an interface to a mutable sequence of reftables.
+
+ * A stack can be mutated by pushing a table to the top of the stack.
+
+ * The reftable_stack automatically compacts files on disk to ensure good
+ * amortized performance.
+ *
+ * For windows and other platforms that cannot have open files as rename
+ * destinations, concurrent access from multiple processes needs the rand()
+ * random seed to be randomized.
+ */
+struct reftable_stack;
+
+/* open a new reftable stack. The tables along with the table list will be
+ *  stored in 'dir'. Typically, this should be .git/reftables.
+ */
+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
+		       struct reftable_write_options config);
+
+/* returns the update_index at which a next table should be written. */
+uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
+
+/* holds a transaction to add tables at the top of a stack. */
+struct reftable_addition;
+
+/*
+ * returns a new transaction to add reftables to the given stack. As a side
+ * effect, the ref database is locked.
+ */
+int reftable_stack_new_addition(struct reftable_addition **dest,
+				struct reftable_stack *st);
+
+/* Adds a reftable to transaction. */
+int reftable_addition_add(struct reftable_addition *add,
+			  int (*write_table)(struct reftable_writer *wr,
+					     void *arg),
+			  void *arg);
+
+/* Commits the transaction, releasing the lock. After calling this,
+ * reftable_addition_destroy should still be called.
+ */
+int reftable_addition_commit(struct reftable_addition *add);
+
+/* Release all non-committed data from the transaction, and deallocate the
+ * transaction. Releases the lock if held. */
+void reftable_addition_destroy(struct reftable_addition *add);
+
+/* add a new table to the stack. The write_table function must call
+ * reftable_writer_set_limits, add refs and return an error value. */
+int reftable_stack_add(struct reftable_stack *st,
+		       int (*write_table)(struct reftable_writer *wr,
+					  void *write_arg),
+		       void *write_arg);
+
+/* returns the merged_table for seeking. This table is valid until the
+ * next write or reload, and should not be closed or deleted.
+ */
+struct reftable_merged_table *
+reftable_stack_merged_table(struct reftable_stack *st);
+
+/* frees all resources associated with the stack. */
+void reftable_stack_destroy(struct reftable_stack *st);
+
+/* Reloads the stack if necessary. This is very cheap to run if the stack was up
+ * to date */
+int reftable_stack_reload(struct reftable_stack *st);
+
+/* Policy for expiring reflog entries. */
+struct reftable_log_expiry_config {
+	/* Drop entries older than this timestamp */
+	uint64_t time;
+
+	/* Drop older entries */
+	uint64_t min_update_index;
+};
+
+/* compacts all reftables into a giant table. Expire reflog entries if config is
+ * non-NULL */
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config);
+
+/* heuristically compact unbalanced table stack. */
+int reftable_stack_auto_compact(struct reftable_stack *st);
+
+/* delete stale .ref tables. */
+int reftable_stack_clean(struct reftable_stack *st);
+
+/* convenience function to read a single ref. Returns < 0 for error, 0 for
+ * success, and 1 if ref not found. */
+int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
+			    struct reftable_ref_record *ref);
+
+/* convenience function to read a single log. Returns < 0 for error, 0 for
+ * success, and 1 if ref not found. */
+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
+			    struct reftable_log_record *log);
+
+/* statistics on past compactions. */
+struct reftable_compaction_stats {
+	uint64_t bytes; /* total number of bytes written */
+	uint64_t entries_written; /* total number of entries written, including
+				     failures. */
+	int attempts; /* how often we tried to compact */
+	int failures; /* failures happen on concurrent updates */
+};
+
+/* return statistics for compaction up till now. */
+struct reftable_compaction_stats *
+reftable_stack_compaction_stats(struct reftable_stack *st);
+
+/* print the entire stack represented by the directory */
+int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id);
+
+#endif
diff --git a/reftable/stack.c b/reftable/stack.c
new file mode 100644
index 00000000000..df5021ebf08
--- /dev/null
+++ b/reftable/stack.c
@@ -0,0 +1,1396 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "stack.h"
+
+#include "system.h"
+#include "merged.h"
+#include "reader.h"
+#include "refname.h"
+#include "reftable-error.h"
+#include "reftable-record.h"
+#include "reftable-merged.h"
+#include "writer.h"
+
+static int stack_try_add(struct reftable_stack *st,
+			 int (*write_table)(struct reftable_writer *wr,
+					    void *arg),
+			 void *arg);
+static int stack_write_compact(struct reftable_stack *st,
+			       struct reftable_writer *wr, int first, int last,
+			       struct reftable_log_expiry_config *config);
+static int stack_check_addition(struct reftable_stack *st,
+				const char *new_tab_name);
+static void reftable_addition_close(struct reftable_addition *add);
+static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
+					     int reuse_open);
+
+static void stack_filename(struct strbuf *dest, struct reftable_stack *st,
+			   const char *name)
+{
+	strbuf_reset(dest);
+	strbuf_addstr(dest, st->reftable_dir);
+	strbuf_addstr(dest, "/");
+	strbuf_addstr(dest, name);
+}
+
+static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
+{
+	int *fdp = (int *)arg;
+	return write(*fdp, data, sz);
+}
+
+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
+		       struct reftable_write_options config)
+{
+	struct reftable_stack *p =
+		reftable_calloc(sizeof(struct reftable_stack));
+	struct strbuf list_file_name = STRBUF_INIT;
+	int err = 0;
+
+	if (config.hash_id == 0) {
+		config.hash_id = GIT_SHA1_FORMAT_ID;
+	}
+
+	*dest = NULL;
+
+	strbuf_reset(&list_file_name);
+	strbuf_addstr(&list_file_name, dir);
+	strbuf_addstr(&list_file_name, "/tables.list");
+
+	p->list_file = strbuf_detach(&list_file_name, NULL);
+	p->reftable_dir = xstrdup(dir);
+	p->config = config;
+
+	err = reftable_stack_reload_maybe_reuse(p, 1);
+	if (err < 0) {
+		reftable_stack_destroy(p);
+	} else {
+		*dest = p;
+	}
+	return err;
+}
+
+static int fd_read_lines(int fd, char ***namesp)
+{
+	off_t size = lseek(fd, 0, SEEK_END);
+	char *buf = NULL;
+	int err = 0;
+	if (size < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+	err = lseek(fd, 0, SEEK_SET);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	buf = reftable_malloc(size + 1);
+	if (read(fd, buf, size) != size) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+	buf[size] = 0;
+
+	parse_names(buf, size, namesp);
+
+done:
+	reftable_free(buf);
+	return err;
+}
+
+int read_lines(const char *filename, char ***namesp)
+{
+	int fd = open(filename, O_RDONLY);
+	int err = 0;
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			*namesp = reftable_calloc(sizeof(char *));
+			return 0;
+		}
+
+		return REFTABLE_IO_ERROR;
+	}
+	err = fd_read_lines(fd, namesp);
+	close(fd);
+	return err;
+}
+
+struct reftable_merged_table *
+reftable_stack_merged_table(struct reftable_stack *st)
+{
+	return st->merged;
+}
+
+static int has_name(char **names, const char *name)
+{
+	while (*names) {
+		if (!strcmp(*names, name))
+			return 1;
+		names++;
+	}
+	return 0;
+}
+
+/* Close and free the stack */
+void reftable_stack_destroy(struct reftable_stack *st)
+{
+	char **names = NULL;
+	int err = 0;
+	if (st->merged) {
+		reftable_merged_table_free(st->merged);
+		st->merged = NULL;
+	}
+
+	err = read_lines(st->list_file, &names);
+	if (err < 0) {
+		FREE_AND_NULL(names);
+	}
+
+	if (st->readers) {
+		int i = 0;
+		struct strbuf filename = STRBUF_INIT;
+		for (i = 0; i < st->readers_len; i++) {
+			const char *name = reader_name(st->readers[i]);
+			strbuf_reset(&filename);
+			if (names && !has_name(names, name)) {
+				stack_filename(&filename, st, name);
+			}
+			reftable_reader_free(st->readers[i]);
+
+			if (filename.len) {
+				/* On Windows, can only unlink after closing. */
+				unlink(filename.buf);
+			}
+		}
+		strbuf_release(&filename);
+		st->readers_len = 0;
+		FREE_AND_NULL(st->readers);
+	}
+	FREE_AND_NULL(st->list_file);
+	FREE_AND_NULL(st->reftable_dir);
+	reftable_free(st);
+	free_names(names);
+}
+
+static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
+						   int cur_len)
+{
+	struct reftable_reader **cur =
+		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
+	int i = 0;
+	for (i = 0; i < cur_len; i++) {
+		cur[i] = st->readers[i];
+	}
+	return cur;
+}
+
+static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
+				      int reuse_open)
+{
+	int cur_len = !st->merged ? 0 : st->merged->stack_len;
+	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
+	int err = 0;
+	int names_len = names_length(names);
+	struct reftable_reader **new_readers =
+		reftable_calloc(sizeof(struct reftable_reader *) * names_len);
+	struct reftable_table *new_tables =
+		reftable_calloc(sizeof(struct reftable_table) * names_len);
+	int new_readers_len = 0;
+	struct reftable_merged_table *new_merged = NULL;
+	int i;
+
+	while (*names) {
+		struct reftable_reader *rd = NULL;
+		char *name = *names++;
+
+		/* this is linear; we assume compaction keeps the number of
+		   tables under control so this is not quadratic. */
+		int j = 0;
+		for (j = 0; reuse_open && j < cur_len; j++) {
+			if (cur[j] && 0 == strcmp(cur[j]->name, name)) {
+				rd = cur[j];
+				cur[j] = NULL;
+				break;
+			}
+		}
+
+		if (!rd) {
+			struct reftable_block_source src = { NULL };
+			struct strbuf table_path = STRBUF_INIT;
+			stack_filename(&table_path, st, name);
+
+			err = reftable_block_source_from_file(&src,
+							      table_path.buf);
+			strbuf_release(&table_path);
+
+			if (err < 0)
+				goto done;
+
+			err = reftable_new_reader(&rd, &src, name);
+			if (err < 0)
+				goto done;
+		}
+
+		new_readers[new_readers_len] = rd;
+		reftable_table_from_reader(&new_tables[new_readers_len], rd);
+		new_readers_len++;
+	}
+
+	/* success! */
+	err = reftable_new_merged_table(&new_merged, new_tables,
+					new_readers_len, st->config.hash_id);
+	if (err < 0)
+		goto done;
+
+	new_tables = NULL;
+	st->readers_len = new_readers_len;
+	if (st->merged) {
+		merged_table_release(st->merged);
+		reftable_merged_table_free(st->merged);
+	}
+	if (st->readers) {
+		reftable_free(st->readers);
+	}
+	st->readers = new_readers;
+	new_readers = NULL;
+	new_readers_len = 0;
+
+	new_merged->suppress_deletions = 1;
+	st->merged = new_merged;
+	for (i = 0; i < cur_len; i++) {
+		if (cur[i]) {
+			const char *name = reader_name(cur[i]);
+			struct strbuf filename = STRBUF_INIT;
+			stack_filename(&filename, st, name);
+
+			reader_close(cur[i]);
+			reftable_reader_free(cur[i]);
+
+			/* On Windows, can only unlink after closing. */
+			unlink(filename.buf);
+
+			strbuf_release(&filename);
+		}
+	}
+
+done:
+	for (i = 0; i < new_readers_len; i++) {
+		reader_close(new_readers[i]);
+		reftable_reader_free(new_readers[i]);
+	}
+	reftable_free(new_readers);
+	reftable_free(new_tables);
+	reftable_free(cur);
+	return err;
+}
+
+/* return negative if a before b. */
+static int tv_cmp(struct timeval *a, struct timeval *b)
+{
+	time_t diff = a->tv_sec - b->tv_sec;
+	int udiff = a->tv_usec - b->tv_usec;
+
+	if (diff != 0)
+		return diff;
+
+	return udiff;
+}
+
+static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
+					     int reuse_open)
+{
+	struct timeval deadline = { 0 };
+	int err = gettimeofday(&deadline, NULL);
+	int64_t delay = 0;
+	int tries = 0;
+	if (err < 0)
+		return err;
+
+	deadline.tv_sec += 3;
+	while (1) {
+		char **names = NULL;
+		char **names_after = NULL;
+		struct timeval now = { 0 };
+		int err = gettimeofday(&now, NULL);
+		int err2 = 0;
+		if (err < 0) {
+			return err;
+		}
+
+		/* Only look at deadlines after the first few times. This
+		   simplifies debugging in GDB */
+		tries++;
+		if (tries > 3 && tv_cmp(&now, &deadline) >= 0) {
+			break;
+		}
+
+		err = read_lines(st->list_file, &names);
+		if (err < 0) {
+			free_names(names);
+			return err;
+		}
+		err = reftable_stack_reload_once(st, names, reuse_open);
+		if (err == 0) {
+			free_names(names);
+			break;
+		}
+		if (err != REFTABLE_NOT_EXIST_ERROR) {
+			free_names(names);
+			return err;
+		}
+
+		/* err == REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
+		   writer. Check if there was one by checking if the name list
+		   changed.
+		*/
+		err2 = read_lines(st->list_file, &names_after);
+		if (err2 < 0) {
+			free_names(names);
+			return err2;
+		}
+
+		if (names_equal(names_after, names)) {
+			free_names(names);
+			free_names(names_after);
+			return err;
+		}
+		free_names(names);
+		free_names(names_after);
+
+		delay = delay + (delay * rand()) / RAND_MAX + 1;
+		sleep_millisec(delay);
+	}
+
+	return 0;
+}
+
+/* -1 = error
+ 0 = up to date
+ 1 = changed. */
+static int stack_uptodate(struct reftable_stack *st)
+{
+	char **names = NULL;
+	int err = read_lines(st->list_file, &names);
+	int i = 0;
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < st->readers_len; i++) {
+		if (!names[i]) {
+			err = 1;
+			goto done;
+		}
+
+		if (strcmp(st->readers[i]->name, names[i])) {
+			err = 1;
+			goto done;
+		}
+	}
+
+	if (names[st->merged->stack_len]) {
+		err = 1;
+		goto done;
+	}
+
+done:
+	free_names(names);
+	return err;
+}
+
+int reftable_stack_reload(struct reftable_stack *st)
+{
+	int err = stack_uptodate(st);
+	if (err > 0)
+		return reftable_stack_reload_maybe_reuse(st, 1);
+	return err;
+}
+
+int reftable_stack_add(struct reftable_stack *st,
+		       int (*write)(struct reftable_writer *wr, void *arg),
+		       void *arg)
+{
+	int err = stack_try_add(st, write, arg);
+	if (err < 0) {
+		if (err == REFTABLE_LOCK_ERROR) {
+			/* Ignore error return, we want to propagate
+			   REFTABLE_LOCK_ERROR.
+			*/
+			reftable_stack_reload(st);
+		}
+		return err;
+	}
+
+	if (!st->disable_auto_compact)
+		return reftable_stack_auto_compact(st);
+
+	return 0;
+}
+
+static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
+{
+	char buf[100];
+	uint32_t rnd = (uint32_t)rand();
+	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
+		 min, max, rnd);
+	strbuf_reset(dest);
+	strbuf_addstr(dest, buf);
+}
+
+struct reftable_addition {
+	int lock_file_fd;
+	struct strbuf lock_file_name;
+	struct reftable_stack *stack;
+
+	char **new_tables;
+	int new_tables_len;
+	uint64_t next_update_index;
+};
+
+#define REFTABLE_ADDITION_INIT                \
+	{                                     \
+		.lock_file_name = STRBUF_INIT \
+	}
+
+static int reftable_stack_init_addition(struct reftable_addition *add,
+					struct reftable_stack *st)
+{
+	int err = 0;
+	add->stack = st;
+
+	strbuf_reset(&add->lock_file_name);
+	strbuf_addstr(&add->lock_file_name, st->list_file);
+	strbuf_addstr(&add->lock_file_name, ".lock");
+
+	add->lock_file_fd = open(add->lock_file_name.buf,
+				 O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (add->lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = REFTABLE_LOCK_ERROR;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	err = stack_uptodate(st);
+	if (err < 0)
+		goto done;
+
+	if (err > 1) {
+		err = REFTABLE_LOCK_ERROR;
+		goto done;
+	}
+
+	add->next_update_index = reftable_stack_next_update_index(st);
+done:
+	if (err) {
+		reftable_addition_close(add);
+	}
+	return err;
+}
+
+static void reftable_addition_close(struct reftable_addition *add)
+{
+	int i = 0;
+	struct strbuf nm = STRBUF_INIT;
+	for (i = 0; i < add->new_tables_len; i++) {
+		stack_filename(&nm, add->stack, add->new_tables[i]);
+		unlink(nm.buf);
+		reftable_free(add->new_tables[i]);
+		add->new_tables[i] = NULL;
+	}
+	reftable_free(add->new_tables);
+	add->new_tables = NULL;
+	add->new_tables_len = 0;
+
+	if (add->lock_file_fd > 0) {
+		close(add->lock_file_fd);
+		add->lock_file_fd = 0;
+	}
+	if (add->lock_file_name.len > 0) {
+		unlink(add->lock_file_name.buf);
+		strbuf_release(&add->lock_file_name);
+	}
+
+	strbuf_release(&nm);
+}
+
+void reftable_addition_destroy(struct reftable_addition *add)
+{
+	if (!add) {
+		return;
+	}
+	reftable_addition_close(add);
+	reftable_free(add);
+}
+
+int reftable_addition_commit(struct reftable_addition *add)
+{
+	struct strbuf table_list = STRBUF_INIT;
+	int i = 0;
+	int err = 0;
+	if (add->new_tables_len == 0)
+		goto done;
+
+	for (i = 0; i < add->stack->merged->stack_len; i++) {
+		strbuf_addstr(&table_list, add->stack->readers[i]->name);
+		strbuf_addstr(&table_list, "\n");
+	}
+	for (i = 0; i < add->new_tables_len; i++) {
+		strbuf_addstr(&table_list, add->new_tables[i]);
+		strbuf_addstr(&table_list, "\n");
+	}
+
+	err = write(add->lock_file_fd, table_list.buf, table_list.len);
+	strbuf_release(&table_list);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = close(add->lock_file_fd);
+	add->lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = rename(add->lock_file_name.buf, add->stack->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	/* success, no more state to clean up. */
+	strbuf_release(&add->lock_file_name);
+	for (i = 0; i < add->new_tables_len; i++) {
+		reftable_free(add->new_tables[i]);
+	}
+	reftable_free(add->new_tables);
+	add->new_tables = NULL;
+	add->new_tables_len = 0;
+
+	err = reftable_stack_reload(add->stack);
+done:
+	reftable_addition_close(add);
+	return err;
+}
+
+int reftable_stack_new_addition(struct reftable_addition **dest,
+				struct reftable_stack *st)
+{
+	int err = 0;
+	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+	*dest = reftable_calloc(sizeof(**dest));
+	**dest = empty;
+	err = reftable_stack_init_addition(*dest, st);
+	if (err) {
+		reftable_free(*dest);
+		*dest = NULL;
+	}
+	return err;
+}
+
+static int stack_try_add(struct reftable_stack *st,
+			 int (*write_table)(struct reftable_writer *wr,
+					    void *arg),
+			 void *arg)
+{
+	struct reftable_addition add = REFTABLE_ADDITION_INIT;
+	int err = reftable_stack_init_addition(&add, st);
+	if (err < 0)
+		goto done;
+	if (err > 0) {
+		err = REFTABLE_LOCK_ERROR;
+		goto done;
+	}
+
+	err = reftable_addition_add(&add, write_table, arg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_addition_commit(&add);
+done:
+	reftable_addition_close(&add);
+	return err;
+}
+
+int reftable_addition_add(struct reftable_addition *add,
+			  int (*write_table)(struct reftable_writer *wr,
+					     void *arg),
+			  void *arg)
+{
+	struct strbuf temp_tab_file_name = STRBUF_INIT;
+	struct strbuf tab_file_name = STRBUF_INIT;
+	struct strbuf next_name = STRBUF_INIT;
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+	int tab_fd = 0;
+
+	strbuf_reset(&next_name);
+	format_name(&next_name, add->next_update_index, add->next_update_index);
+
+	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
+	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
+
+	tab_fd = mkstemp(temp_tab_file_name.buf);
+	if (tab_fd < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
+				 &add->stack->config);
+	err = write_table(wr, arg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_writer_close(wr);
+	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
+		err = 0;
+		goto done;
+	}
+	if (err < 0)
+		goto done;
+
+	err = close(tab_fd);
+	tab_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = stack_check_addition(add->stack, temp_tab_file_name.buf);
+	if (err < 0)
+		goto done;
+
+	if (wr->min_update_index < add->next_update_index) {
+		err = REFTABLE_API_ERROR;
+		goto done;
+	}
+
+	format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	strbuf_addstr(&next_name, ".ref");
+
+	stack_filename(&tab_file_name, add->stack, next_name.buf);
+
+	/*
+	  On windows, this relies on rand() picking a unique destination name.
+	  Maybe we should do retry loop as well?
+	 */
+	err = rename(temp_tab_file_name.buf, tab_file_name.buf);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	add->new_tables = reftable_realloc(add->new_tables,
+					   sizeof(*add->new_tables) *
+						   (add->new_tables_len + 1));
+	add->new_tables[add->new_tables_len] = strbuf_detach(&next_name, NULL);
+	add->new_tables_len++;
+done:
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (temp_tab_file_name.len > 0) {
+		unlink(temp_tab_file_name.buf);
+	}
+
+	strbuf_release(&temp_tab_file_name);
+	strbuf_release(&tab_file_name);
+	strbuf_release(&next_name);
+	reftable_writer_free(wr);
+	return err;
+}
+
+uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
+{
+	int sz = st->merged->stack_len;
+	if (sz > 0)
+		return reftable_reader_max_update_index(st->readers[sz - 1]) +
+		       1;
+	return 1;
+}
+
+static int stack_compact_locked(struct reftable_stack *st, int first, int last,
+				struct strbuf *temp_tab,
+				struct reftable_log_expiry_config *config)
+{
+	struct strbuf next_name = STRBUF_INIT;
+	int tab_fd = -1;
+	struct reftable_writer *wr = NULL;
+	int err = 0;
+
+	format_name(&next_name,
+		    reftable_reader_min_update_index(st->readers[first]),
+		    reftable_reader_max_update_index(st->readers[last]));
+
+	stack_filename(temp_tab, st, next_name.buf);
+	strbuf_addstr(temp_tab, ".temp.XXXXXX");
+
+	tab_fd = mkstemp(temp_tab->buf);
+	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
+
+	err = stack_write_compact(st, wr, first, last, config);
+	if (err < 0)
+		goto done;
+	err = reftable_writer_close(wr);
+	if (err < 0)
+		goto done;
+
+	err = close(tab_fd);
+	tab_fd = 0;
+
+done:
+	reftable_writer_free(wr);
+	if (tab_fd > 0) {
+		close(tab_fd);
+		tab_fd = 0;
+	}
+	if (err != 0 && temp_tab->len > 0) {
+		unlink(temp_tab->buf);
+		strbuf_release(temp_tab);
+	}
+	strbuf_release(&next_name);
+	return err;
+}
+
+static int stack_write_compact(struct reftable_stack *st,
+			       struct reftable_writer *wr, int first, int last,
+			       struct reftable_log_expiry_config *config)
+{
+	int subtabs_len = last - first + 1;
+	struct reftable_table *subtabs = reftable_calloc(
+		sizeof(struct reftable_table) * (last - first + 1));
+	struct reftable_merged_table *mt = NULL;
+	int err = 0;
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	struct reftable_log_record log = { NULL };
+
+	uint64_t entries = 0;
+
+	int i = 0, j = 0;
+	for (i = first, j = 0; i <= last; i++) {
+		struct reftable_reader *t = st->readers[i];
+		reftable_table_from_reader(&subtabs[j++], t);
+		st->stats.bytes += t->size;
+	}
+	reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
+				   st->readers[last]->max_update_index);
+
+	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
+					st->config.hash_id);
+	if (err < 0) {
+		reftable_free(subtabs);
+		goto done;
+	}
+
+	err = reftable_merged_table_seek_ref(mt, &it, "");
+	if (err < 0)
+		goto done;
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+
+		if (first == 0 && reftable_ref_record_is_deletion(&ref)) {
+			continue;
+		}
+
+		err = reftable_writer_add_ref(wr, &ref);
+		if (err < 0) {
+			break;
+		}
+		entries++;
+	}
+	reftable_iterator_destroy(&it);
+
+	err = reftable_merged_table_seek_log(mt, &it, "");
+	if (err < 0)
+		goto done;
+
+	while (1) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+		if (first == 0 && reftable_log_record_is_deletion(&log)) {
+			continue;
+		}
+
+		if (config && config->min_update_index > 0 &&
+		    log.update_index < config->min_update_index) {
+			continue;
+		}
+
+		if (config && config->time > 0 &&
+		    log.value.update.time < config->time) {
+			continue;
+		}
+
+		err = reftable_writer_add_log(wr, &log);
+		if (err < 0) {
+			break;
+		}
+		entries++;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	if (mt) {
+		merged_table_release(mt);
+		reftable_merged_table_free(mt);
+	}
+	reftable_ref_record_release(&ref);
+	reftable_log_record_release(&log);
+	st->stats.entries_written += entries;
+	return err;
+}
+
+/* <  0: error. 0 == OK, > 0 attempt failed; could retry. */
+static int stack_compact_range(struct reftable_stack *st, int first, int last,
+			       struct reftable_log_expiry_config *expiry)
+{
+	struct strbuf temp_tab_file_name = STRBUF_INIT;
+	struct strbuf new_table_name = STRBUF_INIT;
+	struct strbuf lock_file_name = STRBUF_INIT;
+	struct strbuf ref_list_contents = STRBUF_INIT;
+	struct strbuf new_table_path = STRBUF_INIT;
+	int err = 0;
+	int have_lock = 0;
+	int lock_file_fd = 0;
+	int compact_count = last - first + 1;
+	char **listp = NULL;
+	char **delete_on_success =
+		reftable_calloc(sizeof(char *) * (compact_count + 1));
+	char **subtable_locks =
+		reftable_calloc(sizeof(char *) * (compact_count + 1));
+	int i = 0;
+	int j = 0;
+	int is_empty_table = 0;
+
+	if (first > last || (!expiry && first == last)) {
+		err = 0;
+		goto done;
+	}
+
+	st->stats.attempts++;
+
+	strbuf_reset(&lock_file_name);
+	strbuf_addstr(&lock_file_name, st->list_file);
+	strbuf_addstr(&lock_file_name, ".lock");
+
+	lock_file_fd =
+		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	/* Don't want to write to the lock for now.  */
+	close(lock_file_fd);
+	lock_file_fd = 0;
+
+	have_lock = 1;
+	err = stack_uptodate(st);
+	if (err != 0)
+		goto done;
+
+	for (i = first, j = 0; i <= last; i++) {
+		struct strbuf subtab_file_name = STRBUF_INIT;
+		struct strbuf subtab_lock = STRBUF_INIT;
+		int sublock_file_fd = -1;
+
+		stack_filename(&subtab_file_name, st,
+			       reader_name(st->readers[i]));
+
+		strbuf_reset(&subtab_lock);
+		strbuf_addbuf(&subtab_lock, &subtab_file_name);
+		strbuf_addstr(&subtab_lock, ".lock");
+
+		sublock_file_fd = open(subtab_lock.buf,
+				       O_EXCL | O_CREAT | O_WRONLY, 0644);
+		if (sublock_file_fd > 0) {
+			close(sublock_file_fd);
+		} else if (sublock_file_fd < 0) {
+			if (errno == EEXIST) {
+				err = 1;
+			} else {
+				err = REFTABLE_IO_ERROR;
+			}
+		}
+
+		subtable_locks[j] = subtab_lock.buf;
+		delete_on_success[j] = subtab_file_name.buf;
+		j++;
+
+		if (err != 0)
+			goto done;
+	}
+
+	err = unlink(lock_file_name.buf);
+	if (err < 0)
+		goto done;
+	have_lock = 0;
+
+	err = stack_compact_locked(st, first, last, &temp_tab_file_name,
+				   expiry);
+	/* Compaction + tombstones can create an empty table out of non-empty
+	 * tables. */
+	is_empty_table = (err == REFTABLE_EMPTY_TABLE_ERROR);
+	if (is_empty_table) {
+		err = 0;
+	}
+	if (err < 0)
+		goto done;
+
+	lock_file_fd =
+		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
+	if (lock_file_fd < 0) {
+		if (errno == EEXIST) {
+			err = 1;
+		} else {
+			err = REFTABLE_IO_ERROR;
+		}
+		goto done;
+	}
+	have_lock = 1;
+
+	format_name(&new_table_name, st->readers[first]->min_update_index,
+		    st->readers[last]->max_update_index);
+	strbuf_addstr(&new_table_name, ".ref");
+
+	stack_filename(&new_table_path, st, new_table_name.buf);
+
+	if (!is_empty_table) {
+		/* retry? */
+		err = rename(temp_tab_file_name.buf, new_table_path.buf);
+		if (err < 0) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+	}
+
+	for (i = 0; i < first; i++) {
+		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
+		strbuf_addstr(&ref_list_contents, "\n");
+	}
+	if (!is_empty_table) {
+		strbuf_addbuf(&ref_list_contents, &new_table_name);
+		strbuf_addstr(&ref_list_contents, "\n");
+	}
+	for (i = last + 1; i < st->merged->stack_len; i++) {
+		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
+		strbuf_addstr(&ref_list_contents, "\n");
+	}
+
+	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(new_table_path.buf);
+		goto done;
+	}
+	err = close(lock_file_fd);
+	lock_file_fd = 0;
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(new_table_path.buf);
+		goto done;
+	}
+
+	err = rename(lock_file_name.buf, st->list_file);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		unlink(new_table_path.buf);
+		goto done;
+	}
+	have_lock = 0;
+
+	/* Reload the stack before deleting. On windows, we can only delete the
+	   files after we closed them.
+	*/
+	err = reftable_stack_reload_maybe_reuse(st, first < last);
+
+	listp = delete_on_success;
+	while (*listp) {
+		if (strcmp(*listp, new_table_path.buf)) {
+			unlink(*listp);
+		}
+		listp++;
+	}
+
+done:
+	free_names(delete_on_success);
+
+	listp = subtable_locks;
+	while (*listp) {
+		unlink(*listp);
+		listp++;
+	}
+	free_names(subtable_locks);
+	if (lock_file_fd > 0) {
+		close(lock_file_fd);
+		lock_file_fd = 0;
+	}
+	if (have_lock) {
+		unlink(lock_file_name.buf);
+	}
+	strbuf_release(&new_table_name);
+	strbuf_release(&new_table_path);
+	strbuf_release(&ref_list_contents);
+	strbuf_release(&temp_tab_file_name);
+	strbuf_release(&lock_file_name);
+	return err;
+}
+
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config)
+{
+	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
+}
+
+static int stack_compact_range_stats(struct reftable_stack *st, int first,
+				     int last,
+				     struct reftable_log_expiry_config *config)
+{
+	int err = stack_compact_range(st, first, last, config);
+	if (err > 0) {
+		st->stats.failures++;
+	}
+	return err;
+}
+
+static int segment_size(struct segment *s)
+{
+	return s->end - s->start;
+}
+
+int fastlog2(uint64_t sz)
+{
+	int l = 0;
+	if (sz == 0)
+		return 0;
+	for (; sz; sz /= 2) {
+		l++;
+	}
+	return l - 1;
+}
+
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
+{
+	struct segment *segs = reftable_calloc(sizeof(struct segment) * n);
+	int next = 0;
+	struct segment cur = { 0 };
+	int i = 0;
+
+	if (n == 0) {
+		*seglen = 0;
+		return segs;
+	}
+	for (i = 0; i < n; i++) {
+		int log = fastlog2(sizes[i]);
+		if (cur.log != log && cur.bytes > 0) {
+			struct segment fresh = {
+				.start = i,
+			};
+
+			segs[next++] = cur;
+			cur = fresh;
+		}
+
+		cur.log = log;
+		cur.end = i + 1;
+		cur.bytes += sizes[i];
+	}
+	segs[next++] = cur;
+	*seglen = next;
+	return segs;
+}
+
+struct segment suggest_compaction_segment(uint64_t *sizes, int n)
+{
+	int seglen = 0;
+	struct segment *segs = sizes_to_segments(&seglen, sizes, n);
+	struct segment min_seg = {
+		.log = 64,
+	};
+	int i = 0;
+	for (i = 0; i < seglen; i++) {
+		if (segment_size(&segs[i]) == 1) {
+			continue;
+		}
+
+		if (segs[i].log < min_seg.log) {
+			min_seg = segs[i];
+		}
+	}
+
+	while (min_seg.start > 0) {
+		int prev = min_seg.start - 1;
+		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev])) {
+			break;
+		}
+
+		min_seg.start = prev;
+		min_seg.bytes += sizes[prev];
+	}
+
+	reftable_free(segs);
+	return min_seg;
+}
+
+static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
+{
+	uint64_t *sizes =
+		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
+	int version = (st->config.hash_id == GIT_SHA1_FORMAT_ID) ? 1 : 2;
+	int overhead = header_size(version) - 1;
+	int i = 0;
+	for (i = 0; i < st->merged->stack_len; i++) {
+		sizes[i] = st->readers[i]->size - overhead;
+	}
+	return sizes;
+}
+
+int reftable_stack_auto_compact(struct reftable_stack *st)
+{
+	uint64_t *sizes = stack_table_sizes_for_compaction(st);
+	struct segment seg =
+		suggest_compaction_segment(sizes, st->merged->stack_len);
+	reftable_free(sizes);
+	if (segment_size(&seg) > 0)
+		return stack_compact_range_stats(st, seg.start, seg.end - 1,
+						 NULL);
+
+	return 0;
+}
+
+struct reftable_compaction_stats *
+reftable_stack_compaction_stats(struct reftable_stack *st)
+{
+	return &st->stats;
+}
+
+int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_table tab = { NULL };
+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
+	return reftable_table_read_ref(&tab, refname, ref);
+}
+
+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
+			    struct reftable_log_record *log)
+{
+	struct reftable_iterator it = { NULL };
+	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
+	int err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err)
+		goto done;
+
+	err = reftable_iterator_next_log(&it, log);
+	if (err)
+		goto done;
+
+	if (strcmp(log->refname, refname) ||
+	    reftable_log_record_is_deletion(log)) {
+		err = 1;
+		goto done;
+	}
+
+done:
+	if (err) {
+		reftable_log_record_release(log);
+	}
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int stack_check_addition(struct reftable_stack *st,
+				const char *new_tab_name)
+{
+	int err = 0;
+	struct reftable_block_source src = { NULL };
+	struct reftable_reader *rd = NULL;
+	struct reftable_table tab = { NULL };
+	struct reftable_ref_record *refs = NULL;
+	struct reftable_iterator it = { NULL };
+	int cap = 0;
+	int len = 0;
+	int i = 0;
+
+	if (st->config.skip_name_check)
+		return 0;
+
+	err = reftable_block_source_from_file(&src, new_tab_name);
+	if (err < 0)
+		goto done;
+
+	err = reftable_new_reader(&rd, &src, new_tab_name);
+	if (err < 0)
+		goto done;
+
+	err = reftable_reader_seek_ref(rd, &it, "");
+	if (err > 0) {
+		err = 0;
+		goto done;
+	}
+	if (err < 0)
+		goto done;
+
+	while (1) {
+		struct reftable_ref_record ref = { NULL };
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0)
+			goto done;
+
+		if (len >= cap) {
+			cap = 2 * cap + 1;
+			refs = reftable_realloc(refs, cap * sizeof(refs[0]));
+		}
+
+		refs[len++] = ref;
+	}
+
+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
+
+	err = validate_ref_record_addition(tab, refs, len);
+
+done:
+	for (i = 0; i < len; i++) {
+		reftable_ref_record_release(&refs[i]);
+	}
+
+	free(refs);
+	reftable_iterator_destroy(&it);
+	reftable_reader_free(rd);
+	return err;
+}
+
+static int is_table_name(const char *s)
+{
+	const char *dot = strrchr(s, '.');
+	return dot && !strcmp(dot, ".ref");
+}
+
+static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
+				     const char *name)
+{
+	int err = 0;
+	uint64_t update_idx = 0;
+	struct reftable_block_source src = { NULL };
+	struct reftable_reader *rd = NULL;
+	struct strbuf table_path = STRBUF_INIT;
+	stack_filename(&table_path, st, name);
+
+	err = reftable_block_source_from_file(&src, table_path.buf);
+	if (err < 0)
+		goto done;
+
+	err = reftable_new_reader(&rd, &src, name);
+	if (err < 0)
+		goto done;
+
+	update_idx = reftable_reader_max_update_index(rd);
+	reftable_reader_free(rd);
+
+	if (update_idx <= max) {
+		unlink(table_path.buf);
+	}
+done:
+	strbuf_release(&table_path);
+}
+
+static int reftable_stack_clean_locked(struct reftable_stack *st)
+{
+	uint64_t max = reftable_merged_table_max_update_index(
+		reftable_stack_merged_table(st));
+	DIR *dir = opendir(st->reftable_dir);
+	struct dirent *d = NULL;
+	if (!dir) {
+		return REFTABLE_IO_ERROR;
+	}
+
+	while ((d = readdir(dir))) {
+		int i = 0;
+		int found = 0;
+		if (!is_table_name(d->d_name))
+			continue;
+
+		for (i = 0; !found && i < st->readers_len; i++) {
+			found = !strcmp(reader_name(st->readers[i]), d->d_name);
+		}
+		if (found)
+			continue;
+
+		remove_maybe_stale_table(st, max, d->d_name);
+	}
+
+	closedir(dir);
+	return 0;
+}
+
+int reftable_stack_clean(struct reftable_stack *st)
+{
+	struct reftable_addition *add = NULL;
+	int err = reftable_stack_new_addition(&add, st);
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(st);
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_clean_locked(st);
+
+done:
+	reftable_addition_destroy(add);
+	return err;
+}
+
+int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id)
+{
+	struct reftable_stack *stack = NULL;
+	struct reftable_write_options cfg = { .hash_id = hash_id };
+	struct reftable_merged_table *merged = NULL;
+	struct reftable_table table = { NULL };
+
+	int err = reftable_new_stack(&stack, stackdir, cfg);
+	if (err < 0)
+		goto done;
+
+	merged = reftable_stack_merged_table(stack);
+	reftable_table_from_merged_table(&table, merged);
+	err = reftable_table_print(&table);
+done:
+	if (stack)
+		reftable_stack_destroy(stack);
+	return err;
+}
diff --git a/reftable/stack.h b/reftable/stack.h
new file mode 100644
index 00000000000..f57005846e5
--- /dev/null
+++ b/reftable/stack.h
@@ -0,0 +1,41 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef STACK_H
+#define STACK_H
+
+#include "system.h"
+#include "reftable-writer.h"
+#include "reftable-stack.h"
+
+struct reftable_stack {
+	char *list_file;
+	char *reftable_dir;
+	int disable_auto_compact;
+
+	struct reftable_write_options config;
+
+	struct reftable_reader **readers;
+	size_t readers_len;
+	struct reftable_merged_table *merged;
+	struct reftable_compaction_stats stats;
+};
+
+int read_lines(const char *filename, char ***lines);
+
+struct segment {
+	int start, end;
+	int log;
+	uint64_t bytes;
+};
+
+int fastlog2(uint64_t sz);
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
+struct segment suggest_compaction_segment(uint64_t *sizes, int n);
+
+#endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
new file mode 100644
index 00000000000..eb0b7228b0c
--- /dev/null
+++ b/reftable/stack_test.c
@@ -0,0 +1,953 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "stack.h"
+
+#include "system.h"
+
+#include "reftable-reader.h"
+#include "merged.h"
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+#include <sys/types.h>
+#include <dirent.h>
+
+static void clear_dir(const char *dirname)
+{
+	struct strbuf path = STRBUF_INIT;
+	strbuf_addstr(&path, dirname);
+	remove_dir_recursively(&path, 0);
+	strbuf_release(&path);
+}
+
+static int count_dir_entries(const char *dirname)
+{
+	DIR *dir = opendir(dirname);
+	int len = 0;
+	struct dirent *d;
+	if (dir == NULL)
+		return 0;
+
+	while ((d = readdir(dir))) {
+		if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
+			continue;
+		len++;
+	}
+	closedir(dir);
+	return len;
+}
+
+/*
+ * Work linenumber into the tempdir, so we can see which tests forget to
+ * cleanup.
+ */
+static char *get_tmp_template(int linenumber)
+{
+	const char *tmp = getenv("TMPDIR");
+	static char template[1024];
+	snprintf(template, sizeof(template) - 1, "%s/stack_test-%d.XXXXXX",
+		 tmp ? tmp : "/tmp", linenumber);
+	return template;
+}
+
+static char *get_tmp_dir(int linenumber)
+{
+	char *dir = get_tmp_template(linenumber);
+	EXPECT(mkdtemp(dir));
+	return dir;
+}
+
+static void test_read_file(void)
+{
+	char *fn = get_tmp_template(__LINE__);
+	int fd = mkstemp(fn);
+	char out[1024] = "line1\n\nline2\nline3";
+	int n, err;
+	char **names = NULL;
+	char *want[] = { "line1", "line2", "line3" };
+	int i = 0;
+
+	EXPECT(fd > 0);
+	n = write(fd, out, strlen(out));
+	EXPECT(n == strlen(out));
+	err = close(fd);
+	EXPECT(err >= 0);
+
+	err = read_lines(fn, &names);
+	EXPECT_ERR(err);
+
+	for (i = 0; names[i]; i++) {
+		EXPECT(0 == strcmp(want[i], names[i]));
+	}
+	free_names(names);
+	remove(fn);
+}
+
+static void test_parse_names(void)
+{
+	char buf[] = "line\n";
+	char **names = NULL;
+	parse_names(buf, strlen(buf), &names);
+
+	EXPECT(NULL != names[0]);
+	EXPECT(0 == strcmp(names[0], "line"));
+	EXPECT(NULL == names[1]);
+	free_names(names);
+}
+
+static void test_names_equal(void)
+{
+	char *a[] = { "a", "b", "c", NULL };
+	char *b[] = { "a", "b", "d", NULL };
+	char *c[] = { "a", "b", NULL };
+
+	EXPECT(names_equal(a, a));
+	EXPECT(!names_equal(a, b));
+	EXPECT(!names_equal(a, c));
+}
+
+static int write_test_ref(struct reftable_writer *wr, void *arg)
+{
+	struct reftable_ref_record *ref = arg;
+	reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
+	return reftable_writer_add_ref(wr, ref);
+}
+
+struct write_log_arg {
+	struct reftable_log_record *log;
+	uint64_t update_index;
+};
+
+static int write_test_log(struct reftable_writer *wr, void *arg)
+{
+	struct write_log_arg *wla = arg;
+
+	reftable_writer_set_limits(wr, wla->update_index, wla->update_index);
+	return reftable_writer_add_log(wr, wla->log);
+}
+
+static void test_reftable_stack_add_one(void)
+{
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record ref = {
+		.refname = "HEAD",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "master",
+	};
+	struct reftable_ref_record dest = { NULL };
+
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_read_ref(st, ref.refname, &dest);
+	EXPECT_ERR(err);
+	EXPECT(0 == strcmp("master", dest.value.symref));
+
+	printf("testing print functionality:\n");
+	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
+	EXPECT(err == REFTABLE_FORMAT_ERROR);
+
+	reftable_ref_record_release(&dest);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_uptodate(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st1 = NULL;
+	struct reftable_stack *st2 = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+
+	int err;
+	struct reftable_ref_record ref1 = {
+		.refname = "HEAD",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "master",
+	};
+	struct reftable_ref_record ref2 = {
+		.refname = "branch2",
+		.update_index = 2,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "master",
+	};
+
+
+	/* simulate multi-process access to the same stack
+	   by creating two stacks for the same directory.
+	 */
+	err = reftable_new_stack(&st1, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st1, &write_test_ref, &ref1);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	EXPECT(err == REFTABLE_LOCK_ERROR);
+
+	err = reftable_stack_reload(st2);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	EXPECT_ERR(err);
+	reftable_stack_destroy(st1);
+	reftable_stack_destroy(st2);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_transaction_api(void)
+{
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_addition *add = NULL;
+
+	struct reftable_ref_record ref = {
+		.refname = "HEAD",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "master",
+	};
+	struct reftable_ref_record dest = { NULL };
+
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	reftable_addition_destroy(add);
+
+	err = reftable_stack_new_addition(&add, st);
+	EXPECT_ERR(err);
+
+	err = reftable_addition_add(add, &write_test_ref, &ref);
+	EXPECT_ERR(err);
+
+	err = reftable_addition_commit(add);
+	EXPECT_ERR(err);
+
+	reftable_addition_destroy(add);
+
+	err = reftable_stack_read_ref(st, ref.refname, &dest);
+	EXPECT_ERR(err);
+	EXPECT(REFTABLE_REF_SYMREF == dest.value_type);
+	EXPECT(0 == strcmp("master", dest.value.symref));
+
+	reftable_ref_record_release(&dest);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_validate_refname(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	char *dir = get_tmp_dir(__LINE__);
+
+	int i;
+	struct reftable_ref_record ref = {
+		.refname = "a/b",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "master",
+	};
+	char *additions[] = { "a", "a/b/c" };
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	EXPECT_ERR(err);
+
+	for (i = 0; i < ARRAY_SIZE(additions); i++) {
+		struct reftable_ref_record ref = {
+			.refname = additions[i],
+			.update_index = 1,
+			.value_type = REFTABLE_REF_SYMREF,
+			.value.symref = "master",
+		};
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		EXPECT(err == REFTABLE_NAME_CONFLICT);
+	}
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static int write_error(struct reftable_writer *wr, void *arg)
+{
+	return *((int *)arg);
+}
+
+static void test_reftable_stack_update_index_check(void)
+{
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record ref1 = {
+		.refname = "name1",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "master",
+	};
+	struct reftable_ref_record ref2 = {
+		.refname = "name2",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "master",
+	};
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref1);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref2);
+	EXPECT(err == REFTABLE_API_ERROR);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_lock_failure(void)
+{
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err, i;
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
+		err = reftable_stack_add(st, &write_error, &i);
+		EXPECT(err == i);
+	}
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_add(void)
+{
+	int i = 0;
+	int err = 0;
+	struct reftable_write_options cfg = {
+		.exact_log_message = 1,
+	};
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_ref_record refs[2] = { { NULL } };
+	struct reftable_log_record logs[2] = { { NULL } };
+	int N = ARRAY_SIZE(refs);
+
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+	st->disable_auto_compact = 1;
+
+	for (i = 0; i < N; i++) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "branch%02d", i);
+		refs[i].refname = xstrdup(buf);
+		refs[i].update_index = i + 1;
+		refs[i].value_type = REFTABLE_REF_VAL1;
+		refs[i].value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
+		set_test_hash(refs[i].value.val1, i);
+
+		logs[i].refname = xstrdup(buf);
+		logs[i].update_index = N + i + 1;
+		logs[i].value_type = REFTABLE_LOG_UPDATE;
+
+		logs[i].value.update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
+		logs[i].value.update.email = xstrdup("identity@invalid");
+		set_test_hash(logs[i].value.update.new_hash, i);
+	}
+
+	for (i = 0; i < N; i++) {
+		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		EXPECT_ERR(err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_stack_compact_all(st, NULL);
+	EXPECT_ERR(err);
+
+	for (i = 0; i < N; i++) {
+		struct reftable_ref_record dest = { NULL };
+
+		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
+		EXPECT_ERR(err);
+		EXPECT(reftable_ref_record_equal(&dest, refs + i,
+						 GIT_SHA1_RAWSZ));
+		reftable_ref_record_release(&dest);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct reftable_log_record dest = { NULL };
+		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
+		EXPECT_ERR(err);
+		EXPECT(reftable_log_record_equal(&dest, logs + i,
+						 GIT_SHA1_RAWSZ));
+		reftable_log_record_release(&dest);
+	}
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_release(&refs[i]);
+		reftable_log_record_release(&logs[i]);
+	}
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_log_normalize(void)
+{
+	int err = 0;
+	struct reftable_write_options cfg = {
+		0,
+	};
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+
+	uint8_t h1[GIT_SHA1_RAWSZ] = { 0x01 }, h2[GIT_SHA1_RAWSZ] = { 0x02 };
+
+	struct reftable_log_record input = { .refname = "branch",
+					     .update_index = 1,
+					     .value_type = REFTABLE_LOG_UPDATE,
+					     .value = { .update = {
+								.new_hash = h1,
+								.old_hash = h2,
+							} } };
+	struct reftable_log_record dest = {
+		.update_index = 0,
+	};
+	struct write_log_arg arg = {
+		.log = &input,
+		.update_index = 1,
+	};
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	input.value.update.message = "one\ntwo";
+	err = reftable_stack_add(st, &write_test_log, &arg);
+	EXPECT(err == REFTABLE_API_ERROR);
+
+	input.value.update.message = "one";
+	err = reftable_stack_add(st, &write_test_log, &arg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_read_log(st, input.refname, &dest);
+	EXPECT_ERR(err);
+	EXPECT(0 == strcmp(dest.value.update.message, "one\n"));
+
+	input.value.update.message = "two\n";
+	arg.update_index = 2;
+	err = reftable_stack_add(st, &write_test_log, &arg);
+	EXPECT_ERR(err);
+	err = reftable_stack_read_log(st, input.refname, &dest);
+	EXPECT_ERR(err);
+	EXPECT(0 == strcmp(dest.value.update.message, "two\n"));
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	reftable_log_record_release(&dest);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_tombstone(void)
+{
+	int i = 0;
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	struct reftable_ref_record refs[2] = { { NULL } };
+	struct reftable_log_record logs[2] = { { NULL } };
+	int N = ARRAY_SIZE(refs);
+	struct reftable_ref_record dest = { NULL };
+	struct reftable_log_record log_dest = { NULL };
+
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	/* even entries add the refs, odd entries delete them. */
+	for (i = 0; i < N; i++) {
+		const char *buf = "branch";
+		refs[i].refname = xstrdup(buf);
+		refs[i].update_index = i + 1;
+		if (i % 2 == 0) {
+			refs[i].value_type = REFTABLE_REF_VAL1;
+			refs[i].value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
+			set_test_hash(refs[i].value.val1, i);
+		}
+
+		logs[i].refname = xstrdup(buf);
+		/* update_index is part of the key. */
+		logs[i].update_index = 42;
+		if (i % 2 == 0) {
+			logs[i].value_type = REFTABLE_LOG_UPDATE;
+			logs[i].value.update.new_hash =
+				reftable_malloc(GIT_SHA1_RAWSZ);
+			set_test_hash(logs[i].value.update.new_hash, i);
+			logs[i].value.update.email =
+				xstrdup("identity@invalid");
+		}
+	}
+	for (i = 0; i < N; i++) {
+		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		EXPECT_ERR(err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_stack_read_ref(st, "branch", &dest);
+	EXPECT(err == 1);
+	reftable_ref_record_release(&dest);
+
+	err = reftable_stack_read_log(st, "branch", &log_dest);
+	EXPECT(err == 1);
+	reftable_log_record_release(&log_dest);
+
+	err = reftable_stack_compact_all(st, NULL);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_read_ref(st, "branch", &dest);
+	EXPECT(err == 1);
+
+	err = reftable_stack_read_log(st, "branch", &log_dest);
+	EXPECT(err == 1);
+	reftable_ref_record_release(&dest);
+	reftable_log_record_release(&log_dest);
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_release(&refs[i]);
+		reftable_log_record_release(&logs[i]);
+	}
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_hash_id(void)
+{
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+
+	struct reftable_ref_record ref = {
+		.refname = "master",
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "target",
+		.update_index = 1,
+	};
+	struct reftable_write_options cfg32 = { .hash_id = GIT_SHA256_FORMAT_ID };
+	struct reftable_stack *st32 = NULL;
+	struct reftable_write_options cfg_default = { 0 };
+	struct reftable_stack *st_default = NULL;
+	struct reftable_ref_record dest = { NULL };
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st, &write_test_ref, &ref);
+	EXPECT_ERR(err);
+
+	/* can't read it with the wrong hash ID. */
+	err = reftable_new_stack(&st32, dir, cfg32);
+	EXPECT(err == REFTABLE_FORMAT_ERROR);
+
+	/* check that we can read it back with default config too. */
+	err = reftable_new_stack(&st_default, dir, cfg_default);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_read_ref(st_default, "master", &dest);
+	EXPECT_ERR(err);
+
+	EXPECT(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
+	reftable_ref_record_release(&dest);
+	reftable_stack_destroy(st);
+	reftable_stack_destroy(st_default);
+	clear_dir(dir);
+}
+
+static void test_log2(void)
+{
+	EXPECT(1 == fastlog2(3));
+	EXPECT(2 == fastlog2(4));
+	EXPECT(2 == fastlog2(5));
+}
+
+static void test_sizes_to_segments(void)
+{
+	uint64_t sizes[] = { 2, 3, 4, 5, 7, 9 };
+	/* .................0  1  2  3  4  5 */
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	EXPECT(segs[2].log == 3);
+	EXPECT(segs[2].start == 5);
+	EXPECT(segs[2].end == 6);
+
+	EXPECT(segs[1].log == 2);
+	EXPECT(segs[1].start == 2);
+	EXPECT(segs[1].end == 5);
+	reftable_free(segs);
+}
+
+static void test_sizes_to_segments_empty(void)
+{
+	int seglen = 0;
+	struct segment *segs = sizes_to_segments(&seglen, NULL, 0);
+	EXPECT(seglen == 0);
+	reftable_free(segs);
+}
+
+static void test_sizes_to_segments_all_equal(void)
+{
+	uint64_t sizes[] = { 5, 5 };
+
+	int seglen = 0;
+	struct segment *segs =
+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+	EXPECT(seglen == 1);
+	EXPECT(segs[0].start == 0);
+	EXPECT(segs[0].end == 2);
+	reftable_free(segs);
+}
+
+static void test_suggest_compaction_segment(void)
+{
+	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
+	/* .................0    1    2  3   4  5  6 */
+	struct segment min =
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+	EXPECT(min.start == 2);
+	EXPECT(min.end == 7);
+}
+
+static void test_suggest_compaction_segment_nothing(void)
+{
+	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
+	struct segment result =
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+	EXPECT(result.start == result.end);
+}
+
+static void test_reflog_expire(void)
+{
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	struct reftable_log_record logs[20] = { { NULL } };
+	int N = ARRAY_SIZE(logs) - 1;
+	int i = 0;
+	int err;
+	struct reftable_log_expiry_config expiry = {
+		.time = 10,
+	};
+	struct reftable_log_record log = { NULL };
+
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	for (i = 1; i <= N; i++) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "branch%02d", i);
+
+		logs[i].refname = xstrdup(buf);
+		logs[i].update_index = i;
+		logs[i].value_type = REFTABLE_LOG_UPDATE;
+		logs[i].value.update.time = i;
+		logs[i].value.update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
+		logs[i].value.update.email = xstrdup("identity@invalid");
+		set_test_hash(logs[i].value.update.new_hash, i);
+	}
+
+	for (i = 1; i <= N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		int err = reftable_stack_add(st, &write_test_log, &arg);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_stack_compact_all(st, NULL);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_compact_all(st, &expiry);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_read_log(st, logs[9].refname, &log);
+	EXPECT(err == 1);
+
+	err = reftable_stack_read_log(st, logs[11].refname, &log);
+	EXPECT_ERR(err);
+
+	expiry.min_update_index = 15;
+	err = reftable_stack_compact_all(st, &expiry);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_read_log(st, logs[14].refname, &log);
+	EXPECT(err == 1);
+
+	err = reftable_stack_read_log(st, logs[16].refname, &log);
+	EXPECT_ERR(err);
+
+	/* cleanup */
+	reftable_stack_destroy(st);
+	for (i = 0; i <= N; i++) {
+		reftable_log_record_release(&logs[i]);
+	}
+	clear_dir(dir);
+	reftable_log_record_release(&log);
+}
+
+static int write_nothing(struct reftable_writer *wr, void *arg)
+{
+	reftable_writer_set_limits(wr, 1, 1);
+	return 0;
+}
+
+static void test_empty_add(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	int err;
+	char *dir = get_tmp_dir(__LINE__);
+
+	struct reftable_stack *st2 = NULL;
+
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_add(st, &write_nothing, NULL);
+	EXPECT_ERR(err);
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	EXPECT_ERR(err);
+	clear_dir(dir);
+	reftable_stack_destroy(st);
+	reftable_stack_destroy(st2);
+}
+
+static void test_reftable_stack_auto_compaction(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+
+	int err, i;
+	int N = 100;
+
+	err = reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	st->disable_auto_compact = 1; /* call manually below for coverage. */
+	for (i = 0; i < N; i++) {
+		char name[100];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st),
+			.value_type = REFTABLE_REF_SYMREF,
+			.value.symref = "master",
+		};
+		snprintf(name, sizeof(name), "branch%04d", i);
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+
+		err = reftable_stack_auto_compact(st);
+		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+	}
+
+	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
+	       (uint64_t)(N * fastlog2(N)));
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void test_reftable_stack_compaction_concurrent(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st1 = NULL, *st2 = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+
+	int err, i;
+	int N = 3;
+
+	err = reftable_new_stack(&st1, dir, cfg);
+	EXPECT_ERR(err);
+
+	for (i = 0; i < N; i++) {
+		char name[100];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st1),
+			.value_type = REFTABLE_REF_SYMREF,
+			.value.symref = "master",
+		};
+		snprintf(name, sizeof(name), "branch%04d", i);
+
+		err = reftable_stack_add(st1, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_compact_all(st1, NULL);
+	EXPECT_ERR(err);
+
+	reftable_stack_destroy(st1);
+	reftable_stack_destroy(st2);
+
+	EXPECT(count_dir_entries(dir) == 2);
+	clear_dir(dir);
+}
+
+static void unclean_stack_close(struct reftable_stack *st)
+{
+	/* break abstraction boundary to simulate unclean shutdown. */
+	int i = 0;
+	for (; i < st->readers_len; i++) {
+		reftable_reader_free(st->readers[i]);
+	}
+	st->readers_len = 0;
+	FREE_AND_NULL(st->readers);
+}
+
+static void test_reftable_stack_compaction_concurrent_clean(void)
+{
+	struct reftable_write_options cfg = { 0 };
+	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+
+	int err, i;
+	int N = 3;
+
+	err = reftable_new_stack(&st1, dir, cfg);
+	EXPECT_ERR(err);
+
+	for (i = 0; i < N; i++) {
+		char name[100];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st1),
+			.value_type = REFTABLE_REF_SYMREF,
+			.value.symref = "master",
+		};
+		snprintf(name, sizeof(name), "branch%04d", i);
+
+		err = reftable_stack_add(st1, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_new_stack(&st2, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_compact_all(st1, NULL);
+	EXPECT_ERR(err);
+
+	unclean_stack_close(st1);
+	unclean_stack_close(st2);
+
+	err = reftable_new_stack(&st3, dir, cfg);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_clean(st3);
+	EXPECT_ERR(err);
+	EXPECT(count_dir_entries(dir) == 2);
+
+	reftable_stack_destroy(st1);
+	reftable_stack_destroy(st2);
+	reftable_stack_destroy(st3);
+
+	clear_dir(dir);
+}
+
+int stack_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_empty_add);
+	RUN_TEST(test_log2);
+	RUN_TEST(test_names_equal);
+	RUN_TEST(test_parse_names);
+	RUN_TEST(test_read_file);
+	RUN_TEST(test_reflog_expire);
+	RUN_TEST(test_reftable_stack_add);
+	RUN_TEST(test_reftable_stack_add_one);
+	RUN_TEST(test_reftable_stack_auto_compaction);
+	RUN_TEST(test_reftable_stack_compaction_concurrent);
+	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
+	RUN_TEST(test_reftable_stack_hash_id);
+	RUN_TEST(test_reftable_stack_lock_failure);
+	RUN_TEST(test_reftable_stack_log_normalize);
+	RUN_TEST(test_reftable_stack_tombstone);
+	RUN_TEST(test_reftable_stack_transaction_api);
+	RUN_TEST(test_reftable_stack_update_index_check);
+	RUN_TEST(test_reftable_stack_uptodate);
+	RUN_TEST(test_reftable_stack_validate_refname);
+	RUN_TEST(test_sizes_to_segments);
+	RUN_TEST(test_sizes_to_segments_all_equal);
+	RUN_TEST(test_sizes_to_segments_empty);
+	RUN_TEST(test_suggest_compaction_segment);
+	RUN_TEST(test_suggest_compaction_segment_nothing);
+	return 0;
+}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index c8db6852c35..996da85f7b5 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -10,6 +10,7 @@ int cmd__reftable(int argc, const char **argv)
 	record_test_main(argc, argv);
 	refname_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
+	stack_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	return 0;
 }
-- 
gitgitgadget

