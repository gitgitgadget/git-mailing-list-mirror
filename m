Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44E2E84B
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465955; cv=none; b=J3WugjBp5LMZZY54MJZ+N14OZFY+dXhXufyURJj9x+6OBYaeFEZPZEvNBLE54+TSX9BP705PlhEOe1Kc/7eZB9FeEJwzoj7o9JxsJtvlewuXB1qV679VqN4PqpK8/lHveTU2v0wfnBLKP+pxC0FFkHBiIy+wa9Q0IzmeKNbYPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465955; c=relaxed/simple;
	bh=Fa41ozPir9KhV0HaVUnYDp3KZkUEvArzQDm7rDskCVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKYm5ZKcPNmS1HrQy6r657ANSdLyo4lagh0NzaR4wg1apgQ2mI9v+mN0JrPd7JkQdpSxrsmsMeBNHlJzNNaXv2KLcJamUdYtbPT5KKw12PaVglnvRYDlIpwHZKmOlNrZcy2FEN7VI62k9zHlwHOHHbmJxOgZpJv6ztIwsXc3xOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQH7iSp9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQH7iSp9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746ce7d13so18581905ad.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706465952; x=1707070752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YHyU6MqMCHXq2hPfm8VOn74AGDALEZb1Ngh3+xMlZY=;
        b=fQH7iSp9H3MMGLOdlTyx1C7IPCThPwaSweP+7ZnJP7xhOB79gELDXNWEmv+w+IdNFa
         juhYpoAGH0M+hT9QEB7pYi4M5QGByO3S2FuxHmEpdvAwMFZO6s32pckReTjkNEZTa0hN
         HOvC4bqPq6zz+fILoypXh2F4rS/flGVSSQ1ydzFHGgajBaGqfWMYgUbuNT1p6GI1HM4a
         6u9ZRwrbDl03n/G4q5qzQMtJ6r9hueLiBsLUYaEkG1nuqG+YPxEZJ2insaDe3VHcB9Xd
         awI0FPuGGPAN/RsWnywHAh/RysGuys2VDdamxjzK3HX7N/1EMiqycfND9QEzt5tddA5L
         x0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706465952; x=1707070752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YHyU6MqMCHXq2hPfm8VOn74AGDALEZb1Ngh3+xMlZY=;
        b=DZq/go5hT9lYlI+NYWwkbR4+beC/z1Zuj/NUWjGipvlL5zMEdw7dk9PRp41veToXO7
         TeB+1oDZhQb6At7qS3xkbY1dFg9HuLqJ++noXjPbH5YMvZSwX2HSghir3sLzAEIkMOI8
         VD2DbZQpGnwQZXlzrbUCiHWHJCpqUkcONC7ZQ+fDxtHT9u/yQVePkRkQlmf6OfmKGw2U
         RVFxKVObxQn7Gf0a6OAfv515YPrWVCwHQ8Q1poujcz7uuGlpNib/shimXeZKv+2QEzkY
         Qg8NEPaR89l7lRO+H41ZZIMVELMOl8YP8lGKPxHIOeork+b6kU3o8qlAza9HwRQFfGro
         R24Q==
X-Gm-Message-State: AOJu0YxUFTT3IbYMgts97lNhZdSAd8vxzoeAEaSru3Gw8OWEtkkEj5Qm
	jKePD/WmYVIrAztsCinBaHsP4Elwe9V9pjEm8aHswE7ucuh9p2TAxiJkmxK/hFJCng==
X-Google-Smtp-Source: AGHT+IGerv0kY7c1H8uEUUe0WFmNhvTMnFNtyOzbg6RHXgfYj7CCGZak7oyUG1gfyb3pum7BcDyHNQ==
X-Received: by 2002:a17:902:a606:b0:1d8:e5f3:3b8a with SMTP id u6-20020a170902a60600b001d8e5f33b8amr343887plq.76.1706465952391;
        Sun, 28 Jan 2024 10:19:12 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8b574c9f1sm2447026plb.305.2024.01.28.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 10:19:12 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [RFC PATCH 1/2] add-patch: compare object id instead of literal string
Date: Sun, 28 Jan 2024 23:41:22 +0530
Message-ID: <20240128181202.986753-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128181202.986753-2-shyamthakkar001@gmail.com>
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new function reveq(), which takes repository struct and two revision
strings as arguments and returns 0 if the revisions point to the same
object. Passing a rev which does not point to an object is considered
undefined behavior as the underlying function memcmp() will be called
with NULL hash strings.

Subsequently, replace literal string comparison to HEAD in run_add_p()
with reveq() to handle more ways of saying HEAD (such as '@' or '$branch'
where $branch points to same commit as HEAD). This addresses the
NEEDSWORK comment in run_add_p().

However, in ADD_P_RESET mode keep string comparison in logical OR with
reveq() to handle unborn HEAD.

As for the behavior change, with this patch applied if the given
revision points to the same object as HEAD, the patch mode will be set to
patch_mode_(reset,checkout,worktree)_head instead of
patch_mode_(...)_nothead. That is equivalent of not setting -R flag in
diff-index, which would have been otherwise set before this patch.
However, when given same set of inputs, the actual outcome is same as
before this patch. Therefore, this does not affect any automated scripts.

