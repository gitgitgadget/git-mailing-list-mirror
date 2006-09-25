From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH] Use const for interpolate arguments
Date: Mon, 25 Sep 2006 23:02:22 +0200
Message-ID: <20060925210222.GA6125@steel.home>
References: <E1GPqwJ-0002xt-Bt@jdl.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 23:03:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRxbT-0003oC-Ce
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 23:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWIYVCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 17:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWIYVCs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 17:02:48 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:40169 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751232AbWIYVCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 17:02:47 -0400
Received: from fwd34.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1GRxb2-0000NH-03; Mon, 25 Sep 2006 23:02:36 +0200
Received: from tigra.home (S9WrFGZfrev4Ip9dVchGrLxtCh7QDyElVuNCiGf-iT-csKE0UY-NEK@[84.160.85.62]) by fwd34.sul.t-online.de
	with esmtp id 1GRxar-197LEG0; Mon, 25 Sep 2006 23:02:25 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5C5C6277AF;
	Mon, 25 Sep 2006 23:02:24 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GRxap-0001au-Ei; Mon, 25 Sep 2006 23:02:23 +0200
To: Jon Loeliger <jdl@jdl.com>
Content-Disposition: inline
In-Reply-To: <E1GPqwJ-0002xt-Bt@jdl.com>
User-Agent: Mutt/1.5.11
X-ID: S9WrFGZfrev4Ip9dVchGrLxtCh7QDyElVuNCiGf-iT-csKE0UY-NEK
X-TOI-MSGID: ea5bd348-4428-446c-9eaf-37a084175eb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27753>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---
 interpolate.c |    6 +++---
 interpolate.h |    9 +++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/interpolate.c b/interpolate.c
index d82f1b5..4570c12 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -25,10 +25,10 @@ #include "interpolate.h"
  */
 
 int interpolate(char *result, int reslen,
-		char *orig,
-		struct interp *interps, int ninterps)
+		const char *orig,
+		const struct interp *interps, int ninterps)
 {
-	char *src = orig;
+	const char *src = orig;
 	char *dest = result;
 	int newlen = 0;
 	char *name, *value;
diff --git a/interpolate.h b/interpolate.h
index 00c63a5..d16f924 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -5,6 +5,11 @@
 #ifndef INTERPOLATE_H
 #define INTERPOLATE_H
 
+/*
+ * Convert a NUL-terminated string in buffer orig,
+ * performing substitutions on %-named sub-strings from
+ * the interpretation table.
+ */
 
 struct interp {
 	char *name;
@@ -12,7 +17,7 @@ struct interp {
 };
 
 extern int interpolate(char *result, int reslen,
-		       char *orig,
-		       struct interp *interps, int ninterps);
+		       const char *orig,
+		       const struct interp *interps, int ninterps);
 
 #endif /* INTERPOLATE_H */
-- 
1.4.2.1.g6b47-dirty
