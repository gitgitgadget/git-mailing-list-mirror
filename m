From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/5] path.c: Remove the 'git_' prefix from a file scope function
Date: Tue, 04 Sep 2012 18:26:30 +0100
Message-ID: <504639C6.8000009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8ySo-0001QU-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609Ab2IDTHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:00 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40912 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932540Ab2IDTG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:06:59 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id F080C128077;
	Tue,  4 Sep 2012 20:06:58 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 5B64C128075;	Tue,  4 Sep 2012 20:06:58 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:06:57 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204768>


In particular, the git_vsnpath() function, despite the 'git_' prefix
suggesting otherwise, is (correctly) declared with file scope.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 path.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/path.c b/path.c
index 66acd24..9eb5333 100644
--- a/path.c
+++ b/path.c
@@ -48,7 +48,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	return cleanup_path(buf);
 }
 
-static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_list args)
+static char *vsnpath(char *buf, size_t n, const char *fmt, va_list args)
 {
 	const char *git_dir = get_git_dir();
 	size_t len;
@@ -72,7 +72,7 @@ char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	(void)git_vsnpath(buf, n, fmt, args);
+	(void)vsnpath(buf, n, fmt, args);
 	va_end(args);
 	return buf;
 }
@@ -82,7 +82,7 @@ char *git_pathdup(const char *fmt, ...)
 	char path[PATH_MAX];
 	va_list args;
 	va_start(args, fmt);
-	(void)git_vsnpath(path, sizeof(path), fmt, args);
+	(void)vsnpath(path, sizeof(path), fmt, args);
 	va_end(args);
 	return xstrdup(path);
 }
-- 
1.7.12
