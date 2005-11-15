From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Add git-config-set, a simple helper for scripts to set
 config variables
Date: Tue, 15 Nov 2005 22:36:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511152236200.2152@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Nov 15 22:37:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8Ty-00062f-3V
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVKOVgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVKOVgl
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:36:41 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11212 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750985AbVKOVgk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:36:40 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 64F3B13F704; Tue, 15 Nov 2005 22:36:39 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 497BA9F2FB; Tue, 15 Nov 2005 22:36:39 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2F65A9F2F8; Tue, 15 Nov 2005 22:36:39 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 148B613F715; Tue, 15 Nov 2005 22:36:39 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11941>

This is meant for the end user, who cannot be expected to edit
.git/config by hand.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

 Makefile     |    3 ++-
 config-set.c |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)
 create mode 100644 config-set.c

applies-to: 182b0cedc3aa9a6d4afb3331a9c9472306cf77c6
ef6b137c5b90c3d0cba100d39b0fd7ed9de0dad8
diff --git a/Makefile b/Makefile
index d20cf66..55f4d44 100644
--- a/Makefile
+++ b/Makefile
@@ -125,7 +125,8 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	git-name-rev$X git-pack-redundant$X $(SIMPLE_PROGRAMS)
+	git-name-rev$X git-pack-redundant$X git-config-set$X \
+	$(SIMPLE_PROGRAMS)
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
diff --git a/config-set.c b/config-set.c
new file mode 100644
index 0000000..fe024da
--- /dev/null
+++ b/config-set.c
@@ -0,0 +1,16 @@
+#include "cache.h"
+
+static const char git_config_set_usage[] =
+"git-config-set name value";
+
+int main(int argc, const char **argv)
+{
+	setup_git_directory();
+	switch (argc) {
+	case 3:
+		return git_config_set(argv[1], argv[2]);
+	default:
+		usage(git_config_set_usage);
+	}
+	return 0;
+}
---
0.99.9.GIT
