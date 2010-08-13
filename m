From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/10] t/t9001-send-email.sh: change from skip_all=* to prereq skip
Date: Fri, 13 Aug 2010 20:40:09 +0000
Message-ID: <1281732013-18284-7-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok148-0007V9-7u
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab0HMUlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab0HMUlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:09 -0400
Received: by mail-wy0-f174.google.com with SMTP id 32so3042025wyb.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0b5etwMbcg1oMX3ppRmSOHmsI9ErIaditOWPNlzGI2g=;
        b=a1SxWDzFfcheQe9e/ovZ4HMng1EpQ7rhLbk2IrUOsMiXu3hnlAZFbjL4LgoTJ7Sc7q
         J/SyyP6Pod8JixXnhSk30pke9PIhN23KA6BmBE3+j5odzG4FjCoCn00ihUqZFssymaTR
         13+EJduAsSVxOT/TGiW3+zgoRYk5FWxJAbKIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L5bkXxVtZB+YW6QA2yo9mxI7TabCsH5ytRcGlNTeE7eSYKAW2EVuXbgDsHeihIfzId
         M2MJPMQdbJMmb1ub2L5FJsYsHIm5sv/E6EuEMp3sVy2YAeHf7MteFMwOViJug+r9Gtcu
         N31QicpsUddci3tTJ05DAufMyzUOb6RPaaKzo=
Received: by 10.216.154.133 with SMTP id h5mr1674820wek.93.1281732068251;
        Fri, 13 Aug 2010 13:41:08 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.41.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:41:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153494>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9001-send-email.sh |  165 +++++++++++++++++++++++++----------------=
--------
 1 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6525d1d..bd17d31 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -3,19 +3,17 @@
 test_description=3D'git send-email'
 . ./test-lib.sh
=20
-if ! test_have_prereq PERL; then
-	skip_all=3D'skipping git send-email tests, perl not available'
-	test_done
-fi
+# May be altered later in the test
+PREREQ=3D"PERL"
=20
-test_expect_success \
+test_expect_success $PREREQ \
     'prepare reference tree' \
     'echo "1A quick brown fox jumps over the" >file &&
      echo "lazy dog" >>file &&
      git add file &&
      GIT_AUTHOR_NAME=3D"A" git commit -a -m "Initial."'
=20
-test_expect_success \
+test_expect_success $PREREQ \
     'Setup helper tool' \
     '(echo "#!$SHELL_PATH"
       echo shift
@@ -35,7 +33,7 @@ clean_fake_sendmail() {
 	rm -f commandline* msgtxt*
 }
=20
-test_expect_success 'Extract patches' '
+test_expect_success $PREREQ 'Extract patches' '
     patches=3D`git format-patch -s --cc=3D"One <one@example.com>" --cc=
=3Dtwo@example.com -n HEAD^1`
 '
