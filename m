From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff.c: -B argument passing fix.
Date: Fri, 03 Jun 2005 23:04:07 -0700
Message-ID: <7v64wuk694.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 08:01:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeRiR-00043x-Ma
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 08:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFDGEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 02:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFDGEP
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 02:04:15 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20187 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261249AbVFDGEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2005 02:04:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050604060409.MSPJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Jun 2005 02:04:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes a bug that was preventing non-default parameter to -B
option to be passed correctly; you could not give more than 50%
break score.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -964,11 +964,11 @@ void diffcore_std(const char **paths,
 {
 	if (paths && paths[0])
 		diffcore_pathspec(paths);
-	if (0 <= break_opt)
+	if (break_opt != -1)
 		diffcore_break(break_opt);
 	if (detect_rename)
 		diffcore_rename(detect_rename, rename_score);
-	if (0 <= break_opt)
+	if (break_opt != -1)
 		diffcore_merge_broken();
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
------------

