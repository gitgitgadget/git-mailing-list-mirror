From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/26] t1400: Provide sensible input to the command
Date: Mon, 10 Mar 2014 13:46:19 +0100
Message-ID: <1394455603-2968-3-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzbl-0007Bi-HS
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbaCJMq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:46:57 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49911 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753488AbaCJMqy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:46:54 -0400
X-AuditID: 12074411-f79ab6d000002f0e-a7-531db43d45f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 62.DD.12046.D34BD135; Mon, 10 Mar 2014 08:46:53 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwQ025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:46:51 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqGu7RTbY4P0ZHoud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8bGHYkFOzkruiaaNDCeZe9i5OSQEDCROH/mARuE
	LSZx4d56IJuLQ0jgMqPE4UstUM4JJokHV16zglSxCehKLOppZgKxRQTUJCa2HWIBKWIWuMIo
	8fnrL7CxwgLOEl//tbKA2CwCqhLP1k4Es3mB4jsmbWGGWCcnMeX3ArB6TgEXielXHoDZQkA1
	L/c0s05g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyTwBHcwzjgp
	d4hRgINRiYf34FuZYCHWxLLiytxDjJIcTEqivBPXygYL8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuHNXAyU401JrKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2CycpwcChJ8NZvBmoULEpN
	T61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VGfDEwNkBSPEB7t4G08xYXJOYCRSFaTzEq
	SonzzgFJCIAkMkrz4MbC0skrRnGgL4V5W0GqeICpCK77FdBgJqDBzcelQAaXJCKkpBoYve5/
	LJ4ir9vDN/2US9XTnF/vl6448ipmS9e6xumP1NWEdmsnH2l4vtqMR2jrkdUvVc9Uc6yIu3TR
	b6PJfattZTPXyaidE3HcwSQicFPlzkOZjtOXm3ebGzGEuV+9vLTonfQtq0VPqg4c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243733>

The old version was passing (among other things)

    update SP refs/heads/c NUL NUL 0{40} NUL

to "git update-ref -z --stdin" to test whether the old-value check for
c is working.  But the <newvalue> is empty, which is not allowed for
the "update" command.

So, to be sure that we are testing what we want to test, provide a
legitimate <newvalue> on the "update" line.

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
