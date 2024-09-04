Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0981D0968
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462118; cv=none; b=R0uIojOyPsK+6RrYaYUu0Zh4z5zJUO3l/wteq5JJ6KzmLrRYibI/SqBngNArL3b61XoDEofIO0FKjBJJjeWRzgVJ1A6DvQfMLA/35YiAxV9BVXWSFi7QqrcTHD46PcjyoUoIhN5FIJ2obWPDdQYTPUTSVo8zb6Eot9bBZ3gZYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462118; c=relaxed/simple;
	bh=YWKEoKc7BXhBp2tjmpe6LwvX9vSjCp4ORXjF4XwTkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4GaNj67eWpC4KjHhNQTKR0iDTjxVHL1WdYBnMY+BnKamypBYXJGEU7Bmh/kn8/o3rruCGwDZ0hasNdPIQK9YAVYlle04LutNwHgEYKwlzRkjwjtL9CGNgfsNgChulPQwDoGuBF8MNlm0/Vl0c0Oi9qIIu4hmBjPc2XvCCDQdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY1rjUcJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY1rjUcJ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-204d391f53bso47895305ad.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462115; x=1726066915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KlSMiaK9O3xzb76lvEdyL9L8NX2GJZOzXa+dycO9wY=;
        b=JY1rjUcJ9Lc828izT0dFzvRdLUqSvJZzwsGcCxmzAy79hC8zh1uWRiC6R035+K4mRg
         EtXHy/R8v4PylsEgmrtZ8t2/X9RKJonCBodxxhzDc6YL5OQVmWf5QDj8b9w19qlHJ1qJ
         O863MBD1mh8Ht1mW8rXp8rxag3YxjNriBGp4RkDwumfz3fdI7P/Lk28bTs7HGySxyA4g
         tigSlTZWZYUXNXtYPuEfIkfNmLuVkEHnMvZvTAjxBRk/KPvaDBTP0GRKK+OICZBTYrXZ
         xNEG6ddQYXRtJWsez5vcFVD3eFD7YZL590GmBcG4wn1MMyqoLq1TL9FrG/f5EdpAwUqn
         aXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462115; x=1726066915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KlSMiaK9O3xzb76lvEdyL9L8NX2GJZOzXa+dycO9wY=;
        b=CA1TIv2iPYFQj9TS7u4gswWC0ePta8WZsaIQcC5A57Urpwh7DGB0R3yq10L+5JDLiC
         njh23N/ejmQpNW8vOYawlmKSaQUIGvIp7f1/ll18BIMmzoctA8DI8fKIKOig6tzmU1av
         byedUaxaUErNxjBcPVO9rLjVTOC5/ZKEkpZhLpQbR7mON+TLhFETrjDwU/2OWKDjAqZf
         1WLRhfjs8wPIRL85iEB0V+2Kn33Wq1hRufphALe7/KfB2drLOOdFPOnLGsP5zNUEK0jv
         hdeB5tiHHeZW9DBw7SsHQTbrAdFMXgEOSOHvo6C37IRCP14kHZPO3AOC5tI27ENMermW
         BuKA==
X-Gm-Message-State: AOJu0YzRaN5ZoJjJtCGIC+0KGqQ7AXwT1ywECws0MEAOLiKEIoiuYJov
	6CsmEPkei2eISD6QEMborRCGNwYMXuC5Wor0SuXQYY3CQUav0ur0xcUQ8lT0
X-Google-Smtp-Source: AGHT+IHFfs06mUiAmAnklN0z4XkCsiUDeykwurCNU4IXenk6jWz/6rGvESqTKHJfZr5BRcaP94RdRA==
X-Received: by 2002:a17:903:2451:b0:201:f853:3e73 with SMTP id d9443c01a7336-205472c5bc6mr183302685ad.11.1725462114546;
        Wed, 04 Sep 2024 08:01:54 -0700 (PDT)
