From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: =?y?q?=5BPATCHv3=206/6=5D=20Tests=20of=20UTF8=20character=20with=20git-remote-mediawiki?=
Date: Mon, 11 Jun 2012 22:28:46 +0200
Message-ID: <1339446526-22397-6-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <4FD654C8.6040208@ensimag.imag.fr>
 <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: simon.cathebras@ensimag.imag.fr, Matthieu.Moy@imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, gitster@pobox.com, peff@peff.net,
	Simon.Perrat@ensimag.imag.fr,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 22:29:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBF3-0007dt-5j
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab2FKU3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 16:29:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42525 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248Ab2FKU3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:29:33 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BKKArm010824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 22:20:10 +0200
Received: from Hithlum.crous-grenoble.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BKSkIY022262;
	Mon, 11 Jun 2012 22:29:15 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 22:20:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BKKArm010824
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340050815.72887@eCxU5LIvyMEK9IeJkeq+dA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199724>

=46rom: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

This patch provides a sample of tests for git-remote-mediawiki's
resistance, concerning utf8 special characters.

The sample of tests is located in the file
git/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
---
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh | 377 ++++++++++++++++++++=
++++++++
 1 file changed, 377 insertions(+)
 create mode 100755 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh

diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-t=
o-git/t/t9362-mw-to-git-utf8.sh
new file mode 100755
index 0000000..57431da
--- /dev/null
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -0,0 +1,377 @@
+#!/bin/sh
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#
+# License: GPL v2 or later
+
+# tests for git-remote-mediawiki
+
+test_description=3D'Test git-mediawiki with special characters in file=
names'
+
+. ./test-gitmw-lib.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+TRASH_DIR=3D"$CURR_DIR/trash\ directory.$(basename $0 .sh)"
+
+if ! test_have_prereq PERL
+then
+	skip_all=3D'skipping gateway git-mw tests, '\
+		'perl not available'
+	test_done
+fi
+
+if [ ! -f $GIT_BUILD_DIR/git-remote-mediawiki ];
+then
+	skip_all=3D'skipping gateway git-mw tests,' \
+		' no remote mediawiki for git found'
+	test_done
+fi
+
+if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ;
+then
+	skip_all=3D'skipping gateway git-mw tests, no mediawiki found'
+	test_done
+fi
+
+
+# 1
+test_expect_success 'Git clone works for a wiki with accents in the pa=
ge names' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage f=C3=A9=C3=A9 "This page must be d=C3=A9l=C3=A9t=C3=A9d=
 before clone" false &&
