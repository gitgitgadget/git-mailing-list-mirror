From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/3] Remove unnecessary sort from t6001 testcase
Date: Thu, 30 Jun 2005 12:41:59 +1000
Message-ID: <20050630024159.32549.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 04:36:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnou7-0007aq-Oz
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 04:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVF3Cme (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 22:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVF3Cma
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 22:42:30 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:48256 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262795AbVF3CmB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 22:42:01 -0400
Received: (qmail 32559 invoked by uid 500); 30 Jun 2005 02:41:59 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch removes an unnecessary sort from the t6001 testcase.

Sorts were previously necessary when testing non --merge-order cases because the output order wasn't
entirely deterministic unless commit date was fixed.

However, commit dates are now fixed, so the need for a sort has disappeared. So the sort
has been removed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6001-rev-list-merge-order.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

4a4c2a209c0121314aa444c1c5e361ad43f1848a
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -408,17 +408,17 @@ test_output_expect_success "max-count 10
 | b2
 EOF
 
-test_output_expect_success "max-count 10 - non merge order" 'git-rev-list --max-count=10 l5 | entag | sort' <<EOF
-a2
-a3
+test_output_expect_success "max-count 10 - non merge order" 'git-rev-list --max-count=10 l5' <<EOF
+l5
+l4
+l3
 a4
-b3
 b4
-c2
+a3
+a2
 c3
-l3
-l4
-l5
+c2
+b3
 EOF
 
 test_output_expect_success '--max-age=c3, no --merge-order' "git-rev-list --max-age=$(commit_date c3) l5" <<EOF
------------
