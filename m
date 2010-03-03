From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/9] reset: make reset function non static and declare it
	in "reset.h"
Date: Wed, 03 Mar 2010 21:11:38 +0100
Message-ID: <20100303201146.23506.45925.chriscool@tuxfamily.org>
References: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0RI-00083a-LC
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab0CDCFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:05:20 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40540 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754960Ab0CDCFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:05:18 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F3FAD81808C;
	Thu,  4 Mar 2010 03:05:08 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id ED362818050;
	Thu,  4 Mar 2010 03:05:05 +0100 (CET)
X-git-sha1: 91d74028825ca1abf9fe730c0e68d9efe24665ae 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141496>


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
1.7.0.315.gbc198
