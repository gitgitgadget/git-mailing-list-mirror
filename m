From: Joey Hess <joeyh@joeyh.name>
Subject: [PATCH] improve documentation for some commands that use pathspecs
Date: Tue, 31 Mar 2015 11:22:24 -0400
Message-ID: <20150331152224.GA16617@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 17:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycy0E-0008PC-1C
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 17:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbbCaPWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 11:22:42 -0400
Received: from kitenet.net ([66.228.36.95]:50123 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbbCaPWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 11:22:37 -0400
X-Question: 42
Authentication-Results: kitenet.net; dkim=pass
	reason="1024-bit key; unprotected key/testing"
	header.d=joeyh.name header.i=@joeyh.name header.b=PdRBK1fs;
	dkim-adsp=pass; dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1427815344; bh=ys3S12Isrshnbnvb0nnvx+6R6AI3d8Z9R0U/Mj+ONu0=;
	h=Date:From:To:Subject:From;
	b=PdRBK1fskQiwo9O97CGPv1DINQk5CjVjLafhdOXT4JwQMmEOBzoFkwiIJaTn3BZmj
	 HiIV9THKUwQ75AMtcOgyg2+FHaunw2R03/Aq6Z+POTcV7zMWrK3TC3NSfGYLDMXh7y
	 FSSQN3S7c1HtQvkx1AzFIotgqanqSBP84tV/FpZQ=
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-93.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266527>

After being surprised that git-ls-files expands pathspecs, here's a patch
that would have saved me.
---
 Documentation/git-ls-files.txt | 9 +++++----
 Documentation/git-ls-tree.txt  | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e26f01f..f7a3039 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
-		[--full-name] [--abbrev] [--] [<file>...]
+		[--full-name] [--abbrev] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -101,7 +101,7 @@ OPTIONS
 
 --with-tree=<tree-ish>::
 	When using --error-unmatch to expand the user supplied
-	<file> (i.e. path pattern) arguments to paths, pretend
+	<pathspec> arguments to paths, pretend
 	that paths which were removed in the index since the
 	named <tree-ish> are still present.  Using this option
 	with `-s` or `-u` options does not make any sense.
@@ -150,9 +150,10 @@ a space) at the start of each line:
 \--::
 	Do not interpret any more arguments as options.
 
-<file>::
+<pathspec>::
 	Files to show. If no files are given all files which match the other
-	specified criteria are shown.
+	specified criteria are shown. (Note that this isn't really raw
+	pathnames, but rather a list of patterns to match.)
 
 Output
 ------
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 16e87fd..58e7f64 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
-	    <tree-ish> [<path>...]
+	    <tree-ish> [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -19,11 +19,11 @@ Lists the contents of a given tree object, like what "/bin/ls -a" does
 in the current working directory.  Note that:
 
  - the behaviour is slightly different from that of "/bin/ls" in that the
-   '<path>' denotes just a list of patterns to match, e.g. so specifying
+   '<pathspec>' denotes just a list of patterns to match, e.g. so specifying
    directory name (without '-r') will behave differently, and order of the
    arguments does not matter.
 
- - the behaviour is similar to that of "/bin/ls" in that the '<path>' is
+ - the behaviour is similar to that of "/bin/ls" in that the '<pathspec>' is
    taken as relative to the current working directory.  E.g. when you are
    in a directory 'sub' that has a directory 'dir', you can run 'git
    ls-tree -r HEAD dir' to list the contents of the tree (that is
@@ -72,7 +72,7 @@ OPTIONS
 	Do not limit the listing to the current working directory.
 	Implies --full-name.
 
-[<path>...]::
+[<pathspec>...]::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
 	implicitly uses the root level of the tree as the sole path argument.
-- 
2.1.4
