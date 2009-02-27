From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-p4: remove tabs from usermap file
Date: Fri, 27 Feb 2009 10:53:59 -0800
Message-ID: <20090227185359.GA18102@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 19:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld7rL-0002Ck-8R
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 19:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbZB0Sx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 13:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbZB0Sx1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 13:53:27 -0500
Received: from marge.padd.com ([99.188.165.110]:43450 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbZB0Sx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 13:53:26 -0500
Received: from honk.padd.com (honk.padd.com [209.17.171.228])
	by marge.padd.com (Postfix) with ESMTPSA id DDE1310F81CA;
	Fri, 27 Feb 2009 10:53:24 -0800 (PST)
Received: by honk.padd.com (Postfix, from userid 7770)
	id 1E9AF1C400B7; Fri, 27 Feb 2009 10:53:59 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111693>

Some users have tabs in their names, oddly enough.  This
causes problems when loading the usercache from disk,
as split separates the fields on the wrong tabs.  When
fast-import's parse_ident() tries to parse the committer
field, it is unhappy about the unbalanced <..> angle brackets.

It is easy enough to convert the tabs to single spaces.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
Here's another random little fix.  We have a user
Firstname\tLastname who checked something in recently and
broke my git-p4 conversion.

I need to send the other acked patch to Junio; will wait
and give him two if you ack this one.

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
