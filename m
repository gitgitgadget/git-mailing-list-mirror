Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EFC5505D0
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087490; cv=none; b=bYjksUduuG+8LKWALpza6xlsJfOncpeqXijplGSLnChlCVubG4qNswgJR7khUX4Ed9XCTnx8XwqlFtFcBMqjc2oBnT8KXO/7vwkSjblB10FTGT+4D9NnutH/hiCwybt4Jg0N8pI0KlVxD5gZpIlJn19dHIzZ2TpGDdED0UQY8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087490; c=relaxed/simple;
	bh=rOb5dYVJDwxhnWBmpshDpeCHTkWSNEswlcdnikH+F3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOeXtsTKrvZ/U1QOB2pRjVcnDNkm8hC8Jy+uZwaXjS2T8gqfTVcCkUAsExq37cZBbA3mVXIfclno/ykidJ6NspOTl6jCJ7//Qde5c9wyWQG0Q4msmvFrZVKUTltFWvIeGXH/Fkexvd92OV26C9x3IKvnUELEaa8HbD+C+/Isgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HTPvbhWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=offFViIl; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HTPvbhWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="offFViIl"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 8354713003CD;
	Tue, 22 Sep 2026 10:31:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 22 Sep 2026 10:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790087487; x=
	1790091087; bh=JpK9S2QJC35Itp+P41eSO2Cjf303se77sqL1HHOZhFc=; b=H
	TPvbhWRk//++nVt3HuVHhDek7MalMA5myrP15GvlqSOGJl+DiAOj8rLYprsU1LSa
	OhWPIMObfVFDVxaPJhsOm/BIZicVzFM1W7P5FH697rmGZ9C0TjS1DTzu6gfAXeN1
	LCfvhAJeVdXtFj7VgxUCk2Aw4JDAu8+8dVqRvHPLb/bmc2cPc3afiGpfdynQHL/O
	HMozXqU5HExzYptIk7G80+TEncKDyl2BKbj61D4ykhiNcdbaL9X09f8yDImGZnb0
	4lh/vMxnWw1UvzDDKQwxOg/Adp2niUFZKux0ePQiP4DtdwqaFgsb/i6Pye+xo5bU
	U3lfABdqa2Z/llmVi5TnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790087487; x=1790091087; bh=J
	pK9S2QJC35Itp+P41eSO2Cjf303se77sqL1HHOZhFc=; b=offFViIla35r0m5fv
	LMsIkMko0OaL0QUn5jvIp3DCuiD20ItY71pCq8y/pfaLqFCpLURBHtiv1KQyNLcL
	5SNAzcr0Y2IdcUfaaw0rR+HYjO1yiKe1xkXEiKscCNKADsTVIbE0BRlNhz+LbnxM
	x2APafY3daRQ5tiZl85MpFj7qXPMIHHosn10z84lmokLU/dbUa/v3h4S+UzVNCl1
	RlFkDIWUaKUBG6A2lFPAkaOarpq42ZEQ8H/VXOyi+PkXXqXORyuxKU6EsqZP5GbV
	rjpSb7p0q7NoCK1/Cy7u3qujciDmQHHyprq0TKu51bh4csNlOejaUwnhjTYg+rO/
	SNsog==
X-ME-Sender: <xms:P5GyapX8yVyA0ebHUTd33decCsTknGMzyTr0QNchLqat_2i7yhpMCg>
    <xme:P5GyavkI3uIRxMhPwTG5I1on7qA2n_GXePcBtyIok6CWNWghBDocMzP8l7c4R4pe4
    WiVjsML3of9hfLqlNH-3_CEWPGzPKuhKTmqPQLujCIncj6D1YzqJhuq>
X-ME-Received: <xmr:P5GyajB-bnwbnqHcEAVKiayT5izb2i1pRq6Gm8lnWdurXPZaEudjRcFPE3KM2lCg-5B9rKg8_84QWrqD0rnlbcILue_pudHUZvF5vP1AQJ1mwg>
X-ME-Proxy-Cause: dmFkZTGP46YC6q8ZS3oonxOjMTC8HCqj8daYDtrYqYmUEi+Bj7yDT49A11ucpAmi6NOwbE
    bYPMC/PK7ijGEx3KCLyNJV4ENog/lKljYFCb7OmPy/6Ib0hckN1c0hOW408V2srDVEV37R
    Wt0YOEqKR33HGn05ImrYjn2QJMTRlOtLICsR3jUVxfmA8isF4S8XeLrFnAvx+VV+e20GAQ
    jLnaAe1yTYI09FIuCk2734LLj1Ad6e/2dKFMb/MjXw3+q8iVXlvQyU5vcXVWgdQKgLIHUO
    xRCZEyn025iW7UlArYlUbnLpmBhthU8vvgiTwjzZiBB5En9g0LphA/i07BhhLkbsPEIKjn
    wfTgw9ghgKyg+CabTayrYKdUkFYZNq67ywIbGs9Frc/Yr6OYo33FK2vF7NemFlnNG8WmYa
    mt6Eo3ssLSVmLzAWMuSNKAB3uO6UdAXTUjOsyKmT9OFpVpO7mE46JI7feRHV2xGsKUoA0d
    TfK+caPvtAMZAwFamE8HTbBBr8aNjoyaS6U2R7mCQaohmht0oGUVEvJyPQrAFeYiOW4v3b
    0L6Az7PPypT/mKKmQ5HwF0A4DTCSaVjKjiN4uy5UDzyEle+kgsFQaREBDK2Ee4BBIdTuIi
    11TOR675iNaogK2LTz9uvMNbsZt/Vp3E8j7Ba6d6Rb+f/zE/RYpiZppRxBaw
