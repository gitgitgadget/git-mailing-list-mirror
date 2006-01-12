From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-branch: make --topo-order noop and default.
Date: Wed, 11 Jan 2006 16:05:54 -0800
Message-ID: <7v4q4ajonx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:06:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpz7-0002S8-UM
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWALAF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWALAF6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:05:58 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35210 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964825AbWALAF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:05:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000352.YEIH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:03:52 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14534>

It really does not make sense not doing --topo-order.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Currently in "pu".

 show-branch.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

d899f2bfc64b44e776a87f9c8fdd6abfe819690b
diff --git a/show-branch.c b/show-branch.c
index 9f7e188..f296a87 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -544,7 +544,6 @@ int main(int ac, char **av)
 	int no_name = 0;
 	int sha1_name = 0;
 	int shown_merge_point = 0;
-	int topo_order = 0;
 	int no_current_branch = 0;
 
 	git_config(git_show_branch_config);
@@ -585,7 +584,8 @@ int main(int ac, char **av)
 		else if (!strcmp(arg, "--independent"))
 			independent = 1;
 		else if (!strcmp(arg, "--topo-order"))
-			topo_order = 1;
+			/* noop */
+			;
 		else
 			usage(show_branch_usage);
 		ac--; av++;
@@ -707,8 +707,7 @@ int main(int ac, char **av)
 		exit(0);
 
 	/* Sort topologically */
-	if (topo_order)
-		sort_in_topological_order(&seen);
+	sort_in_topological_order(&seen);
 
 	/* Give names to commits */
 	if (!sha1_name && !no_name)
-- 
1.1.1-g8ecb
