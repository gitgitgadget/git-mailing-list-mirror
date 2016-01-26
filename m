From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 18/19] mingw: handle the missing POSIXPERM prereq in
 t9124
Date: Tue, 26 Jan 2016 15:35:38 +0100 (CET)
Message-ID: <4c38596ae3fdcc5906dba49521084fe2b1a6888d.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:36:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4j5-000593-5V
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966213AbcAZOgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:36:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:53018 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966101AbcAZOfm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:42 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M9fLX-1aFamy1oIJ-00D2fk; Tue, 26 Jan 2016 15:35:39
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:AIeoyuXdumIMZTJEpJDJyjhCh3+FdYsIcg5ds0PRPH6m48FxPDV
 8dLu+akzBHXycP33Lrqh7BvhIhjA4PrLrAKzBzd4H0nK5FpWPB5nssBx+i2z7KgY4I9pptB
 mSn3S4CMZWVryQ8Je3arR9zvcksDiealzv5WGYNgKMs+gY3yfRQ6FgIgp7AhHq4c8SRbonB
 BMMhtNvCx4c69NkhvJp7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kDQSAHvI2lw=:EjGlPXg1F007/nbMXOh3zx
 PIi9fXZubC3JKaExi7umRYJ+N+MIXHiC5fiVk+ALZyuHkLVqOJ2BrieGX+GT47zl71CpTRPkK
 J7DzTs8Mz7N/QREKs89Zt4O1aJlRaSUmKTPZcrwJJKyg7cnrA9FroIRopEG4sno1dKuUqD8Yr
 ABRAs9pmOlCun0UDdUNkEbtWTPILdH4xujK+QX2UIkiepttlz0TaTkG8SQshbzF7Wgtzu0oX3
 vHaM3cdZcd5aqfrSC9H1F8j4hwp7tKoXkkbvBXNyQqaP7xRg/j86bChJfGUdBpUwCZSoj/nsY
 LPLEzzOnjL66I6R4wI/efejmBQSC3NKrByIF9ls4MqHUMy5T9tm6YICr8Nr0kw6O9OUdRjPNq
 wsSbhndodPlQV8Iik1QgSuG5AAEFnUU6WfE/KnxwXcDWE6NASpiwvF24WwUgwHnPC0vEYY9zK
 /m9jLNqFuPDTikZ7bFCtKun0WkVj7PAfSwjsplvf5Vt3/3gZlikPUShEJu5Ew9IYdQBTNYSus
 y1M1W9z639Aey7/wuuHOfPHqHbfvXtIyB4MiE5KTLjXdpSiP0WDc2YYh9dNH/hAJJ87FMI7D7
 Ij93nRI3mWdxPktlgRGXfNeAR7+I/0bA8qw3xzGy3Z2ySaCzWDBzCJkRnWB7wkz7K+NDWFyBz
 i7dNVeR+BCccVYUfH8UIH6AhH4bgKszgv/ItB6JrVDadKCVN1wEGcI5cMxqZQcO0ZAaefgKKV
 D1wCIhBX6UYfytr5pquyBPadLDVJrOQNgR6Ah/dPgOWRCETf/ff9RziB13C7gfxXFddqKwnQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284831>

On Windows, the permission system works completely differently than
expected by some of the tests. So let's make sure that we do not test
POSIX functionality on Windows.

This lets t9124-git-svn-dcommit-auto-props.sh pass in Git for Windows'
SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9124-git-svn-dcommit-auto-props.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
index aa841e1..2be0805 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -34,8 +34,7 @@ test_expect_success 'enable auto-props config' '
 '
 
 test_expect_success 'add files matching auto-props' '
-	echo "#!$SHELL_PATH" >exec1.sh &&
-	chmod +x exec1.sh &&
+	printf "" | write_script exec1.sh &&
 	echo "hello" >hello.txt &&
 	echo bar >bar &&
 	git add exec1.sh hello.txt bar &&
@@ -48,8 +47,7 @@ test_expect_success 'disable auto-props config' '
 '
 
 test_expect_success 'add files matching disabled auto-props' '
-	echo "#$SHELL_PATH" >exec2.sh &&
-	chmod +x exec2.sh &&
+	printf "" | write_script exec2.sh &&
 	echo "world" >world.txt &&
 	echo zot >zot &&
 	git add exec2.sh world.txt zot &&
@@ -65,7 +63,10 @@ test_expect_success 'check resulting svn repository' '
 	cd svnrepo &&
 
 	# Check properties from first commit.
-	test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*" &&
+	if test_have_prereq POSIXPERM
+	then
+		test -z "$(svn_cmd propget svn:executable exec1.sh)"
+	fi &&
 	test "x$(svn_cmd propget svn:mime-type exec1.sh)" = \
 	     "xapplication/x-shellscript" &&
 	test "x$(svn_cmd propget svn:mime-type hello.txt)" = "xtext/plain" &&
@@ -73,7 +74,10 @@ test_expect_success 'check resulting svn repository' '
 	test "x$(svn_cmd propget svn:mime-type bar)" = "x" &&
 
 	# Check properties from second commit.
-	test "x$(svn_cmd propget svn:executable exec2.sh)" = "x*" &&
+	if test_have_prereq POSIXPERM
+	then
+		test -z "$(svn_cmd propget svn:executable exec2.sh)"
+	fi &&
 	test "x$(svn_cmd propget svn:mime-type exec2.sh)" = "x" &&
 	test "x$(svn_cmd propget svn:mime-type world.txt)" = "x" &&
 	test "x$(svn_cmd propget svn:eol-style world.txt)" = "x" &&
-- 
2.7.0.windows.1.7.g55a05c8
