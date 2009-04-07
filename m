From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 07/14] difftool: add a -y shortcut for --no-prompt
Date: Tue,  7 Apr 2009 01:21:19 -0700
Message-ID: <1239092483-14973-2-git-send-email-davvid@gmail.com>
References: <1239092483-14973-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 07 10:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6c6-00066J-JW
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbZDGIV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 04:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbZDGIVz
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:21:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:5823 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbZDGIVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:21:50 -0400
Received: by rv-out-0506.google.com with SMTP id b25so190130rvf.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+mTZyc+HeIica910wVA+/DQ1HsLfeYqWj/F8CYUBmZg=;
        b=eadSVGr3aE2GChK/PCQvYxWS2hZVSOzDwEwHli+icM2XbHMYr1jsc6wciOKCCqOWXO
         eQ5Z6a9YDHS9/Gn86OvB1aUd1EVrXMHt2LEKoqjeO6Uu1rTh1n+W9//4iONfICeefXyI
         z5j8hM12ctmzlSZEtMDXAvPJQL9+6P52nK0tE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u76H1UV6lz1ysvDwGASleWtfldzXDW0glcOiu+Drbw/199Kc8cMUiyUX9itwaeGTVx
         ItZkdw73W+PExCRloO3EeN3QcjLYu6IzOGw3b52fXyxiUbHjp691BmvsPGdIOgNOi1/F
         84tTUNj4Jo6dRoHVJZyoFIjkriZSLBghAB3Iw=
Received: by 10.114.77.1 with SMTP id z1mr2778807waa.214.1239092508375;
        Tue, 07 Apr 2009 01:21:48 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v39sm6566963wah.5.2009.04.07.01.21.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 01:21:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239092483-14973-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115933>

This is another consistency cleanup to make git-difftool's options
match git-mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Includes suggestions from Markus

 contrib/difftool/git-difftool     |    6 +++---
 contrib/difftool/git-difftool.txt |   36 ++++++++++++++----------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/contrib/difftool/git-difftool b/contrib/difftool/git-difftool
index 207dd50..8c160e5 100755
--- a/contrib/difftool/git-difftool
+++ b/contrib/difftool/git-difftool
@@ -18,7 +18,7 @@ my $DIR = abs_path(dirname($0));
 sub usage
 {
 	print << 'USAGE';
-usage: git difftool [--tool=<tool>] [--no-prompt] ["git diff" options]
+usage: git difftool [--tool=<tool>] [-y|--no-prompt] ["git diff" options]
 USAGE
 	exit 1;
 }
@@ -60,11 +60,11 @@ sub generate_command
 			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
 			next;
 		}
-		if ($arg eq '--no-prompt') {
+		if ($arg eq '-y' || $arg eq '--no-prompt') {
 			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
 			next;
 		}
-		if ($arg eq '-h' or $arg eq '--help') {
+		if ($arg eq '-h' || $arg eq '--help') {
 			usage();
 		}
 		push @command, $arg;
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index 2b7bc03..a00e943 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -3,35 +3,32 @@ git-difftool(1)
 
 NAME
 ----
-git-difftool - compare changes using common merge tools
+git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-'git difftool' [--tool=<tool>] [--no-prompt] ['git diff' options]
+'git difftool' [--tool=<tool>] [-y|--no-prompt] [<'git diff' options>]
 
 DESCRIPTION
 -----------
 'git-difftool' is a git command that allows you to compare and edit files
-between revisions using common merge tools.  At its most basic level,
-'git-difftool' does what 'git-mergetool' does but its use is for non-merge
-situations such as when preparing commits or comparing changes against
-the index.
-
-'git difftool' is a frontend to 'git diff' and accepts the same
-arguments and options.
-
-See linkgit:git-diff[1] for the full list of supported options.
+between revisions using common diff tools.  'git difftool' is a frontend
+to 'git-diff' and accepts the same options and arguments.
 
 OPTIONS
 -------
+-y::
+--no-prompt::
+	Do not prompt before launching a diff tool.
+
 -t <tool>::
 --tool=<tool>::
-	Use the merge resolution program specified by <tool>.
+	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
 	vimdiff, gvimdiff, ecmerge, and opendiff
 +
-If a merge resolution program is not specified, 'git-difftool'
+If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
 configuration variable `diff.tool` is not set, 'git-difftool'
 will pick a suitable default.
@@ -42,7 +39,7 @@ can configure the absolute path to kdiff3 by setting
 `difftool.kdiff3.path`. Otherwise, 'git-difftool' assumes the
 tool is available in PATH.
 +
-Instead of running one of the known merge tool programs,
+Instead of running one of the known diff tools,
 'git-difftool' can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `difftool.<tool>.cmd`.
@@ -56,8 +53,7 @@ is set to the name of the temporary file containing the contents
 of the diff post-image.  `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$LOCAL`.
 
---no-prompt::
-	Do not prompt before launching a diff tool.
+See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIG VARIABLES
 ----------------
@@ -65,21 +61,17 @@ CONFIG VARIABLES
 difftool equivalents have not been defined.
 
 diff.tool::
-	The default merge tool to use.
+	The default diff tool to use.
 
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
 difftool.<tool>.cmd::
-	Specify the command to invoke the specified merge tool.
+	Specify the command to invoke the specified diff tool.
 +
 See the `--tool=<tool>` option above for more details.
 
-merge.keepBackup::
-	The original, unedited file content can be saved to a file with
-	a `.orig` extension.  Defaults to `true` (i.e. keep the backup files).
-
 SEE ALSO
 --------
 linkgit:git-diff[1]::
-- 
1.6.2.2.414.g81aa9
