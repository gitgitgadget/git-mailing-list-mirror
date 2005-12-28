From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/6] git-describe: documentation.
Date: Tue, 27 Dec 2005 16:42:47 -0800
Message-ID: <7vek3y2gs8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:43:31 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErPPb-0003w8-FW
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 01:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVL1Amv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 19:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVL1Amv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 19:42:51 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:226 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932433AbVL1Amu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 19:42:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228004035.NWSL20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 19:40:35 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14090>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-describe.txt |   79 ++++++++++++++++++++++++++++++++++++++++
 Documentation/git.txt          |    3 ++
 2 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-describe.txt

82c11e802b05278d902138abc627982273b777c7
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
new file mode 100644
index 0000000..0efe82a
--- /dev/null
+++ b/Documentation/git-describe.txt
@@ -0,0 +1,79 @@
+git-describe(1)
+===============
+
+NAME
+----
+git-describe - Show the most recent tag that is reachable from a commit.
+
+
+SYNOPSIS
+--------
+'git-describe' [--all] [--tags] [--abbrev=<n>] <committish>...
+
+DESCRIPTION
+-----------
+The command finds the most recent tag that is reachable from a
+commit, and if the commit itself is pointed at by the tag, shows
+the tag.  Otherwise, it suffixes the tag name with abbreviated
+object name of the commit.
+
+
+OPTIONS
+-------
+<committish>::
+	The object name of the comittish. 
+
+--all::
+	Instead of using only the annotated tags, use any ref
+	found in `.git/refs/`.
+
+--tags::
+	Instead of using only the annotated tags, use any tag
+	found in `.git/refs/tags`.
+
+--abbrev=<n>::
+	Instead of using the default 8 hexadecimal digits as the
+	abbreviated object name, use <n> digits.
+
+
+EXAMPLES
+--------
+
+With something like git.git current tree, I get:
+
+	[torvalds@g5 git]$ git-describe parent
+	v1.0.4-g2414721b
+
+i.e. the current head of my "parent" branch is based on v1.0.4,
+but since it has a few commits on top of that, it has added the
+git hash of the thing to the end: "-g" + 8-char shorthand for
+the commit `2414721b194453f058079d897d13c4e377f92dc6`.
+
+Doing a "git-describe" on a tag-name will just show the tag name:
+
+	[torvalds@g5 git]$ git-describe v1.0.4
+	v1.0.4
+
+With --all, the command can use branch heads as references, so
+the output shows the reference path as well:
+
+	[torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
+	tags/v1.0.0-g975b
+
+	[torvalds@g5 git]$ git describe --all HEAD^
+	heads/lt/describe-g975b
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>, but somewhat
+butchered by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5f068c2..90c5bfa 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -139,6 +139,9 @@ Interrogation commands
 gitlink:git-cat-file[1]::
 	Provide content or type/size information for repository objects.
 
+gitlink:git-describe[1]::
+	Show the most recent tag that is reachable from a commit.
+
 gitlink:git-diff-index[1]::
 	Compares content and mode of blobs between the index and repository.
 
-- 
1.0.5-geb9d
