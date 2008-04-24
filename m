From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Document functions xmemdupz(), xread() and xwrite()
Date: Fri, 25 Apr 2008 02:58:23 +0300
Message-ID: <20080424235823.GA22898@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 01:59:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpBLM-0001MC-8C
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 01:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYDXX6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 19:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbYDXX6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 19:58:25 -0400
Received: from zakalwe.fi ([80.83.5.154]:55283 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbYDXX6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 19:58:24 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id B4B272BC8E; Fri, 25 Apr 2008 02:58:23 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80317>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 git-compat-util.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a18235e..7498bee 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -268,6 +268,12 @@ static inline void *xmalloc(size_t size)
 	return ret;
 }
 
+/*
+ * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" bytes of
+ * "data" to the allocated memory, zero terminates the allocated memory,
+ * and returns a pointer to the allocated memory. If the allocation fails,
+ * the program dies.
+ */
 static inline void *xmemdupz(const void *data, size_t len)
 {
 	char *p = xmalloc(len + 1);
@@ -329,6 +335,11 @@ static inline void *xmmap(void *start, size_t length,
 	return ret;
 }
 
+/*
+ * xread() is the same a read(), but it automatically restarts read()
+ * operations with a recoverable error (EAGAIN and EINTR). xread()
+ * DOES NOT GUARANTEE that "len" bytes is read even if the data is available.
+ */
 static inline ssize_t xread(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
@@ -340,6 +351,9 @@ static inline ssize_t xread(int fd, void *buf, size_t len)
 	}
 }
 
+/*
+ * xwrite() is similar to xread()
+ */
 static inline ssize_t xwrite(int fd, const void *buf, size_t len)
 {
 	ssize_t nr;
-- 
1.5.4.4
