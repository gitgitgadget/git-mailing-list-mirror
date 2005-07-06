From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Fixes a problem with --merge-order A B (A is linear descendent of a merge B)
Date: Thu, 07 Jul 2005 00:44:08 +1000
Message-ID: <20050706144408.17769.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 16:46:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqB9b-00023w-0U
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 16:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVGFOpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVGFOpM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 10:45:12 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:35714 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262340AbVGFOoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 10:44:13 -0400
Received: (qmail 17779 invoked by uid 500); 6 Jul 2005 14:44:08 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch passes the test case in the first patch of this series.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e4f793b932b30a7bee16610e311630515fe88330
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
