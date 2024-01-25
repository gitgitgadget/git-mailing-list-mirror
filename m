Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034013664D
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212961; cv=none; b=GJqrj16PhyVRstgm2+/FPJq/BaKIGOr1ahtkAmH6lyxUIuXj3fOPGGBwx2LSyaXUZ7qQdD88fOxmv2N8OKZbVOKEMIdjwPtw/4KbE9uH+S5yecWLVctsR+KX4isaOcVt66MtDw5F58ozVawlq6XPKkhCQKvXlhWildf5MpeGq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212961; c=relaxed/simple;
	bh=lBTpAvJy9FP3gWok5Ndm6v3x5CkFRlZFxm5k6vIJQTE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p93adBQM8ZNIPyNji0ZC9cEUgEICCOEsguJ5nE14V7HNWyD9TcU1GMPrxO2PsbRzVWXjgymWlCLVsR8eNXJjIGk4xE0O02eFaAV/UZESTub588HvbMGjAgkb4wcSt8dj7bTHbVwaCMxBdVHaciI9AIHYIpZlOBjvrdsWLDhfXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsYvNPgR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsYvNPgR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eccccfce0so22839985e9.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 12:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212956; x=1706817756; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk4HeSwwJxVJlUdu42BmRyyrQCYE+zvgWktzMTnITMY=;
        b=SsYvNPgRS/C0KsaRkfK9i2sYZ3HBZG44bUuIJnFaWA3v9oLK/KD7Xh+yixwH0oHeZQ
         oiKx5oXPWUWWJJtlL9csR/BVlz0NEaxfIAIyy9/c2nqdkbtqjeT5QOKt/d/LiVNrW0dd
         Vb/5y//34sVN5MXvlIjRc8bAPCkfvKjuyPnqjVyYVWBd+4QDfZsxLQYAdDT2urekHGgL
         5DDaPJOvdSH8+47qACemeFrdeVCxqmllpsUpLqcT8fWE0YIrbkHu+cxbezg+2YUHXw/c
         TiYf3Q8tlWZPXLZKG9GnDeASoaJaO7552QBih1Wx6opjc9GvQKQZWIXZIX/62Mw5fUtv
         3GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212956; x=1706817756;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk4HeSwwJxVJlUdu42BmRyyrQCYE+zvgWktzMTnITMY=;
        b=Jt3M9Nt3PaanY4bHREhnSr/AzydNGakRGdGXJiI3HZnKTRVfII0ZP8D+xYDfs99LX/
         whUzhzOiIRSNiK6RqURgKwTMm960W85ONKArdfRdLaW0a4xGGD/ebdyEGnl7B98PM+0r
         rcaxoR6XXtJtzaTyiCdqSkagU0Ra4vvgtKqqag/BnaBowBuw63dyw4M/dGT4yuS534wA
         pEfZBZsKU9khN9cDF2HAYxH6wyW8a9BYi9pyDhUlhngWzrY8ehWc9EM16kSyeNYZYb4X
         avfz4lUGykd63dWxcQJqeivvTSQeEWg0oE1jjX5D9hQoN3X0Ny7yYmQWEoP2UmLpRGVy
         8/8A==
X-Gm-Message-State: AOJu0Yw5b3JyastpHhgb8oGtNvJogHrL+9tXoTB/65yGTW4fJL1wHq93
	tHFklZBB30sCTjh9vEcZEV4b7xQqGpdDQ6HdZ0qz7abACS8+duclfjxlZY/h
X-Google-Smtp-Source: AGHT+IGhP6nFdwSAVr32ENBpNZcADxj+dDdlIqLihei0RpPdTSCVUyqoL45cx2TX3NcXF31oBGYC7w==
X-Received: by 2002:a05:600c:4f0e:b0:40d:6f89:a839 with SMTP id l14-20020a05600c4f0e00b0040d6f89a839mr201067wmq.30.1706212956329;
        Thu, 25 Jan 2024 12:02:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jh4-20020a05600ca08400b0040d5c58c41dsm3445722wmb.24.2024.01.25.12.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:02:36 -0800 (PST)
