Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A84D27E
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002953; cv=none; b=ixhnLTcRk+PiX9IojalR5VHY+EG7sat7Ue+p9oZ+BRJUoY2N0LZ7QaIW7aO3g7p+rEu34dNRZ3wYLv2ceJw6M5mgVZh8wfj3bqaxURoQgyDwr12SdI9QyQWGxIgHKZYDmGxIDpHdSKEmDPKikuAtiVpPCKiL/3uPqVY6lST8HvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002953; c=relaxed/simple;
	bh=xg3BzUGxdqlLQJCI2sza5JvZPdESVZ31Y6f7GLMd+4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4GArVEi+3KieoXtREtC+2DG1AiTILmtUFiTp5KfnQtAompf7AtwB7qL2pppVBo11kbWbFivwk+wqO3Ah5kiXh5tzpRCT+8AGrWAdqc3/WiVoYXE6kM/5y5/LcDRv2+0FWacUAfy+y67dAxo2bg3KB9u+xkQNWwHsxWf7z1yWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLiE83tJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLiE83tJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d04so19995735ad.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717002951; x=1717607751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr8ozju04b/fENvmFIgkx7p6m+nNn/O94ghV0XkCMIc=;
        b=mLiE83tJHRZqJbu/t24a+m1GnsnQGbxMaGBubJ9a1+MiVSaxqC1yXfmDDCrc3sdlVN
         Ad9Aszb1iaNuZrq6XTBSAvpeWe7z2GTla9+w4tFE8ECpLsnf885bClXTTbCIEtp7Xb2k
         PgG7ib7g2qzT6gANfrFz3NPKMMJrlVbC6LXNx3o15BVgpSUnaVxnQc5gnhoYnP26/9I4
         hgKf/CcfEx8s5Ma2Odf1zSHvr72Db7p78ZZ97w6ZR8gdOP1+5hW+3hxKhdIuXieQTxJv
         33Ct+esGiZjuizj4D3q/j3uDkrKw50udCZPAz/JIIiMq+WaC+BecgqSAIMJAP44JFSQT
         bh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002951; x=1717607751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wr8ozju04b/fENvmFIgkx7p6m+nNn/O94ghV0XkCMIc=;
        b=YVk+KJNr3jCayG2nnPqyw8Nufcl7S/X4WWYNj6b2NBxLInlE2Q+s9kUbsiNlNNMcg+
         g/BxhGPjL+HzIcY3wM2AOPmbMLFd5PGBVx+QI8qrUkRWWehZvSdAUIhGwp4C4GzT+q3r
         O08OxeSavmc1GCyTe/jqMh4K43QkLID5h847c3vnIQHyNdMvqcVARhGU2RtrJwz+CWI3
         i+vvcG/lXPAxfncMNjWZ87/ouk7l/fvSBJJUCs7iiBdIrnmPAshh9mNj/xh0MrcC1ms1
         UaZabDEBKfydhRoNOy4lJ9GdIATaQACWt0DIQeNy9RdtY6Ci7wxvqEHkIN5cpEZ/4ecF
         mgJw==
X-Gm-Message-State: AOJu0YzmlumJ6PT+ue/mPBe8pOPaDLd7fe0/e0vrPRCQWaxzKhzn1dh+
	M7XvKRuKwGV94tpHI2Br5tkRC1ZKImglhbhnegn4/UrVceaxaCDdL/oxca3oHsY=
X-Google-Smtp-Source: AGHT+IF9MnAeNDwTANzJeKmikO09RnmHk1aM9khyXjXvD3IiCj84gbxHEb5KPw6u2wKgofBD2C8s1g==
X-Received: by 2002:a17:902:ce84:b0:1f4:a3a1:789d with SMTP id d9443c01a7336-1f4a3a17a19mr113775845ad.64.1717002951185;
        Wed, 29 May 2024 10:15:51 -0700 (PDT)
Received: from Ubuntu.. ([171.51.169.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f4757734b6sm79720225ad.234.2024.05.29.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:15:50 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v3 2/5] t: move tests from reftable/stack_test.c to the new unit test
Date: Wed, 29 May 2024 22:29:28 +0530
Message-ID: <20240529171439.18271-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529171439.18271-1-chandrapratap3519@gmail.com>
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529171439.18271-1-chandrapratap3519@gmail.com>
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

