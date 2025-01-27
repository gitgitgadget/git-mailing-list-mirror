Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6811096F
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004566; cv=none; b=Dc9RadeGdwWW2/29ar2o7xLogRQWuczAn/KvkYVmfrulVBeJTt29cn6zacQGWBk6tGD5O5/NIVIkC3mqlea5isMZcS2Bpofhfz5mbEyjnNBoBhBn0YADwBnO683+yh2+oXrafET2v2F4V46bPB+H0jqOnzfC0h1QWEjEH+uvVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004566; c=relaxed/simple;
	bh=BuubL9f7lE/8T+WUbOv5pxYAc6FvN8XIKXqlFATnGt8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W6oowhuRHHJPu971AMZPVeUpSNuDyi/gmRaEU9qQXp6zfhDn8bAG5NWxxC6pU5cFYehlRIyR7grHNFwO722s8pqBx/7mhMprbXxwlmkaIfHX8ic8RGXobQXfG0IaFg/MLr4ZFzADYNNPO47j0sO0YR2m1IalFYPRSqg+lvdiukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXEZ8287; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXEZ8287"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso36968095e9.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004562; x=1738609362; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f53ttdsFw8JuDilQyriJY37kxcC2wi1A2tXrod7QucY=;
        b=eXEZ8287F5uCI92zgdri/8SZSFaEbCG7rNVMN4a7G1gxkr/xIpi4FDzUxk/arqmF02
         eq21fe5VYjjxmd4vv9ciHOe6XYe5pZRnoehwzR5P4oPKc7NPFULhO3Nz8t+LgWbcCUAd
         /RdHaKwVgoXW+cQHx6i1pRvkfAcjdg43sMLw2mLdvl1N88rdcUm4ZgfhN8BJ8R6JYEPh
         xx/1alD/IOSSXx2Wom4YLRN9He5zxm9imfllg7w2XeHqxCi2aneCVgloEYk9y3oCMl0z
         A6lfmPwOoR4Yld7O5AOCnZNYcgDcs8MYj0so3wz+QlucShzpTGyN6wRhBrTYYQ2ZBRvK
         vqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004562; x=1738609362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f53ttdsFw8JuDilQyriJY37kxcC2wi1A2tXrod7QucY=;
        b=nyul3b5sZjC9P7Be43qvUdCxCYrj1Z+mo+EarUeyaB3eRgdrS6+9ZKYo+DaRvo8nlg
         b39ZQ7MaD/GKi/sW5HhVuihXICxDxrcTEPXzbDic1NM9o4Eo5G3wjms703uDIc01L5Kg
         WyRqjVzNQ9HpjGY0+Ws6XsF6n/rmQaWeT/6I7F+GRZCSbuogD2JIndeOWFt54ma7mWqC
         1ijdPA5h/TpEJ5Fip2oOUBT6aQm/qRxWnL+9iTjYqtVCEZa9sTyk3jSAsl6/y2Oc5LzA
         ZQ/pC/Vcagv3VgQjGetBrkiy5JmQBvno+jLn1hLB33GXwZZLF9E+jX644YCRJv+Yti1B
         0poQ==
X-Gm-Message-State: AOJu0YwIo9opQZjayNmhJkH0aahwpQupC83/aKX41l7JKqjnEtPmq+3c
	v2qm1oYHx7SCAkhl6YtCIrlEpUBclAhYJBE1bUHHdkwWpmCFGCsSekIdVw==
X-Gm-Gg: ASbGncv1ZnOzKKxmqSovDfKi0mjuXpIi+fAGqduW0dhVhOqNT6hGmD0V0FZnAtifhpM
	XJi+YaASQsX/CheNYsEWAL9X2RPBFBBh2QBSIM1Ksefosgx4lg+Q/vIsj3eZgmYFjXDxT65cie5
	3m1LgwAVF3hEwaHITblsElg6QMl2kYaR5GKOYiWqEVrGzzuMgM34TeoyZKLb9MQDDW1zoMS62Tb
	2yDg9Al4H1bYDumlH3CJir9pz2tmx97tGvB7/v1tIa8iMmdtK/DBQznpewLX3kZAgdnf5H4C1Kp
	Bh1aaQ==
X-Google-Smtp-Source: AGHT+IEyr++j07tJlTmFEQZ6DqthDT44FJfumnF3VFLdpMWFCxiIzHEfmWxbWTNxo27gRFA+jJYcqw==
X-Received: by 2002:a05:6000:1565:b0:38a:906e:16d0 with SMTP id ffacd0b85a97d-38c49a6334fmr505247f8f.21.1738004561468;
        Mon, 27 Jan 2025 11:02:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d6d7sm12030777f8f.31.2025.01.27.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:02:41 -0800 (PST)
Message-Id: <a507be2f19bb3429077fc4b0f87c91d5d797d136.1738004555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
	<pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Jan 2025 19:02:31 +0000
Subject: [PATCH v4 4/7] pack-objects: add GIT_TEST_NAME_HASH_VERSION
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new environment variable to opt-in to different values of the
--name-hash-version=<n> option in 'git pack-objects'. This allows for
extra testing of the feature without repeating all of the test
scenarios. Unlike many GIT_TEST_* variables, we are choosing to not add
this to the linux-TEST-vars CI build as that test run is already
overloaded. The behavior exposed by this test variable is of low risk
and should be sufficient to allow manual testing when an issue arises.

But this option isn't free. There are a few tests that change behavior
with the variable enabled.

First, there are a few tests that are very sensitive to certain delta
bases being picked. These are both involving the generation of thin
bundles and then counting their objects via 'git index-pack --fix-thin'
which pulls the delta base into the new packfile. For these tests,
disable the option as a decent long-term option.

