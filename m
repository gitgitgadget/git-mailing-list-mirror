From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/3] Revert changes and extend diff option documentation
Date: Fri, 14 Dec 2007 12:23:42 +0100
Message-ID: <1197631424-52586-2-git-send-email-win@wincent.com>
References: <1197631424-52586-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38ey-0002kz-C8
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520AbXLNLYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 06:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbXLNLYM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 06:24:12 -0500
Received: from wincent.com ([72.3.236.74]:50226 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbXLNLYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 06:24:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBEBNkhX018244;
	Fri, 14 Dec 2007 05:23:48 -0600
X-Mailer: git-send-email 1.5.4.rc0.1099.g76fa0-dirty
In-Reply-To: <1197631424-52586-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68296>

Revert the part of 62c6489 which says that --check affects
the exit code of "git diff"; as of da31b35 this is only true
if you pass --exit-code as well or disable the pager with
--no-pager or GIT_PAGER=cat.

Instead extend the discussion of the --exit-code switch.

Also, instead of hard-coding "what whitespace errors are",
mention that their classification can be controlled via
config and per-path attributes.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/diff-options.txt |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9ecc1d7..54207f0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -92,10 +92,10 @@ endif::git-format-patch[]
 	file gives the default to do so.
 
 --check::
-	Warn if changes introduce trailing whitespace
-	or an indent that uses a space before a tab. Exits with
-	non-zero status if problems are found. Not compatible with
-	--exit-code.
+	Warn if changes introduce whitespace problems (such as
+	trailing whitespace). Configuration and per-path attributes
+	control what git classifies as a whitespace problem (see
+	gitlink:git-config[1] and gitlink:gitattributes[5]).
 
 --full-index::
 	Instead of the first handful characters, show full
@@ -197,8 +197,9 @@ endif::git-format-patch[]
 
 --exit-code::
 	Make the program exit with codes similar to diff(1).
-	That is, it exits with 1 if there were differences and
-	0 means no differences.
+	That is, it exits with 0 if there were no differences
+	and 1 if there were. If --check is used and the
+	differences introduce whitespace problems exits with 3.
 
 --quiet::
 	Disable all output of the program. Implies --exit-code.
-- 
1.5.4.rc0.1099.g76fa0-dirty
