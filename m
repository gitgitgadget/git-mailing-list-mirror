From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] git notes show: test empty notes
Date: Fri,  6 Feb 2009 16:19:02 +0100
Message-ID: <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:21:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSWM-0001nD-VD
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206AbZBFPT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757021AbZBFPT0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:19:26 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:42198 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756858AbZBFPT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:19:26 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2B65C28C702;
	Fri,  6 Feb 2009 10:19:25 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 06 Feb 2009 10:19:25 -0500
X-Sasl-enc: qQNtztpbbarpJ67o4JcZqc8vY/zowp00iBicniqpiYFC 1233933550
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E88CC13EEB;
	Fri,  6 Feb 2009 10:19:09 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
In-Reply-To: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108729>

Add a test for the handling of empty notes by "git notes show".
---
 t/t3301-notes.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 9393a25..4900dca 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -35,6 +35,11 @@ test_expect_success 'need valid notes ref' '
 	! MSG=2 GIT_NOTES_REF='/' git notes show
 '
 
+# 1 indicates caught gracefully by die, 128 means git-show barfed
+test_expect_failure 'handle empty notes gracefully' '
+	git notes show || test 1 = $?
+'
+
 test_expect_success 'create notes' '
 	git config core.notesRef refs/notes/commits &&
 	MSG=b1 git notes edit &&
-- 
1.6.1.2.253.ga34a
