From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Document git-svn's first-parent rule
Date: Mon, 16 Nov 2009 11:15:17 +0100
Message-ID: <ea845c8757a629d692bb6cd3827887f0e811c044.1258366486.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 16 11:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9ydF-0002SX-PJ
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 11:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbZKPKQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 05:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZKPKQM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 05:16:12 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:19387 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbZKPKQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 05:16:12 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 16 Nov
 2009 11:16:16 +0100
Received: from localhost.localdomain (129.132.210.143) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 16 Nov
 2009 11:16:02 +0100
X-Mailer: git-send-email 1.6.5.2.427.ge73cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132994>

git-svn has the following rule to detect the SVN base for its
operations: find the first git-svn-id line reachable through
first-parent ancestry.  IOW,

  git log --grep=^git-svn-id: --first-parent -1

Document this, as it is very important when using merges with git-svn.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-svn.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1812890..6da4151 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -735,6 +735,16 @@ merges you've made.  Furthermore, if you merge or pull from a git branch
 that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
 branch.
 
+If you do merge, note the following rule: 'git svn dcommit' will
+attempt to commit on top of the SVN commit named in
+------------------------------------------------------------------------
+git log --grep=^git-svn-id: --first-parent -1
+------------------------------------------------------------------------
+You 'must' therefore ensure that the most recent commit of the branch
+you want to dcommit to is the 'first' parent of the merge.  Chaos will
+ensue otherwise, especially if the first parent is an older commit on
+the same SVN branch.
+
 'git clone' does not clone branches under the refs/remotes/ hierarchy or
 any 'git svn' metadata, or config.  So repositories created and managed with
 using 'git svn' should use 'rsync' for cloning, if cloning is to be done
-- 
1.6.5.2.427.ge73cb
