From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] gitk: add --no-replace-objects option
Date: Tue, 17 Nov 2009 06:11:24 +0100
Message-ID: <20091117051125.3588.83924.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 06:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAGQV-0005L4-69
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 06:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbZKQFQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 00:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZKQFQL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 00:16:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47784 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbZKQFQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 00:16:11 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EC487818093;
	Tue, 17 Nov 2009 06:16:07 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A41F6818040;
	Tue, 17 Nov 2009 06:16:04 +0100 (CET)
X-git-sha1: 152e48d33e3dc4bd6e402b826e1ca51ce8f2454b 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133059>

This option simply sets the GIT_NO_REPLACE_OBJECTS environment
variable, and that is enough to make gitk ignore replace refs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gitk-git/gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0214b7..7ca7fbc 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -128,7 +128,7 @@ proc unmerged_files {files} {
 }
 
 proc parseviewargs {n arglist} {
-    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs
+    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
@@ -208,6 +208,9 @@ proc parseviewargs {n arglist} {
 		# git rev-parse doesn't understand --merge
 		lappend revargs --gitk-symmetric-diff-marker MERGE_HEAD...HEAD
 	    }
+	    "--no-replace-objects" {
+		set env(GIT_NO_REPLACE_OBJECTS) ""
+	    }
 	    "-*" {
 		# Other flag arguments including -<n>
 		if {[string is digit -strict [string range $arg 1 end]]} {
-- 
1.6.5.1.gaf97d
