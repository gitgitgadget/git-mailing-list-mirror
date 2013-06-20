From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v5 4/5] pretty: Add failing tests: user format ignores i18n.logOutputEncoding setting
Date: Thu, 20 Jun 2013 13:26:20 +0400
Message-ID: <297a5bacde1eb3cbe96a05e8ddf1783c44cba4ac.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 11:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upb93-0003JW-Ep
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 11:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259Ab3FTJ1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jun 2013 05:27:03 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:38213 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965234Ab3FTJ06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 05:26:58 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so5399132lab.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6LuRuDtxhOJ1v6+IManxf+6OYC4wwTok/b8P+AxH5oI=;
        b=jCFU2hVTNxjioFV6PcZ/2ztZq72VltRS0uRj9rbtzVBSwBZUMxHRx3wIL4+J1nUNgD
         fxjhhayr4Q1Q/ZEsgE5TYPnmfVmDOTTn/jsEPQure5vf83EYNjLMY5/77OQ0d26TkiaP
         WfUpDNJbNXJwDbs2Ea3XRT3AS+a0eYWgVuFbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6LuRuDtxhOJ1v6+IManxf+6OYC4wwTok/b8P+AxH5oI=;
        b=x6c/ao2w/2bLGC22TywSAOKu/ErSLa0s4h7Er70tvVH6CNz4iDu6ufXYYywK1lZB/d
         sCA33tX1KK/l0+if6JKqzWAX3x4cITyzkpqvteHUzfq2w7ocATrQvncEKDLm+y8ng9u/
         vmZwOJrGp/GlUm9o/TeDwtBqc/vq+5Y/CSwh49vAe8pKjvjUc+WEcYUjVtHzmg+3klN1
         E2C6nGlTVgDGoIoRp3tnXS8V93x3OUCNkPJ5xsMsQmcwBsAtNiyZw+5aSnmz4CKiIHR+
         8CxZXcomBfx41cMcaxkBs5Fm1i3RmNO5xnxqvvjzdVp2i9rA4CRirHM269quK3aB6ku+
         pEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=6LuRuDtxhOJ1v6+IManxf+6OYC4wwTok/b8P+AxH5oI=;
        b=ocBvxDqTpj7fkCD93Cf9YuB59mF7Y6t3QLRs9Sn1EHE3leQMk+dHa0deLdb9v0OTE3
         tqVD0/dYmzepP2KoTjNf+m2iwzSaLzUhXP/MQbe4mjjapIDP6RJi9w+ZQmkf4MC0ahl4
         d0vFrn3Te8KviZsNIES613DIbJ2WOa+ZgNb53YpROaHHz73S0NhA78US5q4DbiGWz59f
         V27yRwHfggnGks5FtESmOW7lkduhoOcBZvhXMjM6vq1JsoZW+oeAjECad9jayPxmyUgd
         0ZB9yHtvey0UjIzvOc3XGJv5FaO91K22YTV64rdv7FID8fjQJYIf9j+Oi5yn/VwCQMrC
         o75w==
X-Received: by 10.112.19.162 with SMTP id g2mr5165031lbe.9.1371720416934;
        Thu, 20 Jun 2013 02:26:56 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id e9sm24252lbj.3.2013.06.20.02.26.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 02:26:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com> <cover.1371720245.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQlhXKK4jAKobIMvrXicZMJry8HgocpB3EMpMvl7lSTV+v9nn4hXTHnptqg62l7Bn4MgjVMq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228472>

The following two commands are expected to give the same output to a te=
rminal:

	$ git log --oneline --no-color
	$ git log --pretty=3Dformat:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it format "%s".
Log messages written in an encoding i18n.commitEncoding which differs
from terminal encoding are shown corrupted with the latter even
when i18n.logOutputEncoding and terminal encoding are the same.

The same corruption is true for
	$ git diff --submodule=3Dlog
and
	$ git rev-list --pretty=3Dformat:%s HEAD
