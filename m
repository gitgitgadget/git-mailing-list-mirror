From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] doc/checkout: split checkout and branch creation in
	synopsis
Date: Mon, 13 Apr 2009 07:19:33 -0400
Message-ID: <20090413111933.GD15982@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:21:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtKDt-0001JL-5X
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbZDMLTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbZDMLTf
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:19:35 -0400
Received: from peff.net ([208.65.91.99]:43506 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716AbZDMLTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:19:35 -0400
Received: (qmail 31792 invoked by uid 107); 13 Apr 2009 11:19:38 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 07:19:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 07:19:33 -0400
Content-Disposition: inline
In-Reply-To: <20090413110947.GA15647@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116430>

These can really be thought of as two different modes, since
the "<branch>" parameter is treated differently in the two
(in one it is the branch to be checked out, but in the other
it is really a start-point for branch creation).

Signed-off-by: Jeff King <peff@peff.net>
---
This was the actual goal of the series. :)

 Documentation/git-checkout.txt |   40 ++++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 22ad10d..4a1fb53 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,23 +8,22 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<branch>]
+'git checkout' [-q] [-f] [-m] [<branch>]
+'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 
 DESCRIPTION
 -----------
 
 When <paths> are not given, this command switches branches by
-updating the index and working tree to reflect the specified
-branch, <branch>, and updating HEAD to be <branch> or, if
-specified, <new_branch>.  Using -b will cause <new_branch> to
-be created as if linkgit:git-branch[1] were called; in this case you can
-use the --track or --no-track options, which will be passed to `git
-branch`.
+updating the index, working tree, and HEAD to reflect the specified
+branch.
 
-As a convenience, --track will default to creating a branch whose
-name is constructed from the specified branch name by stripping
-the first namespace level.
+If `-b` is given, a new branch is created and checked out, as if
+linkgit:git-branch[1] were called; in this case you can
+use the --track or --no-track options, which will be passed to `git
+branch`.  As a convenience, --track without `-b` implies branch
+creation; see the description of --track below.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
@@ -63,7 +62,7 @@ entries; instead, unmerged entries are ignored.
 
 -b::
 	Create a new branch named <new_branch> and start it at
-	<branch>; see linkgit:git-branch[1] for details.
+	<start_point>; see linkgit:git-branch[1] for details.
 
 -t::
 --track::
@@ -114,13 +113,6 @@ the conflicted merge in the specified paths.
 	"merge" (default) and "diff3" (in addition to what is shown by
 	"merge" style, shows the original contents).
 
-<new_branch>::
-	Name for the new branch.
-
-<tree-ish>::
-	Tree to checkout from (when paths are given). If not specified,
-	the index will be used.
-
 <branch>::
 	Branch to checkout (when no paths are given); may be any object
 	ID that resolves to a commit.  Defaults to HEAD.
@@ -132,6 +124,18 @@ As a special case, the `"@\{-N\}"` syntax for the N-th last branch
 checks out the branch (instead of detaching).  You may also specify
 `-` which is synonymous with `"@\{-1\}"`.
 
+<new_branch>::
+	Name for the new branch.
+
+<start_point>::
+	The name of a commit at which to start the new branch; see
+	linkgit:git-branch[1] for details. Defaults to HEAD.
+
+<tree-ish>::
+	Tree to checkout from (when paths are given). If not specified,
+	the index will be used.
+
+
 
 Detached HEAD
 -------------
-- 
1.6.3.rc0.148.g141203.dirty
