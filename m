From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 5/5] MinGW: Fix compiler warning in merge-recursive
Date: Sat, 23 May 2009 10:04:51 +0200
Message-ID: <1243065891-13270-6-git-send-email-prohaska@zib.de>
References: <1243065891-13270-1-git-send-email-prohaska@zib.de>
 <1243065891-13270-2-git-send-email-prohaska@zib.de>
 <1243065891-13270-3-git-send-email-prohaska@zib.de>
 <1243065891-13270-4-git-send-email-prohaska@zib.de>
 <1243065891-13270-5-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 10:30:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mcl-0005CC-9c
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbZEWIaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZEWIaN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:30:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:34254 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbZEWIaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:30:12 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 04:29:52 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4N84wcb001296;
	Sat, 23 May 2009 10:05:03 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4N84pOO028553;
	Sat, 23 May 2009 10:04:57 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243065891-13270-5-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119763>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

GCC 4.4.0 on Windows does not like the format %zu.  It is quite unlikely,
though, that we need more merge bases than a %d can display, so replace
the %zu by a %d.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-merge-recursive.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 703045b..d26a96e 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -45,8 +45,9 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 			bases[bases_count++] = sha;
 		}
 		else
-			warning("Cannot handle more than %zu bases. "
-				"Ignoring %s.", ARRAY_SIZE(bases)-1, argv[i]);
+			warning("Cannot handle more than %d bases. "
+				"Ignoring %s.",
+				(int)ARRAY_SIZE(bases)-1, argv[i]);
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
-- 
1.6.3.1.54.g99dd
