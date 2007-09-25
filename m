From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Move convert-objects to contrib.
Date: Tue, 25 Sep 2007 07:03:46 -0700
Message-ID: <1190729026-531-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 16:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaB1R-0002oA-R5
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbXIYOEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbXIYOEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:04:09 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:35341 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbXIYOEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:04:08 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1IaBHx-0001Tq-8j; Tue, 25 Sep 2007 07:21:31 -0700
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1IaB0u-00008r-8o; Tue, 25 Sep 2007 07:03:48 -0700
X-Mailer: git-send-email 1.5.3.2
X-Spam-Score: -4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59123>

convert-objects was needed to convert from an old-style repository,
which hashed the compressed contents and used a different date format.
Such repositories are presumably no longer common and, if such
conversions are necessary, should be done by writing a frontend for
git-fast-import.

Linus, the original author, is OK with moving it to contrib.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---

	I've expanded the commit message and used -M to detect renamed
	files, based on feedback from Johannes Schindelin.

 .gitignore                                         |    1 -
 Documentation/cmd-list.perl                        |    1 -
 Makefile                                           |    2 +-
 contrib/completion/git-completion.bash             |    1 -
 .../convert-objects/convert-objects.c              |    0 
 .../convert-objects}/git-convert-objects.txt       |    0 
 6 files changed, 1 insertions(+), 4 deletions(-)
 rename convert-objects.c => contrib/convert-objects/convert-objects.c (100%)
 rename {Documentation => contrib/convert-objects}/git-convert-objects.txt (100%)

diff --git a/.gitignore b/.gitignore
index 63c918c..e0b91be 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,7 +25,6 @@ git-clone
 git-commit
 git-commit-tree
 git-config
-git-convert-objects
 git-count-objects
 git-cvsexportcommit
 git-cvsimport
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 4ee76ea..1061fd8 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -94,7 +94,6 @@ git-clone                               mainporcelain
 git-commit                              mainporcelain
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
-git-convert-objects                     ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
 git-cvsexportcommit                     foreignscminterface
 git-cvsimport                           foreignscminterface
diff --git a/Makefile b/Makefile
index 0055eef..94b16d0 100644
--- a/Makefile
+++ b/Makefile
@@ -233,7 +233,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
-	git-convert-objects$X git-fetch-pack$X \
+	git-fetch-pack$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-fast-import$X \
 	git-daemon$X \
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cad842a..e760930 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -299,7 +299,6 @@ __git_commands ()
 		check-attr)       : plumbing;;
 		check-ref-format) : plumbing;;
 		commit-tree)      : plumbing;;
-		convert-objects)  : plumbing;;
 		cvsexportcommit)  : export;;
 		cvsimport)        : import;;
 		cvsserver)        : daemon;;
diff --git a/convert-objects.c b/contrib/convert-objects/convert-objects.c
similarity index 100%
rename from convert-objects.c
rename to contrib/convert-objects/convert-objects.c
diff --git a/Documentation/git-convert-objects.txt b/contrib/convert-objects/git-convert-objects.txt
similarity index 100%
rename from Documentation/git-convert-objects.txt
rename to contrib/convert-objects/git-convert-objects.txt
-- 
1.5.3.2
