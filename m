From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH] Correct output of git-count-objects.
Date: Mon, 8 Sep 2008 19:56:32 +0200 (CEST)
Message-ID: <alpine.LNX.1.00.0809081952590.30512@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcl6B-0000oj-Cl
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbYIHSDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbYIHSDU
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:03:20 -0400
Received: from mail.bredband2.net ([82.209.166.4]:18543 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750887AbYIHSDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:03:19 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Sep 2008 14:03:19 EDT
Received: (qmail 14695 invoked from network); 8 Sep 2008 17:56:27 -0000
Received: from lkf-194-200-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.200.194])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <gitster@pobox.com>; 8 Sep 2008 17:56:27 -0000
User-Agent: Alpine 1.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95281>

The non-verbose output was not changed in
fdb2a2a600969598fd80f01b009fbbb020d596ab ("compat: introduce on_disk_bytes()")
which caused git-count-objects to claim 512 times too much space used for 
loose objects.
---
 builtin-count-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 6e80fe7..ab35b65 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -126,6 +126,6 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	}
 	else
 		printf("%lu objects, %lu kilobytes\n",
-		       loose, loose_size / 2);
+		       loose, loose_size / 1024);
 	return 0;
 }
-- 
1.6.0.GIT


--
Mikael Magnusson
