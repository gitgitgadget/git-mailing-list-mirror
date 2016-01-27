From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 18/20] mingw: handle the missing POSIXPERM prereq in
 t9124
Date: Wed, 27 Jan 2016 17:20:15 +0100 (CET)
Message-ID: <05b8e560c0e4d10eea9f945e8e14029cb1b3e54b.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpe-0002ul-0t
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934055AbcA0QUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:60111 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934025AbcA0QUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:20:19 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MJjvw-1aPYl21H7M-0016Fr; Wed, 27 Jan 2016 17:20:16
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:l++ZjJsW+0lognWrjUbjHmzG4QUAueEaZcz5ucVl3NjE2DtEnar
 9Omm6WnMVC4+nHY55/6Dnj2yISdAeeOlNrWWNpQOQBouMM0NR4vPxU5e/AAFBARKriFFeI2
 2jzBSA6VhgAFy/prfYLPnK/xPF9FLeprVxM8u+FJossDdkcB4dVRVuvMOd+FWK3kgQn7TrY
 jiE3s/gM2mshiFbl4Tz0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:39Mmrxmqqp8=:rIaHaPk8UBIHJlpy7d7U73
 g/bVf0wBV3o15b904C83LWrtTlEcXdIkKILIB7ihSpO1wcEBaI3/ALRW2splLHKpOedhMY0zb
 inFj5EwtXBzWc3wISd+MrS1g+Sp0Z5P/7KyKT6XsgzaM5SAzwE/4q1enLkcDrLGmxW3PfLLNB
 ENlBn0SrJNaPSwNv+uAJQ6BDvr4n7Z7riDy77/aBoJjuXE1ldn/OnpAnN3stIxvp8WD09WtKx
 1yMlvwXHY02XPjmKeGpDS05jlXBBEGYxqgFKDBcnsBzdTgjZcXNdjkSk9aTeAeIysF4WgO5rC
 DW4LAOAsEgnk8WybmpAlGgu7IBBzgR1J5bXL90wcT3/3+NF7T4QA1idpFpw5UhsQKawrU/W2V
 Hvptn3eRs3ZjLqAabxmnm1OFqSw1cdRWgr2O/XLFRaZlkIPC6xxKQDE1i/7jJRGyx32zH30he
 EBCeGKGmwx4y878QwlrxBU4pneG1Q7iYncVIt4pr2WAnGiQu4vwkUWhRbYNUWx4z1n0bDDUsd
 CJ2kIr1jbbk4nuVQhV06U/u4F3+hGrZdOjk1+K+YwRN54bSfFabJ/AX3DCBETUe8rpoUs8egp
 MyAEi0CU8ulAcdfvxSxH1uIXvlnAfsQR5D3EJvbbfNpwm6LxQ5AqrIkgTmt1vThUinmto+3PF
 e91ujxXWSIiKlZqr65IV9C4YYQQm7/Phn8YAt4zFFmwvZqHMQJQJbZ6HjR/WggxLr1fNLxC4f
 SyxAXbdCFK68fxXcsn8xhbvVp8oRLZ9zTs0HQ5uUt5OEnQ+9vr4illHDyxea6IatRXyd4fxz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284935>

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
index aa841e1..9f7231d 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -34,8 +34,7 @@ test_expect_success 'enable auto-props config' '
 '
 
 test_expect_success 'add files matching auto-props' '
-	echo "#!$SHELL_PATH" >exec1.sh &&
-	chmod +x exec1.sh &&
+	write_script exec1.sh </dev/null &&
 	echo "hello" >hello.txt &&
 	echo bar >bar &&
 	git add exec1.sh hello.txt bar &&
@@ -48,8 +47,7 @@ test_expect_success 'disable auto-props config' '
 '
 
 test_expect_success 'add files matching disabled auto-props' '
-	echo "#$SHELL_PATH" >exec2.sh &&
-	chmod +x exec2.sh &&
+	write_script exec2.sh </dev/null &&
 	echo "world" >world.txt &&
 	echo zot >zot &&
 	git add exec2.sh world.txt zot &&
@@ -65,7 +63,10 @@ test_expect_success 'check resulting svn repository' '
 	cd svnrepo &&
 
 	# Check properties from first commit.
-	test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*" &&
+	if test_have_prereq POSIXPERM
+	then
+		test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*"
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
+		test "x$(svn_cmd propget svn:executable exec2.sh)" = "x*"
+	fi &&
 	test "x$(svn_cmd propget svn:mime-type exec2.sh)" = "x" &&
 	test "x$(svn_cmd propget svn:mime-type world.txt)" = "x" &&
 	test "x$(svn_cmd propget svn:eol-style world.txt)" = "x" &&
-- 
2.7.0.windows.1.7.g55a05c8
