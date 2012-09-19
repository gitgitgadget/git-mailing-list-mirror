From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 2/6] Make 'not ok $count - $message' consistent with 'ok $count - $message'
Date: Wed, 19 Sep 2012 18:15:11 +0100
Message-ID: <1348074915-19985-3-git-send-email-git@adamspiers.org>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:15:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENsB-0001rP-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab2ISRPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:15:25 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:44889 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477Ab2ISRPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:15:20 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 2F1352E5DF;
	Wed, 19 Sep 2012 18:15:18 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348074915-19985-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205950>

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 4 ++--
 t/test-lib.sh    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 t/test-lib.sh

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ae6a3f0..c6b42de 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -167,13 +167,13 @@ test_expect_success 'tests clean up even on failures' "
 	! test -s err &&
 	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
 	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
-	> not ok - 1 tests clean up even after a failure
+	> not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
 	> #	test_when_finished rm clean-after-failure &&
 	> #	(exit 1)
 	> #	Z
-	> not ok - 2 failure to clean up causes the test to fail
+	> not ok 2 - failure to clean up causes the test to fail
 	> #	Z
 	> #	test_when_finished \"(exit 2)\"
 	> #	Z
diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100644
new mode 100755
index 426820e..5293830
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -270,7 +270,7 @@ test_ok_ () {
 
 test_failure_ () {
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok - $test_count $1"
+	say_color error "not ok $test_count - $1"
 	shift
 	echo "$@" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
-- 
1.7.12.147.g6d168f4
