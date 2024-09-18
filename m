Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C66FC5
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692390; cv=none; b=pbpt8c7jfZareYBw11a9rXYWNWxvPyrOn7y5w/ohw5S1cF8h65ILK6aMcVjzGT2HI44tKMCH+M5vGhmeclUtNcAVrtnrJcsy3g1aQNAC0PsmPHkvpmLpiWjmaaPnLlhSkELTzmhJSTuHFHtVCkVbm68iRUSvnfjuibWlCPCbvU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692390; c=relaxed/simple;
	bh=zQQxqzsHlDi5uoYtZtFBtgbOGoCMSH+erGf6xl1eVfg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YNCSWNkzCQSUZ8kMnikj9uoM+MP1wtQGnYwII+VvgkSdBLe+5sXsnfZPtkeec6ptkzq2GWXkrj01jorxHyoQDJKvX5N3PODfLtXbLFmTs3M4ikz17XJT/KyPadG2KfC7Zc0ZY4tD6CYg1NP+yQQM/ffAh6BSdjpETLxEBAcWbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtBt56X2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtBt56X2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a90188ae58eso11011366b.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726692386; x=1727297186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaMJs25r7/1rS2LyqK8Y3PUdyf1S0PRkDGwgmldpVBo=;
        b=AtBt56X2vprMzRxWbVCV/SnYyPKHgEanmBbsH3dMJhPVm2OTfSePUpWJx9U8bQiI3P
         ZQcTo16miCSd1TS/8ZsRCFHWu9T922rM7oHl+E7bhEwpqEScnqv0F0HMpCdRnq1xDjqk
         xFJJzH0ES9p5pdN02XTO748Orh57rj+THuv7+0lHNNsyxVYuMpbYwXXBAKOPGOM9NT+T
         6mCkECZBUlhJL9U/c3KlOLpDyMmhhUAM25T9g5GZ37pBUxBb7coM7P5M+DR5pfrCgP7r
         IFNXHG3nykVqqfN/rqfj0ejESMtkMj3H+GHOrdgua42bvD9q26QTemGqxrgJLYikXGwm
         3f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692386; x=1727297186;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaMJs25r7/1rS2LyqK8Y3PUdyf1S0PRkDGwgmldpVBo=;
        b=BbE5FW9MaZgNsPKo2F4ZjJ0S21Jm7lSVdtAN3IaEXRdwPb/PMYDYZaZE8f/nw5GQus
         2npXAAVLfppMX+I0luGnKOeTT/HhRbeUoPuA97a+rAZs7E7xsYQlCcf9Db5Dy1cfDVIp
         AAl6Mb8DDEH3zj686fMV6V0XCahQyKsQLtn8UuWK/jsPD0NwyPoFL/7YsxPkE4DEu9YY
         eenwi/M1mtzQgCpHNYOw1e4+xCqBk+b8euXvkhLQdwFLI46n9ayNHLA6AfCLSyRx9DlL
         liIxwoXEVoBF3kmMef8+VG/3hbg5/2d1utWHtW2+yzAjFeDBnAzhit/eOuIswdQ7TYxm
         uM6w==
X-Gm-Message-State: AOJu0YxR5THnPpE82i7bPZVXW7UPZizZM4il5BWn5btpAwLEui6j3Ykr
	bPzz7WRW8VZtyZz1Goc7SMN4mXtQoI6AfOUkhY+eUvIh1pvyCP0apTgwKw==
X-Google-Smtp-Source: AGHT+IGTlyS61Or7qotZ+xkeW5f2Vj4ocgBaNYLfQn5Gx9hzLiiZXcgZsp43xIq9T65sH/C2TuDhQg==
X-Received: by 2002:a17:907:e644:b0:a8a:445f:ac4d with SMTP id a640c23a62f3a-a90294460a2mr2079740866b.18.1726692386417;
        Wed, 18 Sep 2024 13:46:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b389asm625415866b.122.2024.09.18.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:46:26 -0700 (PDT)
Message-Id: <48b3876a10247d2ba65a6e5f1ff8ed3a662813f8.1726692381.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 20:46:18 +0000
Subject: [PATCH v2 3/6] pack-objects: add GIT_TEST_FULL_NAME_HASH
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new environment variable to opt-in to the --full-name-hash option
in 'git pack-objects'. This allows for extra testing of the feature
without repeating all of the test scenarios.

