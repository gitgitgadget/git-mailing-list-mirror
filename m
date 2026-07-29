Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08E3F9F3B
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367943; cv=none; b=uLbMyA0DeoFrpoS28cjKhHO+WahGweqtenehbLlEs3LJcFaLcC1U8zYzc3jkhpdSHYSvAIcON1VSHO3zgpbwXV/gI8jj7F3he1CaM59mvm7qzJroF1xzi6ggNkXXbnzQvUUAUx8X/X2aL0We+FX3y1RMqAteTF0HDF07K/GrTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367943; c=relaxed/simple;
	bh=r4z13wXhVz4hG+npQwk+VbjQvM1GeX1G+GS4+wCc6xg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmDc7EwjGRCXTBgTJaOn6spGePtgFQvNd/xMRVmv65l3xBmDBah8ex5oEFNoscgAr1cs2p6vH1TOrHVKO4sn2AU/mSC6i0M7UqHbnCepSolOHvuWvoFpzdnCQUiL4Qen4SuWO3fp1tK4/NKumd3tszMEVBIcWRtBjiyXNk5NYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cZvpJ7Gi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cZvpJ7Gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785367938;
	bh=r4z13wXhVz4hG+npQwk+VbjQvM1GeX1G+GS4+wCc6xg=;
	h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
	 Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
	 References:Content-Type:Content-Disposition;
	b=cZvpJ7GiT6eZGAQV6eVsSnEXDnYQecenoUns4dWyIb4JwFyvCcIzE/BOG9wp/MJG7
	 e2k73PZ+9cVBKA7MgnlzmUvR7sc+JAD/9Rusb97StjwCtcruH5mU4usIQ5ka+aedFt
	 EP//MJVs/dip12z6ZFj4pvX+WnmQ/SONlCwQ4hzqeo+ZqyeRrFxr9UDW2xRZNou/pS
	 PxD7iNOUPF3LJCLl3kWbnK4Hi6mPd6EnadlmUMBB2quaBcNnuCFT7wJr/Ea4qVdqjt
	 o9L1FJOjQ2RxXddVsHwzXU2djl2yXMdDHFPu9FIUcspw0GMW01on732HsQexTb7Lqx
	 TxrX/fJgl3A93WpiL+7zoF0Hb8yIRhtjEFMxM8mJWPvfZpHynX4p7a5tKCzi7pOPjv
	 AULKiZgrFZFXx1AtGKxF3boC6N5tCesOVw1PbD1JfIONc9xUiBR0NikuIrS2xHLwF6
	 FmPcg3cOBUVDd2ClFGrlkueu4/ksJ7eKO+pxKhyeHXmV1winpX9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c292:4852:9051:fdce])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B4333201E5
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:18 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Subject: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking changes mode
Date: Wed, 29 Jul 2026 23:32:15 +0000
Message-ID: <20260729233215.398654-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260729233215.398654-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git has historically allowed either lowercase or uppercase hex for
object IDs, but it has always emitted only lowercase.  This has caused
people to expect only lowercase and not handle uppercase.

As an example, Git's own example hooks look for "[0-9a-f]" in several
places, but there are many other Git-adjacent pieces of software,
including Gitolite, which make the assumption that object IDs are always
lowercase.  This is not to criticize the authors of these projects, but
rather to point out how common this assumption is.  In fact, it's so
common that we have only one test in our codebase that fails when we
reject uppercase object IDs.

More critically, it leads people to make security-based assumptions that
an object ID either does not contain uppercase characters or that an
object ID can be expressed uniquely in hex form, neither of which are
currently true.  Git itself normally uses binary object IDs, which
avoids many of these problems, but most other projects deal primarily in
hex object IDs, so they are more affected.

In preparation for Git 3.0, only allow lowercase hex object IDs in
breaking changes mode and document this as well.  Update the single
failing test and add a new one to verify we reject new uppercase object
IDs.  Note that in t5324, we change the hex character from "A" to "b"
because in SHA-256 mode, "a" is the correct value, so our test_must_fail
assertion will unexpectedly succeed in that case.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/BreakingChanges.adoc | 5 +++++
 hex-ll.h                           | 4 ++++
 t/t1503-rev-parse-verify.sh        | 5 +++++
 t/t5324-split-commit-graph.sh      | 4 ++--
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 73bb939359..dbc46d14e3 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -171,6 +171,11 @@ JGit, libgit2 and Gitoxide need to support it.
   matches the default branch name used in new repositories by many of the
   big Git forges.
 
+* Git will accept hex object IDs only in lowercase. The fact that Git has
+	historically allowed uppercase characters in hex object IDs has been the
+	source of a variety of bugs and security problems in software using Git. We
+	don't expect most users to notice any change.
+
 * Git will require Rust as a mandatory part of the build process. While Git
   already started to adopt Rust in Git 2.49, all parts written in Rust are
   optional for the time being. This includes:
diff --git a/hex-ll.h b/hex-ll.h
index 9da76f17e8..2f9c8d7c25 100644
--- a/hex-ll.h
+++ b/hex-ll.h
@@ -6,7 +6,11 @@ enum hexkind {
 	HEX_KIND_LOWER = 1,
 };
 
+#ifdef WITH_BREAKING_CHANGES
+#define HEX_KIND_OID HEX_KIND_LOWER
+#else
 #define HEX_KIND_OID HEX_KIND_MIXED
+#endif
 
 extern const signed char hexval_table[256];
 extern const signed char hexval_lc_table[256];
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 87638a4a2c..f07b45de5a 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -60,6 +60,11 @@ test_expect_success 'works with one good rev' '
 	test "$rev_head" = "$HASH4"
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'rejects uppercase revs' '
+	UC_HASH=$(echo "$HASH1" | tr a-f A-F) &&
+	test_must_fail git rev-parse --verify "$UC_HASH"
+'
+
 test_expect_success 'fails with any bad rev or many good revs' '
 	test_must_fail git rev-parse --verify 2>error &&
 	test_grep "single revision" error &&
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index bf7ba0e558..29db815c77 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -349,7 +349,7 @@ test_expect_success 'verify after commit-graph-chain corruption (base)' '
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "invalid commit-graph chain" err &&
-		corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
+		corrupt_file "$graphdir/commit-graph-chain" 30 "a" &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "unable to find all commit-graph files" err
@@ -364,7 +364,7 @@ test_expect_success 'verify after commit-graph-chain corruption (tip)' '
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "invalid commit-graph chain" err &&
-		corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
+		corrupt_file "$graphdir/commit-graph-chain" 70 "b" &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "unable to find all commit-graph files" err
