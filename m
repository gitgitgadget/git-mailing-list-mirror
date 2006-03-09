From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] clone: add refs/remotes/* to Pull: targets when cloning
Date: Thu, 9 Mar 2006 03:55:35 -0800
Message-ID: <20060309115535.GB13369@localdomain>
References: <20060309115452.GA13369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 09 12:56:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJkq-0003Cq-1P
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWCIL4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWCIL4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:56:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:10690 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751844AbWCIL4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 06:56:25 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E6A5A7DC005;
	Thu,  9 Mar 2006 03:56:23 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu,  9 Mar 2006 03:55:35 -0800
To: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060309115452.GA13369@localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17414>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-clone.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

be2db2344099b3713c1136e84bab7390b6198895
diff --git a/git-clone.sh b/git-clone.sh
index 4ed861d..a8ab7fd 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -249,6 +249,12 @@ Pull: $head_points_at:$origin" &&
 			test "$origin" = "$head" ||
 			echo "Pull: ${head}:${head}"
 		done >>"$GIT_DIR/remotes/origin"
+		(test -d "$GIT_DIR"/refs/remotes && cd "$GIT_DIR" &&
+		 find "refs/remotes" -type f -print | sed -e 's|^refs/||') |
+		while read ref
+		do
+			echo "Pull: $ref:$ref"
+		done >>"$GIT_DIR/remotes/origin"
 	esac
 
 	case "$no_checkout" in
-- 
1.2.4.ga2910
