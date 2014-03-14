From: ubuntu733 <ubuntu2012@126.com>
Subject: [PATCH] microproject for GSOC
Date: Sat, 15 Mar 2014 00:42:47 +0800
Message-ID: <1394815367-9706-1-git-send-email-ubuntu2012@126.com>
Cc: ubuntu733 <ubuntu2012@126.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 17:43:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOVCG-00053Q-8Q
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 17:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbaCNQmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 12:42:55 -0400
Received: from m15-111.126.com ([220.181.15.111]:37431 "EHLO m15-111.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809AbaCNQmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 12:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=k/ueVhxGFna5olyqdb
	qo/CeU7AaZOCQG8fwcUN0d/GI=; b=BRl4uzs9S4adpDGMBAEARgDQPhWGNDaC1w
	NpMY+mpVV2+vt/D3f9BwqBK/lqGJLSgggBqOzzx2nCNocXwV6iK1gyzVs5EZwOYG
	M6N/FcK6cfGkdFoCbjKOIvMhNHb81QBi5L0DLEjME9g4IHbZSuZwM5KAjho08WtI
	OmxPVKpYo=
Received: from localhost (unknown [125.71.195.57])
	by smtp1 (Coremail) with SMTP id C8mowEBpWluJMSNTLMP1AA--.440S2;
	Sat, 15 Mar 2014 00:42:50 +0800 (CST)
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: C8mowEBpWluJMSNTLMP1AA--.440S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr48tFWkuryfJF4xGw48JFb_yoW8Ary3pF
	sxK3s8Kr40yF47u3s7Xa1UCwnxK3yqgr47CrWUCwnxZ3s0g3yjqFWFgF1a9F15JrZ7u347
	XF4Yqrn5ZF45KF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi_MarUUUUU=
X-Originating-IP: [125.71.195.57]
X-CM-SenderInfo: hxex03jxsqija6rslhhfrp/1tbiFAVOqE0vLnSy2wAAsm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244093>

Apply for GSOC.The microprojects is rewriter diff-index.c

Signed-off-by: ubuntu733 <ubuntu2012@126.com>
---
 diff-no-index.c |   11 ++++++-----
 dir.h           |    3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..91ece64 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2007 by Johannes Schindelin
  * Copyright (c) 2008 by Junio C Hamano
  */
-
+#define REMOVE 1
 #include "cache.h"
 #include "color.h"
 #include "commit.h"
@@ -24,10 +24,11 @@ static int read_directory(const char *path, struct string_list *list)
 	if (!(dir = opendir(path)))
 		return error("Could not open directory %s", path);
 
-	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
-			string_list_insert(list, e->d_name);
-
+	while ((e = readdir(dir))) {
+		while(is_dot_or_dotdot(e->d_name))
+                      break;
+		string_list_insert(list, e->d_name);
+              }
 	closedir(dir);
 	return 0;
 }
diff --git a/dir.h b/dir.h
index 55e5345..1d68818 100644
--- a/dir.h
+++ b/dir.h
@@ -138,8 +138,9 @@ extern int match_pathspec(const struct pathspec *pathspec,
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
 extern int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec);
+#ifndef REMOVE
 extern int read_directory(struct dir_struct *, const char *path, int len, const struct pathspec *pathspec);
-
+#endif
 extern int is_excluded_from_list(const char *pathname, int pathlen, const char *basename,
 				 int *dtype, struct exclude_list *el);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len);
-- 
1.7.9.5
