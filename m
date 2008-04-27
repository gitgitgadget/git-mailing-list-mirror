From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Document functions xmemdupz(), xread() and xwrite()
Date: Sun, 27 Apr 2008 12:48:30 +0300
Message-ID: <20080427094830.GA23670@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 11:49:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq3Vf-0005qN-Fp
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 11:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYD0Jsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 05:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbYD0Jsc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 05:48:32 -0400
Received: from zakalwe.fi ([80.83.5.154]:56705 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbYD0Jsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 05:48:31 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id B854F2BC8E; Sun, 27 Apr 2008 12:48:30 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80436>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
This is version 2 of the documentation patch. Compared to version 1,
xwrite() behavior is documented explicitly.

 git-compat-util.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a18235e..167c3fe 100644
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
@@ -340,6 +351,11 @@ static inline ssize_t xread(int fd, void *buf, size_t len)
 	}
 }
 
+/*
+ * xwrite() is the same a write(), but it automatically restarts write()
+ * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
+ * GUARANTEE that "len" bytes is written even if the operation is successful.
+ */
 static inline ssize_t xwrite(int fd, const void *buf, size_t len)
 {
 	ssize_t nr;
-- 
1.5.4.4
