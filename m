From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/26] t1400: Add some more tests involving quoted arguments
Date: Mon, 10 Mar 2014 13:46:22 +0100
Message-ID: <1394455603-2968-6-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzdQ-0000Xv-4g
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbaCJMsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:48:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47818 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753488AbaCJMq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:46:59 -0400
X-AuditID: 1207440e-f79c76d000003e2c-85-531db442fff7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E6.C2.15916.244BD135; Mon, 10 Mar 2014 08:46:58 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwT025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:46:57 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqOu0RTbY4NdjS4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8b0k8+ZC9bwV6w6soutgfEATxcjJ4eEgInEkb3P
	2CBsMYkL99YD2VwcQgKXGSWWnfrDCOGcYJKYv+w+C0gVm4CuxKKeZiYQW0RATWJi2yEWkCJm
	gSuMEp+//mIHSQgL+EhcWLmBEcRmEVCV+Nd/EqyBV8BZomfrDGaIdXISU34vAKvnFHCRmH7l
	AZgtBFTzck8z6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI31cjNL9FJTSjcxQoKP
	bwdj+3qZQ4wCHIxKPLwH3soEC7EmlhVX5h5ilORgUhLlnbhWNliILyk/pTIjsTgjvqg0J7X4
	EKMEB7OSCG/mYqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC9/Bm
	oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UHTEFwPjAyTFA7R3G0g7b3FBYi5Q
	FKL1FKOilDjvHJCEAEgiozQPbiwspbxiFAf6Upi3FaSKB5iO4LpfAQ1mAhrcfFwKZHBJIkJK
	qoGxNt/DWcI37P5kr1caz5luOYT3xR1fK+WepZnDGjatxk1SKW5O0bI52nUF8e1bPZk3PA+f
	LhBrqObXszrxhY7b3DNpyUz36lbevHvwxWfftf0TnzqtmJnRFKXwju2Jhdg/zz/V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243755>

Previously there were no good tests of C-quoted arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 5836842..627aaaf 100755
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
1.9.0
