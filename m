Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBA289E36
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190487; cv=none; b=WaHoSklVRRfBz1c88cs5hYpQKfvSDw7tqbEiIOl+obmBWn5r6jms0WSnn5vqUERHeW2Bu1iG+1Lovpobs8fUC3BKl2+Pb81eXsDLXXGpi18RuppHDF44JcPNXC5KPMiaz31Dw7Uiy/hHOZxH1E7zwS9bRLGGKGapeKb+wdPyGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190487; c=relaxed/simple;
	bh=IMsxr8AzhoNEenrVD8DGZviuqlPdIci2pM3CL7PVSZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pc0PS0e1i+OlMLm6XSrQLh+kbg8m9iWMjagp2CZT/XN4As4V25X/8Q72cQGRUG6spGhj65K4lZF9l0MtEiVk76VOvk1dQtgwPUTqPSeyrahDX3pt/9WxgECEpfHeiWy9SkiyTI1xkiUFQ5pgVA1Tmwz7+mzuVn6H9mW8PKa39FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXdrnYGi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXdrnYGi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24664469fd9so28698535ad.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756190481; x=1756795281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpJjX5Ykt/Vg7RJmzGP55YHBZgjgo6Os7FCqZ+OaI5Q=;
        b=RXdrnYGitIKGCMa1dCPpy2bghWQAQKBmfgT1BSPtqpkLBN5YKpz1djBiFdN1YkmpLR
         C7Y1m4vJMbsbnc+X2ipeyfuzkuTcYmt/9E+upV+wnqJPNaMWVIcb3GqnYD6AqjjZBStr
         lN7JoieiHZ/d87YKOrQ+FDhKaJV+lcaVlYFAn3+xiZI74523/zJFY1jsm58Bl2e+RiHW
         XPz1c+iSXKZD5qBXYi8uNLa58WSjHyfRL5THgJHpGxrL8+JbvYUTb1siGIwmN0hoQFDc
         YPwgvuhSEbMLOGPhMblxzLrdhBlAxM8xup7Jjnup0XKKYU1gPjZH0h/snfyfj6jQpX1y
         X5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190481; x=1756795281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpJjX5Ykt/Vg7RJmzGP55YHBZgjgo6Os7FCqZ+OaI5Q=;
        b=TYOfMhcprYxD15FXySZ6DJwLtNbaMhEVnPmkfyZ2th4y9SvGWHu16hx8VDiMsgZL//
         OoLMWzVglqZwuKrQ9jkkimosBjQq0o7aP72ZgWj8ynL26AzK/mPhHAHojs/n5Rv6pNwO
         7qILRSr/uqEwykpildMN8SArNYZuidj2EgwIYzP7/Dt5iR74pqw6NPQt0ITsANay5dNO
         MfNEy+pdhubzMOKfLg4/5R52AjR7Fdl50PjBSNwkldtNGCxBdQNnsTOkveG2F417ARaN
         QLpxh2KZLmWBj+CYKiz9JaaE21N+KD4m8cvt2OJ+/JTODFxySewqiDlRq5HlYM/8haE9
         Lx5w==
X-Gm-Message-State: AOJu0YyIOhhX94TcyXTCwPjrgT1IMI7uAei7BQoqmfGKgaiNs6KBmfSn
	t3qfHFAReavXdxJPYuWonZ+Ist0KLKrYckM7TKy4jrz8hGMIELezN6t/Eeuwfg==
X-Gm-Gg: ASbGnctEGe7rX8DfJxQ1f8WhRcdaDtR3/e/yeiJX/tRdZHq6CA8ZciZ7ZX4mIdgszr9
	fNPdX3Qudl2G/bPv+VmTREjeTdNneXrU1CaSVbnQ0Q18KhhWkDibmNUiZDg25LaWKZDZhlWADRs
	LxEUkteGa4ut70vU9BHSAicY4qKLV5yCRSTd0SiYfybxpK9ZtUIBz3zdl3LNym3Tu/g8Tu5pyHV
	6l6auZk+mXgNssnWw71M0QcDpQR6WPvAdxstltD1JHT+DVvRAbZ1MdkHafYjZpMKO/Ey7/6RVIq
	+NbGL0S4Tz9b2hlww0I/PuCjUyCU7Xsoiy1QBD0rNxBqEzeGtEZ3ZwkZYQiuKNaMcGi7CpWLhP7
	/Xv7EKT7NxE8UdcebGCk2BZeq9TwS4g==
X-Google-Smtp-Source: AGHT+IFZfcdOu9P+LgixIOHC+Ko0L7Oy2xc6MBckH+44qmyXOB4rCh9ybtyGBXQPOUleFq5NCRlgKg==
X-Received: by 2002:a17:902:ca8d:b0:23f:c945:6081 with SMTP id d9443c01a7336-2462ef1f7dbmr139320635ad.31.1756190481409;
        Mon, 25 Aug 2025 23:41:21 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889ddc6sm86442025ad.159.2025.08.25.23.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:41:20 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 2/4] t1403: split 'show-ref --exists' tests into a separate file
Date: Tue, 26 Aug 2025 12:11:08 +0530
Message-Id: <20250826064110.10540-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826064110.10540-1-meetsoni3017@gmail.com>
References: <20250823060012.540433-1-meetsoni3017@gmail.com>
 <20250826064110.10540-1-meetsoni3017@gmail.com>
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

