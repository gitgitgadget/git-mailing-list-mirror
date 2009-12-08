From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] t7508-status: status --porcelain ignores relative paths setting
Date: Tue,  8 Dec 2009 11:12:01 +0100
Message-ID: <313cf8059f028c670b6f17bef412080146669b94.1260266027.git.git@drmicha.warpmail.net>
References: <cover.1260266027.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 11:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHx3R-0005Rh-V8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 11:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbZLHKMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 05:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZLHKME
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 05:12:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37794 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753126AbZLHKMD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 05:12:03 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2A4DDC4B15;
	Tue,  8 Dec 2009 05:12:09 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 08 Dec 2009 05:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=SjXupJyMkzixtwlBnUA/S2dJtQ0=; b=IDMoFhWxT+N/RUrU0jSC46oWN0ABUxjh0ivuVJcy1Mn/0UMWjjBV2f204rBw3k6wc0t/gZazsKFyTh8HEa4PJRPn1UtrsteOTPqGwe1g4UlFgSswmLziiABpUB4nkZk9AdcC6tQ/t0CUzOhbh/a07CiHojtv0cIIyhRiwVCeUtQ=
X-Sasl-enc: ve42F8ttxgnymFH7/aKxrP9pBbyhqviLhQuMjBdu6B7P 1260267128
Received: from localhost (p5DCC1658.dip0.t-ipconnect.de [93.204.22.88])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 70CB65574;
	Tue,  8 Dec 2009 05:12:08 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.292.gd8fe
In-Reply-To: <cover.1260266027.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134852>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 99a74bd..8e7727e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -298,6 +298,24 @@ test_expect_success 'status -s with relative paths' '
 '
 
 cat > expect << \EOF
+ M dir1/modified
+A  dir2/added
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? expect
+?? output
+?? untracked
+EOF
+
+test_expect_success 'status --porcelain ignores relative paths setting' '
+
+	(cd dir1 && git status --porcelain) > output &&
+	test_cmp expect output
+
+'
+
+cat > expect << \EOF
 # On branch master
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
-- 
1.6.6.rc1.292.gd8fe
