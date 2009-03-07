From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH, acked] git-p4: remove tabs from usermap file
Date: Sat, 7 Mar 2009 10:05:19 -0500
Message-ID: <20090307150519.GA29200@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 16:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfy75-0001x6-FW
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 16:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZCGPF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 10:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbZCGPF0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 10:05:26 -0500
Received: from marge.padd.com ([99.188.165.110]:48033 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbZCGPFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 10:05:25 -0500
Received: from arf.padd.com (pool-71-111-205-109.rlghnc.dsl-w.verizon.net [71.111.205.109])
	by marge.padd.com (Postfix) with ESMTPSA id 024E910F81CA;
	Sat,  7 Mar 2009 07:05:23 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 011493E446F; Sat,  7 Mar 2009 10:05:19 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112541>

Some users have tabs in their names, oddly enough.  This
causes problems when loading the usercache from disk,
as split separates the fields on the wrong tabs.  When
fast-import's parse_ident() tries to parse the committer
field, it is unhappy about the unbalanced <..> angle brackets.

It is easy enough to convert the tabs to single spaces.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-by: Simon Hausmann <simon@lst.de>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3832f60..342529d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1142,7 +1142,7 @@ class P4Sync(Command):
 
         s = ''
         for (key, val) in self.users.items():
-            s += "%s\t%s\n" % (key, val)
+	    s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
         open(self.getUserCacheFilename(), "wb").write(s)
         self.userMapFromPerforceServer = True
-- 
1.6.0.6
