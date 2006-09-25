From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Allow '(no author)' in git-svn's authors file.
Date: Sun, 24 Sep 2006 23:04:55 -0400
Message-ID: <20060925030455.GA15745@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 05:05:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRgmG-0008Io-9m
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 05:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWIYDFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 23:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWIYDFA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 23:05:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22183 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751009AbWIYDE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 23:04:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GRglx-0006Bc-JD
	for git@vger.kernel.org; Sun, 24 Sep 2006 23:04:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1DF2620FB16; Sun, 24 Sep 2006 23:04:55 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27723>

When trying to import an SVN revision which has no author the Git
user may desire to relabel '(no author)' to another name and email
address with their svn.authorsfile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 8a2ef99..017f45a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2171,7 +2171,7 @@ sub load_authors {
 	open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
 	while (<$authors>) {
 		chomp;
-		next unless /^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/;
+		next unless /^(\S+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
 		my ($user, $name, $email) = ($1, $2, $3);
 		$users{$user} = [$name, $email];
 	}
-- 
1.4.2.1.gde2b2-dirty
