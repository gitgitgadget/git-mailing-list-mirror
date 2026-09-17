Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4264E36DA
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674889; cv=none; b=YsQRcgQfZYsEDdZNm55/L6dHcBpcBZLajaX1oJgSsv3jzpvjvjDnVpajkdrF+TWNIM4OjBD7d2qE7LFnMyy6ddmL+MqdrCKyI8TudUHYrHi35xi7yD0Kf81VBVlO1q1mAntyOkaxyGeFILhKse4rcdobNxZsV7usopPszmdyt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674889; c=relaxed/simple;
	bh=1NXzttsr/YESS7IAHCh0/TPKvjGaQFtEMAKUWSMRR1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHN96OOT7+7BA0fLBMffJhnnXESOkcBUPJPihJR76CRQV+F5Xq6ZZMTN9gKWZU80ZpUdDHxWsnR4ynAW3emLUb8BTQ9MOleqKDzTskbTk7zYm/lK3T7xecAmvwHx25mLTHUA3n5TQJNrA2+YzTHgXnSFrB03Hnmh2JpMEpAtVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Shb+c2Lm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MEN7khCZ; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Shb+c2Lm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MEN7khCZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 3919213801F3;
	Thu, 17 Sep 2026 15:54:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 17 Sep 2026 15:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1789674886; x=
	1789678486; bh=FhyQlL4emt8GW2aRJPvANUFSACxoQRtVlH/gSEsYUwA=; b=S
	hb+c2LmIE+T5IBRedwyk4h+2yBzAcQrMI0kxrNtVw66mOGG4ejYaom04Pc0A+XtK
	YzwazGAHtP9Ap6TZxc14EZTtKYYT19+AErTpywTgVd1bPWNPgDnEdaSK2crWIacW
	Rqg/HM8AkajJ9O77bmgC8H4G5hfEtdiT8f4ZWzq39QBGgF20BLLy+18eWGDNifd1
	GpQVm913Ct1C9jWjUvq521ucwuzXXV7tGr+O8y8mt8dp8uYw9NKc9zAl7VsgtbYF
	RsVwfn02kppjxp2izt5NkpyAaFA7z4E69VlpO5HE8vzPUkcH6+kGVimV/uOQHCGn
	2BsmXV8SP4ZW0Mkxjm5bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789674886; x=1789678486; bh=F
	hyQlL4emt8GW2aRJPvANUFSACxoQRtVlH/gSEsYUwA=; b=MEN7khCZlLoEzSITC
	CYpE/VfsIGIK55HLj9KlDfckVGElfzvAPJ3or/u9IgoThzPgoy+OIhGKqwOMuJlT
	uV6NWTO728DVB7mRZbEKtGE/6qF4OdPGyhLfEN9EQZcw2KUUzDQFFN3s+RSZKexR
	tiLDqIPrt0lkpGPiXuAf4OK7da+/K3C8efy2l2woyJDRaID5ZSVlVe5XWmdMz5OE
	ChYbgikeAA12n15W0ICMBQ4pXaHEZT87S6ISZnrhxpDGwe4vyJMlHPi2hmXr5fqU
	HuvVA1Z4HPVIKhO8Cc/AKgYUNojkygOv7KXOf3WlB6936K7a0otkIjKDLB/QeXLm
	G3BAw==
X-ME-Sender: <xms:hkWsarWKXjb44GcnUZIQtD1tVbJOvG_drt_gflrNH724p4GTFvfQNA>
    <xme:hkWsaplMT8Rsey1NMzCmPGCH57Y9qlG4IuwbVqa0O3JOQW50Sx_mFpUbXy9i_uJEy
    sLUFwH1yXfvUjqTXgl_GmNIt8E1UUMB8hWjCMyNxGdIkmoeYSUrE55b>
