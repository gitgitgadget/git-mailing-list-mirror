From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 09/10] t4018: test cases showing that the cpp pattern misses many anchor points
Date: Fri, 21 Mar 2014 22:07:21 +0100
Message-ID: <4f5a35463f5edc7274d4dd124aa03f1262887aad.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gp-0003oA-UB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbaCUVJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:09:11 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23357 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751774AbaCUVJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:09:05 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by lbmfmo03.bon.at (Postfix) with ESMTP id E8E4DCEA78
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:09:03 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EC1CACDF86;
	Fri, 21 Mar 2014 22:08:51 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8DEAC19F6A4;
	Fri, 21 Mar 2014 22:08:51 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244747>

Most of the tests show C++ code, but there is also a union definition and
a GNU style function definition that are not recognized.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018/cpp-class-constructor              | 5 +++++
 t/t4018/cpp-class-constructor-mem-init     | 6 ++++++
 t/t4018/cpp-class-destructor               | 5 +++++
 t/t4018/cpp-function-returning-global-type | 5 +++++
 t/t4018/cpp-function-returning-nested      | 6 ++++++
 t/t4018/cpp-function-returning-reference   | 5 +++++
 t/t4018/cpp-gnu-style-function             | 6 ++++++
 t/t4018/cpp-namespace-definition           | 5 +++++
 t/t4018/cpp-operator-definition            | 5 +++++
 t/t4018/cpp-struct-single-line             | 8 ++++++++
 t/t4018/cpp-template-function-definition   | 5 +++++
 t/t4018/cpp-union-definition               | 5 +++++
 12 files changed, 66 insertions(+)
 create mode 100644 t/t4018/cpp-class-constructor
 create mode 100644 t/t4018/cpp-class-constructor-mem-init
 create mode 100644 t/t4018/cpp-class-destructor
 create mode 100644 t/t4018/cpp-function-returning-global-type
 create mode 100644 t/t4018/cpp-function-returning-nested
 create mode 100644 t/t4018/cpp-function-returning-reference
 create mode 100644 t/t4018/cpp-gnu-style-function
 create mode 100644 t/t4018/cpp-namespace-definition
 create mode 100644 t/t4018/cpp-operator-definition
 create mode 100644 t/t4018/cpp-struct-single-line
 create mode 100644 t/t4018/cpp-template-function-definition
 create mode 100644 t/t4018/cpp-union-definition

diff --git a/t/t4018/cpp-class-constructor b/t/t4018/cpp-class-constructor
new file mode 100644
index 0000000..4c4925c
--- /dev/null
+++ b/t/t4018/cpp-class-constructor
@@ -0,0 +1,5 @@
+Item::Item(int RIGHT)
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-class-constructor-mem-init b/t/t4018/cpp-class-constructor-mem-init
new file mode 100644
index 0000000..eec1d7c
--- /dev/null
+++ b/t/t4018/cpp-class-constructor-mem-init
@@ -0,0 +1,6 @@
+Item::Item(int RIGHT) :
+	member(0)
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-class-destructor b/t/t4018/cpp-class-destructor
new file mode 100644
index 0000000..03aa51c
--- /dev/null
+++ b/t/t4018/cpp-class-destructor
@@ -0,0 +1,5 @@
+RIGHT::~RIGHT()
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-function-returning-global-type b/t/t4018/cpp-function-returning-global-type
new file mode 100644
index 0000000..bff3e5f
--- /dev/null
+++ b/t/t4018/cpp-function-returning-global-type
@@ -0,0 +1,5 @@
+::Item get::it::RIGHT()
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-function-returning-nested b/t/t4018/cpp-function-returning-nested
new file mode 100644
index 0000000..41700f2
--- /dev/null
+++ b/t/t4018/cpp-function-returning-nested
@@ -0,0 +1,6 @@
+get::Item get::it::RIGHT()
+{
+	ChangeMe;
+	broken;
+}
+
diff --git a/t/t4018/cpp-function-returning-reference b/t/t4018/cpp-function-returning-reference
new file mode 100644
index 0000000..29e2bd4
--- /dev/null
+++ b/t/t4018/cpp-function-returning-reference
@@ -0,0 +1,5 @@
+string& get::it::RIGHT(char *ptr)
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-gnu-style-function b/t/t4018/cpp-gnu-style-function
new file mode 100644
index 0000000..d65fc74
--- /dev/null
+++ b/t/t4018/cpp-gnu-style-function
@@ -0,0 +1,6 @@
+const char *
+RIGHT(int arg)
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-namespace-definition b/t/t4018/cpp-namespace-definition
new file mode 100644
index 0000000..6b88dd9
--- /dev/null
+++ b/t/t4018/cpp-namespace-definition
@@ -0,0 +1,5 @@
+namespace RIGHT
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-operator-definition b/t/t4018/cpp-operator-definition
new file mode 100644
index 0000000..f2bd167
--- /dev/null
+++ b/t/t4018/cpp-operator-definition
@@ -0,0 +1,5 @@
+Value operator+(Value LEFT, Value RIGHT)
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-struct-single-line b/t/t4018/cpp-struct-single-line
new file mode 100644
index 0000000..ad6fa8b
--- /dev/null
+++ b/t/t4018/cpp-struct-single-line
@@ -0,0 +1,8 @@
+void wrong()
+{
+}
+
+struct RIGHT_iterator_tag {};
+
+int ChangeMe;
+// broken
diff --git a/t/t4018/cpp-template-function-definition b/t/t4018/cpp-template-function-definition
new file mode 100644
index 0000000..a410298
--- /dev/null
+++ b/t/t4018/cpp-template-function-definition
@@ -0,0 +1,5 @@
+template<class T> int RIGHT(T arg)
+{
+	ChangeMe;
+	broken;
+}
diff --git a/t/t4018/cpp-union-definition b/t/t4018/cpp-union-definition
new file mode 100644
index 0000000..133b662
--- /dev/null
+++ b/t/t4018/cpp-union-definition
@@ -0,0 +1,5 @@
+union RIGHT {
+	double v;
+	int ChangeMe;
+	broken;
+};
-- 
1.8.5.2.244.g9fb3fb1
