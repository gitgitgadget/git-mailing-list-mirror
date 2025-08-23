Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2B1E1DE7
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755928827; cv=none; b=cAUGGWVS51f4XGoZp6FlIMl1BsnOW/oimxz0n3bdmMEG5IT7UzbDJanveOT83OuAmdDIi+idEIXi9JLTdLXfzgHfArEvowd/DFBUZPqE9+Ba3UnsgEei5zbPSVyawLHmvaUma5TWzxq75/EykxJuvxrjRh9XUggkFTH8nBxyVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755928827; c=relaxed/simple;
	bh=IMsxr8AzhoNEenrVD8DGZviuqlPdIci2pM3CL7PVSZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpbnyHQyqzhDVw8Qnn7nkfh8moOt+r7l58dg1/cBS0kcaWWu7WtOoOeeKt16fNmaf5dFbNQg1xscYlj+E3RR3vLq0+Dk7lmSxVaWbvZIiD4aWUh9D3mSBkRCMeIkCZpvxvsARRMZ8wf+3TZFgqYOZ3i3DM/dPxF1p2OeLOSW0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6/tI4x/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6/tI4x/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323267b98a4so2365619a91.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755928824; x=1756533624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpJjX5Ykt/Vg7RJmzGP55YHBZgjgo6Os7FCqZ+OaI5Q=;
        b=P6/tI4x/Ntv+Jgbw9/xzNgcESTV2ldnaI3VlPVqmwcxK/0MqkkV4ENh9slnEdMdQnI
         RZb0xHCHfKkiBiC7xFfIL1dehLwXacxIMhE1YvEe1IRVJjb5tOlewguIMd0i/U+YUKcq
         zrb5tcUPjpuRQet7MbeQZD3IZ8VtMaGrCBOnpjYYjeRGKgez5RPmqqGyE+NvEV8A5j2C
         HiJ3PJg1M8i0RH3LhXt5lQklqP5lnk/n6rSV1DVJt5r789lQGPvubD5T9fnyVgs9djH3
         BZ7tVLr56xsqE6f3ENcF5EWaruBJ+wVNhi5KS6REqX0ITyA+ZSp0arTlIi0dE5oJM7AJ
         oIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755928824; x=1756533624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpJjX5Ykt/Vg7RJmzGP55YHBZgjgo6Os7FCqZ+OaI5Q=;
        b=hwL6zjDqTDDWx3OwQx9uiGrC58I/x/wP02GD0e4nAnq7WYqWzFx6sHiHytojQS+Wga
         fK954GxzgsTwAk+SMCaXnXN2SmLFrZ9ij7k7xWmDIW8VuFLItUxGvciJZxQHkDIn3mXl
         km1SfvOF2rslpWwOi399Sikhlzo+LqJUz4a4/Xambrko4jcApociNs6YXr7fgZU0tNup
         wsXIldu5UOgI4rbFtk+Kj4zOh22w3UgHE/MlrW0HLZ/wUJlMr6D3zLB6wCB5Ysjuz0Gc
         o/vgpyuMTqNoHfedymUdeaaSJBKF6VxCSKrWBD6ZSaPjcPQnK60vad1JHy3gqByqxjyz
         /hhg==
X-Gm-Message-State: AOJu0YzJvYDCIR8hHfJxGSV4Mz24gBOO9vH2JNdmd62vwOWJPNhPEW+l
	is8V/ydQbraQTPVU+G4iDhMJpMi+/0F5XNR1USUIc/oOdaQVvzWyrYd5k62l9A==
X-Gm-Gg: ASbGncvDrRYdApHFOy1eXbFveCqboCvvaj0ENTGsQaTMkLhafRuB32Ra5du/c9LBaGy
	2k2UyOVYc433rs2/PmWwuJmpIuIKDLmGF4JAjYcGBT4kqtPPbZ5cG3payXw6aLxiQdsPLf9w4Hu
	7BYb0ma2UEaZIsTY0fLzd4LSfKIONln8is+XsT6xMFm7NXJIxVxQ2kzckhp0iLVZpXzE/gZ2DdY
	5IKppS6Pj8ArNF4lpvDSfWW24RnfJDHF6M/b10lWSHaFn2oPOr2p/vmAQCG3bCXZIyWuj8hH7N9
	BTKDuohzUyf9mapuCPHjd1qMm5F/UmrtkOcrsJqkvDJKO90D/AbAAK9+jhSnMa4TLFMayLMbFLr
	EWlImvSC0CJvZWd0wII7N6fcczVrTCQ==