Message-ID: <pull.1642.v5.git.1706212955415.gitgitgadget@gmail.com>
In-Reply-To: <pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com>
References: <pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Jan 2024 20:02:35 +0000
Subject: [PATCH v5] tests: move t0009-prio-queue.sh to the new unit testing
 framework
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
    Jeff King <peff@peff.net>,
    Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

t/t0009-prio-queue.sh along with t/helper/test-prio-queue.c unit
tests Git's implementation of a priority queue. Migrate the
test over to the new unit testing framework to simplify debugging
and reduce test run-time. Refactor the required logic and add
a new test case in addition to porting over the original ones in
shell.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    tests: move t0009-prio-queue.sh to the new unit testing framework
    
    Thanks for the feedbacks! I have updated the patch so that the resulting
    tests show something like:
    
    > check "result[j++] == show(get)" failed at
    > unit-tests/t-prio-queue.c:60
    
    > left: 20 right: 2
    
    > input: push 1, push 2, get, get, get, push 1, push 2, get, get, get,
    
    > failed at input index 8
    
    in the case of a failing test.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1642%2FChand-ra%2Fprio-queue-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1642/Chand-ra/prio-queue-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1642

Range-diff vs v4:

 1:  e9a0dba6f47 ! 1:  88e70127ad3 tests: move t0009-prio-queue.sh to the new unit testing framework
     @@ t/unit-tests/t-prio-queue.c (new)
      +	return v ? *v : MISSING;
      +}
      +
     ++static void print_input(int *input, size_t input_size)
     ++{
     ++	char buf[128];
     ++	int len = 0;
     ++	for(size_t i = 0; i < input_size; i++) {
     ++		switch (input[i]) {
     ++		case GET:
     ++			len += xsnprintf(buf+len, sizeof(buf), "get, ");
     ++			break;
     ++		case DUMP:
     ++			len += xsnprintf(buf+len, sizeof(buf), "dump");
     ++			break;
     ++		case STACK:
     ++			len += xsnprintf(buf+len, sizeof(buf), "stack, ");
     ++			break;
     ++		case REVERSE:
     ++			len += xsnprintf(buf+len, sizeof(buf), "reverse, ");
     ++			break;
     ++		default:
     ++			len += xsnprintf(buf+len, sizeof(buf), "push %d, ", input[i]);
     ++			break;
     ++		}
     ++	}
     ++	test_msg("input: %s", buf);
     ++}
     ++
      +static void test_prio_queue(int *input, int *result, size_t input_size)
      +{
      +	struct prio_queue pq = { intcmp };
      +
      +	for (int i = 0, j = 0; i < input_size; i++) {
      +		void *peek, *get;
     -+		switch(input[i]) {
     ++		switch (input[i]) {
      +		case GET:
      +			peek = prio_queue_peek(&pq);
      +			get = prio_queue_get(&pq);
      +			if (!check(peek == get))
      +				return;
     -+			if(!check_int(result[j++], ==, show(get)))
     -+				test_msg("failed at result[] index %d", j-1);
     ++			if (!check_int(result[j++], ==, show(get))) {
     ++				print_input(input, input_size);
     ++				test_msg("failed at input index %d", i);
     ++			}
      +			break;
      +		case DUMP:
      +			while ((peek = prio_queue_peek(&pq))) {
      +				get = prio_queue_get(&pq);
      +				if (!check(peek == get))
      +					return;
     -+				if(!check_int(result[j++], ==, show(get)))
     -+					test_msg("failed at result[] index %d", j-1);
     ++				if (!check_int(result[j++], ==, show(get))) {
     ++					print_input(input, input_size);
     ++					test_msg("failed at input index %d", i);
     ++				}
      +			}
      +			break;
      +		case STACK:
     @@ t/unit-tests/t-prio-queue.c (new)
      +	clear_prio_queue(&pq);
      +}
      +
     ++
      +#define BASIC_INPUT 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP
      +#define BASIC_RESULT 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10
      +


 Makefile                    |   2 +-
 t/helper/test-prio-queue.c  |  51 --------------
 t/helper/test-tool.c        |   1 -
 t/helper/test-tool.h        |   1 -
 t/t0009-prio-queue.sh       |  66 ------------------
 t/unit-tests/t-prio-queue.c | 129 ++++++++++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+), 120 deletions(-)
 delete mode 100644 t/helper/test-prio-queue.c
 delete mode 100755 t/t0009-prio-queue.sh
 create mode 100644 t/unit-tests/t-prio-queue.c

diff --git a/Makefile b/Makefile
index 312d95084c1..d5e48e656b3 100644
--- a/Makefile
+++ b/Makefile
@@ -828,7 +828,6 @@ TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
-TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
 TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
@@ -1340,6 +1339,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
deleted file mode 100644
index f0bf255f5f0..00000000000
--- a/t/helper/test-prio-queue.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include "test-tool.h"
-#include "prio-queue.h"
-
-static int intcmp(const void *va, const void *vb, void *data UNUSED)
-{
-	const int *a = va, *b = vb;
-	return *a - *b;
-}
-
-static void show(int *v)
-{
-	if (!v)
-		printf("NULL\n");
-	else
-		printf("%d\n", *v);
-	free(v);
-}
-
-int cmd__prio_queue(int argc UNUSED, const char **argv)
-{
-	struct prio_queue pq = { intcmp };
-
-	while (*++argv) {
-		if (!strcmp(*argv, "get")) {
-			void *peek = prio_queue_peek(&pq);
-			void *get = prio_queue_get(&pq);
-			if (peek != get)
-				BUG("peek and get results do not match");
-			show(get);
-		} else if (!strcmp(*argv, "dump")) {
-			void *peek;
-			void *get;
-			while ((peek = prio_queue_peek(&pq))) {
-				get = prio_queue_get(&pq);
-				if (peek != get)
-					BUG("peek and get results do not match");
-				show(get);
-			}
-		} else if (!strcmp(*argv, "stack")) {
-			pq.compare = NULL;
-		} else {
-			int *v = xmalloc(sizeof(*v));
-			*v = atoi(*argv);
-			prio_queue_put(&pq, v);
-		}
-	}
-
-	clear_prio_queue(&pq);
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 876cd2dc313..5f591b9718f 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -57,7 +57,6 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
-	{ "prio-queue", cmd__prio_queue },
 	{ "proc-receive", cmd__proc_receive },
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 70dd4eba119..b921138d8ec 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -50,7 +50,6 @@ int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
-int cmd__prio_queue(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
deleted file mode 100755
index eea99107a48..00000000000
--- a/t/t0009-prio-queue.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-test_description='basic tests for priority queue implementation'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-cat >expect <<'EOF'
-1
-2
-3
-4
-5
-5
-6
-7
-8
-9
-10
-EOF
-test_expect_success 'basic ordering' '
-	test-tool prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<'EOF'
-2
-3
-4
-1
-5
-6
-EOF
-test_expect_success 'mixed put and get' '
-	test-tool prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<'EOF'
-1
-2
-NULL
-1
-2
-NULL
-EOF
-test_expect_success 'notice empty queue' '
-	test-tool prio-queue 1 2 get get get 1 2 get get get >actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<'EOF'
-3
-2
-6
-4
-5
-1
-8
-EOF
-test_expect_success 'stack order' '
-	test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
new file mode 100644
index 00000000000..8456b23255c
--- /dev/null
+++ b/t/unit-tests/t-prio-queue.c
@@ -0,0 +1,129 @@
+#include "test-lib.h"
+#include "prio-queue.h"
+
+static int intcmp(const void *va, const void *vb, void *data UNUSED)
+{
+	const int *a = va, *b = vb;
+	return *a - *b;
+}
+
+
+#define MISSING  -1
+#define DUMP	 -2
+#define STACK	 -3
+#define GET	 -4
+#define REVERSE  -5
+
+static int show(int *v)
+{
+	return v ? *v : MISSING;
+}
+
+static void print_input(int *input, size_t input_size)
+{
+	char buf[128];
+	int len = 0;
+	for(size_t i = 0; i < input_size; i++) {
+		switch (input[i]) {
+		case GET:
+			len += xsnprintf(buf+len, sizeof(buf), "get, ");
+			break;
+		case DUMP:
+			len += xsnprintf(buf+len, sizeof(buf), "dump");
+			break;
+		case STACK:
+			len += xsnprintf(buf+len, sizeof(buf), "stack, ");
+			break;
+		case REVERSE:
+			len += xsnprintf(buf+len, sizeof(buf), "reverse, ");
+			break;
+		default:
+			len += xsnprintf(buf+len, sizeof(buf), "push %d, ", input[i]);
+			break;
+		}
+	}
+	test_msg("input: %s", buf);
+}
+
+static void test_prio_queue(int *input, int *result, size_t input_size)
+{
+	struct prio_queue pq = { intcmp };
+
+	for (int i = 0, j = 0; i < input_size; i++) {
+		void *peek, *get;
+		switch (input[i]) {
+		case GET:
+			peek = prio_queue_peek(&pq);
+			get = prio_queue_get(&pq);
+			if (!check(peek == get))
+				return;
+			if (!check_int(result[j++], ==, show(get))) {
+				print_input(input, input_size);
+				test_msg("failed at input index %d", i);
+			}
+			break;
+		case DUMP:
+			while ((peek = prio_queue_peek(&pq))) {
+				get = prio_queue_get(&pq);
+				if (!check(peek == get))
+					return;
+				if (!check_int(result[j++], ==, show(get))) {
+					print_input(input, input_size);
+					test_msg("failed at input index %d", i);
+				}
+			}
+			break;
+		case STACK:
+			pq.compare = NULL;
+			break;
+		case REVERSE:
+			prio_queue_reverse(&pq);
+			break;
+		default:
+			prio_queue_put(&pq, &input[i]);
+			break;
+		}
+	}
+	clear_prio_queue(&pq);
+}
+
+
+#define BASIC_INPUT 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP
+#define BASIC_RESULT 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10
+
+#define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
+#define MIXED_PUT_GET_RESULT 2, 3, 4, 1, 5, 6
+
+#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
+#define EMPTY_QUEUE_RESULT 1, 2, MISSING, 1, 2, MISSING
+
+#define STACK_INPUT STACK, 8, 1, 5, 4, 6, 2, 3, DUMP
+#define STACK_RESULT 3, 2, 6, 4, 5, 1, 8
+
+#define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
+#define REVERSE_STACK_RESULT 1, 2, 3, 4, 5, 6
+
+#define TEST_INPUT(INPUT, RESULT, name)			\
+  static void test_##name(void)				\
+{								\
+	int input[] = {INPUT};					\
+	int result[] = {RESULT};				\
+	test_prio_queue(input, result, ARRAY_SIZE(input));	\
+}
+
+TEST_INPUT(BASIC_INPUT, BASIC_RESULT, basic)
+TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_RESULT, mixed)
+TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_RESULT, empty)
+TEST_INPUT(STACK_INPUT, STACK_RESULT, stack)
+TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_RESULT, reverse)
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(test_basic(), "prio-queue works for basic input");
+	TEST(test_mixed(), "prio-queue works for mixed put & get commands");
+	TEST(test_empty(), "prio-queue works when queue is empty");
+	TEST(test_stack(), "prio-queue works when used as a LIFO stack");
+	TEST(test_reverse(), "prio-queue works when LIFO stack is reversed");
+
+	return test_done();
+}

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
