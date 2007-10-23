From: Adam Roben <aroben@apple.com>
Subject: [PATCH 6/9] Add tests for git hash-object
Date: Mon, 22 Oct 2007 22:46:34 -0700
Message-ID: <1193118397-4696-7-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
 <1193118397-4696-3-git-send-email-aroben@apple.com>
 <1193118397-4696-4-git-send-email-aroben@apple.com>
 <1193118397-4696-5-git-send-email-aroben@apple.com>
 <1193118397-4696-6-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCci-0007YT-Qm
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbXJWFrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbXJWFrY
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:24 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:57268 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 91F8E16874AE;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 6ED3D28086;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a7e5ebb000000c52-61-471d8adfe7f9
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 572702804D;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-6-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62102>


Signed-off-by: Adam Roben <aroben@apple.com>
---
 t/t1006-hash-object.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 t/t1006-hash-object.sh

diff --git a/t/t1006-hash-object.sh b/t/t1006-hash-object.sh
new file mode 100755
index 0000000..77b8eca
--- /dev/null
+++ b/t/t1006-hash-object.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='git hash-object'
+
+. ./test-lib.sh
+
+hello_content="Hello World"
+hello_sha1=557db03de997c86a4a028e1ebd3a1ceb225be238
+echo "$hello_content" > hello
+
+test_expect_success \
+    'hash a file' \
+    "test $hello_sha1 = $(git hash-object hello)"
+
+test_expect_success \
+    'hash from stdin' \
+    "test $hello_sha1 = $(echo "$hello_content" | git hash-object --stdin)"
+
+test_expect_success \
+    'hash a file and write to database' \
+    "test $hello_sha1 = $(git hash-object -w hello)"
+
+test_expect_success \
+    'hash from stdin and write to database' \
+    "test $hello_sha1 = $(echo "$hello_content" | git hash-object -w --stdin)"
+
+test_done
-- 
1.5.3.4.1333.ga2f32
