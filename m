From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 6/7] mergetools: use the correct tool for Beyond Compare 3 on Windows
Date: Sat, 15 Oct 2011 15:05:19 +0100
Message-ID: <1318687520-19522-7-git-send-email-patthoyts@users.sourceforge.net>
References: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 16:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4rv-0003yR-Tm
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab1JOOFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:33 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:64778 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752972Ab1JOOFb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:31 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140530.GEGI8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:30 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4ri-00026A-9Z; Sat, 15 Oct 2011 15:05:30 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id DCE79207A7; Sat, 15 Oct 2011 15:05:29 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=bCYuH54ZWRgA:10 a=21R32oQrAAAA:8 a=FP58Ms26AAAA:8 a=UzQqJiMOJlsQWiq3IiIA:9 a=d8SmFLzJaU0A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183658>

On Windows the bcompare tool launches a graphical program and does
not wait for it to terminate. A separate 'bcomp' tool is provided which
will wait for the view to exit so we use this instead.

Reported-by: Werner BEROUX <werner@beroux.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 mergetools/bc3 |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/mergetools/bc3 b/mergetools/bc3
index 27b3dd4..b6319d2 100644
--- a/mergetools/bc3
+++ b/mergetools/bc3
@@ -16,5 +16,10 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	echo bcompare
+	if type bcomp >/dev/null 2>/dev/null
+	then
+		echo bcomp
+	else
+		echo bcompare
+	fi
 }
-- 
1.7.7.1.gbba15
