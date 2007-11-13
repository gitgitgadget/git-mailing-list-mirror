From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 02/11] t7501-commit.sh: Not all seds understand option -i
Date: Tue, 13 Nov 2007 21:04:57 +0100
Message-ID: <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21A-0001Be-4V
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762509AbXKMUFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761709AbXKMUFK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:10 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49190 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762240AbXKMUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:09 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 9CB7210AAEB;
	Tue, 13 Nov 2007 21:05:07 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64849>

Use mv instead.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t7501-commit.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 4dc35bd..38db2f2 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -69,7 +69,8 @@ test_expect_success \
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -i -e "s/a file/an amend commit/g" $1
+sed -e "s/a file/an amend commit/g" < $1 > $1-
+mv $1- $1
 EOF
 chmod 755 editor
 
@@ -88,7 +89,8 @@ test_expect_success \
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -i -e "s/amend/older/g" $1
+sed -e "s/amend/older/g"  < $1 > $1-
+mv $1- $1
 EOF
 chmod 755 editor
 
-- 
1.5.3.5.1592.g0d6db
