From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Do not let lstree output recursively when a directory whose name
 is a prefix of the others is given in the path list.
Date: Sat, 11 Sep 2010 11:57:54 -0700
Message-ID: <7vhbhwf6q5.fsf@alter.siamese.dyndns.org>
References: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
 <vpqzkvr5u73.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davi.reis@gmail.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Sep 11 20:58:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuVHg-0007h6-9W
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 20:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab0IKS6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 14:58:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0IKS6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 14:58:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B538CD581B;
	Sat, 11 Sep 2010 14:58:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w6Q4bhzxw8osNWGu0AyEi27Zf8U=; b=w/pCpP
	GpR/F/tKwlMAooeSR2seXZVgni89w45zDKDqnrSz18OfhP/fh+Uwu5fd/ni4Qu3U
	HnPtJupjuUmnD9PDgQYFzpGpVzp+/CMSuABqPXHn2c7BTGxWJJ1voTYIiRHV56Pu
	MtqVHj8mLM+6JF9fPazoncF5ChnwPFuD6dyRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKlczpf6rfPfTo6DjsWzgfwkhDOJzzDA
	IlAj9ZjTTxYXiqF0uUqj2ONhFrb6j+S9XD2TUrEulCzLP+9VUfUwomEkV4iF1Sh6
	glEpwxe6JKQtINSsZ6p8mlbZtAdwEpYwTWrrtB6ZX+TDuSSIqdpFWJh4MWzeVWiG
	CDp0ITgBlfE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83554D5819;
	Sat, 11 Sep 2010 14:58:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A421D5818; Sat, 11 Sep
 2010 14:57:56 -0400 (EDT)
In-Reply-To: <vpqzkvr5u73.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu\, 09 Sep 2010 08\:04\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F8EA842-BDD6-11DF-978A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156005>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> That's so close to a real test-case...

Let's do this.

 * t3101 seems somewhat stale; fix the style and add a few missing " &&"
   cascades as a preparatory patch.

 * Add the "mistaken prefix computation causes unwarranted recursion" fix
   with a test.

Here is the first one in such a series.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 11 Sep 2010 10:53:29 -0700
Subject: [PATCH] t3101: modernise style

Also add a few " &&" cascade that were missing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3101-ls-tree-dirname.sh |  126 ++++++++++++++++++++++---------------------
 1 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 06654c6..026f9f8 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -21,33 +21,32 @@ entries.  Also test odd filename and missing entries handling.
 '
 . ./test-lib.sh
 
-test_expect_success \
-    'setup' \
-    'echo 111 >1.txt &&
-     echo 222 >2.txt &&
-     mkdir path0 path0/a path0/a/b path0/a/b/c &&
-     echo 111 >path0/a/b/c/1.txt &&
-     mkdir path1 path1/b path1/b/c &&
-     echo 111 >path1/b/c/1.txt &&
-     mkdir path2 &&
-     echo 111 >path2/1.txt &&
-     mkdir path3 &&
-     echo 111 >path3/1.txt &&
-     echo 222 >path3/2.txt &&
-     find *.txt path* \( -type f -o -type l \) -print |
-     xargs git update-index --add &&
-     tree=`git write-tree` &&
-     echo $tree'
+test_expect_success 'setup' '
+	echo 111 >1.txt &&
+	echo 222 >2.txt &&
+	mkdir path0 path0/a path0/a/b path0/a/b/c &&
+	echo 111 >path0/a/b/c/1.txt &&
+	mkdir path1 path1/b path1/b/c &&
+	echo 111 >path1/b/c/1.txt &&
+	mkdir path2 &&
+	echo 111 >path2/1.txt &&
+	mkdir path3 &&
+	echo 111 >path3/1.txt &&
+	echo 222 >path3/2.txt &&
+	find *.txt path* \( -type f -o -type l \) -print |
+	xargs git update-index --add &&
+	tree=`git write-tree` &&
+	echo $tree
+'
 
 test_output () {
-    sed -e "s/ $_x40	/ X	/" <current >check
-    test_cmp expected check
+	sed -e "s/ $_x40	/ X	/" <current >check &&
+	test_cmp expected check
 }
 
-test_expect_success \
-    'ls-tree plain' \
-    'git ls-tree $tree >current &&
-     cat >expected <<\EOF &&
+test_expect_success 'ls-tree plain' '
+	git ls-tree $tree >current &&
+	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	2.txt
 040000 tree X	path0
@@ -55,13 +54,13 @@ test_expect_success \
 040000 tree X	path2
 040000 tree X	path3
 EOF
-     test_output'
+	test_output
+'
 
 # Recursive does not show tree nodes anymore...
