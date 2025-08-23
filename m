Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4A21ABA8
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755928829; cv=none; b=hXytFgCfNoolfr+QlDBaQm3mAh+whahgMl/EJkci1vkfn6F7Hgtdj6w/t3YjGotUIwFSRrC1nJTE/g0FSO5aNLHW1rCdtQ1LE3btrMDcfoc+vPCjG6/AnKw3u4Pw4vNZvzvXRaoJegQJhIX7sadRSlB5eVLPXHuEISK7XgOvZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755928829; c=relaxed/simple;
	bh=l6kI94Ki3P5mlbpCM05fH9V34S/WD9lBeM0ywRx/BOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJY4uHMWnoGkqcFZNlGed91P9/7zC86bjmeHooOe7EnNuN3piLKMpy8cLZhW8rn5wO7KyQznGXwV1NZkaKNCDKfuqnzVQzw3aB9ClwhDOJksZDVfsm9guwtdxKM02fO5GxMlKddf1fR57XIiK12bsjS0wvVVepH/2MDTtiw87BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMVeIIrE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMVeIIrE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77040e2e6e1so725263b3a.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755928827; x=1756533627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0cCdUgFsflHUp+yhsVe2YuRQEhS4mpZaqQeMXN02js=;
        b=AMVeIIrE3Uv7v2fuj4LebbecyHoN5uacoaBjhgfJ9BYuD16WBZMQQ/8Zr7LaB9ZyZH
         3GwXg8vfj997kX6e7UBEJQU8Z+ClQ9FkYVDA7gbP5wbJY0fFF8avU19PGJu96L3jPgpi
         61oZQ4FyssjgZHdr62WpxMGjT/DXSJzQYY8prpshn6u+2JOqAOz5yWXB3otoQEaJpxY6
         hdXzOt3VkcuudkVt6dTorzWilJTNSE40pcHdhjvWejP9yglUHNyUNY+5E1KQUub/k0n0
         e4SVhTM3dVqGq8SisIk7sbilVVclw9Mm5rHeQRoGnREC7T/+7yRUlFYD54p7y1pIvzBy
         zl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755928827; x=1756533627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0cCdUgFsflHUp+yhsVe2YuRQEhS4mpZaqQeMXN02js=;
        b=UhFvq4CoFKyYAIZ8gZT0dbE4lDXaNTlKwAhUPtLOaQ+8VKb3BrFyDEXVhvV4YYwVf1
         /+oXxqMMVBP5ScyVJfoRQrXsloNPwbt3CVLZ3TzpqTCbgVc55UpASJ+WD0kAWt4DGHJl
         6MEy7Oa/oaLHq3gDBTYbQmYJkhfN4uNp9+shwjZ0waS8z79exQSsBp4XkSsYvNeY1r5O
         l2N6l+2Sbxagy7j2D198NvPD5Pez9oXgVdZ/4bxk+VvbuZLBUnnnGh2n5rDdyz2ZrJQZ
         1BcL6wil40p2++cVB2VYoIVP1ofqH3Z8nFL+MlYPdY+yk7VKEsc+kYlygZeN4ckVX6cg
         PJGQ==
X-Gm-Message-State: AOJu0YySAG6pyloUhJz/UHCjJdRifTphj+KMv+xAXaguFqVSfqzr3fpY
	MhtpImnOHuQp2OX3mXCiq7Fp5BjqQae7UXRPoJIBagUq4b3+VCgLXfKGgWijYA==
X-Gm-Gg: ASbGncvmmQAOsrX83MW9ZLMRJzBCCIJIFFXeuqA1O644miH/9aPfk0bgEC4hQ086b2V
	snbKO014hAXakolpstvzV7NEaAtLniwtQEdK6AuLEQ9/HzNYT3+TQGHu6JZ4vJbB0fqyPbU6/1R
	sFR0431iQtBu3A64mjDlHt+jvTi2bpOrWctvgQ1i1QzFzyFreFDna2Ebf0Y6Kj3Go+pPzIzKr/2
	KUtRRB7cowuidzFNeDAyeuXWfWmGvCdgO2mJe8ngJMo9GYpbvoA3HFnSevyrVntu777kU8m77+v
	4FgMOHbEh9DBye/1faWyq4rFcbjt9dcaI075XP02rUap/jgPqWjFqpL70H0Jj83TytZaKe0s6TF
	2y+cJSEnKViVaXz5YgRQ=
