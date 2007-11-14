From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] git-commit: Pass commit SHA-1 hash to post-commit hook.
Date: Wed, 14 Nov 2007 11:29:36 +1100
Message-ID: <11950001762286-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, Kristis Makris <kristis.makris@asu.edu>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6Jy-0004b0-5u
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760497AbXKNAlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760438AbXKNAlS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:41:18 -0500
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:15922 "EHLO
	ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760081AbXKNAlR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 19:41:17 -0500
X-IronPort-AV: E=Sophos;i="4.21,412,1188743400"; 
   d="scan'208";a="227200585"
Received: from ppp121-44-17-138.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.17.138])
  by ipmail02.adl2.internode.on.net with ESMTP; 14 Nov 2007 10:59:40 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64931>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 Documentation/hooks.txt |    4 ++--
 git-commit.sh           |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index f110162..d5b18f1 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -81,8 +81,8 @@ The default 'commit-msg' hook, when enabled, detects duplicate
 post-commit
 -----------
 
-This hook is invoked by `git-commit`.  It takes no
-parameter, and is invoked after a commit is made.
+This hook is invoked by `git-commit`.  It is passed one
+parameter (the new commit's SHA-1 hash), and is invoked after a commit is made.
 
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-commit`.
diff --git a/git-commit.sh b/git-commit.sh
index 4853397..fff58cb 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -616,7 +616,7 @@ then
 	git gc --auto
 	if test -x "$GIT_DIR"/hooks/post-commit
 	then
-		"$GIT_DIR"/hooks/post-commit
+		"$GIT_DIR"/hooks/post-commit $commit
 	fi
 	if test -z "$quiet"
 	then
-- 
1.5.3.1
