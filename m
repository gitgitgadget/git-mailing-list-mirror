Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FAE1DFDB2
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181693; cv=none; b=eBzWI7ot7O7cle/sXafhE6APbyfNHl5wwNJl+8T+FqEjj0lr3r5iWpcARHjfao4g3Tfbg27m515fc5HBYFbp9HZ5QDi+/6aaDf5Ff6Rx9OqnzkIUsJsr3nB6DhQx0iWDAeRu76F8V/KD2aTsfoiGXnnfKmLjSJIkpmboFZV703o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181693; c=relaxed/simple;
	bh=WUZBLQVPmf3ofepPvBHhCwbqE0hh+s7x7dyLqJwFALc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lbbhNbbauatY9Rr1+NKOYSOb/q4hv0p/B6lbgtIKqya5vkse+fM2eAyYetK9QOdMt7knBwnwxucBbTLraec6GClPcrge+3MHQhFvO1HoI319hrcfMKx05MHQGOxO5uMXeApM9NYBAIw9/3HoT8AC+EqeKA525ugnKbrihAJSBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoWqugh9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoWqugh9"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa52bb7beceso559321266b.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181689; x=1733786489; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag9gIogQI6Zcv/bTsQKHzdfzAXUxOWfbQGzCnxIpCpo=;
        b=AoWqugh9Uyieg3hrga8sp3zqQ2XnrICmCiqGsWNBOZJk/CFWKLtXh4/9Zxo6RHfyHJ
         dMjbgu1e/euOggffEkw6CzfXiGa77LZmc8gEppjPA3wcQt2XWhz/B+KqHInTnbNJvDXv
         UloZzu2VdJ4wZapJjaJt2Zb3QDOWR3medErST5JWGpCLo6v5czyjGvCN7mjj0MuKQ7wE
         AdfBCbWmkeRk+NJ21klv2FEoWP17hxpNTiaYsd/svBvs0uChCpEQlrBQJC7OR4gPogXs
         konFFKjfrz9n8KI2twrYanN8LpayQ4ofoUwfhCU7AcNAqLloeZs5PtG/STvIMaa7IQh5
         Je4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181689; x=1733786489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag9gIogQI6Zcv/bTsQKHzdfzAXUxOWfbQGzCnxIpCpo=;
        b=IWISFWxL9z4xekP1xF5nhfpYNZjmj6mv6HjgMolqoceuWdr/AiqZFChvUetGhG3m9i
         rYvH8uaKVQQKEGhsK2rYkx2Pz2ByjQe34dHTF4n3d6dX5iMd/i2F6ymRtvIPueOKASmm
         J2nuCH6H8f6IRcWJtihoKg1pLZNh8MaT4N8Yy1Xbp7aP8GvQj89D29rFzw/GsAJfunSA
         oNO8xMrVOZWFFOTXZmdMbbB3GoAp1DRmZgHtMQDiMbJF6bubI+z6WqMsT7pK0FO6vrup
         MATHDXEugWxof4/+oMLhlgmM1BQrFJVicNJ/EUq7iVQkNLk8+AW9i18R7ysUkyGIfDzw
         J1Nw==
X-Gm-Message-State: AOJu0Yyd5xa3edTK8gFwcQMAElYhbnWOLUGvs1CT+kfMT5UzzSev529g
	PSwuzxefDJv7Cs4X2J3MCu8+owHYmrQ1np3HCXGb2UbKm17mApAqbYNUUQ==
X-Gm-Gg: ASbGncssrTdIFzgVNcgRYIw/yawGAPu0JDXTAqsfNVLOxLEHKwQ9M766gzg8QorGsf9
	5gy9PA7ujgdjjHBRo7tCdomjELUR1+08JVKGyrt/KDi6LWFY5pgP6hHOvznUIEe5f4sLIfmcdic
	M7fT8aRpelfZmpdvtNkQRI+KGztDBekK/YwmvlMgmNllCV3o1K+3fJcUcKFj8lDCw4M1biGHnjY
	jIcxSaCE+/OUkB2x/4qIPKHCXVEIy10mtrcn/ORn4uCvgpnong=
X-Google-Smtp-Source: AGHT+IGYaNV6LcIncb5JVEqxp98AEmbaEBnUzBcJ2xzwW6mm8q9PQMejfVSy88yJV8D01DdQ8Ys8eA==
X-Received: by 2002:a17:906:3191:b0:aa5:3591:4208 with SMTP id a640c23a62f3a-aa5f7cccb05mr6835066b.12.1733181688793;
        Mon, 02 Dec 2024 15:21:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c0eb2sm560003066b.28.2024.12.02.15.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:28 -0800 (PST)
Message-Id: <6a95708bf972cb22c8abf1da389350fc9f53c4ca.1733181682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:18 +0000
Subject: [PATCH v2 4/8] pack-objects: add GIT_TEST_NAME_HASH_VERSION
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new environment variable to opt-in to differen values of the
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

Third, there are some tests that compare the exact output of a 'git
pack-objects' process when using bitmaps. The warning that ignores the
--name-hash-version=2 and forces version 1 causes these tests to fail.
Disable the environment variable to get around this issue.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c          |  5 ++++-
 t/README                        |  4 ++++
 t/t5300-pack-object.sh          |  7 +++++--
 t/t5310-pack-bitmaps.sh         |  5 ++++-
 t/t5333-pseudo-merge-bitmaps.sh |  4 ++++
 t/t5510-fetch.sh                |  7 ++++++-
 t/t5616-partial-clone.sh        | 26 ++++++++++++++++++++++++--
 t/t6020-bundle-misc.sh          |  6 +++++-
 t/t7406-submodule-update.sh     |  4 +++-
 t/t7700-repack.sh               | 10 ++++++++--
 10 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e36a93a0082..e2f6431d614 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,7 +266,7 @@ struct configured_exclusion {
 static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
-static int name_hash_version = 1;
+static int name_hash_version = -1;
 
 static void validate_name_hash_version(void)
 {
@@ -4609,6 +4609,9 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
+	if (name_hash_version < 0)
+		name_hash_version = (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSION", 1);
+
 	validate_name_hash_version();
 	if (write_bitmap_index && name_hash_version != 1) {
 		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
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
index eca4a1eb8c6..b1553cbaf7f 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -209,6 +209,10 @@ test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
 '
 
 test_expect_success 'out of order thresholds are rejected' '
+	# Disable this option to avoid stderr message
+	GIT_TEST_NAME_HASH_VERSION=1 &&
+	export GIT_TEST_NAME_HASH_VERSION &&
+
 	test_must_fail git \
 		-c bitmapPseudoMerge.test.pattern="refs/*" \
 		-c bitmapPseudoMerge.test.threshold=1.month.ago \
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
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c53e93be2f7..9371d2606c6 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -516,7 +516,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big tree (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --full-name-hash option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=2, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" without any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+		GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify the assumption that the client needed to fetch the delta base
@@ -535,7 +546,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big blob (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --full-name-hash option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=2, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" without any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+		GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify that protocol version 2 was used.
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

