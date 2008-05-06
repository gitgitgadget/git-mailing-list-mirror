From: Sebastian Schuberth <sschuberth@visageimaging.com>
Subject: [PATCH] mergetool: Make ECMerge use the settings as specified by
 the user in the GUI
Date: Tue, 06 May 2008 12:53:56 +0200
Message-ID: <482038C4.6050402@visageimaging.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 13:25:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtLIS-0002mk-7s
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 13:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYEFLYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 07:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYEFLYg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 07:24:36 -0400
Received: from iris-63.mc.com ([63.96.239.141]:42528 "EHLO mc.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752483AbYEFLYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 07:24:35 -0400
X-Greylist: delayed 1833 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 May 2008 07:24:35 EDT
Received: from CHM-EMAIL2.ad.mc.com by mc.com (8.8.8+Sun/SMI-SVR4)
	id GAA16652; Tue, 6 May 2008 06:53:57 -0400 (EDT)
Received: from ber-email1.ad.mc.com ([192.168.212.30]) by CHM-EMAIL2.ad.mc.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 May 2008 06:53:57 -0400
Received: from [192.168.213.119] ([192.168.213.119]) by ber-email1.ad.mc.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 May 2008 12:53:56 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
X-OriginalArrivalTime: 06 May 2008 10:53:56.0446 (UTC) FILETIME=[7B41C7E0:01C8AF67]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81352>

When run from the command line, ECMerge does not automatically use the same
settings for a merge / diff that it would use when starting the GUI and loading
files manually. In the first case the built-in factory defaults would be used,
while in the second case the settings the user has specified in the GUI would
be used, which can be misleading. Specifying the "--default" command line
option changes this behavior so that always the user specfified GUI settings
are used.

Signed-off-by: Sebastian Schuberth <sschuberth@visageimaging.com>
---
 git-mergetool.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 5c86f69..fcdec4a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -237,9 +237,9 @@ merge_file () {
 	ecmerge)
 	    touch "$BACKUP"
 	    if base_present; then
-		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --mode=merge3 --to="$MERGED"
+		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"
 	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" --mode=merge2 --to="$MERGED"
+		"$merge_tool_path" "$LOCAL" "$REMOTE" --default --mode=merge2 --to="$MERGED"
 	    fi
 	    check_unchanged
 	    ;;
-- 
1.5.5.GIT