=20
@@ -56,31 +54,34 @@ test_no_confirm () {
=20
 # Exit immediately to prevent hang if a no-confirm test fails
 check_no_confirm () {
-	test -f no_confirm_okay || {
-		skip_all=3D'confirm test failed; skipping remaining tests to prevent=
 hanging'
-		test_done
-	}
+	if ! test -f no_confirm_okay
+	then
+		say 'confirm test failed; skipping remaining tests to prevent hangin=
g'
+		PREREQ=3D"$PREREQ,CHECK_NO_CONFIRM"
+	fi
+	return 0
 }
=20
-test_expect_success 'No confirm with --suppress-cc' '
-	test_no_confirm --suppress-cc=3Dsob
+test_expect_success $PREREQ 'No confirm with --suppress-cc' '
+	test_no_confirm --suppress-cc=3Dsob &&
+	check_no_confirm
 '
-check_no_confirm
=20
-test_expect_success 'No confirm with --confirm=3Dnever' '
-	test_no_confirm --confirm=3Dnever
+
+test_expect_success $PREREQ 'No confirm with --confirm=3Dnever' '
+	test_no_confirm --confirm=3Dnever &&
+	check_no_confirm
 '
-check_no_confirm
=20
 # leave sendemail.confirm set to never after this so that none of the
 # remaining tests prompt unintentionally.
-test_expect_success 'No confirm with sendemail.confirm=3Dnever' '
+test_expect_success $PREREQ 'No confirm with sendemail.confirm=3Dnever=
' '
 	git config sendemail.confirm never &&
-	test_no_confirm --compose --subject=3Dfoo
+	test_no_confirm --compose --subject=3Dfoo &&
+	check_no_confirm
 '
-check_no_confirm
=20
-test_expect_success 'Send patches' '
+test_expect_success $PREREQ 'Send patches' '
      git send-email --suppress-cc=3Dsob --from=3D"Example <nobody@exam=
ple.com>" --to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake.sendma=
il" $patches 2>errors
 '
=20
@@ -90,11 +91,11 @@ cat >expected <<\EOF
 !one@example.com!
 !two@example.com!
 EOF
-test_expect_success \
+test_expect_success $PREREQ \
     'Verify commandline' \
     'test_cmp expected commandline1'
=20
-test_expect_success 'Send patches with --envelope-sender' '
+test_expect_success $PREREQ 'Send patches with --envelope-sender' '
     clean_fake_sendmail &&
      git send-email --envelope-sender=3D"Patch Contributer <patch@exam=
ple.com>" --suppress-cc=3Dsob --from=3D"Example <nobody@example.com>" -=
-to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake.sendmail" $patche=
s 2>errors
 '
@@ -107,11 +108,11 @@ cat >expected <<\EOF
 !one@example.com!
 !two@example.com!
 EOF
-test_expect_success \
+test_expect_success $PREREQ \
     'Verify commandline' \
     'test_cmp expected commandline1'
=20
-test_expect_success 'Send patches with --envelope-sender=3Dauto' '
+test_expect_success $PREREQ 'Send patches with --envelope-sender=3Daut=
o' '
     clean_fake_sendmail &&
      git send-email --envelope-sender=3Dauto --suppress-cc=3Dsob --fro=
m=3D"Example <nobody@example.com>" --to=3Dnobody@example.com --smtp-ser=
ver=3D"$(pwd)/fake.sendmail" $patches 2>errors
 '
@@ -124,7 +125,7 @@ cat >expected <<\EOF
 !one@example.com!
 !two@example.com!
 EOF
-test_expect_success \
+test_expect_success $PREREQ \
     'Verify commandline' \
     'test_cmp expected commandline1'
=20
@@ -158,7 +159,7 @@ References: <unique-message-id@example.com>
 Result: OK
 EOF
=20
-test_expect_success 'Show all headers' '
+test_expect_success $PREREQ 'Show all headers' '
 	git send-email \
 		--dry-run \
 		--suppress-cc=3Dsob \
@@ -176,7 +177,7 @@ test_expect_success 'Show all headers' '
 	test_cmp expected-show-all-headers actual-show-all-headers
 '
=20
-test_expect_success 'Prompting works' '
+test_expect_success $PREREQ 'Prompting works' '
 	clean_fake_sendmail &&
 	(echo "Example <from@example.com>"
 	 echo "to@example.com"
@@ -189,7 +190,7 @@ test_expect_success 'Prompting works' '
 		grep "^To: to@example.com\$" msgtxt1
 '
=20
-test_expect_success 'cccmd works' '
+test_expect_success $PREREQ 'cccmd works' '
 	clean_fake_sendmail &&
 	cp $patches cccmd.patch &&
 	echo cccmd--cccmd@example.com >>cccmd.patch &&
@@ -211,7 +212,7 @@ test_expect_success 'cccmd works' '
 z8=3Dzzzzzzzz
 z64=3D$z8$z8$z8$z8$z8$z8$z8$z8
 z512=3D$z64$z64$z64$z64$z64$z64$z64$z64
-test_expect_success 'reject long lines' '
+test_expect_success $PREREQ 'reject long lines' '
 	clean_fake_sendmail &&
 	cp $patches longline.patch &&
 	echo $z512$z512 >>longline.patch &&
@@ -224,11 +225,11 @@ test_expect_success 'reject long lines' '
 	grep longline.patch errors
 '
=20
-test_expect_success 'no patch was sent' '
+test_expect_success $PREREQ 'no patch was sent' '
 	! test -e commandline1
 '
=20
-test_expect_success 'Author From: in message body' '
+test_expect_success $PREREQ 'Author From: in message body' '
 	clean_fake_sendmail &&
 	git send-email \
 		--from=3D"Example <nobody@example.com>" \
@@ -239,7 +240,7 @@ test_expect_success 'Author From: in message body' =
'
 	grep "From: A <author@example.com>" msgbody1
 '
=20
-test_expect_success 'Author From: not in message body' '
+test_expect_success $PREREQ 'Author From: not in message body' '
 	clean_fake_sendmail &&
 	git send-email \
 		--from=3D"A <author@example.com>" \
@@ -250,7 +251,7 @@ test_expect_success 'Author From: not in message bo=
dy' '
 	! grep "From: A <author@example.com>" msgbody1
 '
=20
-test_expect_success 'allow long lines with --no-validate' '
+test_expect_success $PREREQ 'allow long lines with --no-validate' '
 	git send-email \
 		--from=3D"Example <nobody@example.com>" \
 		--to=3Dnobody@example.com \
@@ -260,7 +261,7 @@ test_expect_success 'allow long lines with --no-val=
idate' '
 		2>errors
 '
=20
-test_expect_success 'Invalid In-Reply-To' '
+test_expect_success $PREREQ 'Invalid In-Reply-To' '
 	clean_fake_sendmail &&
 	git send-email \
 		--from=3D"Example <nobody@example.com>" \
@@ -272,7 +273,7 @@ test_expect_success 'Invalid In-Reply-To' '
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
=20
-test_expect_success 'Valid In-Reply-To when prompting' '
+test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	clean_fake_sendmail &&
 	(echo "From Example <from@example.com>"
 	 echo "To Example <to@example.com>"
@@ -283,7 +284,7 @@ test_expect_success 'Valid In-Reply-To when prompti=
ng' '
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
=20
-test_expect_success 'setup fake editor' '
+test_expect_success $PREREQ 'setup fake editor' '
 	(echo "#!$SHELL_PATH" &&
 	 echo "echo fake edit >>\"\$1\""
 	) >fake-editor &&
@@ -292,7 +293,7 @@ test_expect_success 'setup fake editor' '
=20
 test_set_editor "$(pwd)/fake-editor"
=20
-test_expect_success '--compose works' '
+test_expect_success $PREREQ '--compose works' '
 	clean_fake_sendmail &&
 	git send-email \
 	--compose --subject foo \
@@ -303,11 +304,11 @@ test_expect_success '--compose works' '
 	2>errors
 '
=20
-test_expect_success 'first message is compose text' '
+test_expect_success $PREREQ 'first message is compose text' '
 	grep "^fake edit" msgtxt1
 '
=20
-test_expect_success 'second message is patch' '
+test_expect_success $PREREQ 'second message is patch' '
 	grep "Subject:.*Second" msgtxt2
 '
=20
@@ -353,7 +354,7 @@ test_suppression () {
 	test_cmp expected-suppress-$1${2+"-$2"} actual-suppress-$1${2+"-$2"}
 }
=20
-test_expect_success 'sendemail.cc set' '
+test_expect_success $PREREQ 'sendemail.cc set' '
 	git config sendemail.cc cc@example.com &&
 	test_suppression sob
 '
@@ -383,7 +384,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success 'sendemail.cc unset' '
+test_expect_success $PREREQ 'sendemail.cc unset' '
 	git config --unset sendemail.cc &&
 	test_suppression sob
 '
@@ -416,7 +417,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success 'sendemail.cccmd' '
+test_expect_success $PREREQ 'sendemail.cccmd' '
 	echo echo cc-cmd@example.com > cccmd &&
 	chmod +x cccmd &&
 	git config sendemail.cccmd ./cccmd &&
@@ -439,7 +440,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success '--suppress-cc=3Dall' '
+test_expect_success $PREREQ '--suppress-cc=3Dall' '
 	test_suppression all
 '
=20
@@ -471,7 +472,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success '--suppress-cc=3Dbody' '
+test_expect_success $PREREQ '--suppress-cc=3Dbody' '
 	test_suppression body
 '
=20
@@ -500,7 +501,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success '--suppress-cc=3Dbody --suppress-cc=3Dcccmd' '
+test_expect_success $PREREQ '--suppress-cc=3Dbody --suppress-cc=3Dcccm=
d' '
 	test_suppression body cccmd
 '
=20
@@ -529,7 +530,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success '--suppress-cc=3Dsob' '
+test_expect_success $PREREQ '--suppress-cc=3Dsob' '
 	git config --unset sendemail.cccmd
 	test_suppression sob
 '
@@ -562,7 +563,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success '--suppress-cc=3Dbodycc' '
+test_expect_success $PREREQ '--suppress-cc=3Dbodycc' '
 	test_suppression bodycc
 '
=20
@@ -588,7 +589,7 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
=20
-test_expect_success '--suppress-cc=3Dcc' '
+test_expect_success $PREREQ '--suppress-cc=3Dcc' '
 	test_suppression cc
 '
=20
@@ -603,23 +604,23 @@ test_confirm () {
 	grep "Send this email" stdout
 }
=20
-test_expect_success '--confirm=3Dalways' '
+test_expect_success $PREREQ '--confirm=3Dalways' '
 	test_confirm --confirm=3Dalways --suppress-cc=3Dall
 '
=20
-test_expect_success '--confirm=3Dauto' '
+test_expect_success $PREREQ '--confirm=3Dauto' '
 	test_confirm --confirm=3Dauto
 '
=20
-test_expect_success '--confirm=3Dcc' '
+test_expect_success $PREREQ '--confirm=3Dcc' '
 	test_confirm --confirm=3Dcc
 '
=20
-test_expect_success '--confirm=3Dcompose' '
+test_expect_success $PREREQ '--confirm=3Dcompose' '
 	test_confirm --confirm=3Dcompose --compose
 '
=20
-test_expect_success 'confirm by default (due to cc)' '
+test_expect_success $PREREQ 'confirm by default (due to cc)' '
 	CONFIRM=3D$(git config --get sendemail.confirm) &&
 	git config --unset sendemail.confirm &&
 	test_confirm
@@ -628,7 +629,7 @@ test_expect_success 'confirm by default (due to cc)=
' '
 	test $ret =3D "0"
 '
=20
-test_expect_success 'confirm by default (due to --compose)' '
+test_expect_success $PREREQ 'confirm by default (due to --compose)' '
 	CONFIRM=3D$(git config --get sendemail.confirm) &&
 	git config --unset sendemail.confirm &&
 	test_confirm --suppress-cc=3Dall --compose
@@ -637,7 +638,7 @@ test_expect_success 'confirm by default (due to --c=
ompose)' '
 	test $ret =3D "0"
 '
=20
-test_expect_success 'confirm detects EOF (inform assumes y)' '
+test_expect_success $PREREQ 'confirm detects EOF (inform assumes y)' '
 	CONFIRM=3D$(git config --get sendemail.confirm) &&
 	git config --unset sendemail.confirm &&
 	rm -fr outdir &&
@@ -653,7 +654,7 @@ test_expect_success 'confirm detects EOF (inform as=
sumes y)' '
 	test $ret =3D "0"
 '
=20
-test_expect_success 'confirm detects EOF (auto causes failure)' '
+test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)=
' '
 	CONFIRM=3D$(git config --get sendemail.confirm) &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=3D1 &&
