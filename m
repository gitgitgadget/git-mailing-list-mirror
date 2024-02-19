Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4D1CD0A
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317945; cv=none; b=KnpnCLLWGzfh0JG8KkCI/S89XDb6lV4YuufFMKGXyRVwlyDSIeBrwgXUBRq+ySUte2perserGR+OL7VyYy/pgmAbnZ4+uvhkqAPzXaEB5po2oyOMPgeUZstcVDkdl7IuwvATvGpVP+SRCqoBYT2Y6cxdpj5GuIRTz5D2bsgNcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317945; c=relaxed/simple;
	bh=6sK8cFM1K+huDUz0oGZzjH3TutaA5miELh4O6mS6SxM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e6JmymNvh1ufeBRxZRlogGS82ngL6wKpFiBwqK9GCNXBTjQWBc/9SVXUgInWYCU7wCMZLXcf1ho2GtTY0pe1w7diEx2npqKcuBTGc+EB1cK1g+fnWcteWW/0xKpBBkhSxyEbMY1aNzA9wc+Vk/9H55xqabicqAad8tdWou8WW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz8JZoB/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz8JZoB/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d28468666so950912f8f.0
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 20:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708317941; x=1708922741; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x3Wi6mlfR6ezpJBtGlzg/O83HS01kI1ADdS3Vtpz60=;
        b=hz8JZoB/oju3Jdq4u/3a3vsZQKZtu3Ro1zXgspdMfk8K3QIfowqQeK+b6L0wxf72gk
         TlZgRawTNQOM6OVE7EZ2nSWE6MuLAd7RGkCD9NHFtRCPpUXEb//N2gayMT6mxZkJmAP/
         Y08f/DWCvKzI2IPQrypoYWE/tFt1UCte91MfqNvJtPOGyXqSl5ij7POc9BIvFoNRmL+M
         sSEyvUWnDu6MQo0L4YxdV7785HrWYYaxE4qW66yMV1zF6CWPpQFiu2/NG7jvfRsECptG
         X+70lZvyLAzrJrlJjB76UmSKCwvMBTyIY3dgmnvaCMRCJwgkZt/FOx5vIqlgu0NA5Aj/
         1Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708317941; x=1708922741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x3Wi6mlfR6ezpJBtGlzg/O83HS01kI1ADdS3Vtpz60=;
        b=YfLc1QXGYLzBeqHy3sQd6wQlShT7ujOY42ivfPdHCPBdG3CVl8lOdZVyQO7Kqlpz4r
         zFlHkgRdslIxeojlfIq2r04Ydfj8yA5vRy/mFmfU5cjTG3ZSrLgDLcFSTniQ4owTmYy4
         q3y8EvUGjrpwy/82ZMhoe9R0cNg/qpDELDkyOMfi/jt5KzhMmFegfh+PqJo5yuH2bAp7
         lDoWMO0OTZgx+22KT1w5i/3iVvBGhYyQufPfGO7Xoy3riCvTAjjJxO1BpAHZ9Hj/WDYY
         xa4R+UuLoeTXn8c7THXYPJO0Ci1WyjkxUOxlTisp1xQxnQfBB4o0RBHiKLKD+6CHUHmn
         i5Qg==
X-Gm-Message-State: AOJu0YxbGlej34qnAG7DVDhb+KLQtXEJ9HtvU7zFw7d915DmFbDfiQBd
	4dBl5hUsgihd+1Grezi1G7EvypGgkMBnr/WGd5sSQW5LZHujXAGqWl422SRC
X-Google-Smtp-Source: AGHT+IFkYDq1AzXt6bHRjGfGPA1azXP7GpXZ8KDHUNGlQpgW5o7vfaRiJiCjcT86bwg8U8se39BKug==
X-Received: by 2002:a5d:4dd2:0:b0:33d:52c6:874 with SMTP id f18-20020a5d4dd2000000b0033d52c60874mr524947wru.58.1708317941280;
        Sun, 18 Feb 2024 20:45:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm4574286wru.76.2024.02.18.20.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 20:45:41 -0800 (PST)
