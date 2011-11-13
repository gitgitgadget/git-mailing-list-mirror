From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Add built-in diff patterns for MATLAB code
Date: Sun, 13 Nov 2011 14:42:44 +0100
Message-ID: <1321191764-11972-1-git-send-email-hendeby@isy.liu.se>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 14:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPaTh-0004yB-GX
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 14:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab1KMNwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 08:52:04 -0500
Received: from muon.isy.liu.se ([130.236.48.25]:55636 "EHLO muon.isy.liu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab1KMNwC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 08:52:02 -0500
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Nov 2011 08:52:02 EST
Received: from foolap.hendeby.homeip.net (81-232-38-97-no36.tbcn.telia.com [81.232.38.97])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by muon.isy.liu.se (Postfix) with ESMTPSA id ECE61104;
	Sun, 13 Nov 2011 14:43:02 +0100 (MET)
X-Mailer: git-send-email 1.7.8.rc2.209.geddc4
X-ISY-LIU-SE-MailScanner-Information: Please contact postmaster@isy.liu.se for more information
X-ISY-LIU-SE-MailScanner-ID: ECE61104.A14D8
X-ISY-LIU-SE-MailScanner: Found to be clean
X-ISY-LIU-SE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-ISY-LIU-SE-MailScanner-From: hendeby@isy.liu.se
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185339>

MATLAB is often used in industry and academia for scientific
computations motivating it being included as a build in pattern.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---
 Documentation/gitattributes.txt |    2 ++
 t/t4018-diff-funcname.sh        |    2 +-
 t/t4034-diff-words.sh           |    1 +
 t/t4034/matlab/expect           |   14 ++++++++++++++
 t/t4034/matlab/post             |    9 +++++++++
 t/t4034/matlab/pre              |    9 +++++++++
 userdiff.c                      |    3 +++
 7 files changed, 39 insertions(+), 1 deletions(-)
 create mode 100644 t/t4034/matlab/expect
 create mode 100644 t/t4034/matlab/post
 create mode 100644 t/t4034/matlab/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 25e46ae..a85b187 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -500,6 +500,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `matlab` suitable for source code in the MATLAB language.
+
 - `objc` suitable for source code in the Objective-C language.
 
 - `pascal` suitable for source code in the Pascal/Delphi language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index b68c56b..4bd2a1c 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -105,7 +105,7 @@ test_expect_funcname () {
 	grep "^@@.*@@ $1" diff
 }
 
-for p in bibtex cpp csharp fortran html java objc pascal perl php python ruby tex
+for p in bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index c374aa4..6f1e5a2 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -299,6 +299,7 @@ test_language_driver csharp
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
+test_language_driver matlab
 test_language_driver objc
 test_language_driver pascal
 test_language_driver perl
diff --git a/t/t4034/matlab/expect b/t/t4034/matlab/expect
new file mode 100644
index 0000000..d846ce9
--- /dev/null
+++ b/t/t4034/matlab/expect
@@ -0,0 +1,14 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index ac2af08..0f07497 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,9 +1,9 @@<RESET>
+(<RED>1<RESET><GREEN>0<RESET>) (<RED>-1e10<RESET><GREEN>-0e10<RESET>) '<RED>b<RESET><GREEN>y<RESET>';
+[<RED>a<RESET><GREEN>x<RESET>] {<RED>a<RESET><GREEN>x<RESET>} <RED>a<RESET><GREEN>x<RESET>.<RED>b<RESET><GREEN>y<RESET>;
+~<RED>a<RESET><GREEN>x<RESET>;
+<RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>.*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>./<RED>b a<RESET><GREEN>y x<RESET>^<RED>b a<RESET><GREEN>y x<RESET>.^<RED>b<RESET><GREEN>y<RESET>;
+<RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET><GREEN>y<RESET>;
+<RED>a<RESET><GREEN>x<RESET>&<RED>b a<RESET><GREEN>y x<RESET>&&<RED>b a<RESET><GREEN>y x<RESET>|<RED>b a<RESET><GREEN>y x<RESET>||<RED>b<RESET><GREEN>y<RESET>;
+<RED>a<RESET><GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET><GREEN>y<RESET>;
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>~=<RED>b<RESET><GREEN>y<RESET>;
+<RED>a<RESET><GREEN>x<RESET>,<RED>b<RESET><GREEN>y<RESET>;
diff --git a/t/t4034/matlab/post b/t/t4034/matlab/post
new file mode 100644
index 0000000..0f07497
--- /dev/null
+++ b/t/t4034/matlab/post
@@ -0,0 +1,9 @@
+(0) (-0e10) 'y';
+[x] {x} x.y;
+~x;
+x*y x.*y x/y x./y x^y x.^y;
+x+y x-y;
+x&y x&&y x|y x||y;
+x<y x<=y x>y x>=y;
+x==y x~=y;
+x,y;
diff --git a/t/t4034/matlab/pre b/t/t4034/matlab/pre
new file mode 100644
index 0000000..ac2af08
--- /dev/null
+++ b/t/t4034/matlab/pre
@@ -0,0 +1,9 @@
+(1) (-1e10) 'b';
+[a] {a} a.b;
+~a;
+a*b a.*b a/b a./b a^b a.^b;
+a+b a-b;
+a&b a&&b a|b a||b;
+a<b a<=b a>b a>=b;
+==b a~=b;
+a,b;
diff --git a/userdiff.c b/userdiff.c
index bf553ad..e0948e6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -37,6 +37,9 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("matlab",
+	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\|\\||&&"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
-- 
1.7.8.rc1.222.g29897
