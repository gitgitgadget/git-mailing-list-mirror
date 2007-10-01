From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] mv: allow verbosity to be enabled using -v
Date: Mon, 1 Oct 2007 12:27:34 +0200
Message-ID: <20071001102734.GB8315@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 12:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcIXQ-0004aW-0z
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 12:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbXJAK3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 06:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbXJAK3v
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 06:29:51 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:37360 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbXJAK3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 06:29:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id B08C25F8C52
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 12:29:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Z-jiCVKv0SS for <git@vger.kernel.org>;
	Mon,  1 Oct 2007 12:29:46 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7FBF0600016
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 12:27:34 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 47BD86DFD26
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 12:22:23 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 6929C632B6; Mon,  1 Oct 2007 12:27:34 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59597>

The infrastructure was already there but the option parsing for it was
missing. Also, move full command line documentation to synopsis section.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-mv.txt |   10 +++++-----
 builtin-mv.c             |    6 +++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 2c9cf74..9cd1177 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -8,15 +8,14 @@ git-mv - Move or rename a file, a directory, or a symlink
 
 SYNOPSIS
 --------
-'git-mv' <options>... <args>...
+[verse]
+'git-mv' [-f] [-n] [-v] <source> <destination>
+'git-mv' [-f] [-n] [-v] [-k] <source> ... <destination directory>
 
 DESCRIPTION
 -----------
 This script is used to move or rename a file, directory or symlink.
 
- git-mv [-f] [-n] <source> <destination>
- git-mv [-f] [-n] [-k] <source> ... <destination directory>
-
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
 In the second form, the last argument has to be an existing
@@ -36,7 +35,8 @@ OPTIONS
         file unless '-f' is given.
 -n::
 	Do nothing; only show what would happen
-
+-v::
+	Be verbose.
 
 Author
 ------
diff --git a/builtin-mv.c b/builtin-mv.c
index b944651..620998e 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -10,7 +10,7 @@
 #include "path-list.h"
 
 static const char builtin_mv_usage[] =
-"git-mv [-n] [-f] (<source> <destination> | [-k] <source>... <destination>)";
+"git-mv [-n] [-f] [-v] (<source> <destination> | [-k] <source>... <destination>)";
 
 static const char **copy_pathspec(const char *prefix, const char **pathspec,
 				  int count, int base_name)
@@ -99,6 +99,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			ignore_errors = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-v")) {
+			verbose = 1;
+			continue;
+		}
 		usage(builtin_mv_usage);
 	}
 	count = argc - i - 1;
-- 
1.5.3.2.1029.gc1d178

-- 
Jonas Fonseca
