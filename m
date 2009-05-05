From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] Fix sloppy Getopt::Long.
Date: Tue,  5 May 2009 11:16:14 -0700
Message-ID: <1241547374-6737-1-git-send-email-robbat2@gentoo.org>
Cc: "Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 20:16:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1PBz-0001ly-VP
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 20:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbZEESQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbZEESQV
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 14:16:21 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:35086 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753341AbZEESQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 14:16:20 -0400
Received: (qmail 7849 invoked from network); 5 May 2009 18:16:17 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 05 May 2009 18:16:17 +0000
Received: (qmail 26670 invoked from network); 5 May 2009 11:16:14 -0700
Received: from unknown (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by 172.16.9.1 with SMTP; 5 May 2009 11:16:14 -0700
Received: (nullmailer pid 6769 invoked by uid 0);
	Tue, 05 May 2009 18:16:14 -0000
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118307>

Getopt-Long v2.38 is much stricter about sloppy getopt usage. The
trailing pipe causes git-svn testcases to fail for all of the --stdin
argument calls.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

===
Should be applied to both the stable 1.6.2.x tree and the new 1.6.3
tree.
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c5965c9..ef1d30d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -147,7 +147,7 @@ my %cmd = (
 	           'dry-run|n' => \$_dry_run } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
-			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
+			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'create-ignore' => [ \&cmd_create_ignore,
 			     'Create a .gitignore per svn:ignore',
 			     { 'revision|r=i' => \$_revision
-- 
1.6.2.3
