From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/6] git-merge: fix faulty SQUASH_MSG
Date: Mon, 24 Sep 2007 00:51:41 +0200
Message-ID: <1190587905-700-3-git-send-email-hjemli@gmail.com>
References: <1190587905-700-1-git-send-email-hjemli@gmail.com>
 <1190587905-700-2-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaIP-000243-M1
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbXIWWvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbXIWWvQ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:51:16 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:42774 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbXIWWvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:51:15 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8NMp91N023085;
	Mon, 24 Sep 2007 00:51:10 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190587905-700-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58992>

Only the first 'remote' head is currently specified as an argument to 'git
log' when generating a SQUSH_MSG, which makes the generated message fail
to mention every commit involved in the merge. This fixes the problem.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..3857634 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -59,7 +59,7 @@ finish_up_to_date () {
 squash_message () {
 	echo Squashed commit of the following:
 	echo
-	git log --no-merges ^"$head" $remote
+	git log --no-merges ^"$head" $remoteheads
 }
 
 finish () {
-- 
1.5.3.2.82.g75c8d
