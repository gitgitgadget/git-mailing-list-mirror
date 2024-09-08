Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F1A31
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725769088; cv=none; b=b11VphYsTi508npJwN8pdgmniuKov2ozeTmuOLI+l4JbssY3QFqsyq9GRzuNmoThg+KJkxTwHM0Jbsw7IjI8Q+XPFEYRg3tZEbVGsBToiQIlq/RAE5Gf0/VQlw3+SeWl19gz0WH/y3dbGHYJA+sn2aDndTJTEwBQxpKI1ANA/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725769088; c=relaxed/simple;
	bh=zhUa3sUrCme1VfOGWQjPwEk73ZA0ndMLZCLclYnidD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHWutggVEOliL6Vx5RyuQAOqz8wZVlv6x7pM41Z2gJC7QUUAXpV3SS9yov6yQDFaVgIjp2kNFc8lTV9BrI0k8RAfwlZz7gcEynMNie+dPDexuIJqWVq7i977TCjCFRutIRnjnzyCJ/xqbZO9l1F1ZgZ97PbQ98UVmqzhabjLdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRXy0g1v; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRXy0g1v"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718da0821cbso1507729b3a.0
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 21:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725769085; x=1726373885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZ+MjQR0rQIie5JHEGQP7x+WStUsA9AjmwCWWdnXKJE=;
        b=kRXy0g1vQEZcCzxZBpE/kRd4I5rRDwvSWPfG8cXL4FLpBvjk1K/ZtHreie5k0fxbCO
         W/j/jLko215dIszFJP9Cf+nzMCYppS+A6daxpz+OIQvcUgKzrc0NWa5wXs0iD4zsBMx8
         5heel6trxAUrOLYNd6QPsGXOAATLVnKoeeaL0C+csQ9G81FG1GjjUJpRJ+qmWzrJn7xw
         Svu8JmglemyceJH5SKL2/v/zxAzwJVUb3hWf3v3zWdtWsfmmUdO2E1bOhKeuuvazge67
         JrLjJX69PkNTJf44Xn0xFuHvN7SL+s/otDw6oGaePOBGcxwkC3UruMQDJzS9IFVTjQg2
         TMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725769085; x=1726373885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ+MjQR0rQIie5JHEGQP7x+WStUsA9AjmwCWWdnXKJE=;
        b=K0F69SQfQkP8MIBVCbvmHGMC/5Jtg/EukoIz3Hm2p2eKgNp+lj5sxp+zYkd3pYncPT
         qUzDSMdrSP7tcNSN37VF1cIXCMQV38MFDuBO3df/ZfyFjiKpgu9qOBJlhPGtbK4icRo/
         kBRXhO7txgiVRIShZvWCYUOc2sWzjlnfLBEhFBBG7dHJCru9CxmMKLDbiuGTiZlK0bYV
         NWkSSdmpPqIgkS5o2nwnokKrb5dPJjH9rZWjiq0je0BQ8iVRoptqP4yVKwr4K+RcS1+P
         Bj2CkZw0VQ+FCNHpHPM1A18A1VCmnSogRZouKdaDa1KWkwD0fVgg57XU1zKL65TDAVfz
         yVmQ==
X-Gm-Message-State: AOJu0Ywz2rIPLOwCzi3/wQ40RemJhvRKm3wUdTHxdw87YKd8/8SdeT1Z
	S0wgygqC+qOqfnwXdTKsy1QoXIiS739puLEVYZ1VopdjxspQnWM7UFBGNamW3z8=
X-Google-Smtp-Source: AGHT+IGPb5i2CK16IH1+eHPls0X0IXjh8Mx59E8ltuzisBnb4Nu+e5uggrE4nkCzXdMXJO7qCK81hw==
X-Received: by 2002:a05:6a20:d04e:b0:1cf:2862:beca with SMTP id adf61e73a8af0-1cf2ac88ed9mr5391804637.13.1725769085122;
        Sat, 07 Sep 2024 21:18:05 -0700 (PDT)
Received: from Ubuntu.. ([27.59.86.31])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596883csm1533253b3a.121.2024.09.07.21.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 21:18:04 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v6 0/6] t: port reftable/stack_test.c to the unit testing framework
Date: Sun,  8 Sep 2024 09:35:55 +0530
Message-ID: <20240908041632.4948-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240906113746.8903-1-chandrapratap3519@gmail.com>
References: <20240906113746.8903-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/stack_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v6:
- Fix the Makefile changes in patch 7 of the previous series that
  broke the OSX CI.
- Squash patch 7 of the previous series into patch 1.

CI/PR: https://github.com/gitgitgadget/git/pull/1762

Chandra Pratap(6):
t: move reftable/stack_test.c to the unit testing framework
t: harmonize t-reftable-stack.c with coding guidelines
t-reftable-stack: use Git's tempfile API instead of mkstemp()
t-reftable-stack: use reftable_ref_record_equal() to compare ref records
t-reftable-stack: add test for non-default compaction factor
t-reftable-stack: add test for stack iterators

