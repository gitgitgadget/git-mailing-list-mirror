Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF01A2C1E
	for <git@vger.kernel.org>; Sun, 26 May 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716710080; cv=none; b=OjRCjDFhAxrCO78K64GOREVRRqtXE97mS5JrNd9Kaa9gMdTjM9q1WfHh0VTlbojwMOlXSMUg8JyWIojbXOT0S7+t7kwDzcf+z46dl9z3LVtUd2wbcePAekrKgy3a4vJH2eEEVpxqdEFpaMUXO1IW2Fj+KCNzZoyAx33fiCUNLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716710080; c=relaxed/simple;
	bh=k7zyICfdYdf4pOsDqe38gsprRUPJ8A0AHvAfzMcHIK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SEAwlJ7KVxIoLty/v0SNzUIO10k2gbnttYSdzSYhrzw/6WfIMY7g62DnWY0nfH0wLhc7qEos4SBNHfAqNgOdaVm/dv9lFrOFptnq/4sEUYyJGghEpM3CLP32d9/Du3Ay1J3OH59k7GADAkFHCssTjvnbgyCA/doZck7fq+C2noQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXRDDBjC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXRDDBjC"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354faf5f1b4so3096513f8f.1
        for <git@vger.kernel.org>; Sun, 26 May 2024 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716710077; x=1717314877; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCllrjrJTcE2mJTSBxx/WGKEaRIuObhD/iMj30Akb+c=;
        b=YXRDDBjCSBJjgmJSmfSwbx1QVZP/KOQ4ceJrjDIJnKlw/toECdDfwi5j9r2RiSdmuU
         Au4AX3xOoqKTwbjrJleXTrRpFAKG+POq3VmkBTPfts5fUYcWyNg3OpbrQRpTZ5ns8qcI
         y5JSKiMob+cWPjqxEvJgsymla9vvnL4+SlV21zEE0OUPYaqTk4o3s8qCTLhw5W57KKBd
         2z9ypM/IhjX3v6Fdv6crs8nOHwy5YtDHw5ZRcC0ywKJfBuJzq8fWXabeFNo2GWcPAI+h
         wvs0uCi+/tpaWwT3tKLaXBIK+cF44GTfcoAWnij+BUJDxe9eFAmNQtVJgXrXEYBgb/VW
         LkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716710077; x=1717314877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCllrjrJTcE2mJTSBxx/WGKEaRIuObhD/iMj30Akb+c=;
        b=dBdTIwzO/Bfx2LwBCnu++GgTdszWHBG3EMbwYlNEp6+S22ZhAGsIvgfht7Oug93F/j
         gPYyKlXoLaWqd3nCwJ9Ct2r3KjPBtBqOfvCZc+SDl0EUAB1Oe6oh2X+mGEa8vb4e7t2G
         nrEWi8+r2cZhm21PO2crCvPd9w16LHtsoYd9hJDAoyMwfqXtIa200VoUblcpUFUyrma1
         Za+4cmLD+TZU5EiCyHrWKYCuJSQgxakac5C61+/xZeAjd5ckNgdsmUIJqMLg2nNN7nj/
         JJrcxRmLMDhq1IbcneNQsczNE0qyve5PIlsKYivZ2gSQJuaIRZhhBfCF8LQNpGzixLf9
         YY8w==
X-Gm-Message-State: AOJu0YxCaqPnd67K35GnIG7kAKhMeox0ZZabPAB2sZi6hE0XXIKUDqQ5
	rTC+RdfnikdiwTN6/5MiwwINrQBdKUFTzd79tWiatTHgWy5ht5/iM5kvjQ==
X-Google-Smtp-Source: AGHT+IFzYhFeGhH+q+zQ/LevZy/7kftYzTaWx0eoVIFZ1CPCo8IWpgMYQJaf/kIl/y8DuJT8Tbu5TQ==
X-Received: by 2002:a05:6000:1f8e:b0:354:fab6:3103 with SMTP id ffacd0b85a97d-3552fe17e47mr7420519f8f.60.1716710076473;
        Sun, 26 May 2024 00:54:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a8c9sm5859951f8f.40.2024.05.26.00.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 00:54:35 -0700 (PDT)
