From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 13/13] Fixes a problem with --merge-order A B (A is linear descendent of a merge B)
Date: Thu, 07 Jul 2005 02:39:35 +1000
Message-ID: <20050706163935.10032.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 18:48:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqD38-00064h-Hg
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVGFQqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGFQoQ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:44:16 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:4225 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262363AbVGFQjy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 12:39:54 -0400
Received: (qmail 10042 invoked by uid 500); 6 Jul 2005 16:39:35 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch passes the test case introduced by the previous patch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6f7f90901ec4aafd12ac4179110b78fc426395cd
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -612,7 +612,7 @@ int sort_list_in_merge_order(struct comm
 		while (reversed) {
 			struct commit * next = pop_commit(&reversed);
 
-			if (!(next->object.flags & VISITED)) {
+			if (!(next->object.flags & VISITED) && next!=base) {
 				sort_first_epoch(next, &stack);
 				if (reversed) {
 					/*
------------
