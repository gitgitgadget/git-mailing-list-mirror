From: Samuel Tardieu <sam@rfc1149.net>
Subject: [StGit PATCH 2/2] Always resolve "git describe" to something
Date: Thu, 09 Oct 2008 11:02:02 +0200
Message-ID: <20081009090202.12637.2907.stgit@arrakis.enst.fr>
References: <20081009090157.12637.45887.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 11:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnrnI-0004dn-4q
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 11:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYJIJZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753824AbYJIJZl
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 05:25:41 -0400
Received: from revol2.enst.fr ([137.194.2.14]:53097 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579AbYJIJZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 05:25:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id 9A384B834E;
	Thu,  9 Oct 2008 11:02:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id 574B4B82D9;
	Thu,  9 Oct 2008 11:02:02 +0200 (CEST)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 5256720463;
	Thu,  9 Oct 2008 11:02:02 +0200 (CEST)
In-Reply-To: <20081009090157.12637.45887.stgit@arrakis.enst.fr>
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97837>

Sometimes, "git describe" cannot describe the current version. Use
"--always" so that we have a fallback.
---
 stgit/version.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/version.py b/stgit/version.py
index d57053d..05fa8e9 100644
--- a/stgit/version.py
+++ b/stgit/version.py
@@ -8,7 +8,7 @@ class VersionUnavailable(StgException):
 def git_describe_version():
     path = sys.path[0]
     try:
-        v = run.Run('git', 'describe', '--tags', '--abbrev=4'
+        v = run.Run('git', 'describe', '--tags', '--abbrev=4', '--always'
                     ).cwd(path).output_one_line()
     except run.RunException, e:
         raise VersionUnavailable(str(e))
