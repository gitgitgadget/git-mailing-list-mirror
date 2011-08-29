From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/4] t4014: "no-add-headers" is actually called "no-add-header"
Date: Mon, 29 Aug 2011 22:10:48 +0200
Message-ID: <221564762d013a422c36f42401c5782a7b20aa17.1314648438.git.trast@student.ethz.ch>
References: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8Ab-0005R6-JI
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab1H2UKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:10:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:55607 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885Ab1H2UKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:10:52 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:49 +0200
Received: from localhost.localdomain (129.132.153.219) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:50 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
In-Reply-To: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180341>

Since c426003 (format-patch: add --no-cc, --no-to, and
--no-add-headers, 2010-03-07) the tests have checked for an option
called --no-add-headers introduced by letting the user negate
--add-header.

However, the parseopt machinery does not automatically pluralize
anything, so it is in fact called --no-add-header.

Since the option never worked, is not documented anywhere, and
implementing an actual --no-add-headers would lead to silly code
complications, we just adapt the test to the code.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4014-format-patch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index a45d4fb..5cbc066 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -219,11 +219,11 @@ test_expect_success '--no-cc overrides config.cc' '
 	! grep "^Cc: C. E. Cipient <rcipient@example.com>\$" patch12
 '
 
-test_expect_failure '--no-add-headers overrides config.headers' '
+test_expect_success '--no-add-header overrides config.headers' '
 
 	git config --replace-all format.headers \
 		"Header1: B. E. Cipient <rcipient@example.com>" &&
-	git format-patch --no-add-headers --stdout master..side |
+	git format-patch --no-add-header --stdout master..side |
 	sed -e "/^\$/q" >patch13 &&
 	check_patch patch13 &&
 	! grep "^Header1: B. E. Cipient <rcipient@example.com>\$" patch13
-- 
1.7.7.rc0.370.gdcae57
