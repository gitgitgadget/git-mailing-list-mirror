From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/4] t3301: fix confusing test for valid notes ref
Date: Sat, 14 Feb 2009 20:15:05 +0100
Message-ID: <21cefcfb71849535430c75575a9decf1f9fe9c06.1234638466.git.trast@student.ethz.ch>
References: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 20:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQ0a-0008VK-6w
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbZBNTPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZBNTPW
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:15:22 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20714 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbZBNTPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:15:18 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:14 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:14 +0100
X-Mailer: git-send-email 1.6.2.rc0.288.g6852b
In-Reply-To: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 19:15:14.0725 (UTC) FILETIME=[909FED50:01C98ED8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109898>

The test used single quotes in the test code, but also single quotes
to wrap the entire test snippet, thus effectively skipping _out_ of
quoted mode.  Since it doesn't matter here, just drop the quotes to
cause less confusion.

Also, the test passed a MSG variable to 'git notes show', but that
never calls an editor.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

As an aside, is there a specific reason why all the negative tests use
'! VAR=foo bar' instead of 'VAR=foo test_must_fail bar'?  I thought
the latter was preferred to catch segfaults.


 t/t3301-notes.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index ff4ea05..b99271e 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -31,8 +31,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'need valid notes ref' '
-	! MSG=1 GIT_NOTES_REF='/' git notes edit &&
-	! MSG=2 GIT_NOTES_REF='/' git notes show
+	! MSG=1 GIT_NOTES_REF=/ git notes edit &&
+	! GIT_NOTES_REF=/ git notes show
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
-- 
1.6.2.rc0.288.g6852b
