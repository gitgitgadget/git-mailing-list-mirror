From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/10] t/t9001-send-email.sh: convert setup code to tests
Date: Fri, 13 Aug 2010 20:40:10 +0000
Message-ID: <1281732013-18284-8-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok148-0007V9-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab0HMUlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50532 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974Ab0HMUlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:11 -0400
Received: by wyb32 with SMTP id 32so3042131wyb.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rNadxcRFzULjBGWPjg67FT8g3wYbeEM2nX7ARZKFHLY=;
        b=BiPqY/VvM7lLlkL/0qdLrLvUpVln6RJg2vwXiD19W0/OvmsOu1NXd+CHm30Y5iWMRp
         KJ6SFk5I/TSRZ3xrK/M6aHskLEKAsZizUyRY0NKLCdUx2RVEMBrM3pfLcfeJSu/h5e9p
         3zZqVQ4qyOaO49iQz1bZqMOyM51q0Cj3D3yho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mPTh425FWenBDdsZ9VDekpedDX4B3i24ItMGlGbGWuVySDlFxcbhi63hdItRUpQMu2
         Zs6gYeoY2V8e8QEtSq5a78sI7iT/9DfgwJWCOFIB2HZThVEnjAv0At5veH/ZjFWrUSin
         By95kBvuech8zzW81bF6J5G05FrvOfypSSAyc=
Received: by 10.216.5.13 with SMTP id 13mr124765wek.91.1281732070350;
        Fri, 13 Aug 2010 13:41:10 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.41.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:41:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153496>

Change the setup code in t/t9001-send-email.sh to use
test_expect_success. This way it isn't needlessly run in environments
where the test prerequisites aren't met.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9001-send-email.sh |   43 ++++++++++++++++++++++++++++++++++++++++-=
--
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index bd17d31..71b3df9 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -85,12 +85,15 @@ test_expect_success $PREREQ 'Send patches' '
      git send-email --suppress-cc=3Dsob --from=3D"Example <nobody@exam=
ple.com>" --to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake.sendma=
il" $patches 2>errors
 '
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >expected <<\EOF
 !nobody@example.com!
 !author@example.com!
 !one@example.com!
 !two@example.com!
 EOF
+'
+
 test_expect_success $PREREQ \
     'Verify commandline' \
     'test_cmp expected commandline1'
@@ -100,6 +103,7 @@ test_expect_success $PREREQ 'Send patches with --en=
velope-sender' '
      git send-email --envelope-sender=3D"Patch Contributer <patch@exam=
ple.com>" --suppress-cc=3Dsob --from=3D"Example <nobody@example.com>" -=
-to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake.sendmail" $patche=
s 2>errors
 '
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >expected <<\EOF
 !patch@example.com!
 !-i!
@@ -108,6 +112,8 @@ cat >expected <<\EOF
 !one@example.com!
 !two@example.com!
 EOF
+'
+
 test_expect_success $PREREQ \
     'Verify commandline' \
     'test_cmp expected commandline1'
@@ -117,6 +123,7 @@ test_expect_success $PREREQ 'Send patches with --en=
velope-sender=3Dauto' '
      git send-email --envelope-sender=3Dauto --suppress-cc=3Dsob --fro=
m=3D"Example <nobody@example.com>" --to=3Dnobody@example.com --smtp-ser=
ver=3D"$(pwd)/fake.sendmail" $patches 2>errors
 '
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >expected <<\EOF
 !nobody@example.com!
 !-i!
@@ -125,10 +132,13 @@ cat >expected <<\EOF
 !one@example.com!
 !two@example.com!
 EOF
+'
+
 test_expect_success $PREREQ \
     'Verify commandline' \
     'test_cmp expected commandline1'
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -158,6 +168,7 @@ References: <unique-message-id@example.com>
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ 'Show all headers' '
 	git send-email \
@@ -209,10 +220,10 @@ test_expect_success $PREREQ 'cccmd works' '
 	grep "^	cccmd@example.com" msgtxt1
 '
