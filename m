From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: =?UTF-8?q?=5BPATCH=2005/12=5D=20git-remote-mediawiki=20=28t9362=29=3A=20test=20git-remote-mediawiki=20with=20UTF8=20characters?=
Date: Thu,  5 Jul 2012 09:36:05 +0200
Message-ID: <1341473772-28023-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon Cathebras <simon.cathebras@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:37:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgdF-0002Jm-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab2GEHhi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 03:37:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38974 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246Ab2GEHgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZTqp011210
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcB-0006Yd-3O; Thu, 05 Jul 2012 09:36:39 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcB-0007ib-1a; Thu, 05 Jul 2012 09:36:39 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Jul 2012 09:35:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZTqp011210
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078530.97667@OSZYPpiOzOyePaFOGHqhhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201036>

=46rom: Simon Cathebras <simon.cathebras@ensimag.imag.fr>

Non-ascii encoding create many particular cases when used in page
content, name, and edit/commit message. Test these cases.

Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh | 301 ++++++++++++++++++++=
++++++++
 1 file changed, 301 insertions(+)
 create mode 100755 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh

diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-t=
o-git/t/t9362-mw-to-git-utf8.sh
new file mode 100755
index 0000000..8635878
--- /dev/null
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -0,0 +1,301 @@
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
+
+test_check_precond
+
+
+test_expect_success 'Git clone works for a wiki with accents in the pa=
ge names' '
+	wiki_reset &&
+	wiki_editpage f=C3=A9=C3=A9 "This page must be d=C3=A9l=C3=A9t=C3=A9d=
 before clone" false &&
