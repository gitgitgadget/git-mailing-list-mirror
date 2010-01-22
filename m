From: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
Subject: [PATCH 3/3] git-p4: improve submit performance on new P4 servers
Date: Thu, 21 Jan 2010 18:06:00 -0800
Message-ID: <4B590808.6010206@naughtydog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:05:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY8uD-0006Yb-HW
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab0AVCFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755815Ab0AVCFe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:05:34 -0500
Received: from ironport01a.scea.com ([160.33.44.41]:53539 "EHLO
	ironport01a.scea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab0AVCFc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:05:32 -0500
X-IronPort-AV: E=Sophos;i="4.49,321,1262592000"; 
   d="scan'208";a="10635398"
Received: from inbetweener01.scea.com ([160.33.45.195])
  by ironport01a.scea.com with ESMTP; 21 Jan 2010 18:05:31 -0800
Received: from postal1-dog.naughtydog.com (intmail.naughtydog.com [10.15.0.14])
	by inbetweener01.scea.com (Postfix) with ESMTP id BD965F017A;
	Thu, 21 Jan 2010 18:05:31 -0800 (PST)
Received: from [127.0.0.1] ([150.0.6.116]) by postal1-dog.naughtydog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Jan 2010 18:06:00 -0800
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-OriginalArrivalTime: 22 Jan 2010 02:06:00.0336 (UTC) FILETIME=[716A7900:01CA9B07]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137718>

Improve git-p4 submit performance on newer (from 2009.2) Perforce
servers by changing "p4 diff -du" to "p4 diff -dub". This change is
harmless since the output is only used for display purposes.

Signed-off-by: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index ab538b3..ec26cac 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -715,7 +715,7 @@ class P4Submit(Command):
             submitTemplate = self.prepareLogMessage(template, logMessage)
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
-            diff = p4_read_pipe("diff -du ...")
+            diff = p4_read_pipe("diff -dub ...")
 
             newdiff = ""
             for newFile in filesToAdd:
-- 
1.6.5.2.6.gc3c1e.dirty
