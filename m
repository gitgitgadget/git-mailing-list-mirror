Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5A1FFC47
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410865; cv=none; b=j3Fo/ZGm/yBj81vzbxY344VZp2rEiQFQO+DxKrf8lXILofzFKJcSdlYmseilHDh1N9BUKzd2FzyeVCrMK7IcjWAY/HsanBI4ykFxkXbm6NR30Fc01urMRFqNNQ0ivG4BwExA6kSEBLSy//o1ArcKQywId2CDBuvVhp+fJkez/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410865; c=relaxed/simple;
	bh=TMMu7aWjpDxpAnAmGGV5a5DlzlAGcoymd5DESIo4R2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tR3dtJ1GidiOC5ESQXH2uvJncSh64xfCedmSY2tC+mtqXX3Jym/BbXaQB3KR6C7q1fQA0IegzIbjPCxqqCXcEZHsCV9ECzihXig9jmuKd9TRFxQWNjEgbQ6T7gH/w3BaLqVU0ENk5kAfCNTnMGUyBaV1SrNvRh9omY7ubbmz4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgyESO8S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgyESO8S"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so43339485e9.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410861; x=1741015661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xscftoQQ6jfbHzETaNj9mD13m6vN0fwFel79D9fYrbQ=;
        b=SgyESO8SQw9PQFImiFG6FttVWJoq50RDi3rMeZETjgoBSHb+0se62vggTSFDM3b77E
         StmfMp7yerlGsFkqJ75x5BoepvNIweLVxZ4+95RoADfX3uk+ypeEqh6X8qyYKMq+cJVI
         Si1xyJy/7XJCn0WIQIZEIemeDv+7gWhAwdm6k8Yb9//JcwnosxYkDZkg4RmyDpIvHELE
         +guwrIi8pFeXqCVjj3p1nnC5U6HjQ/9azYt7DmP1Zzf4NsSxUkH+sYYMGJqpF2c0ZUed
         RGl2BLepWLMf0JLAOXTABty9P8nclBbnQ0TPJCi1tqZ+aBZ/C8/itH+UJvbN9fv8zPMr
         Avlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410861; x=1741015661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xscftoQQ6jfbHzETaNj9mD13m6vN0fwFel79D9fYrbQ=;
        b=fvrZaO73DT4rzBMEbjvk9IcrTf81YwIgqlNAC211Gb7BYHSEPOHX3rVW/7IgWjJPsY
         n0xlCalD7Ey/yaBr7iLrZHg8mdxCwt0zYK9lr69n5Cj+jGyLYtNiEXLegCvUSBDAYWzZ
         BZGpEuTVzA+QJf9mi1lAhWQYug6MJciacVGp3bZLMrrqiF8zLj7rFG/a4dgjrCNJlEeq
         KXNqMZhGBuTIqY5ozjEYTHoeNsOmvHVN/trlYAyAEX1D/suJJ2euiTyyT2C2f/4vAfMC
         J/oXrnBXupEDAar4Vo8m2l+Z+2SrloefDVjc2cnyr+XZ/bw8SC6o6fzVNZHP97UqwKdg
         jiaQ==
X-Gm-Message-State: AOJu0YwzMw1a7FEp1u8LMhs5q8mfs6ojczW+EKr8azf/xew2pHiz3m1Z
	ItXv5VaoFiGC38X0yTq7/sEvRuDKOLxfaF/SdQJSO95pNy/kDU5EKql2Yqg6VYU9Ng==
X-Gm-Gg: ASbGncuRfaUWguga0dO8S7qG0s5vwX3o8JmJxKW2jcXsCtcN1IAgpbXREv8Gj/eMyU4
	5V2zrL5I1Uc8Ak5YRfuND/Rlc3DX2DgNYoVDLbthjMHznPSH5lK5C4TJ1ltpRFLUAi9P5kAFgoS
	qBoHzPmjxkR/Q/L6IyfGnWAx2wqQ87jF1aqXCHRU3ul474SOMrRiINfFgJoM+SFSGOEtQalISnL
	lOTUx6piwnHs40HRXI0vJGLuCqwtE3+LUbVaNNx0r9Rui2YhI0Ox5piR3e8gkLCgkM5DlOAb9KF
	5oAeDSRBM+32GQxqmPfLfj9nVR34VMth2tTKvcg=
