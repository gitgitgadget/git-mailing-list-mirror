Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B7B1F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeBSL3p (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:45 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:54748 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeBSL3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:24 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdJeU69D; Mon, 19 Feb 2018 11:29:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039762;
        bh=/l5cDwCHv3tDgWuOMpzy+rhZkm5+78yX8qvXgWkmP/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=XaBDfkI+/mHDorw6SFhnp0vxieexO7hUuQLkJLFNeltGcfgLZJvpHH0RDdkB0NHOW
         0yOQbdwxsRf+bqotXNcTnc5sLvyDMg+MhWFDpBPslVviS+zwR+vqW0PgsUHS8cpB84
         480DTp4qr5L4Lmkg1Kuz0gcKefBOCGLAwLQUybTk=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=O1iWIr25U2cVnlaOALwA:9
 a=zdiJweklN5ucPckc:21 a=T_SJQFKzzivnNv3I:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/9] t3701: don't hard code sha1 hash values
Date:   Mon, 19 Feb 2018 11:29:05 +0000
Message-Id: <20180219112910.24471-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219112910.24471-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJW/nW9ld++aQnrejQl7lCNHezSaWN1MBPhfM0iCO6orvHTqX6U9pVwXOXJpT3HJtHixLtPIecfUv2gngZ4diRBNu7oRxHYPXuPAjVw6HJls0B/uB67l
 P4Wgnm99S5XTDnuHRyGyh3mZGWBot2Bx3aHelTbHsVRyE3Ngo+ZPj/aH09vUxfIlcJEirCq7TP7G60Pki1/HOEJ4nTKwoGP/yNkHx26PWBs0Sy+6FrIGr/8H
 ksS9GkRcCvmd8qc6mybWUVDuks+uJliwxg2YvsW50mtlUjGMLs2U0CN1xCeB/qlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Purge the index lines from diffs so we're not hard coding sha1 hash
values in the expected output.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3701-add-interactive.sh | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b73a9598ab3eaed074735e99f3dcbc8f88d86f4c..70748393f28c93f4bc5d43b07bd96bd208aba3e9 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -24,7 +24,6 @@ test_expect_success 'status works (initial)' '
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	new file mode 100644
-	index 0000000..d95f3ad
 	--- /dev/null
 	+++ b/file
 	@@ -0,0 +1 @@
@@ -34,7 +33,7 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
-	sed -ne "/new file/,/content/p" <output >diff &&
+	sed -ne /^index/d -e "/new file/,/content/p" <output >diff &&
 	test_cmp expected diff
 '
 test_expect_success 'revert works (initial)' '
@@ -60,7 +59,6 @@ test_expect_success 'status works (commit)' '
 
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
-	index 180b47c..b6f2c08 100644
 	--- a/file
 	+++ b/file
 	@@ -1 +1,2 @@
@@ -71,7 +69,7 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
-	sed -ne "/^index/,/content/p" <output >diff &&
+	sed -ne "/^---/,/content/p" <output >diff &&
 	test_cmp expected diff
 '
 test_expect_success 'revert works (commit)' '
@@ -90,7 +88,7 @@ test_expect_success 'setup expected' '
 test_expect_success 'dummy edit works' '
 	test_set_editor : &&
 	(echo e; echo a) | git add -p &&
-	git diff > diff &&
+	git diff | sed /^index/d >diff &&
 	test_cmp expected diff
 '
 
@@ -145,7 +143,6 @@ test_expect_success 'setup patch' '
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	diff --git a/file b/file
-	index b5dd6c9..f910ae9 100644
 	--- a/file
 	+++ b/file
 	@@ -1,4 +1,4 @@
@@ -159,7 +156,7 @@ test_expect_success 'setup expected' '
 
 test_expect_success 'real edit works' '
 	(echo e; echo n; echo d) | git add -p &&
-	git diff >output &&
+	git diff | sed /^index/d >output &&
 	test_cmp expected output
 '
 
@@ -168,10 +165,10 @@ test_expect_success 'skip files similarly as commit -a' '
 	echo file >.gitignore &&
 	echo changed >file &&
 	echo y | git add -p file &&
-	git diff >output &&
+	git diff | sed /^index/d >output &&
 	git reset &&
 	git commit -am commit &&
-	git diff >expected &&
+	git diff | sed /^index/d >expected &&
 	test_cmp expected output &&
 	git reset --hard HEAD^
 '
@@ -217,7 +214,6 @@ test_expect_success 'setup again' '
 # Write the patch file with a new line at the top and bottom
 test_expect_success 'setup patch' '
 	cat >patch <<-EOF
-	index 180b47c..b6f2c08 100644
 	--- a/file
 	+++ b/file
 	@@ -1,2 +1,4 @@
@@ -232,7 +228,6 @@ test_expect_success 'setup patch' '
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	diff --git a/file b/file
-	index b6f2c08..61b9053 100755
 	--- a/file
 	+++ b/file
 	@@ -1,2 +1,4 @@
@@ -248,15 +243,14 @@ test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	(echo s; echo y; echo y) | git add -p file &&
-	git diff --cached > diff &&
+	git diff --cached | sed /^index/d >diff &&
 	test_cmp expected diff
 '
 
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	diff --git a/non-empty b/non-empty
 	deleted file mode 100644
-	index d95f3ad..0000000
 	--- a/non-empty
 	+++ /dev/null
 	@@ -1 +0,0 @@
@@ -271,15 +265,14 @@ test_expect_success 'deleting a non-empty file' '
 	git commit -m non-empty &&
 	rm non-empty &&
 	echo y | git add -p non-empty &&
-	git diff --cached >diff &&
+	git diff --cached | sed /^index/d >diff &&
 	test_cmp expected diff
 '
 
 test_expect_success 'setup expected' '
 	cat >expected <<-EOF
 	diff --git a/empty b/empty
 	deleted file mode 100644
-	index e69de29..0000000
 	EOF
 '
 
@@ -290,7 +283,7 @@ test_expect_success 'deleting an empty file' '
 	git commit -m empty &&
 	rm empty &&
 	echo y | git add -p empty &&
-	git diff --cached >diff &&
+	git diff --cached | sed /^index/d >diff &&
 	test_cmp expected diff
 '
 
@@ -317,7 +310,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	#    exits.
 	printf "%s\n" s e     q n q q |
 	EDITOR=: git add -p &&
-	git diff >actual &&
+	git diff | sed /^index/d >actual &&
 	! grep "^+15" actual
 '
 
@@ -329,7 +322,7 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 	printf "%s\n" s n y e   q n q q |
 	EDITOR=: git add -p 2>error &&
 	test_must_be_empty error &&
-	git diff >actual &&
+	git diff | sed /^index/d >actual &&
 	! grep "^+31" actual
 '
 
@@ -348,14 +341,13 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	cat >expected <<-\EOF &&
 	* Unmerged path conflict.t
 	diff --git a/non-conflict.t b/non-conflict.t
-	index f766221..5ea2ed4 100644
 	--- a/non-conflict.t
 	+++ b/non-conflict.t
 	@@ -1 +1 @@
 	-non-conflict
 	+changed
 	EOF
-	git diff --cached >diff &&
+	git diff --cached | sed /^index/d >diff &&
 	test_cmp expected diff
 '
 
-- 
2.16.1

