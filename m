Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5B511194
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751938; cv=none; b=iGmMf55AWYW1N+jtnQy/6IznkpQAjm74chVT74i5x8ESMK7bb/4jaX4sZHNxatcnH1leKK7HVI0+wPfySj4sryy2Pp5HzH+J6nbSvOpn6I95ECTsCrTdGrxrM7orSegdOmvsK8vPtDZRbsT5gDHH+xTULQOuFY56s3dZaPNUr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751938; c=relaxed/simple;
	bh=8ex8Ba0bx2gehdpEJBIrY9S7IhshU+JBTLU2FIPEF2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbVMAwjk2cQhDfh0z6vWatdKjdj//aKnkdYT+KmtH51I19F4LQI99ruHWMt+2KaZibKnQnYSr0FClA4EV688Y4cD115gxoB+CfTHLx6sI1+R7HgWFeYdlWYlLrhcYbAI0C+IDY2TBlioSIe1wYzHUG260PJK8uM7381IsR8iYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b5/piRuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+LhYc6H; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b5/piRuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+LhYc6H"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 2935A1300278;
	Fri, 18 Sep 2026 13:18:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 18 Sep 2026 13:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1789751936; x=
	1789755536; bh=sWNFtLG8e3n7dXIiIrigSB1f1BRT6zV5Z6CiuU9BADU=; b=b
	5/piRuXDs2BeY9wkgOdgIhIDKMqKjpAq4o6p7y9t4ExYKt7lAWUrOBFh5QiyiaT9
	XUWIuddGiR7Sb/fEk0dTz5kCeuU5bFI1OYBT8582J2F90fuUP9aCzpGSLxn1aXBU
	mT9SM8QEbRDVJRsjt7PlbCIjVocysPsCL0yHNjG0Forv8hHuWPtG+mNKuvf6ckVC
	2Q2S6THNWoh3F1uEKhuc8N6A2c1Mr5OEzTcWZlF5mx/X+dcZj/c+QNKlzkAt9/n4
	q7EmqYTAXynj40KvKGGL0NAVASyEJwNE5ohJXF7TAJWw1r5TkQYGzhkPxeAxgjxA
	9tCK8EYJyZdTQOZNWGGvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789751936; x=1789755536; bh=s
	WNFtLG8e3n7dXIiIrigSB1f1BRT6zV5Z6CiuU9BADU=; b=W+LhYc6Hvxz1WztmX
	+Du9vcwsiuFWhAZvXxhxtaKnH4makR0hTKc52EhJp5M2BvkPmbOYZ/zufRwa3BBq
	Twm5ImiDO2FNzTc1TjAgbRrHyVQjy21DmPMvRQJUahyMG7Os1s+RbewjH3T7zNSl
	caWbE+r3dLlbQPxFhq8aiCf05bl52f9oZrq8y4X1LFyC3li42oyHT7OLtDONCWZv
	Zkxthvwp3k38DuTtmI6kK15Gqr7TANwKPTLxex479Wbhnkq7/1eYbrItKHUPEjqg
	kt2pR1xlSMYTHDZUS/AArneY9EYVRAU1y5b2fB7yGv4V/pF3vro468D5KA5mTCl6
	6/7Cg==
X-ME-Sender: <xms:f3KtakZn472HKVSTP3ahEuWMjRnpU69DI8AuF_RfspEMbtNbSRIaqg>
    <xme:f3KtalZ8t-nEUBgFy17utytYWlxyMAlr10oBxI1CTqi6QZlgAtFC_Gi9L4xuun9ZS
    79ER5F840COJLrY20pp55kyI2b1gYzkankOr0zyZ_rjFH6X1E1yTbHO>
X-ME-Received: <xmr:f3KtaskqZsQL9KY-nxM-SuMVV0gnKshittrGlefn77Nzu1cRkNz7Y2kpV9fHCer4tIp_rN7nvo_-ItS1Mxmrm0bCBLqnGJOm2GDJg4hzKghtHA>
X-ME-Proxy-Cause: dmFkZTGmPTOGm99l02Hig6CYd3+V4H+UU3rFiUYklZHnfcmDoG4wv30i20PxVboKfblbPN
    ZwgIP0sCDCf84gSs5itRv9GE9Mcf0FatjYZ7fuVPe6IOtO1jLKcxeYyX1IYPBYXxRNUCed
    ySozJV4qlmC6Trzd38rUNy26VdSO0x0GoVINZRXOhizA8zklXQIBqQkh0HmAQKtdNtDXEx
    fK5WnLr8KMWbdhd5+U9kayg4o2SeOjsvH9nCWocQPEhu3bka4G2mgBiYLyw2w/u187dAqw
    lDn2quWrGavE6/YA6OfrcaX+/6jwG32BFkG6cXsw9WDV3v3Z28DMgOTngE6MGk9djFnwQU
    WR5aNO+FjI0Jfu7HwsEc1cP3dBg6VWoZ9CcmssvZOGu34SPK6+xz43WEdstxjSLN5iZgnV
    m2L0NPxVYRQ7OZ8D92aOP1vKUT7jrJCO22vHrcxXc2EWreojtAK1u45LWKdDEb2uLVVWBU
    GmsXb8ptjwcTx2R/KaBl7OB+oLsN+pFH9K0N19evW1GFral5N6cwBdhDk1QsBeNbp8oqtV
    UacJfqbvlNQx62CMtw/uKJLooyCMkiDuc4x7Wq7/XUo5zMxwDEzwuE6MPjMf/QRxJbT5RX
    lx0RaAhK+eTGWomA+qAnz++WEJxBCwJNHj5nOoj2Ta06G7HsI3D5jBkTCIaA
