From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/4] test-lib.sh: Add new function, test_expect_code
Date: Sat, 3 Dec 2005 11:40:39 +0100
Message-ID: <20051203104039.GC4896@c165.ib.student.liu.se>
References: <20051203103255.GA4896@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 11:41:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiUp0-0004Ef-De
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 11:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVLCKkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 05:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVLCKkk
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 05:40:40 -0500
Received: from [85.8.31.11] ([85.8.31.11]:52413 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751234AbVLCKkj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 05:40:39 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id BC2984116; Sat,  3 Dec 2005 11:50:29 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EiUop-0000KS-00; Sat, 03 Dec 2005 11:40:39 +0100
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20051203103255.GA4896@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13152>

The test is considered OK if it exits with code $1

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 t/test-lib.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

12ea56dda039b8b2fed61459a7a2df5ebf3dfde2
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e654155..f2eccd7 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -133,6 +133,19 @@ test_expect_success () {
 	fi
 }
 
+test_expect_code () {
+	test "$#" = 3 ||
+	error "bug in the test script: not 3 parameters to test-expect-code"
+	say >&3 "expecting exit code $1: $3"
+	test_run_ "$3"
+	if [ "$?" = 0 -a "$eval_ret" = "$1" ]
+	then
+		test_ok_ "$2"
+	else
+		test_failure_ "$@"
+	fi
+}
+
 test_done () {
 	trap - exit
 	case "$test_failure" in
-- 
0.99.9.GIT
