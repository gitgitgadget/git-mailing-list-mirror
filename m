From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: minor fixups
Date: Tue, 23 May 2006 00:45:47 +1200
Message-ID: <11483019472537-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon May 22 14:40:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi9i5-0003Tb-Ee
	for gcvg-git@gmane.org; Mon, 22 May 2006 14:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEVMk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 08:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWEVMk2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 08:40:28 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:40142 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1750798AbWEVMk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 08:40:28 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Fi9hz-0004hM-2b; Tue, 23 May 2006 00:40:27 +1200
Received: from mltest ([127.0.0.1] helo=localhost.localdomain)
	by mltest with esmtp (Exim 3.36 #1 (Debian))
	id 1Fi9n9-0001Yt-00; Tue, 23 May 2006 00:45:47 +1200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0.g9927-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20500>

Cleanup @skipped after it's used. Close a fhandle. 
Removing suspects one at a time.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsimport.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

93bef2832d30c9a04e95ff348b9ab8ab8cabee98
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 2ecfe14..176b787 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -650,6 +650,8 @@ sub commit {
 			"GIT_COMMITTER_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
 			"git-commit-tree", $tree,@par);
 		die "Cannot exec git-commit-tree: $!\n";
+		
+		close OUT;
 	}
 	$pw->writer();
 	$pr->reader();
@@ -661,6 +663,7 @@ sub commit {
 	if (@skipped) {
 	    $logmsg .= "\n\n\nSKIPPED:\n\t";
 	    $logmsg .= join("\n\t", @skipped) . "\n";
+	    @skipped = ();
 	}
 
 	print $pw "$logmsg\n"
-- 
1.3.2.g82000
