From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/5] git-p4: stop ignoring apple filetype
Date: Sat, 17 Sep 2011 21:32:36 -0400
Message-ID: <20110918013236.GE4619@arf.padd.com>
References: <20110918012634.GA4578@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 03:32:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R56FQ-0007QW-JO
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 03:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab1IRBck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 21:32:40 -0400
Received: from honk.padd.com ([74.3.171.149]:59850 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab1IRBck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 21:32:40 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 64ED7BFC;
	Sat, 17 Sep 2011 18:32:39 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 55F0F31448; Sat, 17 Sep 2011 21:32:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110918012634.GA4578@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181597>

Currently "apple" filetype is ignored explicitly, and the file is
not even included in the git repository.  This seems wrong.
Remove this, letting it be treated like a "binary" filetype.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 931cf5f..eee288d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1247,11 +1247,6 @@ class P4Sync(Command, P4UserMap):
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
-        if file["type"] == "apple":
-            print "\nfile %s is a strange apple file that forks. Ignoring" % \
-                file['depotFile']
-            return
-
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = self.wildcard_decode(relPath)
         if verbose:
-- 
1.7.6.3
