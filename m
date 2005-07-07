From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Tidy up - remove use of (*f)() idiom from epoch.c
Date: Thu, 07 Jul 2005 11:26:43 +1000
Message-ID: <20050707012643.17103.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 03:29:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqLCc-0007vg-RF
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 03:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVGGB2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 21:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGGB0x
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 21:26:53 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:4224 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262316AbVGGB0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 21:26:46 -0400
Received: (qmail 17114 invoked by uid 500); 7 Jul 2005 01:26:43 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Replace (*f)() with f() where the former idiom was used in epoch.c

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

ce760b162be7463a5648d086bfd7ac324ba66edd
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -499,7 +499,7 @@ static int emit_stack(struct commit_list
 		if (*stack || include_last) {
 			if (!*stack) 
 				next->object.flags |= BOUNDARY;
-			action = (*emitter) (next);
+			action = emitter(next);
 		}
 	}
 
@@ -545,7 +545,7 @@ static int sort_in_merge_order(struct co
 				if (next->object.flags & UNINTERESTING) {
 					action = STOP;
 				} else {
-					action = (*emitter) (next);
+					action = emitter(next);
 				}
 				if (action != STOP) {
 					next = next->parents->item;
@@ -562,7 +562,7 @@ static int sort_in_merge_order(struct co
 	}
 
 	if (next && (action != STOP) && !ret) {
-		(*emitter) (next);
+		emitter(next);
 	}
 
 	return ret;
------------
