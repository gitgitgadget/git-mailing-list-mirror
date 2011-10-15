From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/6] git-p4: stop ignoring apple filetype
Date: Sat, 15 Oct 2011 11:59:08 -0400
Message-ID: <20111015155908.GE29436@arf.padd.com>
References: <20111015155358.GA29436@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 17:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF6eD-0001XC-RD
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 17:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab1JOP7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 11:59:37 -0400
Received: from honk.padd.com ([74.3.171.149]:35790 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab1JOP7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 11:59:37 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 8B8C02822;
	Sat, 15 Oct 2011 08:59:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0C8AD31465; Sat, 15 Oct 2011 11:59:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20111015155358.GA29436@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183667>

Currently "apple" filetype is ignored explicitly, and the file is
not even included in the git repository.  This seems wrong.
Remove this, letting it be treated like a "binary" filetype.

Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 0490ca5..6b91595 100755
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
