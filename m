From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 13/40] Windows: Fix PRIuMAX definition.
Date: Wed, 27 Feb 2008 19:54:36 +0100
Message-ID: <1204138503-6126-14-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVY-00022R-RE
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbYB0S4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755984AbYB0S4P
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:15 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40439 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbYB0SzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:08 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 2265E976B5;
	Wed, 27 Feb 2008 19:55:06 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75282>

Since GIT calls into Microsoft's MSVCRT.DLL, it must use the printf
format that this DLL uses for 64-bit integers, which is %I64u instead
of %llu.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-compat-util.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3b57464..c576f5a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -103,7 +103,11 @@
 #endif
 
 #ifndef PRIuMAX
+#ifndef __MINGW32__
 #define PRIuMAX "llu"
+#else
+#define PRIuMAX "I64u"
+#endif
 #endif
 
 #ifdef __GNUC__
-- 
1.5.4.1.126.ge5a7d
