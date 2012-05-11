From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 3/3] git p4: fix bug when enabling tag import/export via config variables
Date: Fri, 11 May 2012 07:25:18 +0100
Message-ID: <1336717518-4214-4-git-send-email-luke@diamand.org>
References: <1336717518-4214-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 08:25:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSjIL-0004Zl-IK
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 08:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab2EKGZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 02:25:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53161 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab2EKGZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 02:25:26 -0400
Received: by wgbdr13 with SMTP id dr13so2162320wgb.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 23:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=WqfWVAut6hvJJRiEbUEf9vJmOhTx9WC/gssEbLKetuY=;
        b=gaLsa0hgHSXCprt0gKN5/0RCbaN1WMbowOniwoSuCASX63/FSiCssRmCFBxpkH0gHx
         cXcquKj6zRX667j5uJc650sTIEs5um/O5w642P/IQ0qz1b6LQTHCCbWf05kVX4Qkhcbk
         UZ8kc7DknfZZdcBxzX7k5HW20UiF0pG8gZXrDdzYzvSa7BpsnWbt8yQuDWNPFuGjE6n0
         AQeumfYUfh+Q/078SqVWwqaaFC8kRfPhgG7/O8zeGkzVjmYn5pq2XPSoPlxOgtv0inoD
         t0RdgDGO3U1jLhUIr+IchXYDU7aI0UylDjfM/E8m/zbG6ZEqQomMFEmhSg9NtdbPKjtx
         2Yug==
Received: by 10.216.136.72 with SMTP id v50mr670004wei.73.1336717525316;
        Thu, 10 May 2012 23:25:25 -0700 (PDT)
Received: from halilbut.local.diamand.org (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id h8sm13801629wix.4.2012.05.10.23.25.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 23:25:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.221.g3bf1d
In-Reply-To: <1336717518-4214-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQldqRkWo/DR89395QClb4p5siELTCMhjWl35W9bzr5iLE+q8+y2E8Lvyv3Qbqr5/wxyiKq5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197659>

Use Python's True, not true. Causes failure when enabling tag
import or export in "git p4" using a config option rather than
the command line.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8f0169a..f895a24 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1451,7 +1451,7 @@ class P4Submit(Command, P4UserMap):
             rebase.rebase()
 
         if gitConfig("git-p4.exportLabels", "--bool") == "true":
-            self.exportLabels = true
+            self.exportLabels = True
 
         if self.exportLabels:
             p4Labels = getP4Labels(self.depotPath)
@@ -2711,7 +2711,7 @@ class P4Sync(Command, P4UserMap):
                         sys.stdout.write("\n")
 
         if gitConfig("git-p4.importLabels", "--bool") == "true":
-            self.importLabels = true
+            self.importLabels = True
 
         if self.importLabels:
             p4Labels = getP4Labels(self.depotPaths)
-- 
1.7.10.282.g2120.dirty
