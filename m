Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E521129C
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071839; cv=none; b=meMhmfS+Bf8o1XggmOF9N1poRBzHziP7E5zu9/bknHC9w07IRI4ff2pdICxIgP4C/g/xbLqRWq+J9svm0ckpsKU8UGNI4eK3mgH6K32g7VzJPRemO9w0JMLb4R1vSEd34fZ2wXTS4sZp/hi8Tj5LjY9ConcYeb/nmz8bi4Z4mWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071839; c=relaxed/simple;
	bh=kbryDW/8mAHi1VxLqgZRb+hSNgwHHvpVcZLcfFw5Ldo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VyhTVQFKpQRLoVZGx4bFqnoyM1oQC2T25SsiM3aAZctnf9/jrdHndvQv7N3+cotda1Ayyg+BDE4Tc8oqAsLRq2YSrAkUEYPZI90uXfjvqOVzAEHJx6/foq0WLJfoHh2cQiIt4W+N0gSOv9w9EV5cMD/fsrxsqYPbf/3J3LTuGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O2WAw4Kp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+1EF+dW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O2WAw4Kp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+1EF+dW"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 147171140126;
	Thu, 27 Mar 2025 06:37:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 27 Mar 2025 06:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071837;
	 x=1743158237; bh=99JmKnJAovG52dErw2E33UrMlnFczkkbwlem6rWKtX8=; b=
	O2WAw4KpMbg0cpOWX7tT03aPi4KlnSJPnbBuH4k9EoA6IcA4QpWVxdU42fhER/0Y
	4Qet+CFk4Fpa5X8FENczP50MGv+hlTzc8M2uTB+odtwlYoXhsfqsjRoBr487gDMg
	P98iddQHcku/pj/UzSOTK6K/oxb6zAMlxbf0NGYwh1beTgXzvYacYnyp4HG9UtIZ
	Uf7TJLNp0YwntY+14FldLDMfEj0i3H6PIWyzL5Up/3wPLTjcV1jQTDkulmTukfYB
	IfH7/0qUey9GaXDtZH1U2E1Iv/EsbyA4TNxchxOaS0aF7fNCc8Zmomg64Kg25K9O
	rLMEBc45wrUO+qffWQobxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071837; x=
	1743158237; bh=99JmKnJAovG52dErw2E33UrMlnFczkkbwlem6rWKtX8=; b=k
	+1EF+dWC6d2RHKKhMHLlWH97HhsWcj6/jEEcHC11yjYKChqvX6Vh1ElL27ulZmGB
	q4sDXZmC88n3dXfxyGVLQCLT5lxKIGnrCiGlQp8iHZdfRV1JwGaqmYxylG7yGU6T
	ZVV3SBsC5caNSa/sWgQuDIjNKnNaBlzWn/DdHE+BZ6tqGkQXIOIPo7zdNdVG8931
	VWtaVweJExjC3TuTuZoUJn6Kr72Sp6SPiZH0YYwJ4XNHFr+7LhEgJ27O5T31F4ha
	HalOCS+5olGFQmi/t7QVc8emCUxKn2QEfdHFwFJ2oJFSTQ542ii2IIcQtujst4hX
	tlcagRFNl46ZUdIz3GnZg==
X-ME-Sender: <xms:XCrlZxvpC_yPqclMvMGFSs959e5w_cbBWcCEUc_8ZI6y4HRu29tVjA>
    <xme:XCrlZ6eeWpvHiPZfM_y6X4BRRfD0KPHQTZW4k0O-ewnfNCuiwOjNiVZ-jMRwqD-Jt
    6AG_p0Vce0GTLTLTA>
X-ME-Received: <xmr:XCrlZ0zvc5tPQjAU-kCAw39p17aZK6VtR02CJ3RHAWlZoBEOkkh6WC38RMSenKNg8rLkpgnNgeAyriMkcq0-PC7J1TnJqDqHd4RkMVIWiKGABg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XCrlZ4OXTiBN0TQDtQByRJ6ewKWi7ggXrwK7m2ltf9eCcEpt_anTyg>
    <xmx:XCrlZx_5neAZ8U8DW-9XYUUZmBzSCfwZZrfqeGJGGuZqHpXfOV66cQ>
    <xmx:XCrlZ4WIj5zlAJrnk6zIpn4q8lUlkjcePeQG1AZquHpA9rVRRyW0hQ>
    <xmx:XCrlZycw_kAxenjdo97Iu_y-I5CgJGjAbsNQDOj0ceO9_LQDIqD9sg>
    <xmx:XSrlZ0nhZNDIjdKoHdtOa61-ALI2IQM2USS2UWxNDCua0p1BB-PumvZj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9314326f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:08 +0100
Subject: [PATCH v3 10/20] t: refactor tests depending on Perl
 transliteration operator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-10-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
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
index 59d38793ae6..8e302a5a57e 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -11,12 +11,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping apply-binary tests; Perl not available'
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

