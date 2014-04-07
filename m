From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/27] t1400: add some more tests involving quoted arguments
Date: Mon,  7 Apr 2014 15:47:55 +0200
Message-ID: <1396878498-19887-5-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:48:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9uu-0002aQ-S7
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbaDGNsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50781 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755339AbaDGNsc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:32 -0400
X-AuditID: 1207440c-f79656d000003eba-76-5342acaf8112
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id AF.25.16058.FACA2435; Mon,  7 Apr 2014 09:48:31 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaB026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:29 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLt+jVOwweZmVYud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8bDBw3sBWv4K45vuMLawHiAp4uRk0NCwETi+OcL
	rBC2mMSFe+vZQGwhgcuMEptnu3UxcgHZx5gkjm5cD1bEJqArsainmQnEFhFQk5jYdogFpIhZ
	4AqjxJWP21lAEsIC/hIbZ0wDm8QioCpxZtV1ZhCbV8BF4srdSWwQ2+QkTh6bDDaUU8BVYsah
	W4wQm10k7q85xjKBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJDQ
	49nB+G2dzCFGAQ5GJR7eFYccg4VYE8uKK3MPMUpyMCmJ8j5f5hQsxJeUn1KZkVicEV9UmpNa
	fIhRgoNZSYSXazVQjjclsbIqtSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1ILUIJivDwaEkwWsN
	0ihYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPio34YmB0gKR4gPY+XQWyt7ggMRco
	CtF6ilFRSpyXDSQhAJLIKM2DGwtLKK8YxYG+FOY1BtnOA0xGcN2vgAYzAQ02dAUbXJKIkJJq
	YLQwPBGncfBRSOVj5RnV3xt6mJh3B1u2hT2TePdqt6pI5C/uPkPVq4HP+AsFbFbcCtHJWvfn
	t3o6+12J1NINvgz5Pntt16kmbZi6evLcg8tEwz8Xz/0c1TqlKOTWtYDzbq+1z0aZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245839>

Previously there were no good tests of C-quoted arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 774f8c5..00862bc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -350,12 +350,18 @@ test_expect_success 'stdin fails on unknown command' '
 	grep "fatal: unknown command: unknown $a" err
 '
 
-test_expect_success 'stdin fails on badly quoted input' '
+test_expect_success 'stdin fails on unbalanced quotes' '
 	echo "create $a \"master" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: badly quoted argument: \\\"master" err
 '
 
+test_expect_success 'stdin fails on invalid escape' '
+	echo "create $a \"ma\zter\"" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: badly quoted argument: \\\"ma\\\\zter\\\"" err
+'
+
 test_expect_success 'stdin fails on junk after quoted argument' '
 	echo "create \"$a\"master" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -458,6 +464,24 @@ test_expect_success 'stdin create ref works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin succeeds with quoted argument' '
+	git update-ref -d $a &&
+	echo "create $a \"$m\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin succeeds with escaped character' '
+	git update-ref -d $a &&
+	echo "create $a \"ma\\163ter\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stdin update ref creates with zero old value' '
 	echo "update $b $m $Z" >stdin &&
 	git update-ref --stdin <stdin &&
-- 
1.9.1