Received: from Ubuntu.. ([106.194.60.213])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm14549395ad.257.2024.09.04.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:01:54 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v4 0/6] t: port reftable/stack_test.c to the unit testing framework
Date: Wed,  4 Sep 2024 20:08:00 +0530
Message-ID: <20240904150132.11567-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240826173627.4525-1-chandrapratap3519@gmail.com>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
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
Changes in v4:
- v3 of this patch series had conflicts with 85da2a2ab6 (Merge branch
  'ps/reftable-concurrent-compaction') and e49d2472d2 (Merge branch
  'ps/reftable-drop-generic').

  These branches have since graduated to 'master', so this version
  rebases the commits on top of the latest 'master'. The resulting
  branch has been tested to have no conflicts with 'next' and
  trivial ones with 'seen'.

CI/PR: https://github.com/gitgitgadget/git/pull/1762

Chandra Pratap(6):
t: move reftable/stack_test.c to the unit testing framework
t: harmonize t-reftable-stack.c with coding guidelines
t-reftable-stack: use Git's tempfile API instead of mkstemp()
t-reftable-stack: use reftable_ref_record_equal() to compare ref records
t-reftable-stack: add test for non-default compaction factor
t-reftable-stack: add test for stack iterators

Makefile                                                 |   2 +-
reftable/reftable-tests.h                                |   1 -
t/helper/test-reftable.c                                 |   1 -
reftable/stack_test.c => t/unit-tests/t-reftable-stack.c | 611 +++++++++++++++++++--------------
4 files changed, 360 insertions(+), 255 deletions(-)

