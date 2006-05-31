From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Update documentation for git-format-patch
Date: Wed, 31 May 2006 16:14:08 +0200
Message-ID: <20060531141408.G366d89c7@leonov.stosberg.net>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com> <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com> <20060531112803.GB3877@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: geoff@austrics.com.au, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 16:14:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlRSj-00024n-5j
	for gcvg-git@gmane.org; Wed, 31 May 2006 16:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWEaOOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 10:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWEaOOO
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 10:14:14 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:59331 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S965036AbWEaOON (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 10:14:13 -0400
Received: from leonov.stosberg.net (p213.54.78.240.tisdip.tiscali.de [213.54.78.240])
	by ncs.stosberg.net (Postfix) with ESMTP id CC3CDAEBA005;
	Wed, 31 May 2006 16:14:03 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 93ABA105AE4; Wed, 31 May 2006 16:14:08 +0200 (CEST)
To: Matthias Kestenholz <lists@spinlock.ch>
Content-Disposition: inline
In-Reply-To: <20060531112803.GB3877@spinlock.ch>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21066>

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
This updates the documentation for git-format-patch to reflect the
changes that the built-in version brought.

In addition to the functional changes, I reworded a few expressions
which sounded suspicious or unclear to me.  However, I'm not a
native English speaker, so corrections are welcome.

Is there any "patch" program at all that understands git's rename
patches?

Regards,
Dennis


 Documentation/git-format-patch.txt |   82 +++++++++++++++---------------------
 1 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 7cc7faf..64d3f1e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,70 +9,58 @@ git-format-patch - Prepare patches for e
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [-s] [-c]
-		 [--diff-options] <his> [<mine>]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach]
+	           [--diff-options] [--start-number <n>]
+		   <since>[..<until>]
 
 DESCRIPTION
 -----------
-Prepare each commit with its patch since <mine> head forked from
-<his> head, one file per patch formatted to resemble UNIX mailbox
-format, for e-mail submission or use with gitlink:git-am[1].
+
+Prepare each commit between <since> and <until> with its patch in
+one file per commit, formatted to resemble UNIX mailbox format.
+If ..<until> is not specified, the head of the current working
+tree is implied.
+
+The output of this command is convenient for e-mail submission or
+for use with gitlink:git-am[1].
 
 Each output file is numbered sequentially from 1, and uses the
-first line of the commit message (massaged for pathname safety)
-as the filename.
+first line of the commit message (checked for pathname safety) as
+the filename. The names of the output files are printed to standard
+output, unless the --stdout option is specified.
 
-When -o is specified, output files are created in <dir>; otherwise
-they are created in the current working directory.  This option
-is ignored if --stdout is specified.
+If -o is specified, output files are created in <dir>.  Otherwise
+they are created in the current working directory.
 
-When -n is specified, instead of "[PATCH] Subject", the first
-line is formatted as "[PATCH N/M] Subject", unless you have only
-one patch.
+If -n is specified, instead of "[PATCH] Subject", the first line
+is formatted as "[PATCH n/m] Subject".
 
 
 OPTIONS
 -------
 -o|--output-directory <dir>::
 	Use <dir> to store the resulting files, instead of the
-	current working directory.
+	current working directory. This option is ignored if
+	--stdout is specified.
 
 -n|--numbered::
 	Name output in '[PATCH n/m]' format.
 
+--start-number <n>::
+	Start numbering the patches with <n> instead of 1.
+
 -k|--keep-subject::
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
--s|--signoff::
-	Add `Signed-off-by:` line to the commit message, using
-	the committer identity of yourself.
-
--c|--check::
-        Display suspicious lines in the patch.  The definition
-        of 'suspicious lines' is currently the lines that has
-        trailing whitespaces, and the lines whose indentation
-        has a SP character immediately followed by a TAB
-        character.
-
 --stdout::
-	This flag generates the mbox formatted output to the
-	standard output, instead of saving them into a file per
-	patch and implies --mbox.
+	Print all commits to the standard output in mbox format,
+	instead of creating a file for each one.
 
 --attach::
 	Create attachments instead of inlining patches.
 
 
-CONFIGURATION
--------------
-You can specify extra mail header lines to be added to each
-message in the repository configuration as follows:
-
-[format]
-        headers = "Organization: git-foo\n"
-
-
 EXAMPLES
 --------
 
@@ -82,18 +70,18 @@ git-format-patch -k --stdout R1..R2 | gi
 	cherry-pick them.
 
 git-format-patch origin::
-	Extract commits the current branch accumulated since it
-	pulled from origin the last time in a patch form for
-	e-mail submission.
+	Extract all commits which are in the current branch but
+	not in the origin branch.  For each commit a separate file
+	is created in the current directory.
 
 git-format-patch -M -B origin::
-	The same as the previous one, except detect and handle
-	renames and complete rewrites intelligently to produce
-	renaming patch.  A renaming patch reduces the amount of
-	text output, and generally makes it easier to review
-	it.  Note that the "patch" program does not understand
-	renaming patch well, so use it only when you know the
-	recipient uses git to apply your patch.
+	The same as the previous one.  Additionally, it detects
+	and handles renames and complete rewrites intelligently to
+	produce a renaming patch.  A renaming patch reduces the
+	amount of text output, and generally makes it easier to
+	review it.  Note that the "patch" program does not
+	understand renaming patches, so use it only when you know
+	the recipient uses git to apply your patch.
 
 
 See Also
-- 
1.3.3+git20060531-dest1
