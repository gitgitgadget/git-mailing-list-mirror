From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 19/21] git p4: avoid shell when invoking git config --get-all
Date: Fri, 28 Sep 2012 08:04:23 -0400
Message-ID: <1348833865-6093-20-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:11:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZPH-0004OU-Of
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602Ab2I1MKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:10:51 -0400
Received: from honk.padd.com ([74.3.171.149]:58385 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab2I1MKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:10:50 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 1EBD35AF2;
	Fri, 28 Sep 2012 05:10:50 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AEEA231413; Fri, 28 Sep 2012 08:10:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206577>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 9c33af4..c0c738a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -525,7 +525,8 @@ def gitConfig(key, args = None): # set args to "--bool", for instance
 
 def gitConfigList(key):
     if not _gitConfig.has_key(key):
-        _gitConfig[key] = read_pipe("git config --get-all %s" % key, ignore_error=True).strip().split(os.linesep)
+        s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
+        _gitConfig[key] = s.strip().split(os.linesep)
     return _gitConfig[key]
 
 def p4BranchesInGit(branchesAreInRemotes = True):
-- 
1.7.12.1.403.g28165e1
