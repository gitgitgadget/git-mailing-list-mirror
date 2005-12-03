From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/4] git-merge: Exit with code 2 if no strategy was able to handle the merge.
Date: Sat, 3 Dec 2005 11:40:21 +0100
Message-ID: <20051203104021.GB4896@c165.ib.student.liu.se>
References: <20051203103255.GA4896@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 11:41:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiUok-00049H-Qb
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 11:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVLCKkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 05:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLCKkW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 05:40:22 -0500
Received: from [85.8.31.11] ([85.8.31.11]:51645 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751210AbVLCKkW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 05:40:22 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 43BE74117; Sat,  3 Dec 2005 11:50:12 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EiUoX-0000KH-00; Sat, 03 Dec 2005 11:40:21 +0100
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20051203103255.GA4896@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13150>

This way it is possible to test in scripts if the merge was non-clean
or if the strategy had other problems with the merge.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

8fb7e4ef2b13f85966976c567cefb6a6d4c18c29
diff --git a/git-merge.sh b/git-merge.sh
index d352a3c..a221daa 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -273,7 +273,8 @@ fi
 case "$best_strategy" in
 '')
 	restorestate
-	die "No merge strategy handled the merge."
+	echo >&2 "No merge strategy handled the merge."
+	exit 2
 	;;
 "$wt_strategy")
 	# We already have its result in the working tree.
-- 
0.99.9.GIT
