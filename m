From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: git-commit in 1.2.X series defaults to --include.
Date: Mon, 13 Feb 2006 23:53:10 -0800
Message-ID: <7vd5hqtlzt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 14 08:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8v0C-0001U2-Sf
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 08:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWBNHxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 02:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWBNHxM
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 02:53:12 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47317 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030416AbWBNHxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 02:53:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214074957.GYNA17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 02:49:57 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16129>

The documentation was mistakenly describing the --only semantics to
be default.  The 1.2.0 release and its maintenance series 1.2.X will
keep the traditional --include semantics as the default.  Clarify the
situation.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This will be part of 1.2.1 maintenance series.

 Documentation/git-commit.txt |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

64491e1ea95acde1aa77db539ba498593a0fcbc5
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53b64fa..5b1b4d3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,8 +8,8 @@ git-commit - Record your changes
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a] [-i] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
-	   [-e] [--author <author>] [--] <file>...
+'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
+	   [-e] [--author <author>] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -73,19 +73,39 @@ OPTIONS
 	commit the whole index.  This is the traditional
 	behaviour.
 
---::
-	Do not interpret any more arguments as options.
-
-<file>...::
+-o|--only::
 	Commit only the files specified on the command line.
 	This format cannot be used during a merge, nor when the
 	index and the latest commit does not match on the
 	specified paths to avoid confusion.
 
+--::
+	Do not interpret any more arguments as options.
+
+<file>...::
+	Files to be committed.  The meaning of these is
+	different between `--include` and `--only`.  Without
+	either, it defaults `--include` semantics.
+
 If you make a commit and then found a mistake immediately after
 that, you can recover from it with gitlink:git-reset[1].
 
 
+WARNING
+-------
+
+The 1.2.0 and its maintenance series 1.2.X will keep the
+traditional `--include` semantics as the default when neither
+`--only` nor `--include` is specified and `paths...` are given.
+This *will* change during the development towards 1.3.0 in the
+'master' branch of `git.git` repository.  If you are using this
+command in your scripts, and you depend on the traditional
+`--include` semantics, please update them to explicitly ask for
+`--include` semantics.  Also if you are used to making partial
+commit using `--include` semantics, please train your fingers to
+say `git commit --include paths...` (or `git commit -i paths...`).
+
+
 Discussion
 ----------
 
@@ -101,7 +121,7 @@ even the command is invoked from a subdi
 That is, update the specified paths to the index and then commit
 the whole tree.
 
-`git commit paths...` largely bypasses the index file and
+`git commit --only paths...` largely bypasses the index file and
 commits only the changes made to the specified paths.  It has
 however several safety valves to prevent confusion.
 
-- 
1.2.0.g45dc
