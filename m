Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B03C26
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317945; cv=none; b=gJptFhV2UATXxtF6/qQD8OyeTi8IV0z/P5VImEzj92s73z/7Ov9Cj2pOwmJi6JivyLO23oFHR0grZs+POqWL2bVVh/TB3HU5Fp5qV/f+OpJcsJz4UC9yMCbNX6rxpNAzpDGOM6r2vK3yWZuW+Sev0amQkFkEjNJDkX5ZCtY0P+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317945; c=relaxed/simple;
	bh=0VZQZ4uO2euqBbzwRlk8/twwEFaLOKHkoJMEPCjyLVo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Udhd79bQUW06Zl86eEnhsGkuR6MVPmdbx0tK2w9CIZNKvCIMtS3hqeM6ZDaOok4FqI5faR6+iwPEsgeCbEiFeQAmgWdLQlVD73F4dgJNsvHKtTJZIoRkFdq7ZypeTYFVG/OcH2DqMZRFI16xDUeTrpI6B4UyvSdP9wWUtThjol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwJknduC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwJknduC"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d18931a94so1693699f8f.1
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 20:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708317941; x=1708922741; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EdHh2OzjiRjZwya1ZQbkXFQUUSOrqE5ZRIvk8EBr9M=;
        b=MwJknduCHHbIwIoU7oL4tLXztozSetp6CWT27JWYbc2rsAdKksF5c1vdn0RAm26UQu
         ERZkbf/ZJX6qzrOk5v5atNmkMnghVG5nQG5Oy+C0u0h7CoFP8mmWX5Q0EbeBgRIwftUU
         xiESGlFg7/8Ygvt7d4oNYL0hPqK5vqdFdYO2TfXTtvG2gfI3I3UnuhnOsoiKN+j7wy9t
         v20rmYJzYL6/N546NhPxHJ1ujrRzi8ebI9x5T7zWcgTO04awMEHFBTjNMfHO8eB1fyby
         SmvPIZyvUJGuSGZDD9r0OKQ/JskoipNAjs7ihGikBbjeJPvUaZvSD/NRDrYmKs5tlJcr
         0Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708317941; x=1708922741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EdHh2OzjiRjZwya1ZQbkXFQUUSOrqE5ZRIvk8EBr9M=;
        b=sfWH0U3SppKoQG3lGV91HaxScupdR+tV4h2kfp7vT0IMTo+WtAncc2GzAr99JrP+BY
         YPCglrDpn5dDJIAp0eMKWBUAwGHGl4OJG3go3Buo2qicuH50wAzH6bv3wuNU6Bf+/Hul
         jGTsaG5J6t3DKZiuNizin3i0QRbg/OH4yeEd58olA79572+dP4t7pLRhiZXiAmR2KjC4
         9AY7msC2x0jQDlMEYNuLu+A+AgnoEHFdcf/KNHvZTQwHwcIkX8eNtdNcdDeEs/aZGHHG
         e3Fp7rIxE+RNStld6BZY3C4LV/oBVFLnNZDagrnKvukVrsT91K+CQK8s0PovOIF9lXei
         I1hQ==
X-Gm-Message-State: AOJu0YxfHky/+CTsR5cdUGDn+9lFwjUTz1cDIBhrtcrooKqR4YrswltZ
	ohYRoIUsSbDu8Asqvrmo58Iesr0wT2MK23dpqXQvg93oLCc/tbuatsAr1y1N
X-Google-Smtp-Source: AGHT+IGDLpkPODCYl6ADPWmtXqEvqkK/Nfpe5sl7GWzSs+YREbdxGlu2emmvmn2Jg5LbgkLEedQgrw==
X-Received: by 2002:a5d:4a49:0:b0:33d:11a2:42 with SMTP id v9-20020a5d4a49000000b0033d11a20042mr6114993wrs.47.1708317940766;
        Sun, 18 Feb 2024 20:45:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c20d500b0041044e130bfsm9951557wmm.33.2024.02.18.20.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 20:45:39 -0800 (PST)
Message-ID: <2c60c4406d4eb1307a32f23604f3ef8e34ad56d6.1708317938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Feb 2024 04:45:37 +0000
Subject: [PATCH 1/2] apply: add unit tests for parse_range and rename to
 parse_fragment_range
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

