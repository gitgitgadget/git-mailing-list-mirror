From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] Documentation: Add diff.<driver>.* to config
Date: Sun,  3 Apr 2011 19:55:21 +0530
Message-ID: <1301840722-24344-3-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1301840722-24344-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Helped-by: Michael J Gruber" <git@drmicha.warpmail.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 16:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6OGU-0002ct-HJ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 16:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab1DCO0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 10:26:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42759 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1DCO0m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 10:26:42 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so4981839iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Bj0+6fR0sGwwAkl9ypv9T5ER51UD6gmwVgmFm30pyvs=;
        b=h9NkvEGnhI6IXUu/ylVxtvsy970rJPhofzGdTXFc+hrJkgEfdEJUONTvaVuv5jg+oJ
         hTvv54/m/MUxlAGR3LGzSXKyn/VPUgngiOozNqbFwXz5mBcD4Rp6UjlmA0MIkDrWOd6u
         y0hAt51Ho9gO+sIyamJMRMefQtkK7h1tNyNKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZB5gGRQzIo8jAVAJbsMiOweHrJqwbaVjYe7HgJkXcue9BYa5GserT8XsATR6dmxlou
         TaffAGxvzzBbFhys24tVPu5J/VMLlK5l6/tIhGLgFrzoI64YKgW90gutd+FBf+II+dLi
         TzBUXJ1ZwM+0qM1BHXJhl/4R4zUVZCLyf5RAE=
Received: by 10.43.51.74 with SMTP id vh10mr141952icb.512.1301840802466;
        Sun, 03 Apr 2011 07:26:42 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i3sm3011074iby.40.2011.04.03.07.26.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 07:26:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301840722-24344-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170694>

Although the gitattributes page contains comprehensive information
about these configuration options, they should be included in the
config documentation for completeness.  Also, move out the diff.*
configuration options into a dedicated diff-config.txt.

Helped-by: Jakub Narebski <jnareb@gmail.com>
Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt      |   63 +----------------------------
 Documentation/diff-config.txt |   91 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/diff-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 711072c..cfeef63 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -812,68 +812,7 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
