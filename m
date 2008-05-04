From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 07/10] lib-git-svn.sh: Fix quoting issues with paths containing shell metacharacters
Date: Sun,  4 May 2008 01:37:57 -0400
Message-ID: <1209879480-16910-8-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-4-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-5-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-6-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-7-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWwf-0004V4-FO
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbYEDFiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbYEDFiU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:38:20 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37793 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbYEDFiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:38:18 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Mj-Uh; Sun, 04 May 2008 05:38:07 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvB-0004PJ-7v; Sun, 04 May 2008 01:38:01 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-7-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81136>

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
1.5.5.1.128.g03a943
