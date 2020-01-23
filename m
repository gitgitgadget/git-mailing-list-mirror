Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC24C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A66F2253D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q13FgTFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAWTlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:41:35 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39603 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgAWTlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:41:35 -0500
Received: by mail-wm1-f52.google.com with SMTP id 20so3758917wmj.4
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Eqce79XLuIB1Z33h20I2ddX8p2m35d1f6qapJtTVEG0=;
        b=Q13FgTFN/g4iMCIeYbdqWNpLQuLeVbAhAyI9BRR1N4bvz28cGu1vgkii6fHFK4tJx4
         8mfuseMnavp3sCIz6/T3xUn3S8ZEHdYgwLvwo8Uvsunpamrb51dfmtpZs8DfwNbhOxvQ
         ciwyCSn35oZHlOXN0S2FjhRv6XslQ4CL8wBCopZKcstsp05Ek2pwx0wh+gNBT94eSnxH
         D2PJgjsziWXOj707OVDEH8riz06IL0LfDvGqd63+H4dEv5JpLsaFzz8ceDU49vJ3T8UU
         m+RpeVl8m/O7v4Qs49jssz5vWCxBZeqczJ4QRzkmUmWfZeFiZz/fHxev3gpljLXv6Xki
         8ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Eqce79XLuIB1Z33h20I2ddX8p2m35d1f6qapJtTVEG0=;
        b=GC1x54xjJqbetqWAyKtjmB8XrCiIwJm7tbbjztBub7x9ttpQ4eMCLxhWvnsNsFC+lz
         HtuE30MHJZ8s2vTmiCwAhmAkXtn47dS6IFoodueOt2k+AiIfdVBpVDlnnzVoVKiPy7nq
         A09+GZld0Ms78jNbh2Y0oiLW1WUJCoChZ1ww5EkKKIsY191EJapcJtMmh7OyZLezzrK9
         7GXUUDzpXY5Va2i6IsRih7daZ56LmHGIWoT1CIRsjd7mL6NczWWu2/JBpQgs/TTVadvH
         8xr6Ammi3a1nCTHZjupP6g2Iyd8WLR9oUlqsgbmyT8m/qIkg7rrMRatX+AEqSab6S2em
         05EA==
X-Gm-Message-State: APjAAAWS+AjgJSwcFza4KbvKUfnmOeLO+G4k4INMF3YcUX6ZpQMt15PN
        6K0l7l1L3Pi/kkbCbFYia98ie9Py
X-Google-Smtp-Source: APXvYqyTAcAPtr/jTWnvfaeVxHuaWHZoM3c+RHFGjdx2YTedHNcK0+inGVNyl9KwuvLKkdFNffVscw==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr5463794wmh.108.1579808484144;
        Thu, 23 Jan 2020 11:41:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm4409488wre.68.2020.01.23.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:41:23 -0800 (PST)
Message-Id: <3c86bd1d7e0cdcc3ce34cc13754110108e14ce22.1579808479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.git.1579808479.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 19:41:18 +0000
Subject: [PATCH 4/5] Add reftable library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@xs4all.nl>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Change-Id: Id396ff42be8b42b9e11f194a32e2f95b8250c109
---
 reftable/README.md        |   12 +
 reftable/VERSION          |  293 +++++++++++
 reftable/basics.c         |  180 +++++++
 reftable/basics.h         |   38 ++
 reftable/block.c          |  382 ++++++++++++++
 reftable/block.h          |   71 +++
 reftable/block_test.c     |  145 ++++++
 reftable/blocksource.h    |   20 +
 reftable/bytes.c          |    0
 reftable/constants.h      |   27 +
 reftable/dump.c           |  102 ++++
 reftable/file.c           |   98 ++++
 reftable/iter.c           |  211 ++++++++
 reftable/iter.h           |   56 ++
 reftable/merged.c         |  262 ++++++++++
 reftable/merged.h         |   34 ++
 reftable/merged_test.c    |  247 +++++++++
 reftable/pq.c             |  116 +++++
 reftable/pq.h             |   34 ++
 reftable/reader.c         |  672 ++++++++++++++++++++++++
 reftable/reader.h         |   52 ++
 reftable/record.c         | 1030 +++++++++++++++++++++++++++++++++++++
 reftable/record.h         |   79 +++
 reftable/record_test.c    |  313 +++++++++++
 reftable/reftable.h       |  396 ++++++++++++++
 reftable/reftable_test.c  |  434 ++++++++++++++++
 reftable/slice.c          |  179 +++++++
 reftable/slice.h          |   39 ++
 reftable/slice_test.c     |   38 ++
 reftable/stack.c          |  931 +++++++++++++++++++++++++++++++++
 reftable/stack.h          |   40 ++
 reftable/stack_test.c     |  265 ++++++++++
 reftable/test_framework.c |   60 +++
 reftable/test_framework.h |   63 +++
 reftable/tree.c           |   60 +++
 reftable/tree.h           |   24 +
 reftable/tree_test.c      |   54 ++
 reftable/writer.c         |  586 +++++++++++++++++++++
 reftable/writer.h         |   46 ++
 39 files changed, 7689 insertions(+)
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/bytes.c
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/slice_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h

