Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221748E0DC
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896703; cv=none; b=pkplCrkKxK/8ykM5b2n5KB2TlFvRMEAl9IMxc91pR0AtAKGOwVueYG5p42YetuLIC10zE5vL5IZxCYUznrXiugkV9CYJ0XyWeZmNohAbqdn3ibVxMoBGDiyqQuzrmwCq2oS9LaJTeGOlCEyoc6lJHV6ABvYopIjNee1wiJjrqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896703; c=relaxed/simple;
	bh=OATzhZDKqJ14hD6q/YAw40YMvNZ3Yr1efhI3qfOorks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=beGG1V2gZHzgzt1bs6kwQmuK25OfJpqS/p/CoMleG4dQTR9ag6EdvYfz8huDV5G13aOIoDkbcvtwrdOYBiNTPUlvcH+cVZIg2oUk7kq8e400wGGBS7oQMzmlSaH86/SMF3dBb0bl+F9o7YLWIqCCThRgLExZscVKvtNYS05oIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO3DAWBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO3DAWBC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F6F9C2BCFA;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788896702;
	bh=OATzhZDKqJ14hD6q/YAw40YMvNZ3Yr1efhI3qfOorks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fO3DAWBCEbN2A+/Ygnr9QnwY75SEV298u9MyJmlwcseHpq7xQjmMl9zL2AjGvQxmc
	 Ae+6uCnRWlWMUOefH9sKwQMwI0jXCiGVWHl7/TeahHmPZ0XFcBqmK/5jhGxsnZHqiC
	 jMv3L818oqaWSbBhZX0AYZFmMP9s/9uuY2ol3hrKyHypHjG6z+y9kWbalmkelCDPoz
	 8NCsfcFaxmWXb0p3r+FPsFutUw6EtlJFUi9b4H4fMhKt2fayUkyE0+wCllfAWNKTEU
	 j2rEPLKt+AVPYmDdOY7xXqjBDWhcDR2ZFhT/2cjuzEzh96CCyWmP1Puj9Wmt5wZ3a9
	 FL422SbO+boig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C787C79F82;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Tue, 08 Sep 2026 15:44:53 -0400
Subject: [PATCH 1/3] Update t4001 to use modern syntax.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-modernize-t4001-v1-1-cab3933a173f@fastmail.com>
References: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
In-Reply-To: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=tYfimROY4pM4hcIs4mrY96uFgq+P8MDoIKlkcUrM5Jw=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIWpO7W2m265owa90T3lPVPFKvkMnWjax7cd3Rc/+L4r
 Eml4Qn8HaUsDGJcDLJiiiz//wk0vmJ5IOEX9O4TzBxWJpAhDFycAjCRpX8YGTb9YSicc0HuwG5n
 uXNKz1Qy9ee73Vi+jiPBSuCGoUNK62xGhispD857bGHe/85getSq3cdV5B58znplvXRG40+3tzl
 d59gB
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

---
 t/t4001-diff-rename.sh   | 31 ++++++++++++++++---------------
 t/t4009-diff-rename-4.sh |  8 ++++----
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index ad474100af..2aa161c217 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -88,28 +88,29 @@ test_expect_success 'setup' '
 	EOF
 '
 
-test_expect_success \
-    'update-index --add a file.' \
-    'git update-index --add path0'
+test_expect_success 'update-index --add a file.' '
+    git update-index --add path0
+'
 
-test_expect_success \
-    'write that tree.' \
-    'tree=$(git write-tree) && echo $tree'
+test_expect_success 'write that tree.' '
+    tree=$(git write-tree) && echo $tree
+'
 
 sed -e 's/line/Line/' <path0 >path1
 rm -f path0
-test_expect_success \
-    'renamed and edited the file.' \
-    'git update-index --add --remove path0 path1'
 
-test_expect_success \
-    'git diff-index -p -M after rename and editing.' \
-    'git diff-index -p -M $tree >current'
+test_expect_success 'renamed and edited the file.' '
+    git update-index --add --remove path0 path1
+'
+
+test_expect_success 'git diff-index -p -M after rename and editing.' '
+    git diff-index -p -M $tree >current
+'
 
 
-test_expect_success \
-    'validate the output.' \
-    'compare_diff_patch current expected'
+test_expect_success 'validate the output.' '
+    compare_diff_patch current expected
+'
 
 test_expect_success 'test diff.renames=true' '
 	git -c diff.renames=true diff --cached $tree >current &&
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 59e71e3acd..8f86dc7274 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -19,10 +19,10 @@ test_expect_success \
     tree=$(git write-tree) &&
     echo $tree'
 
-test_expect_success \
-    'prepare work tree' \
-    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+
+test_expect_success 'prepare work tree' '
+    sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+    sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
     rm -f COPYING &&
     c1=$(git hash-object COPYING.1) &&
     c2=$(git hash-object COPYING.2) &&

-- 
2.53.0


