From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Extend t3404-rebase-interactive.sh test: "no changes are a
 nop"
Date: Sat, 24 May 2008 01:13:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0805240101530.3980@euler.pkqs.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 01:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzgSh-0006kj-JF
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 01:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbYEWXNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbYEWXNX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 19:13:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:56795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753658AbYEWXNW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 19:13:22 -0400
Received: (qmail invoked by alias); 23 May 2008 23:13:19 -0000
Received: from pkqs.net (EHLO euler.pkqs.net) [213.239.210.122]
  by mail.gmx.net (mp041) with SMTP; 24 May 2008 01:13:19 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19flUsW+mtfrYLKIIUeudC60t3Cx8s+3DtlHrCmsN
	q3amVmS49omS9X
X-X-Sender: sbeyer@euler.pkqs.net
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82771>

Now the test "no changes are a nop" checks additionally, 
that HEAD is commit I and a symbolic ref for branch2.

The new test fails on a situation like this, for example:
$ git branch -v
* (no branch) cac536e I
   branch1     1599c04 H
   branch2     cac536e I
   master      cb54291 E

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
  t/t3404-rebase-interactive.sh |    4 +++-
  1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b9e3dbd..623d784 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -96,7 +96,9 @@ chmod a+x fake-editor.sh

  test_expect_success 'no changes are a nop' '
  	git rebase -i F &&
-	test $(git rev-parse I) = $(git rev-parse HEAD)
+	test $(git rev-parse I) = $(git rev-parse HEAD) &&
+	test $(git rev-parse I) = $(git rev-parse branch2) &&
+	git symbolic-ref HEAD
  '

  test_expect_success 'test the [branch] option' '
-- 
1.5.5.1
