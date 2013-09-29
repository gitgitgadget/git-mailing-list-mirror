From: Keshav Kini <keshav.kini@gmail.com>
Subject: [PATCH v2 4/4] git-svn.txt: elaborate on rev_map files
Date: Sun, 29 Sep 2013 18:46:00 -0500
Message-ID: <1380498360-18387-5-git-send-email-keshav.kini@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	Keshav Kini <keshav.kini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 30 01:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQQhP-0000Ze-G0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 01:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab3I2Xqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 19:46:48 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:62977 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3I2Xqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 19:46:47 -0400
Received: by mail-oa0-f42.google.com with SMTP id g12so3423446oah.15
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GWn5+6Vj/vvU3gDou3X4ABLPgHO5WQBf5VwpgMbsUns=;
        b=mob7eRRq9jvWMDUOacmJdoP4OaCh0jrxj3G98XSn5Pw67HEO2qBpgJNTocbJuk/YEU
         TCvuMRkIFXRJZ41CgA2hZo7BEvhkJsZeDsXv6aGJ/2/UeFIshySIjFPcdJ1xOW4B9DYH
         iZlArH4UdJEzR8D6aWoZ50bd114p0rETNYPhvLhZBwK/chPeLZwO54Tlke44zpCTh7B3
         kwvL7NlmXHXL3lno7Ez5YHz825FlzbEiLZ2QBXDXGB1vMq77BGx+WEGPUbI8eqqqc2W5
         1X1Pt3Azi1aj+LdDKhRExwSWscu16zdAixv6rH6x4tg0tLF2Oob/VsAXoNdrjLwYON+t
         uyPQ==
X-Received: by 10.182.80.196 with SMTP id t4mr17292150obx.1.1380498406555;
        Sun, 29 Sep 2013 16:46:46 -0700 (PDT)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id z5sm25665837obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 16:46:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235612>

The man page for `git svn` describes a situation in which "'git svn'
will not be able to rebuild" your $GIT_DIR/svn/**/.rev_map* files, but
no mention is made of in what circumstances `git svn` *will* be able to
do so, how to get `git svn` to do so, or even what these files are.

This patch adds a FILES section to the man page with a description of
what $GIT_DIR/svn/**/.rev_map* files are and how they are (re)built, and
links to this description from various other parts of the man page.

Signed-off-by: Keshav Kini <keshav.kini@gmail.com>
---
 Documentation/git-svn.txt | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3ddf545..5383496 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -106,6 +106,9 @@ COMMANDS
 	tracking.  The name of the [svn-remote "..."] section in the
 	$GIT_DIR/config file may be specified as an optional
 	command-line argument.
++
+This automatically updates the rev_map if needed (see
+'$GIT_DIR/svn/\*\*/.rev_map.*' in the FILES section below for details).
 
 --localtime;;
 	Store Git commit times in the local timezone instead of UTC.  This
@@ -201,6 +204,9 @@ accept.  However, '--fetch-all' only fetches from the current
 +
 Like 'git rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
++
+This automatically updates the rev_map if needed (see
+'$GIT_DIR/svn/\*\*/.rev_map.*' in the FILES section below for details).
 
 -l;;
 --local;;
@@ -449,9 +455,10 @@ Any other arguments are passed directly to 'git log'
 	file cannot be ignored forever (with --ignore-paths) the only
 	way to repair the repo is to use 'reset'.
 +
-Only the rev_map and refs/remotes/git-svn are changed.  Follow 'reset'
-with a 'fetch' and then 'git reset' or 'git rebase' to move local
-branches onto the new tree.
+Only the rev_map and refs/remotes/git-svn are changed (see
+'$GIT_DIR/svn/\*\*/.rev_map.*' in the FILES section below for details).
+Follow 'reset' with a 'fetch' and then 'git reset' or 'git rebase' to
+move local branches onto the new tree.
 
 -r <n>;;
 --revision=<n>;;
@@ -684,7 +691,7 @@ svn-remote.<name>.noMetadata::
 +
 This option can only be used for one-shot imports as 'git svn'
 will not be able to fetch again without metadata. Additionally,
-if you lose your $GIT_DIR/svn/\*\*/.rev_map.* files, 'git svn' will not
+if you lose your '$GIT_DIR/svn/\*\*/.rev_map.*' files, 'git svn' will not
 be able to rebuild them.
 +
 The 'git svn log' command will not work on repositories using
@@ -1063,6 +1070,19 @@ or tag has appeared. If the subset of branches or tags is changed after
 fetching, then $GIT_DIR/svn/.metadata must be manually edited to remove
 (or reset) branches-maxRev and/or tags-maxRev as appropriate.
 
+FILES
+-----
+$GIT_DIR/svn/\*\*/.rev_map.*::
+	Mapping between Subversion revision numbers and Git commit
+	names.  In a repository where the noMetadata option is not set,
+	this can be rebuilt from the git-svn-id: lines that are at the
+	end of every commit (see the 'svn.noMetadata' section above for
+	details).
++
+'git svn fetch' and 'git svn rebase' automatically update the rev_map
+if it is missing or not up to date.  'git svn reset' automatically
+rewinds it.
+
 SEE ALSO
 --------
 linkgit:git-rebase[1]
-- 
1.8.3.2
