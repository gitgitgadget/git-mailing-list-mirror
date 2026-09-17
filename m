Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B44E4C56
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674890; cv=none; b=YKkBRI2SIZktMt2C088/yrEwF4QDcq07c2aG5pS7FikKsXS7XFcMsgH8i8oVSN+TZ8oU4lFkXVeKLuATdzktQr7iUNlPkbQZVg2K+MxeoYPN9QuY4VSy8gRCHi7tknwtpjiXKarHYk/Rgttnvh838Gl+xxGLi6XZ2DXxMaRuQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674890; c=relaxed/simple;
	bh=S5cJNWh1p3YTYiRr7l9l3EWUgI7oDGGVPwGRWeXvbho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQTTsRBMp/8yhO/XYDxz4PwOQPlu4BQ81RZXR/8VQfU3rDIplbv2Acykhvgn53yJ1RN5FWd0eXFIOqGs+xojxmPZ2+vIt48TgX6RzrHIpKs1Uud36nm3/OKgymhzxf6svV4lRnrzXk55Ayq5nMR441b2lQJ91U6W7BWtgAT1beU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tnsq10m2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doWDzwCF; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tnsq10m2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doWDzwCF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 7FC3C13801FE;
	Thu, 17 Sep 2026 15:54:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 17 Sep 2026 15:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1789674887; x=
	1789678487; bh=6Sj9MyPUKrGBwNUXWefZ/GrOLo2OKiloS8b1itdh89w=; b=T
	nsq10m2FdsUYMI45/yDhBH2VxudGCVraLeU/mu87pZEwrQSeGW4lRvgfYOjZd2TX
	eSvHNN84p29Sb2ALRREHy3P/tExA+UjOWqACzqBAIYxBvVjhSMzQMmXJ5C8YFTpk
	AE29IMlUOsbza1xYjU4Cnwo3uwKBZP3kUfU860nEf5RPYbkbdZHBQH91cGnuQ/Kt
	wkaUEg0GZpcGhqf8IaZ5QdJz1SpKjYFPQb1z7fYGePbB2OP+dzGTfiZUbhkcYxl6
	qZC7MI3z2g2vKTI82YTk6xMBl2GEA2NIwKa69agux2n8TjdpY1X98bVVE8WiOn1m
	l1DwJwUa1hJeAS6Aupy0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789674887; x=1789678487; bh=6
	Sj9MyPUKrGBwNUXWefZ/GrOLo2OKiloS8b1itdh89w=; b=doWDzwCFZwWC2wyKS
	N2DUwNeKXDgaMM6Ekk8aYSOI0NQlnB6Im/fwbLACQeh1i9jnapveEHjJJQy77J20
	FpkWmnaOYLSvSPVbDxxIxS0QuoFyw7tAojJnBDrY+5uZKPbe4Bo3guZQG3VgN3dF
	cxxq9+j3GenqaybHlFn2Zk0TObuKJihsMDZIIzYqTOSLAKmRHYFbfu1QhTKRr2IK
	gisADtsf77CUFW/+Z8ub+v8g5LmN/AVsHRQTcQhXsLbcAZQixKBExy5BNV76lMWC
	HRzhNCM/Elj4ZVK4LcVP8D9bcHdnm8OVL7C4I1aIn61zTPhbxa9XRyBkNzUrCEOY
	qkTaA==
X-ME-Sender: <xms:h0Wsan4NNTl3u6DhzyIcM-guZUVmaK-j6cjarDqF7e9XPeRncXakbA>
    <xme:h0Wsai6ScZKk-gPCPDHsYc3KpXO9iu5dIw_0VYY-6mur_hJtqtSUYYU6DhYt3XMm7
    tnaeK9YWgRAsi548hwxvmYijMgxL_BvF4-6dQKcfEqjyFLh9LD7IzwG>
X-ME-Received: <xmr:h0WsasGHYT7POnx56oSGLYB4kAe5RTawCcBjCqAocKMVXJicMwy9jO572K52Vt40BoWw3UpPjCzuGOt41gGvEsci7gj-zEEjVjI2Qge51vj2TQ>
X-ME-Proxy-Cause: dmFkZTFd5n3QdA6V/1Qo+bttjxkXarVLag2WIyBugSx2ET6iok0cG48E4NJogkx1Fmgdip
    S6pllqJ0q3lPE/Mrm86OjM8LsHMstLXle5G3cB3wikwlf4++mkRO4z7/yGGb8vhtFIScpf
    52i6whuu1Z5uBKxoLUMUsfjwfWPa/3ieIU1WnkNwQnPe3a/xUrrIU3sG8EbwHsl8FHrx31
    7ABHMGfS+OmyS58TXOwVIOHAW5FqKmH8KDwPRnRlA7ESi97ufzwqP5vUs9duGLdP7VUh2M
    q+uQSZqZeiNQkpjeNSla1JJZkhWyNATPZTGnQE8TimAykwkS8cRJ9GsI9EJuZT6mxsFLbT
    qDM6/on/MRBokyz9mR4lOOLsyUy2B8aUfU4aZir2WhhScZuF0ropPqLZ6DlnkYPvixTLYA
    BI+TGP71dw/YqNIoan7mKYtgqUmoSWKEUiU3khkEcHo7DVTv5Wpar5YT514rF8N2rFOOL8
    xpWVspxRBrIXUi5tSmnMn4KLNAaisJtTPbSHKzRtopobVKI0Hf2WfvrlSYFMUg5TNp080c
    PKcTiphXKUOut+VpIDNOCWfvmcDFkk3xBQAXra8n8cv6niwrwDGRCjdBFaeeTHLR1cSD4W
    jLL4a5eksDAPUyV/2d9lT8UvC4Ok2Hmu0i15MF8bqJrbno/HfxzxXz3xuZFQ
X-ME-Proxy: <xmx:h0WsajR8RNuJaQCAX8MSu1QPM9a1cYoXM-NMSDbJAK44oDv2Uh2GSQ>
    <xmx:h0WsatsXdmUh_b5nJe9G_uBwvhcxEaCe7p4sbx6hA30HvUC8wK86iw>
    <xmx:h0WsaqzVMtIbMZ-FJnFUUxJ7js5izuv2gGAXTeIgWorREVJXlsQCNQ>
    <xmx:h0Wsav40wilIfQ4XUsoj9uSNQMYRejvE_gxT0EPUEtvdKOjkjsAVtQ>
    <xmx:h0WsagXQNb4OKFfbBxlXF3gPosfbuFMXJUHeobcDtUmkDlUyWyOu0koa>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 15:54:47 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v3 3/3] Update t/t4010-diff-pathspec.sh to modern style.
Date: Thu, 17 Sep 2026 15:54:36 -0400
Message-ID: <20260917195436.1102981-4-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917195436.1102981-1-markchucarroll@fastmail.com>
References: <20260917195436.1102981-1-markchucarroll@fastmail.com>
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

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4010-diff-pathspec.sh | 121 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index c84c3fa05b..76ddd3ff4e 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -13,67 +13,66 @@ Prepare:
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
+	echo "$tree" &&
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
+    : >expected &&
+	git diff-index --cached $tree -- file0/ >current &&
+	compare_diff_raw current expected
+'
 
 test_expect_success 'diff-tree pathspec' '
 	tree2=$(git write-tree) &&
-- 
2.53.0

