From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 19/21] git p4: avoid shell when invoking git config --get-all
Date: Sat, 26 Jan 2013 22:11:22 -0500
Message-ID: <1359256284-5660-20-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:18:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIl0-0007D9-8j
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3A0DRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:17:49 -0500
Received: from honk.padd.com ([74.3.171.149]:44482 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755551Ab3A0DRs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:17:48 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 126462F3F;
	Sat, 26 Jan 2013 19:17:48 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1064D22838; Sat, 26 Jan 2013 22:17:45 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214670>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index c8ae83d..7efa9a8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -571,7 +571,8 @@ def gitConfig(key, args = None): # set args to "--bool", for instance
 
 def gitConfigList(key):
     if not _gitConfig.has_key(key):
-        _gitConfig[key] = read_pipe("git config --get-all %s" % key, ignore_error=True).strip().split(os.linesep)
+        s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
+        _gitConfig[key] = s.strip().split(os.linesep)
     return _gitConfig[key]
 
 def p4BranchesInGit(branchesAreInRemotes=True):
-- 
1.8.1.1.460.g6fa8886
