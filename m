Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91A175AB
	for <git@vger.kernel.org>; Sun, 19 May 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716151606; cv=none; b=BsrRiVDvjglVimTSCYbBnDY1SIrT0TH7KJVT42B5yNVyr8XMQ8VNZEbYJjF2gFEXvA6llVj90drrBohNE0KnMTljp3moZWbh1GsrskAo6K+cZ1vabFnuWLZwg95pvPmM4CS1lo7EVECraV2yzEsCl7pO94mgfkl68Uy39rL3MII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716151606; c=relaxed/simple;
	bh=6Pm168cAGLbzo7B0u9TUAAH0th7pqGNJ+FN+WAJ7viY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SknIi3YOH63/cyEVLihHR7j2d2JgujQ1bZUbeD+nZk74Flnwzbz2WrO8DOYxO6k70phXjVLgoEreLMysdvdgGQxgxrwSIbU3HZknJA7H9+FGsYjdmDTgTxhZCa8q3RE/DWM8xG/pwAwvHdVl5zx/LqQKz4W/N0ilHVWkcnqBCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjrJ2QVn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjrJ2QVn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1edc696df2bso65505505ad.0
        for <git@vger.kernel.org>; Sun, 19 May 2024 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716151604; x=1716756404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPljSPB92Z6DlRU+ptIeKTh5YLr+3d9bZGgwk4MjIs8=;
        b=GjrJ2QVnHAKdBEFZbZ+ec1vK4quNjTw79WzTEMQjcwSgsuGVaeOyKcLEfAB1118tPG
         H5diCa0PrtbzaHa6EzhdewxMO9oEj9jTdM/oao8Y/qoHcAiU/JM1Zm7PcxWDMT+csyQW
         OzCh2JfC2b27RMZSBC6i7GZ7Osjy03e7N1z4Wyj0AN00eRIiw1d9jVAR4rndG0T6dQT1
         wt1Qafb8E0KPQvRYVI3iwf53cWs+ZYk8R6OeMZNqs8x6q8DOa3IXXIgNnkGLz5bto8SZ
         WCYx/gqOIdZceRSU+VTD3VYkfXfxAfoCI82VA7XJ2R+2nPB7cvY+/k2vJdQBe+ArDw2Q
         B++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716151604; x=1716756404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPljSPB92Z6DlRU+ptIeKTh5YLr+3d9bZGgwk4MjIs8=;
        b=r/FoagSLllS9MEDrCs1h/3T1hmOJ2Wp0eVaJD05KnO6JSCOhEW4S8ul748Rbhnu+v8
         pXZ8IdFNdsFBgfolH+zBIDMiNb0+KG3mAwarMGSfkyV0Sx4/JOQg+NNz5hwY4XjlnKbA
         C73z9kfKvpWuCeyGEtn/qWRv7uM3vJmJhViF5IJQDPu/2vii8fiyx2QQ9YK8cNg2yhg2
         zEf5p/6wFHbiUMqeFlZbB8/rM2SoRH3YKbRAnrREy7z+iM6qxyP+t/h/zxsI+wW1xOlJ
         jkgyuyEBLmoqbpS+Zb98zW2Rhd9AOMnk3aQjnUJ2EpN5MpVSRpD7DXKGaeSY/j3maavs
         4l4w==
X-Gm-Message-State: AOJu0YzO9aStiWe0FXyGSyCAt3JcgxHVnagEBBKRMQZcs8lnN9iv5xzC
	e5ae4yrI5zb6stOMHMcOV2dHQhtKvSNHEPfLsKvIr8LoHI/n/V2HRcK0elr8Jc9/rw==
X-Google-Smtp-Source: AGHT+IGupM2ILSNPPi/sJnyz5MqJQ/lYKNo7i0lLCkdlYK8BRiwzB8I4H3BohLJ0HFOKG5OlRHHqcw==
X-Received: by 2002:a05:6a20:394d:b0:1b1:d403:5272 with SMTP id adf61e73a8af0-1b1d40353bcmr3734525637.57.1716151603947;
        Sun, 19 May 2024 13:46:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f89ea243sm13537786b3a.166.2024.05.19.13.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 13:46:43 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>
