From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 3/4] git-fetch: Add --recover option
Date: Wed, 14 Sep 2005 16:47:37 +0400
Message-ID: <20050914124737.GF24405@master.mivlgu.local>
References: <20050914124206.GC24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 14:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFWft-0002rU-KB
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 14:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVINMrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVINMrj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 08:47:39 -0400
Received: from mivlgu.ru ([81.18.140.87]:1985 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S965152AbVINMri (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 08:47:38 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 84961180119; Wed, 14 Sep 2005 16:47:37 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050914124206.GC24405@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8521>

Make git-fetch accept the --recover option and pass it to
git-http-fetch (for other protocols this option is ignored).

---

 I would add the documentation in the same patch, but noticed that
 other options of git-fetch were not documented, so I made a separate
 patch which documents all of them.


 git-fetch.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

e19be8e89d20745918c76c4b587c286cef88d023
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -8,6 +8,7 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x4
 append=
 force=
 update_head_ok=
+recover_option=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -22,6 +23,9 @@ do
 	--update-head-o|--update-head-ok)
 		update_head_ok=t
 		;;
+	-r|--r|--re|--rec|--reco|--recov|--recove|--recover)
+		recover_option="--recover"
+		;;
 	*)
 		break
 		;;
@@ -179,7 +183,7 @@ do
 	expr "$head" : "$_x40\$" >/dev/null ||
 		die "Failed to fetch $remote_name from $remote"
 	echo Fetching "$remote_name from $remote" using http
-	git-http-fetch -v -a "$head" "$remote/" || exit
+	git-http-fetch -v -a $recover_option "$head" "$remote/" || exit
 	;;
     rsync://*)
 	TMP_HEAD="$GIT_DIR/TMP_HEAD"
