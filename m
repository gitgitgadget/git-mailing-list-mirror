From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-cherry-pick.txt et al.: Fix misleading -n
	description
Date: Wed, 16 Jul 2008 14:35:22 +0200
Message-ID: <20080716123344.5875.88693.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 14:36:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ6Fd-0001A1-C6
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 14:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbYGPMf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 08:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbYGPMf6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 08:35:58 -0400
Received: from [212.249.11.140] ([212.249.11.140]:14260 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754415AbYGPMf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 08:35:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id CAC5F2AC73C;
	Wed, 16 Jul 2008 14:35:22 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88675>

The manual page of git-cherry-pick and git-revert asserts that -n works
primarily on the working tree, while in fact the primary object it operates
on is the index, and the changes only "accidentally" propagate to the
working tree. This e.g. leads innocent #git IRC folks to believe that you
can use -n to prepare changes for git-add -i staging.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  I'm actually not *entirely* sure about the exact working tree vs. index
semantics of the -n parameter, this is a guess based on the code.
Unfortunately, I'm currently too busy with other things to check
thoroughly, and I'm sure other people on the list will know off-hand.

 Documentation/git-cherry-pick.txt |   10 +++++-----
 Documentation/git-revert.txt      |   16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index a691173..50fb3d5 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -58,14 +58,14 @@ OPTIONS
 	Usually the command automatically creates a commit with
 	a commit log message stating which commit was
 	cherry-picked.  This flag applies the change necessary
-	to cherry-pick the named commit to your working tree,
-	but does not make the commit.  In addition, when this
-	option is used, your working tree does not have to match
+	to cherry-pick the named commit to your working tree
+	and the index, but does not make the commit.  In addition,
+	when this option is used, your index does not have to match
 	the HEAD commit.  The cherry-pick is done against the
-	beginning state of your working tree.
+	beginning state of your index.
 +
 This is useful when cherry-picking more than one commits'
-effect to your working tree in a row.
+effect to your index in a row.
 
 -s::
 --signoff::
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 5411edc..271850f 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -43,16 +43,16 @@ OPTIONS
 -n::
 --no-commit::
 	Usually the command automatically creates a commit with
-	a commit log message stating which commit was reverted.
-	This flag applies the change necessary to revert the
-	named commit to your working tree, but does not make the
-	commit.  In addition, when this option is used, your
-	working tree does not have to match the HEAD commit.
-	The revert is done against the beginning state of your
-	working tree.
+	a commit log message stating which commit was
+	reverted.  This flag applies the change necessary
+	to revert the named commit to your working tree
+	and the index, but does not make the commit.  In addition,
+	when this option is used, your index does not have to match
+	the HEAD commit.  The revert is done against the
+	beginning state of your index.
 +
 This is useful when reverting more than one commits'
-effect to your working tree in a row.
+effect to your index in a row.
 
 -s::
 --signoff::