+	wiki_editpage k=C3=A8=C3=A8 "This page must be deleted before clone" =
false &&
+	wiki_editpage h=C3=A0=C3=A0 "This page must be deleted before clone" =
false &&
+	wiki_editpage k=C3=AE=C3=AE "This page must be deleted before clone" =
false &&
+	wiki_editpage foo "This page must be deleted before clone" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page
+'
+
+# 2
+test_expect_success 'Git pull works with a wiki with accents in the pa=
ges names' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage k=C3=AE=C3=AE "this page must be cloned" false &&
+	wiki_editpage foo "this page must be cloned" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_editpage =C3=A9=C3=A0=C3=AE=C3=B4=C3=BB "This page must be pulle=
d" false &&
+	cd mw_dir &&
+	git pull &&
+	cd .. &&=20
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page &&
+	rm -rf mw_dir &&
+	rm -rf ref_page
+'
+
+# 3
+test_expect_success 'Cloning a chosen page works with accents' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage k=C3=AE=C3=AE "this page must be cloned" false &&
+	git clone -c remote.origin.pages=3Dk=C3=AE=C3=AE mediawiki::http://lo=
calhost/wiki mw_dir &&
+	wiki_check_content mw_dir/K=C3=AE=C3=AE.mw K=C3=AE=C3=AE &&
+	test -e mw_dir/K=C3=AE=C3=AE.mw &&
+	rm -rf mw_dir
+'
+
+# 4
+test_expect_success 'The shallow option works with accents' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage n=C3=A9o=C3=A0 "1st revision, should not be cloned" fal=
se &&
+	wiki_editpage n=C3=A9o=C3=A0 "2nd revision, should be cloned" false &=
&
+	git -c remote.origin.shallow=3Dtrue clone mediawiki::http://localhost=
/wiki/ mw_dir &&
+	test_contains_N_files mw_dir 2 &&
+	test -e mw_dir/N=C3=A9o=C3=A0.mw &&
+	test -e mw_dir/Main_Page.mw &&
+	cd mw_dir &&
+	test `git log --oneline N=C3=A9o=C3=A0.mw | wc -l` -eq 1 &&
+	test `git log --oneline Main_Page.mw | wc -l ` -eq 1 &&
+	cd .. &&
+	wiki_check_content mw_dir/N=C3=A9o=C3=A0.mw N=C3=A9o=C3=A0 &&
+	wiki_check_content mw_dir/Main_Page.mw Main_Page &&
+	rm -rf mw_dir
+'
+
+# 5
+test_expect_success 'Cloning works when page name first letter has an =
accent' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage =C3=AE=C3=AE "this page must be cloned" false &&
+	git clone -c remote.origin.pages=3D=C3=AE=C3=AE mediawiki::http://loc=
alhost/wiki mw_dir &&
+	test -e mw_dir/=C3=8E=C3=AE.mw &&
+	wiki_check_content mw_dir/=C3=8E=C3=AE.mw =C3=8E=C3=AE &&
+	rm -rf mw_dir
+'
+
+# 6
+test_expect_success 'Git push works with a wiki with accents' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage f=C3=A9=C3=A9 "lots of accents : =C3=A9=C3=A8=C3=A0=C3=96=
" false &&
+	wiki_editpage foo "this page must be cloned" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	cd mw_dir &&
+	echo "A wild P=C3=AEk=C3=A4ch=C3=BB appears on the wiki" > P=C3=AEk=C3=
=A4ch=C3=BB.mw &&
+	git add P=C3=AEk=C3=A4ch=C3=BB.mw &&
+	git commit -m "A new page appears" &&
+	git push &&
+	cd .. &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page &&
+	rm -rf mw_dir &&
+	rm -rf ref_page
+'
+
+# 7
+test_expect_success 'Git clone works with accentsand spaces' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage "=C3=A9 =C3=A0 =C3=AE" "this page must be d=C3=A9l=C3=A9=
t=C3=A9 before the clone" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page &&
+	rm -rf mw_dir &&
+	rm -rf ref_page
+'
+# 8
+test_expect_success 'character $ in page name (mw -> git)' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	wiki_editpage file_\$_foo "expect to be called file_$_foo" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test -f mw_dir/File_\$_foo.mw &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page
+'
+
+
+# 9
+test_expect_success 'character $ in file name (git -> mw) ' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	cd mw_dir &&
+	echo "this file is called File_\$_foo.mw" > File_\$_foo.mw &&
+	git add . &&
+	git commit -am "file File_\$_foo.mw" &&
+	git pull &&
+	git push &&
+	cd .. &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page
+'
+
+# 10
+test_expect_failure 'capital at the begining of file names' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	cd mw_dir &&
+	echo "my new file foo" > foo.mw &&
+	echo "my new file Foo... Finger crossed" > Foo.mw &&
+	git add . &&
+	git commit -am "file foo.mw" &&
+	git pull &&
+	git push &&
+	cd .. &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page
+'
+
+
+# 11
+test_expect_failure 'special character at the begining of file name fr=
om mw to git' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_editpage {char_1 "expect to be renamed {char_1" false &&
+	wiki_editpage [char_2 "expect to be renamed [char_2" false &&
+	cd mw_dir &&
+	git pull &&
+	cd .. &&
+	test -f mw_dir/{char_1 &&
+	test -f mw_dir/[char_2
+'
+
+# 12
+test_expect_success 'test of correct formating for file name from mw t=
o git' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_editpage char{_1 "expect to be renamed char{_1" false &&
+	wiki_editpage char[_2 "expect to be renamed char{_2" false &&
+	cd mw_dir &&
+	git pull &&
+	cd .. &&
+	test -f mw_dir/Char\{_1.mw &&
+	test -f mw_dir/Char\[_2.mw &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page
+'
+
+# 13
+test_expect_failure 'test of correct formating for file name begining =
with special character' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	cd mw_dir &&
+	echo "my new file {char_1" > \{char_1.mw &&
+	echo "my new file [char_2" > \[char_2.mw &&
+	git add . &&
+	git commit -am "commiting some exotic file name..." &&
+	git push &&
+	git pull &&
+	cd .. &&
+	wiki_getallpage ref_page &&
+	test -f ref_page/{char_1.mw &&
+	test -f ref_page/[char_2.mw &&
+	test_diff_directories mw_dir ref_page
+'
+
+# 14
+
+test_expect_success 'test of correct formating for file name from git =
to mw' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	rm -rf ref_page &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	cd mw_dir &&
+	echo "my new file char{_1" > Char\{_1.mw &&
+	echo "my new file char[_2" > Char\[_2.mw &&
+	git add . &&
+	git commit -m "commiting some exotic file name..." &&
+	git push &&
+	cd .. &&
+	wiki_getallpage ref_page &&
+	test_diff_directories mw_dir ref_page
+'
+
+
+# 15
+test_expect_success 'git clone with /' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage \/fo\/o "this is not important" false -c=3DDeleted &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test -f mw_dir/%2Ffo%2Fo.mw &&
+	wiki_check_content mw_dir/%2Ffo%2Fo.mw \/fo\/o &&
+	rm -rf mw_dir
+'
+
+# 16
+test_expect_success 'git push with /' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	echo "I will be on the wiki" > mw_dir/%2Ffo%2Fo.mw &&
+	cd mw_dir &&
+	git add %2Ffo%2Fo.mw &&
+	git commit -m " %2Ffo%2Fo added" &&
+	git push &&
+	cd .. &&
+	wiki_page_exist \/fo\/o &&
+	wiki_check_content mw_dir/%2Ffo%2Fo.mw \/fo\/o &&
+	rm -rf mw_dir=20
+
+'
+
+# 17
+test_expect_success 'git clone with \' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage \\ko\\o "this is not important" false -c=3DDeleted &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test -f mw_dir/\\ko\\o.mw &&
+	wiki_check_content mw_dir/\\ko\\o.mw \\ko\\o &&
+	rm -rf mw_dir
+'
+
+# 18
+test_expect_success 'git push with \' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	echo "I will be on the wiki" > mw_dir/\\ko\\o.mw &&
+	cd mw_dir &&
+	git add \\ko\\o.mw &&
+	git commit -m " \\ko\\o added" &&
+	git push &&
+	cd .. &&
+	wiki_page_exist \\ko\\o &&
+	wiki_check_content mw_dir/\\ko\\o.mw \\ko\\o &&
+	rm -rf mw_dir
+
+'
+
+# 19
+test_expect_success 'git clone with \ in format control' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	wiki_editpage \\no\\o "this is not important" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	test -f mw_dir/\\no\\o.mw &&
+	wiki_check_content mw_dir/\\no\\o.mw \\no\\o =20
+=09
+'
+
+
+# 20
+test_expect_success 'git push with \ in format contraol' '
+	wiki_reset &&
+	cd '"$TRASH_DIR"' &&
+	rm -rf mw_dir &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	echo "I will be on the wiki" > mw_dir/\\fo\\o.mw &&
+	cd mw_dir &&
+	git add \\fo\\o.mw &&
+	git commit -m " \\fo\\o added" &&
+	git push &&
+	cd .. &&
+	wiki_page_exist \\fo\\o &&
+	wiki_check_content mw_dir/\\fo\\o.mw \\fo\\o &&=20
+	rm -rf mw_dir
+
+'
+
+
+ test_done
--=20
1.7.10.2.552.gaa3bb87
