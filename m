From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH resend] git-gui: fix "Explore Working Copy" for Windows again
Date: Tue, 16 Mar 2010 00:22:05 +0100
Message-ID: <1268695325-9112-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJaz-00049Y-52
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937162Ab0COXVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 19:21:08 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:55309 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937130Ab0COXVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:21:06 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2A9E914DB11F9;
	Tue, 16 Mar 2010 00:21:02 +0100 (CET)
Received: from [91.19.1.188] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NrJao-00075p-00; Tue, 16 Mar 2010 00:21:02 +0100
X-Mailer: git-send-email 1.7.0.2.201.gbb6c1
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+jpINDEvlIBgaOlroL5sB05cU8FOvAKM8FjCSA
	jf2JKqHa9kC21oWGV6XNoZVcYN0RhcapxolIzcKT/k4xna5E/4
	PTw20acWPnNrIl025q+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142275>

It has already been fixed in commit 454efb47 (git-gui (Win): make
"Explore Working Copy" more robust, 2009-04-01), but has been broken in
commit 21985a11 (git-gui: handle non-standard worktree locations,
2010-01-23) by accidentally replacing too much with a new variable.

The problem can be reproduced when starting git-gui from within a
subdirectory. The solution is to convert the path name, explorer.exe is
invoked with, to a platform native name.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8996d2d..7184afa 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2101,7 +2101,7 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
-	eval exec $explorer $_gitworktree &
+	eval exec $explorer [list [file nativename $_gitworktree]] &
 }
 
 set is_quitting 0
-- 
1.7.0.52.gb3f79