X-ME-Proxy: <xmx:f3KtapwWF1HU-2LjItRFG9dhWPl2avvvzhQcs881247byHxnN7fZ9A>
    <xmx:f3KtaiNGu04hWAys_GMp-sJHQkQdtTpBkwFwGZdfjTpY4LqFojTqBg>
    <xmx:f3KtalQ6nGarE2oP-wiFN3-gMdUEpUbGDJMiT9T6xM4tCxWhELeQ9g>
    <xmx:f3KtaoYA8YUnaoQO8kIxm1nyn68QHzOP0ob2mF2vhtioddhrq55l2Q>
    <xmx:f3Ktaq3b79Y1dmwUoney7cMmfGtQsGVogoo3KuSOCTb4Q0QSgdP3_zs->
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 13:18:55 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v4 2/3] t4009: modernize
Date: Fri, 18 Sep 2026 13:18:46 -0400
Message-ID: <20260918171847.2670739-3-markchucarroll@fastmail.com>
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
update t4009 to the modern style.

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
 t/t4009-diff-rename-4.sh | 126 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 66 deletions(-)

diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 198de5d039..e42891ee5a 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -10,67 +10,63 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success  'prepare reference tree' '
-    COPYING_test_data >COPYING &&
-    echo frotz >rezrov &&
-    git update-index --add COPYING rezrov &&
-    orig=$(git hash-object COPYING) &&
-    tree=$(git write-tree) &&
-    echo $tree
+test_expect_success 'setup' '
+	# prepare reference tree
+	COPYING_test_data >COPYING &&
+	echo frotz >rezrov &&
+	git update-index --add COPYING rezrov &&
+	orig=$(git hash-object COPYING) &&
+	tree=$(git write-tree) &&
+	echo $tree &&
+	# prepare work tree
+	sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+	sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
+	rm -f COPYING &&
+	c1=$(git hash-object COPYING.1) &&
+	c2=$(git hash-object COPYING.2) &&
+	git update-index --add --remove COPYING COPYING.?
 '
 
-test_expect_success 'prepare work tree' '
-    sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
-    sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
-    rm -f COPYING &&
-    c1=$(git hash-object COPYING.1) &&
-    c2=$(git hash-object COPYING.2) &&
-    git update-index --add --remove COPYING COPYING.?
-'
-
-# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
-# both are slightly edited, and unchanged rezrov.  We say COPYING.1
-# and COPYING.2 are based on COPYING, and do not say anything about
-# rezrov.
-
-git diff-index -z -C $tree >current
-
-cat >expected <<EOF
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-:100644 100644 $orig $c2 R1234
-COPYING
-COPYING.2
-EOF
-
 test_expect_success 'validate output from rename/copy detection (#1)' '
-    compare_diff_raw_z current expected
+	# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
+	# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+	# and COPYING.2 are based on COPYING, and do not say anything about
+	# rezrov.
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	:100644 100644 $orig $c2 R1234
+	COPYING
+	COPYING.2
+	EOF
+
+	git diff-index -z -C $tree >actual &&
+	compare_diff_raw_z actual expect
 '
 
 ################################################################
 
-test_expect_success 'prepare work tree again' '
-    mv COPYING.2 COPYING &&
-    git update-index --add --remove COPYING COPYING.1 COPYING.2
-'
-
-# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
-# both are slightly edited, and unchanged rezrov.  We say COPYING.1
-# is based on COPYING and COPYING is still there, and do not say anything
-# about rezrov.
-
-git diff-index -z -C $tree >current
-cat >expected <<EOF
-:100644 100644 $orig $c2 M
-COPYING
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-EOF
-
 test_expect_success 'validate output from rename/copy detection (#2)' '
-    compare_diff_raw_z current expected
+	# prepare work tree again
+	mv COPYING.2 COPYING &&
+	git update-index --add --remove COPYING COPYING.1 COPYING.2 &&
+
+	# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
+	# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+	# is based on COPYING and COPYING is still there, and do not say anything
+	# about rezrov.
+
+	git diff-index -z -C $tree >actual &&
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c2 M
+	COPYING
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	EOF
+
+	compare_diff_raw_z actual expect
 '
 
 ################################################################
@@ -80,20 +76,18 @@ test_expect_success 'validate output from rename/copy detection (#2)' '
 # anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
-test_expect_success 'prepare work tree once again' '
-    COPYING_test_data >COPYING &&
-    git update-index --add --remove COPYING COPYING.1
-'
-
-git diff-index -z -C --find-copies-harder $tree >current
-cat >expected <<EOF
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-EOF
-
 test_expect_success 'validate output from rename/copy detection (#3)' '
-    compare_diff_raw_z current expected
+	# prepare work tree once again
+	COPYING_test_data >COPYING &&
+	git update-index --add --remove COPYING COPYING.1 &&
+	git diff-index -z -C --find-copies-harder $tree >actual &&
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	EOF
+
+	compare_diff_raw_z actual expect
 '
 
 test_done
-- 
2.53.0

