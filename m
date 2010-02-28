From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/12] reset: make reset function non static and declare it
	in "reset.h"
Date: Sun, 28 Feb 2010 23:22:02 +0100
Message-ID: <20100228222208.2260.54777.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrXo-0006Rr-Ew
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032154Ab0B1WW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:22:59 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48568 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032121Ab0B1WWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B2B54818126;
	Sun, 28 Feb 2010 23:22:40 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6CB4181810A;
	Sun, 28 Feb 2010 23:22:37 +0100 (CET)
X-git-sha1: bbe34c331a950ac53be3d0bf33ba389c90aad40e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141280>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/reset.c |    8 ++++----
 reset.h         |   10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 reset.h

diff --git a/builtin/reset.c b/builtin/reset.c
index b2239d2..f1d7a5a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -20,6 +20,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "reset.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]",
@@ -27,7 +28,6 @@ static const char * const git_reset_usage[] = {
 	NULL
 };
 
-enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
 static const char *reset_type_names[] = {
 	"mixed", "soft", "hard", "merge", "keep", NULL
 };
@@ -255,9 +255,9 @@ static int update_heads(unsigned char *sha1)
 	return update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 }
 
-static int reset(const char *rev, const char *prefix,
-		 int reset_type, int quiet, int patch_mode,
-		 int argc, const char **argv)
+int reset(const char *rev, const char *prefix,
+	  int reset_type, int quiet, int patch_mode,
+	  int argc, const char **argv)
 {
 	struct commit *commit;
 	unsigned char sha1[20];
diff --git a/reset.h b/reset.h
new file mode 100644
index 0000000..05d2205
--- /dev/null
+++ b/reset.h
@@ -0,0 +1,10 @@
+#ifndef RESET_H
+#define RESET_H
+
+enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
+
+int reset(const char *rev, const char *prefix,
+	  int reset_type, int quiet, int patch_mode,
+	  int argc, const char **argv);
+
+#endif
-- 
1.7.0.321.g2d270
