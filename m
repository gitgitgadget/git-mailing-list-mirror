From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 2/9] git-sh-setup.sh: add variable to use the stuck-long mode
Date: Mon, 10 Feb 2014 01:03:31 +0000
Message-ID: <1391994218-639101-3-git-send-email-sandals@crustytoothpaste.net>
References: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 10 02:04:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCfI1-0001Gz-3h
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 02:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbaBJBDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 20:03:47 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51734 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752066AbaBJBDp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 20:03:45 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CDFE628083;
	Mon, 10 Feb 2014 01:03:43 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241887>

From: Nicolas Vigier <boklm@mars-attacks.org>

If the variable $OPTIONS_STUCKLONG is not empty, then rev-parse
option parsing is done in --stuck-long mode.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 contrib/git-resurrect.sh | 1 +
 git-am.sh                | 1 +
 git-instaweb.sh          | 1 +
 git-quiltimport.sh       | 1 +
 git-rebase.sh            | 1 +
 git-request-pull.sh      | 1 +
 git-sh-setup.sh          | 2 ++
 7 files changed, 8 insertions(+)

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index a4ed4c3..d7e97bb 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -10,6 +10,7 @@ is rather slow but allows you to resurrect other people's topic
 branches."
 
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git resurrect $USAGE
 --
diff --git a/git-am.sh b/git-am.sh
index bbea430..a3b6f98 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -4,6 +4,7 @@
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git am [options] [(<mbox>|<Maildir>)...]
 git am [options] (--continue | --skip | --abort)
diff --git a/git-instaweb.sh b/git-instaweb.sh
index e93a238..4aa3eb8 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -5,6 +5,7 @@
 
 PERL='@@PERL@@'
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git instaweb [options] (--start | --stop | --restart)
 --
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 8e17525..167d79f 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git quiltimport [options]
 --
diff --git a/git-rebase.sh b/git-rebase.sh
index 8a3efa2..c1f98ae 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -5,6 +5,7 @@
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
diff --git a/git-request-pull.sh b/git-request-pull.sh
index fe21d5d..cf4f150 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -9,6 +9,7 @@ LONG_USAGE='Summarizes the changes between two commits to the standard output,
 and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK='Yes'
 OPTIONS_KEEPDASHDASH=
+OPTIONS_STUCKLONG=
 OPTIONS_SPEC='git request-pull [options] start url [end]
 --
 p    show patch text as well
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index fffa3c7..5f28b32 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -72,6 +72,8 @@ if test -n "$OPTIONS_SPEC"; then
 	parseopt_extra=
 	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
 		parseopt_extra="--keep-dashdash"
+	[ -n "$OPTIONS_STUCKLONG" ] &&
+		parseopt_extra="$parseopt_extra --stuck-long"
 
 	eval "$(
 		echo "$OPTIONS_SPEC" |
-- 
1.9.0.rc3.1008.gd08b47c.dirty
