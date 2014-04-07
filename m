From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/27] t1400: provide more usual input to the command
Date: Mon,  7 Apr 2014 15:47:53 +0200
Message-ID: <1396878498-19887-3-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:48:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9um-0002Wl-Dj
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbaDGNsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:38 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:65437 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755334AbaDGNsa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:30 -0400
X-AuditID: 12074412-f79d46d000002e58-eb-5342acab9be1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4A.DD.11864.BACA2435; Mon,  7 Apr 2014 09:48:27 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJa9026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:26 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLt6jVOwwf11WhY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7ox7ryYzF6zhrOi8s4K5gfEAexcjJ4eEgInEkTuf
	mCBsMYkL99azdTFycQgJXGaUOHu7F8o5xiRxbV4nC0gVm4CuxKKeZrAOEQE1iYlth1hAipgF
	rjBKXPm4HaxIWMBDYvvUr6wgNouAqsSt/9OZuxg5OHgFXCTmvTKD2CYncfLYZLASTgFXiRmH
	bjGC2EJAJffXHGOZwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZI
	6AntYFx/Uu4QowAHoxIP74pDjsFCrIllxZW5hxglOZiURHmfL3MKFuJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCy7UaKMebklhZlVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8GhJMHb
	CNIoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2zgXbW1yQmAsU
	hWg9xagoJc5bApIQAElklObBjYUllFeM4kBfCvMWgFTxAJMRXPcroMFMQIMNXcEGlyQipKQa
	GLNrT5ulmfu/5yq8sL+KU/f0mj6DZO1gqW07ZdheHena3WUxOaeUe4J9QtO55HNbNep3TWU6
	cXTXhAQ51a/fEhvaNwcX31B7LGIiZ1l1cmb7Y02F9ZcZV9eZBjS+Ws33o/eNlb3y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245838>

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
1.9.1
