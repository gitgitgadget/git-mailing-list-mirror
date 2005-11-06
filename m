From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow GIT_DIR to be an absolute path
Date: Mon, 7 Nov 2005 00:36:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511070034160.23992@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 07 00:36:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYu3j-0005R7-2Q
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 00:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVKFXgS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 18:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVKFXgS
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 18:36:18 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32722 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932365AbVKFXgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 18:36:16 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E5F6013EF4B; Mon,  7 Nov 2005 00:36:15 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB95E9F1B5; Mon,  7 Nov 2005 00:36:15 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B7511913EA; Mon,  7 Nov 2005 00:36:15 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7AEEA13EF4B; Mon,  7 Nov 2005 00:36:15 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11238>


This fixes a problem in safe_create_leading_directories() when the
argument starts with a '/' (i.e. the path is absolute).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I did not thoroughly check if there are more places where a 
	relative path is assumed. Could well be the only one.

 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 8a2743d0d424a3bc0ff120cdba66ee20b59f5a56
e1f7e03e178889c53367745810130ef3e933d2aa
diff --git a/sha1_file.c b/sha1_file.c
index 642f00d..544db4e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -50,7 +50,7 @@ int get_sha1_hex(const char *hex, unsign
 
 int safe_create_leading_directories(char *path)
 {
-	char *pos = path;
+	char *pos = path+1;
 
 	while (pos) {
 		pos = strchr(pos, '/');
---
0.99.9.GIT
