From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 4/6] reset: make reset function non static and declare it
	in "reset.h"
Date: Mon, 01 Feb 2010 08:55:39 +0100
Message-ID: <20100201075542.3929.57485.chriscool@tuxfamily.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbr69-0005ho-Kn
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 08:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab0BAHxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 02:53:04 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49848 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534Ab0BAHw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 02:52:57 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F0CEF8180D7;
	Mon,  1 Feb 2010 08:52:49 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EF047818165;
	Mon,  1 Feb 2010 08:52:46 +0100 (CET)
X-git-sha1: 22b243f8152cb7ff7bd043d54b5bb474cb403230 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138588>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c |    8 ++++----
 reset.h         |   10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 reset.h

diff --git a/builtin-reset.c b/builtin-reset.c
index bf97931..b004f9a 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -20,6 +20,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "reset.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
@@ -27,7 +28,6 @@ static const char * const git_reset_usage[] = {
 	NULL
 };
 
-enum reset_type { MIXED, SOFT, HARD, MERGE, NONE };
 static const char *reset_type_names[] = { "mixed", "soft", "hard", "merge", NULL };
 
 static char *args_to_str(const char **argv)
@@ -235,9 +235,9 @@ static int update_heads(unsigned char *sha1)
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
index 0000000..c8497e4
--- /dev/null
+++ b/reset.h
@@ -0,0 +1,10 @@
+#ifndef RESET_H
+#define RESET_H
+
+enum reset_type { MIXED, SOFT, HARD, MERGE, NONE };
+
+int reset(const char *rev, const char *prefix,
+	  int reset_type, int quiet, int patch_mode,
+	  int argc, const char **argv);
+
+#endif
-- 
1.6.6.1.557.g77031
