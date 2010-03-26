From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 05/12] Implement the rmdir_or_warn function
Date: Fri, 26 Mar 2010 15:25:33 +0000
Message-ID: <1269617140-7827-6-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQd-0005ou-Bg
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0CZP0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:00 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55548 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab0CZPZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:57 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001o6-Cm; Fri, 26 Mar 2010 15:25:54 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023G-6k; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143239>

This patch implements an rmdir_or_warn function (like unlink_or_warn
but for directories) that uses the generalised warning code in
warn_if_unremovable.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 git-compat-util.h |    4 ++++
 wrapper.c         |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a3c4537..67ea4c8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -469,5 +469,9 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  * Always returns the return value of unlink(2).
  */
 int unlink_or_warn(const char *path);
+/*
+ * Likewise for rmdir(2).
+ */
+int rmdir_or_warn(const char *path);
 
 #endif
diff --git a/wrapper.c b/wrapper.c
index 0bbff56..4017bff 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -328,3 +328,8 @@ int unlink_or_warn(const char *file)
 {
 	return warn_if_unremovable("unlink", file, unlink(file));
 }
+
+int rmdir_or_warn(const char *file)
+{
+	return warn_if_unremovable("rmdir", file, rmdir(file));
+}
-- 
1.6.5
