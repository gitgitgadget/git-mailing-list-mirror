From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/1] Remove aliasing between COUNTED and UNINTERESTING flags used by rev-list.c
Date: Thu, 30 Jun 2005 00:16:29 +1000
Message-ID: <20050629141629.15754.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 29 16:11:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DndI5-0006Op-7I
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 16:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVF2OSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 10:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVF2OSt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 10:18:49 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:54915 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262588AbVF2OQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 10:16:35 -0400
Received: (qmail 15765 invoked by uid 500); 29 Jun 2005 14:16:29 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The COUNTED and UNINTERESTING flags were unintentionally aliased.

This patch makes sure that flags defined in rev-list.c have distinct
values from from those defined by epoch.h.

The aliasing may have caused unexpected behaviour of the git-rev-list
--bisect flag.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 rev-list.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

fb2676c0c3991666db9a3b0ebe222d8028c12a05
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -4,10 +4,10 @@
 #include "blob.h"
 #include "epoch.h"
 
-#define SEEN		(1u << 0)
-#define INTERESTING	(1u << 1)
-#define COUNTED		(1u << 2)
-#define SHOWN		(LAST_EPOCH_FLAG << 2)
+#define SEEN        (LAST_EPOCH_FLAG << 1)
+#define INTERESTING (LAST_EPOCH_FLAG << 2)
+#define COUNTED     (LAST_EPOCH_FLAG << 3)
+#define SHOWN       (LAST_EPOCH_FLAG << 4)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
------------
