From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 3/7] git-blame(1): mention options in the synopsis and advertise pickaxe
Date: Fri, 25 Aug 2006 03:01:49 +0200
Message-ID: <20060825010149.GD4069@diku.dk>
References: <20060818084545.GB4717@diku.dk> <7virkqbcq3.fsf@assigned-by-dhcp.cox.net> <20060825005655.GB4069@diku.dk> <20060825005820.GC4069@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 03:02:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQ5A-0005Oy-1c
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 03:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWHYBB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 21:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWHYBB5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 21:01:57 -0400
Received: from [130.225.96.91] ([130.225.96.91]:60079 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1422800AbWHYBB4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 21:01:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 812F177007C;
	Fri, 25 Aug 2006 03:01:53 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26104-15; Fri, 25 Aug 2006 03:01:50 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 15348770076;
	Fri, 25 Aug 2006 03:01:50 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E7D856DFAB8; Fri, 25 Aug 2006 03:00:31 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id ED81B629FB; Fri, 25 Aug 2006 03:01:49 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060825005820.GC4069@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25986>

Inspired by the cvs annotate documentation improve and expand the man page
to also mention the limitations of file annotations. Since people coming
from the SVN/CVS world might first look here, also briefly advertise how
the pickaxe interface makes it easy to go beyond these limitation.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-blame.txt |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

The advertising might be a bit too much, as in not belonging there.

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index bfed945..e1f8944 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -3,21 +3,38 @@ git-blame(1)
 
 NAME
 ----
-git-blame - Blame file lines on commits
+git-blame - Show what revision and author last modified each line of a file
 
 SYNOPSIS
 --------
-git-blame file [options] file [revision]
+'git-blame' [-c] [-l] [-t] [-S <revs-file>] [--] <file> [<rev>]
 
 DESCRIPTION
 -----------
-Annotates each line in the given file with information from the commit
-which introduced the line. Start annotation from the given revision.
+
+Annotates each line in the given file with information from the revision which
+last modified the line. Optionally, start annotating from the given revision.
+
+This report doesn't tell you anything about lines which have been deleted or
+replaced; you need to use a tool such as gitlink:git-diff[1] or the "pickaxe"
+interface briefly mentioned in the following paragraph.
+
+Apart from supporting file annotation, git also supports searching the
+development history for when a code snippet occured in a change. This makes it
+possible to track when a code snippet was added to a file, moved or copied
+between files, and eventually deleted or replaced. It works by searching for
+a text string in the diff. A small example:
+
+-----------------------------------------------------------------------------
+$ git log --pretty=oneline -S'blame_usage'
+5040f17eba15504bad66b14a645bddd9b015ebb7 blame -S <ancestry-file>
+ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
+-----------------------------------------------------------------------------
 
 OPTIONS
 -------
 -c, --compatibility::
-	Use the same output mode as git-annotate (Default: off).
+	Use the same output mode as gitlink:git-annotate[1] (Default: off).
 
 -l, --long::
 	Show long rev (Default: off).
@@ -26,7 +43,7 @@ OPTIONS
 	Show raw timestamp (Default: off).
 
 -S, --rev-file <revs-file>::
-	Use revs from revs-file instead of calling git-rev-list.
+	Use revs from revs-file instead of calling gitlink:git-rev-list[1].
 
 -h, --help::
 	Show help message.
-- 
1.4.2.GIT


-- 
Jonas Fonseca
