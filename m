From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] help.c: Pull cmd_version out of this file.
Date: Sun, 29 Aug 2010 17:44:19 -0300
Message-ID: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpokJ-0003pX-IY
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab0H2Uov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 16:44:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64691 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0H2Uou (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 16:44:50 -0400
Received: by yxp4 with SMTP id 4so65441yxp.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=YaV1lB649SC/SrA+SNNms35DIqyoVmSzuuWY7GT0WTg=;
        b=RnbD+u+rskO2JEkw8jHe+JRQBr3RNWvkqUlW+GzNqUicVAfkzPrhzVrXTbNZSkjBW0
         pQzVyRqWo689V3E2TBEBLrlBDWo6vbiY0bKKIIRIl5n8QjIa/W4Pl208SW9Al36Aczf0
         CY5LsrH+OIe2s9Z/8kZ77bSmank/eNQ38IEHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=CbMir60zr4PxmPePo8JixSlD405YZ7tL13asT5udpkcjfTkjnhIOXESceA7ilfStLN
         A2CR7qhCUyPf4Q6ME5EBuOjAZN/rhjsBAGVZsfYUQ8yi5ZZUeVwo/4VUUYIFc9ddlYp8
         ZvYZEXrqFp+4UrkNr+jBQGQIzCBYjnXaSxBQI=
Received: by 10.100.105.3 with SMTP id d3mr3658321anc.194.1283114689965;
        Sun, 29 Aug 2010 13:44:49 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id k11sm11193354ani.10.2010.08.29.13.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 13:44:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154716>

Promote cmd_version to a builtin, by moving it to its own file
in builtin/version.c

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Makefile          |    1 +
 builtin/version.c |    7 +++++++
 help.c            |    6 ------
 3 files changed, 8 insertions(+), 6 deletions(-)
 create mode 100644 builtin/version.c

diff --git a/Makefile b/Makefile
index b4745a5..0f3b6d8 100644
--- a/Makefile
+++ b/Makefile
@@ -738,6 +738,7 @@ BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
+BUILTIN_OBJS += builtin/version.o
 BUILTIN_OBJS += builtin/write-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
diff --git a/builtin/version.c b/builtin/version.c
new file mode 100644
index 0000000..d98e260
--- /dev/null
+++ b/builtin/version.c
@@ -0,0 +1,7 @@
+#include "builtin.h"
+
+int cmd_version(int argc, const char **argv, const char *prefix)
+{
+	printf("git version %s\n", git_version_string);
+	return 0;
+}
diff --git a/help.c b/help.c
index 7f4928e..ad4f923 100644
--- a/help.c
+++ b/help.c
@@ -362,9 +362,3 @@ const char *help_unknown_cmd(const char *cmd)
 
 	exit(1);
 }
-
-int cmd_version(int argc, const char **argv, const char *prefix)
-{
-	printf("git version %s\n", git_version_string);
-	return 0;
-}
-- 
1.7.2.1.95.g3d045
