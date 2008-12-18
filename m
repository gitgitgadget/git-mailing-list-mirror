From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] test overlapping ignore patterns
Date: Thu, 18 Dec 2008 18:11:18 +0100
Message-ID: <1229620278-25152-1-git-send-email-git@drmicha.warpmail.net>
References: <7viqpjra57.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 18:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDMQc-0008BU-0A
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 18:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbYLRRLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 12:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbYLRRLb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 12:11:31 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50500 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752305AbYLRRLa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 12:11:30 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1C5361E77EC;
	Thu, 18 Dec 2008 12:11:29 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 18 Dec 2008 12:11:29 -0500
X-Sasl-enc: VBO+tj/Y5y16VmxH7PYXegvym+XgEA6jM8ZaOQ0Sb/3M 1229620288
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 63EBDF682;
	Thu, 18 Dec 2008 12:11:28 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1
In-Reply-To: <7viqpjra57.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103473>

Add a test which checks that negated patterns such as "!foo.html" can
override previous patterns such as "*.html". This is documented
behaviour but had not been tested so far.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3001-ls-files-others-exclude.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 8666946..85aef12 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -140,4 +140,10 @@ test_expect_success 'trailing slash in exclude forces directory match (2)' '
 
 '
 
+test_expect_success 'negated exclude matches can override previous ones' '
+
+	git ls-files --others --exclude="a.*" --exclude="!a.1" >output &&
+	grep "^a.1" output
+'
+
 test_done
-- 
1.6.1.rc1
