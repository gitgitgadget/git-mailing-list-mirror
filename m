X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/6] git-fetch can use both --thin and --keep with fetch-pack
 now
Date: Wed, 01 Nov 2006 17:06:22 -0500
Message-ID: <1162418786895-git-send-email-nico@cam.org>
References: <11624187853116-git-send-email-nico@cam.org>
 <11624187853865-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Nov 2006 22:06:39 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <11624187853865-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.4.3.3.g87b2-dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30663>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOEC-0005XC-Jq for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752512AbWKAWGa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbWKAWG3
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:06:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63137 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752512AbWKAWG1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:06:27 -0500
Received: from localhost.localdomain ([74.56.106.175]) by
 VL-MH-MR002.ip.videotron.ca (Sun Java System Messaging Server 6.2-2.05 (built
 Apr 28 2005)) with ESMTP id <0J8200BN9O2PMF20@VL-MH-MR002.ip.videotron.ca>
 for git@vger.kernel.org; Wed, 01 Nov 2006 17:06:26 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 git-fetch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 539dff6..2b5538f 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -20,7 +20,7 @@ verbose=
 update_head_ok=
 exec=
 upload_pack=
-keep=--thin
+keep=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -370,7 +370,7 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
-	  git-fetch-pack $exec $keep "$remote" $rref || echo failed "$remote"
+	  git-fetch-pack --thin $exec $keep "$remote" $rref || echo failed "$remote"
       ) |
       while read sha1 remote_name
       do
-- 
1.4.3.3.g87b2-dirty
