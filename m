X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: update git-clone man page with new behavior
Date: Fri, 8 Dec 2006 01:27:21 -0500
Message-ID: <20061208062721.GF5939@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 06:27:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33662>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsZCg-0002Kf-BX for gcvg-git@gmane.org; Fri, 08 Dec
 2006 07:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424728AbWLHG1X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 01:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424756AbWLHG1X
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 01:27:23 -0500
Received: from mail.fieldses.org ([66.93.2.214]:54793 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424728AbWLHG1X (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 01:27:23 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsZCb-0004Bh-V7; Fri, 08 Dec 2006
 01:27:21 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Update git-clone man page to reflect recent changes
(--use-separate-remote default and use of .git/config instead of
remotes files), and rewrite introduction.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/git-clone.txt |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index d5efa00..985043f 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -16,22 +16,21 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Clones a repository into a newly created directory.  All remote
-branch heads are copied under `$GIT_DIR/refs/heads/`, except
-that the remote `master` is also copied to `origin` branch.
 
-In addition, `$GIT_DIR/remotes/origin` file is set up to have
-this line:
+Clones a repository into a newly created directory, creates
+remote-tracking branches for each branch in the cloned repository
+(visible using `git branch -r`), and creates and checks out a master
+branch equal to the cloned repository's master branch.
 
-	Pull: master:origin
-
-This is to help the typical workflow of working off of the
-remote `master` branch.  Every time `git pull` without argument
-is run, the progress on the remote `master` branch is tracked by
-copying it into the local `origin` branch, and merged into the
-branch you are currently working on.  Remote branches other than
-`master` are also added there to be tracked.
+After the clone, a plain `git fetch` without arguments will update
+all the remote-tracking branches, and a `git pull` without
+arguments will in addition merge the remote master branch into the
+current branch.
 
+This default configuration is achieved by creating references to
+the remote branch heads under `$GIT_DIR/refs/remotes/origin` and
+by initializing `remote.origin.url` and `remote.origin.fetch`
+configuration variables.
 
 OPTIONS
 -------
-- 
1.4.4.2.ga3cbd
