Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7C48E0E9
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896703; cv=none; b=geAIGeGYG6pmBIH0PCCxuBwdMalmkcxMco0zkVhF5+S3c3cKD+gcWrK9KxwravtO8iYhlstsY+KLPN8v4/v3ewb5Te/5n+zo/E/4Wf4QLZB0lvCXsHU+ixluyzskPjRWuSLbIdeWMjGEnQr5pfRuJ0BaJmnHigPciyN7SHgI9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896703; c=relaxed/simple;
	bh=vj2Z9FWQ0t8k2PN9N9enOWxb3x0eBjILhYs6Ud/wRq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKcEBor2CyPHh8Zr3nOoljLv1PmQUsqRK93sPCOLIISosP5oMcF4p0Q6NzZSvqvMP9kSpCzVKJCqe0XlzfF3gIcMhg1uW7rhb1R7GS9uqV5970FXQAtTa9K79NMv4sRQsctXR0nNVA2kmNKs9F3jGVfbpzSY9b3XY8GF/VY2qEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUtsQ9VV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUtsQ9VV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8641AC2BCFD;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788896702;
	bh=vj2Z9FWQ0t8k2PN9N9enOWxb3x0eBjILhYs6Ud/wRq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GUtsQ9VViA2O4orHEgh3wa9Htst4jKmheIrwFTksL5tiX/prmZGmXw6kStjBMJZQn
	 bGsDb0ojcLY89Wr+m299aziNdHchrL5B3r2FfMdK9ktTPY3XYLU+UusO9zdobIwYJg
	 gVZbrNDWbbhxFbV01FGJ1MVBb6IcO6DENY+vXLmxjlwXvV3hoinYzXFB+3MYdb3w6u
	 EXaHehPAewo20Jh6M/b1/ZrGIm0IevorxjKft/AwurSOVtUxgvX0sMan+k0DzufHkS
	 RwJySaYj4Fv9vXIzqHcWadlOvqvjdRC+VMVSdLjkFJm3kXeTrCx9J66yVBGlMEgNKw
	 jFsRJXXwHpy+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ABBC79F99;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Tue, 08 Sep 2026 15:44:54 -0400
Subject: [PATCH 2/3] Update t4009 to use modern style.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-modernize-t4001-v1-2-cab3933a173f@fastmail.com>
References: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
In-Reply-To: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=xNAADiP1ADadN8yIjMs2daoM5SExxWFRw/MYta0bF8s=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIWpO6OfX/Q8kWdzCTnotSy9JYo6W2L3nf7Xnj0adOlF
 K9l2x2LOkpZGMS4GGTFFFn+/xNofMXyQMIv6N0nmDmsTCBDGLg4BWAiFQUM/+u1n5zk/zHldytn
 25yqxV+qr+8O71uVl/+otXeLZlLFvm6G/1UZwmvb697Xzfot/09k2a8HVfFn1m6MmfcybO2M/9l
 Jb3gA
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

---
 t/t4009-diff-rename-4.sh | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 8f86dc7274..198de5d039 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -10,15 +10,14 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    'prepare reference tree' \
-    'COPYING_test_data >COPYING &&
-     echo frotz >rezrov &&
+test_expect_success  'prepare reference tree' '
+    COPYING_test_data >COPYING &&
+    echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     orig=$(git hash-object COPYING) &&
     tree=$(git write-tree) &&
-    echo $tree'
-
+    echo $tree
+'
 
 test_expect_success 'prepare work tree' '
     sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
@@ -26,7 +25,8 @@ test_expect_success 'prepare work tree' '
     rm -f COPYING &&
     c1=$(git hash-object COPYING.1) &&
     c2=$(git hash-object COPYING.2) &&
-    git update-index --add --remove COPYING COPYING.?'
+    git update-index --add --remove COPYING COPYING.?
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
@@ -44,16 +44,16 @@ COPYING
 COPYING.2
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#1)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#1)' '
+    compare_diff_raw_z current expected
+'
 
 ################################################################
 
-test_expect_success \
-    'prepare work tree again' \
-    'mv COPYING.2 COPYING &&
-     git update-index --add --remove COPYING COPYING.1 COPYING.2'
+test_expect_success 'prepare work tree again' '
+    mv COPYING.2 COPYING &&
+    git update-index --add --remove COPYING COPYING.1 COPYING.2
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
@@ -69,9 +69,9 @@ COPYING
 COPYING.1
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#2)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#2)' '
+    compare_diff_raw_z current expected
+'
 
 ################################################################
 
@@ -80,10 +80,10 @@ test_expect_success \
 # anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
-test_expect_success \
-    'prepare work tree once again' \
-    'COPYING_test_data >COPYING &&
-     git update-index --add --remove COPYING COPYING.1'
+test_expect_success 'prepare work tree once again' '
+    COPYING_test_data >COPYING &&
+    git update-index --add --remove COPYING COPYING.1
+'
 
 git diff-index -z -C --find-copies-harder $tree >current
 cat >expected <<EOF
@@ -92,8 +92,8 @@ COPYING
 COPYING.1
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#3)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#3)' '
+    compare_diff_raw_z current expected
+'
 
 test_done

-- 
2.53.0


