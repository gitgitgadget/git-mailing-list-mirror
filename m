From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 10/11] setup.c: document get_pathspec()
Date: Sun,  6 Jan 2013 16:58:12 +0000
Message-ID: <1357491493-11619-11-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:58:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYa-0007mE-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab3AFQ6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:25 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45596 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab3AFQ6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:22 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 9C43B2E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:21 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212818>

Since we have just created a new pathspec-handling library, now is a
good time to add some comments explaining get_pathspec().

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
The deprecation warning is new since v3.

 setup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/setup.c b/setup.c
index 7663a4c..9570147 100644
--- a/setup.c
+++ b/setup.c
@@ -249,6 +249,25 @@ static const char *prefix_pathspec(const char *prefix, int prefixlen, const char
 		return prefix_path(prefix, prefixlen, copyfrom);
 }
 
+/*
+ * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
+ * based interface - see pathspec_magic above.
+ *
+ * Arguments:
+ *  - prefix - a path relative to the root of the working tree
+ *  - pathspec - a list of paths underneath the prefix path
+ *
+ * Iterates over pathspec, prepending each path with prefix,
+ * and return the resulting list.
+ *
+ * If pathspec is empty, return a singleton list containing prefix.
+ *
+ * If pathspec and prefix are both empty, return an empty list.
+ *
+ * This is typically used by built-in commands such as add.c, in order
+ * to normalize argv arguments provided to the built-in into a list of
+ * paths to process, all relative to the root of the working tree.
+ */
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
-- 
1.7.11.7.33.gb8feba5