Message-Id: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>
In-Reply-To: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 May 2024 07:54:33 +0000
Subject: [PATCH v2] apply: add unit tests for parse_range
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
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Philip <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

Also rename parse_range to parse_fragment_range for external linkage.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
    apply: add unit tests for parse_range
    
    Add unit tests for apply's parse_range function. Also rename parse_range
    to parse_fragment_range and expose it externally for use by the unit
    tests. Internal callers may continue to refer to it by the name
    parse_range.
    
    It is necessary to make the function be non-internal linkage in order to
    expose it to the unit testing framework. Because there is another
    function in the codebase also called parse_range, change this one to a
    more specific name as well: parse_fragment_range. Also add several test
    cases (both positive and negative) for the function.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1677%2Fphilip-peterson%2Fpeterson%2Funit-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1677/philip-peterson/peterson/unit-tests-v2
Pull-Request: https://github.com/git/git/pull/1677

Range-diff vs v1:

 1:  2c60c4406d4 < -:  ----------- apply: add unit tests for parse_range and rename to parse_fragment_range
 2:  7dab12ab7b8 ! 1:  c0d7b93e383 apply: rewrite unit tests with structured cases
     @@ Metadata
      Author: Philip Peterson <philip.c.peterson@gmail.com>
      
       ## Commit message ##
     -    apply: rewrite unit tests with structured cases
     +    apply: add unit tests for parse_range
      
     -    The imperative format was a little hard to read, so I rewrote the test cases
     -    in a declarative style by defining a common structure for each test case and
     -    its assertions.
     +    Also rename parse_range to parse_fragment_range for external linkage.
      
          Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
      
     - ## t/unit-tests/t-apply.c ##
     + ## Makefile ##
     +@@ Makefile: THIRD_PARTY_SOURCES += compat/regex/%
     + THIRD_PARTY_SOURCES += sha1collisiondetection/%
     + THIRD_PARTY_SOURCES += sha1dc/%
     + 
     ++UNIT_TEST_PROGRAMS += t-apply
     + UNIT_TEST_PROGRAMS += t-ctype
     + UNIT_TEST_PROGRAMS += t-mem-pool
     + UNIT_TEST_PROGRAMS += t-prio-queue
     +
     + ## apply.c ##
      @@
     + #include "wildmatch.h"
     + #include "ws.h"
       
     - #define FAILURE -1
     ++#define parse_range apply_parse_fragment_range
     ++
     + struct gitdiff_data {
     + 	struct strbuf *root;
     + 	int linenr;
     +@@ apply.c: static int parse_num(const char *line, unsigned long *p)
     + 	return ptr - line;
     + }
       
     --static void setup_static(const char *line, int len, int offset,
     --						 const char *expect, int assert_result,
     --						 unsigned long assert_p1,
     --						 unsigned long assert_p2)
     +-static int parse_range(const char *line, int len, int offset, const char *expect,
     +-		       unsigned long *p1, unsigned long *p2)
     ++int apply_parse_fragment_range(const char *line, int len, int offset, const char *expect,
     ++			 unsigned long *p1, unsigned long *p2)
     + {
     + 	int digits, ex;
     + 
     +
     + ## apply.h ##
     +@@ apply.h: int apply_all_patches(struct apply_state *state,
     + 		      int argc, const char **argv,
     + 		      int options);
     + 
     ++/*
     ++ * exposed only for tests; do not call this as it not
     ++ * a part of the API
     ++ */
     ++extern int apply_parse_fragment_range(const char *line, int len, int offset,
     ++				      const char *expect, unsigned long *p1,
     ++				      unsigned long *p2);
     ++
     + #endif
     +
     + ## t/unit-tests/t-apply.c (new) ##
     +@@
     ++#include "test-lib.h"
     ++#include "apply.h"
     ++
     ++#define FAILURE -1
     ++
      +typedef struct test_case {
      +	const char *line;
      +	const char *expect_suffix;
     @@ t/unit-tests/t-apply.c
      +} test_case;
      +
      +static void setup_static(struct test_case t)
     - {
     - 	unsigned long p1 = 9999;
     - 	unsigned long p2 = 9999;
     --	int result = parse_fragment_range(line, len, offset, expect, &p1, &p2);
     --	check_int(result, ==, assert_result);
     --	check_int(p1, ==, assert_p1);
     --	check_int(p2, ==, assert_p2);
     -+	int result = parse_fragment_range(t.line, strlen(t.line), t.offset, t.expect_suffix, &p1, &p2);
     ++{
     ++	unsigned long p1 = 9999;
     ++	unsigned long p2 = 9999;
     ++	int result = apply_parse_fragment_range(t.line, strlen(t.line), t.offset,
     ++						t.expect_suffix, &p1, &p2);
      +	check_int(result, ==, t.expect_result);
      +	check_int(p1, ==, t.expect_p1);
      +	check_int(p2, ==, t.expect_p2);
     - }
     - 
     - int cmd_main(int argc, const char **argv)
     - {
     --	char* text;
     --	int expected_result;
     --
     --	/* Success */
     --	text = "@@ -4,4 +";
     --	expected_result = 9;
     --	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
     --		 "well-formed range");
     ++}
     ++
     ++int cmd_main(int argc, const char **argv)
     ++{
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -4,4 +",
      +		.offset = 4,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 4,
      +		.expect_p2 = 4
      +	}), "well-formed range");
     - 
     --	text = "@@ -4 +8 @@";
     --	expected_result = 7;
     --	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 1),
     --		 "non-comma range");
     ++
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -4 +8 @@",
      +		.offset = 4,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 4,
      +		.expect_p2 = 1
      +	}), "non-comma range");
     - 
     --	/* Failure */
     --	text = "@@ -X,4 +";
     --	expected_result = FAILURE;
     --	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 9999, 9999),
     --		 "non-digit range (first coordinate)");
     ++
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -X,4 +",
      +		.offset = 4,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 9999,
      +		.expect_p2 = 9999
      +	}), "non-digit range (first coordinate)");
     - 
     --	text = "@@ -4,X +";
     --	expected_result = FAILURE;
     --	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 1), // p2 is 1, a little strange but not catastrophic
     --		 "non-digit range (second coordinate)");
     ++
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -4,X +",
      +		.offset = 4,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 4,
      +		.expect_p2 = 1 // A little strange this is 1, but not end of the world
      +	}), "non-digit range (second coordinate)");
     - 
     --	text = "@@ -4,4 -";
     --	expected_result = FAILURE;
     --	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
     --		 "non-expected trailing text");
     ++
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -4,4 -",
      +		.offset = 4,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 4,
      +		.expect_p2 = 4
      +	}), "non-expected trailing text");
     - 
     --	text = "@@ -4,4";
     --	expected_result = FAILURE;
     --	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
     --		 "not long enough for expected trailing text");
     ++
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -4,4",
      +		.offset = 4,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 4,
      +		.expect_p2 = 4
      +	}), "not long enough for expected trailing text");
     - 
     --	text = "@@ -4,4";
     --	expected_result = FAILURE;
     --	TEST(setup_static(text, strlen(text), 7, " +", expected_result, 9999, 9999),
     --		 "not long enough for offset");
     ++
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -4,4",
      +		.offset = 7,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 9999,
      +		.expect_p2 = 9999
      +	}), "not long enough for offset");
     - 
     --	text = "@@ -4,4";
     --	expected_result = FAILURE;
     --	TEST(setup_static(text, strlen(text), -1, " +", expected_result, 9999, 9999),
     --		 "negative offset");
     ++
      +	TEST(setup_static((struct test_case) {
      +		.line = "@@ -4,4",
      +		.offset = -1,
     @@ t/unit-tests/t-apply.c
      +		.expect_p1 = 9999,
      +		.expect_p2 = 9999
      +	}), "negative offset");
     - 
     - 	return test_done();
     - }
     ++
     ++	return test_done();
     ++}


 Makefile               |   1 +
 apply.c                |   6 ++-
 apply.h                |   8 ++++
 t/unit-tests/t-apply.c | 101 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 t/unit-tests/t-apply.c

