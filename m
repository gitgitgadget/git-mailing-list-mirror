Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E449224AE6
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463347; cv=none; b=JXPkBHJJXPKv+XyfhTxx2xs0EMXzOOUcvhXH5y+SQx5chHMY16NNYhIDp2Q2jm/zN31VbQfgpVGqLxH/0cs7HDnOETzI1bSaSrgiHtfevt8tZMncdoldRFiNzPLW5AjFc1OnvciwOymMInlb56lKYADYFJAqu2r2Bs6JIxJEn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463347; c=relaxed/simple;
	bh=5QVjqd+4YGFm6p+Ew6ypGp2wL4efgKMQwLNxNzMTCpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJHJmMWHKYkIgmU3oBoWjfqPBOM5yWNK27MlmRnwzKDp65ZnL5gDsmn1fisjY8fgG2ODOmJbV3f3gKgRmXb43RkbcNhKNZx/T5Dn4yKZc41h4GLa7qFvUXi2c/w2ZlBoYbK9Jy4SviNU61feB+aTg2dwTysOE16/vd1DOjUIlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=paTUlc3P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AE+KYbE3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="paTUlc3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AE+KYbE3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA9C02540099;
	Thu, 20 Mar 2025 05:35:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 05:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463343;
	 x=1742549743; bh=BJRNwgiWlbJ4ZkzV1L8Jvpgsf5aQcXtCcYctslhu8VY=; b=
	paTUlc3PuOJQZyguRQo0ISE51LeEvZoKkjMhFXRNWEH2cRNbJP3/I+AvM7r44lU/
	jRfU9ESFP+v9M9Jn2y9PWXnpdosJ27QTEMtWeotnw6GtP9dIT2XOQjj+lMAeXkma
	j+GIsFT9AjfwBJ+E4Hdq+ZdfqnGYF/E9yehuuDNH0ak/0GI45tsZZwPog6vnwjSt
	W01GlVJPbGKw/LP5O42W87rfT7scKhbmAaeTi+LT5gGPXFiBpWFXLDlnctDdUnBZ
	oO8zqd7fvN6gXayUme/dhoSuJBfROMywlpkNzKQv5J3ZHgeisaIiqeERZkv0ES6F
	XOWF8HTIPV3eVXSmZnYAYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463343; x=
	1742549743; bh=BJRNwgiWlbJ4ZkzV1L8Jvpgsf5aQcXtCcYctslhu8VY=; b=A
	E+KYbE3q6h6DTKE6Iht3oJQ9KNqVenKGzenNPKiCg8LvADpkoSxQd3l8hEV4n6d5
	omVO31AwiQ69w6Rp2JMQSk6taReobTFmuox6YDAGCUdPRiTKQcglzuRsLbW4Z1G5
	S4UE2L7RlI6/P49c7yFuwk+aEU9HfVFMbb/93c7kLTZj6/zgHVfDVmll3qrfa3GU
	fjNmBI6UdIeXhlmncgeYziLSY16udzVh3l9aM2jXBFxMDlhI//lqZ9nm+/aEikkU
	pD/tXR2Vp5Z263idkVOLOIiEcucWnl1ZH5DHTHdU9U4A7AjWrnKT1z3v7xsSlv/m
	9BtYjJziBKBCqwGniFQEw==
X-ME-Sender: <xms:b-HbZ8VIWr6J3so9D2qb8oWsFqb8P84E_R3iQ65LvWUlcDTmGTsuwQ>
    <xme:b-HbZwkWZF3fCLL-gWr0fwazAj_0v9q9PzYURHxKKGaL0TAPxrJaFTB2xCiIdkGVa
    TB4U__Mij7JIzlbFQ>
