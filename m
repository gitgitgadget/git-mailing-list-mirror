From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 7/8] mergetools: use the correct tool for Beyond Compare 3 on Windows
Date: Fri, 14 Oct 2011 23:53:34 +0100
Message-ID: <1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 00:54:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REqdz-0000Zr-8h
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 00:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933511Ab1JNWyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 18:54:16 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:63189 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932401Ab1JNWyI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 18:54:08 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225407.PZBQ21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:54:07 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqdi-0006bN-W2; Fri, 14 Oct 2011 23:54:07 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id A1A8A20A65; Fri, 14 Oct 2011 23:54:06 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=dRIEh8c9U7UA:10 a=21R32oQrAAAA:8 a=FP58Ms26AAAA:8 a=Xd6sfcQDNcueAVLXO6cA:9 a=d8SmFLzJaU0A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183622>

On Windows the bcompare tool launches a graphical program and does
not wait for it to terminate. A separate 'bcomp' tool is provided which
will wait for the view to exit so we use this instead.

Reported-by: Werner BEROUX <werner@beroux.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 mergetools/bc3 |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/mergetools/bc3 b/mergetools/bc3
index 27b3dd4..b642bf2 100644
--- a/mergetools/bc3
+++ b/mergetools/bc3
@@ -16,5 +16,12 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	echo bcompare
+	case $(uname -s) in
+	*MINGW*)
+		echo bcomp
+		;;
+	*)
+		echo bcompare
+		;;
+	esac
 }
-- 
1.7.7.1.gbba15