diff --git a/Makefile b/Makefile
index 8f4432ae57c..1615de69e6c 100644
--- a/Makefile
+++ b/Makefile
@@ -1334,6 +1334,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
+UNIT_TEST_PROGRAMS += t-apply
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
diff --git a/apply.c b/apply.c
index 901b67e6255..8cdf7e7d77f 100644
--- a/apply.c
+++ b/apply.c
@@ -36,6 +36,8 @@
 #include "wildmatch.h"
 #include "ws.h"
 
+#define parse_range apply_parse_fragment_range
+
 struct gitdiff_data {
 	struct strbuf *root;
 	int linenr;
@@ -1438,8 +1440,8 @@ static int parse_num(const char *line, unsigned long *p)
 	return ptr - line;
 }
 
-static int parse_range(const char *line, int len, int offset, const char *expect,
-		       unsigned long *p1, unsigned long *p2)
+int apply_parse_fragment_range(const char *line, int len, int offset, const char *expect,
+			 unsigned long *p1, unsigned long *p2)
 {
 	int digits, ex;
 
diff --git a/apply.h b/apply.h
index 7cd38b1443c..283aba77495 100644
--- a/apply.h
+++ b/apply.h
@@ -186,4 +186,12 @@ int apply_all_patches(struct apply_state *state,
 		      int argc, const char **argv,
 		      int options);
 
+/*
+ * exposed only for tests; do not call this as it not
+ * a part of the API
+ */
+extern int apply_parse_fragment_range(const char *line, int len, int offset,
+				      const char *expect, unsigned long *p1,
+				      unsigned long *p2);
+
 #endif
diff --git a/t/unit-tests/t-apply.c b/t/unit-tests/t-apply.c
new file mode 100644
index 00000000000..0eb0c22fc0d
--- /dev/null
+++ b/t/unit-tests/t-apply.c
@@ -0,0 +1,101 @@
+#include "test-lib.h"
+#include "apply.h"
+
+#define FAILURE -1
+
+typedef struct test_case {
+	const char *line;
+	const char *expect_suffix;
+	int offset;
+	unsigned long expect_p1;
+	unsigned long expect_p2;
+	int expect_result;
+} test_case;
+
+static void setup_static(struct test_case t)
+{
+	unsigned long p1 = 9999;
+	unsigned long p2 = 9999;
+	int result = apply_parse_fragment_range(t.line, strlen(t.line), t.offset,
+						t.expect_suffix, &p1, &p2);
+	check_int(result, ==, t.expect_result);
+	check_int(p1, ==, t.expect_p1);
+	check_int(p2, ==, t.expect_p2);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4 +",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = 9,
+		.expect_p1 = 4,
+		.expect_p2 = 4
+	}), "well-formed range");
+
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4 +8 @@",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = 7,
+		.expect_p1 = 4,
+		.expect_p2 = 1
+	}), "non-comma range");
+
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -X,4 +",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 9999,
+		.expect_p2 = 9999
+	}), "non-digit range (first coordinate)");
+
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,X +",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 4,
+		.expect_p2 = 1 // A little strange this is 1, but not end of the world
+	}), "non-digit range (second coordinate)");
+
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4 -",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 4,
+		.expect_p2 = 4
+	}), "non-expected trailing text");
+
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 4,
+		.expect_p2 = 4
+	}), "not long enough for expected trailing text");
+
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4",
+		.offset = 7,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 9999,
+		.expect_p2 = 9999
+	}), "not long enough for offset");
+
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4",
+		.offset = -1,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 9999,
+		.expect_p2 = 9999
+	}), "negative offset");
+
+	return test_done();
+}

base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
-- 
gitgitgadget
