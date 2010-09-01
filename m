From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] install-webdoc: quell diff output on stdout
Date: Wed,  1 Sep 2010 17:10:21 +0200
Message-ID: <2730e927194a15f708ea4c5ffa72353f793f2ed4.1283353628.git.git@drmicha.warpmail.net>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 17:12:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqozP-0006Cq-Tm
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 17:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab0IAPKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 11:10:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38961 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755529Ab0IAPKT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 11:10:19 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1488B3E9;
	Wed,  1 Sep 2010 11:10:19 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 01 Sep 2010 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=so6cfbcpYgW8fewZSroJ89EsKz8=; b=NpSp+CKGzvUwzGaNdfTP+fcpQ2lu/NoIZFF8yLAmwgfETyccaYk/oP8k4s5CYbdqHvhG1ahbJhgsPsbZMHZaKpKIUV8EsDBSYsQkLC7eOGoZrI/okA477+1FQoxUGfO5nTEWPANDr7q+xQHVVWgg2SsHetv+jfW3yKqFLmP/wOA=
X-Sasl-enc: I7qxVqL9/VBR7aJTsTZNksKw6fkbqOIYfmTQ87kaK2Gd 1283353818
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8671B5E5D6B;
	Wed,  1 Sep 2010 11:10:18 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.2.540.g9d56f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155050>

When installing html-doc, install-webdoc.sh compares the installed html
with the version to be installed using diff. Currently, the diff output
fills up stdout.

Redirect this to /dev/null so that the actual progress report can be
spotted again. (Note that install-webdoc.sh actually uses $DIFF so that
redirecting stdout is safer than using an option which $DIFF may or may
not understand.)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/install-webdoc.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index 34d02a2..43c09d2 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -12,7 +12,7 @@ do
 	then
 		: did not match
 	elif test -f "$T/$h" &&
-	   $DIFF -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
+	   $DIFF -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h" >/dev/null
 	then
 		:; # up to date
 	else
-- 
1.7.2.2.540.g9d56f.dirty