X-Google-Smtp-Source: AGHT+IH/0QQjr1CMAHBrDhS9YNFYPL0R/G+BwDelrfrjEtA3l82kV1+H77quZ+DVbr7byXabsghcoQ==
X-Received: by 2002:a05:600c:458d:b0:439:99e6:2ab with SMTP id 5b1f17b1804b1-439aebcfd58mr103187285e9.28.1740410860826;
        Mon, 24 Feb 2025 07:27:40 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm109048915e9.17.2025.02.24.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:27:40 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 0/4] t/unit-tests: convert unit-tests to use clar
Date: Mon, 24 Feb 2025 16:27:00 +0100
Message-ID: <20250224152704.70289-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250220082959.10854-1-kuforiji98@gmail.com>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions a couple more of our existing unit
test files to the Clar testing framework. This change is part of our
ongoing effort to standardize our testing framework to enhance
maintainability.

Changes in v2:
 - fixes to the commit messages and how they read
 - some code refactoring based on review

Thanks
Seyi

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Philip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (4):
  t/unit-tests: implement clar specific oid helper functions
  t/unit-tests: convert oid-array test to use clar test framework
  t/unit-tests: convert oidmap test to use clar test framework
  t/unit-tests: convert oidtree test to use clar test framework

 Makefile                                      |   8 +-
 t/meson.build                                 |   8 +-
 t/unit-tests/lib-oid.c                        |  31 ++--
 t/unit-tests/lib-oid.h                        |   9 +-
 t/unit-tests/{t-oid-array.c => u-oid-array.c} | 125 +++++++-------
 t/unit-tests/{t-oidmap.c => u-oidmap.c}       | 153 +++++++-----------
 t/unit-tests/{t-oidtree.c => u-oidtree.c}     |  79 ++++-----
 t/unit-tests/unit-test.c                      |   2 +
 8 files changed, 177 insertions(+), 238 deletions(-)
 rename t/unit-tests/{t-oid-array.c => u-oid-array.c} (34%)
 rename t/unit-tests/{t-oidmap.c => u-oidmap.c} (32%)
 rename t/unit-tests/{t-oidtree.c => u-oidtree.c} (45%)