and
	$ git reset --hard

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4041-diff-submodule-option.sh |  35 +++++----
 t/t4205-log-pretty-formats.sh    | 149 ++++++++++++++++++++++++-------=
--------
 t/t6006-rev-list-format.sh       |  85 +++++++++++++++-------
 t/t7102-reset.sh                 |  29 +++++++-
 4 files changed, 200 insertions(+), 98 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
index 32d4a60..22bf4df 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2009 Jens Lehmann, based on t7401 by Ping Yin
+# Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding tests=
)
 #
=20
 test_description=3D'Support for verbose submodule differences in git d=
iff
@@ -10,6 +11,9 @@ This test tries to verify the sanity of the --submodu=
le option of git diff.
=20
 . ./test-lib.sh
=20
+# String "added" in Russian, encoded in UTF-8, used in
+# sample commit log messages in add_file() function below.
+added=3D$(printf "\320\264\320\276\320\261\320\260\320\262\320\273\320=
\265\320\275")
 add_file () {
 	(
 		cd "$1" &&
@@ -19,7 +23,8 @@ add_file () {
 			echo "$name" >"$name" &&
 			git add "$name" &&
 			test_tick &&
-			git commit -m "Add $name" || exit
+			msg_added_iso88595=3D$(echo "Add $name ($added $name)" | iconv -f u=
tf-8 -t iso88595) &&
+			git -c 'i18n.commitEncoding=3Diso88595' commit -m "$msg_added_iso88=
595"
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
@@ -89,29 +94,29 @@ test_expect_success 'diff.submodule does not affect=
 plumbing' '
 commit_file sm1 &&
 head2=3D$(add_file sm1 foo3)
=20
-test_expect_success 'modified submodule(forward)' '
+test_expect_failure 'modified submodule(forward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'modified submodule(forward)' '
+test_expect_failure 'modified submodule(forward)' '
 	git diff --submodule=3Dlog >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'modified submodule(forward) --submodule' '
+test_expect_failure 'modified submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
@@ -138,25 +143,25 @@ head3=3D$(
 	git rev-parse --short --verify HEAD
 )
=20
-test_expect_success 'modified submodule(backward)' '
+test_expect_failure 'modified submodule(backward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
-	  < Add foo3
-	  < Add foo2
+	  < Add foo3 ($added foo3)
+	  < Add foo2 ($added foo2)
 	EOF
 	test_cmp expected actual
 '
=20
 head4=3D$(add_file sm1 foo4 foo5)
-test_expect_success 'modified submodule(backward and forward)' '
+test_expect_failure 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
-	  > Add foo5
-	  > Add foo4
-	  < Add foo3
-	  < Add foo2
+	  > Add foo5 ($added foo5)
+	  > Add foo4 ($added foo4)
+	  < Add foo3 ($added foo3)
+	  < Add foo2 ($added foo2)
 	EOF
 	test_cmp expected actual
 '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 6d8d457..6a56019 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1,20 +1,43 @@
 #!/bin/sh
 #
 # Copyright (c) 2010, Will Palmer
+# Copyright (c) 2011, Alexey Shumkin (+ non-UTF-8 commit encoding test=
s)
 #
=20
 test_description=3D'Test pretty formats'
 . ./test-lib.sh
=20
+commit_msg() {
+	# String "initial commit" partly in Russian, encoded in UTF-8,
+	# used as a commit log message below.
+	msg=3D$(printf "initial \320\272\320\276\320\274\320\274\320\270\321\=
202")
+	if test -n "$1"
+	then
+		msg=3D$(echo $msg | iconv -f utf-8 -t $1)
+	fi
+	if test -n "$2" -a -n "$3"
+	then
+		# cut string, replace cut part with two dots
+		# $2 - chars count from the beginning of the string
+		# $3 - "trailing" chars
+		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a by=
te
+		# as it does with C locale
+		msg=3D$(echo $msg | LC_ALL=3Den_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1=
=2E./")
+	fi
+	echo $msg
+}
+
 test_expect_success 'set up basic repos' '
 	>foo &&
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git commit -m initial &&
+	git config i18n.commitEncoding iso88595 &&
+	git commit -m "$(commit_msg iso88595)" &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar"
+	git commit -m "add bar" &&
+	git config --unset i18n.commitEncoding
 '
=20
 test_expect_success 'alias builtin format' '
@@ -38,6 +61,20 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'alias user-defined tformat with %s (iso88595 enco=
ding)' '
+	git config i18n.logOutputEncoding iso88595 &&
+	git log --oneline >expected-s &&
+	git log --pretty=3D"tformat:%h %s" >actual-s &&
+	git config --unset i18n.logOutputEncoding &&
+	test_cmp expected-s actual-s
+'
+
+test_expect_failure 'alias user-defined tformat with %s (utf-8 encodin=
g)' '
+	git log --oneline >expected-s &&
+	git log --pretty=3D"tformat:%h %s" >actual-s &&
+	test_cmp expected-s actual-s
+'
+
 test_expect_success 'alias user-defined tformat' '
 	git log --pretty=3D"tformat:%h" >expected &&
 	git config pretty.test-alias "tformat:%h" &&
@@ -71,22 +108,22 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=3Dtest-foo
 '
=20
-test_expect_success 'NUL separation' '
-	printf "add bar\0initial" >expected &&
+test_expect_failure 'NUL separation' '
+	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty=3D"format:%s" >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'NUL termination' '
-	printf "add bar\0initial\0" >expected &&
+test_expect_failure 'NUL termination' '
+	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty=3D"tformat:%s" >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'NUL separation with --stat' '
+test_expect_failure 'NUL separation with --stat' '
 	stat0_part=3D$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=3D$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n" >expected &&
+	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expect=
ed &&
 	git log -z --stat --pretty=3D"format:%s" >actual &&
 	test_i18ncmp expected actual
 '
@@ -94,7 +131,7 @@ test_expect_success 'NUL separation with --stat' '
 test_expect_failure 'NUL termination with --stat' '
 	stat0_part=3D$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=3D$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n\0" >expected &=
&
+	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n0" >expec=
ted &&
 	git log -z --stat --pretty=3D"tformat:%s" >actual &&
 	test_i18ncmp expected actual
 '
@@ -108,20 +145,20 @@ test_expect_success 'setup more commits' '
 	head4=3D$(git rev-list --max-count=3D1 --abbrev-commit HEAD~3)
 '
=20
-test_expect_success 'left alignment formatting' '
-	git log --pretty=3D"format:%<(40)%s" >actual &&
+test_expect_failure 'left alignment formatting' "
+	git log --pretty=3D'format:%<(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
 message two                            Z
 message one                            Z
 add bar                                Z
-initial                                Z
+$(commit_msg)                         Z
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'left alignment formatting at the nth column' "
+test_expect_failure 'left alignment formatting at the nth column' "
 	git log --pretty=3D'format:%h %<|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -129,77 +166,77 @@ test_expect_success 'left alignment formatting at=
 the nth column' "
 $head1 message two                    Z
 $head2 message one                    Z
 $head3 add bar                        Z
-$head4 initial                        Z
+$head4 $(commit_msg)                 Z
 EOF
 	test_cmp expected actual
 "
=20
-test_expect_success 'left alignment formatting with no padding' '
-	git log --pretty=3D"format:%<(1)%s" >actual &&
+test_expect_failure 'left alignment formatting with no padding' "
+	git log --pretty=3D'format:%<(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	cat <<\EOF >expected &&
 message two
 message one
 add bar
-initial
+$(commit_msg)
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'left alignment formatting with trunc' '
-	git log --pretty=3D"format:%<(10,trunc)%s" >actual &&
+test_expect_failure 'left alignment formatting with trunc' "
+	git log --pretty=3D'format:%<(10,trunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
 message ..
 message ..
 add bar  Z
-initial  Z
+$(commit_msg "" "8" ".\+$")
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'left alignment formatting with ltrunc' '
-	git log --pretty=3D"format:%<(10,ltrunc)%s" >actual &&
+test_expect_failure 'left alignment formatting with ltrunc' "
+	git log --pretty=3D'format:%<(10,ltrunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
 ..sage two
 ..sage one
 add bar  Z
-initial  Z
+$(commit_msg "" "0" ".\{6\}")
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'left alignment formatting with mtrunc' '
-	git log --pretty=3D"format:%<(10,mtrunc)%s" >actual &&
+test_expect_failure 'left alignment formatting with mtrunc' "
+	git log --pretty=3D'format:%<(10,mtrunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
 mess.. two
 mess.. one
 add bar  Z
-initial  Z
+$(commit_msg "" "4" ".\{6\}")
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'right alignment formatting' '
-	git log --pretty=3D"format:%>(40)%s" >actual &&
+test_expect_failure 'right alignment formatting' "
+	git log --pretty=3D'format:%>(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
 Z                            message two
 Z                            message one
 Z                                add bar
-Z                                initial
+Z                         $(commit_msg)
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'right alignment formatting at the nth column' "
+test_expect_failure 'right alignment formatting at the nth column' "
 	git log --pretty=3D'format:%h %>|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -207,38 +244,38 @@ test_expect_success 'right alignment formatting a=
t the nth column' "
 $head1                      message two
 $head2                      message one
 $head3                          add bar
-$head4                          initial
+$head4                   $(commit_msg)
 EOF
 	test_cmp expected actual
 "
=20
-test_expect_success 'right alignment formatting with no padding' '
-	git log --pretty=3D"format:%>(1)%s" >actual &&
+test_expect_failure 'right alignment formatting with no padding' "
+	git log --pretty=3D'format:%>(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	cat <<\EOF >expected &&
 message two
 message one
 add bar
-initial
+$(commit_msg)
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'center alignment formatting' '
-	git log --pretty=3D"format:%><(40)%s" >actual &&
+test_expect_failure 'center alignment formatting' "
+	git log --pretty=3D'format:%><(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
 Z             message two              Z
 Z             message one              Z
 Z               add bar                Z
-Z               initial                Z
+Z            $(commit_msg)            Z
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'center alignment formatting at the nth column' "
+test_expect_failure 'center alignment formatting at the nth column' "
 	git log --pretty=3D'format:%h %><|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -246,36 +283,36 @@ test_expect_success 'center alignment formatting =
at the nth column' "
 $head1           message two          Z
 $head2           message one          Z
 $head3             add bar            Z
-$head4             initial            Z
+$head4          $(commit_msg)        Z
 EOF
 	test_cmp expected actual
 "
=20
-test_expect_success 'center alignment formatting with no padding' '
-	git log --pretty=3D"format:%><(1)%s" >actual &&
+test_expect_failure 'center alignment formatting with no padding' "
+	git log --pretty=3D'format:%><(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	cat <<\EOF >expected &&
 message two
 message one
 add bar
-initial
+$(commit_msg)
 EOF
 	test_cmp expected actual
-'
+"
=20
-test_expect_success 'left/right alignment formatting with stealing' '
-	git commit --amend -m short --author "long long long <long@me.com>" &=
&
-	git log --pretty=3D"format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual =
&&
+test_expect_failure 'left/right alignment formatting with stealing' "
+	git commit --amend -m short --author 'long long long <long@me.com>' &=
&
+	git log --pretty=3D'format:%<(10,trunc)%s%>>(10,ltrunc)% an' >actual =
&&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	cat <<\EOF >expected &&
 short long  long long
 message ..   A U Thor
 add bar      A U Thor
-initial      A U Thor
+$(commit_msg "" "8" ".\+$")   A U Thor
 EOF
 	test_cmp expected actual
-'
+"
=20
 test_done
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index d32e65e..36e4cc0 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -1,36 +1,62 @@
 #!/bin/sh
=20
+# Copyright (c) 2009 Jens Lehmann
+# Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding tests=
)
+
 test_description=3D'git rev-list --pretty=3Dformat test'
=20
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
 test_tick
+# String "added" in Russian, encoded in UTF-8,
+# used as a commit log message below.
+added=3D$(printf "added (\320\264\320\276\320\261\320\260\320\262\320\=
273\320\265\320\275) foo")
+added_iso88595=3D$(echo "$added" | iconv -f utf-8 -t iso88595)
+# same but "changed"
+changed=3D$(printf "changed (\320\264\320\276\320\261\320\260\320\262\=
320\273\320\265\320\275) foo")
+changed_iso88595=3D$(echo "$changed" | iconv -f utf-8 -t iso88595)
+
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
-	git commit -m "added foo" &&
+	git config i18n.commitEncoding iso88595 &&
+	git commit -m "$added_iso88595" &&
 	head1=3D$(git rev-parse --verify HEAD) &&
 	head1_short=3D$(git rev-parse --short $head1) &&
 	tree1=3D$(git cat-file commit HEAD | sed -n -e "s/^tree //p" -e "/^$/=
q") &&
 	tree1_short=3D$(git rev-parse --short $tree1) &&
-	echo changed >foo &&
-	git commit -a -m "changed foo" &&
+	echo "$changed" > foo &&
+	git commit -a -m "$changed_iso88595" &&
 	head2=3D$(git rev-parse --verify HEAD) &&
 	head2_short=3D$(git rev-parse --short $head2) &&
 	head2_parent=3D$(git cat-file commit HEAD | sed -n -e "s/^parent //p"=
 -e "/^$/q") &&
 	head2_parent_short=3D$(git rev-parse --short $head2_parent) &&
 	tree2=3D$(git cat-file commit HEAD | sed -n -e "s/^tree //p" -e "/^$/=
q") &&
-	tree2_short=3D$(git rev-parse --short $tree2)
+	tree2_short=3D$(git rev-parse --short $tree2) &&
+	git config --unset i18n.commitEncoding
 '
=20
-# usage: test_format name format_string <expected_output
+# usage: test_format [failure] name format_string <expected_output
 test_format () {
+	local must_fail=3D0
+	# if parameters count is more than 2 then test must fail
+	if test $# -gt 2
+	then
+		must_fail=3D1
+		# remove first parameter which is flag for test failure
+		shift
+	fi
 	cat >expect.$1
-	test_expect_success "format $1" "
-		git rev-list --pretty=3Dformat:'$2' master >output.$1 &&
-		test_cmp expect.$1 output.$1
-	"
+	name=3D"format $1"
+	command=3D"git rev-list --pretty=3Dformat:'$2' master >output.$1 &&
+		test_cmp expect.$1 output.$1"
+	if test $must_fail -eq 1
+	then
+		test_expect_failure "$name" "$command"
+	else
+		test_expect_success "$name" "$command"
+	fi
 }
=20
 # Feed to --format to provide predictable colored sequences.
@@ -112,14 +138,16 @@ EOF
=20
 test_format encoding %e <<EOF
 commit $head2
+iso88595
 commit $head1
+iso88595
 EOF
=20
-test_format subject %s <<EOF
+test_format failure subject %s <<EOF
 commit $head2
-changed foo
+$changed
 commit $head1
-added foo
+$added
 EOF
=20
 test_format body %b <<EOF
@@ -127,12 +155,12 @@ commit $head2
 commit $head1
 EOF
=20
-test_format raw-body %B <<EOF
+test_format failure raw-body %B <<EOF
 commit $head2
-changed foo
+$changed
=20
 commit $head1
-added foo
+$added
=20
 EOF
=20
@@ -192,42 +220,49 @@ test_expect_success '%C(auto) respects --color=3D=
auto (stdout not tty)' '
 	)
 '
=20
-cat >commit-msg <<'EOF'
+iconv -f utf-8 -t iso8859-1 > commit-msg <<EOF
 Test printing of complex bodies
=20
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =A1bueno!
+include an iso8859 character: =C2=A1bueno!
 EOF
=20
 test_expect_success 'setup complex body' '
 	git config i18n.commitencoding iso8859-1 &&
 	echo change2 >foo && git commit -a -F commit-msg &&
 	head3=3D$(git rev-parse --verify HEAD) &&
-	head3_short=3D$(git rev-parse --short $head3)
+	head3_short=3D$(git rev-parse --short $head3) &&
+	# unset commit encoding config
+	# otherwise %e does not print encoding value
+	# and following test fails
+	git config --unset i18n.commitEncoding
+
 '
=20
 test_format complex-encoding %e <<EOF
 commit $head3
 iso8859-1
 commit $head2
+iso88595
 commit $head1
+iso88595
 EOF
=20
-test_format complex-subject %s <<EOF
+test_format failure complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
-changed foo
+$changed
 commit $head1
-added foo
+$added
 EOF
=20
-test_format complex-body %b <<EOF
+test_format failure complex-body %b <<EOF
 commit $head3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =A1bueno!
+include an iso8859 character: =C2=A1bueno!
=20
 commit $head2
 commit $head1
@@ -281,12 +316,12 @@ test_expect_success 'add LF before non-empty (2)'=
 '
=20
 test_expect_success 'add SP before non-empty (1)' '
 	git show -s --pretty=3Dformat:"%s% bThanks" HEAD^^ >actual &&
-	test $(wc -w <actual) =3D 2
+	test $(wc -w <actual) =3D 3
 '
=20
 test_expect_success 'add SP before non-empty (2)' '
 	git show -s --pretty=3Dformat:"%s% sThanks" HEAD^^ >actual &&
-	test $(wc -w <actual) =3D 4
+	test $(wc -w <actual) =3D 6
 '
=20
 test_expect_success '--abbrev' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 05dfb27..48534f1 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -9,6 +9,17 @@ Documented tests for git reset'
=20
 . ./test-lib.sh
=20
+commit_msg() {
+	# String "2nd file modified" in Russian, encoded in UTF-8,
+	# used as a commit log message below.
+	msg=3D$(printf "modify 2nd file (\320\270\320\267\320\274\320\265\320=
\275\321\221\320\275 \321\204\320\260\320\271\320\273)")
+	if test -n "$1"
+	then
+		msg=3D$(echo $msg | iconv -f utf-8 -t $1)
+	fi
+	echo $msg
+}
+
 test_expect_success 'creating initial files and commits' '
 	test_tick &&
 	echo "1st file" >first &&
@@ -28,7 +39,7 @@ test_expect_success 'creating initial files and commi=
ts' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git commit -a -m "modify 2nd file" &&
+	git -c "i18n.commitEncoding=3Diso88595" commit -a -m "$(commit_msg is=
o88595)" &&
 	head5=3D$(git rev-parse --verify HEAD)
 '
 # git log --pretty=3Doneline # to see those SHA1 involved
@@ -44,6 +55,20 @@ check_changes () {
 	done | test_cmp .cat_expect -
 }
=20
+test_expect_failure 'reset --hard message' '
+	hex=3D$(git log -1 --format=3D"%h") &&
+	git reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg) > .expected &&
+	test_cmp .expected .actual
+'
+
+test_expect_success 'reset --hard message (iso88595 logoutencoding)' '
+	hex=3D$(git log -1 --format=3D"%h") &&
+	git -c "i18n.logOutputEncoding=3Diso88595" reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg iso88595) > .expected &&
+	test_cmp .expected .actual
+'
+
 >.diff_expect
 >.cached_expect
 cat >.cat_expect <<EOF
@@ -304,7 +329,7 @@ test_expect_success 'redoing the last two commits s=
hould succeed' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git commit -a -m "modify 2nd file" &&
+	git -c "i18n.commitEncoding=3Diso88595" commit -a -m "$(commit_msg is=
o88595)" &&
 	check_changes $head5
 '
=20
--=20
1.8.3.1.15.g5c23c1e
