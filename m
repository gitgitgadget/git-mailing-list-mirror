Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562338DF2
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171469; cv=none; b=YbxttsOWuo96shIxWsYAFk93/XpTdI6Gg+L8d5AoBPM7WJWbFQsEAs1gkDuouTHvWbKGrsgHX7BN0nV+wRZyeci4/ZTHGg91fdcaB0zznQPT0Usw6/D1sjJJD9puFAO8pEAybM1OIcI1R3Sz3JNDIWadrsiXc4uJBMOjGP6NKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171469; c=relaxed/simple;
	bh=Pq6fvH6see6NZIBIFeB7IaN4Jg8NcBtFIkuTYeLePQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slUHHdh5/wWkiVYITC2YzAGciqWxgig43mh4siiiRPcSi6rs+zDbSe2UGXN99o75l+dTmd4i2y6Fs5E1wW+oVvyZfwViqD9v3zBe+h0/0rNWQgKzX+V3pnNRWu2V5uTqObOf2s6q7P63eAnM9VFmrYRifpdwrykBXb2o0jlagOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPQeOvtt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPQeOvtt"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-705959a2dfbso473366b3a.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718171467; x=1718776267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDFXxri1fS73+VNmjcNGWp15A/C0f4gErIv+95CXRHo=;
        b=RPQeOvttSLcktcBj5E+/BP+wFvqo3WKaV3ajw8nlooqacgubFG1XsbXvZ87A67IupH
         LbE2KUCjaFV+eXwsBaiQwuDtshoB7CkEkbgk5oEyv4o3IJ4RpQM+b7lgZz0N4zueOjlI
         lYbjmFHTZdVJWDjCht3LbEUbwPT2vq2TXPAiDYOiREUdm/U1Yygxnj9u5EzL0LkKVz52
         gHseirPxjFdHSmgFnzR64yiXKUIC2VdKPZhVSdSzxOx6p2Nqnwd7e3t2APPNZRDmuHMi
         lhAUnATGUQ/mF0wXi8HQmFEPs/rzNjqcbSlwEsLjmxaq3MiRs500srdJVNc4RoKyz+xn
         w3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171467; x=1718776267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDFXxri1fS73+VNmjcNGWp15A/C0f4gErIv+95CXRHo=;
        b=qtVTTjiut7g3aRV3RYCby50jek+sFNWl9BdkYXbNBTeriK+4pu7Ih10kLaESd4OF8F
         KlQ7uQOWKo5d84GVOUBY1HXwyP06+CEe9HjzyzzztqrACJlKoYkUM5a66n4SBdDNDgRW
         ZHRZNrcAjVELNykXH9h0bUp2VkpCQ7alAChxd/nDknZaWFXphhTNTZQWpBMfF7BApuO6
         6GZdR8WOsok/yM/30MyvjAgtM/sO2EUx9yVrfwvxJDJlmzbysnJnJU4YdaZZLIKxoLtS
         VA5QiEokE8o+4SjCD3mnRghplQXNfSbWeLx+SObLAeeNv0uNM+nkZk/h62NAV/4aAJoV
         lsXg==
X-Gm-Message-State: AOJu0YzUzTnb9DkzVDTbO4ZQ3mhtl74wD0Ov2XU4fx/T0pP7Lm7mNwAt
	zRhEOkUVFiYfZog3tmSr/qR0kANXnTup+MBJeZw/vcHNy5LNEoJW3a7VauGq
X-Google-Smtp-Source: AGHT+IEbap6G9oPBpA6v1fvLVKrEO3bNJ5eB4JI67E95Rhw60CMpxBhh+ymIcwiMj10Xn/f3yVC9Wg==
X-Received: by 2002:a05:6a20:9190:b0:1b0:3910:3796 with SMTP id adf61e73a8af0-1b86d5acb9emr5769024637.31.1718171467449;
        Tue, 11 Jun 2024 22:51:07 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6f78b8336a7sm1934114a12.73.2024.06.11.22.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:51:06 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/5] t: move reftable/tree_test.c to the unit testing framework
Date: Wed, 12 Jun 2024 11:08:11 +0530
Message-ID: <20240612055031.3607-3-chandrapratap3519@gmail.com>
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

reftable/tree_test.c exercises the functions defined in
reftable/tree.{c, h}. Migrate reftable/tree_test.c to the
unit testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |  2 +-
 t/helper/test-reftable.c                      |  1 -
 .../unit-tests/t-reftable-tree.c              | 32 ++++++++-----------
 3 files changed, 15 insertions(+), 20 deletions(-)
 rename reftable/tree_test.c => t/unit-tests/t-reftable-tree.c (59%)

diff --git a/Makefile b/Makefile
index 2f5f16847a..d736b2f8bd 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2681,7 +2682,6 @@ REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
-REFTABLE_TEST_OBJS += reftable/tree_test.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index bae731669c..9475db2f76 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -8,7 +8,6 @@ int cmd__reftable(int argc, const char **argv)
 	basics_test_main(argc, argv);
 	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	merged_test_main(argc, argv);
diff --git a/reftable/tree_test.c b/t/unit-tests/t-reftable-tree.c
similarity index 59%
rename from reftable/tree_test.c
rename to t/unit-tests/t-reftable-tree.c
index 6961a657ad..208e7b7874 100644
--- a/reftable/tree_test.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -6,11 +6,8 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "system.h"
-#include "tree.h"
-
-#include "test_framework.h"
-#include "reftable-tests.h"
+#include "test-lib.h"
+#include "reftable/tree.h"
 
 static int test_compare(const void *a, const void *b)
 {
@@ -24,37 +21,36 @@ struct curry {
 static void check_increasing(void *arg, void *key)
 {
 	struct curry *c = arg;
-	if (c->last) {
-		EXPECT(test_compare(c->last, key) < 0);
-	}
+	if (c->last)
+		check_int(test_compare(c->last, key), <, 0);
 	c->last = key;
 }
 
 static void test_tree(void)
 {
 	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct tree_node *nodes[11] = { 0 };
+	size_t i = 1;
+	struct curry c = { 0 };
 
-	void *values[11] = { NULL };
-	struct tree_node *nodes[11] = { NULL };
-	int i = 1;
-	struct curry c = { NULL };
 	do {
 		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
 		i = (i * 7) % 11;
 	} while (i != 1);
 
 	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
-		EXPECT(values + i == nodes[i]->key);
-		EXPECT(nodes[i] ==
-		       tree_search(values + i, &root, &test_compare, 0));
+		check_pointer_eq(values + i, nodes[i]->key);
+		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
 	infix_walk(root, check_increasing, &c);
 	tree_free(root);
 }
 
-int tree_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_tree);
-	return 0;
+	TEST(test_tree(), "tree_search and infix_walk work");
+
+	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

