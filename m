From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 07/14] difftool: add a -y shortcut for --no-prompt
Date: Mon,  6 Apr 2009 01:31:22 -0700
Message-ID: <1239006689-14695-8-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
 <1239006689-14695-6-git-send-email-davvid@gmail.com>
 <1239006689-14695-7-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIJ-0002l9-7Y
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbZDFIcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZDFIcD
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:32:03 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:18484 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbZDFIb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:31:59 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1642088wah.21
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WDoZcAer1oij+5du1SJIDFpwdZGSu8QGV20aczao3yo=;
        b=QIPl0xquzwGfeg/2zTARRyMu2XLyX87tlDXEibkM2qhNutphLlKx5sZp1Dlreox9r+
         nz6oXXfrGVhMbsClyHSG5KiYTd+rF+srxoKP0WhPI5NVOzuzRiuoOitFP4MqnW2HataF
         aGMvwoxaNwGb2WlXewJj8EP7AgUglBxkyBVqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mhdRdeIfjWsqwsv2VdoWShKJc503TdxpJo6q05SCCRu3uDHSk/pv90/0tIO0AVZ/ft
         frhIsNagN/w6TP9KcXOxWFK64TIfIN75gsknEmDe48zXoFWjlzP9ycn50CMFHd+7yrml
         wYkiesoQ4fKwyp35/RlXh+fIcAd72DsduiY5Y=
Received: by 10.115.106.18 with SMTP id i18mr2142387wam.213.1239006717584;
        Mon, 06 Apr 2009 01:31:57 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k14sm5184056waf.58.2009.04.06.01.31.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:31:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-7-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115791>

This is another consistency cleanup to make git-difftool's options
match git-mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
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
index 2b7bc03..4dff529 100644
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
+'git difftool' [-t|--tool=<tool>] [-y|--no-prompt] [<'git diff' options>]
 
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
