From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/27] t1400: Fix name and expected result of one test
Date: Mon, 24 Mar 2014 18:56:34 +0100
Message-ID: <1395683820-17304-2-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99P-0002hi-7p
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbaCXR7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:59:00 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43456 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753546AbaCXR5N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:13 -0400
X-AuditID: 1207440c-f79656d000003eba-d8-533071f7c9c0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 10.AF.16058.7F170335; Mon, 24 Mar 2014 13:57:11 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xX028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:10 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqPu90CDY4MACM4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8aH7VuZClq4KtadvsfWwPibvYuRk0NCwETi6Oxv
	bBC2mMSFe+uBbC4OIYHLjBJfp/1hhXBOMEk83vcFrIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPA
	FUaJKx+3s4AkhAU8JV7sWssKYrMIqEq8W74TrJlXwEVi5szVUKvlJKb8XgBmcwq4SmxtP8wM
	YgsB1ez42Ms0gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQ4OPZ
	wfhtncwhRgEORiUe3ghjg2Ah1sSy4srcQ4ySHExKorxsuUAhvqT8lMqMxOKM+KLSnNTiQ4wS
	HMxKIryW4UA53pTEyqrUonyYlDQHi5I4r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IEbxgwyoQE
	i1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQdERXwyMD5AUD9BeB5B23uKCxFygKETr
	KUZFKXHeawVACQGQREZpHtxYWEp5xSgO9KUwbwJIOw8wHcF1vwIazAQ0OLxJD2RwSSJCSqqB
	MUu965Pi9JOzr3046vQ/7535QTm1iX5fnC93O2w+2y/xVDwkJeTCf9WD1+5nT113yYTFLFP3
	5GLN4L/dJd5zDstwfdm5ZPcKY6047/fTFA3bLj42FLa+meS0fx3XZfP6ouBQtbaA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244856>

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
