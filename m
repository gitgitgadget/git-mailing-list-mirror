From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 7/8] t7810: add test for grep -W and trailing empty context
 lines
Date: Sat, 28 May 2016 17:05:41 +0200
Message-ID: <5749B3C5.4060809@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 17:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6foH-0006md-BU
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbcE1PFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:05:50 -0400
Received: from mout.web.de ([212.227.15.14]:56500 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbcE1PFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:05:49 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Maazp-1amfx12zl3-00KASQ; Sat, 28 May 2016 17:05:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5749AF59.2070704@web.de>
X-Provags-ID: V03:K0:6gzlFZ7Qqg6v2Wv+pNumnaOinfUTrlq4Kx334Jyzt9ASjIspX+O
 zFO8SnwBux2eywFk9OpDvQK0JvrT8LvJ8vVuTHCs25tDBEB9c/jVKsvv3xN5JgVdlfDncot
 zQEOZ7XSlaMTAKhsla/zdtvQCF2Id3+3fyyZUYw+PTnkn8TuvJQkVA1inyxuQbXlXeVwRaK
 m0rCHsEoMh4OkjklKB47g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lwLtLVi5Ax8=:OwO/KjzuJd2o3OAPMcRqDO
 jmUhXb0qmIWXAKWQHP/D2kvBTqK01GMxKK/QH67nQmw0E0sUL7rnh9tTEQY5t6nT4u3dJP1vJ
 HBbKu0mTzg3Yzz/Edw9PUXvqwWWEBv9qdkM/IxCUU2kDMpUNz2v5bqQ9MFbkI+oGzgd8i1c3y
 XaTAyU79Zxp9Q0p35LwTifwNdHfxeq0gmlmM//26Q6pZK0rC7YjjZKRKHAFXqY48KMYdf7h7r
 NQT88IYmLcVX3GqJbGCUfWkmwztqVDWUQTKQUwq7c5OXGmjwWgqHXPqzCDiQ2NUGUwNs9V7aP
 jFwCgmJ5/a0vVPn3weeqpUm8pV0hNZxzbT9quDuE4+/lg/EmTFQ80Nj8H1DrcjbW8cqyTJrqx
 Q+ZmGGMvbnlIq9nIaCUGzMlGc155l97MFuqntMfY9UGQij/lYXlvwHiViai5P/9oWtpVvWGUP
 dns6+hKhMDshDdgkLi3ppDm/JWgvLt6idMt1fkKFzl3AMTn2ukCgeZzXrboaxJKR6WFy9GVvK
 JdD+B3/GSK3KpEFAJMEZbhNa5H1nYQXHM6VcBMD2yedldWTfUoHy528EhYregjqUWh3ykA/xg
 6KjDpMtMV2mwaZRwczPKhAQn+xGOo8ZVMJURcoHGHkFhW0BhysyirlNtWcM8EtKF7HDuHlf9X
 iK0qlo+ZQ3kkB2VdPkfjR8zKJpbizh7Bcuegjo7ChTQA7IHlP7488wJ5zgm96OLFnfrecT204
 HixkbifyzuEx6MIHdIcuY9IycVICT5+Qd6SIgBQ1OIc5LlknxOOsuSvFccpET8fzFFpPtkG1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295825>

Add a test demonstrating that git grep -W prints empty lines following
the function context we're actually interested in.  The modified test
file makes it necessary to adjust three unrelated test cases.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t7810-grep.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1e72971..26912dc 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -9,7 +9,9 @@ test_description='git grep various.
 . ./test-lib.sh
 
 cat >hello.c <<EOF
+#include <assert.h>
 #include <stdio.h>
+
 int main(int argc, const char **argv)
 {
 	printf("Hello world.\n");
@@ -715,6 +717,7 @@ test_expect_success 'grep -p' '
 
 cat >expected <<EOF
 hello.c-#include <stdio.h>
+hello.c-
 hello.c=int main(int argc, const char **argv)
 hello.c-{
 hello.c-	printf("Hello world.\n");
@@ -741,6 +744,16 @@ test_expect_success 'grep -W' '
 '
 
 cat >expected <<EOF
+hello.c-#include <assert.h>
+hello.c:#include <stdio.h>
+EOF
+
+test_expect_failure 'grep -W shows no trailing empty lines' '
+	git grep -W stdio >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 hello.c=	printf("Hello world.\n");
 hello.c:	return 0;
 hello.c-	/* char ?? */
@@ -1232,8 +1245,8 @@ test_expect_success 'grep --heading' '
 
 cat >expected <<EOF
 <BOLD;GREEN>hello.c<RESET>
-2:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
-6:	/* <BLACK;BYELLOW>char<RESET> ?? */
+4:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
+8:	/* <BLACK;BYELLOW>char<RESET> ?? */
 
 <BOLD;GREEN>hello_world<RESET>
 3:Hel<BLACK;BYELLOW>lo_w<RESET>orld
@@ -1340,7 +1353,7 @@ test_expect_success 'grep --color -e A --and --not -e B with context' '
 '
 
 cat >expected <<EOF
-hello.c-#include <stdio.h>
+hello.c-
 hello.c=int main(int argc, const char **argv)
 hello.c-{
 hello.c:	pr<RED>int<RESET>f("<RED>Hello<RESET> world.\n");
-- 
2.8.3