X-ME-Received: <xmr:hkWsalAJ6lM47Fil5ECBCfwOlUaMWnBm1vyWCfet1CIx3PrZO7hB7fKDRuUPADQLodXfdtLnlj67Ser1qMNfBgEvom1bs0e5Ka_OpXmd8ZlOCw>
X-ME-Proxy-Cause: dmFkZTFd5n3QdA6V/1Qo+bttjxkXarVLag2WIyBugSx2ET6iok0cG48E4NJogkx1Fmgdip
    S6pllqJ0q3lPE/Mrm86OjM8LsHMstLXle5G3cB3wikwlf4++mkRO4z7/yGGb8vhtFIScpf
    52i6whuu1Z5uBKxoLUMUsfjwfWPa/3ieIU1WnkNwQnPe3a/xUrrIU3sG8EbwHsl8FHrx31
    7ABHMGfS+OmyS58TXOwVIOHAW5FqKmH8KDwPRnRlA7ESi97ufzwqP5vUs9duGLdP7VUh2M
    q+uQSZqZeiNQkpjeNSla1JJZkhWyNATPZTGnQE8TimAykwkS8cRJ9GsI9EJuZT6mxsFLVi
    Pemv26FyqY9aKLunfAjQXnoCZ1p+fKP+NK/XG+C5b+mugEUxis1Xvv4a4G+efIbK/sPWZx
    6eE2d/IZN42te3Tvd+ZZn/29EZHDxGqOOu8AYok1gP9rfMxYzsKpi1OsS/+G7LgYWcbXaJ
    5pT1cxVxMdp7trlqlPn4iUGwOM/KiF+1xNfqHc7d6lCuv4GJ8qkAzohFWSB4XyNRq8kQuy
    ZsDbc0pOpT14NPx1ugEgr6FocmAtQk5Lb/x7N9sbqmOW0hj2P3D5jGR7PA5sitY9ktLitN
    vBWBv6tJPWNUFqO1GLd2AKTjlBu7H9PCfjf/tK7A4D7io4X12UbASRNeSfXQ
X-ME-Proxy: <xmx:hkWsahcgnhxc6GMV4gm4gTlKJXCM3owWQyHetJ3jm-KssCJ15s_FMQ>
    <xmx:hkWsaoLRIrEfWUhtHVoK72KoCv6mpZmtm1Tdj0baVweeyJF5ey7r0w>
    <xmx:hkWsasfrfTHbg8daFce6V4JeU7inF5LfCShUhbV0SEpihaK3zTVAEw>
    <xmx:hkWsan3gev1ZAxsLe-gPhOfejVAbsRMKd3mzEB-xYvao7pnnXoMGYg>
    <xmx:hkWsakADZsPTFfrL6MpG17RmaIQGi_ltTydTDSn3lEOADWl6eN1beiP8>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 15:54:45 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v3 2/3] Update t/t4009-diff-rename-4 to use modern style.
Date: Thu, 17 Sep 2026 15:54:35 -0400
Message-ID: <20260917195436.1102981-3-markchucarroll@fastmail.com>
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
update t4009 to the modern style.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4009-diff-rename-4.sh | 113 +++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 59 deletions(-)

diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 198de5d039..7a48a7011c 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -10,67 +10,64 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success  'prepare reference tree' '
+
+
+test_expect_success 'validate output from rename/copy detection (#1)' '
+    # prepare reference tree
     COPYING_test_data >COPYING &&
     echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     orig=$(git hash-object COPYING) &&
     tree=$(git write-tree) &&
-    echo $tree
-'
-
-test_expect_success 'prepare work tree' '
+    echo $tree &&
+    # prepare work tree
     sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
     sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
     rm -f COPYING &&
     c1=$(git hash-object COPYING.1) &&
     c2=$(git hash-object COPYING.2) &&
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
-test_expect_success 'validate output from rename/copy detection (#1)' '
-    compare_diff_raw_z current expected
+	git update-index --add --remove COPYING COPYING.? &&
+
+	# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
+	# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+	# and COPYING.2 are based on COPYING, and do not say anything about
+	# rezrov.
+
+    cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	:100644 100644 $orig $c2 R1234
+	COPYING
+	COPYING.2
+	EOF
+
+    git diff-index -z -C $tree >actual &&
+    compare_diff_raw_z actual expect
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
+    # prepare work tree again
+    mv COPYING.2 COPYING &&
+    git update-index --add --remove COPYING COPYING.1 COPYING.2 &&
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
+    compare_diff_raw_z actual expect
 '
 
 ################################################################
@@ -80,20 +77,18 @@ test_expect_success 'validate output from rename/copy detection (#2)' '
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
+    # prepare work tree once again
+    COPYING_test_data >COPYING &&
+    git update-index --add --remove COPYING COPYING.1 &&
+    git diff-index -z -C --find-copies-harder $tree >actual &&
+    cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	EOF
+
+    compare_diff_raw_z actual expect
 '
 
 test_done
-- 
2.53.0

