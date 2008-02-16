From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Correct git-pull documentation
Date: Fri, 15 Feb 2008 23:50:41 -0500
Message-ID: <1203137441-52448-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 05:51:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQF1M-000382-4q
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbYBPEus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYBPEus
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:50:48 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:44687 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbYBPEur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:50:47 -0500
Received: by an-out-0708.google.com with SMTP id d31so207538and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 20:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=YaGR/xA1s465ayxDKR5Vkye/kLH7npuvDLEWFNNO8MU=;
        b=Piz/dnIwQ3HQUcG0mYB7cTi128LE/DTU5PeI5isZq46+eSm3rheYGsOj2pnwPkEZQ0ypSbVhV81jTpTgZaNRrZCGL0e1cPsJzU1Em/crsqON1Wh4I1Mci52xUogefICsPS4dq/rKul01LzXCyWZljQ9CyYKDDiU9W5fwUe5xktg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=DzwX59ZeJn8B5KFYE/GbCeA3AtCwvGsEJyOlhlL6IOOCvf8zZ7iMO/I9y9lgX/y9IQZ6fSg/Lb+HQqymaFPW3DJq+oQyVmDLefbiNGlBK5aV7vkZOcFLwYiqrHP5hlAQtKUR38tfSWPmVRNKbQNM1BrEBZOL1ifn+PZqkKiuGi4=
Received: by 10.101.70.5 with SMTP id x5mr5463319ank.59.1203137444090;
        Fri, 15 Feb 2008 20:50:44 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d25sm9539999and.2.2008.02.15.20.50.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 20:50:43 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74008>

The --rebase option was documented in the wrong place (under MERGE
STRATEGIES instead of OPTIONS). Noted the branch.<name>.rebase
option and clarified the use '.' in a few places. Switched
"git-<command>" to "git command".

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-pull.txt |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 179bdfc..f734f18 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -8,13 +8,14 @@ git-pull - Fetch from and merge with another repository or a local branch
 
 SYNOPSIS
 --------
-'git-pull' <options> <repository> <refspec>...
+'git-pull' [<options>] [<repository>] [<refspec>...]
 
 
 DESCRIPTION
 -----------
-Runs `git-fetch` with the given parameters, and calls `git-merge`
-to merge the retrieved head(s) into the current branch.
+Runs `git fetch` with the given parameters, and calls `git merge` or
+`git rebase` to merge or rebase the retrieved head(s) into the
+current branch.
 
 Note that you can use `.` (current directory) as the
 <repository> to pull from the local repository -- this is useful
@@ -28,17 +29,12 @@ include::merge-options.txt[]
 :git-pull: 1
 include::fetch-options.txt[]
 
-include::pull-fetch-param.txt[]
-
-include::urls-remotes.txt[]
-
-include::merge-strategies.txt[]
-
 \--rebase::
 	Instead of a merge, perform a rebase after fetching.  If
 	there is a remote ref for the upstream branch, and this branch
 	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes.
+	to avoid rebasing non-local changes. This if the default if
+	`branch.<name>.rebase` is set.
 +
 *NOTE:* This is a potentially _dangerous_ mode of operation.
 It rewrites history, which does not bode well when you
@@ -48,6 +44,12 @@ unless you have read linkgit:git-rebase[1] carefully.
 \--no-rebase::
 	Override earlier \--rebase.
 
+include::pull-fetch-param.txt[]
+
+include::urls-remotes.txt[]
+
+include::merge-strategies.txt[]
+
 DEFAULT BEHAVIOUR
 -----------------
 
@@ -55,12 +57,13 @@ Often people use `git pull` without giving any parameter.
 Traditionally, this has been equivalent to saying `git pull
 origin`.  However, when configuration `branch.<name>.remote` is
 present while on branch `<name>`, that value is used instead of
-`origin`.
+`origin`. (`branch.<name>.remote` may be set to `.` to pull from 
+the local repository by default.)
 
-In order to determine what URL to use to fetch from, the value
-of the configuration `remote.<origin>.url` is consulted
-and if there is not any such variable, the value on `URL: ` line
-in `$GIT_DIR/remotes/<origin>` file is used.
+Unless pulling from the local repository, a URL must be determined
+for the origin. This is done by first consulting
+`remote.<origin>.url`. If there is not any such variable, the value
+on `URL: ` line in `$GIT_DIR/remotes/<origin>` file is used.
 
 In order to determine what remote branches to fetch (and
 optionally store in the tracking branches) when the command is
@@ -138,6 +141,9 @@ You should refrain from abusing this option to sneak substantial
 changes into a merge commit.  Small fixups like bumping
 release/version name would be acceptable.
 
+git pull --rebase . master::
+	This syntax is equivalent to calling `git rebase master`; see
+	linkgit:git-rebase[1] for details.
 Command line pull of multiple branches from one repository::
 +
 ------------------------------------------------
@@ -163,7 +169,7 @@ linkgit:git-reset[1].
 
 SEE ALSO
 --------
-linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1]
+linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1], linkgit:git-rebase[1]
 
 
 Author
-- 
1.5.4.1.1281.g75df
