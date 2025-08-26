Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA41227581
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190486; cv=none; b=u6ABrAiZ/LlEOKKAR6KOg702MrjHVttwdPm1xGnzOrTjIpLwnkGNNksiKwmEKlKe1ouA0c56UJg9h+t7fvSAnU+HKdPIvQcQ4S8Z5ThJRjZp+AvW0mp/HmFRDXI1iiWkTzameLiVTZadRqbceKNPJAw1rU9aGcHlHwhxvvRxWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190486; c=relaxed/simple;
	bh=HQrE+lYMBw/BJwh3YB474rm1F5FjP6Adcx6AcToJ9w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkTeriwRFWZQU7UQDOkyDyHgQe4l+7D5qUWy3zY3yvX+tuF9Euyl1awqt4zi1GVO6Gt7zQMys58bE7O18aK5E5fCaC1q0gWpj3CBtcfjQimERANlUWd9Kw0cJH2MoVejjCe7uk9zAiXkrLJ86rzYqaOk36H+jmgGmDSlECMp+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrQa7Dmd; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrQa7Dmd"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c1d79bd64so1665101a12.0
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756190484; x=1756795284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxVd401pJd+9k8SFFLNoxIKnXxx0y3z83RDV40BheC8=;
        b=GrQa7DmdUMLWi7C5H65qr9o2IcQQLe3Bqx/25Z/EHixbbOQsW0qhz8a3v11+AilNys
         J08zPnq9t06L2Yt1nl0UNk28gp0ezfQ8JYZe7kc5Hu0hCs7ZMotO0Rlu2T/uTlumw8xT
         QiVRgUSYLbh2d08G4ABTFwL3pZ+GHRV3Flws40hK5n+P3vzkhZ1Rw2s/Ob1l7x+Yu28e
         ZIOOWiRysPNBBIFyZnXjkOZAXBS/Q6TyU8UISnr4E3OJdfXYWaJqX0hjjQxiYuy7xVOv
         BxI4oqG0GA+wzwH3YQj7GFeqig2PNRmc374AmmURJANJta/Apl1hgL/IHVTb3InNl2FU
         FOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190484; x=1756795284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxVd401pJd+9k8SFFLNoxIKnXxx0y3z83RDV40BheC8=;
        b=i3OSXTQtvPRTJoLSBOkKH1B7LVzNRWWB5DIncMy3CB+LLB5kqlJJlNBBrPvEE8RPgE
         R5y3vn2HThfa1PX4LbzNLqXt5WKPZg3ViSbc7CnIv93OFb85VNtokEnb7p9/+WI65HSr
         UfzPkYHjiwcAdg/r+ojF6Z8sftjsJ6IWiseeuf8gAN119dCNcqqcHvBH2crXJa3s5Y61
         KniFTod2bbMcEHtnFCVWuoYI6FOMfw9cruNGoZ5KJdk5XkHslLLZaGECfSvG/7ERMA3c
         KY5mFJhiDsQyeh7+6zhI7iX5fz5nEVzWdOFDc+ogCrbXdhQZ53CmnyXLZR0m8rkiD32Q
         y/4g==
X-Gm-Message-State: AOJu0YyW8am5YdL/yV/hrhyvaoSogQB51E6KbekvOYCBSNqUe+RlRaxp
	//4RbgijWGIc3bjK/oV9QTzwlMibnkSvOWgnhvlcRv9OEG9J2mNv9ojYthu/Qw==
X-Gm-Gg: ASbGncukVd0n/7cmEoJakpL3GAU58yCRAtBmjOzjnTnrec5QzfurJhtnoOANOdaqBva
	mbY7xx+QD5Rpz36kzJERfVt7g9AhE6gRPLH0D3pSo2crO5jH8ptp5fijoJf/f2E/MZT002NvIbH
	tVuUyL6wOAWmBCyKBzJ3zQcDCMwsJ6+6TZGe3rxAwN6OOBOJviM3v0nLleSkxAOdOjVVHLBMXTu
	Fyi9KYbW5MCuwITln4wWWtdYP0xbNbzwCybHk3kXduJ3cIhwMx7f4D+L8yo7EWSoMqPSJLfBja8
	0+rCYcG68ooJMyL5o5rv9lGB45AUACH4xdctEXD2bDgRpF/RNSn8D0hQU4axQ2m+OlymP1BN7Y5
	oSHESnTs+fBRLZ84rUkLoBnyQf1ZVGg==
X-Google-Smtp-Source: AGHT+IHVpH7LQJq2IAVU8J2DOvSVHTndfslmhRAooGV8+4NoQ4aIY6fLwuJjH0qYHkjXpSZfZJze9Q==
X-Received: by 2002:a17:902:d486:b0:246:d769:2ff8 with SMTP id d9443c01a7336-246d76933fbmr85180635ad.27.1756190484002;
        Mon, 25 Aug 2025 23:41:24 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889ddc6sm86442025ad.159.2025.08.25.23.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:41:23 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 3/4] t1422: refactor tests to be shareable
Date: Tue, 26 Aug 2025 12:11:09 +0530
Message-Id: <20250826064110.10540-4-meetsoni3017@gmail.com>
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
 t/show-ref-exists-tests.sh | 77 ++++++++++++++++++++++++++++++++++++++
 t/t1422-show-ref-exists.sh | 76 +------------------------------------
 2 files changed, 78 insertions(+), 75 deletions(-)
 create mode 100644 t/show-ref-exists-tests.sh
 mode change 100644 => 100755 t/t1422-show-ref-exists.sh

diff --git a/t/show-ref-exists-tests.sh b/t/show-ref-exists-tests.sh
new file mode 100644
index 0000000000..36e8e9df33
--- /dev/null
+++ b/t/show-ref-exists-tests.sh
@@ -0,0 +1,77 @@
+git_show_ref_exists=${git_show_ref_exists:-git show-ref --exists}
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

