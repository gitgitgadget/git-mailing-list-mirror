From: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
Subject: [PATCH 1/1] Documentation/git-filter-branch: add --index-filter example
Date: Wed, 27 Apr 2011 14:08:04 -0400
Message-ID: <1303927684-6513-2-git-send-email-michael.ocleirigh@rivulet.ca>
References: <1303927684-6513-1-git-send-email-michael.ocleirigh@rivulet.ca>
Cc: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 20:08:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF99v-0000Na-4e
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 20:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab1D0SIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 14:08:16 -0400
Received: from rivulet.ca ([69.164.222.54]:51580 "EHLO smtp.rivulet.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab1D0SIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 14:08:15 -0400
Received: from rivulet.com (localhost [127.0.0.1])
	by smtp.rivulet.ca (Postfix) with ESMTP id CE649F000E;
	Wed, 27 Apr 2011 14:08:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1303927684-6513-1-git-send-email-michael.ocleirigh@rivulet.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172255>

Added an example using git ls-tree on the $GIT_COMMIT and then filtering
what should remain in the history using egrep.

This allows multiple paths accross history to be retained when filtering a branch.
---
 Documentation/git-filter-branch.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 9dc1f2a..e80bc01 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -248,6 +248,19 @@ To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
 order to paste the other history behind the current history:
 
+-----------------------------------------------------------------------------------------------------------------------------------
+git filter-branch --prune-empty --index-filter 'git ls-tree $GIT_COMMIT | egrep \
+"(top-dir-A|top-dir-B|consolidated-dir-C)" | git mktree | xargs git read-tree -i -m'
+-----------------------------------------------------------------------------------------------------------------------------------
+
+The --subdirectory-filter works great when all commits of interest have
+that path but sometimes you have a history that contains an irregular 
+structure. i.e. that was reorganized at some point and you would like to 
+keep the prior history.
+
+For each commit the top-dir-A, top-dir-B and consolidated-dir-C paths (if they exist)
+are kept (and everything else discarded). 
+
 -------------------------------------------------------------------
 git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' HEAD
 -------------------------------------------------------------------
-- 
1.7.2.3