But this option isn't free. There are a few tests that change behavior
with the variable enabled.

First, there are a few tests that are very sensitive to certain delta
bases being picked. These are both involving the generation of thin
bundles and then counting their objects via 'git index-pack --fix-thin'
which pulls the delta base into the new packfile. For these tests,
disable the option as a decent long-term option.

Second, there are two tests in t5616-partial-clone.sh that I believe are
actually broken scenarios. While the client is set up to clone the
'promisor-server' repo via a treeless partial clone filter (tree:0),
that filter does not translate to the 'server' repo. Thus, fetching from
these repos causes the server to think that the client has all reachable
trees and blobs from the commits advertised as 'haves'. This leads the
server to providing a thin pack assuming those objects as delta bases.
Changing the name-hash algorithm presents new delta bases and thus
breaks the expectations of these tests. An alternative could be to set
up 'server' as a promisor server with the correct filter enabled. This
may also point out more issues with partial clone being set up as a
remote-based filtering mechanism and not a repository-wide setting. For
now, do the minimal change to make the test work by disabling the test
variable.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c    |  6 ++++--
 ci/run-build-and-tests.sh |  1 +
 t/README                  |  4 ++++
 t/t5510-fetch.sh          |  7 ++++++-
 t/t5616-partial-clone.sh  | 26 ++++++++++++++++++++++++--
 t/t6020-bundle-misc.sh    |  6 +++++-
 6 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4a990d15609..8876fa3d641 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,7 +266,7 @@ struct configured_exclusion {
 static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
-static int use_full_name_hash;
+static int use_full_name_hash = -1;
 
 static inline uint32_t pack_name_hash_fn(const char *name)
 {
@@ -4583,8 +4583,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
-	if (write_bitmap_index && use_full_name_hash)
+	if (write_bitmap_index && use_full_name_hash > 0)
 		die(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
+	if (use_full_name_hash < 0)
+		use_full_name_hash = git_env_bool("GIT_TEST_FULL_NAME_HASH", 0);
 
 	if (use_delta_islands)
 		strvec_push(&rp, "--topo-order");
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2e28d02b20f..75b40f07bbd 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -30,6 +30,7 @@ linux-TEST-vars)
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	export GIT_TEST_FULL_NAME_HASH=1
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
diff --git a/t/README b/t/README
index 44c02d81298..eaaf9fcd57e 100644
--- a/t/README
+++ b/t/README
@@ -488,6 +488,10 @@ a test and then fails then the whole test run will abort. This can help to make
 sure the expected tests are executed and not silently skipped when their
 dependency breaks or is simply not present in a new environment.
 
+GIT_TEST_FULL_NAME_HASH=<boolean>, when true, sets the default name-hash
+function in 'git pack-objects' to be the one used by the --full-name-hash
+option.
+
 Naming Tests
 ------------
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c5..be79c72495e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1062,7 +1062,12 @@ test_expect_success 'all boundary commits are excluded' '
 	test_tick &&
 	git merge otherside &&
 	ad=$(git log --no-walk --format=%ad HEAD) &&
-	git bundle create twoside-boundary.bdl main --since="$ad" &&
+
+	# If the --full-name-hash function is used here, then no delta
+	# pair is found and the bundle does not expand to three objects
+	# when fixing the thin object.
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git bundle create twoside-boundary.bdl main --since="$ad" &&
 	test_bundle_object_count --thin twoside-boundary.bdl 3
 '
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8415884754b..69d5bab73cd 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -515,7 +515,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big tree (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --full-name-hash option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_FULL_NAME_HASH=1, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" withot any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify the assumption that the client needed to fetch the delta base
@@ -534,7 +545,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big blob (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --full-name-hash option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_FULL_NAME_HASH=1, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" withot any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify that protocol version 2 was used.
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 34b5cd62c20..553a20d10e9 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -247,7 +247,11 @@ test_expect_success 'create bundle with --since option' '
 	EOF
 	test_cmp expect actual &&
 
-	git bundle create since.bdl \
+	# If the --full-name-hash option is used, then one fewer
+	# delta base is found and this counts a different number
+	# of objects after performing --fix-thin.
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git bundle create since.bdl \
 		--since "Thu Apr 7 15:27:00 2005 -0700" \
 		--all &&
 
-- 
gitgitgadget

