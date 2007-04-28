From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/5] Make xstrndup common
Date: Sat, 28 Apr 2007 13:05:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704281303371.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 19:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhqNQ-0001U8-BU
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbXD1RGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbXD1RFe
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:05:34 -0400
Received: from iabervon.org ([66.92.72.58]:4831 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161861AbXD1RFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:05:06 -0400
Received: (qmail 7641 invoked by uid 1000); 28 Apr 2007 17:05:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2007 17:05:05 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45787>

It was implemented in commit.c; move it with the other x memory functions.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 commit.c          |    8 --------
 git-compat-util.h |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index f1ba972..aa7059c 100644
--- a/commit.c
+++ b/commit.c
@@ -718,14 +718,6 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static char *xstrndup(const char *text, int len)
-{
-	char *result = xmalloc(len + 1);
-	memcpy(result, text, len);
-	result[len] = '\0';
-	return result;
-}
-
 static void fill_person(struct interp *table, const char *msg, int len)
 {
 	int start, end, tz = 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index 2c84016..615c353 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -197,6 +197,14 @@ static inline void *xmalloc(size_t size)
 	return ret;
 }
 
+static inline char *xstrndup(const char *str, int len)
+{
+	char *ret = xmalloc(len + 1);
+	memcpy(ret, str, len);
+	ret[len] = '\0';
+	return ret;
+}
+
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
-- 
1.5.1.2.255.g6ead4-dirty