Message-ID: <7dab12ab7b8af3e6a0778fc1a01dd1479990bcff.1708317938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Feb 2024 04:45:38 +0000
Subject: [PATCH 2/2] apply: rewrite unit tests with structured cases
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
Cc: Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

The imperative format was a little hard to read, so I rewrote the test cases
in a declarative style by defining a common structure for each test case and
its assertions.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 t/unit-tests/t-apply.c | 123 ++++++++++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 45 deletions(-)

diff --git a/t/unit-tests/t-apply.c b/t/unit-tests/t-apply.c
index ff0abfb2e0b..2b78624b690 100644
--- a/t/unit-tests/t-apply.c
+++ b/t/unit-tests/t-apply.c
@@ -3,65 +3,98 @@
 
 #define FAILURE -1
 
-static void setup_static(const char *line, int len, int offset,
-						 const char *expect, int assert_result,
-						 unsigned long assert_p1,
-						 unsigned long assert_p2)
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
 {
 	unsigned long p1 = 9999;
 	unsigned long p2 = 9999;
-	int result = parse_fragment_range(line, len, offset, expect, &p1, &p2);
-	check_int(result, ==, assert_result);
-	check_int(p1, ==, assert_p1);
-	check_int(p2, ==, assert_p2);
+	int result = parse_fragment_range(t.line, strlen(t.line), t.offset, t.expect_suffix, &p1, &p2);
+	check_int(result, ==, t.expect_result);
+	check_int(p1, ==, t.expect_p1);
+	check_int(p2, ==, t.expect_p2);
 }
 
 int cmd_main(int argc, const char **argv)
 {
-	char* text;
-	int expected_result;
-
-	/* Success */
-	text = "@@ -4,4 +";
-	expected_result = 9;
-	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
-		 "well-formed range");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4 +",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = 9,
+		.expect_p1 = 4,
+		.expect_p2 = 4
+	}), "well-formed range");
 
-	text = "@@ -4 +8 @@";
-	expected_result = 7;
-	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 1),
-		 "non-comma range");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4 +8 @@",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = 7,
+		.expect_p1 = 4,
+		.expect_p2 = 1
+	}), "non-comma range");
 
-	/* Failure */
-	text = "@@ -X,4 +";
-	expected_result = FAILURE;
-	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 9999, 9999),
-		 "non-digit range (first coordinate)");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -X,4 +",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 9999,
+		.expect_p2 = 9999
+	}), "non-digit range (first coordinate)");
 
-	text = "@@ -4,X +";
-	expected_result = FAILURE;
-	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 1), // p2 is 1, a little strange but not catastrophic
-		 "non-digit range (second coordinate)");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,X +",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 4,
+		.expect_p2 = 1 // A little strange this is 1, but not end of the world
+	}), "non-digit range (second coordinate)");
 
-	text = "@@ -4,4 -";
-	expected_result = FAILURE;
-	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
-		 "non-expected trailing text");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4 -",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 4,
+		.expect_p2 = 4
+	}), "non-expected trailing text");
 
-	text = "@@ -4,4";
-	expected_result = FAILURE;
-	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
-		 "not long enough for expected trailing text");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4",
+		.offset = 4,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 4,
+		.expect_p2 = 4
+	}), "not long enough for expected trailing text");
 
-	text = "@@ -4,4";
-	expected_result = FAILURE;
-	TEST(setup_static(text, strlen(text), 7, " +", expected_result, 9999, 9999),
-		 "not long enough for offset");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4",
+		.offset = 7,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 9999,
+		.expect_p2 = 9999
+	}), "not long enough for offset");
 
-	text = "@@ -4,4";
-	expected_result = FAILURE;
-	TEST(setup_static(text, strlen(text), -1, " +", expected_result, 9999, 9999),
-		 "negative offset");
+	TEST(setup_static((struct test_case) {
+		.line = "@@ -4,4",
+		.offset = -1,
+		.expect_suffix = " +",
+		.expect_result = FAILURE,
+		.expect_p1 = 9999,
+		.expect_p2 = 9999
+	}), "negative offset");
 
 	return test_done();
 }
-- 
gitgitgadget