This patchset makes the parse_range function in apply be non-internal
linkage in order to expose to the unit testing framework. In so doing,
because there is another function called parse_range, I gave this one a more
specific name, parse_fragment_range. Other than that, this commit adds
several test cases (positive and negative) for the function.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 Makefile               |  1 +
 apply.c                |  8 ++---
 apply.h                |  4 +++
 t/unit-tests/t-apply.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/t-apply.c

diff --git a/Makefile b/Makefile
index 15990ff3122..369092aedfe 100644
--- a/Makefile
+++ b/Makefile
@@ -1339,6 +1339,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
+UNIT_TEST_PROGRAMS += t-apply
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-strbuf
diff --git a/apply.c b/apply.c
index 7608e3301ca..199a1150df6 100644
--- a/apply.c
+++ b/apply.c
@@ -1430,8 +1430,8 @@ static int parse_num(const char *line, unsigned long *p)
 	return ptr - line;
 }
 
-static int parse_range(const char *line, int len, int offset, const char *expect,
-		       unsigned long *p1, unsigned long *p2)
+int parse_fragment_range(const char *line, int len, int offset, const char *expect,
+			 unsigned long *p1, unsigned long *p2)
 {
 	int digits, ex;
 
@@ -1530,8 +1530,8 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
 		return -1;
 
 	/* Figure out the number of lines in a fragment */
-	offset = parse_range(line, len, 4, " +", &fragment->oldpos, &fragment->oldlines);
-	offset = parse_range(line, len, offset, " @@", &fragment->newpos, &fragment->newlines);
+	offset = parse_fragment_range(line, len, 4, " +", &fragment->oldpos, &fragment->oldlines);
+	offset = parse_fragment_range(line, len, offset, " @@", &fragment->newpos, &fragment->newlines);
 
 	return offset;
 }
diff --git a/apply.h b/apply.h
index 7cd38b1443c..bbc5e3caeb5 100644
--- a/apply.h
+++ b/apply.h
@@ -187,3 +187,7 @@ int apply_all_patches(struct apply_state *state,
 		      int options);
 
 #endif
+
+
+int parse_fragment_range(const char *line, int len, int offset, const char *expect,
+		       unsigned long *p1, unsigned long *p2);
diff --git a/t/unit-tests/t-apply.c b/t/unit-tests/t-apply.c
new file mode 100644
index 00000000000..ff0abfb2e0b
--- /dev/null
+++ b/t/unit-tests/t-apply.c
@@ -0,0 +1,67 @@
+#include "test-lib.h"
+#include "apply.h"
+
+#define FAILURE -1
+
+static void setup_static(const char *line, int len, int offset,
+						 const char *expect, int assert_result,
+						 unsigned long assert_p1,
+						 unsigned long assert_p2)
+{
+	unsigned long p1 = 9999;
+	unsigned long p2 = 9999;
+	int result = parse_fragment_range(line, len, offset, expect, &p1, &p2);
+	check_int(result, ==, assert_result);
+	check_int(p1, ==, assert_p1);
+	check_int(p2, ==, assert_p2);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	char* text;
+	int expected_result;
+
+	/* Success */
+	text = "@@ -4,4 +";
+	expected_result = 9;
+	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
+		 "well-formed range");
+
+	text = "@@ -4 +8 @@";
+	expected_result = 7;
+	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 1),
+		 "non-comma range");
+
+	/* Failure */
+	text = "@@ -X,4 +";
+	expected_result = FAILURE;
+	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 9999, 9999),
+		 "non-digit range (first coordinate)");
+
+	text = "@@ -4,X +";
+	expected_result = FAILURE;
+	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 1), // p2 is 1, a little strange but not catastrophic
+		 "non-digit range (second coordinate)");
+
+	text = "@@ -4,4 -";
+	expected_result = FAILURE;
+	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
+		 "non-expected trailing text");
+
+	text = "@@ -4,4";
+	expected_result = FAILURE;
+	TEST(setup_static(text, strlen(text), 4, " +", expected_result, 4, 4),
+		 "not long enough for expected trailing text");
+
+	text = "@@ -4,4";
+	expected_result = FAILURE;
+	TEST(setup_static(text, strlen(text), 7, " +", expected_result, 9999, 9999),
+		 "not long enough for offset");
+
+	text = "@@ -4,4";
+	expected_result = FAILURE;
+	TEST(setup_static(text, strlen(text), -1, " +", expected_result, 9999, 9999),
+		 "negative offset");
+
+	return test_done();
+}
-- 
gitgitgadget

