From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] fetch doc: Move FETCH_HEAD material, and add an example.
Date: Mon,  2 Jun 2014 11:21:47 -0400
Message-ID: <1401722507-15075-1-git-send-email-marcnarc@xiplink.com>
References: <xmqqioon9msf.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:30:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrUCF-0001yH-8n
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 17:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbaFBPan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 11:30:43 -0400
Received: from domain.not.configured ([192.252.130.194]:17446 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751202AbaFBPam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 11:30:42 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jun 2014 11:30:42 EDT
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 6FF1760318;
	Mon,  2 Jun 2014 11:21:46 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.1.g335f86d.dirty
In-Reply-To: <xmqqioon9msf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250570>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-fetch.txt | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

This patch applies on top of your 1/5.  It:

* De-emphasizes the FETCH_HEAD stuff by moving it to the end of the
  DESCRIPTION section,

* States that remote-tracking branches are simply "updated", and hints
  that playing with <refspec> can control this.

* Includes the "their histories" rephrasing.

* Adds your peek-at-a-remote-branch example.

If you like this, feel free to sqush it into your 1/5.

		M.


diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d5f5b54..06106b9 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -18,14 +18,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Fetch branches and/or tags (collectively, "refs") from one or more
-other repositories, along with the objects necessary to complete the
-histories of them.
-
-The names of refs that are fetched, together with the object names
-they point at, are written to `.git/FETCH_HEAD`.  This information
-is used by a later merge operation done by 'git merge'.  In addition,
-the remote-tracking branches may be updated (see description on
-<refspec> below for details).
+other repositories, along with the objects necessary to complete their
+histories.  Remote-tracking branches are updated (see the description
+of <refspec> below for ways to control this behavior).
 
 By default, any tag that points into the histories being fetched is
 also fetched; the effect is to fetch tags that
@@ -35,7 +30,7 @@ configuring remote.<name>.tagopt.  By using a refspec that fetches tags
 explicitly, you can fetch tags that do not point into branches you
 are interested in as well.
 
-'git fetch' can fetch from either a single named repository,
+'git fetch' can fetch from either a single named repository or URL,
 or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
@@ -43,6 +38,10 @@ there is a remotes.<group> entry in the configuration file.
 When no remote is specified, by default the `origin` remote will be used,
 unless there's an upstream branch configured for the current branch.
 
+The names of refs that are fetched, together with the object names
+they point at, are written to `.git/FETCH_HEAD`.  This information
+may be used by scripts or other git commands, such as linkgit:git-pull[1].
+
 OPTIONS
 -------
 include::fetch-options.txt[]
@@ -79,6 +78,19 @@ the local repository by fetching from the branches (respectively)
 The `pu` branch will be updated even if it is does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.
 
+* Peek at a remote's branch, without configuring the remote in your local
+repository:
++
+------------------------------------------------
+$ git fetch git://git.kernel.org/pub/scm/git/git.git maint
+$ git log FETCH_HEAD
+------------------------------------------------
++
+The first command fetches the `maint` branch from the repository at
+`git://git.kernel.org/pub/scm/git/git.git` and the second command uses
+`FETCH_HEAD` to examine the branch with linkgit:git-log[1].  The fetched
+objects will eventually be removed by git's built-in housekeeping (see
+linkgit:git-gc[1]).
 
 BUGS
 ----
-- 
2.0.0.1.g335f86d.dirty
