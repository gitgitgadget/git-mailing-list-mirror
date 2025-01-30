Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833E1B4243
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228438; cv=none; b=qySO3M3dCScx9K1DIER6dPCJ9WS5/L1pQnYbQTzbZJ5DP3p4CvJ+EFbZsJIhOlov0/gikZlBwqByrA2XrS2HQtwPYojRv/E9bEvotKzcI4CQtL5f07SBFNkwx/T9j0is85fJGVLrBNWlhjLN3W1YwCKIHowCBVNsyBxAfJPg1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228438; c=relaxed/simple;
	bh=jfTH4JEv1ZTwEjAiZIiJ0Ym9Mv56yiRN8sblrkutTY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzXvLfGscvNpzJJqojS+Bkgq3Oyeq92TdVxOwTLVPjNn1rwa4CkSnyjsksC+apwt9Tswno5NBOPT5Tl6Q2HdU/YKexpt8ru6UcPcw7IyWp15QezbmY4cAJgsW9TpBJILA7JYJa9CCp+Ty99+1jbYJH85tC6V37HbPVImscPwWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+0UC/oo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+0UC/oo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso937869a12.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738228435; x=1738833235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46ZJLy13d8XyVS+Tm2//4aBH5tveKhmyIuJs4p8Kc98=;
        b=J+0UC/ooqDtC6I37/YEq+HVbQjPwCT+vELycVNk5Lgs/JOUMYFTqD3NCrc78rqaC8j
         zhvXcCVXOupdhlhIFeOr2iA/V3z31xmZs/xtTa8/mtvBKSt9+1QknxiaPlLlEXbJc2+M
         NUFFdEZloIJDi+UH3GSyH2jtIKRZSx716VbzBkJyO+IjGNKLDP/9p+0s/55ibYFPhVc4
         ygNPlV3n2IAtFXBBD9Hl86ttmb/H0A/AiCjEYa/nTRGrrEIdYmGZG7JN7s8jlnNwDkDm
         7N9AI2JvF3BSptUryiWQzlk7E2DDbB1Srnw4MBwWDMK0ITS+fFPrOcrVT9ob0ja2D492
         KZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228435; x=1738833235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46ZJLy13d8XyVS+Tm2//4aBH5tveKhmyIuJs4p8Kc98=;
        b=mNR5zcAfI+wJWVdehSJy1yajSQMDY0b4immFV9697vhpcIAUI2vFTUDA6+X4LQg5HO
         lh5YuTxAJpOf9VUTLsyXQfkkDELjLoB/cQU8EkZwy+4que4Bm1y2Zjrzs/FS/t3HJ8Bd
         FV4w/Yb8LT5BHBtz/Ppw8sEgtyoTeKvt2ROL4DLdcTSYyn7QNMUIFM85ymg/KuNR5qf+
         K30wmRZW718zM181htD1QrIj+opEs8JQC8gxDjuZP+q6lNFPmLIk1W9GE8ZcUFUuEHpt
         2ZIt4g4YfefeL/Z0ufPTxOzSrnPFZtJuOZL+ynolloGFcykntDXukFKmqhS8ca562cBW
         iXlA==
X-Gm-Message-State: AOJu0Yyl1sp380FkYTIjmpwrzg4hbrvUnVoRISnmDz+Oyidt/HeFpCE5
	8zel2bI9yQyRrq9xjuLOLWsacTG2HmIoRh3zVcURvr8YxvqRnCgpE/8bPnwmLMyz8A==
X-Gm-Gg: ASbGnctzoG/9T0zbfIq4qVR7nGPMXZ2VkmOXHkjtwQ5sTM9iOdI6FSLH/cHSNNu+O+i
	5H6miakv77QNSjc52PEULrJ4YZgaMO7JgPIeMweb764qLObmZoQHoJf3xp2KLyd4coRvNIONazR
	GEcym0jdzriEa2WOWvkf5anMmbGc23Ni8MY3qMts3WfueHrZqSBU/3b6RjCDibST9n91TJpuxG7
	abUaxnFDocEVJLSPgTbIXn1anVWBd0lL86Lfoj5+e1rjFPLRKJkEZ7KGE4W2RLRoZwrGUwhFDbn
	+F7Xt3Iw+NYCxaqL2BhvLFxDJ+BSSg==
X-Google-Smtp-Source: AGHT+IEdSG4y6SqzpWxIjRgxENFtQqkIjXHH/Jfj+qtD4ozkVb+tawVYw2uEZDCX5eTbM2gbhP/TlQ==
X-Received: by 2002:a05:6402:2791:b0:5db:faf8:e06d with SMTP id 4fb4d7f45d1cf-5dc5efb8ccemr6530302a12.7.1738228434524;
        Thu, 30 Jan 2025 01:13:54 -0800 (PST)
Received: from localhost.localdomain ([154.120.90.178])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e9ee4sm742249a12.25.2025.01.30.01.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 01:13:54 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 2/4] t/unit-tests: adapt example decorate test to clar framework
Date: Thu, 30 Jan 2025 10:13:32 +0100
Message-ID: <20250130091334.39922-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250130091334.39922-1-kuforiji98@gmail.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapts example decorate test script to clar framework by using clar
assertions where necessary. Test functions are created as standalone to
test different test cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                          |  2 +-
 t/meson.build                     |  2 +-
 t/unit-tests/t-example-decorate.c | 74 ------------------------------
 t/unit-tests/u-example-decorate.c | 76 +++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 76 deletions(-)
 delete mode 100644 t/unit-tests/t-example-decorate.c
 create mode 100644 t/unit-tests/u-example-decorate.c