-test_expect_success \
-    'ls-tree recursive' \
-    'git ls-tree -r $tree >current &&
-     cat >expected <<\EOF &&
+test_expect_success 'ls-tree recursive' '
+	git ls-tree -r $tree >current &&
+	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	2.txt
 100644 blob X	path0/a/b/c/1.txt
@@ -70,68 +69,71 @@ test_expect_success \
 100644 blob X	path3/1.txt
 100644 blob X	path3/2.txt
 EOF
-     test_output'
+	test_output
+'
 
-test_expect_success \
-    'ls-tree filter 1.txt' \
-    'git ls-tree $tree 1.txt >current &&
-     cat >expected <<\EOF &&
+test_expect_success 'ls-tree filter 1.txt' '
+	git ls-tree $tree 1.txt >current &&
+	cat >expected <<\EOF &&
 100644 blob X	1.txt
 EOF
-     test_output'
+	test_output
+'
 
-test_expect_success \
-    'ls-tree filter path1/b/c/1.txt' \
-    'git ls-tree $tree path1/b/c/1.txt >current &&
-     cat >expected <<\EOF &&
+test_expect_success 'ls-tree filter path1/b/c/1.txt' '
+	git ls-tree $tree path1/b/c/1.txt >current &&
+	cat >expected <<\EOF &&
 100644 blob X	path1/b/c/1.txt
 EOF
-     test_output'
+	test_output
+'
 
-test_expect_success \
-    'ls-tree filter all 1.txt files' \
-    'git ls-tree $tree 1.txt path0/a/b/c/1.txt path1/b/c/1.txt path2/1.txt path3/1.txt >current &&
-     cat >expected <<\EOF &&
+test_expect_success 'ls-tree filter all 1.txt files' '
+	git ls-tree $tree 1.txt path0/a/b/c/1.txt \
+		path1/b/c/1.txt path2/1.txt path3/1.txt >current &&
+	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	path0/a/b/c/1.txt
 100644 blob X	path1/b/c/1.txt
 100644 blob X	path2/1.txt
 100644 blob X	path3/1.txt
 EOF
-     test_output'
+	test_output
+'
 
 # I am not so sure about this one after ls-tree doing pathspec match.
 # Having both path0/a and path0/a/b/c makes path0/a redundant, and
 # it behaves as if path0/a/b/c, path1/b/c, path2 and path3 are specified.
-test_expect_success \
-    'ls-tree filter directories' \
-    'git ls-tree $tree path3 path2 path0/a/b/c path1/b/c path0/a >current &&
-     cat >expected <<\EOF &&
+test_expect_success 'ls-tree filter directories' '
+	git ls-tree $tree path3 path2 path0/a/b/c path1/b/c path0/a >current &&
+	cat >expected <<\EOF &&
 040000 tree X	path0/a/b/c
 040000 tree X	path1/b/c
 040000 tree X	path2
 040000 tree X	path3
 EOF
-     test_output'
+	test_output
+'
 
 # Again, duplicates are filtered away so this is equivalent to
 # having 1.txt and path3
-test_expect_success \
-    'ls-tree filter odd names' \
-    'git ls-tree $tree 1.txt ./1.txt .//1.txt path3/1.txt path3/./1.txt path3 path3// >current &&
-     cat >expected <<\EOF &&
+test_expect_success 'ls-tree filter odd names' '
+	git ls-tree $tree 1.txt ./1.txt .//1.txt \
+		path3/1.txt path3/./1.txt path3 path3// >current &&
+	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	path3/1.txt
 100644 blob X	path3/2.txt
 EOF
-     test_output'
+	test_output
+'
 
-test_expect_success \
-    'ls-tree filter missing files and extra slashes' \
-    'git ls-tree $tree 1.txt/ abc.txt path3//23.txt path3/2.txt/// >current &&
-     cat >expected <<\EOF &&
-EOF
-     test_output'
+test_expect_success 'ls-tree filter missing files and extra slashes' '
+	git ls-tree $tree 1.txt/ abc.txt \
+		path3//23.txt path3/2.txt/// >current &&
+	>expected &&
+	test_output
+'
 
 test_expect_success 'ls-tree filter is leading path match' '
 	git ls-tree $tree pa path3/a >current &&
@@ -198,7 +200,7 @@ EOF
 '
 
 test_expect_success 'ls-tree --name-only' '
-	git ls-tree --name-only $tree >current
+	git ls-tree --name-only $tree >current &&
 	cat >expected <<\EOF &&
 1.txt
 2.txt
@@ -211,7 +213,7 @@ EOF
 '
 
 test_expect_success 'ls-tree --name-only -r' '
-	git ls-tree --name-only -r $tree >current
+	git ls-tree --name-only -r $tree >current &&
 	cat >expected <<\EOF &&
 1.txt
 2.txt
-- 
1.7.3.rc1.215.g6997c
