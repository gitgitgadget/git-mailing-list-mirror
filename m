From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 04/21] git p4: fix error message when "describe -s" fails
Date: Fri, 28 Sep 2012 08:04:08 -0400
Message-ID: <1348833865-6093-5-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:05:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZKQ-0001VV-M8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2I1MFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:05:49 -0400
Received: from honk.padd.com ([74.3.171.149]:34959 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab2I1MFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:05:49 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id BDA4F5AF2;
	Fri, 28 Sep 2012 05:05:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5714A31413; Fri, 28 Sep 2012 08:05:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206561>

The output was a bit nonsensical, including a bare %d.  Fix it
to make it easier to understand.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index eef5c94..d7ee4b4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2679,7 +2679,8 @@ class P4Sync(Command, P4UserMap):
             if r.has_key('time'):
                 newestTime = int(r['time'])
         if newestTime is None:
-            die("\"describe -s\" on newest change %d did not give a time")
+            die("Output from \"describe -s\" on newest change %d did not give a time" %
+                newestRevision)
         details["time"] = newestTime
 
         self.updateOptionDict(details)
-- 
1.7.12.1.403.g28165e1
