From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH] Make rev_compare_tree less confusing.
Date: Thu, 15 Apr 2010 01:46:11 -0700
Message-ID: <1271321171-12176-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 10:46:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Ki7-0001jg-1M
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 10:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473Ab0DOIp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 04:45:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51356 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757418Ab0DOIp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 04:45:58 -0400
Received: by pwj9 with SMTP id 9so907405pwj.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+PXvXgHDj0Hs0FzROsLhMCm7m+cWwKLQNBoDVfnr+6I=;
        b=L5tpkYTlyYD6TmaHCPUpoHXFo7LgRYoMbEhrVldel4jG3wiilK035XERBqOeJqH1xt
         glRTykPWKGCwDbXVVWMJWYllMfc8D8KIU/7V7dcCnXP+TzQlPl6vaA0NHFgbkLo5Tqza
         Uh2Fv+KhbRHrReGY3OCTk0rTZ+Xhu8/hPYEyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YWUbfUGDfyHZnKyFzPDVy9AQq95nWgemgKPantpE1D/QpaoeawkkU3Ekt9K3Pr+e9n
         fHPzncZ5/beQCSXDytAR0pEczbmwnorO0jzzFq/leBQEg6n1JIEbxzMsFFGdM3lQEGH5
         dC0Kf0NQRReziMoBI02UK5Zl4r/IAOY2Pivrk=
Received: by 10.115.87.32 with SMTP id p32mr8087924wal.86.1271321157852;
        Thu, 15 Apr 2010 01:45:57 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id 23sm1073289pzk.2.2010.04.15.01.45.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 01:45:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144962>

diff_tree_sha1 always return 0, so comparing the return value
of it make no sense. Just delete the comparison to make code
reader clear.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 revision.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index f4b8b38..8caca99 100644
--- a/revision.c
+++ b/revision.c
@@ -329,9 +329,7 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
-			   &revs->pruning) < 0)
-		return REV_TREE_DIFFERENT;
+	diff_tree_sha1(t1->object.sha1, t2->object.sha1, "", &revs->pruning);
 	return tree_difference;
 }
 
-- 
1.6.0.4
