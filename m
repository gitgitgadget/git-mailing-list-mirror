From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v6 4/5] pretty: Add failing tests: --format output should honor logOutputEncoding
Date: Tue, 25 Jun 2013 12:55:31 +0400
Message-ID: <44d13d28427c524c896f9eb4873e60f66f2fd20c.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 10:57:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrP46-0000k6-Do
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 10:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab3FYI5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 04:57:25 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:54539 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3FYIzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 04:55:53 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so11741668lab.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=vIL3YLPL9gYFp04r3R9sQ68bXBvm54g34Z/dHWRsjcg=;
        b=SLRGI0frpejALHMcXXyYuG4eqyGYSwWRP4DUvJeuuzViPyJvK1KndkbxsBgKQXKdWH
         n2hwyhKcSaTBYFVNKOYp0D3jmek48dDNnBMGhwiRxoZicPLZz65XLfuXgJbvai872v3Z
         4T9rUiA9mli/tpKWp/KRe1rV0og/5qvJv95go=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=vIL3YLPL9gYFp04r3R9sQ68bXBvm54g34Z/dHWRsjcg=;
        b=Vm+jYhDeCD33lqglrQGV/NnXipGwyd87Pl8K7RwvhABzQsTfVp8OwDna6wKSHj9TPU
         /9ylXxNHQ4ClrGAJcjx/wxWMq48YNxx0GJB6KNDFsqML5b9xiHmGVBsyzBJviRnhrVqq
         oOYPfSMFwmwBf265akReQ74WvsFmyvksmN51YlhgQA8PXxIrFMXgBiBSlx4/iZCYgFlN
         BtWQlpdT5liet/hoEvqbVWtT6rKzFrAX7+Kq3jpCXMNgR2+3mFpOTC5u7GRMCQ/eVYBf
         T6s4Xhn7GkJCosD0ZGI1NwGI6MR9VCv4qN3tJtpixn+WxGyxhi2MkXmkIc45B2dQ293B
         7WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=vIL3YLPL9gYFp04r3R9sQ68bXBvm54g34Z/dHWRsjcg=;
        b=bdnCOUKpest3t/ZUh31Muv1fIprIa59d4NyGyl/4N/o4S0H36o2c0nPQNGulg+TK+x
         cYRsPVFL8UCWoJ2PetMQZ7M3hqt4hqsqJdDhULUeRq1+8cfZ6UhWpNJ/BsB/Dv7Qn3wp
         U3CIWK/7PY8+d/Px0N/I6evwfH1V2TVIVZcWMmkUjH9MYMRJMOya+fXsDR3Hyet1N816
         DbBeMW6HvSEFel1q/1l4EgAxfKSZCpfINi6qXOo9dnS2Dgq2jBpmMiu14QuOdVhkXVqZ
         zUaw9owkVdCsuIDtjDWxU3g8NqD2NYz9USa3btSHdhWAsz6SobnZRVHDv4HpZ/3xXojK
         rHRA==
X-Received: by 10.112.53.10 with SMTP id x10mr14613042lbo.28.1372150550853;
        Tue, 25 Jun 2013 01:55:50 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id x8sm8350756lae.10.2013.06.25.01.55.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 01:55:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com> <cover.1372149305.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQlshoUN361UWxNp/i/tGg/yyhPYr45Y7LN6wFq6aLeWLUs9MVmQ/pkOAo8g8eA4+mObmNhU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228951>

One can set an alias
	$ git config alias.lg "log --graph --pretty=3Dformat:'%Cred%h%Creset
	-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset'
	--abbrev-commit --date=3Dlocal"

to see the log as a pretty tree (like *gitk* but in a terminal).

However, log messages written in an encoding i18n.commitEncoding which =
differs
from terminal encoding are shown corrupted even when i18n.logOutputEnco=
ding
and terminal encoding are the same (e.g. log messages committed on a Cy=
gwin box
with Windows-1251 encoding seen on a Linux box with a UTF-8 encoding an=
d vice versa).

