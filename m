From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 4/4] Teach GIT-VERSION-GEN about the .git file
Date: Wed, 20 Feb 2008 23:13:16 +0100
Message-ID: <1203545596-6337-5-git-send-email-hjemli@gmail.com>
References: <1203545596-6337-1-git-send-email-hjemli@gmail.com>
 <1203545596-6337-2-git-send-email-hjemli@gmail.com>
 <1203545596-6337-3-git-send-email-hjemli@gmail.com>
 <1203545596-6337-4-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:16:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxF3-0006aQ-K3
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbYBTWPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbYBTWPu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:15:50 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:47371 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbYBTWPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:15:49 -0500
Received: from localhost.localdomain (ti231210a341-0590.bb.online.no [88.88.170.78])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m1KMEQAM024249;
	Wed, 20 Feb 2008 23:14:29 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
In-Reply-To: <1203545596-6337-4-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74552>

The presence of a .git directory used to be good enough evidence that
GIT-VERSION-GEN could use 'git describe' to get a version number. But
now .git might as well be a file so the test must be extended to cater for
such setups.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 1ad324e..10fe488 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -11,7 +11,7 @@ LF='
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d .git &&
+elif test -d .git -o -f .git &&
 	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
-- 
1.5.4.1.188.g3ea1f5