X-Google-Smtp-Source: AGHT+IGNUWtK3huqHd6ElgBcr7BnUc8RBI8ndf94WP4Y0IbW66JGV6denmgmOAHynz5MPs3QLKFwuw==
X-Received: by 2002:a17:90b:2c87:b0:31f:134:94ae with SMTP id 98e67ed59e1d1-32515edd6b4mr6940854a91.11.1755928824016;
        Fri, 22 Aug 2025 23:00:24 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b6fbsm1434145a12.30.2025.08.22.23.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 23:00:23 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 2/4] t1403: split 'show-ref --exists' tests into a separate file
Date: Sat, 23 Aug 2025 11:30:10 +0530
Message-Id: <20250823060012.540433-3-meetsoni3017@gmail.com>
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

The test file for git-show-ref(1), `t1403-show-ref.sh`, contains a group
of tests for the '--exists' flag. To improve organization and to prepare
for refactoring these tests to be shareable, move the '--exists' tests
and their corresponding setup logic into a self-contained test suite,
`t1422-show-ref-exists.sh`.

This is a pure code-movement refactoring with no change in test coverage
or behavior.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build              |  3 +-
 t/t1403-show-ref.sh        | 65 -----------------------------
 t/t1422-show-ref-exists.sh | 83 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 66 deletions(-)
 create mode 100644 t/t1422-show-ref-exists.sh

diff --git a/t/meson.build b/t/meson.build
index daf01fb5d0..4d6bc3d38e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -205,6 +205,7 @@ integration_tests = [
   't1419-exclude-refs.sh',
   't1420-lost-found.sh',
   't1421-reflog-write.sh',
+  't1422-show-ref-exists.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
@@ -1216,4 +1217,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9da3650e91..36c903ca19 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -228,69 +228,4 @@ test_expect_success 'show-ref sub-modes are mutually exclusive' '
 	grep "cannot be used together" err
 '
 
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
 test_done
diff --git a/t/t1422-show-ref-exists.sh b/t/t1422-show-ref-exists.sh
new file mode 100644
index 0000000000..0eccb2dce1
--- /dev/null
+++ b/t/t1422-show-ref-exists.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='show-ref --exists'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
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
+	git show-ref --exists refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+'
+
+test_expect_success '--exists with missing reference' '
+	test_expect_code 2 git show-ref --exists refs/heads/does-not-exist
+'
+
+test_expect_success '--exists does not use DWIM' '
+	test_expect_code 2 git show-ref --exists $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME 2>err &&
+	grep "reference does not exist" err
+'
+
+test_expect_success '--exists with HEAD' '
+	git show-ref --exists HEAD
+'
+
+test_expect_success '--exists with bad reference name' '
+	test_when_finished "git update-ref -d refs/heads/bad...name" &&
+	new_oid=$(git rev-parse HEAD) &&
+	test-tool ref-store main update-ref msg refs/heads/bad...name $new_oid $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	git show-ref --exists refs/heads/bad...name
+'
+
+test_expect_success '--exists with arbitrary symref' '
+	test_when_finished "git symbolic-ref -d refs/symref" &&
+	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+	git show-ref --exists refs/symref
+'
+
+test_expect_success '--exists with dangling symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	git show-ref --exists refs/heads/dangling
+'
+
+test_expect_success '--exists with nonexistent object ID' '
+	test-tool ref-store main update-ref msg refs/heads/missing-oid $(test_oid 001) $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	git show-ref --exists refs/heads/missing-oid
+'
+
+test_expect_success '--exists with non-commit object' '
+	tree_oid=$(git rev-parse HEAD^{tree}) &&
+	test-tool ref-store main update-ref msg refs/heads/tree ${tree_oid} $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	git show-ref --exists refs/heads/tree
+'
+
+test_expect_success '--exists with directory fails with generic error' '
+	cat >expect <<-EOF &&
+	error: reference does not exist
+	EOF
+	test_expect_code 2 git show-ref --exists refs/heads 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success '--exists with non-existent special ref' '
+	test_expect_code 2 git show-ref --exists FETCH_HEAD
+'
+
+test_expect_success '--exists with existing special ref' '
+	test_when_finished "rm .git/FETCH_HEAD" &&
+	git rev-parse HEAD >.git/FETCH_HEAD &&
+	git show-ref --exists FETCH_HEAD
+'
+
+test_done
-- 
2.34.1