X-ME-Received: <xmr:b-HbZwbQFcXHZ8eZ5HQLw9YO41YIzub78bbtErBUlzApr2x1ynCC30gVUo0WQrqm4FCKU7msANLnoAM8MmHSbGpui1o5FrQEgdamD2_OiTvj9_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:b-HbZ7VimsHZ_5OGV3IS3l1bW4C92qsVCyswQzEo-hHxbtCPsQ5wew>
    <xmx:b-HbZ2lpilT6q0yx7He2p8BceglI4VqwRsWrgPhMKHwj2cp-nOBBVg>
    <xmx:b-HbZwfUVRWYPKdsMZ8zo9NjMnjwxXllIKz9_Wf71G2X4bKi-wGCDQ>
    <xmx:b-HbZ4EiGy08sl-wsK1dxWDlVRb_4H56nayTN2tbx7v328U-45PRSQ>
    <xmx:b-HbZ7zaRw2N9eIKvutgAYYiTd_pr3FVIz0-3u4GJcM2DRn0QkKvlC6C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80ef37a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:37 +0100
Subject: [PATCH 10/20] t: refactor tests depending on Perl transliteration
 operator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-10-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

We have a bunch of tests that use Perl to perform character
transliteration via the "y/" or "tr/" operator. These usecases can be
trivially replaced with tr(1).

Refactor the tests accordingly so that we can drop a couple of
PERL_TEST_HELPERS prerequisites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-sha1.sh    |  4 ++--
 t/lib-diff.sh            |  4 ++--
 t/t3300-funny-names.sh   | 12 ++++++------
 t/t4020-diff-external.sh |  6 +++---
 t/t4103-apply-binary.sh  | 12 +++---------
 t/t4116-apply-reverse.sh | 10 ++--------
 t/t4200-rerere.sh        |  2 +-
 7 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/t/helper/test-sha1.sh b/t/helper/test-sha1.sh
index bf387d3db14..f03b784ddc2 100755
--- a/t/helper/test-sha1.sh
+++ b/t/helper/test-sha1.sh
@@ -15,7 +15,7 @@ do
 			{
 				test -z "$pfx" || echo "$pfx"
 				dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-				perl -pe 'y/\000/g/'
+				tr "\000" "g"
 			} | ./t/helper/test-tool $sha1 $cnt
 		)
 		if test "$expect" = "$actual"
@@ -61,7 +61,7 @@ do
 		{
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-			perl -pe 'y/\000/g/'
+			tr "\000" "g"
 		} | sha1sum |
 		sed -e 's/ .*//'
 	)