=20
-z8=3Dzzzzzzzz
-z64=3D$z8$z8$z8$z8$z8$z8$z8$z8
-z512=3D$z64$z64$z64$z64$z64$z64$z64$z64
 test_expect_success $PREREQ 'reject long lines' '
+	z8=3Dzzzzzzzz &&
+	z64=3D$z8$z8$z8$z8$z8$z8$z8$z8 &&
+	z512=3D$z64$z64$z64$z64$z64$z64$z64$z64 &&
 	clean_fake_sendmail &&
 	cp $patches longline.patch &&
 	echo $z512$z512 >>longline.patch &&
@@ -312,6 +323,7 @@ test_expect_success $PREREQ 'second message is patc=
h' '
 	grep "Subject:.*Second" msgtxt2
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -338,6 +350,7 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_suppression () {
 	git send-email \
@@ -359,6 +372,7 @@ test_expect_success $PREREQ 'sendemail.cc set' '
 	test_suppression sob
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -383,12 +397,14 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ 'sendemail.cc unset' '
 	git config --unset sendemail.cc &&
 	test_suppression sob
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-cccmd <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -416,6 +432,7 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ 'sendemail.cccmd' '
 	echo echo cc-cmd@example.com > cccmd &&
@@ -424,6 +441,7 @@ test_expect_success $PREREQ 'sendemail.cccmd' '
 	test_suppression cccmd
 '
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >expected-suppress-all <<\EOF
 0001-Second.patch
 Dry-OK. Log says:
@@ -439,11 +457,13 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+'
=20
 test_expect_success $PREREQ '--suppress-cc=3Dall' '
 	test_suppression all
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-body <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -471,11 +491,13 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ '--suppress-cc=3Dbody' '
 	test_suppression body
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-body-cccmd <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -500,11 +522,13 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ '--suppress-cc=3Dbody --suppress-cc=3Dcccm=
d' '
 	test_suppression body cccmd
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -529,12 +553,14 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ '--suppress-cc=3Dsob' '
 	git config --unset sendemail.cccmd
 	test_suppression sob
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-bodycc <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -562,11 +588,13 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ '--suppress-cc=3Dbodycc' '
 	test_suppression bodycc
 '
=20
+test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-cc <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@ex=
ample.com>'
@@ -588,6 +616,7 @@ X-Mailer: X-MAILER-STRING
=20
 Result: OK
 EOF
+"
=20
 test_expect_success $PREREQ '--suppress-cc=3Dcc' '
 	test_suppression cc
@@ -918,6 +947,7 @@ test_expect_success $PREREQ '--no-bcc overrides sen=
demail.bcc' '
 	! grep "RCPT TO:<other@ex.com>" stdout
 '
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >email-using-8bit <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 Message-Id: <bogus-message-id@example.com>
@@ -927,12 +957,15 @@ Subject: subject goes here
=20
 Dieser deutsche Text enth=C3=A4lt einen Umlaut!
 EOF
+'
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >content-type-decl <<EOF
 MIME-Version: 1.0
 Content-Type: text/plain; charset=3DUTF-8
 Content-Transfer-Encoding: 8bit
 EOF
+'
=20
 test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	clean_fake_sendmail &&
@@ -970,6 +1003,7 @@ test_expect_success $PREREQ '--8bit-encoding overr=
ides sendemail.8bitEncoding' '
 	test_cmp actual content-type-decl
 '
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >email-using-8bit <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 Message-Id: <bogus-message-id@example.com>
@@ -979,10 +1013,13 @@ Subject: Dieser Betreff enth=C3=A4lt auch einen =
Umlaut!
=20
 Nothing to see here.
 EOF
+'
=20
+test_expect_success $PREREQ 'setup expect' '
 cat >expected <<EOF
 Subject: =3D?UTF-8?q?Dieser=3D20Betreff=3D20enth=3DC3=3DA4lt=3D20auch=3D=
20einen=3D20Umlaut!?=3D
 EOF
+'
=20
 test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 	clean_fake_sendmail &&
--=20
1.7.2.1.338.gf2379