Range-diff against v3:
<rebase commits>
  1:  d094b8f94d ! 184:  cdfb49f5d5 t: move reftable/stack_test.c to the unit testing framework
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## Makefile ##
    -@@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-basics
    - UNIT_TEST_PROGRAMS += t-reftable-merged
    +@@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-merged
      UNIT_TEST_PROGRAMS += t-reftable-pq
    + UNIT_TEST_PROGRAMS += t-reftable-readwrite
      UNIT_TEST_PROGRAMS += t-reftable-record
     +UNIT_TEST_PROGRAMS += t-reftable-stack
      UNIT_TEST_PROGRAMS += t-reftable-tree
      UNIT_TEST_PROGRAMS += t-strbuf
      UNIT_TEST_PROGRAMS += t-strcmp-offset
    -@@ Makefile: REFTABLE_OBJS += reftable/writer.o
    - REFTABLE_TEST_OBJS += reftable/block_test.o
    - REFTABLE_TEST_OBJS += reftable/dump.o
    - REFTABLE_TEST_OBJS += reftable/readwrite_test.o
    +@@ Makefile: REFTABLE_OBJS += reftable/stack.o
    + REFTABLE_OBJS += reftable/tree.o
    + REFTABLE_OBJS += reftable/writer.o
    +
     -REFTABLE_TEST_OBJS += reftable/stack_test.o
      REFTABLE_TEST_OBJS += reftable/test_framework.o

      TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))

      ## reftable/reftable-tests.h ##
    -@@ reftable/reftable-tests.h: int basics_test_main(int argc, const char **argv);
    - int block_test_main(int argc, const char **argv);
    - int record_test_main(int argc, const char **argv);
    - int readwrite_test_main(int argc, const char **argv);
    +@@ reftable/reftable-tests.h: license that can be found in the LICENSE file or at
    + #ifndef REFTABLE_TESTS_H
    + #define REFTABLE_TESTS_H
    +
     -int stack_test_main(int argc, const char **argv);
    - int reftable_dump_main(int argc, char *const *argv);

      #endif

      ## t/helper/test-reftable.c ##
    -@@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
    +@@
    + int cmd__reftable(int argc, const char **argv)
    + {
      	/* test from simple to complex. */
    - 	block_test_main(argc, argv);
    - 	readwrite_test_main(argc, argv);
     -	stack_test_main(argc, argv);
      	return 0;
      }
    @@ t/unit-tests/t-reftable-stack.c: license that can be found in the LICENSE file o
     -
     -#include "system.h"
     -
    +-#include "copy.h"
     -#include "reftable-reader.h"
     -#include "merged.h"
     -#include "basics.h"
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_add_one(void)
     +	check_str("master", dest.value.symref);
     +	check_int(st->readers_len, >, 0);

    - 	printf("testing print functionality:\n");
    - 	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
    --	EXPECT_ERR(err);
    -+	check(!err);
    -
    - 	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
    --	EXPECT(err == REFTABLE_FORMAT_ERROR);
    -+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
    -
      #ifndef GIT_WINDOWS_NATIVE
      	strbuf_addstr(&scratch, dir);
      	strbuf_addstr(&scratch, "/tables.list");
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_transaction_api
      		 * all tables in the stack.
      		 */
      		if (i != n)
    --			EXPECT(st->merged->stack_len == i + 1);
    -+			check_int(st->merged->stack_len, ==, i + 1);
    +-			EXPECT(st->merged->readers_len == i + 1);
    ++			check_int(st->merged->readers_len, ==, i + 1);
      		else
    --			EXPECT(st->merged->stack_len == 1);
    -+			check_int(st->merged->stack_len, ==, 1);
    +-			EXPECT(st->merged->readers_len == 1);
    ++			check_int(st->merged->readers_len, ==, 1);
      	}

      	reftable_stack_destroy(st);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction

      	err = reftable_stack_add(st, write_test_ref, &ref);
     -	EXPECT_ERR(err);
    --	EXPECT(st->merged->stack_len == 1);
    +-	EXPECT(st->merged->readers_len == 1);
     -	EXPECT(st->stats.attempts == 0);
     -	EXPECT(st->stats.failures == 0);
     +	check(!err);
    -+	check_int(st->merged->stack_len, ==, 1);
    ++	check_int(st->merged->readers_len, ==, 1);
     +	check_int(st->stats.attempts, ==, 0);
     +	check_int(st->stats.failures, ==, 0);

    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction
      	ref.update_index = 2;
      	err = reftable_stack_add(st, write_test_ref, &ref);
     -	EXPECT_ERR(err);
    --	EXPECT(st->merged->stack_len == 2);
    +-	EXPECT(st->merged->readers_len == 2);
     -	EXPECT(st->stats.attempts == 1);
     -	EXPECT(st->stats.failures == 1);
     +	check(!err);
    -+	check_int(st->merged->stack_len, ==, 2);
    ++	check_int(st->merged->readers_len, ==, 2);
     +	check_int(st->stats.attempts, ==, 1);
     +	check_int(st->stats.failures, ==, 1);

      	reftable_stack_destroy(st);
      	strbuf_release(&table_path);
    -@@ t/unit-tests/t-reftable-stack.c: static int write_error(struct reftable_writer *wr, void *arg)
    +@@ t/unit-tests/t-reftable-stack.c: static int write_error(struct reftable_writer *wr UNUSED, void *arg)
      	return *((int *)arg);
      }

    @@ t/unit-tests/t-reftable-stack.c: static void test_reflog_expire(void)

      	/* cleanup */
      	reftable_stack_destroy(st);
    -@@ t/unit-tests/t-reftable-stack.c: static int write_nothing(struct reftable_writer *wr, void *arg)
    +@@ t/unit-tests/t-reftable-stack.c: static int write_nothing(struct reftable_writer *wr, void *arg UNUSED)
      	return 0;
      }

    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction

      		err = reftable_stack_auto_compact(st);
     -		EXPECT_ERR(err);
    --		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
    +-		EXPECT(i < 3 || st->merged->readers_len < 2 * fastlog2(i));
     +		check(!err);
    -+		check(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
    ++		check(i < 3 || st->merged->readers_len < 2 * fastlog2(i));
      	}

     -	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction
     +	check(!err);

      	write_n_ref_tables(st, 5);
    --	EXPECT(st->merged->stack_len == 5);
    -+	check_int(st->merged->stack_len, ==, 5);
    +-	EXPECT(st->merged->readers_len == 5);
    ++	check_int(st->merged->readers_len, ==, 5);

      	/*
      	 * Given that all tables we have written should be roughly the same
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction
      	err = reftable_stack_auto_compact(st);
     -	EXPECT_ERR(err);
     -	EXPECT(st->stats.failures == 0);
    --	EXPECT(st->merged->stack_len == 4);
    +-	EXPECT(st->merged->readers_len == 4);
     +	check(!err);
     +	check_int(st->stats.failures, ==, 0);
    -+	check_int(st->merged->stack_len, ==, 4);
    ++	check_int(st->merged->readers_len, ==, 4);

      	reftable_stack_destroy(st);
      	strbuf_release(&buf);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_add_performs_au
      		 * all tables in the stack.
      		 */
      		if (i != n)
    --			EXPECT(st->merged->stack_len == i + 1);
    -+			check_int(st->merged->stack_len, ==, i + 1);
    +-			EXPECT(st->merged->readers_len == i + 1);
    ++			check_int(st->merged->readers_len, ==, i + 1);
      		else
    --			EXPECT(st->merged->stack_len == 1);
    -+			check_int(st->merged->stack_len, ==, 1);
    +-			EXPECT(st->merged->readers_len == 1);
    ++			check_int(st->merged->readers_len, ==, 1);
      	}

      	reftable_stack_destroy(st);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_with
     +	check(!err);

      	write_n_ref_tables(st, 3);
    --	EXPECT(st->merged->stack_len == 3);
    -+	check_int(st->merged->stack_len, ==, 3);
    +-	EXPECT(st->merged->readers_len == 3);
    ++	check_int(st->merged->readers_len, ==, 3);

      	/* Lock one of the tables that we're about to compact. */
      	strbuf_reset(&buf);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_with
      	err = reftable_stack_compact_all(st, NULL);
     -	EXPECT(err == REFTABLE_LOCK_ERROR);
     -	EXPECT(st->stats.failures == 1);
    --	EXPECT(st->merged->stack_len == 3);
    +-	EXPECT(st->merged->readers_len == 3);
     +	check_int(err, ==, REFTABLE_LOCK_ERROR);
     +	check_int(st->stats.failures, ==, 1);
    -+	check_int(st->merged->stack_len, ==, 3);
    ++	check_int(st->merged->readers_len, ==, 3);

      	reftable_stack_destroy(st);
      	strbuf_release(&buf);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_conc
      	clear_dir(dir);
      }

    --int stack_test_main(int argc, const char *argv[])
    -+int cmd_main(int argc, const char *argv[])
    +-static void test_reftable_stack_read_across_reload(void)
    ++static void t_reftable_stack_read_across_reload(void)
    + {
    + 	struct reftable_write_options opts = { 0 };
    + 	struct reftable_stack *st1 = NULL, *st2 = NULL;
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_read_across_reload(void)
    +
    + 	/* Create a first stack and set up an iterator for it. */
    + 	err = reftable_new_stack(&st1, dir, &opts);
    +-	EXPECT_ERR(err);
    ++	check(!err);
    + 	write_n_ref_tables(st1, 2);
    +-	EXPECT(st1->merged->readers_len == 2);
    ++	check_int(st1->merged->readers_len, ==, 2);
    + 	reftable_stack_init_ref_iterator(st1, &it);
    + 	err = reftable_iterator_seek_ref(&it, "");
    +-	EXPECT_ERR(err);
    ++	check(!err);
    +
    + 	/* Set up a second stack for the same directory and compact it. */
    + 	err = reftable_new_stack(&st2, dir, &opts);
    +-	EXPECT_ERR(err);
    +-	EXPECT(st2->merged->readers_len == 2);
    ++	check(!err);
    ++	check_int(st2->merged->readers_len, ==, 2);
    + 	err = reftable_stack_compact_all(st2, NULL);
    +-	EXPECT_ERR(err);
    +-	EXPECT(st2->merged->readers_len == 1);
    ++	check(!err);
    ++	check_int(st2->merged->readers_len, ==, 1);
    +
    + 	/*
    + 	 * Verify that we can continue to use the old iterator even after we
    + 	 * have reloaded its stack.
    + 	 */
    + 	err = reftable_stack_reload(st1);
    +-	EXPECT_ERR(err);
    +-	EXPECT(st1->merged->readers_len == 1);
    ++	check(!err);
    ++	check_int(st1->merged->readers_len, ==, 1);
    + 	err = reftable_iterator_next_ref(&it, &rec);
    +-	EXPECT_ERR(err);
    +-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
    ++	check(!err);
    ++	check_str(rec.refname, "refs/heads/branch-0000");
    + 	err = reftable_iterator_next_ref(&it, &rec);
    +-	EXPECT_ERR(err);
    +-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0001"));
    ++	check(!err);
    ++	check_str(rec.refname, "refs/heads/branch-0001");
    + 	err = reftable_iterator_next_ref(&it, &rec);
    +-	EXPECT(err > 0);
    ++	check_int(err, >, 0);
    +
    + 	reftable_ref_record_release(&rec);
    + 	reftable_iterator_destroy(&it);
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_read_across_reload(void)
    + 	clear_dir(dir);
    + }
    +
    +-static void test_reftable_stack_reload_with_missing_table(void)
    ++static void t_reftable_stack_reload_with_missing_table(void)
    + {
    + 	struct reftable_write_options opts = { 0 };
    + 	struct reftable_stack *st = NULL;
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_reload_with_missing_table(void)
    +
    + 	/* Create a first stack and set up an iterator for it. */
    + 	err = reftable_new_stack(&st, dir, &opts);
    +-	EXPECT_ERR(err);
    ++	check(!err);
    + 	write_n_ref_tables(st, 2);
    +-	EXPECT(st->merged->readers_len == 2);
    ++	check_int(st->merged->readers_len, ==, 2);
    + 	reftable_stack_init_ref_iterator(st, &it);
    + 	err = reftable_iterator_seek_ref(&it, "");
    +-	EXPECT_ERR(err);
    ++	check(!err);
    +
    + 	/*
    + 	 * Update the tables.list file with some garbage data, while reusing
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_reload_with_missing_table(void)
    + 	strbuf_addf(&table_path, "%s.lock", st->list_file);
    + 	write_file_buf(table_path.buf, content.buf, content.len);
    + 	err = rename(table_path.buf, st->list_file);
    +-	EXPECT_ERR(err);
    ++	check(!err);
    +
    + 	err = reftable_stack_reload(st);
    +-	EXPECT(err == -4);
    +-	EXPECT(st->merged->readers_len == 2);
    ++	check_int(err, ==, -4);
    ++	check_int(st->merged->readers_len, ==, 2);
    +
    + 	/*
    + 	 * Even though the reload has failed, we should be able to continue
    + 	 * using the iterator.
    + 	*/
    + 	err = reftable_iterator_next_ref(&it, &rec);
    +-	EXPECT_ERR(err);
    +-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
    ++	check(!err);
    ++	check_str(rec.refname, "refs/heads/branch-0000");
    + 	err = reftable_iterator_next_ref(&it, &rec);
    +-	EXPECT_ERR(err);
    +-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0001"));
    ++	check(!err);
    ++	check_str(rec.refname, "refs/heads/branch-0001");
    + 	err = reftable_iterator_next_ref(&it, &rec);
    +-	EXPECT(err > 0);
    ++	check_int(err, >, 0);
    +
    + 	reftable_ref_record_release(&rec);
    + 	reftable_iterator_destroy(&it);
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_reload_with_missing_table(void)
    + 	clear_dir(dir);
    + }
    +
    +-int stack_test_main(int argc UNUSED, const char *argv[] UNUSED)
    ++int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
      {
     -	RUN_TEST(test_empty_add);
     -	RUN_TEST(test_read_file);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_conc
     -	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
     -	RUN_TEST(test_reftable_stack_update_index_check);
     -	RUN_TEST(test_reftable_stack_uptodate);
    +-	RUN_TEST(test_reftable_stack_read_across_reload);
    +-	RUN_TEST(test_reftable_stack_reload_with_missing_table);
     -	RUN_TEST(test_suggest_compaction_segment);
     -	RUN_TEST(test_suggest_compaction_segment_nothing);
     -	return 0;
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_conc
     +	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
     +	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
     +	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
    ++	TEST(t_reftable_stack_read_across_reload(), "reading stack works across reloads");
    ++	TEST(t_reftable_stack_reload_with_missing_table(), "reading stack with garbage tables");
     +	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
     +	TEST(t_reftable_stack_transaction_api(), "update transaction to stack");
     +	TEST(t_reftable_stack_transaction_api_performs_auto_compaction(), "update transaction triggers auto-compaction");
  2:  838ccc63a7 ! 185:  e37be61cbe t: harmonize t-reftable-stack.c with coding guidelines
    @@ t/unit-tests/t-reftable-stack.c: static void t_read_file(void)
      	(void) remove(fn);
      }
     @@ t/unit-tests/t-reftable-stack.c: static void write_n_ref_tables(struct reftable_stack *st,
    - 			.value_type = REFTABLE_REF_VAL1,
      		};

    + 		strbuf_reset(&buf);
     -		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
     +		strbuf_addf(&buf, "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
      		ref.refname = buf.buf;
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add_performs_auto_
      		check(!err);

      		/*
    -@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_compaction_concurrent(void)
    - static void unclean_stack_close(struct reftable_stack *st)
    - {
    - 	/* break abstraction boundary to simulate unclean shutdown. */
    --	int i = 0;
    --	for (; i < st->readers_len; i++) {
    -+	for (size_t i = 0; i < st->readers_len; i++)
    - 		reftable_reader_free(st->readers[i]);
    --	}
    - 	st->readers_len = 0;
    - 	FREE_AND_NULL(st->readers);
    - }
  3:  2a151c299c = 186:  449b9e5e26 t-reftable-stack: use Git's tempfile API instead of mkstemp()
  4:  fb5073da2c ! 187:  a4f1a8e93a t-reftable-stack: use reftable_ref_record_equal() to compare ref records
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add_one(void)
     +	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
      	check_int(st->readers_len, >, 0);

    - 	printf("testing print functionality:\n");
    + #ifndef GIT_WINDOWS_NATIVE
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_transaction_api(void)
      	err = reftable_stack_read_ref(st, ref.refname, &dest);
      	check(!err);
  5:  028fa6f70b ! 188:  b5dce8c505 t-reftable-stack: add test for non-default compaction factor
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_auto_compaction(vo

      		err = reftable_stack_auto_compact(st);
      		check(!err);
    --		check(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
    -+		check(i < 2 || st->merged->stack_len < 2 * fastlogN(i, 2));
    +-		check(i < 3 || st->merged->readers_len < 2 * fastlog2(i));
    ++		check(i < 2 || st->merged->readers_len < 2 * fastlogN(i, 2));
      	}

      	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_auto_compaction(vo
     +		err = reftable_stack_add(st, &write_test_ref, &ref);
     +		check(!err);
     +
    -+		check(i < 5 || st->merged->stack_len < 5 * fastlogN(i, 5));
    ++		check(i < 5 || st->merged->readers_len < 5 * fastlogN(i, 5));
     +	}

      	reftable_stack_destroy(st);
      	clear_dir(dir);
    -@@ t/unit-tests/t-reftable-stack.c: int cmd_main(int argc, const char *argv[])
    +@@ t/unit-tests/t-reftable-stack.c: int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
      	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
      	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
      	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
  6:  fa0d358e65 ! 189:  8081831ce6 t-reftable-stack: add test for stack iterators
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
      static void t_reftable_stack_log_normalize(void)
      {
      	int err = 0;
    -@@ t/unit-tests/t-reftable-stack.c: int cmd_main(int argc, const char *argv[])
    +@@ t/unit-tests/t-reftable-stack.c: int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
      	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
      	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
      	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
     +	TEST(t_reftable_stack_iterator(), "log and ref iterator for reftable stack");
      	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
      	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
    - 	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
    + 	TEST(t_reftable_stack_read_across_reload(), "reading stack works across reloads");

