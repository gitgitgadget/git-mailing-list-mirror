Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472F485922
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060075; cv=none; b=KCa6wPR2G4WDWtyy1r8roWJ+iv8b6IxBO/9bI5jY8UkEsKN4W6AW/7an2eD/vihASOhqaluhqKcyqBWKikqLIUQF/F1GJ1UMjagnaPBagt1BNw8qSqbiqaAUjlinahrbw3O9s/urzqUIcbDA5w2rKMtLgTJ/pfTD374RB2FbXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060075; c=relaxed/simple;
	bh=Zi1D+ns5SAiADhp4qv1vAsSH5p6KEAA7cbyvWg2p9LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiiWBJzKGceoCbgRA4rJ45dO7dfjqfLh2rYVI22QaBjgN+OnybkWHNmuPrR1vXiumNDjmpllTlN02d8CHt20nmW05flJaL1GJ5OPWOfytUcyx4Vopruk/6/4gmoXdy3UfOSttWH4bx/xa7E7muETR4vWNZlbf9Y5jX/8f0TCogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BitHwQvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BitHwQvH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 261B7C2BCF6;
	Thu, 10 Sep 2026 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789060072;
	bh=Zi1D+ns5SAiADhp4qv1vAsSH5p6KEAA7cbyvWg2p9LU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BitHwQvHMmdgRQSKM5NMyEfLPscc6PkZLt1ZSnaAft8UaPyhEW1Q3r6ujjJ86egOs
	 1Sbri/CswwfYCzemyeioMo08aDlVZ6iT1imu4Lo3MpeEdM4oKSKWNkhuEszkAP7SE1
	 v7dVvpqn68bEPeCpr+9dizI1cRxEJ5mLWVGcORD476ru+lbizkUUK8hRCH3/b8sP3I
	 pvACMiH8r4fx5jkEO0sYVFXypHZzi7tbAFcTGrn4Y3aWIJ/dKQhdbd+6Phi2BkBns9
	 /qYqHK6iwmf9nPt/pyudXvV/zo8z/cJN5AH05Zmr5Pa/7ULVbnruYJlvC1B0M6rVrL
	 20R5TjCmvUiFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B0C88E41;
	Thu, 10 Sep 2026 17:07:52 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Thu, 10 Sep 2026 13:07:34 -0400
Subject: [PATCH v2 2/3] Update t4009 to use modern style.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-modernize-t4001-v2-2-ac53e9f5d717@fastmail.com>
References: <20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com>
In-Reply-To: <20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4663;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=aHQJ31CmjPuMd+DSJIB+ax1Dys+pJ8v7p02yCjw4tnQ=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIWPX5q0FDLw5JXo1XMJSWmYHlKa8bNBcrd9e+uTlJMv
 G4QkTeho5SFQYyLQVZMkeX/P4HGVywPJPyC3n2CmcPKBDKEgYtTACZysonhD2evpfj0QJ3cWwe/
 fJYyOpwS/yX92izGiCtmmaybe/ZOs2b4zepw1rTj6v75h34w31n6fON+yQ69MMsrCtfnMfaevSv
 7ix0A
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

---
 t/t4009-diff-rename-4.sh | 113 ++++++++++++++++++++++-------------------------
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