+	wiki_editpage k=C3=A8=C3=A8 "This page must be deleted before clone" =
false &&
+	wiki_editpage h=C3=A0=C3=A0 "This page must be deleted before clone" =
false &&
+	wiki_editpage k=C3=AE=C3=AE "This page must be deleted before clone" =
false &&
+	wiki_editpage foo "This page must be deleted before clone" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_1 &&
+	wiki_getallpage ref_page_1 &&
+	test_diff_directories mw_dir_1 ref_page_1
+'
+
+
+test_expect_success 'Git pull works with a wiki with accents in the pa=
ges names' '
+	wiki_reset &&
+	wiki_editpage k=C3=AE=C3=AE "this page must be cloned" false &&
+	wiki_editpage foo "this page must be cloned" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_2 &&
+	wiki_editpage =C3=A9=C3=A0=C3=AE=C3=B4=C3=BB "This page must be pulle=
d" false &&
+	(
+		cd mw_dir_2 &&
+		git pull
+	) &&
+	wiki_getallpage ref_page_2 &&
+	test_diff_directories mw_dir_2 ref_page_2
+'
+
+
+test_expect_success 'Cloning a chosen page works with accents' '
+	wiki_reset &&
+	wiki_editpage k=C3=AE=C3=AE "this page must be cloned" false &&
+	git clone -c remote.origin.pages=3Dk=C3=AE=C3=AE \
+		mediawiki::'"$WIKI_URL"' mw_dir_3 &&
+	wiki_check_content mw_dir_3/K=C3=AE=C3=AE.mw K=C3=AE=C3=AE &&
+	test_path_is_file mw_dir_3/K=C3=AE=C3=AE.mw &&
+	rm -rf mw_dir_3
+'
+
+
+test_expect_success 'The shallow option works with accents' '
+	wiki_reset &&
+	wiki_editpage n=C3=A9o=C3=A0 "1st revision, should not be cloned" fal=
se &&
+	wiki_editpage n=C3=A9o=C3=A0 "2nd revision, should be cloned" false &=
&
+	git -c remote.origin.shallow=3Dtrue clone \
+		mediawiki::'"$WIKI_URL"' mw_dir_4 &&
+	test_contains_N_files mw_dir_4 2 &&
+	test_path_is_file mw_dir_4/N=C3=A9o=C3=A0.mw &&
+	test_path_is_file mw_dir_4/Main_Page.mw &&
+	(
+		cd mw_dir_4 &&
+		test `git log --oneline N=C3=A9o=C3=A0.mw | wc -l` -eq 1 &&
+		test `git log --oneline Main_Page.mw | wc -l ` -eq 1
+	) &&
+	wiki_check_content mw_dir_4/N=C3=A9o=C3=A0.mw N=C3=A9o=C3=A0 &&
+	wiki_check_content mw_dir_4/Main_Page.mw Main_Page
+'
+
+
+test_expect_success 'Cloning works when page name first letter has an =
accent' '
+	wiki_reset &&
+	wiki_editpage =C3=AE=C3=AE "this page must be cloned" false &&
+	git clone -c remote.origin.pages=3D=C3=AE=C3=AE \
+		mediawiki::'"$WIKI_URL"' mw_dir_5 &&
+	test_path_is_file mw_dir_5/=C3=8E=C3=AE.mw &&
+	wiki_check_content mw_dir_5/=C3=8E=C3=AE.mw =C3=8E=C3=AE
+'
+
+
+test_expect_success 'Git push works with a wiki with accents' '
+	wiki_reset &&
+	wiki_editpage f=C3=A9=C3=A9 "lots of accents : =C3=A9=C3=A8=C3=A0=C3=96=
" false &&
+	wiki_editpage foo "this page must be cloned" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_6 &&
+	(
+		cd mw_dir_6 &&
+		echo "A wild P=C3=AEk=C3=A4ch=C3=BB appears on the wiki" >P=C3=AEk=C3=
=A4ch=C3=BB.mw &&
+		git add P=C3=AEk=C3=A4ch=C3=BB.mw &&
+		git commit -m "A new page appears" &&
+		git push
+	) &&
+	wiki_getallpage ref_page_6 &&
+	test_diff_directories mw_dir_6 ref_page_6
+'
+
+test_expect_success 'Git clone works with accentsand spaces' '
+	wiki_reset &&
+	wiki_editpage "=C3=A9 =C3=A0 =C3=AE" "this page must be d=C3=A9l=C3=A9=
t=C3=A9 before the clone" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_7 &&
+	wiki_getallpage ref_page_7 &&
+	test_diff_directories mw_dir_7 ref_page_7
+'
+
+test_expect_success 'character $ in page name (mw -> git)' '
+	wiki_reset &&
+	wiki_editpage file_\$_foo "expect to be called file_$_foo" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_8 &&
+	test_path_is_file mw_dir_8/File_\$_foo.mw &&
+	wiki_getallpage ref_page_8 &&
+	test_diff_directories mw_dir_8 ref_page_8
+'
+
+
+
+test_expect_success 'character $ in file name (git -> mw) ' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_9 &&
+	(
+		cd mw_dir_9 &&
+		echo "this file is called File_\$_foo.mw" >File_\$_foo.mw &&
+		git add . &&
+		git commit -am "file File_\$_foo.mw" &&
+		git pull &&
+		git push
+	) &&
+	wiki_getallpage ref_page_9 &&
+	test_diff_directories mw_dir_9 ref_page_9
+'
+
+
+test_expect_failure 'capital at the begining of file names' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_10 &&
+	(
+		cd mw_dir_10 &&
+		echo "my new file foo" >foo.mw &&
+		echo "my new file Foo... Finger crossed" >Foo.mw &&
+		git add . &&
+		git commit -am "file foo.mw" &&
+		git pull &&
+		git push
+	) &&
+	wiki_getallpage ref_page_10 &&
+	test_diff_directories mw_dir_10 ref_page_10
+'
+
+
+test_expect_failure 'special character at the begining of file name fr=
om mw to git' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_11 &&
+	wiki_editpage {char_1 "expect to be renamed {char_1" false &&
+	wiki_editpage [char_2 "expect to be renamed [char_2" false &&
+	(
+		cd mw_dir_11 &&
+		git pull
+	) &&
+	test_path_is_file mw_dir_11/{char_1 &&
+	test_path_is_file mw_dir_11/[char_2
+'
+
+test_expect_success 'test of correct formating for file name from mw t=
o git' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_12 &&
+	wiki_editpage char_%_7b_1 "expect to be renamed char{_1" false &&
+	wiki_editpage char_%_5b_2 "expect to be renamed char{_2" false &&
+	(
+		cd mw_dir_12 &&
+		git pull
+	) &&
+	test_path_is_file mw_dir_12/Char\{_1.mw &&
+	test_path_is_file mw_dir_12/Char\[_2.mw &&
+	wiki_getallpage ref_page_12 &&
+	mv ref_page_12/Char_%_7b_1.mw ref_page_12/Char\{_1.mw &&
+	mv ref_page_12/Char_%_5b_2.mw ref_page_12/Char\[_2.mw &&
+	test_diff_directories mw_dir_12 ref_page_12
+'
+
+
+test_expect_failure 'test of correct formating for file name begining =
with special character' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_13 &&
+	(
+		cd mw_dir_13 &&
+		echo "my new file {char_1" >\{char_1.mw &&
+		echo "my new file [char_2" >\[char_2.mw &&
+		git add . &&
+		git commit -am "commiting some exotic file name..." &&
+		git push &&
+		git pull
+	) &&
+	wiki_getallpage ref_page_13 &&
+	test_path_is_file ref_page_13/{char_1.mw &&
+	test_path_is_file ref_page_13/[char_2.mw &&
+	test_diff_directories mw_dir_13 ref_page_13
+'
+
+
+test_expect_success 'test of correct formating for file name from git =
to mw' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_14 &&
+	(
+		cd mw_dir_14 &&
+		echo "my new file char{_1" >Char\{_1.mw &&
+		echo "my new file char[_2" >Char\[_2.mw &&
+		git add . &&
+		git commit -m "commiting some exotic file name..." &&
+		git push
+	) &&
+	wiki_getallpage ref_page_14 &&
+	mv mw_dir_14/Char\{_1.mw mw_dir_14/Char_%_7b_1.mw &&
+	mv mw_dir_14/Char\[_2.mw mw_dir_14/Char_%_5b_2.mw &&
+	test_diff_directories mw_dir_14 ref_page_14
+'
+
+
+test_expect_success 'git clone with /' '
+	wiki_reset &&
+	wiki_editpage \/fo\/o "this is not important" false -c=3DDeleted &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_15 &&
+	test_path_is_file mw_dir_15/%2Ffo%2Fo.mw &&
+	wiki_check_content mw_dir_15/%2Ffo%2Fo.mw \/fo\/o
+'
+
+
+test_expect_success 'git push with /' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_16 &&
+	echo "I will be on the wiki" >mw_dir_16/%2Ffo%2Fo.mw &&
+	(
+		cd mw_dir_16 &&
+		git add %2Ffo%2Fo.mw &&
+		git commit -m " %2Ffo%2Fo added" &&
+		git push
+	) &&
+	wiki_page_exist \/fo\/o &&
+	wiki_check_content mw_dir_16/%2Ffo%2Fo.mw \/fo\/o
+
+'
+
+
+test_expect_success 'git clone with \' '
+	wiki_reset &&
+	wiki_editpage \\ko\\o "this is not important" false -c=3DDeleted &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_17 &&
+	test_path_is_file mw_dir_17/\\ko\\o.mw &&
+	wiki_check_content mw_dir_17/\\ko\\o.mw \\ko\\o
+'
+
+
+test_expect_success 'git push with \' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_18 &&
+	echo "I will be on the wiki" >mw_dir_18/\\ko\\o.mw &&
+	(
+		cd mw_dir_18 &&
+		git add \\ko\\o.mw &&
+		git commit -m " \\ko\\o added" &&
+		git push
+	)&&
+	wiki_page_exist \\ko\\o &&
+	wiki_check_content mw_dir_18/\\ko\\o.mw \\ko\\o
+
+'
+
+test_expect_success 'git clone with \ in format control' '
+	wiki_reset &&
+	wiki_editpage \\no\\o "this is not important" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_19 &&
+	test_path_is_file mw_dir_19/\\no\\o.mw &&
+	wiki_check_content mw_dir_19/\\no\\o.mw \\no\\o
+'
+
+
+test_expect_success 'git push with \ in format control' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_20 &&
+	echo "I will be on the wiki" >mw_dir_20/\\fo\\o.mw &&
+	(
+		cd mw_dir_20 &&
+		git add \\fo\\o.mw &&
+		git commit -m " \\fo\\o added" &&
+		git push
+	)&&
+	wiki_page_exist \\fo\\o &&
+	wiki_check_content mw_dir_20/\\fo\\o.mw \\fo\\o
+
+'
+
+
+test_done
--=20
1.7.11.1.147.g47a574d
