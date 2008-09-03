From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: [PATCH 2/2] Added test for log`s new '%d' format specifier
Date: Wed, 3 Sep 2008 20:42:07 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809032040150.32295@pollux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Wed Sep 03 20:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaxK3-0004i5-68
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYICSmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbYICSmO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:42:14 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:44634 "EHLO
	mailout05.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYICSmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:42:13 -0400
Received: from fwd26.aul.t-online.de 
	by mailout05.sul.t-online.de with smtp 
	id 1KaxIx-0001Zt-01; Wed, 03 Sep 2008 20:42:11 +0200
Received: from [192.168.2.100] (bKbO7YZGwhUOvz52ZdIGd1xbARNFBT7axtNbXYPKi3Mfvi0AgazkoQV38WBKluvZo8@[84.163.231.184]) by fwd26.t-online.de
	with esmtp id 1KaxIp-1s7JRY0; Wed, 3 Sep 2008 20:42:03 +0200
X-X-Sender: michael@pollux
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: bKbO7YZGwhUOvz52ZdIGd1xbARNFBT7axtNbXYPKi3Mfvi0AgazkoQV38WBKluvZo8
X-TOI-MSGID: 34292a89-bded-4658-9346-d89855ea42da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94835>



Signed-off-by: Michael Dressel <MichaelTiloDressel@t-online.de>
---
  t/t4203-log.sh |   41 +++++++++++++++++++++++++++++++++++++++++
  1 files changed, 41 insertions(+), 0 deletions(-)
  create mode 100755 t/t4203-log.sh

diff --git a/t/t4203-log.sh b/t/t4203-log.sh
new file mode 100755
index 0000000..ef13927
--- /dev/null
+++ b/t/t4203-log.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='git log --pretty=format:%h%d'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo one >one &&
+	git add one &&
+	test_tick &&
+	git commit -m initial &&
+	git tag -a V1 -m "v1" &&
+
+	echo ichi >one &&
+	git add one &&
+	test_tick &&
+	git commit -m second &&
+	git tag l2 &&
+
+	echo bichi >one &&
+	git add one &&
+	test_tick &&
+	git commit -m third &&
+	git tag l3 &&
+	git tag -a V3 -m "v3"
+
+'
+
+test_expect_success 'find decoration' '
+
+	git log --pretty="format:%h %d" | grep V1 &&
+	git log --pretty="format:%h %d" | grep V3 &&
+	git log --pretty="format:%h %d" | grep l2 &&
+	git log --pretty="format:%h %d" | grep l3
+
+
+'
+
+test_done
+
-- 
1.6.0.1
