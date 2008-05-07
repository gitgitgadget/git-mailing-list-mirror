From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] Makefile: update the default build options for AIX
Date: Wed,  7 May 2008 09:35:55 +0100
Message-ID: <1210149355875-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, mike.ralphson@gmail.com,
	Mike Ralphson <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 10:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtf3s-0002lu-JH
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbYEGIav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbYEGIav
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:30:51 -0400
Received: from [82.109.193.99] ([82.109.193.99]:9598 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754782AbYEGIat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 04:30:49 -0400
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2008 04:30:49 EDT
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id C3CD3130CDD; Wed,  7 May 2008 09:35:55 +0100 (BST)
X-Mailer: git-send-email 1.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81415>

NO_MKDTEMP is required to build, FREAD_READS_DIRECTORIES and the definition
of _LARGE_FILES fix test suite failures and INTERNAL_QSORT is required for
adequate performance.

Tested on AIX v5.3 Maintenance Level 06

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 7c70b00..4296656 100644
--- a/Makefile
+++ b/Makefile
@@ -632,8 +632,12 @@ endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
+	NO_MKDTEMP = YesPlease
 	NO_STRLCPY = YesPlease
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
+	BASIC_CFLAGS += -D_LARGE_FILES
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
-- 
1.5.5.1.dirty
