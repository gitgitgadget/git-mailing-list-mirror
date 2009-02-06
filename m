From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 1/2] git notes show: test empty notes
Date: Fri,  6 Feb 2009 17:17:54 +0100
Message-ID: <1233937075-31194-2-git-send-email-git@drmicha.warpmail.net>
References: <1233937075-31194-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 17:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTQR-0000jm-UM
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbZBFQSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZBFQSF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:18:05 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47839 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752730AbZBFQSE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 11:18:04 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D001D28831C;
	Fri,  6 Feb 2009 11:18:03 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 06 Feb 2009 11:18:03 -0500
X-Sasl-enc: swuYeJultcyz/oVZj7fDUNCtgR7OVzUa3ZuvuvfvJhkA 1233937083
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3377422E1B;
	Fri,  6 Feb 2009 11:18:03 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
In-Reply-To: <1233937075-31194-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108755>

Add a test for the handling of empty notes by "git notes show".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3301-notes.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 9393a25..7ef1c29 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -35,6 +35,11 @@ test_expect_success 'need valid notes ref' '
 	! MSG=2 GIT_NOTES_REF='/' git notes show
 '
 
+# 1 indicates caught gracefully by die, 128 means git-show barked
+test_expect_failure 'handle empty notes gracefully' '
+	git notes show ; test 1 = $?
+'
+
 test_expect_success 'create notes' '
 	git config core.notesRef refs/notes/commits &&
 	MSG=b1 git notes edit &&
-- 
1.6.1.2.253.ga34a
