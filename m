Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5126868D
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908477; cv=none; b=YWNwRIyIFNkWDYj/6aP2G89Akf2RngtiZdnxrcqFbEiA4pUh9aFcmE6npHu6eOXCWUh7l6ie2lijQ7nYWPWR8XosiMofpHICftfPwsngXbqkGEqF1P+mc0yHCjFs7u8Ge3ey0Qpt7CeQ5zNndmIlCzUZSlJYwxQUQLy6aXAgAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908477; c=relaxed/simple;
	bh=kbryDW/8mAHi1VxLqgZRb+hSNgwHHvpVcZLcfFw5Ldo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iq/v/aZk4JElyRtofqb12zeVqGwjSFULutt0Wdt3M/clOWf/TYVEIgh6q1M579Y3ceYWc8+cSCIl6u+QWuRnvm5NS1JqVkzOdNupc/BP5+AzJzT0V6JJ0fwIR48GHIvUM2OQiJLzV3O7WzhFln7xqgyeTi6Kpz5Eu6JHhZLMQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZaANJI6j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFh5OxIe; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZaANJI6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFh5OxIe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 451951383841;
	Tue, 25 Mar 2025 09:14:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908474;
	 x=1742994874; bh=99JmKnJAovG52dErw2E33UrMlnFczkkbwlem6rWKtX8=; b=
	ZaANJI6jLkSR2eKm+L34czG363yGzJtqW+Zp37rDGCyrXHvhGQKhbCIPlJdKCyK7
	PVXxMmajJ9BFAD7ubLQCyOcLIXriCCGzgou7FaCGGWxmo9lmqRpXOzZT+ADWdSdt
	dtXbh5HZNZ4Utf11WzX1n0Q9x4ln1Cz05jLqGD99XMlmLxRcQsKQBiQzItsRVdNP
	J5McBUS8WRlbW0bJB+44bNINoTGShuBWaiFkeLidhLRcRDQP5bF7DmyJIfH0b9f2
	/ETNLTQtCEBwp+a6tXE9wCMio1G4Pusigt9GsEW/CAnGeRuyn02NikNoF38qHkac
	bL0Pz2oIhkNNrsB9nXk0PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908474; x=
	1742994874; bh=99JmKnJAovG52dErw2E33UrMlnFczkkbwlem6rWKtX8=; b=D
	Fh5OxIe+grdD4Ip4N2ZWuOURO/aDk81RqR885aQmOCo32cA6pFJUyV6DJItNns4x
	lJxQua838sEGSt0+UkFAPBMi7abH6EDqj8PoKj1wNKkyy0IWbieY4/sHAdjl5hq7
	XOkjvHGC6Gx+znAyQotF/5lO0vZ9wd/zzXhVp//GkaHo0FD3OGD32T64alwhkgaZ
	Kvpxj0YBE1GTQNQIYGZxl6ZZrpsnU9p7uXaRl0ISpOAzu7DkXujdC3zz03ANI1Va
	Qnxw7L9CYcLowJ/gu5C1I+gDX9IvWy2jlLBwztHjOkvZDjVrqbVx0p6C928Pa68L
	iSHwrYhAMqkxtFXVaEqiA==
X-ME-Sender: <xms:OqziZ3ZcQ11AjNraNOQFAbvn3pN5xbhFsNodcOk2apunWhai5At5Qg>
    <xme:OqziZ2Z-fhP-neeamlQWzgqCw-tWZByGtP9W106nX8QIG0pX9vfu5vCSvLbF39Np5
    n2NXctaio43sv6Ymw>
X-ME-Received: <xmr:OqziZ5_N0-MuXoXmC8CHsYLoSgc-b1ntFx640TI6xkb2eWLxjkAYVvzR76zygEccG9hYBYnTBXf2S4DKbp8mYrxPB52RvkLB4xaMNQHT1j0SQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OqziZ9rSYgFehmF5jBrLeGBqIvXblRzrX9UU7dY3Qah7ZCQM5XtQrQ>
    <xmx:OqziZypnvwmwb6t4yqX0tPD5Q3pqQtBJXivsf-HbwXLWB1OEb2Mb5w>
    <xmx:OqziZzRFzSRAw7uStQ9DYZ3facw__CiOP0mERZbxqo7fHa_VVUMIhw>
    <xmx:OqziZ6rAIG7TDDKzapER9b1VBr5raY7ipTIe1x0sl3ZZ0f9NROkTFw>
    <xmx:OqziZ_DsglhQHBVOy9skf45FHXorlPYduR0WQkzd7-TxHD2goTGTgnop>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18ada201 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:28 +0100
Subject: [PATCH v2 10/20] t: refactor tests depending on Perl
 transliteration operator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-10-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
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