Second, there are some tests that compare the exact output of a 'git
pack-objects' process when using bitmaps. The warning that ignores the
--name-hash-version=2 and forces version 1 causes these tests to fail.
Disable the environment variable to get around this issue.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c          |  5 ++++-
 t/README                        |  4 ++++
 t/t5300-pack-object.sh          |  7 +++++--
 t/t5310-pack-bitmaps.sh         |  5 ++++-
 t/t5333-pseudo-merge-bitmaps.sh |  3 ++-
 t/t5510-fetch.sh                |  7 ++++++-
 t/t6020-bundle-misc.sh          |  6 +++++-
 t/t7406-submodule-update.sh     |  4 +++-
 t/t7700-repack.sh               | 10 ++++++++--
 9 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e65d4793edf..57277429900 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,7 +266,7 @@ struct configured_exclusion {
 static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
-static int name_hash_version = 1;
+static int name_hash_version = -1;
 
 /**
  * Check whether the name_hash_version chosen by user input is apporpriate,
@@ -4616,6 +4616,9 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
+	if (name_hash_version < 0)
+		name_hash_version = (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSION", 1);
+
 	validate_name_hash_version();
 
 	if (use_delta_islands)
diff --git a/t/README b/t/README
index 8c0319b58e5..e63d2360852 100644
--- a/t/README
+++ b/t/README
@@ -492,6 +492,10 @@ a test and then fails then the whole test run will abort. This can help to make
 sure the expected tests are executed and not silently skipped when their
 dependency breaks or is simply not present in a new environment.
 
+GIT_TEST_NAME_HASH_VERSION=<int>, when set, causes 'git pack-objects' to
+assume '--name-hash-version=<n>'.
+
+
 Naming Tests
 ------------
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 4270eabe8b7..97fe9e561c6 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -675,15 +675,18 @@ do
 done
 
 test_expect_success 'valid and invalid --name-hash-versions' '
+	sane_unset GIT_TEST_NAME_HASH_VERSION &&
+
 	# Valid values are hard to verify other than "do not fail".
 	# Performance tests will be more valuable to validate these versions.
-	for value in 1 2
+	# Negative values are converted to version 1.
+	for value in -1 1 2
 	do
 		git pack-objects base --all --name-hash-version=$value || return 1
 	done &&
 
 	# Invalid values have clear post-conditions.
-	for value in -1 0 3
+	for value in 0 3
 	do
 		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
 		test_grep "invalid --name-hash-version option" err || return 1
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7044c7d7c6d..c30522b57fd 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -420,7 +420,10 @@ test_bitmap_cases () {
 			cat >expect <<-\EOF &&
 			error: missing value for '\''pack.preferbitmaptips'\''
 			EOF
-			git repack -adb 2>actual &&
+
+			# Disable name hash version adjustment due to stderr comparison.
+			GIT_TEST_NAME_HASH_VERSION=1 \
+				git repack -adb 2>actual &&
 			test_cmp expect actual
 		)
 	'
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index eca4a1eb8c6..971f9d2d4ee 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -209,7 +209,8 @@ test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
 '
 
 test_expect_success 'out of order thresholds are rejected' '
-	test_must_fail git \
+	# Disable the test var to remove a stderr message.
+	test_must_fail env GIT_TEST_NAME_HASH_VERSION=1 git \
 		-c bitmapPseudoMerge.test.pattern="refs/*" \
 		-c bitmapPseudoMerge.test.threshold=1.month.ago \
 		-c bitmapPseudoMerge.test.stableThreshold=1.week.ago \
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c5..1699c3a3bb8 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1062,7 +1062,12 @@ test_expect_success 'all boundary commits are excluded' '
 	test_tick &&
 	git merge otherside &&
 	ad=$(git log --no-walk --format=%ad HEAD) &&
-	git bundle create twoside-boundary.bdl main --since="$ad" &&
+
+	# If the a different name hash function is used here, then no delta
+	# pair is found and the bundle does not expand to three objects
+	# when fixing the thin object.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git bundle create twoside-boundary.bdl main --since="$ad" &&
 	test_bundle_object_count --thin twoside-boundary.bdl 3
 '
 
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 34b5cd62c20..a1f18ae71f1 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -247,7 +247,11 @@ test_expect_success 'create bundle with --since option' '
 	EOF
 	test_cmp expect actual &&
 
-	git bundle create since.bdl \
+	# If a different name hash function is used, then one fewer
+	# delta base is found and this counts a different number
+	# of objects after performing --fix-thin.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git bundle create since.bdl \
 		--since "Thu Apr 7 15:27:00 2005 -0700" \
 		--all &&
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0f0c86f9cb2..ebd9941075a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1094,7 +1094,9 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	) &&
 	git clone super4 super5 &&
 	(cd super5 &&
-	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
+	 # This test var can mess with the stderr output checked in this test.
+	 GIT_TEST_NAME_HASH_VERSION=1 \
+		git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err
 	) &&
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index b9a5759e01d..16861f80c9c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -309,7 +309,10 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	keep=${pack%.pack}.keep &&
 	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
-	git -C bare.git repack -ad 2>stderr &&
+
+	# Disable --name-hash-version test due to stderr comparison.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
@@ -320,7 +323,10 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	blob=$(test-tool genrandom big $((1024*1024)) |
 	       git -C bare.git hash-object -w --stdin) &&
 	git -C bare.git update-ref refs/tags/big $blob &&
-	git -C bare.git repack -ad 2>stderr &&
+
+	# Disable --name-hash-version test due to stderr comparison.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
-- 
gitgitgadget

