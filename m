From: Jeff King <peff@peff.net>
Subject: [PATCH] t5541: mark passing c-a-s test as success
Date: Fri, 20 Sep 2013 06:25:00 -0400
Message-ID: <20130920102459.GA26914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 12:25:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMxtl-0000tN-Be
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 12:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab3ITKZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 06:25:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:44852 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259Ab3ITKZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 06:25:10 -0400
Received: (qmail 9993 invoked by uid 102); 20 Sep 2013 10:25:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Sep 2013 05:25:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Sep 2013 06:25:00 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235064>

Commit 05c1eb1 (push: teach --force-with-lease to smart-http
transport) fixed the compare-and-swap test in t5541. It
tried to mark the test as passing by teaching the test
helper function to expect an extra "success or failure"
parameter, but forgot to actually use the parameter in the
helper.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of jc/push-cas.

 t/lib-httpd.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index dab405d..54dbbfe 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -169,7 +169,7 @@ test_http_push_nonff () {
 		test_i18ngrep "Updates were rejected because" output
 	'
 
-	test_expect_failure 'force with lease aka cas' '
+	test_expect_${EXPECT_CAS_RESULT} 'force with lease aka cas' '
 		HEAD=$(	cd "$REMOTE_REPO" && git rev-parse --verify HEAD ) &&
 		test_when_finished '\''
 			(cd "$REMOTE_REPO" && git update-ref HEAD "$HEAD")
-- 
1.8.4.37.g67196dd