Makefile                                           |  12 +-
reftable/reftable-tests.h                          |  14 -
reftable/test_framework.c                          |  27 -
reftable/test_framework.h                          |  61 --
t/helper/test-reftable.c                           |   8 -
t/helper/test-tool.c                               |   3 +-
t/helper/test-tool.h                               |   1 -
t/t0032-reftable-unittest.sh                       |  16 -
.../unit-tests/t-reftable-stack.c                  | 665 ++++++++++++---------
9 files changed, 392 insertions(+), 415 deletions(-)

Range-diff against v5:
1:  e9af30d14a ! 1:  fa549a875a t: move reftable/stack_test.c to the unit testing framework
    @@ Commit message
         '#included' in the test file, copy this function in the
         ported test file.

    +    With the migration of stack test to the unit-tests framework,
    +    "test-tool reftable" becomes a no-op. Hence, get rid of everything
    +    that uses "test-tool reftable" alongside everything that is used
    +    to implement it.
    +
    +    While at it, alphabetically sort the cmds[] list in
    +    helper/test-tool.c by moving the entry for "dump-reftable".
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## Makefile ##
    +@@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
    + LIB_FILE = libgit.a
    + XDIFF_LIB = xdiff/lib.a
    + REFTABLE_LIB = reftable/libreftable.a
    +-REFTABLE_TEST_LIB = reftable/libreftable_test.a
    +
    + GENERATED_H += command-list.h
    + GENERATED_H += config-list.h
     @@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-merged
      UNIT_TEST_PROGRAMS += t-reftable-pq
      UNIT_TEST_PROGRAMS += t-reftable-readwrite
    @@ Makefile: REFTABLE_OBJS += reftable/stack.o
      REFTABLE_OBJS += reftable/writer.o

     -REFTABLE_TEST_OBJS += reftable/stack_test.o
    - REFTABLE_TEST_OBJS += reftable/test_framework.o
    -
    +-REFTABLE_TEST_OBJS += reftable/test_framework.o
    +-
      TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
    -
    - ## reftable/reftable-tests.h ##
    -@@ reftable/reftable-tests.h: license that can be found in the LICENSE file or at
    - #ifndef REFTABLE_TESTS_H
    - #define REFTABLE_TESTS_H

    --int stack_test_main(int argc, const char **argv);
    + .PHONY: test-objs
    +@@ Makefile: $(XDIFF_LIB): $(XDIFF_OBJS)
    + $(REFTABLE_LIB): $(REFTABLE_OBJS)
    + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^

    - #endif
    +-$(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
    +-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    +-
    + export DEFAULT_EDITOR DEFAULT_PAGER
    +
    + Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
    +@@ Makefile: perf: all
    +
    + t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
    +
    +-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
    ++t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
    + 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
    +
    + check-sha1:: t/helper/test-tool$X
    +@@ Makefile: clean: profile-clean coverage-clean cocciclean
    + 	$(RM) git.res
    + 	$(RM) $(OBJECTS)
    + 	$(RM) headless-git.o
    +-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
    ++	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
    + 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
    + 	$(RM) $(TEST_PROGRAMS)
    + 	$(RM) $(FUZZ_PROGRAMS)
    +
    + ## reftable/reftable-tests.h (deleted) ##
    +@@
    +-/*
    +-Copyright 2020 Google LLC
    +-
    +-Use of this source code is governed by a BSD-style
    +-license that can be found in the LICENSE file or at
    +-https://developers.google.com/open-source/licenses/bsd
    +-*/
    +-
    +-#ifndef REFTABLE_TESTS_H
    +-#define REFTABLE_TESTS_H
    +-
    +-int stack_test_main(int argc, const char **argv);
    +-
    +-#endif
    +
    + ## reftable/test_framework.c (deleted) ##
    +@@
    +-/*
    +-Copyright 2020 Google LLC
    +-
    +-Use of this source code is governed by a BSD-style
    +-license that can be found in the LICENSE file or at
    +-https://developers.google.com/open-source/licenses/bsd
    +-*/
    +-
    +-#include "system.h"
    +-#include "test_framework.h"
    +-
    +-
    +-void set_test_hash(uint8_t *p, int i)
    +-{
    +-	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
    +-}
    +-
    +-ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
    +-{
    +-	strbuf_add(b, data, sz);
    +-	return sz;
    +-}
    +-
    +-int noop_flush(void *arg UNUSED)
    +-{
    +-	return 0;
    +-}
    +
    + ## reftable/test_framework.h (deleted) ##
    +@@
    +-/*
    +-Copyright 2020 Google LLC
    +-
    +-Use of this source code is governed by a BSD-style
    +-license that can be found in the LICENSE file or at
    +-https://developers.google.com/open-source/licenses/bsd
    +-*/
    +-
    +-#ifndef TEST_FRAMEWORK_H
    +-#define TEST_FRAMEWORK_H
    +-
    +-#include "system.h"
    +-#include "reftable-error.h"
    +-
    +-#define EXPECT_ERR(c)                                                          \
    +-	do {                                                                   \
    +-		if (c != 0) {                                                  \
    +-			fflush(stderr);                                        \
    +-			fflush(stdout);                                        \
    +-			fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
    +-				__FILE__, __LINE__, c, reftable_error_str(c)); \
    +-			abort();                                               \
    +-		}                                                              \
    +-	} while (0)
    +-
    +-#define EXPECT_STREQ(a, b)                                                       \
    +-	do {                                                                     \
    +-		if (strcmp(a, b)) {                                              \
    +-			fflush(stderr);                                          \
    +-			fflush(stdout);                                          \
    +-			fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
    +-				__LINE__, #a, a, #b, b);                         \
    +-			abort();                                                 \
    +-		}                                                                \
    +-	} while (0)
    +-
    +-#define EXPECT(c)                                                                  \
    +-	do {                                                                       \
    +-		if (!(c)) {                                                        \
    +-			fflush(stderr);                                            \
    +-			fflush(stdout);                                            \
    +-			fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
    +-				__LINE__, #c);                                     \
    +-			abort();                                                   \
    +-		}                                                                  \
    +-	} while (0)
    +-
    +-#define RUN_TEST(f)                          \
    +-	fprintf(stderr, "running %s\n", #f); \
    +-	fflush(stderr);                      \
    +-	f();
    +-
    +-void set_test_hash(uint8_t *p, int i);
    +-
    +-/* Like strbuf_add, but suitable for passing to reftable_new_writer
    +- */
    +-ssize_t strbuf_add_void(void *b, const void *data, size_t sz);
    +-
    +-int noop_flush(void *);
    +-
    +-#endif

      ## t/helper/test-reftable.c ##
     @@
    - int cmd__reftable(int argc, const char **argv)
    - {
    - 	/* test from simple to complex. */
    + #include "reftable/reftable-merged.h"
    + #include "reftable/reftable-reader.h"
    + #include "reftable/reftable-stack.h"
    +-#include "reftable/reftable-tests.h"
    + #include "test-tool.h"
    +
    +-int cmd__reftable(int argc, const char **argv)
    +-{
    +-	/* test from simple to complex. */
     -	stack_test_main(argc, argv);
    - 	return 0;
    - }
    -
    +-	return 0;
    +-}
    +-
    + static void print_help(void)
    + {
    + 	printf("usage: dump [-st] arg\n\n"
    +
    + ## t/helper/test-tool.c ##
    +@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
    + 	{ "drop-caches", cmd__drop_caches },
    + 	{ "dump-cache-tree", cmd__dump_cache_tree },
    + 	{ "dump-fsmonitor", cmd__dump_fsmonitor },
    ++	{ "dump-reftable", cmd__dump_reftable },
    + 	{ "dump-split-index", cmd__dump_split_index },
    + 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
    + 	{ "env-helper", cmd__env_helper },
    +@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
    + 	{ "read-graph", cmd__read_graph },
    + 	{ "read-midx", cmd__read_midx },
    + 	{ "ref-store", cmd__ref_store },
    +-	{ "reftable", cmd__reftable },
    + 	{ "rot13-filter", cmd__rot13_filter },
    +-	{ "dump-reftable", cmd__dump_reftable },
    + 	{ "regex", cmd__regex },
    + 	{ "repository", cmd__repository },
    + 	{ "revision-walking", cmd__revision_walking },
    +
    + ## t/helper/test-tool.h ##
    +@@ t/helper/test-tool.h: int cmd__read_graph(int argc, const char **argv);
    + int cmd__read_midx(int argc, const char **argv);
    + int cmd__ref_store(int argc, const char **argv);
    + int cmd__rot13_filter(int argc, const char **argv);
    +-int cmd__reftable(int argc, const char **argv);
    + int cmd__regex(int argc, const char **argv);
    + int cmd__repository(int argc, const char **argv);
    + int cmd__revision_walking(int argc, const char **argv);
    +
    + ## t/t0032-reftable-unittest.sh (deleted) ##
    +@@
    +-#!/bin/sh
    +-#
    +-# Copyright (c) 2020 Google LLC
    +-#
    +-
    +-test_description='reftable unittests'
    +-
    +-TEST_PASSES_SANITIZE_LEAK=true
    +-. ./test-lib.sh
    +-
    +-test_expect_success 'unittests' '
    +-	TMPDIR=$(pwd) && export TMPDIR &&
    +-	test-tool reftable
    +-'
    +-
    +-test_done

      ## reftable/stack_test.c => t/unit-tests/t-reftable-stack.c ##
     @@ t/unit-tests/t-reftable-stack.c: license that can be found in the LICENSE file or at
2:  8e8e09bd5b = 2:  1fd91e7a12 t: harmonize t-reftable-stack.c with coding guidelines
3:  ca4b00feef = 3:  8a7132500a t-reftable-stack: use Git's tempfile API instead of mkstemp()
4:  3e723667dd = 4:  786f7c2874 t-reftable-stack: use reftable_ref_record_equal() to compare ref records
5:  7526550c92 = 5:  388f1129d8 t-reftable-stack: add test for non-default compaction factor
6:  05e4b7e715 = 6:  5468c9853f t-reftable-stack: add test for stack iterators
7:  560d3c76e0 < -:  ---------- t: clean up leftover reftable test cruft

