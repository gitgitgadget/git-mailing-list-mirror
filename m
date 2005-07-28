From: Peter Osterlund <petero2@telia.com>
Subject: [PATCH] stgit: Handle 'A' flag for new files
Date: 28 Jul 2005 13:55:46 +0200
Message-ID: <m3d5p3kuv1.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 13:57:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy70g-0006yP-7z
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 13:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVG1L4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 07:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVG1L4b
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 07:56:31 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:24545 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261394AbVG1Lz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 07:55:58 -0400
Received: from r3000.localdomain (195.252.45.222) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 42B94E29005B0A6E; Thu, 28 Jul 2005 13:55:55 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j6SBtnQg006797;
	Thu, 28 Jul 2005 13:55:49 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j6SBtmmK006792;
	Thu, 28 Jul 2005 13:55:48 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Patches that add new files don't work correctly if git reports them
with the 'A' flag. StGIT claims there are unresolved conflicts. This
patch fixes it.

Signed-off-by: Peter Osterlund <petero2@telia.com>

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -274,7 +274,7 @@ def commit(message, files = [], parents 
         raise GitException, 'No changes to commit'
 
     # check for unresolved conflicts
-    if not first and len(filter(lambda x: x[0] not in ['M', 'N', 'D'],
+    if not first and len(filter(lambda x: x[0] not in ['M', 'N', 'A', 'D'],
                                 cache_files)) != 0:
         raise GitException, 'Commit failed: unresolved conflicts'
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
