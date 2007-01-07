From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix show-ignore
Date: Sat,  6 Jan 2007 22:25:55 -0800
Message-ID: <11681511553281-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jan 07 07:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3RTp-0003vU-NI
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 07:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbXAGGZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 01:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbXAGGZ7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 01:25:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33774 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932419AbXAGGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 01:25:58 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id ABDAC7DC094;
	Sat,  6 Jan 2007 22:25:56 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 06 Jan 2007 22:25:55 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.g244a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36131>

Looks like I broke it in 747fa12cef73b6ca04fffaddaad7326cf546cdea
but never noticed.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5377762..1da31fd 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -536,7 +536,7 @@ sub show_ignore {
 	my $repo;
 	$SVN ||= libsvn_connect($SVN_URL);
 	my $r = defined $_revision ? $_revision : $SVN->get_latest_revnum;
-	libsvn_traverse_ignore(\*STDOUT, $SVN->{svn_path}, $r);
+	libsvn_traverse_ignore(\*STDOUT, '', $r);
 }
 
 sub graft_branches {
-- 
1.5.0.rc0.g244a7
