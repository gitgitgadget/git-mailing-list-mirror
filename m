From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/27] t1400: Provide more usual input to the command
Date: Mon, 24 Mar 2014 18:56:35 +0100
Message-ID: <1395683820-17304-3-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS97g-0000d1-3m
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbaCXR5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:15 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54318 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753706AbaCXR5O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:14 -0400
X-AuditID: 12074413-f79076d000002d17-f3-533071f91339
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BE.E5.11543.9F170335; Mon, 24 Mar 2014 13:57:13 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xY028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:12 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqPuz0CDYoPeogcXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO2PXss8sBWs4Ky6suMjYwHiAvYuRk0NCwERiX886
	NghbTOLCvfVANheHkMBlRokbbzYyQzgnmCRmXl8D1sEmoCuxqKeZCcQWEVCTmNh2iAWkiFng
	CqPElY/bWUASwgIeEvcu/WMFsVkEVCUO3HjFCGLzCrhIXD9whBFinZzElN8LwIZyCrhKbG0/
	zAxiCwHV7PjYyzSBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJDg
	E97BuOuk3CFGAQ5GJR7eDaYGwUKsiWXFlbmHGCU5mJREedlygUJ8SfkplRmJxRnxRaU5qcWH
	GCU4mJVEeC3DgXK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQnerAKg
	RsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQdMQXA+MDJMUDtNehEGRvcUFiLlAU
	ovUUo6KUOO81kLkCIImM0jy4sbCU8opRHOhLYV41kHYeYDqC634FNJgJaHB4kx7I4JJEhJRU
	A2ODVFl9yYfvkqm/l4Q+PSBZ8EXp4zWVVTPeXGQ8f/1syvxuhmNFqz7tXt94qSN84vxcd6ep
	hgVc95Zt2BXzMui1wZ5p6e5xAdXXXh9O3aOfHJ+fcymSWUHr7NV38tOUlBeuYdrp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244830>

The old version was passing (among other things)

    update SP refs/heads/c NUL NUL 0{40} NUL

to "git update-ref -z --stdin" to test whether the old-value check for
c is working.  But the <newvalue> is empty, which is a bit off the
beaten track.

So, to be sure that we are testing what we want to test, provide an
actual <newvalue> on the "update" line.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index fa927d2..29391c6 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -912,7 +912,7 @@ test_expect_success 'stdin -z update refs works with identity updates' '
 
 test_expect_success 'stdin -z update refs fails with wrong old value' '
 	git update-ref $c $m &&
-	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "" "$Z" >stdin &&
+	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$m" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
-- 
1.9.0