Subject: [GSoC][PATCH v2] t/: port helper/test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
Date: Mon, 20 May 2024 02:14:42 +0530
Message-ID: <20240519204530.12258-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240310144819.4379-1-ach.lumap@gmail.com>
References: <20240310144819.4379-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (8bf6fbd (Merge branch
'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
merged, providing a standardized approach for testing C code. Prior to
this update, some unit tests relied on the test helper mechanism,
lacking a dedicated unit testing framework. It's more natural to perform
these unit tests using the new unit test framework.

Let's migrate the unit tests for strcmp-offset functionality from the
legacy approach using the test-tool command `test-tool strcmp-offset` in
helper/test-strcmp-offset.c to the new unit testing framework
(t/unit-tests/test-lib.h).

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Helped-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
The v2 only adjusts the formatting to be in line with the style
described in CodingGuidelines. And it is also rebased on 'next' to
avoid Makefile conflicts.

CI for v2: https://github.com/spectre10/git/actions/runs/9150288967

Range-diff against v1:
1:  47e7df1d22 ! 1:  3c2a6f7e9b Port helper/test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
    @@
      ## Metadata ##
    -Author: Achu Luma <ach.lumap@gmail.com>
    +Author: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
     
      ## Commit message ##
    -    Port helper/test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
    +    t/: port helper/test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
     
         In the recent codebase update (8bf6fbd (Merge branch
         'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
    @@ Commit message
         The migration involves refactoring the tests to utilize the testing
         macros provided by the framework (TEST() and check_*()).
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    +    Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Co-authored-by: Achu Luma <ach.lumap@gmail.com>
         Signed-off-by: Achu Luma <ach.lumap@gmail.com>
    +    Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
     
      ## Makefile ##
     @@ Makefile: TEST_BUILTINS_OBJS += test-sha1.o
    @@ Makefile: TEST_BUILTINS_OBJS += test-sha1.o
      TEST_BUILTINS_OBJS += test-string-list.o
      TEST_BUILTINS_OBJS += test-submodule-config.o
      TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
    -@@ Makefile: UNIT_TEST_PROGRAMS += t-mem-pool
    - UNIT_TEST_PROGRAMS += t-strbuf
    - UNIT_TEST_PROGRAMS += t-ctype
    +@@ Makefile: UNIT_TEST_PROGRAMS += t-ctype
    + UNIT_TEST_PROGRAMS += t-mem-pool
      UNIT_TEST_PROGRAMS += t-prio-queue
    + UNIT_TEST_PROGRAMS += t-strbuf
     +UNIT_TEST_PROGRAMS += t-strcmp-offset
    + UNIT_TEST_PROGRAMS += t-trailer
      UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
      UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
    - UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
     
      ## t/helper/test-strcmp-offset.c (deleted) ##
     @@
    @@ t/unit-tests/t-strcmp-offset.c (new)
     +#include "test-lib.h"
     +#include "read-cache-ll.h"
     +
    -+static void check_strcmp_offset(const char *string1, const char *string2, int expect_result,  uintmax_t expect_offset)
    ++static void check_strcmp_offset(const char *string1, const char *string2,
    ++				int expect_result, uintmax_t expect_offset)
     +{
    -+	int result;
     +	size_t offset;
    ++	int result = strcmp_offset(string1, string2, &offset);
     +
    -+	result = strcmp_offset(string1, string2, &offset);
    -+
    -+	/* Because different CRTs behave differently, only rely on signs of the result values. */
    ++	/*
    ++	 * Because different CRTs behave differently, only rely on signs of the
    ++	 * result values.
    ++	 */
     +	result = (result < 0 ? -1 :
    -+			  result > 0 ? 1 :
    -+			  0);
    ++			result > 0 ? 1 :
    ++			0);
     +
     +	check_int(result, ==, expect_result);
     +	check_uint((uintmax_t)offset, ==, expect_offset);
     +}
     +
     +#define TEST_STRCMP_OFFSET(string1, string2, expect_result, expect_offset) \
    -+		TEST(check_strcmp_offset(string1, string2, expect_result, expect_offset), \
    -+			"strcmp_offset(%s, %s) works", #string1, #string2)
    ++	TEST(check_strcmp_offset(string1, string2, expect_result,          \
    ++				 expect_offset),                           \
    ++	     "strcmp_offset(%s, %s) works", #string1, #string2)
     +
    -+int cmd_main(int argc, const char **argv) {
    ++int cmd_main(int argc, const char **argv)
    ++{
     +	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
     +	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
     +	TEST_STRCMP_OFFSET("abc", "abz", -1, 2);

 Makefile                       |  2 +-
 t/helper/test-strcmp-offset.c  | 23 ----------------------
 t/helper/test-tool.c           |  1 -
 t/helper/test-tool.h           |  1 -
 t/t0065-strcmp-offset.sh       | 22 ---------------------
 t/unit-tests/t-strcmp-offset.c | 35 ++++++++++++++++++++++++++++++++++
 6 files changed, 36 insertions(+), 48 deletions(-)
 delete mode 100644 t/helper/test-strcmp-offset.c
 delete mode 100755 t/t0065-strcmp-offset.sh
 create mode 100644 t/unit-tests/t-strcmp-offset.c

diff --git a/Makefile b/Makefile
index 8f4432ae57..59d98ba688 100644
--- a/Makefile
+++ b/Makefile
@@ -839,7 +839,6 @@ TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-simple-ipc.o
-TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
@@ -1338,6 +1337,7 @@ UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
deleted file mode 100644
index d8473cf2fc..0000000000
--- a/t/helper/test-strcmp-offset.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "test-tool.h"
-#include "read-cache-ll.h"
-
-int cmd__strcmp_offset(int argc UNUSED, const char **argv)
-{
-	int result;
-	size_t offset;
-
-	if (!argv[1] || !argv[2])
-		die("usage: %s <string1> <string2>", argv[0]);
-
-	result = strcmp_offset(argv[1], argv[2], &offset);
-
-	/*
-	 * Because different CRTs behave differently, only rely on signs
-	 * of the result values.
-	 */
-	result = (result < 0 ? -1 :
-			  result > 0 ? 1 :
-			  0);
-	printf("%d %"PRIuMAX"\n", result, (uintmax_t)offset);
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f6fd0fe491..7ad7d07018 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -78,7 +78,6 @@ static struct test_cmd cmds[] = {
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "simple-ipc", cmd__simple_ipc },
-	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
 	{ "submodule", cmd__submodule },
 	{ "submodule-config", cmd__submodule_config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 868f33453c..d14b3072bd 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -71,7 +71,6 @@ int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
-int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
deleted file mode 100755
index 94e34c83ed..0000000000
--- a/t/t0065-strcmp-offset.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-
-test_description='Test strcmp_offset functionality'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-while read s1 s2 expect
-do
-	test_expect_success "strcmp_offset($s1, $s2)" '
-		echo "$expect" >expect &&
-		test-tool strcmp-offset "$s1" "$s2" >actual &&
-		test_cmp expect actual
-	'
-done <<-EOF
-abc abc 0 3
-abc def -1 0
-abc abz -1 2
-abc abcdef -1 3
-EOF
-
-test_done
diff --git a/t/unit-tests/t-strcmp-offset.c b/t/unit-tests/t-strcmp-offset.c
new file mode 100644
index 0000000000..fe4c2706b1
--- /dev/null
+++ b/t/unit-tests/t-strcmp-offset.c
@@ -0,0 +1,35 @@
+#include "test-lib.h"
+#include "read-cache-ll.h"
+
+static void check_strcmp_offset(const char *string1, const char *string2,
+				int expect_result, uintmax_t expect_offset)
+{
+	size_t offset;
+	int result = strcmp_offset(string1, string2, &offset);
+
+	/*
+	 * Because different CRTs behave differently, only rely on signs of the
+	 * result values.
+	 */
+	result = (result < 0 ? -1 :
+			result > 0 ? 1 :
+			0);
+
+	check_int(result, ==, expect_result);
+	check_uint((uintmax_t)offset, ==, expect_offset);
+}
+
+#define TEST_STRCMP_OFFSET(string1, string2, expect_result, expect_offset) \
+	TEST(check_strcmp_offset(string1, string2, expect_result,          \
+				 expect_offset),                           \
+	     "strcmp_offset(%s, %s) works", #string1, #string2)
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
+	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
+	TEST_STRCMP_OFFSET("abc", "abz", -1, 2);
+	TEST_STRCMP_OFFSET("abc", "abcdef", -1, 3);
+
+	return test_done();
+}
-- 
2.45.1

