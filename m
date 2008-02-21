From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] A test for commit --amend allowing changing of a very
	empty commit message
Date: Thu, 21 Feb 2008 20:54:38 +0100
Message-ID: <20080221195438.GA6973@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 20:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSHVz-0002en-Lu
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 20:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759074AbYBUTyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 14:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757796AbYBUTyn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 14:54:43 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:60957 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbYBUTym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 14:54:42 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFhynk=
Received: from tigra.home (Fad6a.f.strato-dslnet.de [195.4.173.106])
	by post.webmailer.de (klopstock mo51) (RZmta 16.8)
	with ESMTP id a03fd7k1LJrcTz for <git@vger.kernel.org>;
	Thu, 21 Feb 2008 20:54:39 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 30910277BD
	for <git@vger.kernel.org>; Thu, 21 Feb 2008 20:54:39 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 41D3F56D24; Thu, 21 Feb 2008 20:54:38 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74647>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Well, it fails... In current master

 t/t7501-commit.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 361886c..f81bf7b 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -345,4 +345,14 @@ test_expect_success 'amend using the message from a commit named with tag' '
 
 '
 
+test_expect_success 'allow amend of an empty message' '
+
+	git reset --hard &&
+	sha=$(:|git commit-tree HEAD^{tree} -p HEAD) &&
+	git reset --hard $sha &&
+	git commit --amend -mChanged &&
+	git cat-file commit HEAD|tail -n1|grep ^Changed$
+
+'
+
 test_done
-- 
1.5.4.2.204.g6d0ab
