From: Johan Herland <johan@herland.net>
Subject: [PATCH] Teach git-gc to merge unsorted softrefs
Date: Sun, 10 Jun 2007 16:45:41 +0200
Message-ID: <200706101645.41601.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092021.43314.johan@herland.net> <f4h1ot$83m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 16:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxOfx-0003rG-Lw
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150AbXFJOpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755586AbXFJOpq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:45:46 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33255 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbXFJOpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:45:45 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00503D08UI00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:45:44 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF005ELD064X90@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:45:42 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00DDMD06C090@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 16:45:42 +0200 (CEST)
In-reply-to: <f4h1ot$83m$1@sea.gmane.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49743>

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 10 June 2007, Jakub Narebski wrote:
> Perhaps git-gc should also sort softrefs (if it doesn't do it yet)?

Sure.

 builtin-gc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 45025fb..30e1e44 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -12,6 +12,7 @@
 
 #include "cache.h"
 #include "run-command.h"
+#include "softrefs.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -87,6 +88,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (i != argc)
 		usage(builtin_gc_usage);
 
+	if (merge_unsorted_softrefs(NULL, 1))
+		return error("failed to merge unsorted softrefs");
+
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_pack_refs[0]);
 
-- 
1.5.2.1.144.gabc40
