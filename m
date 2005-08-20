From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use .git/remote/origin, not .git/branches/origin.
Date: Sat, 20 Aug 2005 11:25:32 -0700
Message-ID: <7vzmrclb37.fsf@assigned-by-dhcp.cox.net>
References: <7vvf20o4sp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 20 20:25:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Y2H-0003uM-By
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 20:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVHTSZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVHTSZf
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 14:25:35 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51943 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932673AbVHTSZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 14:25:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820182533.WXQU19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 14:25:33 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now multi-head fetch is complete, let's migrate the
default configuration for new repositories created with
the "git clone" command.

The original $GIT_DIR/branches is not deprecated yet, but create
remotes directory by default from the templates as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-clone-script    |    8 +++++---
 templates/remotes-- |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 templates/remotes--

8ad3e7efb406377f6903171638c70b7d566254c5
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -127,6 +127,8 @@ yes,yes)
 esac
 
 # Update origin.
-mkdir -p "$D/.git/branches/" &&
-rm -f "$D/.git/branches/origin" &&
-echo "$repo" >"$D/.git/branches/origin"
+mkdir -p "$D/.git/remotes/" &&
+rm -f "$D/.git/remotes/origin" &&
+echo >"$D/.git/remotes/origin" \
+"URL: $repo
+Pull: master:origin"
diff --git a/templates/remotes-- b/templates/remotes--
new file mode 100644
--- /dev/null
+++ b/templates/remotes--
@@ -0,0 +1 @@
+: this is just to ensure the directory exists.
