Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826405013DF
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751940; cv=none; b=sLRDptMndGgtc2zGyXY4hC0a5BaO5roiW9qfxyFR8GWGJMc8dQINpAyFEsHpUNkXT7G+J2VhxDURiLXr69ExXSP6FJ5Y5BdBENslCqAjvktWMdHVdxByRe9Yt2mKhanmzBnc+LH8i3wgLVJFyF+u7b7013Oe/QYZjH5oNDP7xI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751940; c=relaxed/simple;
	bh=rOb5dYVJDwxhnWBmpshDpeCHTkWSNEswlcdnikH+F3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xw42bm3IqkoTgQMJrC2fdhvGm3wZqwdSOjya57AAu/egL1Bm3SH1Df9NVUjze3UYsCehY/xLC9AlirolZ1H35AqAAayC6OLDJYFMrc1q0t9MrZwpCY3387Vu1chZi8GeCe3hoAse2vLDRziVsgWsdCBYNkLHmRcAROfmOKzqGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HpA3Ag3P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlJ/7nfA; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HpA3Ag3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlJ/7nfA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id BD3F1130027E;
	Fri, 18 Sep 2026 13:18:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 18 Sep 2026 13:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1789751937; x=
	1789755537; bh=JpK9S2QJC35Itp+P41eSO2Cjf303se77sqL1HHOZhFc=; b=H
	pA3Ag3P3MWoVuVjlZnyBfOa2fGThtJPoUIix8s/qMjeI42Z6fqx0S+WSKVQMe+/2
	taXkUzH1i4jmLiuMjDfr7dJDqi8XlN72tenqbvTBcJYTKB5tkprzThJv5c8XyOji
	sR5pJSKy6YinRCcY1zOo70+bXrFIM0xAoF+5PdiQY/p4nWguQF7wQEy9Ra3k/bc3
	MXw40st2SBznWOJI1CheRbKvER2Ad9e5HbUNPInaD0OWhEhhhVA16yLke397UV9m
	NrXDwvf3oXcoBgWd5yoQCh56qGHbim4Rm3Bp/EHTafVxvR2xKIK3SF0mwotmg6pf
	27JCirC8wk8HdxwTPIugQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789751937; x=1789755537; bh=J
	pK9S2QJC35Itp+P41eSO2Cjf303se77sqL1HHOZhFc=; b=HlJ/7nfAEC1+AUm+g
	/n4f7x/E+wnhl41CrIOhWMHWbzYKZS8d9t60ON/stIekG75D/a/UOxPjvg6wB6oX
	RXEotCXskHENHk1EpVtctD21JW6jOyROFV7ksTwI2sy7I8Z7Mo4NM8PTRoaEvZ6o
	jyMnIKourv2XQ6Rfva78ddDP50VQNC3V6vvdn4fZqi/J/jdbYGjibsl94goRG+2a
	dTgtBLIezWJE0yxGpyd7Ns9tdoS/rmqaWOJKg4zhCS3veAk9uWtPeCXmU3NQL2Gd
	tXVG/b7AANkuO7gqxcP0vu+h0p5zQmA7W3yyU1S+VbPvIWjOJ0Mx6br6eyBpFSvP
	JQKzQ==
X-ME-Sender: <xms:gXKtavr1J9hLKL3ux3MoyiuU04gprq3AEXxaUxLlMSLy_pI1QU9Wbg>
    <xme:gXKtavr2DVejzJUtRoq3CBmexM5ANnBFIc8mokh6jNLFL341CfHQ6yceVU9EguAtn
    bz1lWbyavTpHUmTEHgSgWYlhbUSsDO-CsOH2SyJFUdxaB9JcSQKbOPC>
X-ME-Received: <xmr:gXKtap26l0uG55eJtTS4IbthMnql85I3EBVgPgFgoz8mKq9w7BW7cN-Xhnv4_d_bXxNI43SzmpiYOdm3IhgnQSisBrvUWATA9ukKx75Onk61zA>
X-ME-Proxy-Cause: dmFkZTGSm/Sx6JqmBiK2EmU/sXENm1X7hzGoBZoamrrBqmwe/9mnZPS30pHjqMzN2N9StX
    bkE5p+/SCCFaDu/f6H/G+I9OoJmmi711bctQVDIPGQ+wn1G9eRRgPp1rD3FvXKo1g07VRm
    wqivqu/mh+invTF/hnVRicExtE2EHXOAZdweRn9xRrXuOkIX1EAYejC51OWu80pPY8ftHs
    zByHO+RJ+8BkeAHGUeytcSDMaVm3uelbJcKpluUOw0wBzx3V/WcI2Ti/fRo11DQ1LFQcHx
    pN8CziddeDaJo6CTQLeKy6e9qQLAtrknzUaQhruAHiK6Q1kLxmq6AX1ehUm7vsyM/RUQh0
    4muDmu8MABJOhWQAQJ71uSzxf1u91vLv0HC/+i9ixGJZRRymMMXOrL1cRzxVjqINHdDECm
    OeInDsddcGUaY6vGO1qodX9s+nBTIF4t1slf+PUwGmrablYOgGyzw94Mug77bLiBUN8v3r
    zQRdnN11ty+w4kT6WyCRlyzclKaauL5FIA9qtHy7N6WOZ4pZCTdaGYxUp/gn8hRO/RAaEG
    y78f/LTJzdsrswOzhEgAMOtJs1L+3uAzu3vDV598QMl+X0JO4bjtHYponUDIiV8w7DV30j
    bRnu626kSE8ISRTqk0pVO72uCkyOQDlENCrJKJ8LIdaUyl3W851zIJ4nbveg
X-ME-Proxy: <xmx:gXKtauDL2dewa5S3-fTTNjMJ0JDa6szqVo4g-QD_qKz8qoCOdzKMNA>
    <xmx:gXKtaheMLbENlQGpdH5T9Y-7W5FMvEzy9vvVAW3cbCwbMBsC3Xyuig>
    <xmx:gXKtajg7DRF6Y1cUD8DW4gFqkZdV0Rm5ec9s6DnMblSXpPf-XjE0Ww>
    <xmx:gXKtapo5Cym6223h4HuiyK7h-3-8AsWPaK76zBlLBN9ouNQM58zS1w>
    <xmx:gXKtahG2c6eS8Xef4vtbmiM8R9sjzisb1Sno1MDx7KZSYYfmPA_sJ3H7>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 13:18:57 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v4 3/3] t4010: modernize
Date: Fri, 18 Sep 2026 13:18:47 -0400
Message-ID: <20260918171847.2670739-4-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918171847.2670739-1-markchucarroll@fastmail.com>
References: <20260918171847.2670739-1-markchucarroll@fastmail.com>
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

