From: Junio C Hamano <junkio@cox.net>
Subject: git-status: do not mark unmerged paths as committable.
Date: Sun, 06 Nov 2005 17:39:06 -0800
Message-ID: <7vslu9uthh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 07 02:40:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYvye-0001q2-7s
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 02:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVKGBjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 20:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVKGBjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 20:39:09 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12219 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932396AbVKGBjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 20:39:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107013807.WVFF24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 20:38:07 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11244>

An unmerged path appears as both "Updated but not checked in" list,
and "Changed but not updated" list.  We are not going to commit that
path until it is resolved, so remove it from the former list.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-status.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 49ac95e5ebfd28b32ec1a23a0982900426f0c06c
f1790448628262e46496861bb6da76be63a2a247
diff --git a/git-status.sh b/git-status.sh
index 62a24a9..837f334 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -41,7 +41,7 @@ git-update-index -q --unmerged --refresh
 
 if GIT_DIR="$GIT_DIR" git-rev-parse --verify HEAD >/dev/null 2>&1
 then
-	git-diff-index -M --cached --name-status HEAD |
+	git-diff-index -M --cached --name-status --diff-filter=MDTCRA HEAD |
 	sed -e '
 		s/\\/\\\\/g
 		s/ /\\ /g
---
0.99.9.GIT
