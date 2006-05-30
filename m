From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: remove assertion that broke with older versions of svn
Date: Mon, 29 May 2006 19:03:46 -0700
Message-ID: <1148954626357-git-send-email-normalperson@yhbt.net>
References: <20060529063543.GA8128@localdomain>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 30 04:03:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FktaP-00070A-17
	for gcvg-git@gmane.org; Tue, 30 May 2006 04:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWE3CDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 22:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWE3CDs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 22:03:48 -0400
Received: from hand.yhbt.net ([66.150.188.102]:22196 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750777AbWE3CDr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 22:03:47 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 935697DC021; Mon, 29 May 2006 19:03:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <20060529063543.GA8128@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21007>

svn < 1.3.x would display changes to keywords lines as modified
if they aren't expanded in the working copy.  We already check
for changes against the git tree here, so checking against the
svn one is probably excessive.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

b430de64cb228512b9a817499203827c0ef645aa
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index b3e0684..aac8779 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -567,7 +567,6 @@ sub precommit_check {
 sub svn_checkout_tree {
 	my ($svn_rev, $treeish) = @_;
 	my $from = file_to_s("$REV_DIR/$svn_rev");
-	assert_svn_wc_clean($svn_rev);
 	assert_tree($from);
 	print "diff-tree $from $treeish\n";
 	my $pid = open my $diff_fh, '-|';
-- 
1.3.2.g7d11
