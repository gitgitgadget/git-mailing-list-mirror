Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738174BD10B
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108564; cv=none; b=IJF+TExOd8EeWHHmQwQQmcgxxG4452hEOo/EYnW+NwmN813B1IEkXBTCVp/Ks7B+WrUd3B9Sd5aQTpbxk9slH15G10tRNutYkSJTbbewZBcMrpQWGpS5+8/YNP6A3lv1HIXCapBsbDqFy3R+90cCvjrhRHi4vkAkHf/FJJ7byDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108564; c=relaxed/simple;
	bh=Rvor9uwzQ7enRPAhlkqoyFaoLc54FEYuKY7lzOLYNfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsRlapfz2d1WuagUNHmmCi4mQwFkfU+GQ8gzbpvtsdzR7aDnAAkKqw+O9JmlHQR2liEPptVM0I5naztZ95mvglbJjpRWYyGkgRInOm90cYePREKAeweyyZVXx9WIEMi5g7LIL741EfofsMR443eEEn5Ief7PSJd0j7MOFDoF8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=e1eQ3ouP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnP9wqph; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="e1eQ3ouP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnP9wqph"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id D0A4B13000E5;
	Tue, 22 Sep 2026 16:21:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Sep 2026 16:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790108519; x=
	1790112119; bh=tCDaa6+nyViUUuDjNQQfnSoGMevJQhjjjEz9cdqUP64=; b=e
	1eQ3ouP5gHtn16tTXrtjuLIPeB1LSD5E7XpIHl73X5vn63J4jsjSTkDtiX/9B3UC
	UrDILbglVZ6jtehe2YvOH8kRHnPy6NfYUPFTOhDZwzm11YFc4wqzwRng/F0XYTu7
	TI1oc0KsJn5zEoS2Z7UihkAwBBPlDI9zTKAvMXTRO0GTCf8I9S80FnSKNHElX7eu
	yfbMy8OU6WKMdeTO8bT+mHdERg+WfGB6uIpprvQMA7tWd5b+QITJ4ckCiM4Wp2+a
	+9Yj5Bwh6sjEAvmPu8D4v8+Qyp41VTzJZO/vbPSbgcf8FL+V2KZBz3+Q22rAbslp
	CqMydkX05hJ6lnb7Kh+rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790108519; x=1790112119; bh=t
	CDaa6+nyViUUuDjNQQfnSoGMevJQhjjjEz9cdqUP64=; b=dnP9wqph2CvF+gGE1
	mk+wi9vqlk2l8IX8bz8Vc6bN3BYRk0Oxjz088p9Po/jZ/PwCS2gUbACQ69Zem/jD
	59GCaZDHV8MIV7WDYpnSfHmwHd3g/l0JOccbSRgIImn9MHoxyx5On2wO1oo8BEoE
	TyeYYLn5jUddlSuej0Ss4XahrptHPY6Iatlh8RAUxCzuoCcHWg1nzSLfk9DlP72u
	oFDUyG5Gn8CqKgvBDiaBl+WeVPdI4DKqBZ5zGO3NDDYw7LU00+Mu/DoIOY+gn34B
	I5Q89DITOxCHEqX2qa3AMD2M7LG8UusF0mnmrXgZ1KnZYft1j5QQDnCuUDMg8XxR
	g4n9g==
X-ME-Sender: <xms:Z-OyaslflLbd-Pm5JZvxuTi0uJe9HDVuT0fo_EvvDASV20W-F-Jc6w>
    <xme:Z-Oyah3-Gn8iX7kb2B36cmAV-IGaRV4EMzek8IOwlm6n7woEZ4Qvj2gbiCnbyh8d3
    BJ074jex1dBbLW5E7KVy59zgjCEDk_WayzBcvrJQHdQ9bzuH0sfjrjR>
X-ME-Received: <xmr:Z-OyaoQ20ftixwpYSmPZfFrfOT47vVaA9VFfHQN3APtQ6Mim6h_dzHqXrl-7jEmBf-8LNcvQmqEH2Qa_7mM6yEvrss8d6O7OUkhYxGzqXdoBbw>
X-ME-Proxy-Cause: dmFkZTGCYogreECxIvFvsaYuJwFw9zKXvYK/3LuFDw1I6XScytqA3DmIYi28PuUsLEdtBi
    DkuyipRnWjlzPZ5XdPDeK4dLAIz/MHdOVl/S7PUdtAa9+u9ElbebxHhsmqa5ir+bcMnOrG
    MTYZ0MpAsdVc2p4ShIvC5H6Vm6trk/af9xTcLbMvIgaHZQEyn7c6zL79tYTTpzL4W//0Wa
    0ykV/A4EwZvgPXX80OVtok5Lm15DK7Ay6gGv4KUWxANL0/0uj/ASF4+DO7CaNBziVaFL1Y
    QEqkD/oe2jWozyA54GCEgYdUIKePAvSGu5VfOyaagqjSRvQ/Me6amtB5o4d0pMLchUe0AX
    XQ0t9KW98rrZV9ix8a+DvWZWd5kTxUzQ09ZgN1dku6pWnne8LfeGZklRnl8JOdGxqU2wnv
    Dd40cwmZ3CnmGK9bLkVT5ODpf4MtnofPolRg7lWkhpizB2d6N29MP8Sqfh5Gpau107nR1p
    GznDdCWS4Cldd0EqU1NsA6e3rPBfgvg/Yrem6Ai1qYXBgfPzucnCT/l/qUGVeuBRBqpnax
    wsV8yqkHdy2AmIWYdFDLTlTyBY+AfK3CSwjmMFzhKgciDwznqK9MXwgE2QJN7H7XM9393R
    QDMU7EQDKQwIxW9Mk7Ein7t56uxTl2PAnKI1klcR6U7wcFUmv7JyYeQQK05Q
X-ME-Proxy: <xmx:Z-OyajsXmRCC4rYyLd_qRSs_cXMCBjVdOA4xC0rW1Qu2kPHzqBidQQ>
    <xmx:Z-OyatZjOBoh7IRjMgTN1G2V1nr7RDF6uCYfYZoI-RQeQnY7dnjLuw>
    <xmx:Z-OyaouxlA4Hb0aLxCm9UlqXSzyhuIHbyac3m-fV7Ji2ahCkIzg2TA>
    <xmx:Z-OyavEsi96HBSgaWhRKKfgdVXHixr5raNg0gs1lYbTXYavpghcGcw>
    <xmx:Z-OyaoRW0VZpkV_oqyRO35DCdukkJXg_gvoR4Wj-Cgdf3wc0ULHyTbKZ>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 16:21:59 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v6 3/3] t4010: modernize
Date: Tue, 22 Sep 2026 16:21:52 -0400
Message-ID: <20260922202152.842793-4-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922202152.842793-1-markchucarroll@fastmail.com>
References: <20260922202152.842793-1-markchucarroll@fastmail.com>
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
 t/t4010-diff-pathspec.sh | 122 +++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index c84c3fa05b..03b3023bee 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -13,67 +13,67 @@ Prepare:
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
+test_expect_success 'setup' '
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
+	: >expected
+'
+
+test_expect_success 'limit to path should show nothing' '
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

