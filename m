From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/26] t1400: Fix name and expected result of one test
Date: Mon, 10 Mar 2014 13:46:18 +0100
Message-ID: <1394455603-2968-2-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzbl-0007Bi-0e
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbaCJMqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:46:53 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47818 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753488AbaCJMqw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:46:52 -0400
X-AuditID: 1207440e-f79c76d000003e2c-5d-531db43b3e88
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B4.C2.15916.B34BD135; Mon, 10 Mar 2014 08:46:51 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwP025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:46:49 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqGu9RTbY4OUXPoud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8aH7VuZClq4KtadvsfWwPibvYuRk0NCwETi3KnZ
	jBC2mMSFe+vZuhi5OIQELjNK3D2ykRnCOcEksWViGytIFZuArsSinmYmEFtEQE1iYtshFpAi
	ZoErjBKfv/4CGyss4CbR1X4fqIiDg0VAVeLKCUOQMK+As0Tjzz8sENvkJKb8XgBWzingIjH9
	ygMwWwio5uWeZtYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoSE
	Ht8Oxvb1MocYBTgYlXh4D7yVCRZiTSwrrsw9xCjJwaQkyjtxrWywEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHezMVAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO/h
	zUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDYiC8GRgdIigdo7zaQdt7igsRc
	oChE6ylGRSlx3jkgCQGQREZpHtxYWEJ5xSgO9KUwbytIFQ8wGcF1vwIazAQ0uPm4FMjgkkSE
	lFQDo4HTGovtdv62sbtE3827++CF3VyvxLyqG8FWr7/HRZco8k7f4VIs9clSffPEQ9PvGEeW
	P920izMwPPJb1jmPmZca9hmtyVSQ+C+9JIwnJsrAxyDAaXH5ZTsDV0FNW96Hi5yO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243732>

The test

    stdin -z create ref fails with zero new value

actually passes an empty new value, not a zero new value.  So rename
the test s/zero/empty/, and change the expected error from

    fatal: create $c given zero new value

to

    fatal: create $c missing <newvalue>

Of course, this makes the test fail now, so mark it
test_expect_failure.  The failure will be fixed later in this patch
series.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6ffd82f..fa927d2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -827,10 +827,10 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
-test_expect_success 'stdin -z create ref fails with zero new value' '
+test_expect_failure 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c given zero new value" err &&
+	grep "fatal: create $c missing <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
-- 
1.9.0