@@ -668,7 +669,7 @@ test_expect_success 'confirm detects EOF (auto caus=
es failure)' '
 	test $ret =3D "0"
 '
=20
-test_expect_success 'confirm doesnt loop forever' '
+test_expect_success $PREREQ 'confirm doesnt loop forever' '
 	CONFIRM=3D$(git config --get sendemail.confirm) &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=3D1 &&
@@ -683,7 +684,7 @@ test_expect_success 'confirm doesnt loop forever' '
 	test $ret =3D "0"
 '
=20
-test_expect_success 'utf8 Cc is rfc2047 encoded' '
+test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
 	clean_fake_sendmail &&
 	rm -fr outdir &&
 	git format-patch -1 -o outdir --cc=3D"=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA =
<utf8@example.com>" &&
@@ -696,7 +697,7 @@ test_expect_success 'utf8 Cc is rfc2047 encoded' '
 	grep "=3D?UTF-8?q?=3DC3=3DA0=3DC3=3DA9=3DC3=3DAC=3DC3=3DB6=3DC3=3DBA?=
=3D <utf8@example.com>"
 '
=20
-test_expect_success '--compose adds MIME for utf8 body' '
+test_expect_success $PREREQ '--compose adds MIME for utf8 body' '
 	clean_fake_sendmail &&
 	(echo "#!$SHELL_PATH" &&
 	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\"\$1\""
@@ -713,7 +714,7 @@ test_expect_success '--compose adds MIME for utf8 b=
ody' '
 	grep "^Content-Type: text/plain; charset=3DUTF-8" msgtxt1
 '
=20
-test_expect_success '--compose respects user mime type' '
+test_expect_success $PREREQ '--compose respects user mime type' '
 	clean_fake_sendmail &&
 	(echo "#!$SHELL_PATH" &&
 	 echo "(echo MIME-Version: 1.0"
@@ -736,7 +737,7 @@ test_expect_success '--compose respects user mime t=
ype' '
 	! grep "^Content-Type: text/plain; charset=3DUTF-8" msgtxt1
 '
=20
-test_expect_success '--compose adds MIME for utf8 subject' '
+test_expect_success $PREREQ '--compose adds MIME for utf8 subject' '
 	clean_fake_sendmail &&
 	  GIT_EDITOR=3D"\"$(pwd)/fake-editor\"" \
 	  git send-email \
@@ -749,7 +750,7 @@ test_expect_success '--compose adds MIME for utf8 s=
ubject' '
 	grep "^Subject: =3D?UTF-8?q?utf8-s=3DC3=3DBCbj=3DC3=3DABct?=3D" msgtx=
t1
 '
=20
-test_expect_success 'detects ambiguous reference/file conflict' '
+test_expect_success $PREREQ 'detects ambiguous reference/file conflict=
' '
 	echo master > master &&
 	git add master &&
 	git commit -m"add master" &&
@@ -757,7 +758,7 @@ test_expect_success 'detects ambiguous reference/fi=
le conflict' '
 	grep disambiguate errors
 '
=20
-test_expect_success 'feed two files' '
+test_expect_success $PREREQ 'feed two files' '
 	rm -fr outdir &&
 	git format-patch -2 -o outdir &&
 	git send-email \
@@ -770,7 +771,7 @@ test_expect_success 'feed two files' '
 	test "z$(sed -n -e 2p subjects)" =3D "zSubject: [PATCH 2/2] add maste=
r"
 '
=20
-test_expect_success 'in-reply-to but no threading' '
+test_expect_success $PREREQ 'in-reply-to but no threading' '
 	git send-email \
 		--dry-run \
 		--from=3D"Example <nobody@example.com>" \
@@ -781,7 +782,7 @@ test_expect_success 'in-reply-to but no threading' =
'
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
=20
-test_expect_success 'no in-reply-to and no threading' '
+test_expect_success $PREREQ 'no in-reply-to and no threading' '
 	git send-email \
 		--dry-run \
 		--from=3D"Example <nobody@example.com>" \
@@ -791,7 +792,7 @@ test_expect_success 'no in-reply-to and no threadin=
g' '
 	! grep "In-Reply-To: " stdout
 '
=20
-test_expect_success 'threading but no chain-reply-to' '
+test_expect_success $PREREQ 'threading but no chain-reply-to' '
 	git send-email \
 		--dry-run \
 		--from=3D"Example <nobody@example.com>" \
@@ -802,7 +803,7 @@ test_expect_success 'threading but no chain-reply-t=
o' '
 	grep "In-Reply-To: " stdout
 '
=20
-test_expect_success 'warning with an implicit --chain-reply-to' '
+test_expect_success $PREREQ 'warning with an implicit --chain-reply-to=
' '
 	git send-email \
 	--dry-run \
 	--from=3D"Example <nobody@example.com>" \
@@ -811,7 +812,7 @@ test_expect_success 'warning with an implicit --cha=
in-reply-to' '
 	grep "no-chain-reply-to" errors
 '
=20
-test_expect_success 'no warning with an explicit --chain-reply-to' '
+test_expect_success $PREREQ 'no warning with an explicit --chain-reply=
-to' '
 	git send-email \
 	--dry-run \
 	--from=3D"Example <nobody@example.com>" \
@@ -821,7 +822,7 @@ test_expect_success 'no warning with an explicit --=
chain-reply-to' '
 	! grep "no-chain-reply-to" errors
 '
=20
-test_expect_success 'no warning with an explicit --no-chain-reply-to' =
'
+test_expect_success $PREREQ 'no warning with an explicit --no-chain-re=
ply-to' '
 	git send-email \
 	--dry-run \
 	--from=3D"Example <nobody@example.com>" \
@@ -831,7 +832,7 @@ test_expect_success 'no warning with an explicit --=
no-chain-reply-to' '
 	! grep "no-chain-reply-to" errors
 '
=20
-test_expect_success 'no warning with sendemail.chainreplyto =3D false'=
 '
+test_expect_success $PREREQ 'no warning with sendemail.chainreplyto =3D=
 false' '
 	git config sendemail.chainreplyto false &&
 	git send-email \
 	--dry-run \
@@ -841,7 +842,7 @@ test_expect_success 'no warning with sendemail.chai=
nreplyto =3D false' '
 	! grep "no-chain-reply-to" errors
 '
=20
-test_expect_success 'no warning with sendemail.chainreplyto =3D true' =
'
+test_expect_success $PREREQ 'no warning with sendemail.chainreplyto =3D=
 true' '
 	git config sendemail.chainreplyto true &&
 	git send-email \
 	--dry-run \
@@ -851,7 +852,7 @@ test_expect_success 'no warning with sendemail.chai=
nreplyto =3D true' '
 	! grep "no-chain-reply-to" errors
 '
=20
-test_expect_success 'sendemail.to works' '
+test_expect_success $PREREQ 'sendemail.to works' '
 	git config --replace-all sendemail.to "Somebody <somebody@ex.com>" &&
 	git send-email \
 		--dry-run \
@@ -860,7 +861,7 @@ test_expect_success 'sendemail.to works' '
 	grep "To: Somebody <somebody@ex.com>" stdout
 '
=20
-test_expect_success '--no-to overrides sendemail.to' '
+test_expect_success $PREREQ '--no-to overrides sendemail.to' '
 	git send-email \
 		--dry-run \
 		--from=3D"Example <nobody@example.com>" \
@@ -871,7 +872,7 @@ test_expect_success '--no-to overrides sendemail.to=
' '
 	! grep "To: Somebody <somebody@ex.com>" stdout
 '
=20
-test_expect_success 'sendemail.cc works' '
+test_expect_success $PREREQ 'sendemail.cc works' '
 	git config --replace-all sendemail.cc "Somebody <somebody@ex.com>" &&
 	git send-email \
 		--dry-run \
@@ -881,7 +882,7 @@ test_expect_success 'sendemail.cc works' '
 	grep "Cc: Somebody <somebody@ex.com>" stdout
 '
=20
-test_expect_success '--no-cc overrides sendemail.cc' '
+test_expect_success $PREREQ '--no-cc overrides sendemail.cc' '
 	git send-email \
 		--dry-run \
 		--from=3D"Example <nobody@example.com>" \
@@ -893,7 +894,7 @@ test_expect_success '--no-cc overrides sendemail.cc=
' '
 	! grep "Cc: Somebody <somebody@ex.com>" stdout
 '
=20
-test_expect_success 'sendemail.bcc works' '
+test_expect_success $PREREQ 'sendemail.bcc works' '
 	git config --replace-all sendemail.bcc "Other <other@ex.com>" &&
 	git send-email \
 		--dry-run \
@@ -904,7 +905,7 @@ test_expect_success 'sendemail.bcc works' '
 	grep "RCPT TO:<other@ex.com>" stdout
 '
=20
-test_expect_success '--no-bcc overrides sendemail.bcc' '
+test_expect_success $PREREQ '--no-bcc overrides sendemail.bcc' '
 	git send-email \
 		--dry-run \
 		--from=3D"Example <nobody@example.com>" \
@@ -933,7 +934,7 @@ Content-Type: text/plain; charset=3DUTF-8
 Content-Transfer-Encoding: 8bit
 EOF
=20
-test_expect_success 'asks about and fixes 8bit encodings' '
+test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	clean_fake_sendmail &&
 	echo |
 	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
@@ -946,7 +947,7 @@ test_expect_success 'asks about and fixes 8bit enco=
dings' '
 	test_cmp actual content-type-decl
 '
=20
-test_expect_success 'sendemail.8bitEncoding works' '
+test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.assume8bitEncoding UTF-8 &&
 	echo bogus |
@@ -957,7 +958,7 @@ test_expect_success 'sendemail.8bitEncoding works' =
'
 	test_cmp actual content-type-decl
 '
=20
-test_expect_success '--8bit-encoding overrides sendemail.8bitEncoding'=
 '
+test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitE=
ncoding' '
 	clean_fake_sendmail &&
 	git config sendemail.assume8bitEncoding "bogus too" &&
 	echo bogus |
@@ -983,7 +984,7 @@ cat >expected <<EOF
 Subject: =3D?UTF-8?q?Dieser=3D20Betreff=3D20enth=3DC3=3DA4lt=3D20auch=3D=
20einen=3D20Umlaut!?=3D
 EOF
=20
-test_expect_success '--8bit-encoding also treats subject' '
+test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 	clean_fake_sendmail &&
 	echo bogus |
 	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
--=20
1.7.2.1.338.gf2379
