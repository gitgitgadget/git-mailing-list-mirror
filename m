From: Sebastian Kuzminsky <seb@highlab.com>
Subject: minor doc patch for cogito
Date: Fri, 10 Jun 2005 22:23:51 -0600
Message-ID: <E1DgxXD-0004Ky-SE@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 06:17:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgxR9-0005p4-CG
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 06:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFKEV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 00:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFKEV5
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 00:21:57 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:52884 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261158AbVFKEVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 00:21:51 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005061104215101400cud0se>; Sat, 11 Jun 2005 04:21:51 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DgxXD-0004Ky-SE
	for git@vger.kernel.org; Fri, 10 Jun 2005 22:23:51 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here are some minor changes to the Cogito docs, to add the manpage
section to the asciidoc links.  It also adds a 'txt' target to
Documentation/Makefile, so we can make the Cogito .txt docs if we want.


 Makefile             |    4 +++-
 make-cg-asciidoc     |    4 ++--
 make-cogito-asciidoc |   15 +++++++++++----
 3 files changed, 16 insertions(+), 7 deletions(-)


diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -18,7 +18,9 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT
 # yourself - yes, all 6 characters of it!
 #
 
-all: html man
+all: txt html man
+
+txt: $(MAN1_TXT) $(MAN7_TXT)
 
 html: $(DOC_HTML)
 
diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -40,7 +40,7 @@ CAPTION=$(echo "$HEADER" | head -n 1 | t
 # were referenced as "`cg-command`". This way references from cg-* combos in
 # code listings will be ignored.
 BODY=$(echo "$HEADER" | sed '0,/^$/d' \
-		      | sed 's/`\(cg-[a-z-]\+\)`/link:\1.html[\1]/')
+		      | sed 's/`\(cg-[a-z-]\+\)`/link:\1.html[\1(1)]/')
 
 DESCRIPTION=
 OPTIONS=
@@ -109,5 +109,5 @@ $COPYRIGHT
 SEE ALSO
 --------
 $COMMAND command is part of link:cogito.html[cogito(7)],
-a toolkit for managing link:git.html[git(1)] trees.
+a toolkit for managing link:git.html[git(7)] trees.
 __END__
diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -11,7 +11,14 @@ HELPER_COMMANDS="$(ls ../cg-X*) $(ls ../
 link()
 {
 	command="$1"
-	echo "link:$command.html['$command']"
+
+        if [ ! -z "$2" ]; then
+            section="($2)"
+        else
+            section=""
+        fi
+
+	echo "link:$command.html['$command$section']"
 }
 
 # Print description list entry.
@@ -62,7 +69,7 @@ storage system. Amongst some of the note
 for branching, tagging and multiple backends for distributing repositories
 (local files, rsync, HTTP, ssh).
 
-'Cogito' is implemented as a series of 'bash(1)' scripts on top of $(link git)
+'Cogito' is implemented as a series of 'bash(1)' scripts on top of $(link git 7)
 (a content-tracking filesystem) with the goal of providing an interface for
 working with the 'GIT' database in a manner similar to other SCM tools (like
 'CVS', 'BitKeeper' or 'Monotone').
@@ -107,13 +114,13 @@ $(print_command_listing $HELPER_COMMANDS
 Command Identifiers
 -------------------
 BRANCH_NAME::
-	Indicates a branch name added with the $(link cg-branch-add) command.
+	Indicates a branch name added with the $(link cg-branch-add 1) command.
 
 COMMAND::
 	Indicates a 'Cogito' command. The \`cg-\` prefix is optional.
 
 LOCATION::
-	Indicates a local file path or a URI. See $(link cg-branch-add) for a
+	Indicates a local file path or a URI. See $(link cg-branch-add 1) for a
 	list of supported URI schemes.
 
 COMMIT_ID, FROM_ID, TO_ID, BASE_COMMIT::
-- 
Sebastian Kuzminsky

-- 
Sebastian Kuzminsky
