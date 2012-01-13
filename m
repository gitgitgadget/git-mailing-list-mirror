From: mhagger@alum.mit.edu
Subject: [PATCH v2 1/2] git-show-ref: fix escaping in asciidoc source
Date: Fri, 13 Jan 2012 17:39:15 +0100
Message-ID: <1326472756-15227-2-git-send-email-mhagger@alum.mit.edu>
References: <1326472756-15227-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 17:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlkA7-00016T-5W
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 17:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474Ab2AMQj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 11:39:28 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:45602 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2AMQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 11:39:24 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1Rlk04-0007wV-U4; Fri, 13 Jan 2012 17:29:08 +0100
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326472756-15227-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188517>

From: Michael Haggerty <mhagger@alum.mit.edu>

Two "^" characters were incorrectly being interpreted as markup for
superscripting.  Fix them by writing them as attribute references
"{caret}".

Although a single "^" character in a paragraph cannot be
misinterpreted in this way, also write other "^" characters as
"{caret}" in the interest of good hygiene (unless they are in literal
paragraphs, of course, in which context attribute references are not
recognized).

Spell "{}" consistently, namely *not* quoted as "\{\}".  Since the
braces are empty, they cannot be interpreted as an attribute
reference, and either spelling is OK.  So arbitrarily choose one
variation and use it consistently.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-show-ref.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 3c45895..8dfcbe3 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -44,7 +44,7 @@ OPTIONS
 -d::
 --dereference::
 
-	Dereference tags into object IDs as well. They will be shown with "^{}"
+	Dereference tags into object IDs as well. They will be shown with "{caret}{}"
 	appended.
 
 -s::
@@ -73,9 +73,9 @@ OPTIONS
 --exclude-existing[=<pattern>]::
 
 	Make 'git show-ref' act as a filter that reads refs from stdin of the
-	form "^(?:<anything>\s)?<refname>(?:{backslash}{caret}\{\})?$"
+	form "{caret}(?:<anything>\s)?<refname>(?:{backslash}{caret}{})?$"
 	and performs the following actions on each:
-	(1) strip "^{}" at the end of line if any;
+	(1) strip "{caret}{}" at the end of line if any;
 	(2) ignore if pattern is provided and does not head-match refname;
 	(3) warn if refname is not a well-formed refname and skip;
 	(4) ignore if refname is a ref that exists in the local repository;
-- 
1.7.8.3
