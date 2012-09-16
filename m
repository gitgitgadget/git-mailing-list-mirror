From: Adrian Johnson <ajohnson@redneon.com>
Subject: [PATCH] Add userdiff patterns for Ada
Date: Sun, 16 Sep 2012 13:24:15 +0930
Message-ID: <50554D67.1020204@redneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 06:01:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD634-0005SO-VD
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 06:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab2IPEAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 00:00:38 -0400
Received: from redneon.com ([76.191.252.68]:35452 "EHLO redneon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab2IPEAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 00:00:37 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2012 00:00:37 EDT
Received: from bearcat.lan (ppp121-45-48-176.lns20.adl2.internode.on.net [121.45.48.176])
	by redneon.com (Postfix) with ESMTPA id 6EB87193027D
	for <git@vger.kernel.org>; Sun, 16 Sep 2012 13:24:16 +0930 (CST)
Received: from [192.168.1.1] (bearcat.lan [192.168.1.1])
	by bearcat.lan (Postfix) with ESMTP id 51E4A400A2C6
	for <git@vger.kernel.org>; Sun, 16 Sep 2012 13:24:15 +0930 (CST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205591>

Add Ada xfuncname and wordRegex patterns to the list of builtin
patterns.

Signed-off-by: Adrian Johnson <ajohnson@redneon.com>
---
 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  2 +-
 t/t4034-diff-words.sh           |  1 +
 t/t4034/ada/expect              | 27 +++++++++++++++++++++++++++
 t/t4034/ada/post                | 13 +++++++++++++
 t/t4034/ada/pre                 | 13 +++++++++++++
 userdiff.c                      |  9 +++++++++
 7 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 t/t4034/ada/expect
 create mode 100644 t/t4034/ada/post
 create mode 100644 t/t4034/ada/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 462b79c..99ed04d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -511,6 +511,8 @@ configuration file (you still need to enable this with the
 attribute mechanism, via `.gitattributes`).  The following built in
 patterns are available:
 
+- `ada` suitable for source code in the Ada language.
+
 - `bibtex` suitable for files with BibTeX coded references.
 
 - `cpp` suitable for source code in the C and C++ languages.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 4bd2a1c..082d3e8 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -105,7 +105,7 @@ test_expect_funcname () {
 	grep "^@@.*@@ $1" diff
 }
 
-for p in bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
+for p in ada bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 30d42cb..40ab333 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -298,6 +298,7 @@ test_expect_success 'unset default driver' '
 	test_unconfig diff.wordregex
 '
 
+test_language_driver ada
 test_language_driver bibtex
 test_language_driver cpp
 test_language_driver csharp
diff --git a/t/t4034/ada/expect b/t/t4034/ada/expect
new file mode 100644
index 0000000..be2376e
--- /dev/null
+++ b/t/t4034/ada/expect
@@ -0,0 +1,27 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index d96fdd1..df21bb0 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,13 +1,13 @@<RESET>
+Ada.Text_IO.Put_Line("Hello World<RED>!<RESET><GREEN>?<RESET>");
+1 1e<RED>-<RESET>10 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
+<RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>**<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>(<RED>b<RESET><GREEN>y<RESET>)
+<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>/= <RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>..<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><><RED>b<RESET><GREEN>y<RESET>
diff --git a/t/t4034/ada/post b/t/t4034/ada/post
new file mode 100644
index 0000000..df21bb0
--- /dev/null
+++ b/t/t4034/ada/post
@@ -0,0 +1,13 @@
+Ada.Text_IO.Put_Line("Hello World?");
+1 1e10 16#FE12#E2 3.141_592 'y'
+x+y x-y
+x*y x/y
+x**y
+x(y)
+x:=y
+x=y x/= y
+x<y x<=y x>y x>=y
+x,y
+x=>y
+x..y
+x<>y
diff --git a/t/t4034/ada/pre b/t/t4034/ada/pre
new file mode 100644
index 0000000..d96fdd1
--- /dev/null
+++ b/t/t4034/ada/pre
@@ -0,0 +1,13 @@
+Ada.Text_IO.Put_Line("Hello World!");
+1 1e-10 16#FE12#E2 3.141_592 'x'
+a+b a-b
+a*b a/b
+a**b
+a(b)
+a:=b
+a=b a/= b
+a<b a<=b a>b a>=b
+a,b
+a=>b
+a..b
+a<>b
diff --git a/userdiff.c b/userdiff.c
index 1e7184f..ed958ef 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -14,6 +14,15 @@ static int drivers_alloc;
 	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
 	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
 static struct userdiff_driver builtin_drivers[] = {
+IPATTERN("ada",
+	 "!^(.*[ \t])?(is new|renames|is separate)([ \t].*)?$\n"
+	 "!^[ \t]*with[ \t].*$\n"
+	 "^[ \t]*((procedure|function)[ \t]+.*)$\n"
+	 "^[ \t]*((package|protected|task)[ \t]+.*)$",
+	 /* -- */
+	 "[a-zA-Z][a-zA-Z0-9_]*"
+	 "|[0-9][-+0-9#_.eE]"
+	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
1.7.12.465.g52d9ccc
