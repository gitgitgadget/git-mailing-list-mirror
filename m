From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 6/8] lib-git-svn.sh: Fix quoting issues with paths containing shell metacharacters
Date: Tue,  8 Apr 2008 21:30:02 -0400
Message-ID: <1207704604-30393-6-git-send-email-bdonlan@fushizen.net>
References: <>
 <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjPAD-0007qD-PW
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbYDIBbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbYDIBbB
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:31:01 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49028 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYDIBbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:31:00 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dK-Ff; Wed, 09 Apr 2008 01:30:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007vF-KI; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79062>

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/lib-git-svn.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 9decd2e..1b37ba8 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -7,9 +7,9 @@ then
 	exit
 fi
 
-GIT_DIR=$PWD/.git
-GIT_SVN_DIR=$GIT_DIR/svn/git-svn
-SVN_TREE=$GIT_SVN_DIR/svn-tree
+GIT_DIR="$PWD/.git"
+GIT_SVN_DIR="$GIT_DIR/svn/git-svn"
+SVN_TREE="$GIT_SVN_DIR/svn-tree"
 
 svn >/dev/null 2>&1
 if test $? -ne 1
@@ -19,13 +19,14 @@ then
     exit
 fi
 
-svnrepo=$PWD/svnrepo
+svnrepo="$PWD/svnrepo"
+export svnrepo
 
 perl -w -e "
 use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
-system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or exit(41);
+system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
 " >&3 2>&4
 x=$?
 if test $x -ne 0
-- 
1.5.5.8.gbbd98
