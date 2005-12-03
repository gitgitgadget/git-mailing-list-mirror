From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 3/4] New test case: merge with directory/file conflicts
Date: Sat, 3 Dec 2005 11:41:20 +0100
Message-ID: <20051203104120.GD4896@c165.ib.student.liu.se>
References: <20051203103255.GA4896@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 11:41:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiUpY-0004Kj-KH
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 11:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVLCKlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 05:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVLCKlV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 05:41:21 -0500
Received: from [85.8.31.11] ([85.8.31.11]:52669 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751239AbVLCKlV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 05:41:21 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 05A924116; Sat,  3 Dec 2005 11:51:11 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EiUpU-0000Kg-00; Sat, 03 Dec 2005 11:41:20 +0100
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20051203103255.GA4896@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13151>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 t/t6020-merge-df.sh |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100755 t/t6020-merge-df.sh

b1d7b5544a3890d2beb19286a328bc2f7e92cb6b
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
new file mode 100755
index 0000000..a19d49d
--- /dev/null
+++ b/t/t6020-merge-df.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Fredrik Kuivinen
+#
+
+test_description='Test merge with directory/file conflicts'
+. ./test-lib.sh
+
+test_expect_success 'prepare repository' \
+'echo "Hello" > init &&
+git add init &&
+git commit -m "Initial commit" &&
+git branch B &&
+mkdir dir &&
+echo "foo" > dir/foo &&
+git add dir/foo &&
+git commit -m "File: dir/foo" &&
+git checkout B &&
+echo "file dir" > dir &&
+git add dir &&
+git commit -m "File: dir"'
+
+test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B master'
+
+test_done
-- 
0.99.9.GIT