X-ME-Proxy: <xmx:P5GyancjhVxfwiCbKcHTQHFSRy0V8oBDAIkOoqUBsFyglhxB_z2XEw>
    <xmx:P5GyamKBB9AjZJYUnmSZ6G5SR-2NaQ2Yj5oU8gkYk4ATBxnDYV8neA>
    <xmx:P5GyaicOYDGVma1H__CS3KXv5I4ajoa0E9sCM5APqLRp7g0Du_bwAg>
    <xmx:P5Gyal3DJQzs35uP0cg1knGh7F-5F8-zBkeeEdtr8ctLvjwP3QOPAA>
    <xmx:P5Gyar4vCUr2CMG9OjlzRpM-WqRfHvSYJ0IBGT_UexmjQ5BtbnpCzNAt>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 10:31:26 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v5 3/3] t4010: modernize
Date: Tue, 22 Sep 2026 10:31:19 -0400
Message-ID: <20260922143119.3313620-4-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922143119.3313620-1-markchucarroll@fastmail.com>
References: <20260922143119.3313620-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old tests were written in a different style than modern
ones; for better readability and test error messages,
update t4010 to the modern style.

* run everything inside of a test_expect_success block.
* write title line on the same line as test_expect_success,
  end that line with a single quote that opens the body of the test,
  and end the test with a single quote that closes the body.
* write expected output of a test to a file named "expect",
  and actual output to a file named "actual".
* write here-docs using "<<-" syntax, so that they're indented
  uniformly with the rest of the test.
* make test names more clearly reflect the functionality that
  they test.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4010-diff-pathspec.sh | 120 +++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 61 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index c84c3fa05b..34d53e7496 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -13,67 +13,65 @@ Prepare:
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    setup \
-    'echo frotz >file0 &&
-     mkdir path1 &&
-     echo rezrov >path1/file1 &&
-     before0=$(git hash-object file0) &&
-     before1=$(git hash-object path1/file1) &&
-     git update-index --add file0 path1/file1 &&
-     tree=$(git write-tree) &&
-     echo "$tree" &&
-     echo nitfol >file0 &&
-     echo yomin >path1/file1 &&
-     after0=$(git hash-object file0) &&
-     after1=$(git hash-object path1/file1) &&
-     git update-index file0 path1/file1'
-
-cat >expected <<\EOF
-EOF
-test_expect_success \
-    'limit to path should show nothing' \
-    'git diff-index --cached $tree -- path >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before1 $after1 M	path1/file1
-EOF
-test_expect_success \
-    'limit to path1 should show path1/file1' \
-    'git diff-index --cached $tree -- path1 >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before1 $after1 M	path1/file1
-EOF
-test_expect_success \
-    'limit to path1/ should show path1/file1' \
-    'git diff-index --cached $tree -- path1/ >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before1 $after1 M	path1/file1
-EOF
-test_expect_success \
-    '"*file1" should show path1/file1' \
-    'git diff-index --cached $tree -- "*file1" >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before0 $after0 M	file0
-EOF
-test_expect_success \
-    'limit to file0 should show file0' \
-    'git diff-index --cached $tree -- file0 >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<\EOF
-EOF
-test_expect_success \
-    'limit to file0/ should emit nothing.' \
-    'git diff-index --cached $tree -- file0/ >current &&
-     compare_diff_raw current expected'
+
+test_expect_success 'limit to path should show nothing' '
+	echo frotz >file0 &&
+	mkdir path1 &&
+	echo rezrov >path1/file1 &&
+	before0=$(git hash-object file0) &&
+	before1=$(git hash-object path1/file1) &&
+	git update-index --add file0 path1/file1 &&
+	tree=$(git write-tree) &&
+	echo nitfol >file0 &&
+	echo yomin >path1/file1 &&
+	after0=$(git hash-object file0) &&
+	after1=$(git hash-object path1/file1) &&
+	git update-index file0 path1/file1 &&
+	: >expected &&
+	git diff-index --cached $tree -- path >current &&
+	compare_diff_raw current expected
+'
+
+test_expect_success 'limit to path1 should show path1/file1' '
+	cat >expected <<-EOF &&
+	:100644 100644 $before1 $after1 M	path1/file1
+	EOF
+
+	git diff-index --cached $tree -- path1 >current &&
+	compare_diff_raw current expected
+'
+
+test_expect_success 'limit to path1/ should show path1/file1' '
+	cat >expected <<-EOF &&
+	:100644 100644 $before1 $after1 M	path1/file1
+	EOF
+
+	git diff-index --cached $tree -- path1/ >current &&
+	compare_diff_raw current expected
+'
+test_expect_success '"*file1" should show path1/file1' '
+	cat >expected <<-EOF &&
+	:100644 100644 $before1 $after1 M	path1/file1
+	EOF
+
+	git diff-index --cached $tree -- "*file1" >current &&
+	compare_diff_raw current expected
+'
+
+test_expect_success 'limit to file0 should show file0' '
+	cat >expected <<-EOF &&
+	:100644 100644 $before0 $after0 M	file0
+	EOF
+
+	git diff-index --cached $tree -- file0 >current &&
+	compare_diff_raw current expected
+'
+
+test_expect_success 'limit to file0/ should emit nothing.' '
+	: >expected &&
+	git diff-index --cached $tree -- file0/ >current &&
+	compare_diff_raw current expected
+'
 
 test_expect_success 'diff-tree pathspec' '
 	tree2=$(git write-tree) &&
-- 
2.53.0

