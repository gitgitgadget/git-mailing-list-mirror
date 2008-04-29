From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 2/2] Add t7506 to test submodule related functions for git-status
Date: Wed, 30 Apr 2008 00:07:20 +0800
Message-ID: <1209485240-9003-3-git-send-email-pkufranky@gmail.com>
References: <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
 <1209485240-9003-1-git-send-email-pkufranky@gmail.com>
 <1209485240-9003-2-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 29 18:08:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqsNO-0005bR-Sd
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765509AbYD2QH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765406AbYD2QH1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:07:27 -0400
Received: from mail.qikoo.org ([60.28.205.235]:51646 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764776AbYD2QH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:07:26 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 2E696470AF; Wed, 30 Apr 2008 00:07:20 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.96.gef4a.dirty
In-Reply-To: <1209485240-9003-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80696>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 t/t7506-status-submodule.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t7506-status-submodule.sh

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
new file mode 100755
index 0000000..a75130c
--- /dev/null
+++ b/t/t7506-status-submodule.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git-status for submodule'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_create_repo sub
+	cd sub &&
+	: >bar &&
+	git add bar &&
+	git commit -m " Add bar" &&
+	cd .. &&
+	git add sub &&
+	git commit -m "Add submodule sub"
+'
+
+test_expect_success 'status clean' '
+	git status |
+	grep "nothing to commit"
+'
+test_expect_success 'status -a clean' '
+	git status -a |
+	grep "nothing to commit"
+'
+test_expect_success 'rm submodule contents' '
+	rm -rf sub/* sub/.git
+'
+test_expect_success 'status clean (empty submodule dir)' '
+	git status |
+	grep "nothing to commit"
+'
+test_expect_success 'status -a clean (empty submodule dir)' '
+	git status -a |
+	grep "nothing to commit"
+'
+
+test_done
-- 
1.5.5.1.96.gef4a.dirty
