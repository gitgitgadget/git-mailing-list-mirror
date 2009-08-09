From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] tests: use "$TEST_DIRECTORY" instead of ".."
Date: Sun, 9 Aug 2009 04:37:52 -0400
Message-ID: <20090809083752.GA8250@coredump.intra.peff.net>
References: <20090809083518.GA8147@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 10:38:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma3uj-00068Z-TX
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 10:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbZHIIhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 04:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbZHIIhy
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 04:37:54 -0400
Received: from peff.net ([208.65.91.99]:32948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbZHIIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 04:37:53 -0400
Received: (qmail 2733 invoked by uid 107); 9 Aug 2009 08:40:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 04:40:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 04:37:52 -0400
Content-Disposition: inline
In-Reply-To: <20090809083518.GA8147@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125330>

The $TEST_DIRECTORY variable allows tests to find the
top-level test directory regardless of the current working
directory.

In the past, this has been used to accomodate tests which
change directories, but it is also the first step to being
able to move trash directories outside of the
$TEST_DIRECTORY hierarchy.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3404-rebase-interactive.sh            |    2 +-
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 t/t3414-rebase-preserve-onto.sh          |    2 +-
 t/t4020-diff-external.sh                 |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a973628..4cae019 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -10,7 +10,7 @@ that the result still makes sense.
 '
 . ./test-lib.sh
 
-. ../lib-rebase.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 set_fake_editor
 
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 6533505..14a23cd 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -10,7 +10,7 @@ a merge to before the merge.
 '
 . ./test-lib.sh
 
-. ../lib-rebase.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 set_fake_editor
 
diff --git a/t/t3414-rebase-preserve-onto.sh b/t/t3414-rebase-preserve-onto.sh
index 80019ee..ee0a6cc 100755
--- a/t/t3414-rebase-preserve-onto.sh
+++ b/t/t3414-rebase-preserve-onto.sh
@@ -10,7 +10,7 @@ aren'"'"'t on top of $ONTO, even if they are on top of $UPSTREAM.
 '
 . ./test-lib.sh
 
-. ../lib-rebase.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 # Set up branches like this:
 # A1---B1---E1---F1---G1
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 4ea42e0..a7602cf 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -166,7 +166,7 @@ test_expect_success 'diff --cached' '
 	git update-index --assume-unchanged file &&
 	echo second >file &&
 	git diff --cached >actual &&
-	test_cmp ../t4020/diff.NUL actual
+	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
 '
 
 test_done
-- 
1.6.4.178.g7a987