diff --git a/reftable/README.md b/reftable/README.md
new file mode 100644
index 0000000000..cdaf07bbc1
--- /dev/null
+++ b/reftable/README.md
@@ -0,0 +1,12 @@
+The source code in this directory comes from https://github.com/google/reftable
+and can be updated by doing:
+
+   rm -rf reftable-repo && \
+   git clone https://github.com/google/reftable reftable-repo && \
+   cp reftable-repo/c/*.[ch] reftable/ && \
+   cp reftable-repo/LICENSE reftable/
+   git --git-dir reftable-repo/.git show --no-patch origin/master \
+      > reftable/VERSION
+
+Bugfixes should be accompanied by a test and applied to upstream project at
+https://github.com/google/reftable.
diff --git a/reftable/VERSION b/reftable/VERSION
new file mode 100644
index 0000000000..8f3013ead1
--- /dev/null
+++ b/reftable/VERSION
@@ -0,0 +1,293 @@
+commit 887250932a9c39a15aee26aef59df2300c77c03f
+Author: Han-Wen Nienhuys <hanwen@google.com>
+Date:   Wed Jan 22 19:50:16 2020 +0100
+
+    C: implement reflog expiry
+
+diff --git a/c/reftable.h b/c/reftable.h
+index 2f44973..d760af9 100644
+--- a/c/reftable.h
++++ b/c/reftable.h
+@@ -359,8 +359,17 @@ void stack_destroy(struct stack *st);
+ /* reloads the stack if necessary. */
+ int stack_reload(struct stack *st);
+ 
+-/* compacts all reftables into a giant table. */
+-int stack_compact_all(struct stack *st);
++/* Policy for expiring reflog entries. */
++struct log_expiry_config {
++  /* Drop entries older than this timestamp */
++  uint64_t time;
++
++  /* Drop older entries */
++  uint64_t min_update_index;
++};
++
++/* compacts all reftables into a giant table. Expire reflog entries if config is non-NULL */
++int stack_compact_all(struct stack *st, struct log_expiry_config *config);
+ 
+ /* heuristically compact unbalanced table stack. */
+ int stack_auto_compact(struct stack *st);
+diff --git a/c/stack.c b/c/stack.c
+index d67828f..641ac52 100644
+--- a/c/stack.c
++++ b/c/stack.c
+@@ -119,7 +119,7 @@ static struct reader **stack_copy_readers(struct stack *st, int cur_len) {
+   return cur;
+ }
+ 
+-static int stack_reload_once(struct stack *st, char **names) {
++static int stack_reload_once(struct stack *st, char **names, bool reuse_open) {
+   int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
+   struct reader **cur = stack_copy_readers(st, cur_len);
+   int err = 0;
+@@ -136,7 +136,7 @@ static int stack_reload_once(struct stack *st, char **names) {
+ 
+     // this is linear; we assume compaction keeps the number of tables
+     // under control so this is not quadratic.
+-    for (int j = 0; j < cur_len; j++) {
++    for (int j = 0; reuse_open && j < cur_len; j++) {
+       if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
+         rd = cur[j];
+         cur[j] = NULL;
+@@ -207,7 +207,7 @@ static int tv_cmp(struct timeval *a, struct timeval *b) {
+   return udiff;
+ }
+ 
+-int stack_reload(struct stack *st) {
++static int stack_reload_maybe_reuse(struct stack *st, bool reuse_open) {
+   struct timeval deadline = {};
+   int err = gettimeofday(&deadline, NULL);
+   int64_t delay = 0;
+@@ -238,7 +238,7 @@ int stack_reload(struct stack *st) {
+       free_names(names);
+       return err;
+     }
+-    err = stack_reload_once(st, names);
++    err = stack_reload_once(st, names, reuse_open);
+     if (err == 0) {
+       free_names(names);
+       break;
+@@ -269,6 +269,10 @@ int stack_reload(struct stack *st) {
+   return 0;
+ }
+ 
++int stack_reload(struct stack *st) {
++  return stack_reload_maybe_reuse(st, true);
++}
++
+ // -1 = error
+ // 0 = up to date
+ // 1 = changed.
+@@ -471,7 +475,7 @@ uint64_t stack_next_update_index(struct stack *st) {
+ }
+ 
+ static int stack_compact_locked(struct stack *st, int first, int last,
+-                                struct slice *temp_tab) {
++                                struct slice *temp_tab, struct log_expiry_config *config) {
+   struct slice next_name = {};
+   int tab_fd = -1;
+   struct writer *wr = NULL;
+@@ -488,7 +492,7 @@ static int stack_compact_locked(struct stack *st, int first, int last,
+   tab_fd = mkstemp((char *)slice_as_string(temp_tab));
+   wr = new_writer(fd_writer, &tab_fd, &st->config);
+ 
+-  err = stack_write_compact(st, wr, first, last);
++  err = stack_write_compact(st, wr, first, last, config);
+   if (err < 0) {
+     goto exit;
+   }
+@@ -515,7 +519,7 @@ static int stack_compact_locked(struct stack *st, int first, int last,
+ }
+ 
+ int stack_write_compact(struct stack *st, struct writer *wr, int first,
+-                        int last) {
++                        int last, struct log_expiry_config *config) {
+   int subtabs_len = last - first + 1;
+   struct reader **subtabs = calloc(sizeof(struct reader *), last - first + 1);
+   struct merged_table *mt = NULL;
+@@ -580,6 +584,16 @@ int stack_write_compact(struct stack *st, struct writer *wr, int first,
+       continue;
+     }
+ 
++    // XXX collect stats?
++
++    if (config != NULL && config->time > 0 && log.time < config->time) {
++      continue;
++    }
++
++    if (config != NULL && config->min_update_index > 0 && log.update_index < config->min_update_index) {
++      continue;
++    }
++
+     err = writer_add_log(wr, &log);
+     if (err < 0) {
+       break;
+@@ -599,7 +613,7 @@ int stack_write_compact(struct stack *st, struct writer *wr, int first,
+ }
+ 
+ // <  0: error. 0 == OK, > 0 attempt failed; could retry.
+-static int stack_compact_range(struct stack *st, int first, int last) {
++static int stack_compact_range(struct stack *st, int first, int last, struct log_expiry_config *expiry) {
+   struct slice temp_tab_name = {};
+   struct slice new_table_name = {};
+   struct slice lock_file_name = {};
+@@ -612,7 +626,7 @@ static int stack_compact_range(struct stack *st, int first, int last) {
+   char **delete_on_success = calloc(sizeof(char *), compact_count + 1);
+   char **subtable_locks = calloc(sizeof(char *), compact_count + 1);
+ 
+-  if (first >= last) {
++  if (first > last || (expiry == NULL && first == last)) {
+     err = 0;
+     goto exit;
+   }
+@@ -676,7 +690,7 @@ static int stack_compact_range(struct stack *st, int first, int last) {
+   }
+   have_lock = false;
+ 
+-  err = stack_compact_locked(st, first, last, &temp_tab_name);
++  err = stack_compact_locked(st, first, last, &temp_tab_name, expiry);
+   if (err < 0) {
+     goto exit;
+   }
+@@ -739,10 +753,12 @@ static int stack_compact_range(struct stack *st, int first, int last) {
+   have_lock = false;
+ 
+   for (char **p = delete_on_success; *p; p++) {
+-    unlink(*p);
++    if (0 != strcmp(*p, slice_as_string(&new_table_path))) {
++      unlink(*p);
++    }
+   }
+ 
+-  err = stack_reload(st);
++  err = stack_reload_maybe_reuse(st, first < last);
+ exit:
+   for (char **p = subtable_locks; *p; p++) {
+     unlink(*p);
+@@ -764,12 +780,12 @@ static int stack_compact_range(struct stack *st, int first, int last) {
+   return err;
+ }
+ 
+-int stack_compact_all(struct stack *st) {
+-  return stack_compact_range(st, 0, st->merged->stack_len - 1);
++int stack_compact_all(struct stack *st, struct log_expiry_config *config) {
++  return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
+ }
+ 
+-static int stack_compact_range_stats(struct stack *st, int first, int last) {
+-  int err = stack_compact_range(st, first, last);
++static int stack_compact_range_stats(struct stack *st, int first, int last, struct log_expiry_config *config) {
++  int err = stack_compact_range(st, first, last, config);
+   if (err > 0) {
+     st->stats.failures++;
+   }
+@@ -856,7 +872,7 @@ int stack_auto_compact(struct stack *st) {
+   struct segment seg = suggest_compaction_segment(sizes, st->merged->stack_len);
+   free(sizes);
+   if (segment_size(&seg) > 0) {
+-    return stack_compact_range_stats(st, seg.start, seg.end - 1);
++    return stack_compact_range_stats(st, seg.start, seg.end - 1, NULL);
+   }
+ 
+   return 0;
+diff --git a/c/stack.h b/c/stack.h
+index 8cb2cb0..092a03b 100644
+--- a/c/stack.h
++++ b/c/stack.h
+@@ -25,7 +25,7 @@ int read_lines(const char *filename, char ***lines);
+ int stack_try_add(struct stack *st,
+                   int (*write_table)(struct writer *wr, void *arg), void *arg);
+ int stack_write_compact(struct stack *st, struct writer *wr, int first,
+-                        int last);
++                        int last, struct log_expiry_config *config);
+ int fastlog2(uint64_t sz);
+ 
+ struct segment {
+diff --git a/c/stack_test.c b/c/stack_test.c
+index c49d8b8..8c0cde0 100644
+--- a/c/stack_test.c
++++ b/c/stack_test.c
+@@ -121,7 +121,7 @@ void test_stack_add(void) {
+     assert_err(err);
+   }
+ 
+-  err = stack_compact_all(st);
++  err = stack_compact_all(st, NULL);
+   assert_err(err);
+ 
+   for (int i = 0; i < N; i++) {
+@@ -186,7 +186,73 @@ void test_suggest_compaction_segment(void) {
+   }
+ }
+ 
++void test_reflog_expire(void) {
++  char dir[256] = "/tmp/stack.XXXXXX";
++  assert(mkdtemp(dir));
++  printf("%s\n", dir);
++  char fn[256] = "";
++  strcat(fn, dir);
++  strcat(fn, "/refs");
++
++  struct write_options cfg = {};
++  struct stack *st = NULL;
++  int err = new_stack(&st, dir, fn, cfg);
++  assert_err(err);
++
++  struct log_record logs[20] = {};
++  int N = ARRAYSIZE(logs) -1;
++  for (int i = 1; i <= N; i++) {
++    char buf[256];
++    sprintf(buf, "branch%02d", i);
++
++    logs[i].ref_name = strdup(buf);
++    logs[i].update_index = i;
++    logs[i].time = i;
++    logs[i].new_hash = malloc(SHA1_SIZE);
++    logs[i].email = strdup("identity@invalid");
++    set_test_hash(logs[i].new_hash, i);
++  }
++
++  for (int i = 1; i <= N; i++) {
++    int err = stack_add(st, &write_test_log, &logs[i]);
++    assert_err(err);
++  }
++
++  err = stack_compact_all(st, NULL);
++  assert_err(err);
++
++  struct log_expiry_config expiry = {
++    .time = 10,
++  };
++  err = stack_compact_all(st, &expiry);
++  assert_err(err);
++
++  struct log_record log = {};
++  err = stack_read_log(st, logs[9].ref_name, &log);
++  assert(err == 1);
++
++  err = stack_read_log(st, logs[11].ref_name, &log);
++  assert_err(err);
++
++  expiry.min_update_index = 15;
++  err = stack_compact_all(st, &expiry);
++  assert_err(err);
++
++  err = stack_read_log(st, logs[14].ref_name, &log);
++  assert(err == 1);
++
++  err = stack_read_log(st, logs[16].ref_name, &log);
++  assert_err(err);
++
++  // cleanup
++  stack_destroy(st);
++  for (int i = 0; i < N; i++) {
++    log_record_clear(&logs[i]);
++  }
++}
++
+ int main() {
++  add_test_case("test_reflog_expire", test_reflog_expire);
+   add_test_case("test_suggest_compaction_segment",
+                 &test_suggest_compaction_segment);
+   add_test_case("test_sizes_to_segments", &test_sizes_to_segments);
diff --git a/reftable/basics.c b/reftable/basics.c
new file mode 100644
index 0000000000..72c478cbea
--- /dev/null
+++ b/reftable/basics.c
@@ -0,0 +1,180 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "basics.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+void put_u24(byte *out, uint32_t i) {
+  out[0] = (byte)((i >> 16) & 0xff);
+  out[1] = (byte)((i >> 8) & 0xff);
+  out[2] = (byte)((i)&0xff);
+}
+
+uint32_t get_u24(byte *in) {
+  return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 | (uint32_t)(in[2]);
+}
+
+void put_u32(byte *out, uint32_t i) {
+  out[0] = (byte)((i >> 24) & 0xff);
+  out[1] = (byte)((i >> 16) & 0xff);
+  out[2] = (byte)((i >> 8) & 0xff);
+  out[3] = (byte)((i)&0xff);
+}
+
+uint32_t get_u32(byte *in) {
+  return (uint32_t)(in[0]) << 24 | (uint32_t)(in[1]) << 16 |
+         (uint32_t)(in[2]) << 8 | (uint32_t)(in[3]);
+}
+
+void put_u64(byte *out, uint64_t v) {
+  for (int i = sizeof(uint64_t); i--;) {
+    out[i] = (byte)(v & 0xff);
+    v >>= 8;
+  }
+}
+
+uint64_t get_u64(byte *out) {
+  uint64_t v = 0;
+  for (int i = 0; i < sizeof(uint64_t); i++) {
+    v = (v << 8) | (byte)(out[i] & 0xff);
+  }
+  return v;
+}
+
+void put_u16(byte *out, uint16_t i) {
+  out[0] = (byte)((i >> 8) & 0xff);
+  out[1] = (byte)((i)&0xff);
+}
+
+uint16_t get_u16(byte *in) {
+  return (uint32_t)(in[0]) << 8 | (uint32_t)(in[1]);
+}
+
+/*
+  find smallest index i in [0, sz) at which f(i) is true, assuming
+  that f is ascending. Return sz if f(i) is false for all indices.
+*/
+int binsearch(int sz, int (*f)(int k, void *args), void *args) {
+  int lo = 0;
+  int hi = sz;
+
+  /* invariant: (hi == sz) || f(hi) == true
+     (lo == 0 && f(0) == true) || fi(lo) == false
+   */
+  while (hi - lo > 1) {
+    int mid = lo + (hi - lo) / 2;
+
+    int val = f(mid, args);
+    if (val) {
+      hi = mid;
+    } else {
+      lo = mid;
+    }
+  }
+
+  if (lo == 0) {
+    if (f(0, args)) {
+      return 0;
+    } else {
+      return 1;
+    }
+  }
+
+  return hi;
+}
+
+void free_names(char **a) {
+  char **p = a;
+  if (p == NULL) {
+    return;
+  }
+  while (*p) {
+    free(*p);
+    p++;
+  }
+  free(a);
+}
+
+int names_length(char **names) {
+  int len = 0;
+  for (char **p = names; *p; p++) {
+    len++;
+  }
+  return len;
+}
+
+/* parse a newline separated list of names. Empty names are discarded. */
+void parse_names(char *buf, int size, char ***namesp) {
+  char **names = NULL;
+  int names_cap = 0;
+  int names_len = 0;
+
+  char *p = buf;
+  char *end = buf + size;
+  while (p < end) {
+    char *next = strchr(p, '\n');
+    if (next != NULL) {
+      *next = 0;
+    } else {
+      next = end;
+    }
+    if (p < next) {
+      if (names_len == names_cap) {
+        names_cap = 2 * names_cap + 1;
+        names = realloc(names, names_cap * sizeof(char *));
+      }
+      names[names_len++] = strdup(p);
+    }
+    p = next + 1;
+  }
+
+  if (names_len == names_cap) {
+    names_cap = 2 * names_cap + 1;
+    names = realloc(names, names_cap * sizeof(char *));
+  }
+
+  names[names_len] = NULL;
+  *namesp = names;
+}
+
+int names_equal(char **a, char **b) {
+  while (*a && *b) {
+    if (0 != strcmp(*a, *b)) {
+      return 0;
+    }
+
+    a++;
+    b++;
+  }
+
+  return *a == *b;
+}
+
+const char *error_str(int err) {
+  switch (err) {
+    case IO_ERROR:
+      return "I/O error";
+    case FORMAT_ERROR:
+      return "FORMAT_ERROR";
+    case NOT_EXIST_ERROR:
+      return "NOT_EXIST_ERROR";
+    case LOCK_ERROR:
+      return "LOCK_ERROR";
+    case API_ERROR:
+      return "API_ERROR";
+    case ZLIB_ERROR:
+      return "ZLIB_ERROR";
+    case -1:
+      return "general error";
+    default:
+      return "unknown error code";
+  }
+}
diff --git a/reftable/basics.h b/reftable/basics.h
new file mode 100644
index 0000000000..c28903aa2e
--- /dev/null
+++ b/reftable/basics.h
@@ -0,0 +1,38 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BASICS_H
+#define BASICS_H
+
+#include <stdint.h>
+
+#include "reftable.h"
+
+#define true 1
+#define false 0
+#define ARRAYSIZE(a) sizeof(a) / sizeof(a[0])
+
+void put_u24(byte *out, uint32_t i);
+uint32_t get_u24(byte *in);
+
+uint64_t get_u64(byte *in);
+void put_u64(byte *out, uint64_t i);
+
+void put_u32(byte *out, uint32_t i);
+uint32_t get_u32(byte *in);
+
+void put_u16(byte *out, uint16_t i);
+uint16_t get_u16(byte *in);
+int binsearch(int sz, int (*f)(int k, void *args), void *args);
+
+void free_names(char **a);
+void parse_names(char *buf, int size, char ***namesp);
+int names_equal(char **a, char **b);
+int names_length(char **names);
+
+#endif
diff --git a/reftable/block.c b/reftable/block.c
new file mode 100644
index 0000000000..079331b6b9
--- /dev/null
+++ b/reftable/block.c
@@ -0,0 +1,382 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "block.h"
+
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "blocksource.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "zlib.h"
+
+int block_writer_register_restart(struct block_writer *w, int n, bool restart,
+                                  struct slice key);
+
+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
+                       uint32_t block_size, uint32_t header_off,
+                       int hash_size) {
+  bw->buf = buf;
+  bw->hash_size = hash_size;
+  bw->block_size = block_size;
+  bw->header_off = header_off;
+  bw->buf[header_off] = typ;
+  bw->next = header_off + 4;
+  bw->restart_interval = 16;
+  bw->entries = 0;
+}
+
+byte block_writer_type(struct block_writer *bw) {
+  return bw->buf[bw->header_off];
+}
+
+/* adds the record to the block. Returns -1 if it does not fit, 0 on
+   success */
+int block_writer_add(struct block_writer *w, struct record rec) {
+  struct slice empty = {};
+  struct slice last =
+      w->entries % w->restart_interval == 0 ? empty : w->last_key;
+  struct slice out = {
+      .buf = w->buf + w->next,
+      .len = w->block_size - w->next,
+  };
+
+  struct slice start = out;
+
+  bool restart = false;
+  struct slice key = {};
+  int n = 0;
+
+  record_key(rec, &key);
+  n = encode_key(&restart, out, last, key, record_val_type(rec));
+  if (n < 0) {
+    goto err;
+  }
+  out.buf += n;
+  out.len -= n;
+
+  n = record_encode(rec, out, w->hash_size);
+  if (n < 0) {
+    goto err;
+  }
+
+  out.buf += n;
+  out.len -= n;
+
+  if (block_writer_register_restart(w, start.len - out.len, restart, key) < 0) {
+    goto err;
+  }
+
+  free(slice_yield(&key));
+  return 0;
+
+err:
+  free(slice_yield(&key));
+  return -1;
+}
+
+int block_writer_register_restart(struct block_writer *w, int n, bool restart,
+                                  struct slice key) {
+  int rlen = w->restart_len;
+  if (rlen >= MAX_RESTARTS) {
+    restart = false;
+  }
+
+  if (restart) {
+    rlen++;
+  }
+  if (2 + 3 * rlen + n > w->block_size - w->next) {
+    return -1;
+  }
+  if (restart) {
+    if (w->restart_len == w->restart_cap) {
+      w->restart_cap = w->restart_cap * 2 + 1;
+      w->restarts = realloc(w->restarts, sizeof(uint32_t) * w->restart_cap);
+    }
+
+    w->restarts[w->restart_len++] = w->next;
+  }
+
+  w->next += n;
+  slice_copy(&w->last_key, key);
+  w->entries++;
+  return 0;
+}
+
+int block_writer_finish(struct block_writer *w) {
+  for (int i = 0; i < w->restart_len; i++) {
+    put_u24(w->buf + w->next, w->restarts[i]);
+    w->next += 3;
+  }
+
+  put_u16(w->buf + w->next, w->restart_len);
+  w->next += 2;
+  put_u24(w->buf + 1 + w->header_off, w->next);
+
+  if (block_writer_type(w) == BLOCK_TYPE_LOG) {
+    int block_header_skip = 4 + w->header_off;
+    struct slice compressed = {};
+    uLongf dest_len = 0, src_len = 0;
+    slice_resize(&compressed, w->next - block_header_skip);
+
+    dest_len = compressed.len;
+    src_len = w->next - block_header_skip;
+
+    if (Z_OK != compress2(compressed.buf, &dest_len, w->buf + block_header_skip,
+                          src_len, 9)) {
+      free(slice_yield(&compressed));
+      return ZLIB_ERROR;
+    }
+    memcpy(w->buf + block_header_skip, compressed.buf, dest_len);
+    w->next = dest_len + block_header_skip;
+  }
+  return w->next;
+}
+
+byte block_reader_type(struct block_reader *r) {
+  return r->block.data[r->header_off];
+}
+
+int block_reader_init(struct block_reader *br, struct block *block,
+                      uint32_t header_off, uint32_t table_block_size,
+                      int hash_size) {
+  uint32_t full_block_size = table_block_size;
+  byte typ = block->data[header_off];
+  uint32_t sz = get_u24(block->data + header_off + 1);
+
+  if (!is_block_type(typ)) {
+    return FORMAT_ERROR;
+  }
+
+  if (typ == BLOCK_TYPE_LOG) {
+    struct slice uncompressed = {};
+    int block_header_skip = 4 + header_off;
+    uLongf dst_len = sz - block_header_skip;
+    uLongf src_len = block->len - block_header_skip;
+
+    slice_resize(&uncompressed, sz);
+    memcpy(uncompressed.buf, block->data, block_header_skip);
+
+    if (Z_OK != uncompress2(uncompressed.buf + block_header_skip, &dst_len,
+                            block->data + block_header_skip, &src_len)) {
+      free(slice_yield(&uncompressed));
+      return ZLIB_ERROR;
+    }
+
+    block_source_return_block(block->source, block);
+    block->data = uncompressed.buf;
+    block->len = dst_len; /* XXX: 4 bytes missing? */
+    block->source = malloc_block_source();
+    full_block_size = src_len + block_header_skip;
+  } else if (full_block_size == 0) {
+    full_block_size = sz;
+  } else if (sz < full_block_size && sz < block->len && block->data[sz] != 0) {
+    // If the block is smaller than the full block size,
+    // it is padded (data followed by '\0') or the next
+    // block is unaligned.
+    full_block_size = sz;
+  }
+
+  {
+    uint16_t restart_count = get_u16(block->data + sz - 2);
+    uint32_t restart_start = sz - 2 - 3 * restart_count;
+
+    byte *restart_bytes = block->data + restart_start;
+
+    // transfer ownership.
+    br->block = *block;
+    block->data = NULL;
+    block->len = 0;
+
+    br->hash_size = hash_size;
+    br->block_len = restart_start;
+    br->full_block_size = full_block_size;
+    br->header_off = header_off;
+    br->restart_count = restart_count;
+    br->restart_bytes = restart_bytes;
+  }
+
+  return 0;
+}
+
+static uint32_t block_reader_restart_offset(struct block_reader *br, int i) {
+  return get_u24(br->restart_bytes + 3 * i);
+}
+
+void block_reader_start(struct block_reader *br, struct block_iter *it) {
+  it->br = br;
+  slice_resize(&it->last_key, 0);
+  it->next_off = br->header_off + 4;
+}
+
+struct restart_find_args {
+  struct slice key;
+  struct block_reader *r;
+  int error;
+};
+
+static int restart_key_less(int idx, void *args) {
+  struct restart_find_args *a = (struct restart_find_args *)args;
+  uint32_t off = block_reader_restart_offset(a->r, idx);
+  struct slice in = {
+      .buf = a->r->block.data + off,
+      .len = a->r->block_len - off,
+  };
+
+  /* the restart key is verbatim in the block, so this could avoid the
+     alloc for decoding the key */
+  struct slice rkey = {};
+  struct slice last_key = {};
+  byte unused_extra;
+  int n = decode_key(&rkey, &unused_extra, last_key, in);
+  if (n < 0) {
+    a->error = 1;
+    return -1;
+  }
+
+  {
+    int result = slice_compare(a->key, rkey);
+    free(slice_yield(&rkey));
+    return result;
+  }
+}
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src) {
+  dest->br = src->br;
+  dest->next_off = src->next_off;
+  slice_copy(&dest->last_key, src->last_key);
+}
+
+// return < 0 for error, 0 for OK, > 0 for EOF.
+int block_iter_next(struct block_iter *it, struct record rec) {
+  if (it->next_off >= it->br->block_len) {
+    return 1;
+  }
+
+  {
+    struct slice in = {
+        .buf = it->br->block.data + it->next_off,
+        .len = it->br->block_len - it->next_off,
+    };
+    struct slice start = in;
+    struct slice key = {};
+    byte extra;
+    int n = decode_key(&key, &extra, it->last_key, in);
+    if (n < 0) {
+      return -1;
+    }
+
+    in.buf += n;
+    in.len -= n;
+    n = record_decode(rec, key, extra, in, it->br->hash_size);
+    if (n < 0) {
+      return -1;
+    }
+    in.buf += n;
+    in.len -= n;
+
+    slice_copy(&it->last_key, key);
+    it->next_off += start.len - in.len;
+    free(slice_yield(&key));
+    return 0;
+  }
+}
+
+int block_reader_first_key(struct block_reader *br, struct slice *key) {
+  struct slice empty = {};
+  int off = br->header_off + 4;
+  struct slice in = {
+      .buf = br->block.data + off,
+      .len = br->block_len - off,
+  };
+
+  byte extra = 0;
+  int n = decode_key(key, &extra, empty, in);
+  if (n < 0) {
+    return n;
+  }
+  return 0;
+}
+
+int block_iter_seek(struct block_iter *it, struct slice want) {
+  return block_reader_seek(it->br, it, want);
+}
+
+void block_iter_close(struct block_iter *it) {
+  free(slice_yield(&it->last_key));
+}
+
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+                      struct slice want) {
+  struct restart_find_args args = {
+      .key = want,
+      .r = br,
+  };
+
+  int i = binsearch(br->restart_count, &restart_key_less, &args);
+  if (args.error) {
+    return -1;
+  }
+
+  it->br = br;
+  if (i > 0) {
+    i--;
+    it->next_off = block_reader_restart_offset(br, i);
+  } else {
+    it->next_off = br->header_off + 4;
+  }
+
+  {
+    struct record rec = new_record(block_reader_type(br));
+    struct slice key = {};
+    int result = 0;
+    int err = 0;
+    struct block_iter next = {};
+    while (true) {
+      block_iter_copy_from(&next, it);
+
+      err = block_iter_next(&next, rec);
+      if (err < 0) {
+        result = -1;
+        goto exit;
+      }
+
+      record_key(rec, &key);
+      if (err > 0 || slice_compare(key, want) >= 0) {
+        result = 0;
+        goto exit;
+      }
+
+      block_iter_copy_from(it, &next);
+    }
+
+  exit:
+    free(slice_yield(&key));
+    free(slice_yield(&next.last_key));
+    record_clear(rec);
+    free(record_yield(&rec));
+
+    return result;
+  }
+}
+
+void block_writer_reset(struct block_writer *bw) {
+  bw->restart_len = 0;
+  bw->last_key.len = 0;
+}
+
+void block_writer_clear(struct block_writer *bw) {
+  free(bw->restarts);
+  bw->restarts = NULL;
+  free(slice_yield(&bw->last_key));
+  // the block is not owned.
+}
diff --git a/reftable/block.h b/reftable/block.h
new file mode 100644
index 0000000000..bc89f99aeb
--- /dev/null
+++ b/reftable/block.h
@@ -0,0 +1,71 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BLOCK_H
+#define BLOCK_H
+
+#include "basics.h"
+#include "record.h"
+#include "reftable.h"
+
+struct block_writer {
+  byte *buf;
+  uint32_t block_size;
+  uint32_t header_off;
+  int restart_interval;
+  int hash_size;
+
+  uint32_t next;
+  uint32_t *restarts;
+  uint32_t restart_len;
+  uint32_t restart_cap;
+  struct slice last_key;
+  int entries;
+};
+
+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
+                       uint32_t block_size, uint32_t header_off, int hash_size);
+byte block_writer_type(struct block_writer *bw);
+int block_writer_add(struct block_writer *w, struct record rec);
+int block_writer_finish(struct block_writer *w);
+void block_writer_reset(struct block_writer *bw);
+void block_writer_clear(struct block_writer *bw);
+
+struct block_reader {
+  uint32_t header_off;
+  struct block block;
+  int hash_size;
+
+  // size of the data, excluding restart data.
+  uint32_t block_len;
+  byte *restart_bytes;
+  uint32_t full_block_size;
+  uint16_t restart_count;
+};
+
+struct block_iter {
+  struct block_reader *br;
+  struct slice last_key;
+  uint32_t next_off;
+};
+
+int block_reader_init(struct block_reader *br, struct block *bl,
+                      uint32_t header_off, uint32_t table_block_size,
+                      int hash_size);
+void block_reader_start(struct block_reader *br, struct block_iter *it);
+int block_reader_seek(struct block_reader *br, struct block_iter *it,
+                      struct slice want);
+byte block_reader_type(struct block_reader *r);
+int block_reader_first_key(struct block_reader *br, struct slice *key);
+
+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
+int block_iter_next(struct block_iter *it, struct record rec);
+int block_iter_seek(struct block_iter *it, struct slice want);
+void block_iter_close(struct block_iter *it);
+
+#endif
diff --git a/reftable/block_test.c b/reftable/block_test.c
new file mode 100644
index 0000000000..efc3d48a83
--- /dev/null
+++ b/reftable/block_test.c
@@ -0,0 +1,145 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "block.h"
+
+#include <string.h>
+
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+
+struct binsearch_args {
+  int key;
+  int *arr;
+};
+
+static int binsearch_func(int i, void *void_args) {
+  struct binsearch_args *args = (struct binsearch_args *)void_args;
+
+  return args->key < args->arr[i];
+}
+
+void test_binsearch() {
+  int arr[] = {2, 4, 6, 8, 10};
+  int sz = ARRAYSIZE(arr);
+  struct binsearch_args args = {
+      .arr = arr,
+  };
+
+  for (int i = 1; i < 11; i++) {
+    args.key = i;
+    int res = binsearch(sz, &binsearch_func, &args);
+
+    if (res < sz) {
+      assert(args.key < arr[res]);
+      if (res > 0) {
+        assert(args.key >= arr[res - 1]);
+      }
+    } else {
+      assert(args.key == 10 || args.key == 11);
+    }
+  }
+}
+
+void test_block_read_write() {
+  const int header_off = 21;  // random
+  const int N = 30;
+  char *names[N];
+  const int block_size = 1024;
+  struct block block = {};
+  block.data = calloc(block_size, 1);
+  block.len = block_size;
+
+  struct block_writer bw = {};
+  block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size, header_off,
+                    SHA1_SIZE);
+  struct ref_record ref = {};
+  struct record rec = {};
+  record_from_ref(&rec, &ref);
+
+  for (int i = 0; i < N; i++) {
+    char name[100];
+    sprintf(name, "branch%02d", i);
+
+    byte hash[SHA1_SIZE];
+    memset(hash, i, sizeof(hash));
+
+    ref.ref_name = name;
+    ref.value = hash;
+    names[i] = strdup(name);
+    int n = block_writer_add(&bw, rec);
+    ref.ref_name = NULL;
+    ref.value = NULL;
+    assert(n == 0);
+  }
+
+  int n = block_writer_finish(&bw);
+  assert(n > 0);
+
+  block_writer_clear(&bw);
+
+  struct block_reader br = {};
+  block_reader_init(&br, &block, header_off, block_size, SHA1_SIZE);
+
+  struct block_iter it = {};
+  block_reader_start(&br, &it);
+
+  int j = 0;
+  while (true) {
+    int r = block_iter_next(&it, rec);
+    assert(r >= 0);
+    if (r > 0) {
+      break;
+    }
+    assert_streq(names[j], ref.ref_name);
+    j++;
+  }
+
+  record_clear(rec);
+  block_iter_close(&it);
+
+  struct slice want = {};
+  for (int i = 0; i < N; i++) {
+    slice_set_string(&want, names[i]);
+
+    struct block_iter it = {};
+    int n = block_reader_seek(&br, &it, want);
+    assert(n == 0);
+
+    n = block_iter_next(&it, rec);
+    assert(n == 0);
+
+    assert_streq(names[i], ref.ref_name);
+
+    want.len--;
+    n = block_reader_seek(&br, &it, want);
+    assert(n == 0);
+
+    n = block_iter_next(&it, rec);
+    assert(n == 0);
+    assert_streq(names[10 * (i / 10)], ref.ref_name);
+
+    block_iter_close(&it);
+  }
+
+  record_clear(rec);
+  free(block.data);
+  free(slice_yield(&want));
+  for (int i = 0; i < N; i++) {
+    free(names[i]);
+  }
+}
+
+int main() {
+  add_test_case("binsearch", &test_binsearch);
+  add_test_case("block_read_write", &test_block_read_write);
+  test_main();
+}
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
new file mode 100644
index 0000000000..269b3f2e7e
--- /dev/null
+++ b/reftable/blocksource.h
@@ -0,0 +1,20 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef BLOCKSOURCE_H
+#define BLOCKSOURCE_H
+
+#include "reftable.h"
+
+uint64_t block_source_size(struct block_source source);
+int block_source_read_block(struct block_source source, struct block *dest,
+                            uint64_t off, uint32_t size);
+void block_source_return_block(struct block_source source, struct block *ret);
+void block_source_close(struct block_source source);
+
+#endif
diff --git a/reftable/bytes.c b/reftable/bytes.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/reftable/constants.h b/reftable/constants.h
new file mode 100644
index 0000000000..cd35704610
--- /dev/null
+++ b/reftable/constants.h
@@ -0,0 +1,27 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef CONSTANTS_H
+#define CONSTANTS_H
+
+#define SHA1_SIZE 20
+#define SHA256_SIZE 32
+#define VERSION 1
+#define HEADER_SIZE 24
+#define FOOTER_SIZE 68
+
+#define BLOCK_TYPE_LOG 'g'
+#define BLOCK_TYPE_INDEX 'i'
+#define BLOCK_TYPE_REF 'r'
+#define BLOCK_TYPE_OBJ 'o'
+#define BLOCK_TYPE_ANY 0
+
+#define MAX_RESTARTS ((1 << 16) - 1)
+#define DEFAULT_BLOCK_SIZE 4096
+
+#endif
diff --git a/reftable/dump.c b/reftable/dump.c
new file mode 100644
index 0000000000..2eed81ab90
--- /dev/null
+++ b/reftable/dump.c
@@ -0,0 +1,102 @@
+// Copyright 2020 Google Inc. All rights reserved.
+//
+// Licensed under the Apache License, Version 2.0 (the "License");
+// you may not use this file except in compliance with the License.
+// You may obtain a copy of the License at
+//
+//    http://www.apache.org/licenses/LICENSE-2.0
+//
+// Unless required by applicable law or agreed to in writing, software
+// distributed under the License is distributed on an "AS IS" BASIS,
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+// See the License for the specific language governing permissions and
+// limitations under the License.
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "reftable.h"
+
+static int dump_table(const char *tablename) {
+  struct block_source src = {};
+  int err = block_source_from_file(&src, tablename);
+  if (err < 0) {
+    return err;
+  }
+
+  struct reader *r = NULL;
+  err = new_reader(&r, src, tablename);
+  if (err < 0) {
+    return err;
+  }
+
+  {
+    struct iterator it = {};
+    err = reader_seek_ref(r, &it, "");
+    if (err < 0) {
+      return err;
+    }
+
+    struct ref_record ref = {};
+    while (1) {
+      err = iterator_next_ref(it, &ref);
+      if (err > 0) {
+        break;
+      }
+      if (err < 0) {
+        return err;
+      }
+      ref_record_print(&ref, 20);
+    }
+    iterator_destroy(&it);
+    ref_record_clear(&ref);
+  }
+
+  {
+    struct iterator it = {};
+    err = reader_seek_log(r, &it, "");
+    if (err < 0) {
+      return err;
+    }
+    struct log_record log = {};
+    while (1) {
+      err = iterator_next_log(it, &log);
+      if (err > 0) {
+        break;
+      }
+      if (err < 0) {
+        return err;
+      }
+      log_record_print(&log, 20);
+    }
+    iterator_destroy(&it);
+    log_record_clear(&log);
+  }
+  return 0;
+}
+
+int main(int argc, char *argv[]) {
+  int opt;
+  const char *table = NULL;
+  while ((opt = getopt(argc, argv, "t:")) != -1) {
+    switch (opt) {
+      case 't':
+        table = strdup(optarg);
+        break;
+      case '?':
+        printf("usage: %s [-table tablefile]\n", argv[0]);
+        return 2;
+        break;
+    }
+  }
+
+  if (table != NULL) {
+    int err = dump_table(table);
+    if (err < 0) {
+      fprintf(stderr, "%s: %s: %s\n", argv[0], table, error_str(err));
+      return 1;
+    }
+  }
+  return 0;
+}
diff --git a/reftable/file.c b/reftable/file.c
new file mode 100644
index 0000000000..358cd3332e
--- /dev/null
+++ b/reftable/file.c
@@ -0,0 +1,98 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "block.h"
+#include "iter.h"
+#include "record.h"
+#include "reftable.h"
+#include "tree.h"
+
+struct file_block_source {
+  int fd;
+  uint64_t size;
+};
+
+static uint64_t file_size(void *b) {
+  return ((struct file_block_source *)b)->size;
+}
+
+static void file_return_block(void *b, struct block *dest) {
+  memset(dest->data, 0xff, dest->len);
+  free(dest->data);
+}
+
+static void file_close(void *b) {
+  int fd = ((struct file_block_source *)b)->fd;
+  if (fd > 0) {
+    close(fd);
+    ((struct file_block_source *)b)->fd = 0;
+  }
+
+  free(b);
+}
+
+static int file_read_block(void *v, struct block *dest, uint64_t off,
+                           uint32_t size) {
+  struct file_block_source *b = (struct file_block_source *)v;
+  assert(off + size <= b->size);
+  dest->data = malloc(size);
+  if (pread(b->fd, dest->data, size, off) != size) {
+    return -1;
+  }
+  dest->len = size;
+  return size;
+}
+
+struct block_source_vtable file_vtable = {
+    .size = &file_size,
+    .read_block = &file_read_block,
+    .return_block = &file_return_block,
+    .close = &file_close,
+};
+
+int block_source_from_file(struct block_source *bs, const char *name) {
+  struct stat st = {};
+  int err = 0;
+  int fd = open(name, O_RDONLY);
+  if (fd < 0) {
+    if (errno == ENOENT) {
+      return NOT_EXIST_ERROR;
+    }
+    return -1;
+  }
+
+  err = fstat(fd, &st);
+  if (err < 0) {
+    return -1;
+  }
+
+  {
+    struct file_block_source *p = calloc(sizeof(struct file_block_source), 1);
+    p->size = st.st_size;
+    p->fd = fd;
+
+    bs->ops = &file_vtable;
+    bs->arg = p;
+  }
+  return 0;
+}
+
+int fd_writer(void *arg, byte *data, int sz) {
+  int *fdp = (int *)arg;
+  return write(*fdp, data, sz);
+}
diff --git a/reftable/iter.c b/reftable/iter.c
new file mode 100644
index 0000000000..12fb7ed48a
--- /dev/null
+++ b/reftable/iter.c
@@ -0,0 +1,211 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "iter.h"
+
+#include <stdlib.h>
+#include <string.h>
+
+#include "block.h"
+#include "constants.h"
+#include "reader.h"
+#include "reftable.h"
+
+bool iterator_is_null(struct iterator it) { return it.ops == NULL; }
+
+static int empty_iterator_next(void *arg, struct record rec) { return 1; }
+
+static void empty_iterator_close(void *arg) {}
+
+struct iterator_vtable empty_vtable = {
+    .next = &empty_iterator_next,
+    .close = &empty_iterator_close,
+};
+
+void iterator_set_empty(struct iterator *it) {
+  it->iter_arg = NULL;
+  it->ops = &empty_vtable;
+}
+
+int iterator_next(struct iterator it, struct record rec) {
+  return it.ops->next(it.iter_arg, rec);
+}
+
+void iterator_destroy(struct iterator *it) {
+  if (it->ops == NULL) {
+    return;
+  }
+  it->ops->close(it->iter_arg);
+  it->ops = NULL;
+  free(it->iter_arg);
+  it->iter_arg = NULL;
+}
+
+int iterator_next_ref(struct iterator it, struct ref_record *ref) {
+  struct record rec = {};
+  record_from_ref(&rec, ref);
+  return iterator_next(it, rec);
+}
+
+int iterator_next_log(struct iterator it, struct log_record *log) {
+  struct record rec = {};
+  record_from_log(&rec, log);
+  return iterator_next(it, rec);
+}
+
+static void filtering_ref_iterator_close(void *iter_arg) {
+  struct filtering_ref_iterator *fri =
+      (struct filtering_ref_iterator *)iter_arg;
+  free(slice_yield(&fri->oid));
+  iterator_destroy(&fri->it);
+}
+
+static int filtering_ref_iterator_next(void *iter_arg, struct record rec) {
+  struct filtering_ref_iterator *fri =
+      (struct filtering_ref_iterator *)iter_arg;
+  struct ref_record *ref = (struct ref_record *)rec.data;
+
+  while (true) {
+    int err = iterator_next_ref(fri->it, ref);
+    if (err != 0) {
+      return err;
+    }
+
+    if (fri->double_check) {
+      struct iterator it = {};
+
+      int err = reader_seek_ref(fri->r, &it, ref->ref_name);
+      if (err == 0) {
+        err = iterator_next_ref(it, ref);
+      }
+
+      iterator_destroy(&it);
+
+      if (err < 0) {
+        return err;
+      }
+
+      if (err > 0) {
+        continue;
+      }
+    }
+
+    if ((ref->target_value != NULL &&
+         0 == memcmp(fri->oid.buf, ref->target_value, fri->oid.len)) ||
+        (ref->value != NULL &&
+         0 == memcmp(fri->oid.buf, ref->value, fri->oid.len))) {
+      return 0;
+    }
+  }
+}
+
+struct iterator_vtable filtering_ref_iterator_vtable = {
+    .next = &filtering_ref_iterator_next,
+    .close = &filtering_ref_iterator_close,
+};
+
+void iterator_from_filtering_ref_iterator(struct iterator *it,
+                                          struct filtering_ref_iterator *fri) {
+  it->iter_arg = fri;
+  it->ops = &filtering_ref_iterator_vtable;
+}
+
+static void indexed_table_ref_iter_close(void *p) {
+  struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+  block_iter_close(&it->cur);
+  reader_return_block(it->r, &it->block_reader.block);
+  free(slice_yield(&it->oid));
+}
+
+static int indexed_table_ref_iter_next_block(
+    struct indexed_table_ref_iter *it) {
+  if (it->offset_idx == it->offset_len) {
+    it->finished = true;
+    return 1;
+  }
+
+  reader_return_block(it->r, &it->block_reader.block);
+
+  {
+    uint64_t off = it->offsets[it->offset_idx++];
+    int err =
+        reader_init_block_reader(it->r, &it->block_reader, off, BLOCK_TYPE_REF);
+    if (err < 0) {
+      return err;
+    }
+    if (err > 0) {
+      // indexed block does not exist.
+      return FORMAT_ERROR;
+    }
+  }
+  block_reader_start(&it->block_reader, &it->cur);
+  return 0;
+}
+
+static int indexed_table_ref_iter_next(void *p, struct record rec) {
+  struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
+  struct ref_record *ref = (struct ref_record *)rec.data;
+
+  while (true) {
+    int err = block_iter_next(&it->cur, rec);
+    if (err < 0) {
+      return err;
+    }
+
+    if (err > 0) {
+      err = indexed_table_ref_iter_next_block(it);
+      if (err < 0) {
+        return err;
+      }
+
+      if (it->finished) {
+        return 1;
+      }
+      continue;
+    }
+
+    if (0 == memcmp(it->oid.buf, ref->target_value, it->oid.len) ||
+        0 == memcmp(it->oid.buf, ref->value, it->oid.len)) {
+      return 0;
+    }
+  }
+}
+
+int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+                               struct reader *r, byte *oid, int oid_len,
+                               uint64_t *offsets, int offset_len) {
+  struct indexed_table_ref_iter *itr =
+      calloc(sizeof(struct indexed_table_ref_iter), 1);
+  int err = 0;
+
+  itr->r = r;
+  slice_resize(&itr->oid, oid_len);
+  memcpy(itr->oid.buf, oid, oid_len);
+
+  itr->offsets = offsets;
+  itr->offset_len = offset_len;
+
+  err = indexed_table_ref_iter_next_block(itr);
+  if (err < 0) {
+    free(itr);
+  } else {
+    *dest = itr;
+  }
+  return err;
+}
+
+struct iterator_vtable indexed_table_ref_iter_vtable = {
+    .next = &indexed_table_ref_iter_next,
+    .close = &indexed_table_ref_iter_close,
+};
+
+void iterator_from_indexed_table_ref_iter(struct iterator *it,
+                                          struct indexed_table_ref_iter *itr) {
+  it->iter_arg = itr;
+  it->ops = &indexed_table_ref_iter_vtable;
+}
diff --git a/reftable/iter.h b/reftable/iter.h
new file mode 100644
index 0000000000..2590618a06
--- /dev/null
+++ b/reftable/iter.h
@@ -0,0 +1,56 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef ITER_H
+#define ITER_H
+
+#include "block.h"
+#include "record.h"
+#include "slice.h"
+
+struct iterator_vtable {
+  int (*next)(void *iter_arg, struct record rec);
+  void (*close)(void *iter_arg);
+};
+
+void iterator_set_empty(struct iterator *it);
+int iterator_next(struct iterator it, struct record rec);
+bool iterator_is_null(struct iterator it);
+
+struct filtering_ref_iterator {
+  struct reader *r;
+  struct slice oid;
+  bool double_check;
+  struct iterator it;
+};
+
+void iterator_from_filtering_ref_iterator(struct iterator *,
+                                          struct filtering_ref_iterator *);
+
+struct indexed_table_ref_iter {
+  struct reader *r;
+  struct slice oid;
+
+  // mutable
+  uint64_t *offsets;
+
+  // Points to the next offset to read.
+  int offset_idx;
+  int offset_len;
+  struct block_reader block_reader;
+  struct block_iter cur;
+  bool finished;
+};
+
+void iterator_from_indexed_table_ref_iter(struct iterator *it,
+                                          struct indexed_table_ref_iter *itr);
+int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+                               struct reader *r, byte *oid, int oid_len,
+                               uint64_t *offsets, int offset_len);
+
+#endif
diff --git a/reftable/merged.c b/reftable/merged.c
new file mode 100644
index 0000000000..baf0997647
--- /dev/null
+++ b/reftable/merged.c
@@ -0,0 +1,262 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "merged.h"
+
+#include <stdlib.h>
+
+#include "constants.h"
+#include "iter.h"
+#include "pq.h"
+#include "reader.h"
+
+static int merged_iter_init(struct merged_iter *mi) {
+  for (int i = 0; i < mi->stack_len; i++) {
+    struct record rec = new_record(mi->typ);
+    int err = iterator_next(mi->stack[i], rec);
+    if (err < 0) {
+      return err;
+    }
+
+    if (err > 0) {
+      iterator_destroy(&mi->stack[i]);
+      record_clear(rec);
+      free(record_yield(&rec));
+    } else {
+      struct pq_entry e = {
+          .rec = rec,
+          .index = i,
+      };
+      merged_iter_pqueue_add(&mi->pq, e);
+    }
+  }
+
+  return 0;
+}
+
+static void merged_iter_close(void *p) {
+  struct merged_iter *mi = (struct merged_iter *)p;
+  merged_iter_pqueue_clear(&mi->pq);
+  for (int i = 0; i < mi->stack_len; i++) {
+    iterator_destroy(&mi->stack[i]);
+  }
+  free(mi->stack);
+}
+
+static int merged_iter_advance_subiter(struct merged_iter *mi, int idx) {
+  if (iterator_is_null(mi->stack[idx])) {
+    return 0;
+  }
+
+  {
+    struct record rec = new_record(mi->typ);
+    struct pq_entry e = {
+        .rec = rec,
+        .index = idx,
+    };
+    int err = iterator_next(mi->stack[idx], rec);
+    if (err < 0) {
+      return err;
+    }
+
+    if (err > 0) {
+      iterator_destroy(&mi->stack[idx]);
+      record_clear(rec);
+      free(record_yield(&rec));
+      return 0;
+    }
+
+    merged_iter_pqueue_add(&mi->pq, e);
+  }
+  return 0;
+}
+
+static int merged_iter_next(struct merged_iter *mi, struct record rec) {
+  struct slice entry_key = {};
+  struct pq_entry entry = merged_iter_pqueue_remove(&mi->pq);
+  int err = merged_iter_advance_subiter(mi, entry.index);
+  if (err < 0) {
+    return err;
+  }
+
+  record_key(entry.rec, &entry_key);
+  while (!merged_iter_pqueue_is_empty(mi->pq)) {
+    struct pq_entry top = merged_iter_pqueue_top(mi->pq);
+    struct slice k = {};
+    int err = 0, cmp = 0;
+
+    record_key(top.rec, &k);
+
+    cmp = slice_compare(k, entry_key);
+    free(slice_yield(&k));
+
+    if (cmp > 0) {
+      break;
+    }
+
+    merged_iter_pqueue_remove(&mi->pq);
+    err = merged_iter_advance_subiter(mi, top.index);
+    if (err < 0) {
+      return err;
+    }
+    record_clear(top.rec);
+    free(record_yield(&top.rec));
+  }
+
+  record_copy_from(rec, entry.rec, mi->hash_size);
+  record_clear(entry.rec);
+  free(record_yield(&entry.rec));
+  free(slice_yield(&entry_key));
+  return 0;
+}
+
+static int merged_iter_next_void(void *p, struct record rec) {
+  struct merged_iter *mi = (struct merged_iter *)p;
+  if (merged_iter_pqueue_is_empty(mi->pq)) {
+    return 1;
+  }
+
+  return merged_iter_next(mi, rec);
+}
+
+struct iterator_vtable merged_iter_vtable = {
+    .next = &merged_iter_next_void,
+    .close = &merged_iter_close,
+};
+
+static void iterator_from_merged_iter(struct iterator *it,
+                                      struct merged_iter *mi) {
+  it->iter_arg = mi;
+  it->ops = &merged_iter_vtable;
+}
+
+int new_merged_table(struct merged_table **dest, struct reader **stack, int n) {
+  uint64_t last_max = 0;
+  uint64_t first_min = 0;
+  for (int i = 0; i < n; i++) {
+    struct reader *r = stack[i];
+    if (i > 0 && last_max >= reader_min_update_index(r)) {
+      return FORMAT_ERROR;
+    }
+    if (i == 0) {
+      first_min = reader_min_update_index(r);
+    }
+
+    last_max = reader_max_update_index(r);
+  }
+
+  {
+    struct merged_table m = {
+        .stack = stack,
+        .stack_len = n,
+        .min = first_min,
+        .max = last_max,
+        .hash_size = SHA1_SIZE,
+    };
+
+    *dest = calloc(sizeof(struct merged_table), 1);
+    **dest = m;
+  }
+  return 0;
+}
+
+void merged_table_close(struct merged_table *mt) {
+  for (int i = 0; i < mt->stack_len; i++) {
+    reader_free(mt->stack[i]);
+  }
+  free(mt->stack);
+  mt->stack = NULL;
+  mt->stack_len = 0;
+}
+
+/* clears the list of subtable, without affecting the readers themselves. */
+void merged_table_clear(struct merged_table *mt) {
+  free(mt->stack);
+  mt->stack = NULL;
+  mt->stack_len = 0;
+}
+
+void merged_table_free(struct merged_table *mt) {
+  if (mt == NULL) {
+    return;
+  }
+  merged_table_clear(mt);
+  free(mt);
+}
+
+uint64_t merged_max_update_index(struct merged_table *mt) { return mt->max; }
+
+uint64_t merged_min_update_index(struct merged_table *mt) { return mt->min; }
+
+static int merged_table_seek_record(struct merged_table *mt,
+                                    struct iterator *it, struct record rec) {
+  struct iterator *iters = calloc(sizeof(struct iterator), mt->stack_len);
+  struct merged_iter merged = {
+      .stack = iters,
+      .typ = record_type(rec),
+      .hash_size = mt->hash_size,
+  };
+  int n = 0;
+  int err = 0;
+  for (int i = 0; i < mt->stack_len && err == 0; i++) {
+    int e = reader_seek(mt->stack[i], &iters[n], rec);
+    if (e < 0) {
+      err = e;
+    }
+    if (e == 0) {
+      n++;
+    }
+  }
+  if (err < 0) {
+    for (int i = 0; i < n; i++) {
+      iterator_destroy(&iters[i]);
+    }
+    free(iters);
+    return err;
+  }
+
+  merged.stack_len = n, err = merged_iter_init(&merged);
+  if (err < 0) {
+    merged_iter_close(&merged);
+    return err;
+  }
+
+  {
+    struct merged_iter *p = malloc(sizeof(struct merged_iter));
+    *p = merged;
+    iterator_from_merged_iter(it, p);
+  }
+  return 0;
+}
+
+int merged_table_seek_ref(struct merged_table *mt, struct iterator *it,
+                          const char *name) {
+  struct ref_record ref = {
+      .ref_name = (char *)name,
+  };
+  struct record rec = {};
+  record_from_ref(&rec, &ref);
+  return merged_table_seek_record(mt, it, rec);
+}
+
+int merged_table_seek_log_at(struct merged_table *mt, struct iterator *it,
+                             const char *name, uint64_t update_index) {
+  struct log_record log = {
+      .ref_name = (char *)name,
+      .update_index = update_index,
+  };
+  struct record rec = {};
+  record_from_log(&rec, &log);
+  return merged_table_seek_record(mt, it, rec);
+}
+
+int merged_table_seek_log(struct merged_table *mt, struct iterator *it,
+                          const char *name) {
+  uint64_t max = ~((uint64_t)0);
+  return merged_table_seek_log_at(mt, it, name, max);
+}
diff --git a/reftable/merged.h b/reftable/merged.h
new file mode 100644
index 0000000000..d9d7c7dc19
--- /dev/null
+++ b/reftable/merged.h
@@ -0,0 +1,34 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef MERGED_H
+#define MERGED_H
+
+#include "pq.h"
+#include "reftable.h"
+
+struct merged_table {
+  struct reader **stack;
+  int stack_len;
+  int hash_size;
+
+  uint64_t min;
+  uint64_t max;
+};
+
+struct merged_iter {
+  struct iterator *stack;
+  int hash_size;
+  int stack_len;
+  byte typ;
+  struct merged_iter_pqueue pq;
+} merged_iter;
+
+void merged_table_clear(struct merged_table *mt);
+
+#endif
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
new file mode 100644
index 0000000000..81edc86a57
--- /dev/null
+++ b/reftable/merged_test.c
@@ -0,0 +1,247 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "merged.h"
+
+#include <string.h>
+
+#include "basics.h"
+#include "block.h"
+#include "constants.h"
+#include "pq.h"
+#include "reader.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+
+void test_pq(void) {
+  char *names[54] = {};
+  int N = ARRAYSIZE(names) - 1;
+
+  for (int i = 0; i < N; i++) {
+    char name[100];
+    sprintf(name, "%02d", i);
+    names[i] = strdup(name);
+  }
+
+  struct merged_iter_pqueue pq = {};
+
+  int i = 1;
+  do {
+    struct record rec = new_record(BLOCK_TYPE_REF);
+    record_as_ref(rec)->ref_name = names[i];
+
+    struct pq_entry e = {
+        .rec = rec,
+    };
+    merged_iter_pqueue_add(&pq, e);
+    merged_iter_pqueue_check(pq);
+    i = (i * 7) % N;
+  } while (i != 1);
+
+  const char *last = NULL;
+  while (!merged_iter_pqueue_is_empty(pq)) {
+    struct pq_entry e = merged_iter_pqueue_remove(&pq);
+    merged_iter_pqueue_check(pq);
+    struct ref_record *ref = record_as_ref(e.rec);
+
+    if (last != NULL) {
+      assert(strcmp(last, ref->ref_name) < 0);
+    }
+    last = ref->ref_name;
+    ref->ref_name = NULL;
+    free(ref);
+  }
+
+  for (int i = 0; i < N; i++) {
+    free(names[i]);
+  }
+
+  merged_iter_pqueue_clear(&pq);
+}
+
+void write_test_table(struct slice *buf, struct ref_record refs[], int n) {
+  int min = 0xffffffff;
+  int max = 0;
+  for (int i = 0; i < n; i++) {
+    uint64_t ui = refs[i].update_index;
+    if (ui > max) {
+      max = ui;
+    }
+    if (ui < min) {
+      min = ui;
+    }
+  }
+
+  struct write_options opts = {
+      .block_size = 256,
+  };
+
+  struct writer *w = new_writer(&slice_write_void, buf, &opts);
+  writer_set_limits(w, min, max);
+
+  for (int i = 0; i < n; i++) {
+    uint64_t before = refs[i].update_index;
+    int n = writer_add_ref(w, &refs[i]);
+    assert(n == 0);
+    assert(before == refs[i].update_index);
+  }
+
+  int err = writer_close(w);
+  assert(err == 0);
+
+  writer_free(w);
+  w = NULL;
+}
+
+static struct merged_table *merged_table_from_records(struct ref_record **refs,
+                                                      int *sizes,
+                                                      struct slice *buf,
+                                                      int n) {
+  struct block_source *source = calloc(n, sizeof(*source));
+  struct reader **rd = calloc(n, sizeof(*rd));
+  for (int i = 0; i < n; i++) {
+    write_test_table(&buf[i], refs[i], sizes[i]);
+    block_source_from_slice(&source[i], &buf[i]);
+
+    int err = new_reader(&rd[i], source[i], "name");
+    assert(err == 0);
+  }
+
+  struct merged_table *mt = NULL;
+  int err = new_merged_table(&mt, rd, n);
+  assert(err == 0);
+  return mt;
+}
+
+void test_merged_between(void) {
+  byte hash1[SHA1_SIZE];
+  byte hash2[SHA1_SIZE];
+
+  set_test_hash(hash1, 1);
+  set_test_hash(hash2, 2);
+  struct ref_record r1[] = {{
+      .ref_name = "b",
+      .update_index = 1,
+      .value = hash1,
+  }};
+  struct ref_record r2[] = {{
+      .ref_name = "a",
+      .update_index = 2,
+  }};
+
+  struct ref_record *refs[] = {r1, r2};
+  int sizes[] = {1, 1};
+  struct slice bufs[2] = {};
+  struct merged_table *mt = merged_table_from_records(refs, sizes, bufs, 2);
+
+  struct iterator it = {};
+  int err = merged_table_seek_ref(mt, &it, "a");
+  assert(err == 0);
+
+  struct ref_record ref = {};
+  err = iterator_next_ref(it, &ref);
+  assert_err(err);
+  assert(ref.update_index == 2);
+}
+
+void test_merged(void) {
+  byte hash1[SHA1_SIZE];
+  byte hash2[SHA1_SIZE];
+
+  set_test_hash(hash1, 1);
+  set_test_hash(hash2, 2);
+  struct ref_record r1[] = {{
+                                .ref_name = "a",
+                                .update_index = 1,
+                                .value = hash1,
+                            },
+                            {
+                                .ref_name = "b",
+                                .update_index = 1,
+                                .value = hash1,
+                            },
+                            {
+                                .ref_name = "c",
+                                .update_index = 1,
+                                .value = hash1,
+                            }};
+  struct ref_record r2[] = {{
+      .ref_name = "a",
+      .update_index = 2,
+  }};
+  struct ref_record r3[] = {
+      {
+          .ref_name = "c",
+          .update_index = 3,
+          .value = hash2,
+      },
+      {
+          .ref_name = "d",
+          .update_index = 3,
+          .value = hash1,
+      },
+  };
+
+  struct ref_record *refs[] = {r1, r2, r3};
+  int sizes[3] = {3, 1, 2};
+  struct slice bufs[3] = {};
+
+  struct merged_table *mt = merged_table_from_records(refs, sizes, bufs, 3);
+
+  struct iterator it = {};
+  int err = merged_table_seek_ref(mt, &it, "a");
+  assert(err == 0);
+
+  struct ref_record *out = NULL;
+  int len = 0;
+  int cap = 0;
+  while (len < 100) {  // cap loops/recursion.
+    struct ref_record ref = {};
+    int err = iterator_next_ref(it, &ref);
+    if (err > 0) {
+      break;
+    }
+    if (len == cap) {
+      cap = 2 * cap + 1;
+      out = realloc(out, sizeof(struct ref_record) * cap);
+    }
+    out[len++] = ref;
+  }
+  iterator_destroy(&it);
+
+  struct ref_record want[] = {
+      r2[0],
+      r1[1],
+      r3[0],
+      r3[1],
+  };
+  assert(ARRAYSIZE(want) == len);
+  for (int i = 0; i < len; i++) {
+    assert(ref_record_equal(&want[i], &out[i], SHA1_SIZE));
+  }
+  for (int i = 0; i < len; i++) {
+    ref_record_clear(&out[i]);
+  }
+  free(out);
+
+  for (int i = 0; i < 3; i++) {
+    free(slice_yield(&bufs[i]));
+  }
+  merged_table_close(mt);
+  merged_table_free(mt);
+}
+
+// XXX test refs_for(oid)
+
+int main() {
+  add_test_case("test_merged_between", &test_merged_between);
+  add_test_case("test_pq", &test_pq);
+  add_test_case("test_merged", &test_merged);
+  test_main();
+}
diff --git a/reftable/pq.c b/reftable/pq.c
new file mode 100644
index 0000000000..3ea2f1bb3b
--- /dev/null
+++ b/reftable/pq.c
@@ -0,0 +1,116 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "pq.h"
+
+#include <assert.h>
+#include <stdlib.h>
+
+int pq_less(struct pq_entry a, struct pq_entry b) {
+  struct slice ak = {};
+  struct slice bk = {};
+  int cmp = 0;
+  record_key(a.rec, &ak);
+  record_key(b.rec, &bk);
+
+  cmp = slice_compare(ak, bk);
+
+  free(slice_yield(&ak));
+  free(slice_yield(&bk));
+
+  if (cmp == 0) {
+    return a.index > b.index;
+  }
+
+  return cmp < 0;
+}
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq) {
+  return pq.heap[0];
+}
+
+bool merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq) {
+  return pq.len == 0;
+}
+
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq) {
+  for (int i = 1; i < pq.len; i++) {
+    int parent = (i - 1) / 2;
+
+    assert(pq_less(pq.heap[parent], pq.heap[i]));
+  }
+}
+
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq) {
+  int i = 0;
+  struct pq_entry e = pq->heap[0];
+  pq->heap[0] = pq->heap[pq->len - 1];
+  pq->len--;
+
+  i = 0;
+  while (i < pq->len) {
+    int min = i;
+    int j = 2 * i + 1;
+    int k = 2 * i + 2;
+    if (j < pq->len && pq_less(pq->heap[j], pq->heap[i])) {
+      min = j;
+    }
+    if (k < pq->len && pq_less(pq->heap[k], pq->heap[min])) {
+      min = k;
+    }
+
+    if (min == i) {
+      break;
+    }
+
+    {
+      struct pq_entry tmp = pq->heap[min];
+      pq->heap[min] = pq->heap[i];
+      pq->heap[i] = tmp;
+    }
+
+    i = min;
+  }
+
+  return e;
+}
+
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e) {
+  int i = 0;
+  if (pq->len == pq->cap) {
+    pq->cap = 2 * pq->cap + 1;
+    pq->heap = realloc(pq->heap, pq->cap * sizeof(struct pq_entry));
+  }
+
+  pq->heap[pq->len++] = e;
+  i = pq->len - 1;
+  while (i > 0) {
+    int j = (i - 1) / 2;
+    if (pq_less(pq->heap[j], pq->heap[i])) {
+      break;
+    }
+
+    {
+      struct pq_entry tmp = pq->heap[j];
+      pq->heap[j] = pq->heap[i];
+      pq->heap[i] = tmp;
+    }
+
+    i = j;
+  }
+}
+
+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq) {
+  for (int i = 0; i < pq->len; i++) {
+    record_clear(pq->heap[i].rec);
+    free(record_yield(&pq->heap[i].rec));
+  }
+  free(pq->heap);
+  pq->heap = NULL;
+  pq->len = pq->cap = 0;
+}
diff --git a/reftable/pq.h b/reftable/pq.h
new file mode 100644
index 0000000000..c323da76cb
--- /dev/null
+++ b/reftable/pq.h
@@ -0,0 +1,34 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef PQ_H
+#define PQ_H
+
+#include "record.h"
+
+struct pq_entry {
+  struct record rec;
+  int index;
+};
+
+int pq_less(struct pq_entry a, struct pq_entry b);
+
+struct merged_iter_pqueue {
+  struct pq_entry *heap;
+  int len;
+  int cap;
+};
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
+bool merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq);
+
+#endif
diff --git a/reftable/reader.c b/reftable/reader.c
new file mode 100644
index 0000000000..fd4800dcd6
--- /dev/null
+++ b/reftable/reader.c
@@ -0,0 +1,672 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reader.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <zlib.h>
+
+#include "block.h"
+#include "constants.h"
+#include "iter.h"
+#include "record.h"
+#include "reftable.h"
+#include "tree.h"
+
+uint64_t block_source_size(struct block_source source) {
+  return source.ops->size(source.arg);
+}
+
+int block_source_read_block(struct block_source source, struct block *dest,
+                            uint64_t off, uint32_t size) {
+  int result = source.ops->read_block(source.arg, dest, off, size);
+  dest->source = source;
+  return result;
+}
+
+void block_source_return_block(struct block_source source,
+                               struct block *blockp) {
+  source.ops->return_block(source.arg, blockp);
+  blockp->data = NULL;
+  blockp->len = 0;
+  blockp->source.ops = NULL;
+  blockp->source.arg = NULL;
+}
+
+void block_source_close(struct block_source *source) {
+  if (source->ops == NULL) {
+    return;
+  }
+
+  source->ops->close(source->arg);
+  source->ops = NULL;
+}
+
+static struct reader_offsets *reader_offsets_for(struct reader *r, byte typ) {
+  switch (typ) {
+    case BLOCK_TYPE_REF:
+      return &r->ref_offsets;
+    case BLOCK_TYPE_LOG:
+      return &r->log_offsets;
+    case BLOCK_TYPE_OBJ:
+      return &r->obj_offsets;
+  }
+  abort();
+}
+
+static int reader_get_block(struct reader *r, struct block *dest, uint64_t off,
+                            uint32_t sz) {
+  if (off >= r->size) {
+    return 0;
+  }
+
+  if (off + sz > r->size) {
+    sz = r->size - off;
+  }
+
+  return block_source_read_block(r->source, dest, off, sz);
+}
+
+void reader_return_block(struct reader *r, struct block *p) {
+  block_source_return_block(r->source, p);
+}
+
+const char *reader_name(struct reader *r) { return r->name; }
+
+static int parse_footer(struct reader *r, byte *footer, byte *header) {
+  byte *f = footer;
+  int err = 0;
+  if (memcmp(f, "REFT", 4)) {
+    err = FORMAT_ERROR;
+    goto exit;
+  }
+  f += 4;
+
+  if (0 != memcmp(footer, header, HEADER_SIZE)) {
+    err = FORMAT_ERROR;
+    goto exit;
+  }
+
+  {
+    byte version = *f++;
+    if (version != 1) {
+      err = FORMAT_ERROR;
+      goto exit;
+    }
+  }
+
+  r->block_size = get_u24(f);
+
+  f += 3;
+  r->min_update_index = get_u64(f);
+  f += 8;
+  r->max_update_index = get_u64(f);
+  f += 8;
+
+  r->ref_offsets.index_offset = get_u64(f);
+  f += 8;
+
+  r->obj_offsets.offset = get_u64(f);
+  f += 8;
+
+  r->object_id_len = r->obj_offsets.offset & ((1 << 5) - 1);
+  r->obj_offsets.offset >>= 5;
+
+  r->obj_offsets.index_offset = get_u64(f);
+  f += 8;
+  r->log_offsets.offset = get_u64(f);
+  f += 8;
+  r->log_offsets.index_offset = get_u64(f);
+  f += 8;
+
+  {
+    uint32_t computed_crc = crc32(0, footer, f - footer);
+    uint32_t file_crc = get_u32(f);
+    f += 4;
+    if (computed_crc != file_crc) {
+      err = FORMAT_ERROR;
+      goto exit;
+    }
+  }
+
+  {
+    byte first_block_typ = header[HEADER_SIZE];
+    r->ref_offsets.present = (first_block_typ == BLOCK_TYPE_REF);
+    r->ref_offsets.offset = 0;
+    r->log_offsets.present =
+        (first_block_typ == BLOCK_TYPE_LOG || r->log_offsets.offset > 0);
+    r->obj_offsets.present = r->obj_offsets.offset > 0;
+  }
+  err = 0;
+exit:
+  return err;
+}
+
+int init_reader(struct reader *r, struct block_source source,
+                const char *name) {
+  struct block footer = {};
+  struct block header = {};
+  int err = 0;
+
+  memset(r, 0, sizeof(struct reader));
+  r->size = block_source_size(source) - FOOTER_SIZE;
+  r->source = source;
+  r->name = strdup(name);
+  r->hash_size = SHA1_SIZE;
+
+  err = block_source_read_block(source, &footer, r->size, FOOTER_SIZE);
+  if (err != FOOTER_SIZE) {
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  // Need +1 to read type of first block.
+  err = reader_get_block(r, &header, 0, HEADER_SIZE + 1);
+  if (err != HEADER_SIZE + 1) {
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  err = parse_footer(r, footer.data, header.data);
+exit:
+  block_source_return_block(r->source, &footer);
+  block_source_return_block(r->source, &header);
+  return err;
+}
+
+struct table_iter {
+  struct reader *r;
+  byte typ;
+  uint64_t block_off;
+  struct block_iter bi;
+  bool finished;
+};
+
+static void table_iter_copy_from(struct table_iter *dest,
+                                 struct table_iter *src) {
+  dest->r = src->r;
+  dest->typ = src->typ;
+  dest->block_off = src->block_off;
+  dest->finished = src->finished;
+  block_iter_copy_from(&dest->bi, &src->bi);
+}
+
+static int table_iter_next_in_block(struct table_iter *ti, struct record rec) {
+  int res = block_iter_next(&ti->bi, rec);
+  if (res == 0 && record_type(rec) == BLOCK_TYPE_REF) {
+    ((struct ref_record *)rec.data)->update_index += ti->r->min_update_index;
+  }
+
+  return res;
+}
+
+static void table_iter_block_done(struct table_iter *ti) {
+  if (ti->bi.br == NULL) {
+    return;
+  }
+  reader_return_block(ti->r, &ti->bi.br->block);
+  free(ti->bi.br);
+  ti->bi.br = NULL;
+
+  ti->bi.last_key.len = 0;
+  ti->bi.next_off = 0;
+}
+
+static int32_t extract_block_size(byte *data, byte *typ, uint64_t off) {
+  int32_t result = 0;
+
+  if (off == 0) {
+    data += 24;
+  }
+
+  *typ = data[0];
+  if (is_block_type(*typ)) {
+    result = get_u24(data + 1);
+  }
+  return result;
+}
+
+int reader_init_block_reader(struct reader *r, struct block_reader *br,
+                             uint64_t next_off, byte want_typ) {
+  int32_t guess_block_size = r->block_size ? r->block_size : DEFAULT_BLOCK_SIZE;
+  struct block block = {};
+  byte block_typ = 0;
+  int err = 0;
+  uint32_t header_off = next_off ? 0 : HEADER_SIZE;
+  int32_t block_size = 0;
+
+  if (next_off >= r->size) {
+    return 1;
+  }
+
+  err = reader_get_block(r, &block, next_off, guess_block_size);
+  if (err < 0) {
+    return err;
+  }
+
+  block_size = extract_block_size(block.data, &block_typ, next_off);
+  if (block_size < 0) {
+    return block_size;
+  }
+
+  if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
+    reader_return_block(r, &block);
+    return 1;
+  }
+
+  if (block_size > guess_block_size) {
+    reader_return_block(r, &block);
+    err = reader_get_block(r, &block, next_off, block_size);
+    if (err < 0) {
+      return err;
+    }
+  }
+
+  return block_reader_init(br, &block, header_off, r->block_size, r->hash_size);
+}
+
+static int table_iter_next_block(struct table_iter *dest,
+                                 struct table_iter *src) {
+  uint64_t next_block_off = src->block_off + src->bi.br->full_block_size;
+  struct block_reader br = {};
+  int err = 0;
+
+  dest->r = src->r;
+  dest->typ = src->typ;
+  dest->block_off = next_block_off;
+
+  err = reader_init_block_reader(src->r, &br, next_block_off, src->typ);
+  if (err > 0) {
+    dest->finished = true;
+    return 1;
+  }
+  if (err != 0) {
+    return err;
+  }
+
+  {
+    struct block_reader *brp = malloc(sizeof(struct block_reader));
+    *brp = br;
+
+    dest->finished = false;
+    block_reader_start(brp, &dest->bi);
+  }
+  return 0;
+}
+
+static int table_iter_next(struct table_iter *ti, struct record rec) {
+  if (record_type(rec) != ti->typ) {
+    return API_ERROR;
+  }
+
+  while (true) {
+    struct table_iter next = {};
+    int err = 0;
+    if (ti->finished) {
+      return 1;
+    }
+
+    err = table_iter_next_in_block(ti, rec);
+    if (err <= 0) {
+      return err;
+    }
+
+    err = table_iter_next_block(&next, ti);
+    if (err != 0) {
+      ti->finished = true;
+    }
+    table_iter_block_done(ti);
+    if (err != 0) {
+      return err;
+    }
+    table_iter_copy_from(ti, &next);
+    block_iter_close(&next.bi);
+  }
+}
+
+static int table_iter_next_void(void *ti, struct record rec) {
+  return table_iter_next((struct table_iter *)ti, rec);
+}
+
+static void table_iter_close(void *p) {
+  struct table_iter *ti = (struct table_iter *)p;
+  table_iter_block_done(ti);
+  block_iter_close(&ti->bi);
+}
+
+struct iterator_vtable table_iter_vtable = {
+    .next = &table_iter_next_void,
+    .close = &table_iter_close,
+};
+
+static void iterator_from_table_iter(struct iterator *it,
+                                     struct table_iter *ti) {
+  it->iter_arg = ti;
+  it->ops = &table_iter_vtable;
+}
+
+static int reader_table_iter_at(struct reader *r, struct table_iter *ti,
+                                uint64_t off, byte typ) {
+  struct block_reader br = {};
+  struct block_reader *brp = NULL;
+
+  int err = reader_init_block_reader(r, &br, off, typ);
+  if (err != 0) {
+    return err;
+  }
+
+  brp = malloc(sizeof(struct block_reader));
+  *brp = br;
+  ti->r = r;
+  ti->typ = block_reader_type(brp);
+  ti->block_off = off;
+  block_reader_start(brp, &ti->bi);
+  return 0;
+}
+
+static int reader_start(struct reader *r, struct table_iter *ti, byte typ,
+                        bool index) {
+  struct reader_offsets *offs = reader_offsets_for(r, typ);
+  uint64_t off = offs->offset;
+  if (index) {
+    off = offs->index_offset;
+    if (off == 0) {
+      return 1;
+    }
+    typ = BLOCK_TYPE_INDEX;
+  }
+
+  return reader_table_iter_at(r, ti, off, typ);
+}
+
+static int reader_seek_linear(struct reader *r, struct table_iter *ti,
+                              struct record want) {
+  struct record rec = new_record(record_type(want));
+  struct slice want_key = {};
+  struct slice got_key = {};
+  struct table_iter next = {};
+  int err = -1;
+  record_key(want, &want_key);
+
+  while (true) {
+    err = table_iter_next_block(&next, ti);
+    if (err < 0) {
+      goto exit;
+    }
+
+    if (err > 0) {
+      break;
+    }
+
+    err = block_reader_first_key(next.bi.br, &got_key);
+    if (err < 0) {
+      goto exit;
+    }
+    {
+      int cmp = slice_compare(got_key, want_key);
+      if (cmp > 0) {
+        table_iter_block_done(&next);
+        break;
+      }
+    }
+
+    table_iter_block_done(ti);
+    table_iter_copy_from(ti, &next);
+  }
+
+  err = block_iter_seek(&ti->bi, want_key);
+  if (err < 0) {
+    goto exit;
+  }
+  err = 0;
+
+exit:
+  block_iter_close(&next.bi);
+  record_clear(rec);
+  free(record_yield(&rec));
+  free(slice_yield(&want_key));
+  free(slice_yield(&got_key));
+  return err;
+}
+
+static int reader_seek_indexed(struct reader *r, struct iterator *it,
+                               struct record rec) {
+  struct index_record want_index = {};
+  struct record want_index_rec = {};
+  struct index_record index_result = {};
+  struct record index_result_rec = {};
+  struct table_iter index_iter = {};
+  struct table_iter next = {};
+  int err = 0;
+
+  record_key(rec, &want_index.last_key);
+  record_from_index(&want_index_rec, &want_index);
+  record_from_index(&index_result_rec, &index_result);
+
+  err = reader_start(r, &index_iter, record_type(rec), true);
+  if (err < 0) {
+    goto exit;
+  }
+
+  err = reader_seek_linear(r, &index_iter, want_index_rec);
+  while (true) {
+    err = table_iter_next(&index_iter, index_result_rec);
+    table_iter_block_done(&index_iter);
+    if (err != 0) {
+      goto exit;
+    }
+
+    err = reader_table_iter_at(r, &next, index_result.offset, 0);
+    if (err != 0) {
+      goto exit;
+    }
+
+    err = block_iter_seek(&next.bi, want_index.last_key);
+    if (err < 0) {
+      goto exit;
+    }
+
+    if (next.typ == record_type(rec)) {
+      err = 0;
+      break;
+    }
+
+    if (next.typ != BLOCK_TYPE_INDEX) {
+      err = FORMAT_ERROR;
+      break;
+    }
+
+    table_iter_copy_from(&index_iter, &next);
+  }
+
+  if (err == 0) {
+    struct table_iter *malloced = calloc(sizeof(struct table_iter), 1);
+    table_iter_copy_from(malloced, &next);
+    iterator_from_table_iter(it, malloced);
+  }
+exit:
+  block_iter_close(&next.bi);
+  table_iter_close(&index_iter);
+  record_clear(want_index_rec);
+  record_clear(index_result_rec);
+  return err;
+}
+
+static int reader_seek_internal(struct reader *r, struct iterator *it,
+                                struct record rec) {
+  struct reader_offsets *offs = reader_offsets_for(r, record_type(rec));
+  uint64_t idx = offs->index_offset;
+  struct table_iter ti = {};
+  int err = 0;
+  if (idx > 0) {
+    return reader_seek_indexed(r, it, rec);
+  }
+
+  err = reader_start(r, &ti, record_type(rec), false);
+  if (err < 0) {
+    return err;
+  }
+  err = reader_seek_linear(r, &ti, rec);
+  if (err < 0) {
+    return err;
+  }
+
+  {
+    struct table_iter *p = malloc(sizeof(struct table_iter));
+    *p = ti;
+    iterator_from_table_iter(it, p);
+  }
+
+  return 0;
+}
+
+int reader_seek(struct reader *r, struct iterator *it, struct record rec) {
+  byte typ = record_type(rec);
+
+  struct reader_offsets *offs = reader_offsets_for(r, typ);
+  if (!offs->present) {
+    iterator_set_empty(it);
+    return 0;
+  }
+
+  return reader_seek_internal(r, it, rec);
+}
+
+int reader_seek_ref(struct reader *r, struct iterator *it, const char *name) {
+  struct ref_record ref = {
+      .ref_name = (char *)name,
+  };
+  struct record rec = {};
+  record_from_ref(&rec, &ref);
+  return reader_seek(r, it, rec);
+}
+
+int reader_seek_log_at(struct reader *r, struct iterator *it, const char *name,
+                    uint64_t update_index) {
+  struct log_record log = {
+      .ref_name = (char *)name,
+      .update_index = update_index,
+  };
+  struct record rec = {};
+  record_from_log(&rec, &log);
+  return reader_seek(r, it, rec);
+}
+
+int reader_seek_log(struct reader *r, struct iterator *it, const char *name) {
+  uint64_t max = ~((uint64_t)0);
+  return reader_seek_log_at(r, it, name, max);
+}
+
+void reader_close(struct reader *r) {
+  block_source_close(&r->source);
+  free(r->name);
+  r->name = NULL;
+}
+
+int new_reader(struct reader **p, struct block_source src, char const *name) {
+  struct reader *rd = calloc(sizeof(struct reader), 1);
+  int err = init_reader(rd, src, name);
+  if (err == 0) {
+    *p = rd;
+  } else {
+    free(rd);
+  }
+  return err;
+}
+
+void reader_free(struct reader *r) {
+  reader_close(r);
+  free(r);
+}
+
+static int reader_refs_for_indexed(struct reader *r, struct iterator *it,
+                                   byte *oid) {
+  struct obj_record want = {
+      .hash_prefix = oid,
+      .hash_prefix_len = r->object_id_len,
+  };
+  struct record want_rec = {};
+  struct iterator oit = {};
+  struct obj_record got = {};
+  struct record got_rec = {};
+  int err = 0;
+
+  record_from_obj(&want_rec, &want);
+
+  err = reader_seek(r, &oit, want_rec);
+  if (err != 0) {
+    return err;
+  }
+
+  record_from_obj(&got_rec, &got);
+  err = iterator_next(oit, got_rec);
+  iterator_destroy(&oit);
+  if (err < 0) {
+    return err;
+  }
+
+  if (err > 0 || memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
+    iterator_set_empty(it);
+    return 0;
+  }
+
+  {
+    struct indexed_table_ref_iter *itr = NULL;
+    err = new_indexed_table_ref_iter(&itr, r, oid, r->hash_size, got.offsets,
+                                     got.offset_len);
+    if (err < 0) {
+      record_clear(got_rec);
+      return err;
+    }
+    got.offsets = NULL;
+    record_clear(got_rec);
+
+    iterator_from_indexed_table_ref_iter(it, itr);
+  }
+
+  return 0;
+}
+
+static int reader_refs_for_unindexed(struct reader *r, struct iterator *it,
+                                     byte *oid, int oid_len) {
+  struct table_iter *ti = calloc(sizeof(struct table_iter), 1);
+  struct filtering_ref_iterator *filter = NULL;
+  int err = reader_start(r, ti, BLOCK_TYPE_REF, false);
+  if (err < 0) {
+    free(ti);
+    return err;
+  }
+
+  filter = calloc(sizeof(struct filtering_ref_iterator), 1);
+  slice_resize(&filter->oid, oid_len);
+  memcpy(filter->oid.buf, oid, oid_len);
+  filter->r = r;
+  filter->double_check = false;
+  iterator_from_table_iter(&filter->it, ti);
+
+  iterator_from_filtering_ref_iterator(it, filter);
+  return 0;
+}
+
+int reader_refs_for(struct reader *r, struct iterator *it, byte *oid,
+                    int oid_len) {
+  if (r->obj_offsets.present) {
+    return reader_refs_for_indexed(r, it, oid);
+  }
+  return reader_refs_for_unindexed(r, it, oid, oid_len);
+}
+
+uint64_t reader_max_update_index(struct reader *r) {
+  return r->max_update_index;
+}
+
+uint64_t reader_min_update_index(struct reader *r) {
+  return r->min_update_index;
+}
diff --git a/reftable/reader.h b/reftable/reader.h
new file mode 100644
index 0000000000..20dff91fc6
--- /dev/null
+++ b/reftable/reader.h
@@ -0,0 +1,52 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef READER_H
+#define READER_H
+
+#include "block.h"
+#include "record.h"
+#include "reftable.h"
+
+uint64_t block_source_size(struct block_source source);
+
+int block_source_read_block(struct block_source source, struct block *dest,
+                            uint64_t off, uint32_t size);
+void block_source_return_block(struct block_source source, struct block *ret);
+void block_source_close(struct block_source *source);
+
+struct reader_offsets {
+  bool present;
+  uint64_t offset;
+  uint64_t index_offset;
+};
+
+struct reader {
+  struct block_source source;
+  char *name;
+  int hash_size;
+  uint64_t size;
+  uint32_t block_size;
+  uint64_t min_update_index;
+  uint64_t max_update_index;
+  int object_id_len;
+
+  struct reader_offsets ref_offsets;
+  struct reader_offsets obj_offsets;
+  struct reader_offsets log_offsets;
+};
+
+int init_reader(struct reader *r, struct block_source source, const char *name);
+int reader_seek(struct reader *r, struct iterator *it, struct record rec);
+void reader_close(struct reader *r);
+const char *reader_name(struct reader *r);
+void reader_return_block(struct reader *r, struct block *p);
+int reader_init_block_reader(struct reader *r, struct block_reader *br,
+                             uint64_t next_off, byte want_typ);
+
+#endif
diff --git a/reftable/record.c b/reftable/record.c
new file mode 100644
index 0000000000..e28eb0670d
--- /dev/null
+++ b/reftable/record.c
@@ -0,0 +1,1030 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "record.h"
+
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "constants.h"
+#include "reftable.h"
+
+int is_block_type(byte typ) {
+  switch (typ) {
+    case BLOCK_TYPE_REF:
+    case BLOCK_TYPE_LOG:
+    case BLOCK_TYPE_OBJ:
+    case BLOCK_TYPE_INDEX:
+      return true;
+  }
+  return false;
+}
+
+int get_var_int(uint64_t *dest, struct slice in) {
+  int ptr = 0;
+  uint64_t val;
+
+  if (in.len == 0) {
+    return -1;
+  }
+  val = in.buf[ptr] & 0x7f;
+
+  while (in.buf[ptr] & 0x80) {
+    ptr++;
+    if (ptr > in.len) {
+      return -1;
+    }
+    val = (val + 1) << 7 | (uint64_t)(in.buf[ptr] & 0x7f);
+  }
+
+  *dest = val;
+  return ptr + 1;
+}
+
+int put_var_int(struct slice dest, uint64_t val) {
+  byte buf[10] = {};
+  int i = 9;
+  buf[i] = (byte)(val & 0x7f);
+  i--;
+  while (true) {
+    val >>= 7;
+    if (!val) {
+      break;
+    }
+    val--;
+    buf[i] = 0x80 | (byte)(val & 0x7f);
+    i--;
+  }
+
+  {
+    int n = sizeof(buf) - i - 1;
+    if (dest.len < n) {
+      return -1;
+    }
+    memcpy(dest.buf, &buf[i + 1], n);
+    return n;
+  }
+}
+
+int common_prefix_size(struct slice a, struct slice b) {
+  int p = 0;
+  while (p < a.len && p < b.len) {
+    if (a.buf[p] != b.buf[p]) {
+      break;
+    }
+    p++;
+  }
+
+  return p;
+}
+
+static int decode_string(struct slice *dest, struct slice in) {
+  int start_len = in.len;
+  uint64_t tsize = 0;
+  int n = get_var_int(&tsize, in);
+  if (n <= 0) {
+    return -1;
+  }
+  in.buf += n;
+  in.len -= n;
+  if (in.len < tsize) {
+    return -1;
+  }
+
+  slice_resize(dest, tsize + 1);
+  dest->buf[tsize] = 0;
+  memcpy(dest->buf, in.buf, tsize);
+  in.buf += tsize;
+  in.len -= tsize;
+
+  return start_len - in.len;
+}
+
+int encode_key(bool *restart, struct slice dest, struct slice prev_key,
+               struct slice key, byte extra) {
+  struct slice start = dest;
+  int prefix_len = common_prefix_size(prev_key, key);
+  uint64_t suffix_len = key.len - prefix_len;
+  int n = put_var_int(dest, (uint64_t)prefix_len);
+  if (n < 0) {
+    return -1;
+  }
+  dest.buf += n;
+  dest.len -= n;
+
+  *restart = (prefix_len == 0);
+
+  n = put_var_int(dest, suffix_len << 3 | (uint64_t)extra);
+  if (n < 0) {
+    return -1;
+  }
+  dest.buf += n;
+  dest.len -= n;
+
+  if (dest.len < suffix_len) {
+    return -1;
+  }
+  memcpy(dest.buf, key.buf + prefix_len, suffix_len);
+  dest.buf += suffix_len;
+  dest.len -= suffix_len;
+
+  return start.len - dest.len;
+}
+
+static byte ref_record_type(void) { return BLOCK_TYPE_REF; }
+
+static void ref_record_key(const void *r, struct slice *dest) {
+  const struct ref_record *rec = (const struct ref_record *)r;
+  slice_set_string(dest, rec->ref_name);
+}
+
+static void ref_record_copy_from(void *rec, const void *src_rec,
+                                 int hash_size) {
+  struct ref_record *ref = (struct ref_record *)rec;
+  struct ref_record *src = (struct ref_record *)src_rec;
+  assert(hash_size > 0);
+
+  // This is simple and correct, but we could probably reuse the hash fields.
+  ref_record_clear(ref);
+  if (src->ref_name != NULL) {
+    ref->ref_name = strdup(src->ref_name);
+  }
+
+  if (src->target != NULL) {
+    ref->target = strdup(src->target);
+  }
+
+  if (src->target_value != NULL) {
+    ref->target_value = malloc(hash_size);
+    memcpy(ref->target_value, src->target_value, hash_size);
+  }
+
+  if (src->value != NULL) {
+    ref->value = malloc(hash_size);
+    memcpy(ref->value, src->value, hash_size);
+  }
+  ref->update_index = src->update_index;
+}
+
+static char hexdigit(int c) {
+  if (c <= 9) {
+    return '0' + c;
+  }
+  return 'a' + (c - 10);
+}
+
+static void hex_format(char *dest, byte *src, int hash_size) {
+  assert(hash_size > 0);
+  if (src != NULL) {
+    for (int i = 0; i < hash_size; i++) {
+      dest[2 * i] = hexdigit(src[i] >> 4);
+      dest[2 * i + 1] = hexdigit(src[i] & 0xf);
+    }
+    dest[2 * hash_size] = 0;
+  }
+}
+
+void ref_record_print(struct ref_record *ref, int hash_size) {
+  char hex[SHA256_SIZE + 1] = {};
+
+  printf("ref{%s(%ld) ", ref->ref_name, ref->update_index);
+  if (ref->value != NULL) {
+    hex_format(hex, ref->value, hash_size);
+    printf("%s", hex);
+  }
+  if (ref->target_value != NULL) {
+    hex_format(hex, ref->target_value, hash_size);
+    printf(" (T %s)", hex);
+  }
+  if (ref->target != NULL) {
+    printf("=> %s", ref->target);
+  }
+  printf("}\n");
+}
+
+static void ref_record_clear_void(void *rec) {
+  ref_record_clear((struct ref_record *)rec);
+}
+
+void ref_record_clear(struct ref_record *ref) {
+  free(ref->ref_name);
+  free(ref->target);
+  free(ref->target_value);
+  free(ref->value);
+  memset(ref, 0, sizeof(struct ref_record));
+}
+
+static byte ref_record_val_type(const void *rec) {
+  const struct ref_record *r = (const struct ref_record *)rec;
+  if (r->value != NULL) {
+    if (r->target_value != NULL) {
+      return 2;
+    } else {
+      return 1;
+    }
+  } else if (r->target != NULL) {
+    return 3;
+  }
+  return 0;
+}
+
+static int encode_string(char *str, struct slice s) {
+  struct slice start = s;
+  int l = strlen(str);
+  int n = put_var_int(s, l);
+  if (n < 0) {
+    return -1;
+  }
+  s.buf += n;
+  s.len -= n;
+  if (s.len < l) {
+    return -1;
+  }
+  memcpy(s.buf, str, l);
+  s.buf += l;
+  s.len -= l;
+
+  return start.len - s.len;
+}
+
+static int ref_record_encode(const void *rec, struct slice s, int hash_size) {
+  const struct ref_record *r = (const struct ref_record *)rec;
+  struct slice start = s;
+  int n = put_var_int(s, r->update_index);
+  assert(hash_size > 0);
+  if (n < 0) {
+    return -1;
+  }
+  s.buf += n;
+  s.len -= n;
+
+  if (r->value != NULL) {
+    if (s.len < hash_size) {
+      return -1;
+    }
+    memcpy(s.buf, r->value, hash_size);
+    s.buf += hash_size;
+    s.len -= hash_size;
+  }
+
+  if (r->target_value != NULL) {
+    if (s.len < hash_size) {
+      return -1;
+    }
+    memcpy(s.buf, r->target_value, hash_size);
+    s.buf += hash_size;
+    s.len -= hash_size;
+  }
+
+  if (r->target != NULL) {
+    int n = encode_string(r->target, s);
+    if (n < 0) {
+      return -1;
+    }
+    s.buf += n;
+    s.len -= n;
+  }
+
+  return start.len - s.len;
+}
+
+static int ref_record_decode(void *rec, struct slice key, byte val_type,
+                             struct slice in, int hash_size) {
+  struct ref_record *r = (struct ref_record *)rec;
+  struct slice start = in;
+  bool seen_value = false;
+  bool seen_target_value = false;
+  bool seen_target = false;
+
+  int n = get_var_int(&r->update_index, in);
+  if (n < 0) {
+    return n;
+  }
+  assert(hash_size > 0);
+
+  in.buf += n;
+  in.len -= n;
+
+  r->ref_name = realloc(r->ref_name, key.len + 1);
+  memcpy(r->ref_name, key.buf, key.len);
+  r->ref_name[key.len] = 0;
+
+  switch (val_type) {
+    case 1:
+    case 2:
+      if (in.len < hash_size) {
+        return -1;
+      }
+
+      if (r->value == NULL) {
+        r->value = malloc(hash_size);
+      }
+      seen_value = true;
+      memcpy(r->value, in.buf, hash_size);
+      in.buf += hash_size;
+      in.len -= hash_size;
+      if (val_type == 1) {
+        break;
+      }
+      if (r->target_value == NULL) {
+        r->target_value = malloc(hash_size);
+      }
+      seen_target_value = true;
+      memcpy(r->target_value, in.buf, hash_size);
+      in.buf += hash_size;
+      in.len -= hash_size;
+      break;
+    case 3: {
+      struct slice dest = {};
+      int n = decode_string(&dest, in);
+      if (n < 0) {
+        return -1;
+      }
+      in.buf += n;
+      in.len -= n;
+      seen_target = true;
+      r->target = (char *)slice_as_string(&dest);
+    } break;
+
+    case 0:
+      break;
+    default:
+      abort();
+      break;
+  }
+
+  if (!seen_target && r->target != NULL) {
+    free(r->target);
+    r->target = NULL;
+  }
+  if (!seen_target_value && r->target_value != NULL) {
+    free(r->target_value);
+    r->target_value = NULL;
+  }
+  if (!seen_value && r->value != NULL) {
+    free(r->value);
+    r->value = NULL;
+  }
+
+  return start.len - in.len;
+}
+
+int decode_key(struct slice *key, byte *extra, struct slice last_key,
+               struct slice in) {
+  int start_len = in.len;
+  uint64_t prefix_len = 0;
+  uint64_t suffix_len = 0;
+  int n = get_var_int(&prefix_len, in);
+  if (n < 0) {
+    return -1;
+  }
+  in.buf += n;
+  in.len -= n;
+
+  if (prefix_len > last_key.len) {
+    return -1;
+  }
+
+  n = get_var_int(&suffix_len, in);
+  if (n <= 0) {
+    return -1;
+  }
+  in.buf += n;
+  in.len -= n;
+
+  *extra = (byte)(suffix_len & 0x7);
+  suffix_len >>= 3;
+
+  if (in.len < suffix_len) {
+    return -1;
+  }
+
+  slice_resize(key, suffix_len + prefix_len);
+  memcpy(key->buf, last_key.buf, prefix_len);
+
+  memcpy(key->buf + prefix_len, in.buf, suffix_len);
+  in.buf += suffix_len;
+  in.len -= suffix_len;
+
+  return start_len - in.len;
+}
+
+struct record_vtable ref_record_vtable = {
+    .key = &ref_record_key,
+    .type = &ref_record_type,
+    .copy_from = &ref_record_copy_from,
+    .val_type = &ref_record_val_type,
+    .encode = &ref_record_encode,
+    .decode = &ref_record_decode,
+    .clear = &ref_record_clear_void,
+};
+
+static byte obj_record_type(void) { return BLOCK_TYPE_OBJ; }
+
+static void obj_record_key(const void *r, struct slice *dest) {
+  const struct obj_record *rec = (const struct obj_record *)r;
+  slice_resize(dest, rec->hash_prefix_len);
+  memcpy(dest->buf, rec->hash_prefix, rec->hash_prefix_len);
+}
+
+static void obj_record_copy_from(void *rec, const void *src_rec,
+                                 int hash_size) {
+  struct obj_record *ref = (struct obj_record *)rec;
+  const struct obj_record *src = (const struct obj_record *)src_rec;
+
+  *ref = *src;
+  ref->hash_prefix = malloc(ref->hash_prefix_len);
+  memcpy(ref->hash_prefix, src->hash_prefix, ref->hash_prefix_len);
+
+  {
+    int olen = ref->offset_len * sizeof(uint64_t);
+    ref->offsets = malloc(olen);
+    memcpy(ref->offsets, src->offsets, olen);
+  }
+}
+
+static void obj_record_clear(void *rec) {
+  struct obj_record *ref = (struct obj_record *)rec;
+  free(ref->hash_prefix);
+  free(ref->offsets);
+  memset(ref, 0, sizeof(struct obj_record));
+}
+
+static byte obj_record_val_type(const void *rec) {
+  struct obj_record *r = (struct obj_record *)rec;
+  if (r->offset_len > 0 && r->offset_len < 8) {
+    return r->offset_len;
+  }
+  return 0;
+}
+
+static int obj_record_encode(const void *rec, struct slice s, int hash_size) {
+  struct obj_record *r = (struct obj_record *)rec;
+  struct slice start = s;
+  int n = 0;
+  if (r->offset_len == 0 || r->offset_len >= 8) {
+    n = put_var_int(s, r->offset_len);
+    if (n < 0) {
+      return -1;
+    }
+    s.buf += n;
+    s.len -= n;
+  }
+  if (r->offset_len == 0) {
+    return start.len - s.len;
+  }
+  n = put_var_int(s, r->offsets[0]);
+  if (n < 0) {
+    return -1;
+  }
+  s.buf += n;
+  s.len -= n;
+
+  {
+    uint64_t last = r->offsets[0];
+    for (int i = 1; i < r->offset_len; i++) {
+      int n = put_var_int(s, r->offsets[i] - last);
+      if (n < 0) {
+        return -1;
+      }
+      s.buf += n;
+      s.len -= n;
+      last = r->offsets[i];
+    }
+  }
+  return start.len - s.len;
+}
+
+static int obj_record_decode(void *rec, struct slice key, byte val_type,
+                             struct slice in, int hash_size) {
+  struct slice start = in;
+  struct obj_record *r = (struct obj_record *)rec;
+  uint64_t count = val_type;
+  int n = 0;
+  r->hash_prefix = malloc(key.len);
+  memcpy(r->hash_prefix, key.buf, key.len);
+  r->hash_prefix_len = key.len;
+
+  if (val_type == 0) {
+    n = get_var_int(&count, in);
+    if (n < 0) {
+      return n;
+    }
+
+    in.buf += n;
+    in.len -= n;
+  }
+
+  r->offsets = NULL;
+  r->offset_len = 0;
+  if (count == 0) {
+    return start.len - in.len;
+  }
+
+  r->offsets = malloc(count * sizeof(uint64_t));
+  r->offset_len = count;
+
+  n = get_var_int(&r->offsets[0], in);
+  if (n < 0) {
+    return n;
+  }
+
+  in.buf += n;
+  in.len -= n;
+
+  {
+    uint64_t last = r->offsets[0];
+    int j = 1;
+    while (j < count) {
+      uint64_t delta = 0;
+      int n = get_var_int(&delta, in);
+      if (n < 0) {
+        return n;
+      }
+
+      in.buf += n;
+      in.len -= n;
+
+      last = r->offsets[j] = (delta + last);
+      j++;
+    }
+  }
+  return start.len - in.len;
+}
+
+struct record_vtable obj_record_vtable = {
+    .key = &obj_record_key,
+    .type = &obj_record_type,
+    .copy_from = &obj_record_copy_from,
+    .val_type = &obj_record_val_type,
+    .encode = &obj_record_encode,
+    .decode = &obj_record_decode,
+    .clear = &obj_record_clear,
+};
+
+void log_record_print(struct log_record *log, int hash_size) {
+  char hex[SHA256_SIZE + 1] = {};
+
+  printf("log{%s(%ld) %s <%s> %lu %04d\n", log->ref_name, log->update_index,
+         log->name, log->email, log->time, log->tz_offset);
+  hex_format(hex, log->old_hash, hash_size);
+  printf("%s => ", hex);
+  hex_format(hex, log->new_hash, hash_size);
+  printf("%s\n\n%s\n}\n", hex, log->message);
+}
+
+static byte log_record_type(void) { return BLOCK_TYPE_LOG; }
+
+static void log_record_key(const void *r, struct slice *dest) {
+  const struct log_record *rec = (const struct log_record *)r;
+  int len = strlen(rec->ref_name);
+  uint64_t ts = 0;
+  slice_resize(dest, len + 9);
+  memcpy(dest->buf, rec->ref_name, len + 1);
+  ts = (~ts) - rec->update_index;
+  put_u64(dest->buf + 1 + len, ts);
+}
+
+static void log_record_copy_from(void *rec, const void *src_rec,
+                                 int hash_size) {
+  struct log_record *dst = (struct log_record *)rec;
+  const struct log_record *src = (const struct log_record *)src_rec;
+
+  *dst = *src;
+  dst->ref_name = strdup(dst->ref_name);
+  dst->email = strdup(dst->email);
+  dst->name = strdup(dst->name);
+  dst->message = strdup(dst->message);
+  if (dst->new_hash != NULL) {
+    dst->new_hash = malloc(hash_size);
+    memcpy(dst->new_hash, src->new_hash, hash_size);
+  }
+  if (dst->old_hash != NULL) {
+    dst->old_hash = malloc(hash_size);
+    memcpy(dst->old_hash, src->old_hash, hash_size);
+  }
+}
+
+static void log_record_clear_void(void *rec) {
+  struct log_record *r = (struct log_record *)rec;
+  log_record_clear(r);
+}
+
+void log_record_clear(struct log_record *r) {
+  free(r->ref_name);
+  free(r->new_hash);
+  free(r->old_hash);
+  free(r->name);
+  free(r->email);
+  free(r->message);
+  memset(r, 0, sizeof(struct log_record));
+}
+
+static byte log_record_val_type(const void *rec) { return 1; }
+
+static byte zero[SHA256_SIZE] = {};
+
+static int log_record_encode(const void *rec, struct slice s, int hash_size) {
+  struct log_record *r = (struct log_record *)rec;
+  struct slice start = s;
+  int n = 0;
+  byte *oldh = r->old_hash;
+  byte *newh = r->new_hash;
+  if (oldh == NULL) {
+    oldh = zero;
+  }
+  if (newh == NULL) {
+    newh = zero;
+  }
+
+  if (s.len < 2 * hash_size) {
+    return -1;
+  }
+
+  memcpy(s.buf, oldh, hash_size);
+  memcpy(s.buf + hash_size, newh, hash_size);
+  s.buf += 2 * hash_size;
+  s.len -= 2 * hash_size;
+
+  n = encode_string(r->name ? r->name : "", s);
+  if (n < 0) {
+    return -1;
+  }
+  s.len -= n;
+  s.buf += n;
+
+  n = encode_string(r->email ? r->email : "", s);
+  if (n < 0) {
+    return -1;
+  }
+  s.len -= n;
+  s.buf += n;
+
+  n = put_var_int(s, r->time);
+  if (n < 0) {
+    return -1;
+  }
+  s.buf += n;
+  s.len -= n;
+
+  if (s.len < 2) {
+    return -1;
+  }
+
+  put_u16(s.buf, r->tz_offset);
+  s.buf += 2;
+  s.len -= 2;
+
+  n = encode_string(r->message ? r->message : "", s);
+  if (n < 0) {
+    return -1;
+  }
+  s.len -= n;
+  s.buf += n;
+
+  return start.len - s.len;
+}
+
+static int log_record_decode(void *rec, struct slice key, byte val_type,
+                             struct slice in, int hash_size) {
+  struct slice start = in;
+  struct log_record *r = (struct log_record *)rec;
+  uint64_t max = 0;
+  uint64_t ts = 0;
+  struct slice dest = {};
+  int n;
+
+  if (key.len <= 9 || key.buf[key.len - 9] != 0) {
+    return FORMAT_ERROR;
+  }
+
+  r->ref_name = realloc(r->ref_name, key.len - 8);
+  memcpy(r->ref_name, key.buf, key.len - 8);
+  ts = get_u64(key.buf + key.len - 8);
+
+  r->update_index = (~max) - ts;
+
+  if (in.len < 2 * hash_size) {
+    return FORMAT_ERROR;
+  }
+
+  r->old_hash = realloc(r->old_hash, hash_size);
+  r->new_hash = realloc(r->new_hash, hash_size);
+
+  memcpy(r->old_hash, in.buf, hash_size);
+  memcpy(r->new_hash, in.buf + hash_size, hash_size);
+
+  in.buf += 2 * hash_size;
+  in.len -= 2 * hash_size;
+
+  n = decode_string(&dest, in);
+  if (n < 0) {
+    goto error;
+  }
+  in.len -= n;
+  in.buf += n;
+
+  r->name = realloc(r->name, dest.len + 1);
+  memcpy(r->name, dest.buf, dest.len);
+  r->name[dest.len] = 0;
+
+  slice_resize(&dest, 0);
+  n = decode_string(&dest, in);
+  if (n < 0) {
+    goto error;
+  }
+  in.len -= n;
+  in.buf += n;
+
+  r->email = realloc(r->email, dest.len + 1);
+  memcpy(r->email, dest.buf, dest.len);
+  r->email[dest.len] = 0;
+
+  ts = 0;
+  n = get_var_int(&ts, in);
+  if (n < 0) {
+    goto error;
+  }
+  in.len -= n;
+  in.buf += n;
+  r->time = ts;
+  if (in.len < 2) {
+    goto error;
+  }
+
+  r->tz_offset = get_u16(in.buf);
+  in.buf += 2;
+  in.len -= 2;
+
+  slice_resize(&dest, 0);
+  n = decode_string(&dest, in);
+  if (n < 0) {
+    goto error;
+  }
+  in.len -= n;
+  in.buf += n;
+
+  r->message = realloc(r->message, dest.len + 1);
+  memcpy(r->message, dest.buf, dest.len);
+  r->message[dest.len] = 0;
+
+  return start.len - in.len;
+
+error:
+  free(slice_yield(&dest));
+  return FORMAT_ERROR;
+}
+
+static bool null_streq(char *a, char *b) {
+  char *empty = "";
+  if (a == NULL) {
+    a = empty;
+  }
+  if (b == NULL) {
+    b = empty;
+  }
+  return 0 == strcmp(a, b);
+}
+
+static bool zero_hash_eq(byte *a, byte *b, int sz) {
+  if (a == NULL) {
+    a = zero;
+  }
+  if (b == NULL) {
+    b = zero;
+  }
+  return 0 == memcmp(a, b, sz);
+}
+
+bool log_record_equal(struct log_record *a, struct log_record *b,
+                      int hash_size) {
+  return null_streq(a->name, b->name) && null_streq(a->email, b->email) &&
+         null_streq(a->message, b->message) &&
+         zero_hash_eq(a->old_hash, b->old_hash, hash_size) &&
+         zero_hash_eq(a->new_hash, b->new_hash, hash_size) &&
+         a->time == b->time && a->tz_offset == b->tz_offset &&
+         a->update_index == b->update_index;
+}
+
+struct record_vtable log_record_vtable = {
+    .key = &log_record_key,
+    .type = &log_record_type,
+    .copy_from = &log_record_copy_from,
+    .val_type = &log_record_val_type,
+    .encode = &log_record_encode,
+    .decode = &log_record_decode,
+    .clear = &log_record_clear_void,
+};
+
+struct record new_record(byte typ) {
+  struct record rec;
+  switch (typ) {
+    case BLOCK_TYPE_REF: {
+      struct ref_record *r = calloc(1, sizeof(struct ref_record));
+      record_from_ref(&rec, r);
+      return rec;
+    }
+
+    case BLOCK_TYPE_OBJ: {
+      struct obj_record *r = calloc(1, sizeof(struct obj_record));
+      record_from_obj(&rec, r);
+      return rec;
+    }
+    case BLOCK_TYPE_LOG: {
+      struct log_record *r = calloc(1, sizeof(struct log_record));
+      record_from_log(&rec, r);
+      return rec;
+    }
+    case BLOCK_TYPE_INDEX: {
+      struct index_record *r = calloc(1, sizeof(struct index_record));
+      record_from_index(&rec, r);
+      return rec;
+    }
+  }
+  abort();
+  return rec;
+}
+
+static byte index_record_type(void) { return BLOCK_TYPE_INDEX; }
+
+static void index_record_key(const void *r, struct slice *dest) {
+  struct index_record *rec = (struct index_record *)r;
+  slice_copy(dest, rec->last_key);
+}
+
+static void index_record_copy_from(void *rec, const void *src_rec,
+                                   int hash_size) {
+  struct index_record *dst = (struct index_record *)rec;
+  struct index_record *src = (struct index_record *)src_rec;
+
+  slice_copy(&dst->last_key, src->last_key);
+  dst->offset = src->offset;
+}
+
+static void index_record_clear(void *rec) {
+  struct index_record *idx = (struct index_record *)rec;
+  free(slice_yield(&idx->last_key));
+}
+
+static byte index_record_val_type(const void *rec) { return 0; }
+
+static int index_record_encode(const void *rec, struct slice out,
+                               int hash_size) {
+  const struct index_record *r = (const struct index_record *)rec;
+  struct slice start = out;
+
+  int n = put_var_int(out, r->offset);
+  if (n < 0) {
+    return n;
+  }
+
+  out.buf += n;
+  out.len -= n;
+
+  return start.len - out.len;
+}
+
+static int index_record_decode(void *rec, struct slice key, byte val_type,
+                               struct slice in, int hash_size) {
+  struct slice start = in;
+  struct index_record *r = (struct index_record *)rec;
+  int n = 0;
+
+  slice_copy(&r->last_key, key);
+
+  n = get_var_int(&r->offset, in);
+  if (n < 0) {
+    return n;
+  }
+
+  in.buf += n;
+  in.len -= n;
+  return start.len - in.len;
+}
+
+struct record_vtable index_record_vtable = {
+    .key = &index_record_key,
+    .type = &index_record_type,
+    .copy_from = &index_record_copy_from,
+    .val_type = &index_record_val_type,
+    .encode = &index_record_encode,
+    .decode = &index_record_decode,
+    .clear = &index_record_clear,
+};
+
+void record_key(struct record rec, struct slice *dest) {
+  rec.ops->key(rec.data, dest);
+}
+
+byte record_type(struct record rec) { return rec.ops->type(); }
+
+int record_encode(struct record rec, struct slice dest, int hash_size) {
+  return rec.ops->encode(rec.data, dest, hash_size);
+}
+
+void record_copy_from(struct record rec, struct record src, int hash_size) {
+  assert(src.ops->type() == rec.ops->type());
+
+  rec.ops->copy_from(rec.data, src.data, hash_size);
+}
+
+byte record_val_type(struct record rec) { return rec.ops->val_type(rec.data); }
+
+int record_decode(struct record rec, struct slice key, byte extra,
+                  struct slice src, int hash_size) {
+  return rec.ops->decode(rec.data, key, extra, src, hash_size);
+}
+
+void record_clear(struct record rec) { return rec.ops->clear(rec.data); }
+
+void record_from_ref(struct record *rec, struct ref_record *ref_rec) {
+  rec->data = ref_rec;
+  rec->ops = &ref_record_vtable;
+}
+
+void record_from_obj(struct record *rec, struct obj_record *obj_rec) {
+  rec->data = obj_rec;
+  rec->ops = &obj_record_vtable;
+}
+
+void record_from_index(struct record *rec, struct index_record *index_rec) {
+  rec->data = index_rec;
+  rec->ops = &index_record_vtable;
+}
+
+void record_from_log(struct record *rec, struct log_record *log_rec) {
+  rec->data = log_rec;
+  rec->ops = &log_record_vtable;
+}
+
+void *record_yield(struct record *rec) {
+  void *p = rec->data;
+  rec->data = NULL;
+  return p;
+}
+
+struct ref_record *record_as_ref(struct record rec) {
+  assert(record_type(rec) == BLOCK_TYPE_REF);
+  return (struct ref_record *)rec.data;
+}
+
+static bool hash_equal(byte *a, byte *b, int hash_size) {
+  if (a != NULL && b != NULL) {
+    return 0 == memcmp(a, b, hash_size);
+  }
+
+  return a == b;
+}
+
+static bool str_equal(char *a, char *b) {
+  if (a != NULL && b != NULL) {
+    return 0 == strcmp(a, b);
+  }
+
+  return a == b;
+}
+
+bool ref_record_equal(struct ref_record *a, struct ref_record *b,
+                      int hash_size) {
+  assert(hash_size > 0);
+  return 0 == strcmp(a->ref_name, b->ref_name) &&
+         a->update_index == b->update_index &&
+         hash_equal(a->value, b->value, hash_size) &&
+         hash_equal(a->target_value, b->target_value, hash_size) &&
+         str_equal(a->target, b->target);
+}
+
+int ref_record_compare_name(const void *a, const void *b) {
+  return strcmp(((struct ref_record *)a)->ref_name,
+                ((struct ref_record *)b)->ref_name);
+}
+
+bool ref_record_is_deletion(const struct ref_record *ref) {
+  return ref->value == NULL && ref->target == NULL && ref->target_value == NULL;
+}
+
+int log_record_compare_key(const void *a, const void *b) {
+  struct log_record *la = (struct log_record *)a;
+  struct log_record *lb = (struct log_record *)b;
+
+  int cmp  = strcmp(la->ref_name, lb->ref_name);
+  if (cmp) {
+    return cmp;
+  }
+  if (la->update_index > lb->update_index) {
+    return -1;
+  }
+  return (la->update_index < lb->update_index) ? 1 : 0;
+}
+
+bool log_record_is_deletion(const struct log_record *log) {
+  // XXX
+  return false;
+}
diff --git a/reftable/record.h b/reftable/record.h
new file mode 100644
index 0000000000..c6245d6cf1
--- /dev/null
+++ b/reftable/record.h
@@ -0,0 +1,79 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef RECORD_H
+#define RECORD_H
+
+#include "reftable.h"
+#include "slice.h"
+
+struct record_vtable {
+  void (*key)(const void *rec, struct slice *dest);
+  byte (*type)(void);
+  void (*copy_from)(void *rec, const void *src, int hash_size);
+  byte (*val_type)(const void *rec);
+  int (*encode)(const void *rec, struct slice dest, int hash_size);
+  int (*decode)(void *rec, struct slice key, byte extra, struct slice src,
+                int hash_size);
+  void (*clear)(void *rec);
+};
+
+/* record is a generic wrapper for differnt types of records. */
+struct record {
+  void *data;
+  struct record_vtable *ops;
+};
+
+int get_var_int(uint64_t *dest, struct slice in);
+int put_var_int(struct slice dest, uint64_t val);
+int common_prefix_size(struct slice a, struct slice b);
+
+int is_block_type(byte typ);
+struct record new_record(byte typ);
+
+extern struct record_vtable ref_record_vtable;
+
+int encode_key(bool *restart, struct slice dest, struct slice prev_key,
+               struct slice key, byte extra);
+int decode_key(struct slice *key, byte *extra, struct slice last_key,
+               struct slice in);
+
+struct index_record {
+  struct slice last_key;
+  uint64_t offset;
+};
+
+struct obj_record {
+  byte *hash_prefix;
+  int hash_prefix_len;
+  uint64_t *offsets;
+  int offset_len;
+};
+
+void record_key(struct record rec, struct slice *dest);
+byte record_type(struct record rec);
+void record_copy_from(struct record rec, struct record src, int hash_size);
+byte record_val_type(struct record rec);
+int record_encode(struct record rec, struct slice dest, int hash_size);
+int record_decode(struct record rec, struct slice key, byte extra,
+                  struct slice src, int hash_size);
+void record_clear(struct record rec);
+void *record_yield(struct record *rec);
+void record_from_obj(struct record *rec, struct obj_record *objrec);
+void record_from_index(struct record *rec, struct index_record *idxrec);
+void record_from_ref(struct record *rec, struct ref_record *refrec);
+void record_from_log(struct record *rec, struct log_record *logrec);
+struct ref_record *record_as_ref(struct record ref);
+
+// for qsort.
+int ref_record_compare_name(const void *a, const void *b);
+
+// for qsort.
+int log_record_compare_key(const void *a, const void *b);
+
+#endif
diff --git a/reftable/record_test.c b/reftable/record_test.c
new file mode 100644
index 0000000000..71c6d0dd97
--- /dev/null
+++ b/reftable/record_test.c
@@ -0,0 +1,313 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "record.h"
+
+#include <string.h>
+
+#include "basics.h"
+#include "constants.h"
+#include "reftable.h"
+#include "test_framework.h"
+
+void varint_roundtrip() {
+  uint64_t inputs[] = {0,
+                       1,
+                       27,
+                       127,
+                       128,
+                       257,
+                       4096,
+                       ((uint64_t)1 << 63),
+                       ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1};
+  for (int i = 0; i < ARRAYSIZE(inputs); i++) {
+    byte dest[10];
+
+    struct slice out = {.buf = dest, .len = 10, .cap = 10};
+
+    uint64_t in = inputs[i];
+    int n = put_var_int(out, in);
+    assert(n > 0);
+    out.len = n;
+
+    uint64_t got = 0;
+    n = get_var_int(&got, out);
+    assert(n > 0);
+
+    assert(got == in);
+  }
+}
+
+void test_common_prefix() {
+  struct {
+    const char *a, *b;
+    int want;
+  } cases[] = {
+      {"abc", "ab", 2},
+      {"", "abc", 0},
+      {"abc", "abd", 2},
+      {"abc", "pqr", 0},
+  };
+
+  for (int i = 0; i < ARRAYSIZE(cases); i++) {
+    struct slice a = {};
+    struct slice b = {};
+    slice_set_string(&a, cases[i].a);
+    slice_set_string(&b, cases[i].b);
+
+    int got = common_prefix_size(a, b);
+    assert(got == cases[i].want);
+
+    free(slice_yield(&a));
+    free(slice_yield(&b));
+  }
+}
+
+void set_hash(byte *h, int j) {
+  for (int i = 0; i < SHA1_SIZE; i++) {
+    h[i] = (j >> i) & 0xff;
+  }
+}
+
+void test_ref_record_roundtrip() {
+  for (int i = 0; i <= 3; i++) {
+    printf("subtest %d\n", i);
+    struct ref_record in = {};
+    switch (i) {
+      case 0:
+        break;
+      case 1:
+        in.value = malloc(SHA1_SIZE);
+        set_hash(in.value, 1);
+        break;
+      case 2:
+        in.value = malloc(SHA1_SIZE);
+        set_hash(in.value, 1);
+        in.target_value = malloc(SHA1_SIZE);
+        set_hash(in.target_value, 2);
+        break;
+      case 3:
+        in.target = strdup("target");
+        break;
+    }
+    in.ref_name = strdup("refs/heads/master");
+
+    struct record rec = {};
+    record_from_ref(&rec, &in);
+    assert(record_val_type(rec) == i);
+    byte buf[1024];
+    struct slice key = {};
+    record_key(rec, &key);
+    struct slice dest = {
+        .buf = buf,
+        .len = sizeof(buf),
+    };
+    int n = record_encode(rec, dest, SHA1_SIZE);
+    assert(n > 0);
+
+    struct ref_record out = {};
+    struct record rec_out = {};
+    record_from_ref(&rec_out, &out);
+    int m = record_decode(rec_out, key, i, dest, SHA1_SIZE);
+    assert(n == m);
+
+    assert((out.value != NULL) == (in.value != NULL));
+    assert((out.target_value != NULL) == (in.target_value != NULL));
+    assert((out.target != NULL) == (in.target != NULL));
+    free(slice_yield(&key));
+    record_clear(rec_out);
+    ref_record_clear(&in);
+  }
+}
+
+void test_log_record_roundtrip() {
+  struct log_record in = {
+      .ref_name = strdup("refs/heads/master"),
+      .old_hash = malloc(SHA1_SIZE),
+      .new_hash = malloc(SHA1_SIZE),
+      .name = strdup("han-wen"),
+      .email = strdup("hanwen@google.com"),
+      .message = strdup("test"),
+      .update_index = 42,
+      .time = 1577123507,
+      .tz_offset = 100,
+  };
+
+  struct record rec = {};
+  record_from_log(&rec, &in);
+
+  struct slice key = {};
+  record_key(rec, &key);
+
+  byte buf[1024];
+  struct slice dest = {
+      .buf = buf,
+      .len = sizeof(buf),
+  };
+
+  int n = record_encode(rec, dest, SHA1_SIZE);
+  assert(n > 0);
+
+  struct log_record out = {};
+  struct record rec_out = {};
+  record_from_log(&rec_out, &out);
+  int valtype = record_val_type(rec);
+  int m = record_decode(rec_out, key, valtype, dest, SHA1_SIZE);
+  assert(n == m);
+
+  assert(log_record_equal(&in, &out, SHA1_SIZE));
+  log_record_clear(&in);
+  free(slice_yield(&key));
+  record_clear(rec_out);
+}
+
+void test_u24_roundtrip() {
+  uint32_t in = 0x112233;
+  byte dest[3];
+
+  put_u24(dest, in);
+  uint32_t out = get_u24(dest);
+  assert(in == out);
+}
+
+void test_key_roundtrip() {
+  struct slice dest = {}, last_key = {}, key = {}, roundtrip = {};
+
+  slice_resize(&dest, 1024);
+  slice_set_string(&last_key, "refs/heads/master");
+  slice_set_string(&key, "refs/tags/bla");
+
+  bool restart;
+  byte extra = 6;
+  int n = encode_key(&restart, dest, last_key, key, extra);
+  assert(!restart);
+  assert(n > 0);
+
+  byte rt_extra;
+  int m = decode_key(&roundtrip, &rt_extra, last_key, dest);
+  assert(n == m);
+  assert(slice_equal(key, roundtrip));
+  assert(rt_extra == extra);
+
+  free(slice_yield(&last_key));
+  free(slice_yield(&key));
+  free(slice_yield(&dest));
+  free(slice_yield(&roundtrip));
+}
+
+void print_bytes(byte *p, int l) {
+  for (int i = 0; i < l; i++) {
+    byte c = *p;
+    if (c < 32) {
+      c = '.';
+    }
+    printf("%02x[%c] ", p[i], c);
+  }
+  printf("(%d)\n", l);
+}
+
+void test_obj_record_roundtrip() {
+  byte testHash1[SHA1_SIZE] = {};
+  set_hash(testHash1, 1);
+  uint64_t till9[] = {1, 2, 3, 4, 500, 600, 700, 800, 9000};
+
+  struct obj_record recs[3] = {{
+                                   .hash_prefix = testHash1,
+                                   .hash_prefix_len = 5,
+                                   .offsets = till9,
+                                   .offset_len = 3,
+                               },
+                               {
+                                   .hash_prefix = testHash1,
+                                   .hash_prefix_len = 5,
+                                   .offsets = till9,
+                                   .offset_len = 9,
+                               },
+                               {
+                                   .hash_prefix = testHash1,
+                                   .hash_prefix_len = 5,
+                               }
+
+  };
+  for (int i = 0; i < ARRAYSIZE(recs); i++) {
+    printf("subtest %d\n", i);
+    struct obj_record in = recs[i];
+    byte buf[1024];
+    struct record rec = {};
+    record_from_obj(&rec, &in);
+    struct slice key = {};
+    record_key(rec, &key);
+    struct slice dest = {
+        .buf = buf,
+        .len = sizeof(buf),
+    };
+    int n = record_encode(rec, dest, SHA1_SIZE);
+    assert(n > 0);
+    byte extra = record_val_type(rec);
+    struct obj_record out = {};
+    struct record rec_out = {};
+    record_from_obj(&rec_out, &out);
+    int m = record_decode(rec_out, key, extra, dest, SHA1_SIZE);
+    assert(n == m);
+
+    assert(in.hash_prefix_len == out.hash_prefix_len);
+    assert(in.offset_len == out.offset_len);
+
+    assert(0 == memcmp(in.hash_prefix, out.hash_prefix, in.hash_prefix_len));
+    assert(0 ==
+           memcmp(in.offsets, out.offsets, sizeof(uint64_t) * in.offset_len));
+    free(slice_yield(&key));
+    record_clear(rec_out);
+  }
+}
+
+void test_index_record_roundtrip() {
+  struct index_record in = {.offset = 42};
+
+  slice_set_string(&in.last_key, "refs/heads/master");
+
+  struct slice key = {};
+  struct record rec = {};
+  record_from_index(&rec, &in);
+  record_key(rec, &key);
+
+  assert(0 == slice_compare(key, in.last_key));
+
+  byte buf[1024];
+  struct slice dest = {
+      .buf = buf,
+      .len = sizeof(buf),
+  };
+  int n = record_encode(rec, dest, SHA1_SIZE);
+  assert(n > 0);
+
+  byte extra = record_val_type(rec);
+  struct index_record out = {};
+  struct record out_rec;
+  record_from_index(&out_rec, &out);
+  int m = record_decode(out_rec, key, extra, dest, SHA1_SIZE);
+  assert(m == n);
+
+  assert(in.offset == out.offset);
+
+  record_clear(out_rec);
+  free(slice_yield(&key));
+  free(slice_yield(&in.last_key));
+}
+
+int main() {
+  add_test_case("test_log_record_roundtrip", &test_log_record_roundtrip);
+  add_test_case("test_ref_record_roundtrip", &test_ref_record_roundtrip);
+  add_test_case("varint_roundtrip", &varint_roundtrip);
+  add_test_case("test_key_roundtrip", &test_key_roundtrip);
+  add_test_case("test_common_prefix", &test_common_prefix);
+  add_test_case("test_obj_record_roundtrip", &test_obj_record_roundtrip);
+  add_test_case("test_index_record_roundtrip", &test_index_record_roundtrip);
+  add_test_case("test_u24_roundtrip", &test_u24_roundtrip);
+  test_main();
+}
diff --git a/reftable/reftable.h b/reftable/reftable.h
new file mode 100644
index 0000000000..d760af973d
--- /dev/null
+++ b/reftable/reftable.h
@@ -0,0 +1,396 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_H
+#define REFTABLE_H
+
+#include <stdint.h>
+
+typedef uint8_t byte;
+typedef byte bool;
+
+/* block_source is a generic wrapper for a seekable readable file.
+   It is generally passed around by value.
+ */
+struct block_source {
+  struct block_source_vtable *ops;
+  void *arg;
+};
+
+/* a contiguous segment of bytes. It keeps track of its generating block_source
+   so it can return itself into the pool.
+*/
+struct block {
+  byte *data;
+  int len;
+  struct block_source source;
+};
+
+/* block_source_vtable are the operations that make up block_source */
+struct block_source_vtable {
+  /* returns the size of a block source */
+  uint64_t (*size)(void *source);
+
+  /* reads a segment from the block source. It is an error to read
+     beyond the end of the block */
+  int (*read_block)(void *source, struct block *dest, uint64_t off,
+                    uint32_t size);
+  /* mark the block as read; may return the data back to malloc */
+  void (*return_block)(void *source, struct block *blockp);
+
+  /* release all resources associated with the block source */
+  void (*close)(void *source);
+};
+
+/* opens a file on the file system as a block_source */
+int block_source_from_file(struct block_source *block_src, const char *name);
+
+/* write_options sets options for writing a single reftable. */
+struct write_options {
+  /* do not pad out blocks to block size. */
+  bool unpadded;
+
+  /* the blocksize. Should be less than 2^24. */
+  uint32_t block_size;
+
+  /* do not generate a SHA1 => ref index. */
+  bool skip_index_objects;
+
+  /* how often to write complete keys in each block. */
+  int restart_interval;
+};
+
+/* ref_record holds a ref database entry target_value */
+struct ref_record {
+  char *ref_name;        /* Name of the ref, malloced. */
+  uint64_t update_index; /* Logical timestamp at which this value is written */
+  byte *value;           /* SHA1, or NULL. malloced. */
+  byte *target_value;    /* peeled annotated tag, or NULL. malloced. */
+  char *target;          /* symref, or NULL. malloced. */
+};
+
+/* returns whether 'ref' represents a deletion */
+bool ref_record_is_deletion(const struct ref_record *ref);
+
+/* prints a ref_record onto stdout */
+void ref_record_print(struct ref_record *ref, int hash_size);
+
+/* frees and nulls all pointer values. */
+void ref_record_clear(struct ref_record *ref);
+
+/* returns whether two ref_records are the same */
+bool ref_record_equal(struct ref_record *a, struct ref_record *b,
+                      int hash_size);
+
+/* log_record holds a reflog entry */
+struct log_record {
+  char *ref_name;
+  uint64_t update_index;
+  byte *new_hash;
+  byte *old_hash;
+  char *name;
+  char *email;
+  uint64_t time;
+  int16_t tz_offset;
+  char *message;
+};
+
+/* returns whether 'ref' represents the deletion of a log record. */
+bool log_record_is_deletion(const struct log_record *log);
+
+/* frees and nulls all pointer values. */
+void log_record_clear(struct log_record *log);
+
+/* returns whether two records are equal. */
+bool log_record_equal(struct log_record *a, struct log_record *b,
+                      int hash_size);
+
+void log_record_print(struct log_record *log, int hash_size);
+
+/* iterator is the generic interface for walking over data stored in a
+   reftable. It is generally passed around by value.
+*/
+struct iterator {
+  struct iterator_vtable *ops;
+  void *iter_arg;
+};
+
+/* reads the next ref_record. Returns < 0 for error, 0 for OK and > 0:
+   end of iteration.
+*/
+int iterator_next_ref(struct iterator it, struct ref_record *ref);
+
+/* reads the next log_record. Returns < 0 for error, 0 for OK and > 0:
+   end of iteration.
+*/
+int iterator_next_log(struct iterator it, struct log_record *log);
+
+/* releases resources associated with an iterator. */
+void iterator_destroy(struct iterator *it);
+
+/* block_stats holds statistics for a single block type */
+struct block_stats {
+  /* total number of entries written */
+  int entries;
+  /* total number of key restarts */
+  int restarts;
+  /* total number of blocks */
+  int blocks;
+  /* total number of index blocks */
+  int index_blocks;
+  /* depth of the index */
+  int max_index_level;
+
+  /* offset of the first block for this type */
+  uint64_t offset;
+  /* offset of the top level index block for this type, or 0 if not present */
+  uint64_t index_offset;
+};
+
+/* stats holds overall statistics for a single reftable */
+struct stats {
+  /* total number of blocks written. */
+  int blocks;
+  /* stats for ref data */
+  struct block_stats ref_stats;
+  /* stats for the SHA1 to ref map. */
+  struct block_stats obj_stats;
+  /* stats for index blocks */
+  struct block_stats idx_stats;
+  /* stats for log blocks */
+  struct block_stats log_stats;
+
+  /* disambiguation length of shortened object IDs. */
+  int object_id_len;
+};
+
+/* different types of errors */
+
+/* Unexpected file system behavior */
+#define IO_ERROR -2
+
+/* Format inconsistency on reading data
+ */
+#define FORMAT_ERROR -3
+
+/* File does not exist. Returned from block_source_from_file(),  because it
+   needs special handling in stack.
+*/
+#define NOT_EXIST_ERROR -4
+
+/* Trying to write out-of-date data. */
+#define LOCK_ERROR -5
+
+/* Misuse of the API:
+   - on writing a ref_record outside the table limits
+   - on writing a ref or log record before the stack's next_update_index
+   - on reading a ref_record from log iterator, or vice versa.
+ */
+#define API_ERROR -6
+
+/* Decompression error */
+#define ZLIB_ERROR -7
+
+const char *error_str(int err);
+
+/* new_writer creates a new writer */
+struct writer *new_writer(int (*writer_func)(void *, byte *, int),
+                          void *writer_arg, struct write_options *opts);
+
+/* write to a file descriptor. fdp should be an int* pointing to the fd. */
+int fd_writer(void *fdp, byte *data, int size);
+
+/* Set the range of update indices for the records we will add.  When
+   writing a table into a stack, the min should be at least
+   stack_next_update_index(), or API_ERROR is returned.
+ */
+void writer_set_limits(struct writer *w, uint64_t min, uint64_t max);
+
+/* adds a ref_record. Must be called in ascending
+   order. The update_index must be within the limits set by
+   writer_set_limits(), or API_ERROR is returned.
+ */
+int writer_add_ref(struct writer *w, struct ref_record *ref);
+
+/* Convenience function to add multiple refs. Will sort the refs by
+   name before adding. */
+int writer_add_refs(struct writer *w, struct ref_record *refs, int n);
+
+/* adds a log_record. Must be called in ascending order (with more
+   recent log entries first.)
+ */
+int writer_add_log(struct writer *w, struct log_record *log);
+
+/* Convenience function to add multiple logs. Will sort the records by
+   key before adding. */
+int writer_add_logs(struct writer *w, struct log_record *logs, int n);
+
+
+/* writer_close finalizes the reftable. The writer is retained so statistics can
+ * be inspected. */
+int writer_close(struct writer *w);
+
+/* writer_stats returns the statistics on the reftable being written. */
+struct stats *writer_stats(struct writer *w);
+
+/* writer_free deallocates memory for the writer */
+void writer_free(struct writer *w);
+
+struct reader;
+
+/* new_reader opens a reftable for reading. If successful, returns 0
+ * code and sets pp.  The name is used for creating a
+ * stack. Typically, it is the basename of the file.
+ */
+int new_reader(struct reader **pp, struct block_source, const char *name);
+
+/* reader_seek_ref returns an iterator where 'name' would be inserted in the
+   table.
+
+   example:
+
+   struct reader *r = NULL;
+   int err = new_reader(&r, src, "filename");
+   if (err < 0) { ... }
+   struct iterator it = {};
+   err = reader_seek_ref(r, &it, "refs/heads/master");
+   if (err < 0) { ... }
+   struct ref_record ref = {};
+   while (1) {
+     err = iterator_next_ref(it, &ref);
+     if (err > 0) {
+       break;
+     }
+     if (err < 0) {
+       ..error handling..
+     }
+     ..found..
+   }
+   iterator_destroy(&it);
+   ref_record_clear(&ref);
+ */
+int reader_seek_ref(struct reader *r, struct iterator *it, const char *name);
+
+/* seek to logs for the given name, older than update_index. */
+int reader_seek_log_at(struct reader *r, struct iterator *it, const char *name,
+                       uint64_t update_index);
+
+/* seek to newest log entry for given name. */
+int reader_seek_log(struct reader *r, struct iterator *it, const char *name);
+
+/* closes and deallocates a reader. */
+void reader_free(struct reader *);
+
+/* return an iterator for the refs pointing to oid */
+int reader_refs_for(struct reader *r, struct iterator *it, byte *oid,
+                    int oid_len);
+
+/* return the max_update_index for a table */
+uint64_t reader_max_update_index(struct reader *r);
+
+/* return the min_update_index for a table */
+uint64_t reader_min_update_index(struct reader *r);
+
+/* a merged table is implements seeking/iterating over a stack of tables. */
+struct merged_table;
+
+/* new_merged_table creates a new merged table. It takes ownership of the stack
+   array.
+*/
+int new_merged_table(struct merged_table **dest, struct reader **stack, int n);
+
+/* returns an iterator positioned just before 'name' */
+int merged_table_seek_ref(struct merged_table *mt, struct iterator *it,
+                          const char *name);
+
+/* returns an iterator for log entry, at given update_index */
+int merged_table_seek_log_at(struct merged_table *mt, struct iterator *it,
+                             const char *name, uint64_t update_index);
+
+/* like merged_table_seek_log_at but look for the newest entry. */
+int merged_table_seek_log(struct merged_table *mt, struct iterator *it,
+                          const char *name);
+
+/* returns the max update_index covered by this merged table. */
+uint64_t merged_max_update_index(struct merged_table *mt);
+
+/* returns the min update_index covered by this merged table. */
+uint64_t merged_min_update_index(struct merged_table *mt);
+
+/* closes readers for the merged tables */
+void merged_table_close(struct merged_table *mt);
+
+/* releases memory for the merged_table */
+void merged_table_free(struct merged_table *m);
+
+/* a stack is a stack of reftables, which can be mutated by pushing a table to
+ * the top of the stack */
+struct stack;
+
+/* open a new reftable stack. The tables will be stored in 'dir', while the list
+   of tables is in 'list_file'. Typically, this should be .git/reftables and
+   .git/refs respectively.
+*/
+int new_stack(struct stack **dest, const char *dir, const char *list_file,
+              struct write_options config);
+
+/* returns the update_index at which a next table should be written. */
+uint64_t stack_next_update_index(struct stack *st);
+
+/* add a new table to the stack. The write_table function must call
+   writer_set_limits, add refs and return an error value. */
+int stack_add(struct stack *st,
+              int (*write_table)(struct writer *wr, void *write_arg),
+              void *write_arg);
+
+/* returns the merged_table for seeking. This table is valid until the
+   next write or reload, and should not be closed or deleted.
+*/
+struct merged_table *stack_merged_table(struct stack *st);
+
+/* frees all resources associated with the stack. */
+void stack_destroy(struct stack *st);
+
+/* reloads the stack if necessary. */
+int stack_reload(struct stack *st);
+
+/* Policy for expiring reflog entries. */
+struct log_expiry_config {
+  /* Drop entries older than this timestamp */
+  uint64_t time;
+
+  /* Drop older entries */
+  uint64_t min_update_index;
+};
+
+/* compacts all reftables into a giant table. Expire reflog entries if config is non-NULL */
+int stack_compact_all(struct stack *st, struct log_expiry_config *config);
+
+/* heuristically compact unbalanced table stack. */
+int stack_auto_compact(struct stack *st);
+
+/* convenience function to read a single ref. Returns < 0 for error, 0
+   for success, and 1 if ref not found. */
+int stack_read_ref(struct stack *st, const char *refname,
+                   struct ref_record *ref);
+
+/* convenience function to read a single log. Returns < 0 for error, 0
+   for success, and 1 if ref not found. */
+int stack_read_log(struct stack *st, const char *refname,
+                   struct log_record *log);
+
+/* statistics on past compactions. */
+struct compaction_stats {
+  uint64_t bytes;
+  int attempts;
+  int failures;
+};
+
+struct compaction_stats *stack_compaction_stats(struct stack *st);
+
+#endif
diff --git a/reftable/reftable_test.c b/reftable/reftable_test.c
new file mode 100644
index 0000000000..8341654c49
--- /dev/null
+++ b/reftable/reftable_test.c
@@ -0,0 +1,434 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable.h"
+
+#include <string.h>
+
+#include "basics.h"
+#include "block.h"
+#include "constants.h"
+#include "reader.h"
+#include "record.h"
+#include "test_framework.h"
+
+static const int update_index = 5;
+
+void test_buffer(void) {
+  struct slice buf = {};
+
+  byte in[] = "hello";
+  slice_write(&buf, in, sizeof(in));
+  struct block_source source;
+  block_source_from_slice(&source, &buf);
+  assert(block_source_size(source) == 6);
+  struct block out = {};
+  int n = block_source_read_block(source, &out, 0, sizeof(in));
+  assert(n == sizeof(in));
+  assert(0 == memcmp(in, out.data, n));
+  block_source_return_block(source, &out);
+
+  n = block_source_read_block(source, &out, 1, 2);
+  assert(n == 2);
+  assert(0 == memcmp(out.data, "el", 2));
+
+  block_source_return_block(source, &out);
+  block_source_close(&source);
+  free(slice_yield(&buf));
+}
+
+void write_table(char ***names, struct slice *buf, int N, int block_size) {
+  *names = calloc(sizeof(char *), N + 1);
+
+  struct write_options opts = {
+      .block_size = block_size,
+  };
+
+  struct writer *w = new_writer(&slice_write_void, buf, &opts);
+
+  writer_set_limits(w, update_index, update_index);
+  {
+    struct ref_record ref = {};
+    for (int i = 0; i < N; i++) {
+      byte hash[SHA1_SIZE];
+      set_test_hash(hash, i);
+
+      char name[100];
+      sprintf(name, "refs/heads/branch%02d", i);
+
+      ref.ref_name = name;
+      ref.value = hash;
+      ref.update_index = update_index;
+      (*names)[i] = strdup(name);
+
+      fflush(stdout);
+      int n = writer_add_ref(w, &ref);
+      assert(n == 0);
+    }
+  }
+  int n = writer_close(w);
+  assert(n == 0);
+
+  struct stats *stats = writer_stats(w);
+  for (int i = 0; i < stats->ref_stats.blocks; i++) {
+    int off = i * opts.block_size;
+    if (off == 0) {
+      off = HEADER_SIZE;
+    }
+    assert(buf->buf[off] == 'r');
+  }
+
+  writer_free(w);
+  w = NULL;
+}
+
+void test_log_write_read(void) {
+  int N = 2;
+  char **names = calloc(sizeof(char *), N + 1);
+
+  struct write_options opts = {
+      .block_size = 256,
+  };
+
+  struct slice buf = {};
+  struct writer *w = new_writer(&slice_write_void, &buf, &opts);
+
+  writer_set_limits(w, 0, N);
+  {
+    struct ref_record ref = {};
+    for (int i = 0; i < N; i++) {
+      char name[256];
+      sprintf(name, "b%02d%0*d", i, 130, 7);
+      names[i] = strdup(name);
+      puts(name);
+      ref.ref_name = name;
+      ref.update_index = i;
+
+      int err = writer_add_ref(w, &ref);
+      assert_err(err);
+    }
+  }
+
+  {
+    struct log_record log = {};
+    for (int i = 0; i < N; i++) {
+      byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
+      set_test_hash(hash1, i);
+      set_test_hash(hash2, i + 1);
+
+      log.ref_name = names[i];
+      log.update_index = i;
+      log.old_hash = hash1;
+      log.new_hash = hash2;
+
+      int err = writer_add_log(w, &log);
+      assert_err(err);
+    }
+  }
+
+  int n = writer_close(w);
+  assert(n == 0);
+
+  struct stats *stats = writer_stats(w);
+  assert(stats->log_stats.blocks > 0);
+  writer_free(w);
+  w = NULL;
+
+  struct block_source source = {};
+  block_source_from_slice(&source, &buf);
+
+  struct reader rd = {};
+  int err = init_reader(&rd, source, "file.log");
+  assert(err == 0);
+
+  {
+    struct iterator it = {};
+    err = reader_seek_ref(&rd, &it, names[N-1]);
+    assert(err == 0);
+
+    struct ref_record ref = {};
+    err = iterator_next_ref(it, &ref);
+    assert_err(err);
+
+    // end of iteration.
+    err = iterator_next_ref(it, &ref);
+    assert(0 < err);
+
+    iterator_destroy(&it);
+    ref_record_clear(&ref);
+  }
+
+  {
+    struct iterator it = {};
+    err = reader_seek_log(&rd, &it, "");
+    assert(err == 0);
+
+    struct log_record log = {};
+    int i = 0;
+    while (true) {
+      int err = iterator_next_log(it, &log);
+      if (err > 0) {
+        break;
+      }
+
+      assert_err(err);
+      assert_streq(names[i], log.ref_name);
+      assert(i == log.update_index);
+      i++;
+    }
+
+    assert(i == N);
+    iterator_destroy(&it);
+  }
+
+  // cleanup.
+  free(slice_yield(&buf));
+  free_names(names);
+  reader_close(&rd);
+}
+
+void test_table_read_write_sequential(void) {
+  char **names;
+  struct slice buf = {};
+  int N = 50;
+  write_table(&names, &buf, N, 256);
+
+  struct block_source source = {};
+  block_source_from_slice(&source, &buf);
+
+  struct reader rd = {};
+  int err = init_reader(&rd, source, "file.ref");
+  assert(err == 0);
+
+  struct iterator it = {};
+  err = reader_seek_ref(&rd, &it, "");
+  assert(err == 0);
+
+  int j = 0;
+  while (true) {
+    struct ref_record ref = {};
+    int r = iterator_next_ref(it, &ref);
+    assert(r >= 0);
+    if (r > 0) {
+      break;
+    }
+    assert(0 == strcmp(names[j], ref.ref_name));
+    assert(update_index == ref.update_index);
+
+    j++;
+    ref_record_clear(&ref);
+  }
+  assert(j == N);
+  iterator_destroy(&it);
+  free(slice_yield(&buf));
+  free_names(names);
+
+  reader_close(&rd);
+}
+
+void test_table_write_small_table(void) {
+  char **names;
+  struct slice buf = {};
+  int N = 1;
+  write_table(&names, &buf, N, 4096);
+  assert(buf.len < 200);
+  free(slice_yield(&buf));
+  free_names(names);
+}
+
+void test_table_read_api(void) {
+  char **names;
+  struct slice buf = {};
+  int N = 50;
+  write_table(&names, &buf, N, 256);
+
+  struct reader rd = {};
+  struct block_source source = {};
+  block_source_from_slice(&source, &buf);
+
+  int err = init_reader(&rd, source, "file.ref");
+  assert(err == 0);
+
+  struct iterator it = {};
+  err = reader_seek_ref(&rd, &it, names[0]);
+  assert(err == 0);
+
+  struct log_record log = {};
+  err = iterator_next_log(it, &log);
+  assert(err == API_ERROR);
+
+  free(slice_yield(&buf));
+  for (int i = 0; i < N; i++) {
+    free(names[i]);
+  }
+  free(names);
+  reader_close(&rd);
+}
+
+void test_table_read_write_seek(bool index) {
+  char **names;
+  struct slice buf = {};
+  int N = 50;
+  write_table(&names, &buf, N, 256);
+
+  struct reader rd = {};
+  struct block_source source = {};
+  block_source_from_slice(&source, &buf);
+
+  int err = init_reader(&rd, source, "file.ref");
+  assert(err == 0);
+
+  if (!index) {
+    rd.ref_offsets.index_offset = 0;
+  }
+
+  for (int i = 1; i < N; i++) {
+    struct iterator it = {};
+    int err = reader_seek_ref(&rd, &it, names[i]);
+    assert(err == 0);
+    struct ref_record ref = {};
+    err = iterator_next_ref(it, &ref);
+    assert(err == 0);
+    assert(0 == strcmp(names[i], ref.ref_name));
+    assert(i == ref.value[0]);
+
+    ref_record_clear(&ref);
+    iterator_destroy(&it);
+  }
+
+  free(slice_yield(&buf));
+  for (int i = 0; i < N; i++) {
+    free(names[i]);
+  }
+  free(names);
+  reader_close(&rd);
+}
+
+void test_table_read_write_seek_linear(void) {
+  test_table_read_write_seek(false);
+}
+
+void test_table_read_write_seek_index(void) {
+  test_table_read_write_seek(true);
+}
+
+void test_table_refs_for(bool indexed) {
+  int N = 50;
+
+  char **want_names = calloc(sizeof(char *), N + 1);
+
+  int want_names_len = 0;
+  byte want_hash[SHA1_SIZE];
+  set_test_hash(want_hash, 4);
+
+  struct write_options opts = {
+      .block_size = 256,
+  };
+
+  struct slice buf = {};
+  struct writer *w = new_writer(&slice_write_void, &buf, &opts);
+  {
+    struct ref_record ref = {};
+    for (int i = 0; i < N; i++) {
+      byte hash[SHA1_SIZE];
+      memset(hash, i, sizeof(hash));
+      char fill[51] = {};
+      memset(fill, 'x', 50);
+      char name[100];
+      // Put the variable part in the start
+      sprintf(name, "br%02d%s", i, fill);
+      name[40] = 0;
+      ref.ref_name = name;
+
+      byte hash1[SHA1_SIZE];
+      byte hash2[SHA1_SIZE];
+
+      set_test_hash(hash1, i / 4);
+      set_test_hash(hash2, 3 + i / 4);
+      ref.value = hash1;
+      ref.target_value = hash2;
+
+      // 80 bytes / entry, so 3 entries per block. Yields 17 blocks.
+      int n = writer_add_ref(w, &ref);
+      assert(n == 0);
+
+      if (0 == memcmp(hash1, want_hash, SHA1_SIZE) ||
+          0 == memcmp(hash2, want_hash, SHA1_SIZE)) {
+        want_names[want_names_len++] = strdup(name);
+      }
+    }
+  }
+
+  int n = writer_close(w);
+  assert(n == 0);
+
+  writer_free(w);
+  w = NULL;
+
+  struct reader rd;
+  struct block_source source = {};
+  block_source_from_slice(&source, &buf);
+
+  int err = init_reader(&rd, source, "file.ref");
+  assert(err == 0);
+  if (!indexed) {
+    rd.obj_offsets.present = 0;
+  }
+
+  struct iterator it = {};
+  err = reader_seek_ref(&rd, &it, "");
+  assert(err == 0);
+  iterator_destroy(&it);
+
+  err = reader_refs_for(&rd, &it, want_hash, SHA1_SIZE);
+  assert(err == 0);
+
+  struct ref_record ref = {};
+
+  int j = 0;
+  while (true) {
+    int err = iterator_next_ref(it, &ref);
+    assert(err >= 0);
+    if (err > 0) {
+      break;
+    }
+
+    assert(j < want_names_len);
+    assert(0 == strcmp(ref.ref_name, want_names[j]));
+    j++;
+    ref_record_clear(&ref);
+  }
+  assert(j == want_names_len);
+
+  free(slice_yield(&buf));
+  free_names(want_names);
+  iterator_destroy(&it);
+  reader_close(&rd);
+}
+
+void test_table_refs_for_no_index(void) { test_table_refs_for(false); }
+
+void test_table_refs_for_obj_index(void) { test_table_refs_for(true); }
+
+int main() {
+  add_test_case("test_log_write_read", test_log_write_read);
+  add_test_case("test_table_write_small_table", &test_table_write_small_table);
+  add_test_case("test_buffer", &test_buffer);
+  add_test_case("test_table_read_api", &test_table_read_api);
+  add_test_case("test_table_read_write_sequential",
+                &test_table_read_write_sequential);
+  add_test_case("test_table_read_write_seek_linear",
+                &test_table_read_write_seek_linear);
+  add_test_case("test_table_read_write_seek_index",
+                &test_table_read_write_seek_index);
+  add_test_case("test_table_read_write_refs_for_no_index",
+                &test_table_refs_for_no_index);
+  add_test_case("test_table_read_write_refs_for_obj_index",
+                &test_table_refs_for_obj_index);
+  test_main();
+}
diff --git a/reftable/slice.c b/reftable/slice.c
new file mode 100644
index 0000000000..d4e4b5c532
--- /dev/null
+++ b/reftable/slice.c
@@ -0,0 +1,179 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "slice.h"
+
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "reftable.h"
+
+void slice_set_string(struct slice *s, const char *str) {
+  if (str == NULL) {
+    s->len = 0;
+    return;
+  }
+
+  {
+    int l = strlen(str);
+    l++;  // \0
+    slice_resize(s, l);
+    memcpy(s->buf, str, l);
+    s->len = l - 1;
+  }
+}
+
+void slice_resize(struct slice *s, int l) {
+  if (s->cap < l) {
+    int c = s->cap * 2;
+    if (c < l) {
+      c = l;
+    }
+    s->cap = c;
+    s->buf = realloc(s->buf, s->cap);
+  }
+  s->len = l;
+}
+
+void slice_append_string(struct slice *d, const char *s) {
+  int l1 = d->len;
+  int l2 = strlen(s);
+
+  slice_resize(d, l2 + l1);
+  memcpy(d->buf + l1, s, l2);
+}
+
+void slice_append(struct slice *s, struct slice a) {
+  int end = s->len;
+  slice_resize(s, s->len + a.len);
+  memcpy(s->buf + end, a.buf, a.len);
+}
+
+byte *slice_yield(struct slice *s) {
+  byte *p = s->buf;
+  s->buf = NULL;
+  s->cap = 0;
+  s->len = 0;
+  return p;
+}
+
+void slice_copy(struct slice *dest, struct slice src) {
+  slice_resize(dest, src.len);
+  memcpy(dest->buf, src.buf, src.len);
+}
+
+/* return the underlying data as char*. len is left unchanged, but
+   a \0 is added at the end. */
+const char *slice_as_string(struct slice *s) {
+  if (s->cap == s->len) {
+    int l = s->len;
+    slice_resize(s, l + 1);
+    s->len = l;
+  }
+  s->buf[s->len] = 0;
+  return (const char *)s->buf;
+}
+
+/* return a newly malloced string for this slice */
+char *slice_to_string(struct slice in) {
+  struct slice s = {};
+  slice_resize(&s, in.len + 1);
+  s.buf[in.len] = 0;
+  memcpy(s.buf, in.buf, in.len);
+  return (char *)slice_yield(&s);
+}
+
+bool slice_equal(struct slice a, struct slice b) {
+  if (a.len != b.len) {
+    return 0;
+  }
+  return memcmp(a.buf, b.buf, a.len) == 0;
+}
+
+int slice_compare(struct slice a, struct slice b) {
+  int min = a.len < b.len ? a.len : b.len;
+  int res = memcmp(a.buf, b.buf, min);
+  if (res != 0) {
+    return res;
+  }
+  if (a.len < b.len) {
+    return -1;
+  } else if (a.len > b.len) {
+    return 1;
+  } else {
+    return 0;
+  }
+}
+
+int slice_write(struct slice *b, byte *data, int sz) {
+  if (b->len + sz > b->cap) {
+    int newcap = 2 * b->cap + 1;
+    if (newcap < b->len + sz) {
+      newcap = (b->len + sz);
+    }
+    b->buf = realloc(b->buf, newcap);
+    b->cap = newcap;
+  }
+
+  memcpy(b->buf + b->len, data, sz);
+  b->len += sz;
+  return sz;
+}
+
+int slice_write_void(void *b, byte *data, int sz) {
+  return slice_write((struct slice *)b, data, sz);
+}
+
+static uint64_t slice_size(void *b) { return ((struct slice *)b)->len; }
+
+static void slice_return_block(void *b, struct block *dest) {
+  memset(dest->data, 0xff, dest->len);
+  free(dest->data);
+}
+
+static void slice_close(void *b) {}
+
+static int slice_read_block(void *v, struct block *dest, uint64_t off,
+                            uint32_t size) {
+  struct slice *b = (struct slice *)v;
+  assert(off + size <= b->len);
+  dest->data = calloc(size, 1);
+  memcpy(dest->data, b->buf + off, size);
+  dest->len = size;
+  return size;
+}
+
+struct block_source_vtable slice_vtable = {
+    .size = &slice_size,
+    .read_block = &slice_read_block,
+    .return_block = &slice_return_block,
+    .close = &slice_close,
+};
+
+void block_source_from_slice(struct block_source *bs, struct slice *buf) {
+  bs->ops = &slice_vtable;
+  bs->arg = buf;
+}
+
+static void malloc_return_block(void *b, struct block *dest) {
+  memset(dest->data, 0xff, dest->len);
+  free(dest->data);
+}
+
+struct block_source_vtable malloc_vtable = {
+    .return_block = &malloc_return_block,
+};
+
+struct block_source malloc_block_source_instance = {
+    .ops = &malloc_vtable,
+};
+
+struct block_source malloc_block_source(void) {
+  return malloc_block_source_instance;
+}
diff --git a/reftable/slice.h b/reftable/slice.h
new file mode 100644
index 0000000000..6a304f31f4
--- /dev/null
+++ b/reftable/slice.h
@@ -0,0 +1,39 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef SLICE_H
+#define SLICE_H
+
+#include "basics.h"
+#include "reftable.h"
+
+struct slice {
+  byte *buf;
+  int len;
+  int cap;
+};
+
+void slice_set_string(struct slice *dest, const char *);
+void slice_append_string(struct slice *dest, const char *);
+char *slice_to_string(struct slice src);
+const char *slice_as_string(struct slice *src);
+bool slice_equal(struct slice a, struct slice b);
+byte *slice_yield(struct slice *s);
+void slice_copy(struct slice *dest, struct slice src);
+void slice_resize(struct slice *s, int l);
+int slice_compare(struct slice a, struct slice b);
+int slice_write(struct slice *b, byte *data, int sz);
+int slice_write_void(void *b, byte *data, int sz);
+void slice_append(struct slice *dest, struct slice add);
+
+struct block_source;
+void block_source_from_slice(struct block_source *bs, struct slice *buf);
+
+struct block_source malloc_block_source(void);
+
+#endif
diff --git a/reftable/slice_test.c b/reftable/slice_test.c
new file mode 100644
index 0000000000..c2c0545b70
--- /dev/null
+++ b/reftable/slice_test.c
@@ -0,0 +1,38 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "slice.h"
+
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "basics.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+
+void test_slice(void) {
+  struct slice s = {};
+  slice_set_string(&s, "abc");
+  assert(0 == strcmp("abc", slice_as_string(&s)));
+
+  struct slice t = {};
+  slice_set_string(&t, "pqr");
+
+  slice_append(&s, t);
+  assert(0 == strcmp("abcpqr", slice_as_string(&s)));
+
+  free(slice_yield(&s));
+  free(slice_yield(&t));
+}
+
+int main() {
+  add_test_case("test_slice", &test_slice);
+  test_main();
+}
diff --git a/reftable/stack.c b/reftable/stack.c
new file mode 100644
index 0000000000..641ac521dd
--- /dev/null
+++ b/reftable/stack.c
@@ -0,0 +1,931 @@
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
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "merged.h"
+#include "reader.h"
+#include "reftable.h"
+#include "writer.h"
+
+int new_stack(struct stack **dest, const char *dir, const char *list_file,
+              struct write_options config) {
+  struct stack *p = calloc(sizeof(struct stack), 1);
+  int err = 0;
+  *dest = NULL;
+  p->list_file = strdup(list_file);
+  p->reftable_dir = strdup(dir);
+  p->config = config;
+
+  err = stack_reload(p);
+  if (err < 0) {
+    stack_destroy(p);
+  } else {
+    *dest = p;
+  }
+  return err;
+}
+
+static int fread_lines(FILE *f, char ***namesp) {
+  long size = 0;
+  int err = fseek(f, 0, SEEK_END);
+  char *buf = NULL;
+  if (err < 0) {
+    err = IO_ERROR;
+    goto exit;
+  }
+  size = ftell(f);
+  if (size < 0) {
+    err = IO_ERROR;
+    goto exit;
+  }
+  err = fseek(f, 0, SEEK_SET);
+  if (err < 0) {
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  buf = malloc(size + 1);
+  if (fread(buf, 1, size, f) != size) {
+    err = IO_ERROR;
+    goto exit;
+  }
+  buf[size] = 0;
+
+  parse_names(buf, size, namesp);
+exit:
+  free(buf);
+  return err;
+}
+
+int read_lines(const char *filename, char ***namesp) {
+  FILE *f = fopen(filename, "r");
+  int err = 0;
+  if (f == NULL) {
+    if (errno == ENOENT) {
+      *namesp = calloc(sizeof(char *), 1);
+      return 0;
+    }
+
+    return IO_ERROR;
+  }
+  err = fread_lines(f, namesp);
+  fclose(f);
+  return err;
+}
+
+struct merged_table *stack_merged_table(struct stack *st) {
+  return st->merged;
+}
+
+/* Close and free the stack */
+void stack_destroy(struct stack *st) {
+  if (st->merged == NULL) {
+    return;
+  }
+
+  merged_table_close(st->merged);
+  merged_table_free(st->merged);
+  st->merged = NULL;
+
+  free(st->list_file);
+  st->list_file = NULL;
+  free(st->reftable_dir);
+  st->reftable_dir = NULL;
+  free(st);
+}
+
+static struct reader **stack_copy_readers(struct stack *st, int cur_len) {
+  struct reader **cur = calloc(sizeof(struct reader *), cur_len);
+  for (int i = 0; i < cur_len; i++) {
+    cur[i] = st->merged->stack[i];
+  }
+  return cur;
+}
+
+static int stack_reload_once(struct stack *st, char **names, bool reuse_open) {
+  int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
+  struct reader **cur = stack_copy_readers(st, cur_len);
+  int err = 0;
+  int names_len = names_length(names);
+  struct reader **new_tables = malloc(sizeof(struct reader *) * names_len);
+  int new_tables_len = 0;
+  struct merged_table *new_merged = NULL;
+
+  struct slice table_path = {};
+
+  while (*names) {
+    struct reader *rd = NULL;
+    char *name = *names++;
+
+    // this is linear; we assume compaction keeps the number of tables
+    // under control so this is not quadratic.
+    for (int j = 0; reuse_open && j < cur_len; j++) {
+      if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
+        rd = cur[j];
+        cur[j] = NULL;
+        break;
+      }
+    }
+
+    if (rd == NULL) {
+      struct block_source src = {};
+      slice_set_string(&table_path, st->reftable_dir);
+      slice_append_string(&table_path, "/");
+      slice_append_string(&table_path, name);
+
+      err = block_source_from_file(&src, slice_as_string(&table_path));
+      if (err < 0) {
+        goto exit;
+      }
+
+      err = new_reader(&rd, src, name);
+      if (err < 0) {
+        goto exit;
+      }
+    }
+
+    new_tables[new_tables_len++] = rd;
+  }
+
+  // success!
+  err = new_merged_table(&new_merged, new_tables, new_tables_len);
+  if (err < 0) {
+    goto exit;
+  }
+
+  new_tables = NULL;
+  new_tables_len = 0;
+  if (st->merged != NULL) {
+    merged_table_clear(st->merged);
+    merged_table_free(st->merged);
+  }
+  st->merged = new_merged;
+
+  for (int i = 0; i < cur_len; i++) {
+    if (cur[i] != NULL) {
+      reader_close(cur[i]);
+      reader_free(cur[i]);
+    }
+  }
+
+exit:
+  free(slice_yield(&table_path));
+  for (int i = 0; i < new_tables_len; i++) {
+    reader_close(new_tables[i]);
+  }
+  free(new_tables);
+  free(cur);
+  return err;
+}
+
+// return negative if a before b.
+static int tv_cmp(struct timeval *a, struct timeval *b) {
+  time_t diff = a->tv_sec - b->tv_sec;
+  suseconds_t udiff = a->tv_usec - b->tv_usec;
+
+  if (diff != 0) {
+    return diff;
+  }
+
+  return udiff;
+}
+
+static int stack_reload_maybe_reuse(struct stack *st, bool reuse_open) {
+  struct timeval deadline = {};
+  int err = gettimeofday(&deadline, NULL);
+  int64_t delay = 0;
+  int tries = 0;
+  if (err < 0) {
+    return err;
+  }
+
+  deadline.tv_sec += 3;
+  while (true) {
+    char **names = NULL;
+    char **names_after = NULL;
+    struct timeval now = {};
+    int err = gettimeofday(&now, NULL);
+    if (err < 0) {
+      return err;
+    }
+
+    // Only look at deadlines after the first few times. This
+    // simplifies debugging in GDB
+    tries++;
+    if (tries > 3 && tv_cmp(&now, &deadline) >= 0) {
+      break;
+    }
+
+    err = read_lines(st->list_file, &names);
+    if (err < 0) {
+      free_names(names);
+      return err;
+    }
+    err = stack_reload_once(st, names, reuse_open);
+    if (err == 0) {
+      free_names(names);
+      break;
+    }
+    if (err != NOT_EXIST_ERROR) {
+      free_names(names);
+      return err;
+    }
+
+    err = read_lines(st->list_file, &names_after);
+    if (err < 0) {
+      free_names(names);
+      return err;
+    }
+
+    if (names_equal(names_after, names)) {
+      free_names(names);
+      free_names(names_after);
+      return -1;
+    }
+    free_names(names);
+    free_names(names_after);
+
+    delay = delay + (delay * rand()) / RAND_MAX + 100;
+    usleep(delay);
+  }
+
+  return 0;
+}
+
+int stack_reload(struct stack *st) {
+  return stack_reload_maybe_reuse(st, true);
+}
+
+// -1 = error
+// 0 = up to date
+// 1 = changed.
+static int stack_uptodate(struct stack *st) {
+  char **names = NULL;
+  int err = read_lines(st->list_file, &names);
+  if (err < 0) {
+    return err;
+  }
+
+  for (int i = 0; i < st->merged->stack_len; i++) {
+    if (names[i] == NULL) {
+      err = 1;
+      goto exit;
+    }
+
+    if (0 != strcmp(st->merged->stack[i]->name, names[i])) {
+      err = 1;
+      goto exit;
+    }
+  }
+
+  if (names[st->merged->stack_len] != NULL) {
+    err = 1;
+    goto exit;
+  }
+
+exit:
+  free_names(names);
+  return err;
+}
+
+int stack_add(struct stack *st, int (*write)(struct writer *wr, void *arg),
+              void *arg) {
+  int err = stack_try_add(st, write, arg);
+  if (err < 0) {
+    if (err == LOCK_ERROR) {
+      err = stack_reload(st);
+    }
+    return err;
+  }
+
+  return stack_auto_compact(st);
+}
+
+static void format_name(struct slice *dest, uint64_t min, uint64_t max) {
+  char buf[1024];
+  sprintf(buf, "%012lx-%012lx", min, max);
+  slice_set_string(dest, buf);
+}
+
+int stack_try_add(struct stack *st,
+                  int (*write_table)(struct writer *wr, void *arg), void *arg) {
+  struct slice lock_name = {};
+  struct slice temp_tab_name = {};
+  struct slice tab_name = {};
+  struct slice next_name = {};
+  struct slice table_list = {};
+  struct writer *wr = NULL;
+  int err = 0;
+  int tab_fd = 0;
+  int lock_fd = 0;
+  uint64_t next_update_index = 0;
+
+  slice_set_string(&lock_name, st->list_file);
+  slice_append_string(&lock_name, ".lock");
+
+  lock_fd =
+      open(slice_as_string(&lock_name), O_EXCL | O_CREAT | O_WRONLY, 0644);
+  if (lock_fd < 0) {
+    if (errno == EEXIST) {
+      err = LOCK_ERROR;
+      goto exit;
+    }
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  err = stack_uptodate(st);
+  if (err < 0) {
+    goto exit;
+  }
+
+  if (err > 1) {
+    err = LOCK_ERROR;
+    goto exit;
+  }
+
+  next_update_index = stack_next_update_index(st);
+
+  slice_resize(&next_name, 0);
+  format_name(&next_name, next_update_index, next_update_index);
+
+  slice_set_string(&temp_tab_name, st->reftable_dir);
+  slice_append_string(&temp_tab_name, "/");
+  slice_append(&temp_tab_name, next_name);
+  slice_append_string(&temp_tab_name, "XXXXXX");
+
+  tab_fd = mkstemp((char *)slice_as_string(&temp_tab_name));
+  if (tab_fd < 0) {
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  wr = new_writer(fd_writer, &tab_fd, &st->config);
+  err = write_table(wr, arg);
+  if (err < 0) {
+    goto exit;
+  }
+
+  err = writer_close(wr);
+  if (err < 0) {
+    goto exit;
+  }
+
+  err = close(tab_fd);
+  tab_fd = 0;
+  if (err < 0) {
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  if (wr->min_update_index < next_update_index) {
+    err = API_ERROR;
+    goto exit;
+  }
+
+  for (int i = 0; i < st->merged->stack_len; i++) {
+    slice_append_string(&table_list, st->merged->stack[i]->name);
+    slice_append_string(&table_list, "\n");
+  }
+
+  format_name(&next_name, wr->min_update_index, wr->max_update_index);
+  slice_append_string(&next_name, ".ref");
+  slice_append(&table_list, next_name);
+  slice_append_string(&table_list, "\n");
+
+  slice_set_string(&tab_name, st->reftable_dir);
+  slice_append_string(&tab_name, "/");
+  slice_append(&tab_name, next_name);
+
+  err = rename(slice_as_string(&temp_tab_name), slice_as_string(&tab_name));
+  if (err < 0) {
+    err = IO_ERROR;
+    goto exit;
+  }
+  free(slice_yield(&temp_tab_name));
+
+  err = write(lock_fd, table_list.buf, table_list.len);
+  if (err < 0) {
+    err = IO_ERROR;
+    goto exit;
+  }
+  err = close(lock_fd);
+  lock_fd = 0;
+  if (err < 0) {
+    unlink(slice_as_string(&tab_name));
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  err = rename(slice_as_string(&lock_name), st->list_file);
+  if (err < 0) {
+    unlink(slice_as_string(&tab_name));
+    err = IO_ERROR;
+    goto exit;
+  }
+
+  err = stack_reload(st);
+exit:
+  if (tab_fd > 0) {
+    close(tab_fd);
+    tab_fd = 0;
+  }
+  if (temp_tab_name.len > 0) {
+    unlink(slice_as_string(&temp_tab_name));
+  }
+  unlink(slice_as_string(&lock_name));
+
+  if (lock_fd > 0) {
+    close(lock_fd);
+    lock_fd = 0;
+  }
+
+  free(slice_yield(&lock_name));
+  free(slice_yield(&temp_tab_name));
+  free(slice_yield(&tab_name));
+  free(slice_yield(&next_name));
+  free(slice_yield(&table_list));
+  writer_free(wr);
+  return err;
+}
+
+uint64_t stack_next_update_index(struct stack *st) {
+  int sz = st->merged->stack_len;
+  if (sz > 0) {
+    return reader_max_update_index(st->merged->stack[sz - 1]) + 1;
+  }
+  return 1;
+}
+
+static int stack_compact_locked(struct stack *st, int first, int last,
+                                struct slice *temp_tab, struct log_expiry_config *config) {
+  struct slice next_name = {};
+  int tab_fd = -1;
+  struct writer *wr = NULL;
+  int err = 0;
+
+  format_name(&next_name, reader_min_update_index(st->merged->stack[first]),
+              reader_max_update_index(st->merged->stack[first]));
+
+  slice_set_string(temp_tab, st->reftable_dir);
+  slice_append_string(temp_tab, "/");
+  slice_append(temp_tab, next_name);
+  slice_append_string(temp_tab, "XXXXXX");
+
+  tab_fd = mkstemp((char *)slice_as_string(temp_tab));
+  wr = new_writer(fd_writer, &tab_fd, &st->config);
+
+  err = stack_write_compact(st, wr, first, last, config);
+  if (err < 0) {
+    goto exit;
+  }
+  err = writer_close(wr);
+  if (err < 0) {
+    goto exit;
+  }
+  writer_free(wr);
+
+  err = close(tab_fd);
+  tab_fd = 0;
+
+exit:
+  if (tab_fd > 0) {
+    close(tab_fd);
+    tab_fd = 0;
+  }
+  if (err != 0 && temp_tab->len > 0) {
+    unlink(slice_as_string(temp_tab));
+    free(slice_yield(temp_tab));
+  }
+  free(slice_yield(&next_name));
+  return err;
+}
+
+int stack_write_compact(struct stack *st, struct writer *wr, int first,
+                        int last, struct log_expiry_config *config) {
+  int subtabs_len = last - first + 1;
+  struct reader **subtabs = calloc(sizeof(struct reader *), last - first + 1);
+  struct merged_table *mt = NULL;
+  int err = 0;
+  struct iterator it = {};
+  struct ref_record ref = {};
+  struct log_record log = {};
+
+  for (int i = first, j = 0; i <= last; i++) {
+    struct reader *t = st->merged->stack[i];
+    subtabs[j++] = t;
+    st->stats.bytes += t->size;
+  }
+  writer_set_limits(wr, st->merged->stack[first]->min_update_index,
+                    st->merged->stack[last]->max_update_index);
+
+  err = new_merged_table(&mt, subtabs, subtabs_len);
+  if (err < 0) {
+    free(subtabs);
+    goto exit;
+  }
+
+  err = merged_table_seek_ref(mt, &it, "");
+  if (err < 0) {
+    goto exit;
+  }
+
+  while (true) {
+    err = iterator_next_ref(it, &ref);
+    if (err > 0) {
+      err = 0;
+      break;
+    }
+    if (err < 0) {
+      break;
+    }
+    if (first == 0 && ref_record_is_deletion(&ref)) {
+      continue;
+    }
+
+    err = writer_add_ref(wr, &ref);
+    if (err < 0) {
+      break;
+    }
+  }
+
+  err = merged_table_seek_log(mt, &it, "");
+  if (err < 0) {
+    goto exit;
+  }
+
+  while (true) {
+    err = iterator_next_log(it, &log);
+    if (err > 0) {
+      err = 0;
+      break;
+    }
+    if (err < 0) {
+      break;
+    }
+    if (first == 0 && log_record_is_deletion(&log)) {
+      continue;
+    }
+
+    // XXX collect stats?
+
+    if (config != NULL && config->time > 0 && log.time < config->time) {
+      continue;
+    }
+
+    if (config != NULL && config->min_update_index > 0 && log.update_index < config->min_update_index) {
+      continue;
+    }
+
+    err = writer_add_log(wr, &log);
+    if (err < 0) {
+      break;
+    }
+  }
+
+
+exit:
+  iterator_destroy(&it);
+  if (mt != NULL) {
+    merged_table_clear(mt);
+    merged_table_free(mt);
+  }
+  ref_record_clear(&ref);
+
+  return err;
+}
+
+// <  0: error. 0 == OK, > 0 attempt failed; could retry.
+static int stack_compact_range(struct stack *st, int first, int last, struct log_expiry_config *expiry) {
+  struct slice temp_tab_name = {};
+  struct slice new_table_name = {};
+  struct slice lock_file_name = {};
+  struct slice ref_list_contents = {};
+  struct slice new_table_path = {};
+  int err = 0;
+  bool have_lock = false;
+  int lock_file_fd = 0;
+  int compact_count = last - first + 1;
+  char **delete_on_success = calloc(sizeof(char *), compact_count + 1);
+  char **subtable_locks = calloc(sizeof(char *), compact_count + 1);
+
+  if (first > last || (expiry == NULL && first == last)) {
+    err = 0;
+    goto exit;
+  }
+
+  st->stats.attempts++;
+
+  slice_set_string(&lock_file_name, st->list_file);
+  slice_append_string(&lock_file_name, ".lock");
+
+  lock_file_fd =
+      open(slice_as_string(&lock_file_name), O_EXCL | O_CREAT | O_WRONLY, 0644);
+  if (lock_file_fd < 0) {
+    if (errno == EEXIST) {
+      err = 1;
+    } else {
+      err = IO_ERROR;
+    }
+    goto exit;
+  }
+  have_lock = true;
+  err = stack_uptodate(st);
+  if (err != 0) {
+    goto exit;
+  }
+
+  for (int i = first, j = 0; i <= last; i++) {
+    struct slice subtab_name = {};
+    struct slice subtab_lock = {};
+    slice_set_string(&subtab_name, st->reftable_dir);
+    slice_append_string(&subtab_name, "/");
+    slice_append_string(&subtab_name, reader_name(st->merged->stack[i]));
+
+    slice_copy(&subtab_lock, subtab_name);
+    slice_append_string(&subtab_lock, ".lock");
+
+    {
+      int sublock_file_fd = open(slice_as_string(&subtab_lock),
+                                 O_EXCL | O_CREAT | O_WRONLY, 0644);
+      if (sublock_file_fd > 0) {
+        close(sublock_file_fd);
+      } else if (sublock_file_fd < 0) {
+        if (errno == EEXIST) {
+          err = 1;
+        }
+        err = IO_ERROR;
+      }
+    }
+
+    subtable_locks[j] = (char *)slice_as_string(&subtab_lock);
+    delete_on_success[j] = (char *)slice_as_string(&subtab_name);
+    j++;
+
+    if (err != 0) {
+      goto exit;
+    }
+  }
+
+  err = unlink(slice_as_string(&lock_file_name));
+  if (err < 0) {
+    goto exit;
+  }
+  have_lock = false;
+
+  err = stack_compact_locked(st, first, last, &temp_tab_name, expiry);
+  if (err < 0) {
+    goto exit;
+  }
+
+  lock_file_fd =
+      open(slice_as_string(&lock_file_name), O_EXCL | O_CREAT | O_WRONLY, 0644);
+  if (lock_file_fd < 0) {
+    if (errno == EEXIST) {
+      err = 1;
+    } else {
+      err = IO_ERROR;
+    }
+    goto exit;
+  }
+  have_lock = true;
+
+  format_name(&new_table_name, st->merged->stack[first]->min_update_index,
+              st->merged->stack[last]->max_update_index);
+  slice_append_string(&new_table_name, ".ref");
+
+  slice_set_string(&new_table_path, st->reftable_dir);
+  slice_append_string(&new_table_path, "/");
+
+  slice_append(&new_table_path, new_table_name);
+
+  err =
+      rename(slice_as_string(&temp_tab_name), slice_as_string(&new_table_path));
+  if (err < 0) {
+    goto exit;
+  }
+
+  for (int i = 0; i < first; i++) {
+    slice_append_string(&ref_list_contents, st->merged->stack[i]->name);
+    slice_append_string(&ref_list_contents, "\n");
+  }
+  slice_append(&ref_list_contents, new_table_name);
+  slice_append_string(&ref_list_contents, "\n");
+  for (int i = last + 1; i < st->merged->stack_len; i++) {
+    slice_append_string(&ref_list_contents, st->merged->stack[i]->name);
+    slice_append_string(&ref_list_contents, "\n");
+  }
+
+  err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
+  if (err < 0) {
+    unlink(slice_as_string(&new_table_path));
+    goto exit;
+  }
+  err = close(lock_file_fd);
+  lock_file_fd = 0;
+  if (err < 0) {
+    unlink(slice_as_string(&new_table_path));
+    goto exit;
+  }
+
+  err = rename(slice_as_string(&lock_file_name), st->list_file);
+  if (err < 0) {
+    unlink(slice_as_string(&new_table_path));
+    goto exit;
+  }
+  have_lock = false;
+
+  for (char **p = delete_on_success; *p; p++) {
+    if (0 != strcmp(*p, slice_as_string(&new_table_path))) {
+      unlink(*p);
+    }
+  }
+
+  err = stack_reload_maybe_reuse(st, first < last);
+exit:
+  for (char **p = subtable_locks; *p; p++) {
+    unlink(*p);
+  }
+  free_names(delete_on_success);
+  free_names(subtable_locks);
+  if (lock_file_fd > 0) {
+    close(lock_file_fd);
+    lock_file_fd = 0;
+  }
+  if (have_lock) {
+    unlink(slice_as_string(&lock_file_name));
+  }
+  free(slice_yield(&new_table_name));
+  free(slice_yield(&new_table_path));
+  free(slice_yield(&ref_list_contents));
+  free(slice_yield(&temp_tab_name));
+  free(slice_yield(&lock_file_name));
+  return err;
+}
+
+int stack_compact_all(struct stack *st, struct log_expiry_config *config) {
+  return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
+}
+
+static int stack_compact_range_stats(struct stack *st, int first, int last, struct log_expiry_config *config) {
+  int err = stack_compact_range(st, first, last, config);
+  if (err > 0) {
+    st->stats.failures++;
+  }
+  return err;
+}
+
+static int segment_size(struct segment *s) { return s->end - s->start; }
+
+int fastlog2(uint64_t sz) {
+  int l = 0;
+  assert(sz > 0);
+  for (; sz; sz /= 2) {
+    l++;
+  }
+  return l - 1;
+}
+
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n) {
+  struct segment *segs = calloc(sizeof(struct segment), n);
+  int next = 0;
+  struct segment cur = {};
+  for (int i = 0; i < n; i++) {
+    int log = fastlog2(sizes[i]);
+    if (cur.log != log && cur.bytes > 0) {
+      struct segment fresh = {
+          .start = i,
+      };
+
+      segs[next++] = cur;
+      cur = fresh;
+    }
+
+    cur.log = log;
+    cur.end = i + 1;
+    cur.bytes += sizes[i];
+  }
+
+  segs[next++] = cur;
+  *seglen = next;
+  return segs;
+}
+
+struct segment suggest_compaction_segment(uint64_t *sizes, int n) {
+  int seglen = 0;
+  struct segment *segs = sizes_to_segments(&seglen, sizes, n);
+  struct segment min_seg = {
+      .log = 64,
+  };
+  for (int i = 0; i < seglen; i++) {
+    if (segment_size(&segs[i]) == 1) {
+      continue;
+    }
+
+    if (segs[i].log < min_seg.log) {
+      min_seg = segs[i];
+    }
+  }
+
+  while (min_seg.start > 0) {
+    int prev = min_seg.start - 1;
+    if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev])) {
+      break;
+    }
+
+    min_seg.start = prev;
+    min_seg.bytes += sizes[prev];
+  }
+
+  free(segs);
+  return min_seg;
+}
+
+static uint64_t *stack_table_sizes_for_compaction(struct stack *st) {
+  uint64_t *sizes = calloc(sizeof(uint64_t), st->merged->stack_len);
+  for (int i = 0; i < st->merged->stack_len; i++) {
+    // overhead is 24 + 68 = 92.
+    sizes[i] = st->merged->stack[i]->size - 91;
+  }
+  return sizes;
+}
+
+int stack_auto_compact(struct stack *st) {
+  uint64_t *sizes = stack_table_sizes_for_compaction(st);
+  struct segment seg = suggest_compaction_segment(sizes, st->merged->stack_len);
+  free(sizes);
+  if (segment_size(&seg) > 0) {
+    return stack_compact_range_stats(st, seg.start, seg.end - 1, NULL);
+  }
+
+  return 0;
+}
+
+struct compaction_stats *stack_compaction_stats(struct stack *st) {
+  return &st->stats;
+}
+
+int stack_read_ref(struct stack *st, const char *refname,
+                   struct ref_record *ref) {
+  struct iterator it = {};
+  struct merged_table *mt = stack_merged_table(st);
+  int err = merged_table_seek_ref(mt, &it, refname);
+  if (err) {
+    goto exit;
+  }
+
+  err = iterator_next_ref(it, ref);
+  if (err) {
+    goto exit;
+  }
+
+  if (0 != strcmp(ref->ref_name, refname) || ref_record_is_deletion(ref)) {
+    err = 1;
+    goto exit;
+  }
+
+exit:
+  iterator_destroy(&it);
+  return err;
+}
+
+int stack_read_log(struct stack *st, const char *refname,
+                   struct log_record *log) {
+  struct iterator it = {};
+  struct merged_table *mt = stack_merged_table(st);
+  int err = merged_table_seek_log(mt, &it, refname);
+  if (err) {
+    goto exit;
+  }
+
+  err = iterator_next_log(it, log);
+  if (err) {
+    goto exit;
+  }
+
+  if (0 != strcmp(log->ref_name, refname) || log_record_is_deletion(log)) {
+    err = 1;
+    goto exit;
+  }
+
+exit:
+  iterator_destroy(&it);
+  return err;
+}
diff --git a/reftable/stack.h b/reftable/stack.h
new file mode 100644
index 0000000000..092a03b894
--- /dev/null
+++ b/reftable/stack.h
@@ -0,0 +1,40 @@
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
+#include "reftable.h"
+
+struct stack {
+  char *list_file;
+  char *reftable_dir;
+
+  struct write_options config;
+
+  struct merged_table *merged;
+  struct compaction_stats stats;
+};
+
+int read_lines(const char *filename, char ***lines);
+int stack_try_add(struct stack *st,
+                  int (*write_table)(struct writer *wr, void *arg), void *arg);
+int stack_write_compact(struct stack *st, struct writer *wr, int first,
+                        int last, struct log_expiry_config *config);
+int fastlog2(uint64_t sz);
+
+struct segment {
+  int start, end;
+  int log;
+  uint64_t bytes;
+};
+
+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
+struct segment suggest_compaction_segment(uint64_t *sizes, int n);
+
+#endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
new file mode 100644
index 0000000000..8c0cde0579
--- /dev/null
+++ b/reftable/stack_test.c
@@ -0,0 +1,265 @@
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
+#include <string.h>
+#include <unistd.h>
+
+#include "basics.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+
+void test_read_file(void) {
+  char fn[256] = "/tmp/stack.XXXXXX";
+  int fd = mkstemp(fn);
+  assert(fd > 0);
+
+  char out[1024] = "line1\n\nline2\nline3";
+
+  int n = write(fd, out, strlen(out));
+  assert(n == strlen(out));
+  int err = close(fd);
+  assert(err >= 0);
+
+  char **names = NULL;
+  err = read_lines(fn, &names);
+  assert_err(err);
+
+  char *want[] = {"line1", "line2", "line3"};
+  for (int i = 0; names[i] != NULL; i++) {
+    assert(0 == strcmp(want[i], names[i]));
+  }
+  free_names(names);
+  remove(fn);
+}
+
+void test_parse_names(void) {
+  char buf[] = "line\n";
+  char **names = NULL;
+  parse_names(buf, strlen(buf), &names);
+
+  assert(NULL != names[0]);
+  assert(0 == strcmp(names[0], "line"));
+  assert(NULL == names[1]);
+  free_names(names);
+}
+
+void test_names_equal(void) {
+  char *a[] = {"a", "b", "c", NULL};
+  char *b[] = {"a", "b", "d", NULL};
+  char *c[] = {"a", "b", NULL};
+
+  assert(names_equal(a, a));
+  assert(!names_equal(a, b));
+  assert(!names_equal(a, c));
+}
+
+int write_test_ref(struct writer *wr, void *arg) {
+  struct ref_record *ref = arg;
+
+  writer_set_limits(wr, ref->update_index, ref->update_index);
+  int err = writer_add_ref(wr, ref);
+
+  return err;
+}
+
+int write_test_log(struct writer *wr, void *arg) {
+  struct log_record *log = arg;
+
+  writer_set_limits(wr, log->update_index, log->update_index);
+  int err = writer_add_log(wr, log);
+
+  return err;
+}
+
+void test_stack_add(void) {
+  char dir[256] = "/tmp/stack.XXXXXX";
+  assert(mkdtemp(dir));
+  printf("%s\n", dir);
+  char fn[256] = "";
+  strcat(fn, dir);
+  strcat(fn, "/refs");
+
+  struct write_options cfg = {};
+  struct stack *st = NULL;
+  int err = new_stack(&st, dir, fn, cfg);
+  assert_err(err);
+
+  struct ref_record refs[2] = {};
+  struct log_record logs[2] = {};
+  int N = ARRAYSIZE(refs);
+  for (int i = 0; i < N; i++) {
+    char buf[256];
+    sprintf(buf, "branch%02d", i);
+    refs[i].ref_name = strdup(buf);
+    refs[i].value = malloc(SHA1_SIZE);
+    refs[i].update_index = i + 1;
+    set_test_hash(refs[i].value, i);
+
+    logs[i].ref_name = strdup(buf);
+    logs[i].update_index = N + i+1;
+    logs[i].new_hash = malloc(SHA1_SIZE);
+    logs[i].email = strdup("identity@invalid");
+    set_test_hash(logs[i].new_hash, i);
+  }
+
+  for (int i = 0; i < N; i++) {
+    int err = stack_add(st, &write_test_ref, &refs[i]);
+    assert_err(err);
+  }
+
+  for (int i = 0; i < N; i++) {
+    int err = stack_add(st, &write_test_log, &logs[i]);
+    assert_err(err);
+  }
+
+  err = stack_compact_all(st, NULL);
+  assert_err(err);
+
+  for (int i = 0; i < N; i++) {
+    struct ref_record dest = {};
+    int err = stack_read_ref(st, refs[i].ref_name, &dest);
+    assert_err(err);
+    assert(ref_record_equal(&dest, refs + i, SHA1_SIZE));
+    ref_record_clear(&dest);
+  }
+
+  for (int i = 0; i < N; i++) {
+    struct log_record dest = {};
+    int err = stack_read_log(st, refs[i].ref_name, &dest);
+    assert_err(err);
+    assert(log_record_equal(&dest, logs + i, SHA1_SIZE));
+    log_record_clear(&dest);
+  }
+
+  // cleanup
+  stack_destroy(st);
+  for (int i = 0; i < N; i++) {
+    ref_record_clear(&refs[i]);
+    log_record_clear(&logs[i]);
+  }
+}
+
+void test_log2(void) {
+  assert(1 == fastlog2(3));
+  assert(2 == fastlog2(4));
+  assert(2 == fastlog2(5));
+}
+
+void test_sizes_to_segments(void) {
+  uint64_t sizes[] = {2, 3, 4, 5, 7, 9};
+  // .................0  1  2  3  4  5
+
+  int seglen = 0;
+  struct segment *segs = sizes_to_segments(&seglen, sizes, ARRAYSIZE(sizes));
+  assert(segs[2].log == 3);
+  assert(segs[2].start == 5);
+  assert(segs[2].end == 6);
+
+  assert(segs[1].log == 2);
+  assert(segs[1].start == 2);
+  assert(segs[1].end == 5);
+  free(segs);
+}
+
+void test_suggest_compaction_segment(void) {
+  {
+    uint64_t sizes[] = {128, 64, 17, 16, 9, 9, 9, 16, 16};
+    // .................0    1    2  3   4  5  6
+    struct segment min = suggest_compaction_segment(sizes, ARRAYSIZE(sizes));
+    assert(min.start == 2);
+    assert(min.end == 7);
+  }
+
+  {
+    uint64_t sizes[] = {64, 32, 16, 8, 4, 2};
+    struct segment result = suggest_compaction_segment(sizes, ARRAYSIZE(sizes));
+    assert(result.start == result.end);
+  }
+}
+
+void test_reflog_expire(void) {
+  char dir[256] = "/tmp/stack.XXXXXX";
+  assert(mkdtemp(dir));
+  printf("%s\n", dir);
+  char fn[256] = "";
+  strcat(fn, dir);
+  strcat(fn, "/refs");
+
+  struct write_options cfg = {};
+  struct stack *st = NULL;
+  int err = new_stack(&st, dir, fn, cfg);
+  assert_err(err);
+
+  struct log_record logs[20] = {};
+  int N = ARRAYSIZE(logs) -1;
+  for (int i = 1; i <= N; i++) {
+    char buf[256];
+    sprintf(buf, "branch%02d", i);
+
+    logs[i].ref_name = strdup(buf);
+    logs[i].update_index = i;
+    logs[i].time = i;
+    logs[i].new_hash = malloc(SHA1_SIZE);
+    logs[i].email = strdup("identity@invalid");
+    set_test_hash(logs[i].new_hash, i);
+  }
+
+  for (int i = 1; i <= N; i++) {
+    int err = stack_add(st, &write_test_log, &logs[i]);
+    assert_err(err);
+  }
+
+  err = stack_compact_all(st, NULL);
+  assert_err(err);
+
+  struct log_expiry_config expiry = {
+    .time = 10,
+  };
+  err = stack_compact_all(st, &expiry);
+  assert_err(err);
+
+  struct log_record log = {};
+  err = stack_read_log(st, logs[9].ref_name, &log);
+  assert(err == 1);
+
+  err = stack_read_log(st, logs[11].ref_name, &log);
+  assert_err(err);
+
+  expiry.min_update_index = 15;
+  err = stack_compact_all(st, &expiry);
+  assert_err(err);
+
+  err = stack_read_log(st, logs[14].ref_name, &log);
+  assert(err == 1);
+
+  err = stack_read_log(st, logs[16].ref_name, &log);
+  assert_err(err);
+
+  // cleanup
+  stack_destroy(st);
+  for (int i = 0; i < N; i++) {
+    log_record_clear(&logs[i]);
+  }
+}
+
+int main() {
+  add_test_case("test_reflog_expire", test_reflog_expire);
+  add_test_case("test_suggest_compaction_segment",
+                &test_suggest_compaction_segment);
+  add_test_case("test_sizes_to_segments", &test_sizes_to_segments);
+  add_test_case("test_log2", &test_log2);
+  add_test_case("test_parse_names", &test_parse_names);
+  add_test_case("test_read_file", &test_read_file);
+  add_test_case("test_names_equal", &test_names_equal);
+  add_test_case("test_stack_add", &test_stack_add);
+  test_main();
+}
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
new file mode 100644
index 0000000000..4ebf886f35
--- /dev/null
+++ b/reftable/test_framework.c
@@ -0,0 +1,60 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "test_framework.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "constants.h"
+
+struct test_case **test_cases;
+int test_case_len;
+int test_case_cap;
+
+struct test_case *new_test_case(const char *name, void (*testfunc)()) {
+  struct test_case *tc = malloc(sizeof(struct test_case));
+  tc->name = name;
+  tc->testfunc = testfunc;
+  return tc;
+}
+
+struct test_case *add_test_case(const char *name, void (*testfunc)()) {
+  struct test_case *tc = new_test_case(name, testfunc);
+  if (test_case_len == test_case_cap) {
+    test_case_cap = 2 * test_case_cap + 1;
+    test_cases = realloc(test_cases, sizeof(struct test_case) * test_case_cap);
+  }
+
+  test_cases[test_case_len++] = tc;
+  return tc;
+}
+
+void test_main() {
+  for (int i = 0; i < test_case_len; i++) {
+    printf("case %s\n", test_cases[i]->name);
+    test_cases[i]->testfunc();
+  }
+}
+
+void set_test_hash(byte *p, int i) { memset(p, (byte)i, SHA1_SIZE); }
+
+void print_names(char **a) {
+  if (a == NULL || *a == NULL) {
+    puts("[]");
+    return;
+  }
+  puts("[");
+  char **p = a;
+  while (*p) {
+    puts(*p);
+    p++;
+  }
+  puts("]");
+}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
new file mode 100644
index 0000000000..b9defee874
--- /dev/null
+++ b/reftable/test_framework.h
@@ -0,0 +1,63 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef TEST_FRAMEWORK_H
+#define TEST_FRAMEWORK_H
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "reftable.h"
+
+#ifdef NDEBUG
+#undef NDEBUG
+#endif
+
+#include <assert.h>
+
+#ifdef assert
+#undef assert
+#endif
+
+#define assert_err(c)                                                        \
+  if (c != 0) {                                                              \
+    fflush(stderr);                                                          \
+    fflush(stdout);                                                          \
+    fprintf(stderr, "%s: %d: error == %d (%s), want 0\n", __FILE__, __LINE__, c, error_str(c)); \
+    abort();                                                                 \
+  }
+
+#define assert_streq(a, b)                                                    \
+  if (0 != strcmp(a, b)) {                                                    \
+    fflush(stderr);                                                           \
+    fflush(stdout);                                                           \
+    fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, __LINE__, #a, a, \
+            #b, b);                                                           \
+    abort();                                                                  \
+  }
+
+#define assert(c)                                                             \
+  if (!(c)) {                                                                 \
+    fflush(stderr);                                                           \
+    fflush(stdout);                                                           \
+    fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, __LINE__, #c); \
+    abort();                                                                  \
+  }
+
+struct test_case {
+  const char *name;
+  void (*testfunc)();
+};
+
+struct test_case *new_test_case(const char *name, void (*testfunc)());
+struct test_case *add_test_case(const char *name, void (*testfunc)());
+void test_main();
+
+void set_test_hash(byte *p, int i);
+
+#endif
diff --git a/reftable/tree.c b/reftable/tree.c
new file mode 100644
index 0000000000..4bd9dce7c3
--- /dev/null
+++ b/reftable/tree.c
@@ -0,0 +1,60 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "tree.h"
+
+#include <stdlib.h>
+
+struct tree_node *tree_search(void *key, struct tree_node **rootp,
+                              int (*compare)(const void *, const void *),
+                              int insert) {
+  if (*rootp == NULL) {
+    if (!insert) {
+      return NULL;
+    } else {
+      struct tree_node *n = calloc(sizeof(struct tree_node), 1);
+      n->key = key;
+      *rootp = n;
+      return *rootp;
+    }
+  }
+
+  {
+    int res = compare(key, (*rootp)->key);
+    if (res < 0) {
+      return tree_search(key, &(*rootp)->left, compare, insert);
+    } else if (res > 0) {
+      return tree_search(key, &(*rootp)->right, compare, insert);
+    }
+  }
+  return *rootp;
+}
+
+void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
+                void *arg) {
+  if (t->left != NULL) {
+    infix_walk(t->left, action, arg);
+  }
+  action(arg, t->key);
+  if (t->right != NULL) {
+    infix_walk(t->right, action, arg);
+  }
+}
+
+void tree_free(struct tree_node *t) {
+  if (t == NULL) {
+    return;
+  }
+  if (t->left != NULL) {
+    tree_free(t->left);
+  }
+  if (t->right != NULL) {
+    tree_free(t->right);
+  }
+  free(t);
+}
diff --git a/reftable/tree.h b/reftable/tree.h
new file mode 100644
index 0000000000..e37b8215c4
--- /dev/null
+++ b/reftable/tree.h
@@ -0,0 +1,24 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef TREE_H
+#define TREE_H
+
+struct tree_node {
+  void *key;
+  struct tree_node *left, *right;
+};
+
+struct tree_node *tree_search(void *key, struct tree_node **rootp,
+                              int (*compare)(const void *, const void *),
+                              int insert);
+void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
+                void *arg);
+void tree_free(struct tree_node *t);
+
+#endif
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
new file mode 100644
index 0000000000..ee4b6530d5
--- /dev/null
+++ b/reftable/tree_test.c
@@ -0,0 +1,54 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "tree.h"
+
+#include "basics.h"
+#include "record.h"
+#include "reftable.h"
+#include "test_framework.h"
+
+static int test_compare(const void *a, const void *b) { return a - b; }
+
+struct curry {
+  void *last;
+};
+
+void check_increasing(void *arg, void *key) {
+  struct curry *c = (struct curry *)arg;
+  if (c->last != NULL) {
+    assert(test_compare(c->last, key) < 0);
+  }
+  c->last = key;
+}
+
+void test_tree() {
+  struct tree_node *root = NULL;
+
+  void *values[11] = {};
+  struct tree_node *nodes[11] = {};
+  int i = 1;
+  do {
+    nodes[i] = tree_search(values + i, &root, &test_compare, 1);
+    i = (i * 7) % 11;
+  } while (i != 1);
+
+  for (int i = 1; i < ARRAYSIZE(nodes); i++) {
+    assert(values + i == nodes[i]->key);
+    assert(nodes[i] == tree_search(values + i, &root, &test_compare, 0));
+  }
+
+  struct curry c = {};
+  infix_walk(root, check_increasing, &c);
+  tree_free(root);
+}
+
+int main() {
+  add_test_case("test_tree", &test_tree);
+  test_main();
+}
diff --git a/reftable/writer.c b/reftable/writer.c
new file mode 100644
index 0000000000..542ad0fa00
--- /dev/null
+++ b/reftable/writer.c
@@ -0,0 +1,586 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "writer.h"
+
+#include <assert.h>
+#include <stdint.h>
+#include <stdio.h>  // debug
+#include <stdlib.h>
+#include <string.h>
+#include <zlib.h>
+
+#include "block.h"
+#include "constants.h"
+#include "record.h"
+#include "reftable.h"
+#include "tree.h"
+
+static struct block_stats *writer_block_stats(struct writer *w, byte typ) {
+  switch (typ) {
+    case 'r':
+      return &w->stats.ref_stats;
+    case 'o':
+      return &w->stats.obj_stats;
+    case 'i':
+      return &w->stats.idx_stats;
+    case 'g':
+      return &w->stats.log_stats;
+  }
+  assert(false);
+}
+
+/* write data, queuing the padding for the next write. Returns negative for
+ * error. */
+static int padded_write(struct writer *w, byte *data, size_t len, int padding) {
+  int n = 0;
+  if (w->pending_padding > 0) {
+    byte *zeroed = calloc(w->pending_padding, 1);
+    int n = w->write(w->write_arg, zeroed, w->pending_padding);
+    if (n < 0) {
+      return n;
+    }
+
+    w->pending_padding = 0;
+    free(zeroed);
+  }
+
+  w->pending_padding = padding;
+  n = w->write(w->write_arg, data, len);
+  if (n < 0) {
+    return n;
+  }
+  n += padding;
+  return 0;
+}
+
+static void options_set_defaults(struct write_options *opts) {
+  if (opts->restart_interval == 0) {
+    opts->restart_interval = 16;
+  }
+
+  if (opts->block_size == 0) {
+    opts->block_size = DEFAULT_BLOCK_SIZE;
+  }
+}
+
+static int writer_write_header(struct writer *w, byte *dest) {
+  strcpy((char *)dest, "REFT");
+  dest[4] = 1;  // version
+  put_u24(dest + 5, w->opts.block_size);
+  put_u64(dest + 8, w->min_update_index);
+  put_u64(dest + 16, w->max_update_index);
+  return 24;
+}
+
+static void writer_reinit_block_writer(struct writer *w, byte typ) {
+  int block_start = 0;
+  if (w->next == 0) {
+    block_start = HEADER_SIZE;
+  }
+
+  block_writer_init(&w->block_writer_data, typ, w->block, w->opts.block_size,
+                    block_start, w->hash_size);
+  w->block_writer = &w->block_writer_data;
+  w->block_writer->restart_interval = w->opts.restart_interval;
+}
+
+struct writer *new_writer(int (*writer_func)(void *, byte *, int),
+                          void *writer_arg, struct write_options *opts) {
+  struct writer *wp = calloc(sizeof(struct writer), 1);
+  options_set_defaults(opts);
+  if (opts->block_size >= (1 << 24)) {
+    // TODO - error return?
+    abort();
+  }
+  wp->hash_size = SHA1_SIZE;
+  wp->block = calloc(opts->block_size, 1);
+  wp->write = writer_func;
+  wp->write_arg = writer_arg;
+  wp->opts = *opts;
+  writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
+
+  return wp;
+}
+
+void writer_set_limits(struct writer *w, uint64_t min, uint64_t max) {
+  w->min_update_index = min;
+  w->max_update_index = max;
+}
+
+void writer_free(struct writer *w) {
+  free(w->block);
+  free(w);
+}
+
+struct obj_index_tree_node {
+  struct slice hash;
+  uint64_t *offsets;
+  int offset_len;
+  int offset_cap;
+};
+
+static int obj_index_tree_node_compare(const void *a, const void *b) {
+  return slice_compare(((const struct obj_index_tree_node *)a)->hash,
+                       ((const struct obj_index_tree_node *)b)->hash);
+}
+
+static void writer_index_hash(struct writer *w, struct slice hash) {
+  uint64_t off = w->next;
+
+  struct obj_index_tree_node want = {.hash = hash};
+
+  struct tree_node *node =
+      tree_search(&want, &w->obj_index_tree, &obj_index_tree_node_compare, 0);
+  struct obj_index_tree_node *key = NULL;
+  if (node == NULL) {
+    key = calloc(sizeof(struct obj_index_tree_node), 1);
+    slice_copy(&key->hash, hash);
+    tree_search((void *)key, &w->obj_index_tree, &obj_index_tree_node_compare,
+                1);
+  } else {
+    key = node->key;
+  }
+
+  if (key->offset_len > 0 && key->offsets[key->offset_len - 1] == off) {
+    return;
+  }
+
+  if (key->offset_len == key->offset_cap) {
+    key->offset_cap = 2 * key->offset_cap + 1;
+    key->offsets = realloc(key->offsets, sizeof(uint64_t) * key->offset_cap);
+  }
+
+  key->offsets[key->offset_len++] = off;
+}
+
+static int writer_add_record(struct writer *w, struct record rec) {
+  int result = -1;
+  struct slice key = {};
+  int err = 0;
+  record_key(rec, &key);
+  if (slice_compare(w->last_key, key) >= 0) {
+    goto exit;
+  }
+
+  slice_copy(&w->last_key, key);
+  if (w->block_writer == NULL) {
+    writer_reinit_block_writer(w, record_type(rec));
+  }
+
+  assert(block_writer_type(w->block_writer) == record_type(rec));
+
+  if (block_writer_add(w->block_writer, rec) == 0) {
+    result = 0;
+    goto exit;
+  }
+
+  err = writer_flush_block(w);
+  if (err < 0) {
+    result = err;
+    goto exit;
+  }
+
+  writer_reinit_block_writer(w, record_type(rec));
+  err = block_writer_add(w->block_writer, rec);
+  if (err < 0) {
+    result = err;
+    goto exit;
+  }
+
+  result = 0;
+exit:
+  free(slice_yield(&key));
+  return result;
+}
+
+int writer_add_ref(struct writer *w, struct ref_record *ref) {
+  struct record rec = {};
+  struct ref_record copy = *ref;
+  int err = 0;
+
+  if (ref->update_index < w->min_update_index ||
+      ref->update_index > w->max_update_index) {
+    return API_ERROR;
+  }
+
+  record_from_ref(&rec, &copy);
+  copy.update_index -= w->min_update_index;
+  err = writer_add_record(w, rec);
+  if (err < 0) {
+    return err;
+  }
+
+  if (!w->opts.skip_index_objects && ref->value != NULL) {
+    struct slice h = {
+        .buf = ref->value,
+        .len = w->hash_size,
+    };
+
+    writer_index_hash(w, h);
+  }
+  if (!w->opts.skip_index_objects && ref->target_value != NULL) {
+    struct slice h = {
+        .buf = ref->target_value,
+        .len = w->hash_size,
+    };
+    writer_index_hash(w, h);
+  }
+  return 0;
+}
+
+int writer_add_refs(struct writer *w, struct ref_record *refs, int n) {
+  int err = 0;
+  qsort(refs, n, sizeof(struct ref_record), ref_record_compare_name);
+  for (int i = 0; err == 0 && i < n; i++) {
+    err = writer_add_ref(w, &refs[i]);
+  }
+  return err;
+}
+
+int writer_add_log(struct writer *w, struct log_record *log) {
+  if (w->block_writer != NULL &&
+      block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
+    int err = writer_finish_public_section(w);
+    if (err < 0) {
+      return err;
+    }
+  }
+
+  {
+    struct record rec = {};
+    int err;
+    record_from_log(&rec, log);
+    err = writer_add_record(w, rec);
+    return err;
+  }
+}
+
+int writer_add_logs(struct writer *w, struct log_record *logs, int n) {
+  int err = 0;
+  qsort(logs, n, sizeof(struct log_record), log_record_compare_key);
+  for (int i = 0; err == 0 && i < n; i++) {
+    err = writer_add_log(w, &logs[i]);
+  }
+  return err;
+}
+
+
+static int writer_finish_section(struct writer *w) {
+  byte typ = block_writer_type(w->block_writer);
+  uint64_t index_start = 0;
+  int max_level = 0;
+  int threshold = w->opts.unpadded ? 1 : 3;
+  int before_blocks = w->stats.idx_stats.blocks;
+  int err = writer_flush_block(w);
+  if (err < 0) {
+    return err;
+  }
+
+  while (w->index_len > threshold) {
+    struct index_record *idx = NULL;
+    int idx_len = 0;
+
+    max_level++;
+    index_start = w->next;
+    writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+
+    idx = w->index;
+    idx_len = w->index_len;
+
+    w->index = NULL;
+    w->index_len = 0;
+    w->index_cap = 0;
+    for (int i = 0; i < idx_len; i++) {
+      struct record rec = {};
+      record_from_index(&rec, idx + i);
+      if (block_writer_add(w->block_writer, rec) == 0) {
+        continue;
+      }
+
+      {
+        int err = writer_flush_block(w);
+        if (err < 0) {
+          return err;
+        }
+      }
+
+      writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+
+      err = block_writer_add(w->block_writer, rec);
+      assert(err == 0);
+    }
+    for (int i = 0; i < idx_len; i++) {
+      free(slice_yield(&idx[i].last_key));
+    }
+    free(idx);
+  }
+
+  writer_clear_index(w);
+
+  err = writer_flush_block(w);
+  if (err < 0) {
+    return err;
+  }
+
+  {
+    struct block_stats *bstats = writer_block_stats(w, typ);
+    bstats->index_blocks = w->stats.idx_stats.blocks - before_blocks;
+    bstats->index_offset = index_start;
+    bstats->max_index_level = max_level;
+  }
+
+  // Reinit lastKey, as the next section can start with any key.
+  w->last_key.len = 0;
+
+  return 0;
+}
+
+struct common_prefix_arg {
+  struct slice *last;
+  int max;
+};
+
+static void update_common(void *void_arg, void *key) {
+  struct common_prefix_arg *arg = (struct common_prefix_arg *)void_arg;
+  struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+  if (arg->last != NULL) {
+    int n = common_prefix_size(entry->hash, *arg->last);
+    if (n > arg->max) {
+      arg->max = n;
+    }
+  }
+  arg->last = &entry->hash;
+}
+
+struct write_record_arg {
+  struct writer *w;
+  int err;
+};
+
+static void write_object_record(void *void_arg, void *key) {
+  struct write_record_arg *arg = (struct write_record_arg *)void_arg;
+  struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+  struct obj_record obj_rec = {
+      .hash_prefix = entry->hash.buf,
+      .hash_prefix_len = arg->w->stats.object_id_len,
+      .offsets = entry->offsets,
+      .offset_len = entry->offset_len,
+  };
+  struct record rec = {};
+  if (arg->err < 0) {
+    goto exit;
+  }
+
+  record_from_obj(&rec, &obj_rec);
+  arg->err = block_writer_add(arg->w->block_writer, rec);
+  if (arg->err == 0) {
+    goto exit;
+  }
+
+  arg->err = writer_flush_block(arg->w);
+  if (arg->err < 0) {
+    goto exit;
+  }
+
+  writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
+  arg->err = block_writer_add(arg->w->block_writer, rec);
+  if (arg->err == 0) {
+    goto exit;
+  }
+  obj_rec.offset_len = 0;
+  arg->err = block_writer_add(arg->w->block_writer, rec);
+
+  // Should be able to write into a fresh block.
+  assert(arg->err == 0);
+
+exit:;
+}
+
+static void object_record_free(void *void_arg, void *key) {
+  struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
+
+  free(entry->offsets);
+  entry->offsets = NULL;
+  free(slice_yield(&entry->hash));
+  free(entry);
+}
+
+static int writer_dump_object_index(struct writer *w) {
+  struct write_record_arg closure = {.w = w};
+  struct common_prefix_arg common = {};
+  if (w->obj_index_tree != NULL) {
+    infix_walk(w->obj_index_tree, &update_common, &common);
+  }
+  w->stats.object_id_len = common.max + 1;
+
+  writer_reinit_block_writer(w, BLOCK_TYPE_OBJ);
+
+  if (w->obj_index_tree != NULL) {
+    infix_walk(w->obj_index_tree, &write_object_record, &closure);
+  }
+
+  if (closure.err < 0) {
+    return closure.err;
+  }
+  return writer_finish_section(w);
+}
+
+int writer_finish_public_section(struct writer *w) {
+  byte typ = 0;
+  int err = 0;
+
+  if (w->block_writer == NULL) {
+    return 0;
+  }
+
+  typ = block_writer_type(w->block_writer);
+  err = writer_finish_section(w);
+  if (err < 0) {
+    return err;
+  }
+  if (typ == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
+      w->stats.ref_stats.index_blocks > 0) {
+    err = writer_dump_object_index(w);
+    if (err < 0) {
+      return err;
+    }
+  }
+
+  if (w->obj_index_tree != NULL) {
+    infix_walk(w->obj_index_tree, &object_record_free, NULL);
+    tree_free(w->obj_index_tree);
+    w->obj_index_tree = NULL;
+  }
+
+  w->block_writer = NULL;
+  return 0;
+}
+
+int writer_close(struct writer *w) {
+  byte footer[68];
+  byte *p = footer;
+
+  writer_finish_public_section(w);
+
+  writer_write_header(w, footer);
+  p += 24;
+  put_u64(p, w->stats.ref_stats.index_offset);
+  p += 8;
+  put_u64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
+  p += 8;
+  put_u64(p, w->stats.obj_stats.index_offset);
+  p += 8;
+
+  put_u64(p, w->stats.log_stats.offset);
+  p += 8;
+  put_u64(p, w->stats.log_stats.index_offset);
+  p += 8;
+
+  put_u32(p, crc32(0, footer, p - footer));
+  p += 4;
+  w->pending_padding = 0;
+
+  {
+    int n = padded_write(w, footer, sizeof(footer), 0);
+    if (n < 0) {
+      return n;
+    }
+  }
+
+  // free up memory.
+  block_writer_clear(&w->block_writer_data);
+  writer_clear_index(w);
+  free(slice_yield(&w->last_key));
+  return 0;
+}
+
+void writer_clear_index(struct writer *w) {
+  for (int i = 0; i < w->index_len; i++) {
+    free(slice_yield(&w->index[i].last_key));
+  }
+
+  free(w->index);
+  w->index = NULL;
+  w->index_len = 0;
+  w->index_cap = 0;
+}
+
+const int debug = 0;
+
+static int writer_flush_nonempty_block(struct writer *w) {
+  byte typ = block_writer_type(w->block_writer);
+  struct block_stats *bstats = writer_block_stats(w, typ);
+  uint64_t block_typ_off = (bstats->blocks == 0) ? w->next : 0;
+  int raw_bytes = block_writer_finish(w->block_writer);
+  int padding = 0;
+  int err = 0;
+  if (raw_bytes < 0) {
+    return raw_bytes;
+  }
+
+  if (!w->opts.unpadded && typ != BLOCK_TYPE_LOG) {
+    padding = w->opts.block_size - raw_bytes;
+  }
+
+  if (block_typ_off > 0) {
+    bstats->offset = block_typ_off;
+  }
+
+  bstats->entries += w->block_writer->entries;
+  bstats->restarts += w->block_writer->restart_len;
+  bstats->blocks++;
+  w->stats.blocks++;
+
+  if (debug) {
+    fprintf(stderr, "block %c off %ld sz %d (%d)\n", typ, w->next, raw_bytes,
+            get_u24(w->block + w->block_writer->header_off + 1));
+  }
+
+  if (w->next == 0) {
+    writer_write_header(w, w->block);
+  }
+
+  err = padded_write(w, w->block, raw_bytes, padding);
+  if (err < 0) {
+    return err;
+  }
+
+  if (w->index_cap == w->index_len) {
+    w->index_cap = 2 * w->index_cap + 1;
+    w->index = realloc(w->index, sizeof(struct index_record) * w->index_cap);
+  }
+
+  {
+    struct index_record ir = {
+        .offset = w->next,
+    };
+    slice_copy(&ir.last_key, w->block_writer->last_key);
+    w->index[w->index_len] = ir;
+  }
+
+  w->index_len++;
+  w->next += padding + raw_bytes;
+  block_writer_reset(&w->block_writer_data);
+  w->block_writer = NULL;
+  return 0;
+}
+
+int writer_flush_block(struct writer *w) {
+  if (w->block_writer == NULL) {
+    return 0;
+  }
+  if (w->block_writer->entries == 0) {
+    return 0;
+  }
+  return writer_flush_nonempty_block(w);
+}
+
+struct stats *writer_stats(struct writer *w) {
+  return &w->stats;
+}
diff --git a/reftable/writer.h b/reftable/writer.h
new file mode 100644
index 0000000000..1f1b472727
--- /dev/null
+++ b/reftable/writer.h
@@ -0,0 +1,46 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef WRITER_H
+#define WRITER_H
+
+#include "basics.h"
+#include "block.h"
+#include "reftable.h"
+#include "slice.h"
+#include "tree.h"
+
+struct writer {
+  int (*write)(void *, byte *, int);
+  void *write_arg;
+  int pending_padding;
+  int hash_size;
+  struct slice last_key;
+
+  uint64_t next;
+  uint64_t min_update_index, max_update_index;
+  struct write_options opts;
+
+  byte *block;
+  struct block_writer *block_writer;
+  struct block_writer block_writer_data;
+  struct index_record *index;
+  int index_len;
+  int index_cap;
+
+  // tree for use with tsearch
+  struct tree_node *obj_index_tree;
+
+  struct stats stats;
+};
+
+int writer_flush_block(struct writer *w);
+void writer_clear_index(struct writer *w);
+int writer_finish_public_section(struct writer *w);
+
+#endif
-- 
gitgitgadget