-diff.autorefreshindex::
-	When using 'git diff' to compare with work tree
-	files, do not consider stat-only change as changed.
-	Instead, silently run `git update-index --refresh` to
-	update the cached stat information for paths whose
-	contents in the work tree match the contents in the
-	index.  This option defaults to true.  Note that this
-	affects only 'git diff' Porcelain, and not lower level
-	'diff' commands such as 'git diff-files'.
-
-diff.external::
-	If this config variable is set, diff generation is not
-	performed using the internal diff machinery, but using the
-	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
-	environment variable.  The command is called with parameters
-	as described under "git Diffs" in linkgit:git[1].  Note: if
-	you want to use an external diff program only on a subset of
-	your files, you	might want to use linkgit:gitattributes[5] instead.
-
-diff.mnemonicprefix::
-	If set, 'git diff' uses a prefix pair that is different from the
-	standard "a/" and "b/" depending on what is being compared.  When
-	this configuration is in effect, reverse diff output also swaps
-	the order of the prefixes:
-`git diff`;;
-	compares the (i)ndex and the (w)ork tree;
-`git diff HEAD`;;
-	 compares a (c)ommit and the (w)ork tree;
-`git diff --cached`;;
-	compares a (c)ommit and the (i)ndex;
-`git diff HEAD:file1 file2`;;
-	compares an (o)bject and a (w)ork tree entity;
-`git diff --no-index a b`;;
-	compares two non-git things (1) and (2).
-
-diff.noprefix::
-	If set, 'git diff' does not show any source or destination prefix.
-
-diff.renameLimit::
-	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git diff' option '-l'.
-
-diff.renames::
-	Tells git to detect renames.  If set to any boolean value, it
-	will enable basic rename detection.  If set to "copies" or
-	"copy", it will detect copies, as well.
-
-diff.ignoreSubmodules::
-	Sets the default value of --ignore-submodules. Note that this
-	affects only 'git diff' Porcelain, and not lower level 'diff'
-	commands such as 'git diff-files'. 'git checkout' also honors
-	this setting when reporting uncommitted changes.
-
-diff.suppressBlankEmpty::
-	A boolean to inhibit the standard behavior of printing a space
-	before each empty output line. Defaults to false.
-
-diff.tool::
-	Controls which diff tool is used.  `diff.tool` overrides
-	`merge.tool` when used by linkgit:git-difftool[1] and has
-	the same valid values as `merge.tool` minus "tortoisemerge"
-	and plus "kompare".
+include::diff-config.txt[]
 
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
new file mode 100644
index 0000000..8c1732f
--- /dev/null
+++ b/Documentation/diff-config.txt
@@ -0,0 +1,91 @@
+diff.autorefreshindex::
+	When using 'git diff' to compare with work tree
+	files, do not consider stat-only change as changed.
+	Instead, silently run `git update-index --refresh` to
+	update the cached stat information for paths whose
+	contents in the work tree match the contents in the
+	index.  This option defaults to true.  Note that this
+	affects only 'git diff' Porcelain, and not lower level
+	'diff' commands such as 'git diff-files'.
+
+diff.external::
+	If this config variable is set, diff generation is not
+	performed using the internal diff machinery, but using the
+	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
+	environment variable.  The command is called with parameters
+	as described under "git Diffs" in linkgit:git[1].  Note: if
+	you want to use an external diff program only on a subset of
+	your files, you	might want to use linkgit:gitattributes[5] instead.
+
+diff.ignoreSubmodules::
+	Sets the default value of --ignore-submodules. Note that this
+	affects only 'git diff' Porcelain, and not lower level 'diff'
+	commands such as 'git diff-files'. 'git checkout' also honors
+	this setting when reporting uncommitted changes.
+
+diff.mnemonicprefix::
+	If set, 'git diff' uses a prefix pair that is different from the
+	standard "a/" and "b/" depending on what is being compared.  When
+	this configuration is in effect, reverse diff output also swaps
+	the order of the prefixes:
+`git diff`;;
+	compares the (i)ndex and the (w)ork tree;
+`git diff HEAD`;;
+	 compares a (c)ommit and the (w)ork tree;
+`git diff --cached`;;
+	compares a (c)ommit and the (i)ndex;
+`git diff HEAD:file1 file2`;;
+	compares an (o)bject and a (w)ork tree entity;
+`git diff --no-index a b`;;
+	compares two non-git things (1) and (2).
+
+diff.noprefix::
+	If set, 'git diff' does not show any source or destination prefix.
+
+diff.renameLimit::
+	The number of files to consider when performing the copy/rename
+	detection; equivalent to the 'git diff' option '-l'.
+
+diff.renames::
+	Tells git to detect renames.  If set to any boolean value, it
+	will enable basic rename detection.  If set to "copies" or
+	"copy", it will detect copies, as well.
+
+diff.suppressBlankEmpty::
+	A boolean to inhibit the standard behavior of printing a space
+	before each empty output line. Defaults to false.
+
+diff.tool::
+	Controls which diff tool is used.  `diff.tool` overrides
+	`merge.tool` when used by linkgit:git-difftool[1] and has
+	the same valid values as `merge.tool` minus "tortoisemerge"
+	and plus "kompare".
+
+diff.<driver>.command::
+	Defines the command that implements the custom diff driver.
+	See linkgit:gitattributes[5] for details.
+
+diff.<driver>.xfuncname::
+	Defines the regular expression that the custom diff driver
+	should use to recognize the hunk header.  A built-in pattern
+	may also be used.  See linkgit:gitattributes[5] for details.
+
+diff.<driver>.binary::
+	Set this option to true to make the custom diff driver treat
+	files as binary.  See linkgit:gitattributes[5] for details.
+
+diff.<driver>.textconv::
+	Defines the command that the custom diff driver should call to
+	generate the text-converted version of a binary file.  The
+	result of the conversion is used to generate a human-readable
+	diff.  See linkgit:gitattributes[5] for details.
+
+diff.<driver>.wordregex::
+	Defines the regular expression that the custom diff driver
+	should use to split words in a line.  See
+	linkgit:gitattributes[5] for details.
+
+diff.<driver>.cachetextconv::
+	Set this option to true to make the custom diff driver cache
+	the text conversion outputs.  See linkgit:gitattributes[5] for
+	details.
-- 
1.7.4.rc1.7.g2cf08.dirty
