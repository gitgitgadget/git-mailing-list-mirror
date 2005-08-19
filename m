From: Amos Waterland <apw@rossby.metr.ou.edu>
Subject: [PATCH] Make git pull default to origin
Date: Fri, 19 Aug 2005 17:14:45 -0500
Message-ID: <20050819221445.GA97789@rossby.metr.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 00:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6FCF-00013x-On
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 00:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVHSWSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVHSWSk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 18:18:40 -0400
Received: from rossby.metr.ou.edu ([129.15.192.80]:43782 "EHLO
	rossby.metr.ou.edu") by vger.kernel.org with ESMTP id S932323AbVHSWSk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 18:18:40 -0400
Received: from rossby.metr.ou.edu (localhost.metr.ou.edu [127.0.0.1])
	by rossby.metr.ou.edu (8.12.9p2/8.12.9) with ESMTP id j7JMEj5L097824;
	Fri, 19 Aug 2005 17:14:45 -0500 (CDT)
	(envelope-from apw@rossby.metr.ou.edu)
Received: (from apw@localhost)
	by rossby.metr.ou.edu (8.12.9p2/8.12.9/Submit) id j7JMEjau097823;
	Fri, 19 Aug 2005 17:14:45 -0500 (CDT)
	(envelope-from apw)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Currently, typing `git pull' without a third argument will result in an
error message.  Make it default to orgin, which is what the user
typically means.

Signed-off-by: Amos Waterland <apw@rossby.metr.ou.edu>

---

 git-pull-script |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

de9b7753b008a1dc1bdd46f87c76ee3cd9a81d19
diff --git a/git-pull-script b/git-pull-script
--- a/git-pull-script
+++ b/git-pull-script
@@ -1,10 +1,17 @@
 #!/bin/sh
 #
 . git-sh-setup-script || die "Not a git archive"
-. git-parse-remote "$@"
+
+if [ $# -eq 0 ]; then
+    remote="origin"
+else
+    remote="$@"
+fi
+
+. git-parse-remote "$remote"
 merge_name="$_remote_name"
 
-git-fetch-script "$@" || exit 1
+git-fetch-script "$remote" || exit 1
 
 git-resolve-script \
 	"$(cat "$GIT_DIR"/HEAD)" \
