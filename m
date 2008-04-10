From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 07/10] lib-git-svn.sh: Fix quoting issues with paths containing shell metacharacters
Date: Thu, 10 Apr 2008 02:50:13 -0400
Message-ID: <1207810216-27871-8-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-5-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-6-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-7-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:51:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjqck-0002oI-Uw
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbYDJGuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbYDJGuX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:50:23 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34025 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbYDJGuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:50:22 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wD-JF; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbx-0007G3-5B; Thu, 10 Apr 2008 02:50:17 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-7-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79172>

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/lib-git-svn.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 9decd2e..445df78 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -20,12 +20,13 @@ then
 fi
 
 svnrepo=$PWD/svnrepo
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
1.5.5.33.gc0a39.dirty
