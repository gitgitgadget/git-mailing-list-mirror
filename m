Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466603716D
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171473; cv=none; b=hUXOnWoIrGvhj3qaUgXBE7cIuR9Ll3Z1jDwCZKkPWr3Q/JpQGq/qBuUPA2DvI9JFpAMazbNU+OgMiPkZonHAWBEUgXCfw6UvhNuiCks12ioZoddjN7wd6mx3MqfXVTk0Ad5mkXth/CSOmbDiTKAr0qbRA3J2R8DCe6P29MxL6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171473; c=relaxed/simple;
	bh=Q7pMSyQP80ggGaKhyXA8swmOExRd8oyrTSo+6kokmpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6xssVkXIJJiSiM/shVQb5X0dqKWZsH06VW9TtSRPrjtGAwaUabKMFYBrCNArW+IepmTkt6BH6AOAPnJRHvg8g9hTx8tLHo6fjBkNeMsFRkTXKW19jzOmUlF7TdIFUWGjLyByDg0gsJiOZLlBePmu0kdbN+nghDCB2hpsezdSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVJAh1di; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVJAh1di"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b9a5be6668so865076eaf.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718171471; x=1718776271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r9XrWy8GhQ830TW4yLffFrj4/ysvD19t0QFptNnVMM=;
        b=BVJAh1diEbTUCKeS8O7yvZiXV59625Y73BpBswoimmvQMnrgiQ0X6w0BOn4r3fWpKr
         H4SGVofQY98/oib964Bm4P78sEOrmVhbQUL5PUiU47SKAYcklqEQ8s5FWr9qAF59GFwD
         F391O2ApS+efIQCw5BtkVGtfvjxkOaY/OdJE1yhD2lw497rkWuwnpyBcqCqpi8ZTUWHX
         NLx6XorkMIuW3t2SY5jLdRTq1konF+ZK9Rm5sIvr3o+pZX5/NnR+5YNBKS7aUD6LBPvH
         bnV2L7cS72ZdQ1J0NEo4vWUMV5ZJmWDkiMdlFL5c/o5y0xWTrGUqt2B0IuoBdQ0Dqx+H
         mpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171471; x=1718776271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r9XrWy8GhQ830TW4yLffFrj4/ysvD19t0QFptNnVMM=;
        b=bGi/GCSId3zHuGqGA6wv4xU2b2R9QAmmVjZNS8t4j2C/F+vb9xg15NSz/6RhqDBEmm
         UzxzOzhemlcZ66q8wEA5VYGkmWIxD+l+Wmpd8iLa2jKJ5JuJ5yijMzBRHS+eNQpd6oN6
         K3e0xGB0aDWFjXwYilM5+nDFOBx6zu5WnH8fecByx7t6KyhOiVjUpFn5mh2+Chk5vpvT
         wBcKRk3t9fnWIU4meqRLaeC5SXZVyNB+Cp7fgC+WAXxH5jviyKp7D2ABqa6LHYjmFi5k
         RSu8TtxrW2bscPTsSnEP4d3o0kHECEqROzNwPXi1kSnfKGRIege0X3SivI+2kPo5qC1f
         zllQ==
X-Gm-Message-State: AOJu0Yz8EegI90TJjjzkTP2Jrs39MQTscPVn5EQNvLCDG5vi/97wfT3B
	Su30TosRkWD4/x5mO8Agq+vuR+EBZTRX7iRuMZCOBjl3EwugpDpjbEU4rZH6
X-Google-Smtp-Source: AGHT+IF0hfnUy5y1Q22lYFpxmMYb9Ene7vUj6RQIOJ25L/yhA1R16oNNO/7o5PjAqgHjp0RaRjCJkw==
X-Received: by 2002:a05:6358:7e96:b0:19f:19dd:9029 with SMTP id e5c5f4694b2df-19f69d31b53mr121261555d.9.1718171470664;
        Tue, 11 Jun 2024 22:51:10 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6f78b8336a7sm1934114a12.73.2024.06.11.22.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:51:10 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/5] t-reftable-tree: split test_tree() into two sub-test functions
Date: Wed, 12 Jun 2024 11:08:12 +0530
Message-ID: <20240612055031.3607-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612055031.3607-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
 <20240612055031.3607-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup, tests for both tree_search() and
infix_walk() defined by reftable/tree.{c, h} are performed by
a single test function, test_tree(). Split tree_test() into
test_tree_search() and test_infix_walk() responsible for
independently testing tree_search() and infix_walk() respectively.
This improves the overall readability of the test file as well as
simplifies debugging.

Note that the last parameter in the tree_search() functiom is
'int insert' which when set, inserts the key if it is not found
in the tree. Otherwise, the function returns NULL for such cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 208e7b7874..cb721b377a 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -26,13 +26,12 @@ static void check_increasing(void *arg, void *key)
 	c->last = key;
 }
 
-static void test_tree(void)
+static void test_tree_search(void)
 {
 	struct tree_node *root = NULL;
 	void *values[11] = { 0 };
 	struct tree_node *nodes[11] = { 0 };
 	size_t i = 1;
-	struct curry c = { 0 };
 
 	do {
 		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
@@ -44,13 +43,29 @@ static void test_tree(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
-	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+static void test_infix_walk(void)
+{
+	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct curry c = { 0 };
+	size_t i = 1;
+
+	do {
+		tree_search(values + i, &root, &test_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	infix_walk(root, &check_increasing, &c);
 	tree_free(root);
 }
 
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(test_tree(), "tree_search and infix_walk work");
+	TEST(test_tree_search(), "tree_search works");
+	TEST(test_infix_walk(), "infix_walk works");
 
 	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

