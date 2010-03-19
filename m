From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/3] t5505: remove unnecessary subshell invocations
Date: Fri, 19 Mar 2010 18:36:34 -0500
Message-ID: <CxNG4R6Vr07DvPgqJe5msRW43WBM-kHscjWMfuzYM-XxJsVlLbOmNz_AdlMU4gEIvpsxQfdo7fc@cipher.nrlssc.navy.mil>
Cc: ilari.liusvaara@elisanet.fi, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 20 00:37:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nslkd-0004wq-A0
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 00:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab0CSXhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 19:37:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37909 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0CSXg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 19:36:59 -0400
Received: by mail.nrlssc.navy.mil id o2JNao7Y010275; Fri, 19 Mar 2010 18:36:50 -0500
X-OriginalArrivalTime: 19 Mar 2010 23:36:50.0028 (UTC) FILETIME=[0C299AC0:01CAC7BD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142660>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5505-remote.sh |   43 ++++---------------------------------------
 1 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a82c5ff..7291230 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -110,16 +110,17 @@ test_expect_success 'remove remote' '
 test_expect_success 'remove remote protects non-remote branches' '
 (
 	cd test &&
-	(cat >expect1 <<EOF
+	{ cat >expect1 <<EOF
 Note: A non-remote branch was not removed; to delete it, use:
   git branch -d master
 EOF
-    cat >expect2 <<EOF
+	} &&
+	{ cat >expect2 <<EOF
 Note: Non-remote branches were not removed; to delete them, use:
   git branch -d foobranch
   git branch -d master
 EOF
-) &&
+	} &&
 	git tag footag
 	git config --add remote.oops.fetch "+refs/*:refs/*" &&
 	git remote rm oops 2>actual1 &&
@@ -534,43 +535,34 @@ test_expect_success 'show empty remote' '
 '
 
 test_expect_success 'new remote' '
-(
 	git remote add someremote foo &&
 	echo foo >expect &&
 	git config --get-all remote.someremote.url >actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url bar' '
-(
 	git remote set-url someremote bar &&
 	echo bar >expect &&
 	git config --get-all remote.someremote.url >actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url baz bar' '
-(
 	git remote set-url someremote baz bar &&
 	echo baz >expect &&
 	git config --get-all remote.someremote.url >actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url zot bar' '
-(
 	test_must_fail git remote set-url someremote zot bar &&
 	echo baz >expect &&
 	git config --get-all remote.someremote.url >actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push zot baz' '
-(
 	test_must_fail git remote set-url --push someremote zot baz &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
@@ -578,11 +570,9 @@ test_expect_success 'remote set-url --push zot baz' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push zot' '
-(
 	git remote set-url --push someremote zot &&
 	echo zot >expect &&
 	echo "YYY" >>expect &&
@@ -591,11 +581,9 @@ test_expect_success 'remote set-url --push zot' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push qux zot' '
-(
 	git remote set-url --push someremote qux zot &&
 	echo qux >expect &&
 	echo "YYY" >>expect &&
@@ -604,11 +592,9 @@ test_expect_success 'remote set-url --push qux zot' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push foo qu+x' '
-(
 	git remote set-url --push someremote foo qu+x &&
 	echo foo >expect &&
 	echo "YYY" >>expect &&
@@ -617,11 +603,9 @@ test_expect_success 'remote set-url --push foo qu+x' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push --add aaa' '
-(
 	git remote set-url --push --add someremote aaa &&
 	echo foo >expect &&
 	echo aaa >>expect &&
@@ -631,11 +615,9 @@ test_expect_success 'remote set-url --push --add aaa' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push bar aaa' '
-(
 	git remote set-url --push someremote bar aaa &&
 	echo foo >expect &&
 	echo bar >>expect &&
@@ -645,11 +627,9 @@ test_expect_success 'remote set-url --push bar aaa' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push --delete bar' '
-(
 	git remote set-url --push --delete someremote bar &&
 	echo foo >expect &&
 	echo "YYY" >>expect &&
@@ -658,11 +638,9 @@ test_expect_success 'remote set-url --push --delete bar' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --push --delete foo' '
-(
 	git remote set-url --push --delete someremote foo &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
@@ -670,11 +648,9 @@ test_expect_success 'remote set-url --push --delete foo' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --add bbb' '
-(
 	git remote set-url --add someremote bbb &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
@@ -683,11 +659,9 @@ test_expect_success 'remote set-url --add bbb' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --delete .*' '
-(
 	test_must_fail git remote set-url --delete someremote .* &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
@@ -696,11 +670,9 @@ test_expect_success 'remote set-url --delete .*' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --delete bbb' '
-(
 	git remote set-url --delete someremote bbb &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
@@ -708,11 +680,9 @@ test_expect_success 'remote set-url --delete bbb' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --delete baz' '
-(
 	test_must_fail git remote set-url --delete someremote baz &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
@@ -720,11 +690,9 @@ test_expect_success 'remote set-url --delete baz' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --add ccc' '
-(
 	git remote set-url --add someremote ccc &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
@@ -733,11 +701,9 @@ test_expect_success 'remote set-url --add ccc' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_expect_success 'remote set-url --delete baz' '
-(
 	git remote set-url --delete someremote baz &&
 	echo "YYY" >expect &&
 	echo ccc >>expect &&
@@ -745,7 +711,6 @@ test_expect_success 'remote set-url --delete baz' '
 	echo "YYY" >>actual &&
 	git config --get-all remote.someremote.url >>actual &&
 	cmp expect actual
-)
 '
 
 test_done
-- 
1.6.6.2
