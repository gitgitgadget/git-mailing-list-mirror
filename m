From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] am: support --include option
Date: Wed, 28 Mar 2012 13:11:28 +0200
Message-ID: <1332933088.3479.27.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 13:11:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCqn2-0003cf-OO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 13:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244Ab2C1LLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 07:11:31 -0400
Received: from he.sipsolutions.net ([78.46.109.217]:58365 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab2C1LLb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 07:11:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.77)
	(envelope-from <johannes@sipsolutions.net>)
	id 1SCqmn-00010K-CY
	for git@vger.kernel.org; Wed, 28 Mar 2012 13:11:29 +0200
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194118>

am supports a number of pass-through options
to apply, like --exclude and --directory. Add
--include to this list.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 Documentation/git-am.txt |    3 ++-
 git-am.sh                |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ee6cca2..19d57a8 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--exclude=<path>] [--reject] [-q | --quiet]
+	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--scissors | --no-scissors]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
@@ -92,6 +92,7 @@ default.   You can use `--no-utf8` to override this.
 -p<n>::
 --directory=<dir>::
 --exclude=<path>::
+--include=<path>::
 --reject::
 	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
 	program that applies
diff --git a/git-am.sh b/git-am.sh
index 4da0dda..928a35f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -24,6 +24,7 @@ ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
 directory=      pass it through git-apply
 exclude=        pass it through git-apply
+include=        pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
 patch-format=   format the patch(es) are in
@@ -412,7 +413,7 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace|--directory|--exclude)
+	--whitespace|--directory|--exclude|--include)
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
-- 
1.7.9.1
