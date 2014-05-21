From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 4/5] t4205, t6006: Add failing tests for the case when i18n.logOutputEncoding is set
Date: Wed, 21 May 2014 17:20:06 +0400
Message-ID: <12b22fd98d687b0484d7d5e5f122d770ca56908d.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400678003.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 15:20:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn6Rx-0002Hb-6c
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 15:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbaEUNUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2014 09:20:48 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59206 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbaEUNUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 09:20:46 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so1558848lbi.19
        for <git@vger.kernel.org>; Wed, 21 May 2014 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=+UcrYfYfDsnIUsZbvOCEbosow21ZmPqQTEbbPFc0bQM=;
        b=PMCqzqBQlmdBELzPfT0bO8AmvUugJblsG8tGmQJ3HBdltEYAZQA9uGVbacWYrckpil
         +FCyPZlFjp/PGCROMFCcDZSQMgw4afgDtqELboiOemzKWLuJLM5cy+xBZJbDZGya+EAh
         rYM4OnRgON5mbD6c5kZj3pZlBDWrc3MCc8Jsl+xcY8x+Ft9uSg8nz+Ob0qdFxqsUy4Wb
         zCTiQu0D5XrHPbly35C6ej3wybwQd3EzgA5JKTw/3JXqy4gQBvvtduhDgp/Fwen7lDxZ
         xErviDBV0RDutRqBgTS032w8TpBSO1daAqHF9WhQ9x4mstOZLHgdbtQrPpF1qsaQe3yT
         7Oag==
X-Received: by 10.152.29.200 with SMTP id m8mr17948987lah.49.1400678445077;
        Wed, 21 May 2014 06:20:45 -0700 (PDT)
Received: from localhost (ppp91-77-196-183.pppoe.mtu-net.ru. [91.77.196.183])
        by mx.google.com with ESMTPSA id ui5sm1790707lbb.32.2014.05.21.06.20.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 06:20:44 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com> <cover.1400678003.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249798>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

There were no breakages as far as were no tests for the case
when both a commit message and logOutputEncoding are not UTF-8.

Add failing tests for that which will be fixed in the next patch.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
Reviewed-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t4205-log-pretty-formats.sh | 140 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t6006-rev-list-format.sh    |  75 +++++++++++++++++++++-
 2 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index c03a65e..74babce 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -154,6 +154,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting. i18n.logOutputEncoding=
' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two                            Z
+message one                            Z
+add bar                                Z
+$(commit_msg)                    Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting at the nth column' '
 	git log --pretty=3D"tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -165,6 +176,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting at the nth column. i18n=
