From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: pass an unambiguous ref to rev-list when grafting-branches
Date: Sun,  7 Jan 2007 19:35:41 -0800
Message-ID: <11682273424039-git-send-email-normalperson@yhbt.net>
References: <11682273413995-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 08 04:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3lIZ-00052k-5Y
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 04:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbXAHDfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 22:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbXAHDfp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 22:35:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34338 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030477AbXAHDfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 22:35:44 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2EF2A7DC099;
	Sun,  7 Jan 2007 19:35:43 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 07 Jan 2007 19:35:43 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.ge21b-dirty
In-Reply-To: <11682273413995-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36233>

Some users apparently create local heads with the same basename
as the remote branch they're tracking.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a092be8..56f1700 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1086,7 +1086,7 @@ sub graft_merge_msg {
 	my ($grafts, $l_map, $u, $p, @re) = @_;
 
 	my $x = $l_map->{$u}->{$p};
-	my $rl = rev_list_raw($x);
+	my $rl = rev_list_raw("refs/remotes/$x");
 	while (my $c = next_rev_list_entry($rl)) {
 		foreach my $re (@re) {
 			my (@br) = ($c->{m} =~ /$re/g);
-- 
1.5.0.rc0.ge21b-dirty
