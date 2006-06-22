From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] xdiffi.c: squelch compiler warnings.
Date: Thu, 22 Jun 2006 11:58:14 -0700
Message-ID: <7v3bdxm309.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jun 22 20:58:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUNh-0004L6-GP
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWFVS6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWFVS6R
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:58:17 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44233 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161194AbWFVS6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 14:58:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622185815.VZS6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 14:58:15 -0400
To: Davide Libenzi <davidel@xmailserver.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22355>

From: Marco Roeland <marco.roeland@xs4all.nl>

This initializes a few variables that are judged to be used uninitialized
by the compiler.
---
 xdiffi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/xdiffi.c b/xdiffi.c
index b1297d4..b95ade2 100644
--- a/xdiffi.c
+++ b/xdiffi.c
@@ -220,7 +220,7 @@ static long xdl_split(unsigned long cons
 		if (ec >= xenv->mxcost) {
 			long fbest, fbest1, bbest, bbest1;
 
-			fbest = -1;
+			fbest = fbest1 = -1;
 			for (d = fmax; d >= fmin; d -= 2) {
 				i1 = XDL_MIN(kvdf[d], lim1);
 				i2 = i1 - d;
@@ -232,7 +232,7 @@ static long xdl_split(unsigned long cons
 				}
 			}
 
-			bbest = XDL_LINE_MAX;
+			bbest = bbest1 = XDL_LINE_MAX;
 			for (d = bmax; d >= bmin; d -= 2) {
 				i1 = XDL_MAX(off1, kvdb[d]);
 				i2 = i1 - d;
@@ -298,6 +298,7 @@ int xdl_recs_cmp(diffdata_t *dd1, long o
 	} else {
 		long ec;
 		xdpsplit_t spl;
+		spl.i1 = spl.i2 = 0;
 
 		/*
 		 * Divide ...
-- 
1.4.0.gbf9e
