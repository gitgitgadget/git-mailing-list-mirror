From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 2/4] Add t7506 to test submodule related functions for git-status
Date: Fri,  2 May 2008 21:35:34 +0800
Message-ID: <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 15:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvRa-0003lU-M2
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935129AbYEBNfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935135AbYEBNfk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:35:40 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57897 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S935124AbYEBNfj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:35:39 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id A44E6470B0; Fri,  2 May 2008 21:35:36 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.116.ge4b9c.dirty
In-Reply-To: <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80993>

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
1.5.5.1.116.ge4b9c.dirty
