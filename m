From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 07/10] xdiff: add XDL_EMIT_MOREFUNCNAMES
Date: Thu, 27 Mar 2014 14:50:53 -0400
Message-ID: <201aa05a9cea6d82b85b44233e7cb02df2c5623a.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFP8-00056U-EV
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227AbaC0Svf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:35 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64408 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757142AbaC0Svc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:32 -0400
X-AuditID: 12074411-f79ab6d000002f0e-70-533473335964
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.81.12046.33374335; Thu, 27 Mar 2014 14:51:31 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TP013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:30 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsUixO6iqGtcbBJssPycrMXclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4MrY9mEJS8FMnYqtzc/ZGxjPKnUxcnJICJhIfPkwnxHCFpO4cG89WxcjF4eQwGVGiTlN
	29ghnJVMEoun9zKDVLEJOEts+rWfCcQWERCXeHt8JlgRs8BCRom3eyaDFQkLWEi07VkJVsQi
	oCqx/cBNVhCbVyBK4v2U1cwQ6wwkPj07A2ZzCjhITJ6/EcjmANpmL/FxqS1EOFri9dbFbCC2
	EFDr660nWSYw8i9gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERKEgjsY
	Z5yUO8QowMGoxMN7MdskWIg1say4MvcQowQHs5II79wCoBBvSmJlVWpRfnxRaU5q8SFGaQ4W
	JXFeviXqfkIC6YklqdmpqQWpRTBZJg5OqQbGHjYBlYQ1V4UOhTKcbS48LfVJsSb7Ut6JH+k6
	e4TXlXy/skZrSt4lf47HYa21F6Q3Xs3KEVzmG+s4f5Ep353ys5ltDh4230Iq55/9lKrIpbh5
	auR3rqZZUlObv8+cNOloU9I/u0Wn9v7ZmsE7Zf1R/7liBeYLDgDj7LGqy0FRJYZM1ttG76Yr
	sRRnJBpqMRcVJwIAFoysKT4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245316>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

For filtering commits by function name, it's useful to identify the
function name in cases such as adding a new function to a file (where
the default functionality will not emit a function name in the hunk
header, because it isn't part of the context).

This adds a flag asking xdiff to be more aggressive in finding function
names to emit, and turns the flag on when the --function-name option is
in use.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 diff.c             |  2 ++
 diffcore-pickaxe.c |  2 +-
 xdiff/xdiff.h      |  1 +
 xdiff/xemit.c      | 39 +++++++++++++++++++++++----------------
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 2f6dbc1..914b4a2 100644
--- a/diff.c
+++ b/diff.c
@@ -2380,6 +2380,8 @@ static void builtin_diff(const char *name_a,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
+		if (o->funcname)
+			xecfg.flags |= XDL_EMIT_MOREFUNCNAMES;
 		if (DIFF_OPT_TST(o, FUNCCONTEXT))
 			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
 		if (pe)
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 259a8fa..ab31c18 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -164,7 +164,7 @@ static int diff_funcname_filter(mmfile_t *one, mmfile_t *two,
 	xecfg.interhunkctxlen = o->interhunkcontext;
 	if (!(one && two))
 		xecfg.flags = XDL_EMIT_FUNCCONTEXT;
-	xecfg.flags |= XDL_EMIT_FUNCNAMES;
+	xecfg.flags |= XDL_EMIT_FUNCNAMES | XDL_EMIT_MOREFUNCNAMES;
 	xdi_diff_outf(one, two, match_funcname, &ecbdata, &xpp, &xecfg);
 	return ecbdata.hit;
 }
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c033991..469bded 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -44,6 +44,7 @@
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
+#define XDL_EMIT_MOREFUNCNAMES (1 << 3)
 
 #define XDL_MMB_READONLY (1 << 0)
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 4266ada..0ddb094 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -23,6 +23,10 @@
 #include "xinclude.h"
 
 
+struct func_line {
+	long len;
+	char buf[80];
+};
 
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
@@ -135,12 +139,7 @@ static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	return 0;
 }
 
-struct func_line {
-	long len;
-	char buf[80];
-};
-
-static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
+static long get_func_line(xdfile_t *xdf, xdemitconf_t const *xecfg,
 			  struct func_line *func_line, long start, long limit)
 {
 	find_func_t ff = xecfg->find_func ? xecfg->find_func : def_ff;
@@ -150,9 +149,9 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	buf = func_line ? func_line->buf : dummy;
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
-	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
+	for (l = start; l != limit && 0 <= l && l < xdf->nrec; l += step) {
 		const char *rec;
-		long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
+		long reclen = xdl_get_rec(xdf, l, &rec);
 		long len = ff(rec, reclen, buf, size, xecfg->find_func_priv);
 		if (len >= 0) {
 			if (func_line)
@@ -167,7 +166,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
 	xdchange_t *xch, *xche;
-	long funclineprev = -1;
+	long funclineprev1 = -1, funclineprev2 = -1;
 	struct func_line func_line = { 0 };
 
 	if (xecfg->flags & XDL_EMIT_COMMON)
@@ -182,7 +181,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
 
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
-			long fs1 = get_func_line(xe, xecfg, NULL, xch->i1, -1);
+			long fs1 = get_func_line(&xe->xdf1, xecfg, NULL, xch->i1, -1);
 			if (fs1 < 0)
 				fs1 = 0;
 			if (fs1 < s1) {
@@ -200,7 +199,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		e2 = xche->i2 + xche->chg2 + lctx;
 
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
-			long fe1 = get_func_line(xe, xecfg, NULL,
+			long fe1 = get_func_line(&xe->xdf1, xecfg, NULL,
 						 xche->i1 + xche->chg1,
 						 xe->xdf1.nrec);
 			if (fe1 < 0)
@@ -218,7 +217,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			if (xche->next) {
 				long l = xche->next->i1;
 				if (l <= e1 ||
-				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
+				    get_func_line(&xe->xdf1, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
 					goto again;
 				}
@@ -229,10 +228,18 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		 * Emit current hunk header.
 		 */
 
-		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
-			get_func_line(xe, xecfg, &func_line,
-				      s1 - 1, funclineprev);
-			funclineprev = s1 - 1;
+		if (xecfg->flags & XDL_EMIT_MOREFUNCNAMES) {
+			long fl_in_xch1 = get_func_line(&xe->xdf1, xecfg,
+					&func_line, xch->i1, xch->i1+xch->chg1);
+			if (fl_in_xch1 < 0) {
+				get_func_line(&xe->xdf2, xecfg, &func_line,
+					      xch->i2, funclineprev2);
+				funclineprev2 = xch->i2;
+			}
+		} else if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
+			get_func_line(&xe->xdf1, xecfg, &func_line,
+				      s1 - 1, funclineprev1);
+			funclineprev1 = s1 - 1;
 		}
 		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
 				      func_line.buf, func_line.len, ecb) < 0)
-- 
1.7.12.4 (Apple Git-37)
