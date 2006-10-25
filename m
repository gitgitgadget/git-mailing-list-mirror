X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: andyparkins@gmail.com
Subject: (unknown)
Date: Wed, 25 Oct 2006 15:47:20 +0100
Message-ID: <E1Gck2K-0003H4-00@dvr.360vision.com>
NNTP-Posting-Date: Wed, 25 Oct 2006 14:47:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-OriginalArrivalTime: 25 Oct 2006 14:50:21.0308 (UTC) FILETIME=[E52DB3C0:01C6F844]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30059>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gck2W-0006Dc-TM for gcvg-git@gmane.org; Wed, 25 Oct
 2006 16:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932214AbWJYOr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 10:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWJYOr2
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 10:47:28 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:40983 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S932214AbWJYOr1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 10:47:27 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 25 Oct 2006 15:50:21 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gck2K-0003H4-00 for <git@vger.kernel.org>; Wed, 25 Oct
 2006 15:47:20 +0100
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org

From cd4366ed4e3f765c00310c35c0eabeccf433acdb Mon Sep 17 00:00:00 2001
From: Andy Parkins <andyparkins@gmail.com>
Date: Wed, 25 Oct 2006 15:47:19 +0100
Subject: [PATCH] Use "up/" prefix for all the upstream branches
To: git@vger.kernel.org
X-TUID: aba1ff8a0c61615e
X-UID: 126
X-Length: 1359
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251547.19208.andyparkins@gmail.com>

To easily differentiate the read-only upstream branches, from normal branches,
default to cloning them with the prefix "up/" added to their branch names.
This also abandons the idea of an "origin" branch which is now simply
"up/master" and hence removes the special treatment that master was getting.
(cherry picked from 33d89375652222c41fbf225f1e1c3bfb38b755b2 commit)
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I'm sure this will be an unwanted patch.  However, I really do think it's 
important to highlight these upstream branches in some way.  I realise 
renaming "origin" is probably not going to fly, but perhaps it would be okay 
to have at least the non-origin branches prefixed?

 git-clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 3f006d1..ebd93da 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -185,7 +185,7 @@ fi
 
 if test -z "$origin"
 then
-	origin=origin
+	origin=up/master
 fi
 
 # Turn the source into an absolute path if
@@ -389,7 +389,7 @@ Pull: refs/heads/$head_points_at:$origin
 			then
 				continue
 			fi
-			echo "Pull: refs/heads/${name}:$remote_top/${name}"
+			echo "Pull: refs/heads/${name}:$remote_top/up/${name}"
 		done >>"$GIT_DIR/remotes/$origin" &&
 		case "$use_separate_remote" in
 		t)
-- 
1.4.2.3

