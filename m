From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/4] git submodule: Add more tests for add with funky paths
Date: Wed, 25 Feb 2009 14:26:31 +0100
Message-ID: <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net>
References: <49A541D3.4030001@viscovery.net>
 <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net>
Cc: Andrei Thorp <garoth@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 14:29:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJpG-00029T-Iu
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 14:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbZBYN0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 08:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756290AbZBYN0v
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 08:26:51 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47404 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756274AbZBYN0t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 08:26:49 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A6B512A62E4;
	Wed, 25 Feb 2009 08:26:47 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 25 Feb 2009 08:26:47 -0500
X-Sasl-enc: ton0fbcpGi7BnpUDyDqkwfLBk6IdVb3OkuiYYIi2a6Ld 1235568407
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1BDCE3B363;
	Wed, 25 Feb 2009 08:26:46 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111455>

Add 2 more tests which test paths with // and /.., both of which fail
currently.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7400-submodule-basic.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 1757732..21bdfeb 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -63,6 +63,16 @@ test_expect_success 'submodule add with ./ in path' '
 	git submodule add "$submodurl" ././dotsubmod/./frotz/./ &&
 	git submodule init
 '
+
+test_expect_failure 'submodule add with // in path' '
+	git submodule add "$submodurl" slashslashsubmod///frotz// &&
+	git submodule init
+'
+
+test_expect_failure 'submodule add with /.. in path' '
+	git submodule add "$submodurl" dotdotsubmod/../realsubmod/frotz/.. &&
+	git submodule init
+'
 # end of submodule add testing
 popd >/dev/null
 
-- 
1.6.2.rc1.30.gd43c
