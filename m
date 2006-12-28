From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] t9200-git-cvsexportcommit.sh: quiet down commit
Date: Thu, 28 Dec 2006 01:10:52 -0800
Message-ID: <11672970581666-git-send-email-normalperson@yhbt.net>
References: <11672970521665-git-send-email-normalperson@yhbt.net> <11672970542015-git-send-email-normalperson@yhbt.net> <11672970561224-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:11:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrID-0002Gx-26
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWL1JLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1JLD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:11:03 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43006 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964949AbWL1JLA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:11:00 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 253897DC08E;
	Thu, 28 Dec 2006 01:10:59 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:10:58 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
In-Reply-To: <11672970561224-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35544>

Also, fixed an unportable use of 'export'.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9200-git-cvsexportcommit.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index ca0513b..315119a 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -14,16 +14,18 @@ then
     exit
 fi
 
-export CVSROOT=$(pwd)/cvsroot
-export CVSWORK=$(pwd)/cvswork
+CVSROOT=$(pwd)/cvsroot
+CVSWORK=$(pwd)/cvswork
+GIT_DIR=$(pwd)/.git
+export CVSROOT CVSWORK GIT_DIR
+
 rm -rf "$CVSROOT" "$CVSWORK"
 mkdir "$CVSROOT" &&
 cvs init &&
 cvs -Q co -d "$CVSWORK" . &&
-export GIT_DIR=$(pwd)/.git &&
 echo >empty &&
 git add empty &&
-git commit -a -m "Initial" 2>/dev/null ||
+git commit -q -a -m "Initial" 2>/dev/null ||
 exit 1
 
 test_expect_success \
-- 
1.4.4.3.gd4ada