diff --git a/t/lib-diff.sh b/t/lib-diff.sh
index c4606bd4b7f..12b3c8fcc6a 100644
--- a/t/lib-diff.sh
+++ b/t/lib-diff.sh
@@ -21,8 +21,8 @@ compare_diff_raw_z () {
     # Also we do not check SHA1 hash generation in this test, which
     # is a job for t0000-basic.sh
 
-    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
-    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
+    tr "\000" "\012" <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
+    tr "\000" "\012" <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
     test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 502b1572059..dd0586b0073 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -63,14 +63,14 @@ test_expect_success 'ls-files quotes funny filename' '
 	test_cmp expected current
 '
 
-test_expect_success PERL_TEST_HELPERS 'ls-files -z does not quote funny filename' '
+test_expect_success 'ls-files -z does not quote funny filename' '
 	cat >expected <<-\EOF &&
 	just space
 	no-funny
 	tabs	," (dq) and spaces
 	EOF
 	git ls-files -z >ls-files.z &&
-	perl -pe "y/\000/\012/" <ls-files.z >current &&
+	tr "\000" "\012" <ls-files.z >current &&
 	test_cmp expected current
 '
 
@@ -101,23 +101,23 @@ test_expect_success 'diff-tree --name-status quotes funny filename' '
 	test_cmp expected current
 '
 
-test_expect_success PERL_TEST_HELPERS 'diff-index -z does not quote funny filename' '
+test_expect_success 'diff-index -z does not quote funny filename' '
 	cat >expected <<-\EOF &&
 	A
 	tabs	," (dq) and spaces
 	EOF
 	git diff-index -z --name-status $t0 >diff-index.z &&
-	perl -pe "y/\000/\012/" <diff-index.z >current &&
+	tr "\000" "\012" <diff-index.z >current &&
 	test_cmp expected current
 '
 
-test_expect_success PERL_TEST_HELPERS 'diff-tree -z does not quote funny filename' '
+test_expect_success 'diff-tree -z does not quote funny filename' '
 	cat >expected <<-\EOF &&
 	A
 	tabs	," (dq) and spaces
 	EOF
 	git diff-tree -z --name-status $t0 $t1 >diff-tree.z &&
-	perl -pe y/\\000/\\012/ <diff-tree.z >current &&
+	tr "\000" "\012" <diff-tree.z >current &&
 	test_cmp expected current
 '
 
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 189294de7ef..c8a23d51483 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -237,9 +237,9 @@ check_external_diff   0 empty  empty 0 on  --quiet
 check_external_diff   1 empty  empty 1 on  --quiet
 check_external_diff 128 empty  error 2 on  --quiet
 
-echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
+echo NULZbetweenZwords | tr "Z" "\000" > file
 
-test_expect_success PERL_TEST_HELPERS 'force diff with "diff"' '
+test_expect_success 'force diff with "diff"' '
 	after=$(git hash-object file) &&
 	after=$(git rev-parse --short $after) &&
 	echo >.gitattributes "file diff" &&
@@ -300,7 +300,7 @@ test_expect_success 'external diff with autocrlf = true' '
 	test $(wc -l <crlfed.txt) = $(keep_only_cr <crlfed.txt | wc -c)
 '
 
-test_expect_success PERL_TEST_HELPERS 'diff --cached' '
+test_expect_success 'diff --cached' '
 	test_config core.autocrlf true &&
 	git add file &&
 	git update-index --assume-unchanged file &&
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 4894605db7a..8e302a5a57e 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -11,12 +11,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping ignores tests; Perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' '
 	cat >file1 <<-\EOF &&
 	A quick brown fox jumps over the lazy dog.
@@ -32,10 +26,10 @@ test_expect_success 'setup' '
 	git commit -m "Initial Version" 2>/dev/null &&
 
 	git checkout -b binary &&
-	perl -pe "y/x/\000/" <file1 >file3 &&
+	tr "x" "\000" <file1 >file3 &&
 	cat file3 >file4 &&
 	git add file2 &&
-	perl -pe "y/\000/v/" <file3 >file1 &&
+	tr "y" "\000" <file3 >file1 &&
 	rm -f file2 &&
 	git update-index --add --remove file1 file2 file3 file4 &&
 	git commit -m "Second Version" &&
@@ -164,7 +158,7 @@ test_expect_success 'apply binary -p0 diff' '
 	test -z "$(git diff --name-status binary -- file3)"
 '
 
-test_expect_success 'reject truncated binary diff' '
+test_expect_success PERL_TEST_HELPERS 'reject truncated binary diff' '
 	do_reset &&
 
 	# this length is calculated to get us very close to
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 6f414ad27f5..1e7beab0016 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -10,23 +10,17 @@ test_description='git apply in reverse
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping apply reverse tests; Perl not available'
-	test_done
-fi
-
 test_expect_success setup '
 
 	test_write_lines a b c d e f g h i j k l m n >file1 &&
-	perl -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
+	tr "ijk" "\000\001\002" <file1 >file2 &&
 
 	git add file1 file2 &&
 	git commit -m initial &&
 	git tag initial &&
 
 	test_write_lines a b c g h i J K L m o n p q >file1 &&
-	perl -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
+	tr "mon" "\000\001\002" <file1 >file2 &&
 
 	git commit -a -m second &&
 	git tag second &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 50fe8b0fd05..7fcca9ddad5 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -194,7 +194,7 @@ test_expect_success 'rerere updates postimage timestamp' '
 
 test_expect_success 'rerere clear' '
 	mv $rr/postimage .git/post-saved &&
-	echo "$sha1	a1" | perl -pe "y/\012/\000/" >.git/MERGE_RR &&
+	echo "$sha1	a1" | tr "\012" "\000" >.git/MERGE_RR &&
 	git rerere clear &&
 	! test -d $rr
 '

-- 
2.49.0.472.ge94155a9ec.dirty