To simplify an example we can say the following two commands are expect=
ed
to give the same output to a terminal:

	$ git log --oneline --no-color
	$ git log --pretty=3Dformat:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it formats "%s".

The same corruption is true for
	$ git diff --submodule=3Dlog
and
	$ git rev-list --pretty=3Dformat:%s HEAD
and
	$ git reset --hard

This patch adds failing tests for the next patch that fixes them.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4041-diff-submodule-option.sh |  35 +++++----
 t/t4205-log-pretty-formats.sh    | 149 ++++++++++++++++++++++++-------=
--------
 t/t6006-rev-list-format.sh       |  83 +++++++++++++++-------
 t/t7102-reset.sh                 |  29 +++++++-
 4 files changed, 199 insertions(+), 97 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
index 32d4a60..67afb86 100755
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
+			msg_added_cp1251=3D$(echo "Add $name ($added $name)" | iconv -f utf=
-8 -t cp1251) &&
+			git -c 'i18n.commitEncoding=3Dcp1251' commit -m "$msg_added_cp1251"
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
index 73ba5e8..a45bb55 100755
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
+	git config i18n.commitEncoding cp1251 &&
+	git commit -m "$(commit_msg cp1251)" &&
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
+test_expect_success 'alias user-defined tformat with %s (cp1251 encodi=
ng)' '
+	git config i18n.logOutputEncoding cp1251 &&
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
 	head4=3D$(git rev-parse --verify --short HEAD~3)
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
index cc1008d..ce62214 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -1,34 +1,60 @@
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
+added_cp1251=3D$(echo "$added" | iconv -f utf-8 -t cp1251)
+# same but "changed"
+changed=3D$(printf "changed (\320\264\320\276\320\261\320\260\320\262\=
320\273\320\265\320\275) foo")
+changed_cp1251=3D$(echo "$changed" | iconv -f utf-8 -t cp1251)
+
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
-	git commit -m "added foo" &&
+	git config i18n.commitEncoding cp1251 &&
+	git commit -m "$added_cp1251" &&
 	head1=3D$(git rev-parse --verify HEAD) &&
 	head1_short=3D$(git rev-parse --verify --short $head1) &&
 	tree1=3D$(git rev-parse --verify HEAD:) &&
 	tree1_short=3D$(git rev-parse --verify --short $tree1) &&
-	echo changed >foo &&
-	git commit -a -m "changed foo" &&
+	echo "$changed" > foo &&
+	git commit -a -m "$changed_cp1251" &&
 	head2=3D$(git rev-parse --verify HEAD) &&
 	head2_short=3D$(git rev-parse --verify --short $head2) &&
 	tree2=3D$(git rev-parse --verify HEAD:) &&
 	tree2_short=3D$(git rev-parse --verify --short $tree2)
+	git config --unset i18n.commitEncoding
 '
=20
-# usage: test_format name format_string <expected_output
+# usage: test_format [failure] name format_string <expected_output
 test_format () {
+	must_fail=3D0
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
@@ -110,14 +136,16 @@ EOF
=20
 test_format encoding %e <<EOF
 commit $head2
+cp1251
 commit $head1
+cp1251
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
@@ -125,12 +153,12 @@ commit $head2
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
@@ -190,42 +218,49 @@ test_expect_success '%C(auto) respects --color=3D=
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
+cp1251
 commit $head1
+cp1251
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
@@ -279,12 +314,12 @@ test_expect_success 'add LF before non-empty (2)'=
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
index 05dfb27..19a4cf4 100755
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
+	git -c "i18n.commitEncoding=3Dcp1251" commit -a -m "$(commit_msg cp12=
51)" &&
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
+test_expect_success 'reset --hard message (cp1251 logoutencoding)' '
+	hex=3D$(git log -1 --format=3D"%h") &&
+	git -c "i18n.logOutputEncoding=3Dcp1251" reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg cp1251) > .expected &&
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
+	git -c "i18n.commitEncoding=3Dcp1251" commit -a -m "$(commit_msg cp12=
51)" &&
 	check_changes $head5
 '
=20
--=20
1.8.3.1.15.g5c23c1e
