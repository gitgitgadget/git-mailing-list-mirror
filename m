From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 00:21:37 +0100
Message-ID: <1221607297-33212-1-git-send-email-jon.delStrother@bestbefore.tv>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 01:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfjze-0000qS-Da
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYIPX2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbYIPX2z
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:28:55 -0400
Received: from cumberland.bestbefore.tv ([82.165.41.205]:44499 "EHLO
	cumberland.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYIPX2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:28:54 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2008 19:28:53 EDT
Received: (qmail 1958 invoked from network); 17 Sep 2008 00:22:11 +0100
Received: from 87.112.14.64.plusnet.ptn-ag1.dyn.plus.net (HELO localhost.localdomain) (87.112.14.64)
  by cumberland.bestbefore.tv with SMTP; 17 Sep 2008 00:22:11 +0100
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96046>

Add support for recognition of Objective-C class & instance methods, C functions, and class implementation/interfaces.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
 Documentation/gitattributes.txt |    2 ++
 diff.c                          |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 6f3551d..c1f13e2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -315,6 +315,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `objc` suitable for source code in the Objective-C language.
+
 - `pascal` suitable for source code in the Pascal/Delphi language.
 
 - `php` suitable for source code in the PHP language.
diff --git a/diff.c b/diff.c
index 998dcaa..6ed8322 100644
--- a/diff.c
+++ b/diff.c
@@ -1403,6 +1403,12 @@ static struct builtin_funcname_pattern {
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*\\)$" },
+	{ "objc", "^[\t ]*\\([-+][\t ]*([\t ]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$"      // Objective-C methods
+			"\\|"
+			"^[\t ]*\\(\\([\t ]*[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}[\t ]*([^;]*\\)$" // C functions
+			"\\|"
+			"^@\\(implementation\\|interface\\|protocol\\).*"   // Objective-C class/protocol definitions
+			},
 	{ "pascal", "^\\(\\(procedure\\|function\\|constructor\\|"
 			"destructor\\|interface\\|implementation\\|"
 			"initialization\\|finalization\\)[ \t]*.*\\)$"
-- 
1.6.0.2
