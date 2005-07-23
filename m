From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Test framework: prettyprint the failed command.
Date: Fri, 22 Jul 2005 19:09:34 -0700
Message-ID: <7vek9q6zoh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 04:11:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw9Tl-0008Nc-E9
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 04:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVGWCKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 22:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVGWCKW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 22:10:22 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24783 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262280AbVGWCJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 22:09:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723020934.KKMS1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 22:09:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The output from a failure case had the test description message
and the first line of the actual test script concatenated on the
same line, which was ugly.  Correct the output routine a bit to
make it more readable.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/test-lib.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

ba7b8ae0b3af6040c8af2f4e381bd4c30ab9cd24
diff --git a/t/test-lib.sh b/t/test-lib.sh
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -84,7 +84,9 @@ test_ok_ () {
 test_failure_ () {
 	test_count=$(expr "$test_count" + 1)
 	test_failure=$(expr "$test_failure" + 1);
-	say "FAIL $test_count: $@"
+	say "FAIL $test_count: $1"
+	shift
+	echo "$@" | sed -e 's/^/	/'
 	test "$immediate" == "" || exit 1
 }
 
