From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Show a round number of bytes of large untracked
 text files
Date: Fri, 03 Oct 2008 10:28:49 +0200
Message-ID: <48E5D7C1.7050404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 10:30:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klg33-00078X-3o
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 10:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYJCI2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 04:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbYJCI2x
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 04:28:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24861 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbYJCI2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 04:28:52 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Klg1q-00050M-1j; Fri, 03 Oct 2008 10:28:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AF54A69F; Fri,  3 Oct 2008 10:28:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97404>

From: Johannes Sixt <johannes.sixt@telecom.at>

If an untracked text file is selected, then its contents are displayed
instead of a diff. If the file is large, then the following hint is
inserted at the top:

  * Untracked file is 14774881 bytes.
  * Showing only first 131072 bytes.

Why exactly 131072 bytes? With this patch it is 100000 bytes.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Another bikeshed to paint. ;)

 Every now and then I stumble over this number, and I ask myself,
 why are those h4x3rs so binary?

 -- Hannes

 lib/diff.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index abe502d..6e08704 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -164,7 +164,7 @@ proc show_other_diff {path w m cont_info} {
 	# - Git won't give us the diff, there's nothing to compare to!
 	#
 	if {$m eq {_O}} {
-		set max_sz [expr {128 * 1024}]
+		set max_sz 100000
 		set type unknown
 		if {[catch {
 				set type [file type $path]
-- 
1.6.0.2.319.gffa7c