X-Google-Smtp-Source: AGHT+IF6FjaoVAXoma5vvH4K9qtcTEwM5mCGr1wXg/uqyQLFb2AH/8Z0JJxJ2OH/j2vgTVO3XSHZ/w==
X-Received: by 2002:a05:6a20:a124:b0:232:b849:b906 with SMTP id adf61e73a8af0-24340ab33b6mr7105963637.11.1755928826681;
        Fri, 22 Aug 2025 23:00:26 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b6fbsm1434145a12.30.2025.08.22.23.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 23:00:26 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 3/4] t1422: refactor tests to be shareable
Date: Sat, 23 Aug 2025 11:30:11 +0530
Message-Id: <20250823060012.540433-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823060012.540433-1-meetsoni3017@gmail.com>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250823060012.540433-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding tests for the `git refs exists` command,
refactor the existing t1422 test suite to make its logic shareable.

Move the core test logic from `t1422-show-ref-exists.sh` to
`show-ref-exists-tests.sh` file. Inside this script, replace hardcoded
calls to "git show-ref --exists" with the `$git_show_ref_exists`
variable.

The original `t1422-show-ref-exists.sh` script now becomes a simple
"driver". It is responsible for setting the default value of the
variable and then sourcing the test library.

This structure follows an established pattern for sharing tests and
prepares the test suite for the `refs exists` tests to be added in a
subsequent commit.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/show-ref-exists-tests.sh | 76 ++++++++++++++++++++++++++++++++++++++
 t/t1422-show-ref-exists.sh | 76 +-------------------------------------
 2 files changed, 77 insertions(+), 75 deletions(-)
 create mode 100644 t/show-ref-exists-tests.sh
 mode change 100644 => 100755 t/t1422-show-ref-exists.sh

