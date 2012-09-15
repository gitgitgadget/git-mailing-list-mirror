From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] Integrate wildmatch to git
Date: Sat, 15 Sep 2012 19:02:03 +0700
Message-ID: <1347710524-15404-5-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 14:03:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCr5e-0003IB-14
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 14:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab2IOMC6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2012 08:02:58 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57287 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab2IOMC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 08:02:27 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6891861pbb.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q1BfLSoeimlI53CWcmTAzw5kfDk1ETHejesfrfkgJVo=;
        b=tR61ufTVjwOHF1UII5iaJJOxN2T1kjkjyGTb8HqCJYwQzJaRBfAiIAUvD6GOgYMsIV
         6PtpGbufK9hAdQKbs6+1V78Ds6WayDnrP5L6wUAUHvzyCRrOkwHovZkykLzsqGCqZg0v
         paYrMrFlbcyjrih+zJ5lpR8KHrxlPaJ21nAQU8wx9BNbUZmH64L2guxL/xcSiq+NXvTj
         yLP8e3FXG3rh6lWCPHVFwnCT/rp39M/RqT3EBltNR2+mRmZCf6CHTjLwL1QcrNVKmQua
         5x63YEZGtInDk1DfV4khxOVInwAClmcpn2u3JEe3nwmm45ImExA2xfvLpG46RSmY3pWU
         v6UA==
Received: by 10.68.190.8 with SMTP id gm8mr10323265pbc.74.1347710546760;
        Sat, 15 Sep 2012 05:02:26 -0700 (PDT)
Received: from lanh ([115.74.56.159])
        by mx.google.com with ESMTPS id vf8sm2853904pbc.27.2012.09.15.05.02.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 05:02:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Sep 2012 19:02:28 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205554>

This makes wildmatch.c part of libgit.a and builds test-wildmatch

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile             |  6 ++++++
 compat/wildmatch.c   |  8 +++++++-
 t/t3070-wildmatch.sh | 27 +++++++++++++++++++++++++++
 test-wildmatch.c     |  8 +++++++-
 4 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh

diff --git a/Makefile b/Makefile
index 56301dc..c3608e6 100644
--- a/Makefile
+++ b/Makefile
@@ -511,6 +511,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-wildmatch
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -605,6 +606,7 @@ LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
 LIB_H +=3D compat/precompose_utf8.h
 LIB_H +=3D compat/terminal.h
+LIB_H +=3D compat/wildmatch.h
 LIB_H +=3D compat/win32/dirent.h
 LIB_H +=3D compat/win32/poll.h
 LIB_H +=3D compat/win32/pthread.h
@@ -709,6 +711,7 @@ LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D compat/obstack.o
 LIB_OBJS +=3D compat/terminal.o
+LIB_OBJS +=3D compat/wildmatch.o
 LIB_OBJS +=3D config.o
 LIB_OBJS +=3D connect.o
 LIB_OBJS +=3D connected.o
@@ -2586,6 +2589,9 @@ test-svn-fe$X: vcs-svn/lib.a
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(filter %.a,$^) $(LIBS)
=20
+test-wildmatch$X: test-wildmatch.o GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) -lpopt
+
 check-sha1:: test-sha1$X
 	./test-sha1.sh
=20
diff --git a/compat/wildmatch.c b/compat/wildmatch.c
index c7f7f9f..625cb0c 100644
--- a/compat/wildmatch.c
+++ b/compat/wildmatch.c
@@ -9,7 +9,13 @@
 **  work differently than '*', and to fix the character-class code.
 */
=20
-#include "rsync.h"
+#include <stddef.h>
+#include <ctype.h>
+#include <string.h>
+
+#include "wildmatch.h"
+
+typedef unsigned char uchar;
=20
 /* What character marks an inverted character class? */
 #define NEGATE_CLASS	'!'
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
new file mode 100755
index 0000000..7fb63ff
--- /dev/null
+++ b/t/t3070-wildmatch.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description=3D'wildmatch tests'
+
+. ./test-lib.sh
+
+test_wildmatch() {
+    test_expect_success "wildmatch $*" "
+	test-wildmatch $* ../t3070-wildmatch/wildtest.txt >actual &&
+	echo 'No wildmatch errors found.' >expected &&
+	test_cmp expected actual
+    "
+}
+
+test_wildmatch -x1
+test_wildmatch -x1 -e1
+test_wildmatch -x1 -else
+test_wildmatch -x2
+test_wildmatch -x2 -ese
+test_wildmatch -x3
+test_wildmatch -x3 -e1
+test_wildmatch -x4
+test_wildmatch -x4 -e2e
+test_wildmatch -x5
+test_wildmatch -x5 -es
+
+test_done
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 88585c2..2c506a0 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -20,7 +20,13 @@
 /*#define COMPARE_WITH_FNMATCH*/
=20
 #define WILD_TEST_ITERATIONS
-#include "lib/wildmatch.c"
+#include "compat/wildmatch.c"
+
+#define MAXPATHLEN 1024
+#ifdef NO_STRLCPY
+#include "compat/strlcpy.c"
+#define strlcpy gitstrlcpy
+#endif
=20
 #include <popt.h>
=20
--=20
1.7.12.403.gce5cf6f.dirty
