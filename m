From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: find-rev allows short switches for near matches
Date: Sun, 7 Sep 2014 08:35:19 +0000
Message-ID: <20140907083519.GA11302@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 10:35:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQXwf-0000CX-HK
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 10:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbaIGIfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 04:35:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49853 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbaIGIfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 04:35:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 50D9F1FD5A;
	Sun,  7 Sep 2014 08:35:20 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256616>

Allow -B and -A to act as short aliases for --before and --after
options respectively.  This reduces typing and hopefully allows
reuse of muscle memory for grep(1) users.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Will push to git://bogomips.org/git-svn.git

 Documentation/git-svn.txt | 2 ++
 git-svn.perl              | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 14036cf..ef8ef1c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -386,11 +386,13 @@ Any other arguments are passed directly to 'git log'
 	tree-ish to specify which branch should be searched).  When given a
 	tree-ish, returns the corresponding SVN revision number.
 +
+-B;;
 --before;;
 	Don't require an exact match if given an SVN revision, instead find
 	the commit corresponding to the state of the SVN repository (on the
 	current branch) at the specified revision.
 +
+-A;;
 --after;;
 	Don't require an exact match if given an SVN revision; if there is
 	not an exact match return the closest match searching forward in the
diff --git a/git-svn.perl b/git-svn.perl
index 47cd6ea..a0ca31d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -260,8 +260,8 @@ my %cmd = (
 			} ],
 	'find-rev' => [ \&cmd_find_rev,
 	                "Translate between SVN revision numbers and tree-ish",
-			{ 'before' => \$_before,
-			  'after' => \$_after } ],
+			{ 'B|before' => \$_before,
+			  'A|after' => \$_after } ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
 			  'verbose|v' => \$_verbose,
-- 
EW
