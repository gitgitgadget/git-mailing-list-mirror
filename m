Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EEB1667C2
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966278; cv=none; b=ea1s8LoLMkbeklllX3X2rJCTopqgRW+R/iqljrjpRZti25S5LkYw1/2tIbXB0ZCJF+DYaMQhaUda3qM3AKEZl3DIQT7qCw9dxG17tmdXZXFRRFiPvxrWPKaAZxIHqdSMFv8muml5fEVVxaVNGL1V3xWGwFQgKpaIE1MKhsnMk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966278; c=relaxed/simple;
	bh=xg3BzUGxdqlLQJCI2sza5JvZPdESVZ31Y6f7GLMd+4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHYphge1bSYGWSzFBaKYMZa8qi+4ADQf8/xncUXSpXCWu2dhBADjsWeYCzpmjO/i5EJGTbECTq+oXlweNU87eV2yW+GMS/Fcd/FQ6IO09fE5gKUEe3MxQcIS6R9m/6wGW6KrtluFpbLlZERHpoflePtu37yeCnvd1K6++Iip4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DreEtIG/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DreEtIG/"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-701ae8698d8so1378630b3a.0
        for <git@vger.kernel.org>; Wed, 29 May 2024 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966276; x=1717571076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr8ozju04b/fENvmFIgkx7p6m+nNn/O94ghV0XkCMIc=;
        b=DreEtIG/RjzdZkmbY+ANWLdXmczfTyWBj4XbAZErfGh+Qm16bUdp3hU2q+OtYEEoDs
         iFZE+PuBNckQAddZ3gXRZQhNmBRJ1Dj/BNI4iRor8XAy6Y4eTlkSfUvLd/jCZ+CBtf0r
         NUtUVi+khnbuFTyzyASF1MLJFmMGLIhI+Ct7aJmaWsa9F6D28B1E2W9HIRfE3oaYfbzo
         5b1tPBl8G5r5a4b2aMNcGgCQvhbwmyxaf0ZhoFZeUnFAQ1lKAWckKSb/J88noG/bwcV2
         qrUxVYeXYq0ljf3fKdkTeAgQGflkkJ61vkqmZbmHHccvHztJI8GSzm8bNOpp2taJqpsN
         j81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966276; x=1717571076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wr8ozju04b/fENvmFIgkx7p6m+nNn/O94ghV0XkCMIc=;
        b=WdJPWSuVLKCjzARLo6RettiyJ23VLH66nK/i9bVViyVHoSu35w1m2NdOLlSDY9zzKT
         G0KpF481Jyj4d/z2mYuXDRIlPoOsWHtQ8fMQSD75vlnIpYQMHXFNvJjVTLo1d7Cv8YCg
         nP0o2I6g+F1r0NAR37JBYLYgulhTKWF0HF0NySGJItpieMlIho5yyOD80ZbOB4Xi2r88
         93fwbbKjIjNX+tbKIPw+lb1uXMJlUW8MF3jFFttODdWrf9j2zQVbT6bMeJOTphvzkDpR
         CCOIIJY31ePapYW2bNehgHObPqiVFSFfbxHVBfXPMbK5oMUZlLpWy8qbi/sPEKd1YqAE
         5zyA==
X-Gm-Message-State: AOJu0YwS2vEd1PPAGiW3/CUnFDMV3ai4p0j0zHBBtLK3gUNuplTglE6g
	MKpXSqVkbU6vFBGGqctkV8ZyUXIbUJQQicMCFOl7mNANJGvR/DbgYfsISKO2yvc=
X-Google-Smtp-Source: AGHT+IEDxy18WfNUqPKiKLMndHGcbLpzx4bPQ9f1gKFlGxOKBp5tRlW94JX8ymdSABJbhVMzeWZx6A==
X-Received: by 2002:a05:6a00:28cd:b0:6ea:c2a2:5648 with SMTP id d2e1a72fcca58-6f8f2c3f9b4mr16496700b3a.3.1716966275762;
        Wed, 29 May 2024 00:04:35 -0700 (PDT)
Received: from Ubuntu.. ([171.51.188.185])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7473376b3a.39.2024.05.29.00.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:04:35 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 2/4] t: move tests from reftable/stack_test.c to the new unit test
Date: Wed, 29 May 2024 12:25:10 +0530
Message-ID: <20240529070341.4248-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529070341.4248-1-chandrapratap3519@gmail.com>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_names() and names_equal() are functions defined in
reftable/basics.{c, h}. Move the tests for these functions from
reftable/stack_test.c to the newly ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/stack_test.c            | 25 -------------------------
 t/unit-tests/t-reftable-basics.c | 25 ++++++++++++++++++++++---
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7889f818d1..6f6af11e53 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -102,29 +102,6 @@ static void test_read_file(void)
 	(void) remove(fn);
 }
 
-static void test_parse_names(void)
-{
-	char buf[] = "line\n";
-	char **names = NULL;
-	parse_names(buf, strlen(buf), &names);
-
-	EXPECT(NULL != names[0]);
-	EXPECT(0 == strcmp(names[0], "line"));
-	EXPECT(NULL == names[1]);
-	free_names(names);
-}
-
-static void test_names_equal(void)
-{
-	char *a[] = { "a", "b", "c", NULL };
-	char *b[] = { "a", "b", "d", NULL };
-	char *c[] = { "a", "b", NULL };
-
-	EXPECT(names_equal(a, a));
-	EXPECT(!names_equal(a, b));
-	EXPECT(!names_equal(a, c));
-}
-
 static int write_test_ref(struct reftable_writer *wr, void *arg)
 {
 	struct reftable_ref_record *ref = arg;
@@ -1048,8 +1025,6 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 int stack_test_main(int argc, const char *argv[])
 {
 	RUN_TEST(test_empty_add);
-	RUN_TEST(test_names_equal);
-	RUN_TEST(test_parse_names);
 	RUN_TEST(test_read_file);
 	RUN_TEST(test_reflog_expire);
 	RUN_TEST(test_reftable_stack_add);
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 99e6c89120..55fcff12d9 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -58,14 +58,32 @@ static void test_names_length(void)
 	check_int(names_length(a), ==, 2);
 }
 
+static void test_names_equal(void)
+{
+	char *a[] = { "a", "b", "c", NULL };
+	char *b[] = { "a", "b", "d", NULL };
+	char *c[] = { "a", "b", NULL };
+
+	check(names_equal(a, a));
+	check(!names_equal(a, b));
+	check(!names_equal(a, c));
+}
+
 static void test_parse_names_normal(void)
 {
-	char in[] = "a\nb\n";
+	char in1[] = "line\n";
+	char in2[] = "a\nb\nc";
 	char **out = NULL;
-	parse_names(in, strlen(in), &out);
+	parse_names(in1, strlen(in1), &out);
+	check_str(out[0], "line");
+	check(!out[1]);
+	free_names(out);
+
+	parse_names(in2, strlen(in2), &out);
 	check_str(out[0], "a");
 	check_str(out[1], "b");
-	check(!out[2]);
+	check_str(out[2], "c");
+	check(!out[3]);
 	free_names(out);
 }
 
@@ -97,6 +115,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_parse_names_drop_empty(), "parse_names drops empty string");
 	TEST(test_binsearch(), "binary search with binsearch works");
 	TEST(test_names_length(), "names_length retuns size of a NULL-terminated string array");
+	TEST(test_names_equal(), "names_equal compares NULL-terminated string arrays");
 
 	return test_done();
 }
-- 
2.45.GIT

