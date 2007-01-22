From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: remove leading slash when printing removed directories
Date: Mon, 22 Jan 2007 12:25:30 -0800
Message-ID: <1169497530189-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 22 21:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H95jZ-0001Lk-9G
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbXAVUZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbXAVUZc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:25:32 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43313 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbXAVUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:25:32 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4A48A7DC094;
	Mon, 22 Jan 2007 12:25:30 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 22 Jan 2007 12:25:30 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc1.g694d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37444>

Not sure why it was there in the first place, we always do our
work relative to the URL we're connected to; even if that URL is
the root of the repository, so the leading slash is pointless...
Lets be consistent when printing things for the user to see.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b8ede9c..83ec03d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2856,7 +2856,7 @@ sub rmdirs {
 	foreach my $d (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$rm) {
 		$self->close_directory($bat->{$d}, $p);
 		my ($dn) = ($d =~ m#^(.*?)/?(?:[^/]+)$#);
-		print "\tD+\t/$d/\n" unless $q;
+		print "\tD+\t$d/\n" unless $q;
 		$self->SUPER::delete_entry($d, $r, $bat->{$dn}, $p);
 		delete $bat->{$d};
 	}
-- 
1.5.0.rc1.g694d
