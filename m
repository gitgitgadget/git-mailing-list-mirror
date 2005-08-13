From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 3/5] Generate Documentation/introduction.html from the README file
Date: Sat, 13 Aug 2005 18:26:33 +0200
Message-ID: <20050813162633.GD968@diku.dk>
References: <20050813162352.GA968@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:26:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3yqE-0000ME-5G
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVHMQ0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVHMQ0g
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:26:36 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:20442 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932179AbVHMQ0f (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:26:35 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id F03396E1489; Sat, 13 Aug 2005 18:26:21 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7D60C6E12E2; Sat, 13 Aug 2005 18:26:21 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9AA9960A44; Sat, 13 Aug 2005 18:26:33 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050813162352.GA968@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Convert section names to use AsciiDoc markup. Fix a typo and refer to the
cg-* manpages.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/Makefile |    5 ++++-
 README                 |   36 ++++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -4,7 +4,7 @@ CG_SRC=$(filter-out $(CG_IGNORE), $(wild
 MAN1_TXT=$(patsubst ../cg-%,cg-%.txt,$(CG_SRC))
 MAN7_TXT=cogito.txt
 
-DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT)) introduction.html
 
 DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
 DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
@@ -54,6 +54,9 @@ clean:
 
 .PRECIOUS: %.txt
 
+introduction.html: ../README
+	asciidoc -b xhtml11 -d article -f asciidoc.conf -o $@ $<
+
 %.html : %.txt
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
diff --git a/README b/README
--- a/README
+++ b/README
@@ -1,5 +1,5 @@
-	The Cogito Version Control System
-	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The Cogito Version Control System
+=================================
 
 Cogito is a version control system layered on top of the git tree history
 storage system. Note that you can MOSTLY use it in parallel of other GIT
@@ -13,7 +13,8 @@ We shall first describe some quick ways 
 over each available command one by one.
 
 
-	Downloading Cogito From Scratch
+Downloading Cogito From Scratch
+-------------------------------
 
 Cogito can be obtained as a tarball from
 
@@ -39,13 +40,15 @@ The following tools are optional but str
 	           preferred over the BSD variants)
 
 
-        Starting a Fresh GIT Repository
+Starting a Fresh GIT Repository
+-------------------------------
 
 If you want to start your own project using Cogito, there are two basic ways
 to do this. You may start a fresh repository with no files in it, or you may
 take an existing directory tree and turn it into a GIT repository.
 
-	Starting an Empty Repository
+Starting an Empty Repository
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To create a new repository with no files in it, cd into an empty directory,
 and give the following command:
@@ -59,7 +62,8 @@ That's it! You're now in your own GIT re
 directory. Go into it and look around, but don't change anything in there.
 That's what Cogito commands are for.
 
-	Turning an Existing Directory Into a Repository
+Turning an Existing Directory Into a Repository
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If you have a directory full of files, you can easily turn this into a
 GIT repository. In fact, it is virtually the same as starting an empty
@@ -73,9 +77,11 @@ editor, and you're good to go. All of th
 directory are now part of a GIT archive.
 
 
-	Accessing Someone Else's GIT Repository
+Accessing Someone Else's GIT Repository
+---------------------------------------
 
-	Creating the Repository
+Creating the Repository
+~~~~~~~~~~~~~~~~~~~~~~~
 
 If you want to get started tracking an outside GIT repository, you first
 must have Cogito's executables on your $PATH. Next, you need the URL (or
@@ -114,7 +120,8 @@ When you get your prompt back, do an ls 
 directory.
 
 
-    Tracking Others' Work
+Tracking Others' Work
+~~~~~~~~~~~~~~~~~~~~~
 
 Of course, once you have cloned a repository, you don't just want to leave
 it at that. The upstream sources are constantly being updated, and you want
@@ -170,7 +177,8 @@ since your cg-pull. The alternative and 
 the cg-merge command, which we shall describe later.
 
 
-	Other Stuff
+Other Stuff
+~~~~~~~~~~~
 
 If there are any changes, two IDs will be printed (I mean the line saying
 "Tree change"). Pass those as parameters to cg-diff and you will get a diff
@@ -222,10 +230,11 @@ Note that we missed out a lot of stuff h
 for merging (cg-merge), moving your tree to an older commit (cg-seek), etc.
 
 
-	Getting Help
+Getting Help
+------------
 
 Cogito commands come with their own helpful documentation. To get help on
-cg-update, for example, give this command:
+cg-pull, for example, give this command:
 
 	$ cg-pull --help
 
@@ -233,6 +242,9 @@ or, for the same information, try this:
 
 	$ cg-help cg-pull
 
+Additionally, the man pages for the individual commands can be used as a
+reference.
+
 You can ask thoughtful questions and make suggestions on the GIT mailing list:
 
 	git@vger.kernel.org

-- 
Jonas Fonseca
