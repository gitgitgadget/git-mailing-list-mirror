From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] git-svn: Make create-ignore use git add -f
Date: Mon,  5 May 2008 00:33:09 +0200
Message-ID: <1209940390-22622-1-git-send-email-hendeby@isy.liu.se>
Cc: gitster@pobox.com, normalperson@yhbt.net,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 00:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsmmV-0002W2-As
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 00:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbYEDWdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755686AbYEDWdP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 18:33:15 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:63722 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbYEDWdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 18:33:13 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 1B6A0259AC;
	Mon,  5 May 2008 00:33:12 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 12503-01; Mon,  5 May 2008 00:33:10 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 18B322594C;
	Mon,  5 May 2008 00:33:10 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 0A99F177A2; Mon,  5 May 2008 00:33:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.246.gafa4
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81210>

When having a svn:ignore that ignores the .gitignore file the -f
option to git add must be used to avoid git complaining about adding
an ignored file and hence stop the process of creating .gitignores.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 81afb5c..d6d7b1a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -612,7 +612,7 @@ sub cmd_create_ignore {
 		print GITIGNORE "$s\n";
 		close(GITIGNORE)
 		  or fatal("Failed to close `$ignore': $!");
-		command_noisy('add', $ignore);
+		command_noisy('add', '-f', $ignore);
 	});
 }
 
-- 
1.5.5.1.246.gafa4