diff --git a/Makefile b/Makefile
index 2d9dad119a..732d765f1c 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,6 +1338,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
+CLAR_TEST_SUITES += u-example-decorate
 CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
@@ -1349,7 +1350,6 @@ CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
diff --git a/t/meson.build b/t/meson.build
index af597f9804..c7e08eca6f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,5 +1,6 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
+  'unit-tests/u-example-decorate.c',
   'unit-tests/u-hash.c',
   'unit-tests/u-hashmap.c',
   'unit-tests/u-mem-pool.c',
@@ -45,7 +46,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-example-decorate.c',
   'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example-decorate.c
deleted file mode 100644
index bfc776e223..0000000000
--- a/t/unit-tests/t-example-decorate.c
+++ /dev/null
@@ -1,74 +0,0 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
-#include "test-lib.h"
-#include "object.h"
-#include "decorate.h"
-#include "repository.h"
-
-struct test_vars {
-	struct object *one, *two, *three;
-	struct decoration n;
-	int decoration_a, decoration_b;
-};
-
-static void t_add(struct test_vars *vars)
-{
-	void *ret = add_decoration(&vars->n, vars->one, &vars->decoration_a);
-
-	check(ret == NULL);
-	ret = add_decoration(&vars->n, vars->two, NULL);
-	check(ret == NULL);
-}
-
-static void t_readd(struct test_vars *vars)
-{
-	void *ret = add_decoration(&vars->n, vars->one, NULL);
-
-	check(ret == &vars->decoration_a);
-	ret = add_decoration(&vars->n, vars->two, &vars->decoration_b);
-	check(ret == NULL);
-}
-
-static void t_lookup(struct test_vars *vars)
-{
-	void *ret = lookup_decoration(&vars->n, vars->one);
-
-	check(ret == NULL);
-	ret = lookup_decoration(&vars->n, vars->two);
-	check(ret == &vars->decoration_b);
-	ret = lookup_decoration(&vars->n, vars->three);
-	check(ret == NULL);
-}
-
-static void t_loop(struct test_vars *vars)
-{
-	int objects_noticed = 0;
-
-	for (size_t i = 0; i < vars->n.size; i++) {
-		if (vars->n.entries[i].base)
-			objects_noticed++;
-	}
-	check_int(objects_noticed, ==, 2);
-}
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
-	struct test_vars vars = { 0 };
-
-	vars.one = lookup_unknown_object(the_repository, &one_oid);
-	vars.two = lookup_unknown_object(the_repository, &two_oid);
-	vars.three = lookup_unknown_object(the_repository, &three_oid);
-
-	TEST(t_add(&vars),
-	     "Add 2 objects, one with a non-NULL decoration and one with a NULL decoration.");
-	TEST(t_readd(&vars),
-	     "When re-adding an already existing object, the old decoration is returned.");
-	TEST(t_lookup(&vars),
-	     "Lookup returns the added declarations, or NULL if the object was never added.");
-	TEST(t_loop(&vars), "The user can also loop through all entries.");
-
-	clear_decoration(&vars.n, NULL);
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-example-decorate.c b/t/unit-tests/u-example-decorate.c
new file mode 100644
index 0000000000..3a457d41fc
--- /dev/null
+++ b/t/unit-tests/u-example-decorate.c
@@ -0,0 +1,76 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "unit-test.h"
+#include "object.h"
+#include "decorate.h"
+#include "repository.h"
+
+struct test_vars {
+	struct object *one, *two, *three;
+	struct decoration n;
+	int decoration_a, decoration_b;
+};
+
+static struct test_vars vars;
+
+void test_example_decorate__add(void)
+{
+	void *ret = add_decoration(&vars.n, vars.one, &vars.decoration_a);
+	cl_assert(ret == NULL);
+	ret = add_decoration(&vars.n, vars.two, NULL);
+	cl_assert(ret == NULL);
+}
+
+void test_example_decorate__readd(void)
+{
+	void *ret;
+
+	cl_assert(add_decoration(&vars.n, vars.one, &vars.decoration_a) == NULL);
+	cl_assert(add_decoration(&vars.n, vars.two, NULL) == NULL);
+
+	ret = add_decoration(&vars.n, vars.one, NULL);
+	cl_assert(ret == &vars.decoration_a);
+	ret = add_decoration(&vars.n, vars.two, &vars.decoration_b);
+	cl_assert(ret == NULL);
+}
+
+void test_example_decorate__lookup(void)
+{
+	void *ret;
+
+	add_decoration(&vars.n, vars.two, &vars.decoration_b);
+	add_decoration(&vars.n, vars.one, NULL);
+
+	ret = lookup_decoration(&vars.n, vars.two);
+	cl_assert(ret == &vars.decoration_b);
+	ret = lookup_decoration(&vars.n, vars.one);
+	cl_assert(ret == NULL);
+}
+
+void test_example_decorate__loop(void)
+{
+	int objects_noticed = 0;
+
+	add_decoration(&vars.n, vars.one, &vars.decoration_a);
+	add_decoration(&vars.n, vars.two, &vars.decoration_b);
+
+	for (size_t i = 0; i < vars.n.size; i++) {
+		if (vars.n.entries[i].base)
+			objects_noticed++;
+	}
+	cl_assert_equal_i(objects_noticed, 2);
+}
+
+void test_example_decorate__initialize(void)
+{
+	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
+
+	vars.one = lookup_unknown_object(the_repository, &one_oid);
+	vars.two = lookup_unknown_object(the_repository, &two_oid);
+	vars.three = lookup_unknown_object(the_repository, &three_oid);
+}
+
+void test_example_decorate__cleanup(void)
+{
+	clear_decoration(&vars.n, NULL);
+}
-- 
2.47.0.86.g15030f9556