Range-diff against v1:
1:  19192c6c89 < -:  ---------- t/unit-tests: implement oid helper functions in unit-tests.{c,h}
5:  e81ec73f27 ! 1:  7f14d0d574 t/unit-tests: remove lib-oid.{c,h,o}
    @@ Metadata
     Author: Seyi Kuforiji <kuforiji98@gmail.com>
     
      ## Commit message ##
    -    t/unit-tests: remove lib-oid.{c,h,o}
    +    t/unit-tests: implement clar specific oid helper functions
     
    -    The `lib-oid.c`, `lib-oid.h`, and `lib-oid.o files` are no longer needed
    -    since their equivalent functions have been implemented in unit-test.c
    -    and unit-test.h. This removes redundant code and ensures all unit
    -    test-related functionality is consolidated in a single location.
    +    `get_oid_arbitrary_hex()` and `init_hash_algo()` are both required for
    +    oid-related tests to run without errors. In the current implementation,
    +    both functions are defined and declared in the
    +    `t/unit-tests/lib-oid.{c,h}` which is utilized by oid-related tests in
    +    the homegrown unit tests structure.
     
    -    Drop references to lib-oid from our `Makefile`, and `meson.build` files
    -    to prevent build errors due to missing files.
    +    Adapt functions in lib-oid.{c,h} to use clar. Both these functions
    +    become available for oid-related test files implemented using the clar
    +    testing framework, which requires them. This will be used by subsequent
    +    commits.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
      ## Makefile ##
    +@@ Makefile: CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
    + CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    ++CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + 
    + UNIT_TEST_PROGRAMS += t-oid-array
    + UNIT_TEST_PROGRAMS += t-oidmap
     @@ Makefile: UNIT_TEST_PROGRAMS += t-trailer
      UNIT_TEST_PROGRAMS += t-urlmatch-normalization
      UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
    @@ Makefile: UNIT_TEST_PROGRAMS += t-trailer
      # xdiff and reftable libs may in turn depend on what is in libgit.a
     
      ## t/meson.build ##
    +@@ t/meson.build: clar_test_suites = [
    + clar_sources = [
    +   'unit-tests/clar/clar.c',
    +   'unit-tests/unit-test.c',
    ++  'unit-tests/lib-oid.c'
    + ]
    + 
    + clar_decls_h = custom_target(
     @@ t/meson.build: foreach unit_test_program : unit_test_programs
        unit_test = executable(unit_test_name,
          sources: [
    @@ t/meson.build: foreach unit_test_program : unit_test_programs
            unit_test_program,
          ],
     
    - ## t/unit-tests/lib-oid.c (deleted) ##
    + ## t/unit-tests/lib-oid.c ##
     @@
     -#include "test-lib.h"
    --#include "lib-oid.h"
    --#include "strbuf.h"
    --#include "hex.h"
    --
    ++#include "unit-test.h"
    + #include "lib-oid.h"
    + #include "strbuf.h"
    + #include "hex.h"
    + 
     -int init_hash_algo(void)
    --{
    --	static int algo = -1;
    --
    --	if (algo < 0) {
    --		const char *algo_name = getenv("GIT_TEST_DEFAULT_HASH");
    --		algo = algo_name ? hash_algo_by_name(algo_name) : GIT_HASH_SHA1;
    --
    ++int cl_setup_hash_algo(void)
    + {
    + 	static int algo = -1;
    + 
    +@@ t/unit-tests/lib-oid.c: int init_hash_algo(void)
    + 		const char *algo_name = getenv("GIT_TEST_DEFAULT_HASH");
    + 		algo = algo_name ? hash_algo_by_name(algo_name) : GIT_HASH_SHA1;
    + 
     -		if (!check(algo != GIT_HASH_UNKNOWN))
     -			test_msg("BUG: invalid GIT_TEST_DEFAULT_HASH value ('%s')",
     -				 algo_name);
    --	}
    --	return algo;
    --}
    --
    ++		cl_assert(algo != GIT_HASH_UNKNOWN);
    + 	}
    + 	return algo;
    + }
    + 
     -static int get_oid_arbitrary_hex_algop(const char *hex, struct object_id *oid,
    --				       const struct git_hash_algo *algop)
    --{
    --	int ret;
    --	size_t sz = strlen(hex);
    --	struct strbuf buf = STRBUF_INIT;
    --
    ++static void cl_parse_oid(const char *hex, struct object_id *oid,
    + 				       const struct git_hash_algo *algop)
    + {
    + 	int ret;
    + 	size_t sz = strlen(hex);
    + 	struct strbuf buf = STRBUF_INIT;
    + 
     -	if (!check(sz <= algop->hexsz)) {
     -		test_msg("BUG: hex string (%s) bigger than maximum allowed (%lu)",
     -			 hex, (unsigned long)algop->hexsz);
     -		return -1;
     -	}
    --
    --	strbuf_add(&buf, hex, sz);
    --	strbuf_addchars(&buf, '0', algop->hexsz - sz);
    --
    ++	cl_assert(sz <= algop->hexsz);
    + 
    + 	strbuf_add(&buf, hex, sz);
    + 	strbuf_addchars(&buf, '0', algop->hexsz - sz);
    + 
     -	ret = get_oid_hex_algop(buf.buf, oid, algop);
     -	if (!check_int(ret, ==, 0))
     -		test_msg("BUG: invalid hex input (%s) provided", hex);
    --
    --	strbuf_release(&buf);
    ++	cl_assert_equal_i(get_oid_hex_algop(buf.buf, oid, algop), 0);
    + 
    + 	strbuf_release(&buf);
     -	return ret;
    --}
    --
    + }
    + 
     -int get_oid_arbitrary_hex(const char *hex, struct object_id *oid)
    --{
    ++
    ++void cl_parse_any_oid(const char *hex, struct object_id *oid)
    + {
     -	int hash_algo = init_hash_algo();
    --
    ++	int hash_algo = cl_setup_hash_algo();
    + 
     -	if (!check_int(hash_algo, !=, GIT_HASH_UNKNOWN))
     -		return -1;
     -	return get_oid_arbitrary_hex_algop(hex, oid, &hash_algos[hash_algo]);
    --}
    ++	cl_assert(hash_algo != GIT_HASH_UNKNOWN);
    ++	cl_parse_oid(hex, oid, &hash_algos[hash_algo]);
    + }
     
    - ## t/unit-tests/lib-oid.h (deleted) ##
    + ## t/unit-tests/lib-oid.h ##
    +@@
    + 
    + /*
    +  * Convert arbitrary hex string to object_id.
    ++ *
    +  * For example, passing "abc12" will generate
    +  * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
    +  * create object_id with that.
     @@
    --#ifndef LIB_OID_H
    --#define LIB_OID_H
    --
    --#include "hash.h"
    --
    --/*
    -- * Convert arbitrary hex string to object_id.
    -- * For example, passing "abc12" will generate
    -- * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
    -- * create object_id with that.
    -- * WARNING: passing a string of length more than the hexsz of respective hash
    -- * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
    -- * environment variable.
    -- */
    +  * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
    +  * environment variable.
    +  */
     -int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
    --/*
    -- * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
    -- * GIT_TEST_DEFAULT_HASH environment variable. The fallback value in the
    -- * absence of GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1. It also uses
    ++
    ++void cl_parse_any_oid (const char *s, struct object_id *oid);
    + /*
    +  * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
    +  * GIT_TEST_DEFAULT_HASH environment variable. The fallback value in the
    +  * absence of GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1. It also uses
     - * check(algo != GIT_HASH_UNKNOWN) before returning to verify if the
    -- * GIT_TEST_DEFAULT_HASH's value is valid or not.
    -- */
    ++ * cl_assert(algo != GIT_HASH_UNKNOWN) before returning to verify if the
    +  * GIT_TEST_DEFAULT_HASH's value is valid or not.
    +  */
     -int init_hash_algo(void);
    --
    --#endif /* LIB_OID_H */
    ++
    ++int cl_setup_hash_algo(void);
    + 
    + #endif /* LIB_OID_H */
    +
    + ## t/unit-tests/unit-test.c ##
    +@@
    + #include "unit-test.h"
    ++#include "hex.h"
    + #include "parse-options.h"
    ++#include "strbuf.h"
    + #include "string-list.h"
    + #include "strvec.h"
    + 
2:  8a99bbdc31 ! 2:  430f5c5007 t/unit-tests: convert oid-array test to use clar test framework
    @@ Makefile: CLAR_TEST_SUITES += u-example-decorate
      CLAR_TEST_SUITES += u-prio-queue
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
    -@@ Makefile: CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-oid-array
      UNIT_TEST_PROGRAMS += t-oidmap
    @@ t/unit-tests/u-oid-array.c (new)
     +#define USE_THE_REPOSITORY_VARIABLE
     +
     +#include "unit-test.h"
    ++#include "lib-oid.h"
     +#include "oid-array.h"
     +#include "hex.h"
     +
    @@ t/unit-tests/u-oid-array.c (new)
     +void test_oid_array__initialize(void)
     +{
     +	/* The hash algo is used by oid_array_lookup() internally */
    -+	int algo = init_hash_algo();
    -+	cl_assert(algo != GIT_HASH_UNKNOWN);
    ++	int algo = cl_setup_hash_algo();
     +	repo_set_hash_algo(the_repository, algo);
     +}
     +
    @@ t/unit-tests/u-oid-array.c (new)
     +{
     +	const char *nearly_55;
     +
    -+	nearly_55 = init_hash_algo() == GIT_HASH_SHA1 ?
    ++	nearly_55 = cl_setup_hash_algo() == GIT_HASH_SHA1 ?
     +			"5500000000000000000000000000000000000001" :
     +			"5500000000000000000000000000000000000000000000000000000000000001";
     +
3:  c19545e2bc ! 3:  319cea1265 t/unit-tests: convert oidmap test to use clar test framework
    @@ Commit message
         t/unit-tests: convert oidmap test to use clar test framework
     
         Adapt oidmap test script to clar framework by using clar assertions
    -    where necessary. `cl_parse_any_oid` handles the necessary checks needed
    -    for the test to run smoothly.
    +    where necessary. `cl_parse_any_oid()` ensures the hash algorithm is set
    +    before parsing. This prevents issues from an uninitialized or invalid
    +    hash algorithm.
     
         Introduce 'test_oidmap__initialize` handles the to set up of the global
         oidmap map with predefined key-value pairs, and `test_oidmap__cleanup`
         frees the oidmap and its entries when all tests are completed.
     
    -    This streamlines the test suite, making individual tests self-contained
    -    and reducing redundant code.
    +    The test loops through all entries to detect multiple errors. With this
    +    change, it stops at the first error encountered, making it easier to
    +    address it.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
    @@ Makefile: CLAR_TEST_SUITES += u-hash
      CLAR_TEST_SUITES += u-prio-queue
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
    -@@ Makefile: CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-oidmap
      UNIT_TEST_PROGRAMS += t-oidtree
    @@ t/unit-tests/t-oidmap.c (deleted)
      ## t/unit-tests/u-oidmap.c (new) ##
     @@
     +#include "unit-test.h"
    ++#include "lib-oid.h"
     +#include "oidmap.h"
     +#include "hash.h"
     +#include "hex.h"
    @@ t/unit-tests/u-oidmap.c (new)
     +
     +	oidmap_iter_init(&map, &iter);
     +	while ((entry = oidmap_iter_next(&iter))) {
    -+		cl_assert_equal_i(key_val_contains(entry, seen), 0);
    ++		if (key_val_contains(entry, seen) != 0) {
    ++			cl_failf("Unexpected entry: name = %s, oid = %s",
    ++				 entry->name, oid_to_hex(&entry->entry.oid));
    ++		}
     +		count++;
     +	}
     +	cl_assert_equal_i(count, ARRAY_SIZE(key_val));
4:  733b53cd05 ! 4:  ea63a5c9f1 t/unit-tests: convert oidtree test to use clar test framework
    @@ Commit message
         t/unit-tests: convert oidtree test to use clar test framework
     
         Adapt oidtree test script to clar framework by using clar assertions
    -    where necessary. `cl_parse_any_oid` handles the necessary checks needed
    -    for the test to run smoothly.
    +    where necessary. `cl_parse_any_oid()` ensures the hash algorithm is set
    +    before parsing. This prevents issues from an uninitialized or invalid
    +    hash algorithm.
     
         Introduce 'test_oidtree__initialize` handles the to set up of the global
         oidtree variable and `test_oidtree__cleanup` frees the oidtree when all
         tests are completed.
     
    -    This streamlines the test suite, making individual tests self-contained
    -    and reducing redundant code.
    +    With this change, `check_each` stops at the first error encountered,
    +    making it easier to address it.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
    @@ Makefile: CLAR_TEST_SUITES += u-hashmap
      CLAR_TEST_SUITES += u-prio-queue
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
    -@@ Makefile: CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
      
     -UNIT_TEST_PROGRAMS += t-oidtree
      UNIT_TEST_PROGRAMS += t-reftable-basics
    @@ t/unit-tests/t-oidtree.c (deleted)
      ## t/unit-tests/u-oidtree.c (new) ##
     @@
     +#include "unit-test.h"
    ++#include "lib-oid.h"
     +#include "oidtree.h"
     +#include "hash.h"
     +#include "hex.h"
    @@ t/unit-tests/u-oidtree.c (new)
     +	cl_parse_any_oid(query, &oid);
     +	oidtree_each(ot, &oid, strlen(query), check_each_cb, &hex_iter);
     +
    -+	cl_assert_equal_i(hex_iter.i, hex_iter.expected_hexes.nr);
    ++	if (hex_iter.i != hex_iter.expected_hexes.nr)
    ++		cl_failf("error: could not find some 'object_id's for query ('%s')", query);
    ++
     +	strvec_clear(&hex_iter.expected_hexes);
     +}
     +
-- 
2.47.0.86.g15030f9556