=2ElogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%h %<|(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+$head1 message two                    Z
+$head2 message one                    Z
+$head3 add bar                        Z
+$head4 $(commit_msg)            Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty=3D"tformat:%<(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -176,6 +198,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting with no padding. i18n.l=
ogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(1)%s" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with trunc' '
 	git log --pretty=3D"tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -187,6 +220,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message ..
+message ..
+add bar  Z
+initial...
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with ltrunc' '
 	git log --pretty=3D"tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -198,6 +242,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,ltrunc)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+..sage two
+..sage one
+add bar  Z
+..${sample_utf8_part}lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with mtrunc' '
 	git log --pretty=3D"tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -209,6 +264,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,mtrunc)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+mess.. two
+mess.. one
+add bar  Z
+init..lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting' '
 	git log --pretty=3D"tformat:%>(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -220,6 +286,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting. i18n.logOutputEncodin=
g' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%>(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+Z                            message two
+Z                            message one
+Z                                add bar
+Z                    $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting at the nth column' '
 	git log --pretty=3D"tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -231,6 +308,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting at the nth column. i18=
n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%h %>|(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+$head1                      message two
+$head2                      message one
+$head3                          add bar
+$head4              $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty=3D"tformat:%>(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -242,6 +330,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting with no padding. i18n.=
logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%>(1)%s" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting' '
 	git log --pretty=3D"tformat:%><(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -253,6 +352,16 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'center alignment formatting. i18n.logOutputEncodi=
ng' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%><(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+Z             message two              Z
+Z             message one              Z
+Z               add bar                Z
+Z         $(commit_msg)          Z
+EOF
+	test_cmp expected actual
+'
 test_expect_success 'center alignment formatting at the nth column' '
 	git log --pretty=3D"tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
@@ -264,6 +373,17 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'center alignment formatting at the nth column. i1=
8n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%h %><|(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+$head1           message two          Z
+$head2           message one          Z
+$head3             add bar            Z
+$head4       $(commit_msg)      Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty=3D"tformat:%><(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -278,6 +398,16 @@ EOF
 # save HEAD's SHA-1 digest (with no abbreviations) to use it below
 # as far as the next test amends HEAD
 old_head1=3D$(git rev-parse --verify HEAD~0)
+test_expect_success 'center alignment formatting with no padding. i18n=
=2ElogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%><(1)%s" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
=20
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &=
&
@@ -290,6 +420,16 @@ initial...   A U Thor
 EOF
 	test_cmp expected actual
 '
+test_expect_failure 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
+	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+short long  long long
+message ..   A U Thor
+add bar      A U Thor
+initial...   A U Thor
+EOF
+	test_cmp expected actual
+'
=20
 # get new digests (with no abbreviations)
 head1=3D$(git rev-parse --verify HEAD~0) &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9e4ba62..42bdefe 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -15,12 +15,22 @@ test_encoding=3D"ISO8859-1"
 # String "added" in German
 # (translated with Google Translate),
 # encoded in UTF-8, used as a commit log message below.
-added=3D$(printf "added (hinzugef\303\274gt) foo")
+added_utf8_part=3D$(printf "\303\274")
+added_utf8_part_iso88591=3D$(echo "$added_utf8_part" | iconv -f utf-8 =
-t $test_encoding)
+added=3D$(printf "added (hinzugef${added_utf8_part}gt) foo")
 added_iso88591=3D$(echo "$added" | iconv -f utf-8 -t $test_encoding)
 # same but "changed"
-changed=3D$(printf "changed (ge\303\244ndert) foo")
+changed_utf8_part=3D$(printf "\303\244")
+changed_utf8_part_iso88591=3D$(echo "$changed_utf8_part" | iconv -f ut=
f-8 -t $test_encoding)
+changed=3D$(printf "changed (ge${changed_utf8_part}ndert) foo")
 changed_iso88591=3D$(echo "$changed" | iconv -f utf-8 -t $test_encodin=
g)
=20
+# Count of char to truncate
+# Number is chosen so, that non-ACSII characters
+# (see $added_utf8_part and $changed_utf8_part)
+# fall into truncated parts of appropriate words both from left and ri=
ght
+truncate_count=3D20
+
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
@@ -139,6 +149,13 @@ commit $head1
 $added
 EOF
=20
+test_format subject-truncated "%<($truncate_count,trunc)%s" <<EOF
+commit $head2
+changed (ge${changed_utf8_part}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part}gt..
+EOF
+
 test_format body %b <<EOF
 commit $head2
 commit $head1
@@ -242,6 +259,33 @@ commit $head1
 $added_iso88591
 EOF
=20
+test_format complex-subject-trunc "%<($truncate_count,trunc)%s" failur=
e <<EOF
+commit $head3
+Test printing of c..
+commit $head2
+changed (ge${changed_utf8_part_iso88591}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part_iso88591}gt..
+EOF
+
+test_format complex-subject-mtrunc "%<($truncate_count,mtrunc)%s" fail=
ure <<EOF
+commit $head3
+Test prin..ex bodies
+commit $head2
+changed (..dert) foo
+commit $head1
+added (hi..f${added_utf8_part_iso88591}gt) foo
+EOF
+
+test_format complex-subject-ltrunc "%<($truncate_count,ltrunc)%s" fail=
ure <<EOF
+commit $head3
+.. of complex bodies
+commit $head2
+..ged (ge${changed_utf8_part_iso88591}ndert) foo
+commit $head1
+.. (hinzugef${added_utf8_part_iso88591}gt) foo
+EOF
+
 test_expect_success 'prepare expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
@@ -270,6 +314,33 @@ commit $head1
 $added
 EOF
=20
+test_format complex-subject-commitencoding-unset-trunc "%<($truncate_c=
ount,trunc)%s" <<EOF
+commit $head3
+Test printing of c..
+commit $head2
+changed (ge${changed_utf8_part}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part}gt..
+EOF
+
+test_format complex-subject-commitencoding-unset-mtrunc "%<($truncate_=
count,mtrunc)%s" <<EOF
+commit $head3
+Test prin..ex bodies
+commit $head2
+changed (..dert) foo
+commit $head1
+added (hi..f${added_utf8_part}gt) foo
+EOF
+
+test_format complex-subject-commitencoding-unset-ltrunc "%<($truncate_=
count,ltrunc)%s" <<EOF
+commit $head3
+.. of complex bodies
+commit $head2
+..ged (ge${changed_utf8_part}ndert) foo
+commit $head1
+.. (hinzugef${added_utf8_part}gt) foo
+EOF
+
 test_format complex-body-commitencoding-unset %b <expected.utf-8
=20
 test_expect_success '%x00 shows NUL' '
--=20
1.9.2-15
