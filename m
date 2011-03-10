From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 09/10] t6007: test rev-list --cherry
Date: Thu, 10 Mar 2011 15:45:02 +0100
Message-ID: <ca14e3fb22b91653086fbd8c8600f2f93409a0a6.1299767413.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhB9-0007ob-A2
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1CJOs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:58 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48418 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752804Ab1CJOs5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:57 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9E6B620D45;
	Thu, 10 Mar 2011 09:48:56 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 10 Mar 2011 09:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=GbiW5LZlrwTSbek8LAnYmcT0Bmo=; b=Sc3+jAuxQ695sc5ihQd1nzWEwHpQxv0CWd12vVhojWbImJqNuhpv7+9b3LTAkELPnv8EdAu1rDzMPLRLupdMSkoYLH4YJjOlzw7nsipgSJ/EqWfEU/C7cG5G6HUXjasUJ9WKrT4aOBoC/mKKBgw031ZHFl38cbh2WHyY1mhmSZc=
X-Sasl-enc: Q4SpOrSZeB5zbuAcqMvStvaat6LxYq/D+MipyIg87Cuh 1299768536
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2366940D398;
	Thu, 10 Mar 2011 09:48:56 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168823>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6007-rev-list-cherry-pick-file.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 37bd25e..cacf3de 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -145,6 +145,18 @@ test_expect_success '--cherry-pick --left-only' '
 	test_cmp actual.named expect
 '
 
+cat >expect <<EOF
++tags/E
+=tags/C
+EOF
+
+test_expect_success '--cherry' '
+	git rev-list --cherry F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
 test_expect_success '--cherry-pick with independent, but identical branches' '
 	git symbolic-ref HEAD refs/heads/independent &&
 	rm .git/index &&
-- 
1.7.4.1.317.gf445f
