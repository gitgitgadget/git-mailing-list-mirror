From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-rebase -i: have an option for amending the commit message only.
Date: Wed, 11 Jun 2008 17:01:29 +0200
Message-ID: <1213196490-7762-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 17:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6RrL-0000XR-LE
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 17:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbYFKPBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 11:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbYFKPBg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 11:01:36 -0400
Received: from pan.madism.org ([88.191.52.104]:42767 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbYFKPBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 11:01:35 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 79E6C35358;
	Wed, 11 Jun 2008 17:01:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DEB99163B5; Wed, 11 Jun 2008 17:01:30 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.128.g6656e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84616>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-rebase--interactive.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3f926d8..c1b4260 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -215,6 +215,15 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		;;
+	comment|c)
+		comment_for_reflog comment
+
+		mark_action_done
+		pick_one $sha1 ||
+			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		output git commit --no-verify --amend -e -C HEAD
+		;;
+
 	edit|e)
 		comment_for_reflog edit
 
@@ -688,6 +697,7 @@ do
 # Commands:
 #  p, pick = use commit
 #  e, edit = use commit, but stop for amending
+#  c, comment = use commit, but stop for changing the commit message
 #  s, squash = use commit, but meld into previous commit
 #  mark :mark = mark the current HEAD for later reference
 #  reset commit = reset HEAD to the commit
-- 
1.5.6.rc2.128.g6656e