Also, add testcases to check the similarity of result between different
ways of saying HEAD.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
Should the return values of repo_get_oid() be checked in reveq()? As
reveq() is not a global function and is only used in run_add_p(), the
validity of revisions is already checked beforehand by builtin/checkout.c
and builtin/reset.c before the call to run_add_p().

 add-patch.c               | 28 +++++++++++++++-------
 t/t2016-checkout-patch.sh | 50 +++++++++++++++++++++++----------------
 t/t2071-restore-patch.sh  | 21 ++++++++++------
 t/t7105-reset-patch.sh    | 14 +++++++++++
 4 files changed, 77 insertions(+), 36 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..01eb71d90e 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -14,6 +14,7 @@
 #include "color.h"
 #include "compat/terminal.h"
 #include "prompt.h"
+#include "hash.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
@@ -316,6 +317,18 @@ static void setup_child_process(struct add_p_state *s,
 		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
 }
 
+// Check if two revisions point to the same object. Passing a rev which does not
+// point to an object is undefined behavior.
+static inline int reveq(struct repository *r, const char *rev1,
+			const char *rev2)
+{
+	struct object_id oid_rev1, oid_rev2;
+	repo_get_oid(r, rev1, &oid_rev1);
+	repo_get_oid(r, rev2, &oid_rev2);
+
+	return !oideq(&oid_rev1, &oid_rev2);
+}
+
 static int parse_range(const char **p,
 		       unsigned long *offset, unsigned long *count)
 {
@@ -1730,28 +1743,25 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
 		/*
-		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
-		 * compare the commit objects instead so that other ways of
-		 * saying the same thing (such as "@") are also handled
-		 * appropriately.
-		 *
-		 * This applies to the cases below too.
+		 * The literal string comparison to HEAD below is kept
+		 * to handle unborn HEAD.
 		 */
-		if (!revision || !strcmp(revision, "HEAD"))
+		if (!revision || !strcmp(revision, "HEAD") ||
+		    !reveq(r, revision, "HEAD"))
 			s.mode = &patch_mode_reset_head;
 		else
 			s.mode = &patch_mode_reset_nothead;
 	} else if (mode == ADD_P_CHECKOUT) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (!reveq(r, revision, "HEAD"))
 			s.mode = &patch_mode_checkout_head;
 		else
 			s.mode = &patch_mode_checkout_nothead;
 	} else if (mode == ADD_P_WORKTREE) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (!reveq(r, revision, "HEAD"))
 			s.mode = &patch_mode_worktree_head;
 		else
 			s.mode = &patch_mode_worktree_nothead;
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 747eb5563e..431f34fa9c 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -12,6 +12,7 @@ test_expect_success 'setup' '
 	git commit -m initial &&
 	test_tick &&
 	test_commit second dir/foo head &&
+	git branch newbranch &&
 	set_and_save_state bar bar_work bar_index &&
 	save_head
 '
@@ -38,26 +39,35 @@ test_expect_success 'git checkout -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
-	set_and_save_state dir/foo work head &&
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_saved_state dir/foo
-'
-
-test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
-	test_write_lines n y y | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
-
-test_expect_success 'git checkout -p HEAD with change already staged' '
-	set_state dir/foo index index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
+# Note: 'newbranch' points to the same commit as HEAD. And it is technically
+# allowed to name a branch '@' as of now, however in below test '@'
+# represents the shortcut for HEAD.
+for opt in "HEAD" "@" "newbranch"
+do
+	test_expect_success "git checkout -p $opt with NO staged changes: abort" '
+		set_and_save_state dir/foo work head &&
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_saved_state dir/foo &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with NO staged changes: apply" '
+		test_write_lines n y y | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with change already staged" '
+		set_state dir/foo index index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success 'git checkout -p HEAD^...' '
 	# the third n is to get out in case it mistakenly does not apply
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index b5c5c0ff7e..305b4a0c4f 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -12,6 +12,7 @@ test_expect_success PERL 'setup' '
 	git commit -m initial &&
 	test_tick &&
 	test_commit second dir/foo head &&
+	git branch newbranch &&
 	set_and_save_state bar bar_work bar_index &&
 	save_head
 '
@@ -44,13 +45,19 @@ test_expect_success PERL 'git restore -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success PERL 'git restore -p --source=HEAD' '
-	set_state dir/foo work index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git restore -p --source=HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head index
-'
+# Note: 'newbranch' points to the same commit as HEAD. And '@' is a
+# shortcut for HEAD.
+for opt in "HEAD" "@" "newbranch"
+do
+	test_expect_success PERL "git restore -p --source=$opt" '
+		set_state dir/foo work index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git restore -p --source=$opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head index &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success PERL 'git restore -p --source=HEAD^' '
 	set_state dir/foo work index &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 05079c7246..65a8802b29 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -13,6 +13,7 @@ test_expect_success PERL 'setup' '
 	git commit -m initial &&
 	test_tick &&
 	test_commit second dir/foo head &&
+	git branch newbranch &&
 	set_and_save_state bar bar_work bar_index &&
 	save_head
 '
@@ -33,6 +34,19 @@ test_expect_success PERL 'git reset -p' '
 	test_grep "Unstage" output
 '
 
+# Note: '@' can technically also be used as a branch name, but in below test
+# it represents the shortcut for HEAD. And 'newbranch' points to the same
+# commit as HEAD.
+for opt in "HEAD" "@" "newbranch"
+do
+	test_expect_success PERL "git reset -p $opt" '
+		test_write_lines n y | git reset -p $opt >output &&
+		verify_state dir/foo work head &&
+		verify_saved_state bar &&
+		test_grep "Unstage" output
+	'
+done
+
 test_expect_success PERL 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
-- 
2.43.0

