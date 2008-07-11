From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] setup.py: fix error message when running with python-2.3
Date: Fri, 11 Jul 2008 22:09:31 +0200
Message-ID: <1215806972-18713-1-git-send-email-vmiklos@frugalware.org>
References: <20080711200735.GK10347@genesis.frugalware.org>
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOwb-0000ey-6M
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 22:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYGKUJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 16:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934AbYGKUJR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 16:09:17 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33546 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbYGKUJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 16:09:16 -0400
Received: from vmobile.example.net (dsl5401CCAB.pool.t-online.hu [84.1.204.171])
	by yugo.frugalware.org (Postfix) with ESMTP id 9452C1DDC5B;
	Fri, 11 Jul 2008 22:09:14 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B0BFC1A9833; Fri, 11 Jul 2008 22:09:32 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <20080711200735.GK10347@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88167>

When setup.py tries to check the python version, the check actually
won't give a usable error message but it'll raise a SyntaxError. Fix
this by not using generator expressions.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 setup.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.py b/setup.py
index 8d8f7a8..44cc6ea 100755
--- a/setup.py
+++ b/setup.py
@@ -28,7 +28,7 @@ def __check_min_version(min_ver, ver):
 def __check_python_version():
     """Check the minimum Python version
     """
-    pyver = '.'.join(str(n) for n in sys.version_info)
+    pyver = '.'.join(map(lambda x: str(x), sys.version_info))
     if not __check_min_version(version.python_min_ver, pyver):
         print >> sys.stderr, 'Python version %s or newer required. Found %s' \
               % (version.python_min_ver, pyver)
-- 
1.5.6.2.450.g8d367.dirty
