From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] optimize git-resolve-script
Date: Wed, 25 May 2005 13:21:09 -0400
Message-ID: <4294B405.80205@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040102090900060104070902"
X-From: git-owner@vger.kernel.org Wed May 25 19:22:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DazXq-0002nl-Db
	for gcvg-git@gmane.org; Wed, 25 May 2005 19:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVEYRV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVEYRV3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 13:21:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41941 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261498AbVEYRVS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 13:21:18 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DazZF-0002Jr-Ra; Wed, 25 May 2005 17:21:18 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040102090900060104070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This change was suggested for my git-switch-tree script, so it probably 
applies to core git's git-resolve-script as well.



--------------040102090900060104070902
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/git-resolve-script b/git-resolve-script
--- a/git-resolve-script
+++ b/git-resolve-script
@@ -39,7 +39,7 @@ if [ "$common" == "$head" ]; then
 	echo "Destroying all noncommitted data!"
 	echo "Kill me within 3 seconds.."
 	sleep 3
-	git-read-tree -m $merge && git-checkout-cache -f -a && git-update-cache --refresh
+	git-read-tree -m $merge && git-checkout-cache -f -u -a
 	echo $merge > "$GIT_DIR"/HEAD
 	git-diff-tree -p ORIG_HEAD HEAD | diffstat -p1
 	exit 0
@@ -57,5 +57,5 @@ fi
 result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree -p $head -p $merge)
 echo "Committed merge $result_commit"
 echo $result_commit > "$GIT_DIR"/HEAD
-git-checkout-cache -f -a && git-update-cache --refresh
+git-checkout-cache -f -u -a
 git-diff-tree -p ORIG_HEAD HEAD | diffstat -p1

--------------040102090900060104070902--
