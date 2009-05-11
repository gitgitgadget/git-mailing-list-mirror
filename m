From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH 6/6] Add 'make test-text'
Date: Mon, 11 May 2009 15:29:01 -0400
Message-ID: <1242070141-2936-7-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-2-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-3-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-4-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-5-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242070141-2936-6-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:30:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bCJ-0007Nk-GK
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758689AbZEKT33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbZEKT3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:29:25 -0400
Received: from krl.krl.com ([192.147.32.3]:46858 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758332AbZEKT3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:29:16 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BJTEor003014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 May 2009 15:29:14 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BJTET1003013;
	Mon, 11 May 2009 15:29:14 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242070141-2936-6-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118833>

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 Makefile |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6e21643..03176a4 100644
--- a/Makefile
+++ b/Makefile
@@ -1482,6 +1482,16 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
+test-text: all
+ifeq ($(uname_O),Cygwin)
+	@echo Test text mode mount
+	mount -f -u -t $(shell sh -c 'cygpath -m -a t') $(shell sh -c 'cygpath -u -a t')
+	$(MAKE) -C t/ all
+	umount -u $(shell sh -c 'cygpath -u -a t')
+else
+	GIT_TEST_AUTO_CRLF=$${GIT_TEST_AUTO_CRLF:-true} $(MAKE) -C t/ all
+endif
+
 test-ctype$X: ctype.o
 
 test-date$X: date.o ctype.o
-- 
1.6.3.15.g49878
