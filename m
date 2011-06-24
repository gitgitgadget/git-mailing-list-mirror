From: =?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
Subject: [PATCH] Documentation: Clarify guessing of core.bare
Date: Fri, 24 Jun 2011 16:43:31 +0200
Message-ID: <1308926611-27917-1-git-send-email-git@christof-krueger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 16:44:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qa7c9-0000WN-8R
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 16:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759387Ab1FXOoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jun 2011 10:44:05 -0400
Received: from vserver.localhost.li ([85.214.46.152]:56825 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758698Ab1FXOoB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2011 10:44:01 -0400
Received: from p5794c767.dip.t-dialin.net ([87.148.199.103]:52776 helo=oxylap)
	by mail.localhost.li with esmtpa (Exim 4.69)
	(envelope-from <oxygene@localhost.li>)
	id 1Qa7bv-0007sP-Lk; Fri, 24 Jun 2011 16:43:56 +0200
Received: by oxylap (Postfix, from userid 1000)
	id 9093CDC14E7; Fri, 24 Jun 2011 16:43:53 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.rc3.2.g94021
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176308>

Make clear that core.bare is guessed based on GIT_DIR only and not on
what is optionally specified as a directory on the command line.

While "git init test.git" creates a non-bare repo in "test.git/.git",
"GIT_DIR=3Dtest.git git init" creates a bare repo in "test.git".

Also mention guessing of core.bare in the documentation of "git init"
and "git clone".

Signed-off-by: Christof Kr=C3=BCger <git@christof-krueger.de>
---
 Documentation/config.txt    |    8 ++++----
 Documentation/git-clone.txt |    4 +++-
 Documentation/git-init.txt  |    6 ++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b93777..c44c112 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -311,10 +311,10 @@ core.bare::
 	disabled, such as linkgit:git-add[1] or linkgit:git-merge[1].
 +
 This setting is automatically guessed by linkgit:git-clone[1] or
-linkgit:git-init[1] when the repository was created.  By default a
-repository that ends in "/.git" is assumed to be not bare (bare =3D
-false), while all other repositories are assumed to be bare (bare
-=3D true).
+linkgit:git-init[1] when the repository was created.  By
+default, a bare repository is assumed if the last directory
+component in the GIT_DIR environment variable differs from
+".git".
=20
 core.worktree::
 	Set the path to the root of the working tree.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b093e45..4a5af49 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -127,7 +127,9 @@ objects from the source repository into a pack in t=
he cloned repository.
 	to corresponding local branch heads, without mapping
 	them to `refs/remotes/origin/`.  When this option is
 	used, neither remote-tracking branches nor the related
-	configuration variables are created.
+	configuration variables are created.  Setting GIT_DIR to
+	a path whose last directory component is different from
+	".git" implies --bare.
=20
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index f2777a7..ba3979c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -46,8 +46,10 @@ Only print error and warning messages, all other out=
put will be suppressed.
=20
 --bare::
=20
-Create a bare repository. If GIT_DIR environment is not set, it is set=
 to the
-current working directory.
+Create a bare repository. If the GIT_DIR environment variable is not s=
et, the
+bare repository is created in the current working directory.  Setting =
GIT_DIR
+to a path whose last directory component is different from ".git" impl=
ies
+--bare.
=20
 --template=3D<template_directory>::
=20
--=20
1.7.6.rc3.2.g94021
