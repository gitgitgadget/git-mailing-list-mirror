From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-merge documentation: conflicting merge leaves higher stages in index
Date: Fri, 02 Dec 2005 01:16:06 -0800
Message-ID: <7vlkz37tbd.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
	<7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
	<7v8xv39a8z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 02 10:16:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei71Y-0004h5-Ju
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 10:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbVLBJQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbVLBJQI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 04:16:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1925 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751767AbVLBJQH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 04:16:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202091534.OUZN15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 04:15:34 -0500
To: git@vger.kernel.org
In-Reply-To: <7v8xv39a8z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Dec 2005 00:25:00 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13108>

This hopefully concludes the latest updates that changes the
behaviour of the merge on an unsuccessful automerge.  Instead of
collapsing the conflicted path in the index to show HEAD, we
leave it unmerged, now that diff-files can compare working tree
files with higher stages.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-merge.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

e8be26e9282e346b01aa41fd7ab0b5f7bf7dcfc3
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c117404..0cac563 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -108,10 +108,12 @@ When there are conflicts, these things h
 2. Cleanly merged paths are updated both in the index file and
    in your working tree.
 
-3. For conflicting paths, the index file records the version
-   from `HEAD`. The working tree files have the result of
-   "merge" program; i.e. 3-way merge result with familiar
-   conflict markers `<<< === >>>`.
+3. For conflicting paths, the index file records up to three
+   versions; stage1 stores the version from the common ancestor,
+   stage2 from `HEAD`, and stage3 from the remote branch (you
+   can inspect the stages with `git-ls-files -u`).  The working
+   tree files have the result of "merge" program; i.e. 3-way
+   merge result with familiar conflict markers `<<< === >>>`.
 
 4. No other changes are done.  In particular, the local
    modifications you had before you started merge will stay the
-- 
0.99.9.GIT
