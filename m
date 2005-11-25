From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] config.c: remove unnecessary header in minimum configuration file.
Date: Fri, 25 Nov 2005 14:22:27 -0800
Message-ID: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 25 23:23:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eflxh-0002CW-4X
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 23:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVKYWW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 17:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVKYWW3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 17:22:29 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10739 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751489AbVKYWW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 17:22:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051125222101.ZQJO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 17:21:01 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12753>

It is just silly to start the file called "config" with a
comment that says "This is the config file."

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 config.c               |    8 --------
 t/t1300-repo-config.sh |   20 --------------------
 2 files changed, 0 insertions(+), 28 deletions(-)

applies-to: f316bfd81eaa2064c1d9e01a336eaed8d7a5bd4f
55c2454c6f18323b5ff04504593603848084aa4d
diff --git a/config.c b/config.c
index 5cc8535..52659f9 100644
--- a/config.c
+++ b/config.c
@@ -445,12 +445,6 @@ int git_config_set_multivar(const char* 
 	 * If .git/config does not exist yet, write a minimal version.
 	 */
 	if (stat(config_filename, &st)) {
-		static const char contents[] =
-			"#\n"
-			"# This is the config file\n"
-			"#\n"
-			"\n";
-
 		free(store.key);
 
 		/* if nothing to unset, error out */
@@ -461,8 +455,6 @@ int git_config_set_multivar(const char* 
 		}
 
 		store.key = (char*)key;
-
-		write(fd, contents, sizeof(contents)-1);
 		store_write_section(fd, key);
 		store_write_pair(fd, key, value);
 	} else{
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 5e994ff..207dd3d 100644
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -12,10 +12,6 @@ test -f .git/config && rm .git/config
 git-repo-config core.penguin "little blue"
 
 cat > expect << EOF
-#
-# This is the config file
-#
-
 [core]
 	penguin = little blue
 EOF
@@ -25,10 +21,6 @@ test_expect_success 'initial' 'cmp .git/
 git-repo-config Core.Movie BadPhysics
 
 cat > expect << EOF
-#
-# This is the config file
-#
-
 [core]
 	penguin = little blue
 	Movie = BadPhysics
@@ -39,10 +31,6 @@ test_expect_success 'mixed case' 'cmp .g
 git-repo-config Cores.WhatEver Second
 
 cat > expect << EOF
-#
-# This is the config file
-#
-
 [core]
 	penguin = little blue
 	Movie = BadPhysics
@@ -55,10 +43,6 @@ test_expect_success 'similar section' 'c
 git-repo-config CORE.UPPERCASE true
 
 cat > expect << EOF
-#
-# This is the config file
-#
-
 [core]
 	penguin = little blue
 	Movie = BadPhysics
@@ -76,10 +60,6 @@ test_expect_success 'replace with non-ma
 	'git-repo-config core.penguin "very blue" !kingpin'
 
 cat > expect << EOF
-#
-# This is the config file
-#
-
 [core]
 	penguin = very blue
 	Movie = BadPhysics
---
0.99.9.GIT
