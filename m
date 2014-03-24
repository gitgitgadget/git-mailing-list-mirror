From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/27] t1400: Test one mistake at a time
Date: Mon, 24 Mar 2014 18:56:49 +0100
Message-ID: <1395683820-17304-17-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS98A-00018N-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbaCXR5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:43 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58420 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818AbaCXR5m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:42 -0400
X-AuditID: 12074414-f79d96d000002d2b-f7-53307215fd7d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.8E.11563.51270335; Mon, 24 Mar 2014 13:57:41 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xm028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:39 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCtaZBBssLRfwWLnOgmLrivdTBYN
	vVeYLebd3cVkcXvFfGaLHy09zBYfOxcwO7B7/H3/gclj56y77B6XXn5n8/j4bDm7x7PePYwe
	Fy8pe3zeJBfAHsVtk5RYUhacmZ6nb5fAnfH0VSdzwVuuihm7FrE0MN7n6GLk4JAQMJF4/Nq3
	i5ETyBSTuHBvPVsXIxeHkMBlRonHO54xQzgnmCQOPz7AClLFJqArsainmQnEFhFQk5jYdogF
	pIhZ4AqjxJWP21lAEsIC1hLdZ9YygtgsAqoSV+YvBIvzCrhKHFq8iQ1inZzElN8L2EFsTqD4
	1vbDzCC2kICLxI6PvUwTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSnd
	xAgJPZEdjEdOyh1iFOBgVOLhjTA2CBZiTSwrrsw9xCjJwaQkysuWCxTiS8pPqcxILM6ILyrN
	SS0+xCjBwawkwmsZDpTjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLg
	nVoI1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPio34YmB0gKR4gPbWgrTzFhck
	5gJFIVpPMSpKifNeKwBKCIAkMkrz4MbCEsorRnGgL4V554O08wCTEVz3K6DBTECDw5v0QAaX
	JCKkpBoYFxr/46vZZpMp+Oj6Jf/9J1zPyE2o3bwt4KZhplX+349ZnntOv+F3iucvX++RcPTB
	Scnt7wvCtj9VCTr/VbEjQMRv8vktPWpz9tfxnLj8r3vLqnCvaT+vfNW5+3NXUk7x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244837>

This case wants to test passing a bad refname to the "update" command.
But it also passes too few arguments to "update", which muddles the
situation: which error should be diagnosed?  So split this test into
two:

* One that passes too few arguments to update

* One that passes all three arguments to "update", but with a bad
  refname.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

t1400: Add a test of "update" with too few arguments

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 2d61cce..6b21e45 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -724,8 +724,14 @@ test_expect_success 'stdin -z fails update with no ref' '
 	grep "fatal: update line missing <ref>" err
 '
 
+test_expect_success 'stdin -z fails update with too few args' '
+	printf $F "update $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a missing <oldvalue>" err
+'
+
 test_expect_success 'stdin -z fails update with bad ref name' '
-	printf $F "update ~a" "$m" >stdin &&
+	printf $F "update ~a" "$m" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a" err
 '
-- 
1.9.0