diff --git a/t/show-ref-exists-tests.sh b/t/show-ref-exists-tests.sh
new file mode 100644
index 0000000000..2c29643573
--- /dev/null
+++ b/t/show-ref-exists-tests.sh
@@ -0,0 +1,76 @@
+git_show_ref_exists=${git_show_ref_exists:-git show-ref --exists}
+test_expect_success setup '
+	test_commit --annotate A &&
+	git checkout -b side &&
+	test_commit --annotate B &&
+	git checkout main &&
+	test_commit C &&
+	git branch B A^0
+'
+
+test_expect_success '--exists with existing reference' '
+	${git_show_ref_exists} refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+'
+
+test_expect_success '--exists with missing reference' '
+	test_expect_code 2 ${git_show_ref_exists} refs/heads/does-not-exist
+'
+
+test_expect_success '--exists does not use DWIM' '
+	test_expect_code 2 ${git_show_ref_exists} $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME 2>err &&
+	grep "reference does not exist" err
+'
+
+test_expect_success '--exists with HEAD' '
+	${git_show_ref_exists} HEAD
+'
+
+test_expect_success '--exists with bad reference name' '
+	test_when_finished "git update-ref -d refs/heads/bad...name" &&
+	new_oid=$(git rev-parse HEAD) &&
+	test-tool ref-store main update-ref msg refs/heads/bad...name $new_oid $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	${git_show_ref_exists} refs/heads/bad...name
+'
+
+test_expect_success '--exists with arbitrary symref' '
+	test_when_finished "git symbolic-ref -d refs/symref" &&
+	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+	${git_show_ref_exists} refs/symref
+'
+
+test_expect_success '--exists with dangling symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	${git_show_ref_exists} refs/heads/dangling
+'
+
+test_expect_success '--exists with nonexistent object ID' '
+	test-tool ref-store main update-ref msg refs/heads/missing-oid $(test_oid 001) $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	${git_show_ref_exists} refs/heads/missing-oid
+'
+
+test_expect_success '--exists with non-commit object' '
+	tree_oid=$(git rev-parse HEAD^{tree}) &&
+	test-tool ref-store main update-ref msg refs/heads/tree ${tree_oid} $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	${git_show_ref_exists} refs/heads/tree
+'
+
+test_expect_success '--exists with directory fails with generic error' '
+	cat >expect <<-EOF &&
+	error: reference does not exist
+	EOF
+	test_expect_code 2 ${git_show_ref_exists} refs/heads 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success '--exists with non-existent special ref' '
+	test_expect_code 2 ${git_show_ref_exists} FETCH_HEAD
+'
+
+test_expect_success '--exists with existing special ref' '
+	test_when_finished "rm .git/FETCH_HEAD" &&
+	git rev-parse HEAD >.git/FETCH_HEAD &&
+	${git_show_ref_exists} FETCH_HEAD
+'
+
+test_done
diff --git a/t/t1422-show-ref-exists.sh b/t/t1422-show-ref-exists.sh
old mode 100644
new mode 100755
index 0eccb2dce1..fdca3f16c8
--- a/t/t1422-show-ref-exists.sh
+++ b/t/t1422-show-ref-exists.sh
@@ -6,78 +6,4 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_expect_success setup '
-	test_commit --annotate A &&
-	git checkout -b side &&
-	test_commit --annotate B &&
-	git checkout main &&
-	test_commit C &&
-	git branch B A^0
-'
-
-test_expect_success '--exists with existing reference' '
-	git show-ref --exists refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-'
-
-test_expect_success '--exists with missing reference' '
-	test_expect_code 2 git show-ref --exists refs/heads/does-not-exist
-'
-
-test_expect_success '--exists does not use DWIM' '
-	test_expect_code 2 git show-ref --exists $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME 2>err &&
-	grep "reference does not exist" err
-'
-
-test_expect_success '--exists with HEAD' '
-	git show-ref --exists HEAD
-'
-
-test_expect_success '--exists with bad reference name' '
-	test_when_finished "git update-ref -d refs/heads/bad...name" &&
-	new_oid=$(git rev-parse HEAD) &&
-	test-tool ref-store main update-ref msg refs/heads/bad...name $new_oid $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-	git show-ref --exists refs/heads/bad...name
-'
-
-test_expect_success '--exists with arbitrary symref' '
-	test_when_finished "git symbolic-ref -d refs/symref" &&
-	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
-	git show-ref --exists refs/symref
-'
-
-test_expect_success '--exists with dangling symref' '
-	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
-	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
-	git show-ref --exists refs/heads/dangling
-'
-
-test_expect_success '--exists with nonexistent object ID' '
-	test-tool ref-store main update-ref msg refs/heads/missing-oid $(test_oid 001) $ZERO_OID REF_SKIP_OID_VERIFICATION &&
-	git show-ref --exists refs/heads/missing-oid
-'
-
-test_expect_success '--exists with non-commit object' '
-	tree_oid=$(git rev-parse HEAD^{tree}) &&
-	test-tool ref-store main update-ref msg refs/heads/tree ${tree_oid} $ZERO_OID REF_SKIP_OID_VERIFICATION &&
-	git show-ref --exists refs/heads/tree
-'
-
-test_expect_success '--exists with directory fails with generic error' '
-	cat >expect <<-EOF &&
-	error: reference does not exist
-	EOF
-	test_expect_code 2 git show-ref --exists refs/heads 2>err &&
-	test_cmp expect err
-'
-
-test_expect_success '--exists with non-existent special ref' '
-	test_expect_code 2 git show-ref --exists FETCH_HEAD
-'
-
-test_expect_success '--exists with existing special ref' '
-	test_when_finished "rm .git/FETCH_HEAD" &&
-	git rev-parse HEAD >.git/FETCH_HEAD &&
-	git show-ref --exists FETCH_HEAD
-'
-
-test_done
+. "$TEST_DIRECTORY"/show-ref-exists-tests.sh
-- 
2.34.1

