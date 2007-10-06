From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git-gui: try to locate git in same directory as git-gui (on Windows)
Date: Sat,  6 Oct 2007 11:36:44 +0200
Message-ID: <11916634041243-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 11:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ie65m-0003Z5-Rs
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 11:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbXJFJgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbXJFJgr
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 05:36:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:35526 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbXJFJgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 05:36:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l969aiIn014504
	for <git@vger.kernel.org>; Sat, 6 Oct 2007 11:36:45 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l969airq016425;
	Sat, 6 Oct 2007 11:36:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60145>

This commit adds another guess where git might be located.
After searching PATH the last fallback is the directory
in which git-gui is installed. This is a good guess for
a sane installation.

Even if git is not included in PATH, git-gui is now able
to locate it. Hence git-gui can be passed to wish
as an absolute path without caring about the environment.

PATH is searched first and the location of git-gui only
as a last resort. Maybe the order should be reversed?

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3f5927f..bb1e7f3 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -344,6 +344,7 @@ proc _which {what} {
 			set _search_exe .exe
 		} elseif {[is_Windows]} {
 			set _search_path [split $env(PATH) {;}]
+			lappend _search_path [file dirname [info script]]
 			set _search_exe .exe
 		} else {
 			set _search_path [split $env(PATH) :]
-- 
1.5.3.mingw.1.105.ga0fd0
