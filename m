From: Ben Jackson <ben@ben.com>
Subject: [PATCH 1/2] Add 'git svn help [cmd]' which works outside a repo.
Date: Sat, 30 May 2009 18:17:06 -0700
Message-ID: <1243732627-82282-1-git-send-email-ben@ben.com>
Cc: gitster@pobox.com, normalperson@yhbt.net, Ben Jackson <ben@ben.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 03:29:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAZrk-0001Y2-FD
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 03:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbZEaBYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 21:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbZEaBYU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 21:24:20 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:57062 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbZEaBYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 21:24:20 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 May 2009 21:24:20 EDT
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n4V1HEI5082316;
	Sat, 30 May 2009 18:17:14 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n4V1HETU082315;
	Sat, 30 May 2009 18:17:14 -0700 (PDT)
	(envelope-from bjj)
X-Mailer: git-send-email 1.6.3.GIT
X-Virus-Scanned: ClamAV 0.93.3/9407/Sat May 30 10:37:30 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120372>

Previously there was no explicit 'help' command, but 'git svn help'
still printed the usage message (as an invalid command), provided you
got past the initialization steps that required a valid repo.

Signed-off-by: Ben Jackson <ben@ben.com>
---

This was just a minor nit I noticed while working on the 'git-svn reset'
patch.

 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a70c7d7..20bf828 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -219,6 +219,9 @@ for (my $i = 0; $i < @ARGV; $i++) {
 		$cmd = $ARGV[$i];
 		splice @ARGV, $i, 1;
 		last;
+	} elsif ($ARGV[$i] eq 'help') {
+		$cmd = $ARGV[$i+1];
+		usage(0);
 	}
 };
 
-- 
1.6.3.GIT
