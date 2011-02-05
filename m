From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 6/8] git-p4: better message for "git-p4 sync" when not
 cloned
Date: Sat, 5 Feb 2011 17:52:24 -0500
Message-ID: <20110205225224.GG30963@arf.padd.com>
References: <20110205224848.GA30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 23:52:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plqzf-0006bu-8Z
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 23:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877Ab1BEWwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 17:52:34 -0500
Received: from honk.padd.com ([74.3.171.149]:33464 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab1BEWwe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 17:52:34 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 9DFFAEF;
	Sat,  5 Feb 2011 14:52:32 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D512131ADE; Sat,  5 Feb 2011 17:52:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110205224848.GA30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166126>

A common error is to do "git-p4 sync" in a repository that
was not initialized by "git-p4 clone".  There will be no
p4 refs.  The error message in this case is a traceback
for an assertion, which is confusing.

Change it instead to explain the likely problem.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6b847c4..04e6c3d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1676,6 +1676,8 @@ class P4Sync(Command):
 
                 changes.sort()
             else:
+                if not self.p4BranchesInGit:
+                    die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.");
                 if self.verbose:
                     print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
                                                               self.changeRange)
-- 
1.7.2.3
