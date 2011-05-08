From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t3703, t4208: add test cases for magic pathspec
Date: Sun,  8 May 2011 18:08:26 +0700
Message-ID: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
References: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 08 13:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ1ty-0002Yi-Cj
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 13:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab1EHLLg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 07:11:36 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:52489 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab1EHLLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 07:11:35 -0400
Received: by pxi16 with SMTP id 16so3077592pxi.4
        for <git@vger.kernel.org>; Sun, 08 May 2011 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=u21ArkIJCWtAuHndn6ES1s7kSD1iviLc2w05KcoYJSM=;
        b=tf7itRWEFulaAoJxScLJv2fw9TS9IvgYJJMgQWoKinQYnBt+0jyqNliehfHSd/MXti
         6nUhAd0/V2TRio0F5PF1/IM78BCkVNcE8V/l26Eos6LcpAqQoniQ9gF30ok1Sueqc6hU
         t7RERi/EGHQEQlM0xISJ9RTlAhBhpmncsk8AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xQ804b/swSrEo+2+z7qKDLXNTD7q/jObkiG+fvf0NfWq+3NbpN0nv3rfsHf0du3ehP
         wUrQ89p1VhfVAP8SHR/s+spsEDBE60fuLxQwbh6P0We/EfQK1tk8WLd6RonJfPXDWeoQ
         2Ej8kuNZQMta9ROOF74nUmCnSY8cDxSrE7l1Y=
Received: by 10.142.173.14 with SMTP id v14mr3044159wfe.119.1304853094639;
        Sun, 08 May 2011 04:11:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.196.42])
        by mx.google.com with ESMTPS id k7sm6680365wfa.2.2011.05.08.04.11.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 04:11:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 08 May 2011 18:08:37 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173092>

While at it, also document ":" syntax.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2.

 Documentation/glossary-content.txt |    3 +
 t/t3703-add-magic-pathspec.sh      |   78 ++++++++++++++++++++++++++++=
++++++++
 t/t4208-log-magic-pathspec.sh      |   40 ++++++++++++++++++
 3 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100755 t/t3703-add-magic-pathspec.sh
 create mode 100755 t/t4208-log-magic-pathspec.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index 0ca029b..02cea08 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -311,6 +311,9 @@ parenthesis `(`, a comma-separated list of zero or =
more "magic words",
 and a close parentheses `)`, and the remainder is the pattern to match
 against the path.
 +
+A pathspec with only a colon means "there is no pathspec". This form
+cannot be combined with other pathspec.
++
 The "magic signature" consists of an ASCII symbol that is not
 alphanumeric.
 +
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec=
=2Esh
new file mode 100755
index 0000000..3d8c6b8
--- /dev/null
+++ b/t/t3703-add-magic-pathspec.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description=3D'magic pathspec tests using git-add'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir sub anothersub &&
+	: >sub/foo &&
+	: >anothersub/foo
+'
+
+test_expect_failure 'colon alone magic can only used alone' '
+	test_must_fail git add -n sub/foo : &&
+	test_must_fail git add -n : sub/foo
+'
+
+cat >expected <<EOF
+add 'anothersub/foo'
+add 'expected'
+add 'sub/actual'
+add 'sub/foo'
+EOF
+
+test_expect_success 'add :' '
+	(cd sub && git add -n : >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'add :/' '
+	(cd sub && git add -n :/ >actual) &&
+	test_cmp expected sub/actual
+'
+
+cat >expected <<EOF
+add 'anothersub/foo'
+EOF
+
+test_expect_success 'add :/anothersub' '
+	(cd sub && git add -n :/anothersub >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'add :/non-existent' '
+	(cd sub && test_must_fail git add -n :/non-existent)
+'
+
+cat >expected <<EOF
+add 'sub/foo'
+EOF
+
+test_expect_success 'add :(icase)foo' '
+	(cd sub && git add -n ":(icase)FoO" >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'a file with the same (long) magic name exists' '
+	: >":(icase)ha" &&
+	test_must_fail git add -n ":(icase)ha" 2>error &&
+	git add -n "./:(icase)ha"
+'
+
+cat >expected <<EOF
+fatal: pathspec ':(icase)ha' did not match any files
+EOF
+
+test_expect_failure 'show pathspecs exactly what are typed in' '
+	test_cmp expected error
+'
+
+test_expect_success 'a file with the same (short) magic name exists' '
+	mkdir ":" &&
+	: >":/bar" &&
+	test_must_fail git add -n :/bar &&
+	git add -n "./:/bar"
+'
+
+test_done
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec=
=2Esh
new file mode 100755
index 0000000..b296a74
--- /dev/null
+++ b/t/t4208-log-magic-pathspec.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description=3D'magic pathspec tests using git-log'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	test_tick &&
+	git commit --allow-empty -m empty &&
+	mkdir sub
+'
+
+test_expect_failure 'git log :/ ambiguous with [ref]:/path' '
+	test_must_fail git log :/ 2>error &&
+	grep ambiguous error
+'
+
+test_expect_failure 'git log :' '
+	git log :
+'
+
+test_expect_success 'git log HEAD -- :/' '
+	cat >expected <<EOF &&
+24b24cf initial
+EOF
+	(cd sub && git log --oneline HEAD -- :/ >../actual) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git log HEAD -- :' '
+	cat >expected <<EOF &&
+41d179c empty
+24b24cf initial
+EOF
+	(cd sub && git log --oneline HEAD -- : >../actual) &&
+	test_cmp expected actual
+'
+
+test_done
--=20
1.7.4.74.g639db
