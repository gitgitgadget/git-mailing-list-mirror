From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Thu, 29 Aug 2013 14:24:36 -0700
Message-ID: <xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
	<xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:24:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9hy-0003Ym-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431Ab3H2VYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 17:24:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab3H2VYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 17:24:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 945643D0A4;
	Thu, 29 Aug 2013 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ytew0NKwAYPu
	uZLWj21wMNRGhRs=; b=c+RssCjcZW+ugXNwbvWUTX2y5HTSn5y4uJiFCMGGDiph
	4Dy+Rua6LiA9EKkn+d7MX6VxSMHoVdxz10mWki3tdFNAiB8Tw5EvM0UdX+dKgrD1
	kB3+B8obaBs8SKyS8ZgGS0XKsvWjBO+VhBzWRW5ep9iQjOgWdXxz23A3AtX4yok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gv7jdo
	Dz+IkIQO3lRnJzWkezDTA0hTW9yOueDc7wJt7KMnGOyEpbYexbeDxskqnCdZ5TrH
	RCLBOKQ39u6LZ8Wv2BOCJQZeM9jGtPG4oMLnZmRllckcd9i77H5jwqtFw50JKiJe
	mSifBHLp2iAz0TwDYYBvzeUITE22gtrYL3vZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F8B3D0A3;
	Thu, 29 Aug 2013 21:24:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9465F3D099;
	Thu, 29 Aug 2013 21:24:39 +0000 (UTC)
In-Reply-To: <xmqq7gf58okw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 Aug 2013 14:58:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 699AE822-10F1-11E3-BB1D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233365>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Do I really need to quote the paragraph in CodingGuidelines?
>
> Existing violations are not an excuse to make things worse by adding
> more.  I think with these comments we can expect a reroll coming,
> and it should be trivial for any contributor to fix it while at it.

Actually, I think not fixing it inside that 1/8 is good, as there
are many existing "cmd > file" (and worse, "cmd > file-$x") in these
test-*.sh scripts.  Clean-up is better done as a follow-up patch.

Here are two that I noticed.

-- >8 --
Subject: [PATCH 9/8] contrib/remote-helpers: style updates for test scr=
ipts

During the review of the main series it was noticed that these test
scripts can use updates to conform to our coding style better, but
fixing the style should be done in a patch separate from the main
series.

This updates the test-*.sh scripts only for styles:

 * We do not leave SP between a redirection operator and the
   filename;

 * We change line before "then", "do", etc. rather than terminating
   the condition for "if"/"while" and list for "for" with a
   semicolon;

 * When HERE document does not use any expansion, we quote the end
   marker (e.g. "cat <<\EOF" not "cat <<EOF") to signal the readers
   that there is no funny substitution to worry about when reading
   the code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/remote-helpers/test-bzr.sh       | 112 +++++++++++-----------
 contrib/remote-helpers/test-hg-bidi.sh   |  52 ++++++-----
 contrib/remote-helpers/test-hg-hg-git.sh | 156 +++++++++++++++++------=
--------
 contrib/remote-helpers/test-hg.sh        | 154 +++++++++++++++--------=
-------
 4 files changed, 248 insertions(+), 226 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index b0d70fd..5c50251 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -7,19 +7,21 @@ test_description=3D'Test remote-bzr'
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq PYTHON; then
+if ! test_have_prereq PYTHON
+then
 	skip_all=3D'skipping remote-bzr tests; python not available'
 	test_done
 fi
=20
-if ! python -c 'import bzrlib'; then
+if ! python -c 'import bzrlib'
+then
 	skip_all=3D'skipping remote-bzr tests; bzr not available'
 	test_done
 fi
=20
 check () {
-	echo $3 > expected &&
-	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 > actual
+	echo $3 >expected &&
+	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 >actual
 	test_cmp expected actual
 }
=20
@@ -29,7 +31,7 @@ test_expect_success 'cloning' '
 	(
 	bzr init bzrrepo &&
 	cd bzrrepo &&
-	echo one > content &&
+	echo one >content &&
 	bzr add content &&
 	bzr commit -m one
 	) &&
@@ -41,7 +43,7 @@ test_expect_success 'cloning' '
 test_expect_success 'pulling' '
 	(
 	cd bzrrepo &&
-	echo two > content &&
+	echo two >content &&
 	bzr commit -m two
 	) &&
=20
@@ -53,13 +55,13 @@ test_expect_success 'pulling' '
 test_expect_success 'pushing' '
 	(
 	cd gitrepo &&
-	echo three > content &&
+	echo three >content &&
 	git commit -a -m three &&
 	git push
 	) &&
=20
-	echo three > expected &&
-	cat bzrrepo/content > actual &&
+	echo three >expected &&
+	cat bzrrepo/content >actual &&
 	test_cmp expected actual
 '
=20
@@ -67,16 +69,16 @@ test_expect_success 'roundtrip' '
 	(
 	cd gitrepo &&
 	git pull &&
-	git log --format=3D"%s" -1 origin/master > actual
+	git log --format=3D"%s" -1 origin/master >actual
 	) &&
-	echo three > expected &&
+	echo three >expected &&
 	test_cmp expected actual &&
=20
 	(cd gitrepo && git push && git pull) &&
=20
 	(
 	cd bzrrepo &&
-	echo four > content &&
+	echo four >content &&
 	bzr commit -m four
 	) &&
=20
@@ -86,19 +88,19 @@ test_expect_success 'roundtrip' '
=20
 	(
 	cd gitrepo &&
-	echo five > content &&
+	echo five >content &&
 	git commit -a -m five &&
 	git push && git pull
 	) &&
=20
 	(cd bzrrepo && bzr revert) &&
=20
-	echo five > expected &&
-	cat bzrrepo/content > actual &&
+	echo five >expected &&
+	cat bzrrepo/content >actual &&
 	test_cmp expected actual
 '
=20
-cat > expected <<EOF
+cat >expected <<\EOF
 100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
 100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
 120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
@@ -107,7 +109,7 @@ EOF
 test_expect_success 'special modes' '
 	(
 	cd bzrrepo &&
-	echo exec > executable
+	echo exec >executable
 	chmod +x executable &&
 	bzr add executable
 	bzr commit -m exec &&
@@ -122,21 +124,21 @@ test_expect_success 'special modes' '
 	(
 	cd gitrepo &&
 	git pull
-	git ls-tree HEAD > ../actual
+	git ls-tree HEAD >../actual
 	) &&
=20
 	test_cmp expected actual &&
=20
 	(
 	cd gitrepo &&
-	git cat-file -p HEAD:link > ../actual
+	git cat-file -p HEAD:link >../actual
 	) &&
=20
-	printf content > expected &&
+	printf content >expected &&
 	test_cmp expected actual
 '
=20
-cat > expected <<EOF
+cat >expected <<\EOF
 100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
 100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
 120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
@@ -147,8 +149,8 @@ test_expect_success 'moving directory' '
 	(
 	cd bzrrepo &&
 	mkdir movedir &&
-	echo one > movedir/one &&
-	echo two > movedir/two &&
+	echo one >movedir/one &&
+	echo two >movedir/two &&
 	bzr add movedir &&
 	bzr commit -m movedir &&
 	bzr mv movedir movedir-new &&
@@ -158,7 +160,7 @@ test_expect_success 'moving directory' '
 	(
 	cd gitrepo &&
 	git pull &&
-	git ls-tree HEAD > ../actual
+	git ls-tree HEAD >../actual
 	) &&
=20
 	test_cmp expected actual
@@ -167,7 +169,7 @@ test_expect_success 'moving directory' '
 test_expect_success 'different authors' '
 	(
 	cd bzrrepo &&
-	echo john >> content &&
+	echo john >>content &&
 	bzr commit -m john \
 	  --author "Jane Rey <jrey@example.com>" \
 	  --author "John Doe <jdoe@example.com>"
@@ -176,10 +178,10 @@ test_expect_success 'different authors' '
 	(
 	cd gitrepo &&
 	git pull &&
-	git show --format=3D"%an <%ae>, %cn <%ce>" --quiet > ../actual
+	git show --format=3D"%an <%ae>, %cn <%ce>" --quiet >../actual
 	) &&
=20
-	echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" > e=
xpected &&
+	echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" >ex=
pected &&
 	test_cmp expected actual
 '
=20
@@ -196,12 +198,12 @@ test_expect_success 'fetch utf-8 filenames' '
 	bzr init bzrrepo &&
 	cd bzrrepo &&
=20
-	echo test >> "=C3=A6r=C3=B8" &&
+	echo test >>"=C3=A6r=C3=B8" &&
 	bzr add "=C3=A6r=C3=B8" &&
-	echo test >> "=C3=B8~?" &&
+	echo test >>"=C3=B8~?" &&
 	bzr add "=C3=B8~?" &&
 	bzr commit -m add-utf-8 &&
-	echo test >> "=C3=A6r=C3=B8" &&
+	echo test >>"=C3=A6r=C3=B8" &&
 	bzr commit -m test-utf-8 &&
 	bzr rm "=C3=B8~?" &&
 	bzr mv "=C3=A6r=C3=B8" "=C3=B8~?" &&
@@ -211,9 +213,9 @@ test_expect_success 'fetch utf-8 filenames' '
 	(
 	git clone "bzr::bzrrepo" gitrepo &&
 	cd gitrepo &&
-	git -c core.quotepath=3Dfalse ls-files > ../actual
+	git -c core.quotepath=3Dfalse ls-files >../actual
 	) &&
-	echo "=C3=B8~?" > expected &&
+	echo "=C3=B8~?" >expected &&
 	test_cmp expected actual
 '
=20
@@ -229,7 +231,7 @@ test_expect_success 'push utf-8 filenames' '
 	bzr init bzrrepo &&
 	cd bzrrepo &&
=20
-	echo one >> content &&
+	echo one >>content &&
 	bzr add content &&
 	bzr commit -m one
 	) &&
@@ -238,15 +240,15 @@ test_expect_success 'push utf-8 filenames' '
 	git clone "bzr::bzrrepo" gitrepo &&
 	cd gitrepo &&
=20
-	echo test >> "=C3=A6r=C3=B8" &&
+	echo test >>"=C3=A6r=C3=B8" &&
 	git add "=C3=A6r=C3=B8" &&
 	git commit -m utf-8 &&
=20
 	git push
 	) &&
=20
-	(cd bzrrepo && bzr ls > ../actual) &&
-	printf "content\n=C3=A6r=C3=B8\n" > expected &&
+	(cd bzrrepo && bzr ls >../actual) &&
+	printf "content\n=C3=A6r=C3=B8\n" >expected &&
 	test_cmp expected actual
 '
=20
@@ -256,7 +258,7 @@ test_expect_success 'pushing a merge' '
 	(
 	bzr init bzrrepo &&
 	cd bzrrepo &&
-	echo one > content &&
+	echo one >content &&
 	bzr add content &&
 	bzr commit -m one
 	) &&
@@ -265,27 +267,27 @@ test_expect_success 'pushing a merge' '
=20
 	(
 	cd bzrrepo &&
-	echo two > content &&
+	echo two >content &&
 	bzr commit -m two
 	) &&
=20
 	(
 	cd gitrepo &&
-	echo three > content &&
+	echo three >content &&
 	git commit -a -m three &&
 	git fetch &&
 	git merge origin/master || true &&
-	echo three > content &&
+	echo three >content &&
 	git commit -a --no-edit &&
 	git push
 	) &&
=20
-	echo three > expected &&
-	cat bzrrepo/content > actual &&
+	echo three >expected &&
+	cat bzrrepo/content >actual &&
 	test_cmp expected actual
 '
=20
-cat > expected <<EOF
+cat >expected <<\EOF
 origin/HEAD
 origin/branch
 origin/trunk
@@ -299,7 +301,7 @@ test_expect_success 'proper bzr repo' '
 	(
 	bzr init bzrrepo/trunk &&
 	cd bzrrepo/trunk &&
-	echo one >> content &&
+	echo one >>content &&
 	bzr add content &&
 	bzr commit -m one
 	) &&
@@ -307,14 +309,14 @@ test_expect_success 'proper bzr repo' '
 	(
 	bzr branch bzrrepo/trunk bzrrepo/branch &&
 	cd bzrrepo/branch &&
-	echo two >> content &&
+	echo two >>content &&
 	bzr commit -m one
 	) &&
=20
 	(
 	git clone "bzr::bzrrepo" gitrepo &&
 	cd gitrepo &&
-	git for-each-ref --format "%(refname:short)" refs/remotes/origin > ..=
/actual
+	git for-each-ref --format "%(refname:short)" refs/remotes/origin >../=
actual
 	) &&
=20
 	test_cmp expected actual
@@ -327,11 +329,11 @@ test_expect_success 'strip' '
 	bzr init bzrrepo &&
 	cd bzrrepo &&
=20
-	echo one >> content &&
+	echo one >>content &&
 	bzr add content &&
 	bzr commit -m one &&
=20
-	echo two >> content &&
+	echo two >>content &&
 	bzr commit -m two
 	) &&
=20
@@ -341,18 +343,18 @@ test_expect_success 'strip' '
 	cd bzrrepo &&
 	bzr uncommit --force &&
=20
-	echo three >> content &&
+	echo three >>content &&
 	bzr commit -m three &&
=20
-	echo four >> content &&
+	echo four >>content &&
 	bzr commit -m four &&
-	bzr log --line | sed -e "s/^[0-9][0-9]*: //" > ../expected
+	bzr log --line | sed -e "s/^[0-9][0-9]*: //" >../expected
 	) &&
=20
 	(
 	cd gitrepo &&
 	git fetch &&
-	git log --format=3D"%an %ad %s" --date=3Dshort origin/master > ../act=
ual
+	git log --format=3D"%an %ad %s" --date=3Dshort origin/master >../actu=
al
 	) &&
=20
 	test_cmp expected actual
@@ -372,7 +374,7 @@ test_expect_success 'export utf-8 authors' '
 	(
 	git init gitrepo &&
 	cd gitrepo &&
-	echo greg >> content &&
+	echo greg >>content &&
 	git add content &&
 	git commit -m one &&
 	git remote add bzr "bzr::../bzrrepo" &&
@@ -381,10 +383,10 @@ test_expect_success 'export utf-8 authors' '
=20
 	(
 	cd bzrrepo &&
-	bzr log | grep "^committer: " > ../actual
+	bzr log | grep "^committer: " >../actual
 	) &&
=20
-	echo "committer: Gr=C3=A9goire <committer@example.com>" > expected &&
+	echo "committer: Gr=C3=A9goire <committer@example.com>" >expected &&
 	test_cmp expected actual
 '
=20
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
index f83d67d..e24c51d 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -10,12 +10,14 @@ test_description=3D'Test bidirectionality of remote=
-hg'
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq PYTHON; then
+if ! test_have_prereq PYTHON
+then
 	skip_all=3D'skipping remote-hg tests; python not available'
 	test_done
 fi
=20
-if ! python -c 'import mercurial'; then
+if ! python -c 'import mercurial'
+then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
@@ -43,7 +45,7 @@ hg_push () {
 	git checkout -q -b tmp &&
 	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
 	git checkout -q @{-1} &&
-	git branch -q -D tmp 2> /dev/null || true
+	git branch -q -D tmp 2>/dev/null || true
 	)
 }
=20
@@ -62,7 +64,7 @@ setup () {
 	echo "tag =3D -d \"0 0\""
 	echo "[extensions]"
 	echo "graphlog =3D"
-	) >> "$HOME"/.hgrc &&
+	) >>"$HOME"/.hgrc &&
 	git config --global remote-hg.hg-git-compat true
 	git config --global remote-hg.track-branches true
=20
@@ -81,22 +83,22 @@ test_expect_success 'encoding' '
 	git init -q gitrepo &&
 	cd gitrepo &&
=20
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add =C3=A4lph=C3=A0" &&
=20
 	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
 	export GIT_AUTHOR_NAME &&
-	echo beta > beta &&
+	echo beta >beta &&
 	git add beta &&
 	git commit -m "add beta" &&
=20
-	echo gamma > gamma &&
+	echo gamma >gamma &&
 	git add gamma &&
 	git commit -m "add g=C3=A4mm=C3=A2" &&
=20
 	: TODO git config i18n.commitencoding latin-1 &&
-	echo delta > delta &&
+	echo delta >delta &&
 	git add delta &&
 	git commit -m "add d=C3=A9lt=C3=A0"
 	) &&
@@ -105,8 +107,8 @@ test_expect_success 'encoding' '
 	git_clone hgrepo gitrepo2 &&
 	hg_clone gitrepo2 hgrepo2 &&
=20
-	HGENCODING=3Dutf-8 hg_log hgrepo > expected &&
-	HGENCODING=3Dutf-8 hg_log hgrepo2 > actual &&
+	HGENCODING=3Dutf-8 hg_log hgrepo >expected &&
+	HGENCODING=3Dutf-8 hg_log hgrepo2 >actual &&
=20
 	test_cmp expected actual
 '
@@ -117,14 +119,14 @@ test_expect_success 'file removal' '
 	(
 	git init -q gitrepo &&
 	cd gitrepo &&
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add alpha" &&
-	echo beta > beta &&
+	echo beta >beta &&
 	git add beta &&
 	git commit -m "add beta"
 	mkdir foo &&
-	echo blah > foo/bar &&
+	echo blah >foo/bar &&
 	git add foo &&
 	git commit -m "add foo" &&
 	git rm alpha &&
@@ -137,8 +139,8 @@ test_expect_success 'file removal' '
 	git_clone hgrepo gitrepo2 &&
 	hg_clone gitrepo2 hgrepo2 &&
=20
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
+	hg_log hgrepo >expected &&
+	hg_log hgrepo2 >actual &&
=20
 	test_cmp expected actual
 '
@@ -150,12 +152,12 @@ test_expect_success 'git tags' '
 	git init -q gitrepo &&
 	cd gitrepo &&
 	git config receive.denyCurrentBranch ignore &&
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add alpha" &&
 	git tag alpha &&
=20
-	echo beta > beta &&
+	echo beta >beta &&
 	git add beta &&
 	git commit -m "add beta" &&
 	git tag -a -m "added tag beta" beta
@@ -165,8 +167,8 @@ test_expect_success 'git tags' '
 	git_clone hgrepo gitrepo2 &&
 	hg_clone gitrepo2 hgrepo2 &&
=20
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
+	hg_log hgrepo >expected &&
+	hg_log hgrepo2 >actual &&
=20
 	test_cmp expected actual
 '
@@ -178,7 +180,7 @@ test_expect_success 'hg branch' '
 	git init -q gitrepo &&
 	cd gitrepo &&
=20
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -q -m "add alpha" &&
 	git checkout -q -b not-master
@@ -201,8 +203,8 @@ test_expect_success 'hg branch' '
 	: Back to the common revision &&
 	(cd hgrepo && hg checkout default) &&
=20
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
+	hg_log hgrepo >expected &&
+	hg_log hgrepo2 >actual &&
=20
 	test_cmp expected actual
 '
@@ -214,7 +216,7 @@ test_expect_success 'hg tags' '
 	git init -q gitrepo &&
 	cd gitrepo &&
=20
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add alpha" &&
 	git checkout -q -b not-master
@@ -231,8 +233,8 @@ test_expect_success 'hg tags' '
 	hg_push hgrepo gitrepo &&
 	hg_clone gitrepo hgrepo2 &&
=20
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
+	hg_log hgrepo >expected &&
+	hg_log hgrepo2 >actual &&
=20
 	test_cmp expected actual
 '
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-=
helpers/test-hg-hg-git.sh
index 2219284..a5123ca 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -10,17 +10,20 @@ test_description=3D'Test remote-hg output compared =
to hg-git'
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq PYTHON; then
+if ! test_have_prereq PYTHON
+then
 	skip_all=3D'skipping remote-hg tests; python not available'
 	test_done
 fi
=20
-if ! python -c 'import mercurial'; then
+if ! python -c 'import mercurial'
+then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
=20
-if ! python -c 'import hggit'; then
+if ! python -c 'import hggit'
+then
 	skip_all=3D'skipping remote-hg tests; hg-git not available'
 	test_done
 fi
@@ -66,7 +69,7 @@ hg_push_git () {
 	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs=
/heads/*' &&
 	git branch -D default &&
 	git checkout -q @{-1} &&
-	git branch -q -D tmp 2> /dev/null || true
+	git branch -q -D tmp 2>/dev/null || true
 	)
 }
=20
@@ -100,7 +103,7 @@ setup () {
 	echo "hgext.bookmarks =3D"
 	echo "hggit =3D"
 	echo "graphlog =3D"
-	) >> "$HOME"/.hgrc &&
+	) >>"$HOME"/.hgrc &&
 	git config --global receive.denycurrentbranch warn
 	git config --global remote-hg.hg-git-compat true
 	git config --global remote-hg.track-branches false
@@ -121,7 +124,7 @@ test_expect_success 'executable bit' '
 	(
 	git init -q gitrepo &&
 	cd gitrepo &&
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	chmod 0644 alpha &&
 	git add alpha &&
 	git commit -m "add alpha" &&
@@ -133,17 +136,18 @@ test_expect_success 'executable bit' '
 	git commit -m "clear executable bit"
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		(
 		hg_clone_$x gitrepo hgrepo-$x &&
 		cd hgrepo-$x &&
 		hg_log . &&
 		hg manifest -r 1 -v &&
 		hg manifest -v
-		) > output-$x &&
+		) >output-$x &&
=20
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
+		git_log gitrepo2-$x >log-$x
 	done &&
=20
 	test_cmp output-hg output-git &&
@@ -156,7 +160,7 @@ test_expect_success 'symlink' '
 	(
 	git init -q gitrepo &&
 	cd gitrepo &&
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add alpha" &&
 	ln -s alpha beta &&
@@ -164,16 +168,17 @@ test_expect_success 'symlink' '
 	git commit -m "add beta"
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		(
 		hg_clone_$x gitrepo hgrepo-$x &&
 		cd hgrepo-$x &&
 		hg_log . &&
 		hg manifest -v
-		) > output-$x &&
+		) >output-$x &&
=20
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
+		git_log gitrepo2-$x >log-$x
 	done &&
=20
 	test_cmp output-hg output-git &&
@@ -186,28 +191,29 @@ test_expect_success 'merge conflict 1' '
 	(
 	hg init hgrepo1 &&
 	cd hgrepo1 &&
-	echo A > afile &&
+	echo A >afile &&
 	hg add afile &&
 	hg ci -m "origin" &&
=20
-	echo B > afile &&
+	echo B >afile &&
 	hg ci -m "A->B" &&
=20
 	hg up -r0 &&
-	echo C > afile &&
+	echo C >afile &&
 	hg ci -m "A->C" &&
=20
 	hg merge -r1 &&
-	echo C > afile &&
+	echo C >afile &&
 	hg resolve -m afile &&
 	hg ci -m "merge to C"
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		git_clone_$x hgrepo1 gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
+		hg_log hgrepo2-$x >hg-log-$x &&
+		git_log gitrepo-$x >git-log-$x
 	done &&
=20
 	test_cmp hg-log-hg hg-log-git &&
@@ -220,28 +226,29 @@ test_expect_success 'merge conflict 2' '
 	(
 	hg init hgrepo1 &&
 	cd hgrepo1 &&
-	echo A > afile &&
+	echo A >afile &&
 	hg add afile &&
 	hg ci -m "origin" &&
=20
-	echo B > afile &&
+	echo B >afile &&
 	hg ci -m "A->B" &&
=20
 	hg up -r0 &&
-	echo C > afile &&
+	echo C >afile &&
 	hg ci -m "A->C" &&
=20
 	hg merge -r1 || true &&
-	echo B > afile &&
+	echo B >afile &&
 	hg resolve -m afile &&
 	hg ci -m "merge to B"
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		git_clone_$x hgrepo1 gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
+		hg_log hgrepo2-$x >hg-log-$x &&
+		git_log gitrepo-$x >git-log-$x
 	done &&
=20
 	test_cmp hg-log-hg hg-log-git &&
@@ -254,29 +261,30 @@ test_expect_success 'converged merge' '
 	(
 	hg init hgrepo1 &&
 	cd hgrepo1 &&
-	echo A > afile &&
+	echo A >afile &&
 	hg add afile &&
 	hg ci -m "origin" &&
=20
-	echo B > afile &&
+	echo B >afile &&
 	hg ci -m "A->B" &&
=20
-	echo C > afile &&
+	echo C >afile &&
 	hg ci -m "B->C" &&
=20
 	hg up -r0 &&
-	echo C > afile &&
+	echo C >afile &&
 	hg ci -m "A->C" &&
=20
 	hg merge -r2 || true &&
 	hg ci -m "merge"
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		git_clone_$x hgrepo1 gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
+		hg_log hgrepo2-$x >hg-log-$x &&
+		git_log gitrepo-$x >git-log-$x
 	done &&
=20
 	test_cmp hg-log-hg hg-log-git &&
@@ -290,32 +298,33 @@ test_expect_success 'encoding' '
 	git init -q gitrepo &&
 	cd gitrepo &&
=20
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add =C3=A4lph=C3=A0" &&
=20
 	GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
 	export GIT_AUTHOR_NAME &&
-	echo beta > beta &&
+	echo beta >beta &&
 	git add beta &&
 	git commit -m "add beta" &&
=20
-	echo gamma > gamma &&
+	echo gamma >gamma &&
 	git add gamma &&
 	git commit -m "add g=C3=A4mm=C3=A2" &&
=20
 	: TODO git config i18n.commitencoding latin-1 &&
-	echo delta > delta &&
+	echo delta >delta &&
 	git add delta &&
 	git commit -m "add d=C3=A9lt=C3=A0"
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		hg_clone_$x gitrepo hgrepo-$x &&
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
=20
-		HGENCODING=3Dutf-8 hg_log hgrepo-$x > hg-log-$x &&
-		git_log gitrepo2-$x > git-log-$x
+		HGENCODING=3Dutf-8 hg_log hgrepo-$x >hg-log-$x &&
+		git_log gitrepo2-$x >git-log-$x
 	done &&
=20
 	test_cmp hg-log-hg hg-log-git &&
@@ -328,14 +337,14 @@ test_expect_success 'file removal' '
 	(
 	git init -q gitrepo &&
 	cd gitrepo &&
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add alpha" &&
-	echo beta > beta &&
+	echo beta >beta &&
 	git add beta &&
 	git commit -m "add beta"
 	mkdir foo &&
-	echo blah > foo/bar &&
+	echo blah >foo/bar &&
 	git add foo &&
 	git commit -m "add foo" &&
 	git rm alpha &&
@@ -344,17 +353,18 @@ test_expect_success 'file removal' '
 	git commit -m "remove foo/bar"
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		(
 		hg_clone_$x gitrepo hgrepo-$x &&
 		cd hgrepo-$x &&
 		hg_log . &&
 		hg manifest -r 3 &&
 		hg manifest
-		) > output-$x &&
+		) >output-$x &&
=20
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
+		git_log gitrepo2-$x >log-$x
 	done &&
=20
 	test_cmp output-hg output-git &&
@@ -368,20 +378,21 @@ test_expect_success 'git tags' '
 	git init -q gitrepo &&
 	cd gitrepo &&
 	git config receive.denyCurrentBranch ignore &&
-	echo alpha > alpha &&
+	echo alpha >alpha &&
 	git add alpha &&
 	git commit -m "add alpha" &&
 	git tag alpha &&
=20
-	echo beta > beta &&
+	echo beta >beta &&
 	git add beta &&
 	git commit -m "add beta" &&
 	git tag -a -m "added tag beta" beta
 	) &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		hg_clone_$x gitrepo hgrepo-$x &&
-		hg_log hgrepo-$x > log-$x
+		hg_log hgrepo-$x >log-$x
 	done &&
=20
 	test_cmp log-hg log-git
@@ -390,12 +401,13 @@ test_expect_success 'git tags' '
 test_expect_success 'hg author' '
 	test_when_finished "rm -rf gitrepo* hgrepo*" &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		(
 		git init -q gitrepo-$x &&
 		cd gitrepo-$x &&
=20
-		echo alpha > alpha &&
+		echo alpha >alpha &&
 		git add alpha &&
 		git commit -m "add alpha" &&
 		git checkout -q -b not-master
@@ -406,38 +418,38 @@ test_expect_success 'hg author' '
 		cd hgrepo-$x &&
=20
 		hg co master &&
-		echo beta > beta &&
+		echo beta >beta &&
 		hg add beta &&
 		hg commit -u "test" -m "add beta" &&
=20
-		echo gamma >> beta &&
+		echo gamma >>beta &&
 		hg commit -u "test <test@example.com> (comment)" -m "modify beta" &&
=20
-		echo gamma > gamma &&
+		echo gamma >gamma &&
 		hg add gamma &&
 		hg commit -u "<test@example.com>" -m "add gamma" &&
=20
-		echo delta > delta &&
+		echo delta >delta &&
 		hg add delta &&
 		hg commit -u "name<test@example.com>" -m "add delta" &&
=20
-		echo epsilon > epsilon &&
+		echo epsilon >epsilon &&
 		hg add epsilon &&
 		hg commit -u "name <test@example.com" -m "add epsilon" &&
=20
-		echo zeta > zeta &&
+		echo zeta >zeta &&
 		hg add zeta &&
 		hg commit -u " test " -m "add zeta" &&
=20
-		echo eta > eta &&
+		echo eta >eta &&
 		hg add eta &&
 		hg commit -u "test < test@example.com >" -m "add eta" &&
=20
-		echo theta > theta &&
+		echo theta >theta &&
 		hg add theta &&
 		hg commit -u "test >test@example.com>" -m "add theta" &&
=20
-		echo iota > iota &&
+		echo iota >iota &&
 		hg add iota &&
 		hg commit -u "test <test <at> example <dot> com>" -m "add iota"
 		) &&
@@ -445,8 +457,8 @@ test_expect_success 'hg author' '
 		hg_push_$x hgrepo-$x gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
=20
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
+		hg_log hgrepo2-$x >hg-log-$x &&
+		git_log gitrepo-$x >git-log-$x
 	done &&
=20
 	test_cmp hg-log-hg hg-log-git &&
@@ -456,12 +468,13 @@ test_expect_success 'hg author' '
 test_expect_success 'hg branch' '
 	test_when_finished "rm -rf gitrepo* hgrepo*" &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		(
 		git init -q gitrepo-$x &&
 		cd gitrepo-$x &&
=20
-		echo alpha > alpha &&
+		echo alpha >alpha &&
 		git add alpha &&
 		git commit -q -m "add alpha" &&
 		git checkout -q -b not-master
@@ -481,8 +494,8 @@ test_expect_success 'hg branch' '
 		hg_push_$x hgrepo-$x gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
=20
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
+		hg_log hgrepo2-$x >hg-log-$x &&
+		git_log gitrepo-$x >git-log-$x
 	done &&
=20
 	test_cmp hg-log-hg hg-log-git &&
@@ -492,12 +505,13 @@ test_expect_success 'hg branch' '
 test_expect_success 'hg tags' '
 	test_when_finished "rm -rf gitrepo* hgrepo*" &&
=20
-	for x in hg git; do
+	for x in hg git
+	do
 		(
 		git init -q gitrepo-$x &&
 		cd gitrepo-$x &&
=20
-		echo alpha > alpha &&
+		echo alpha >alpha &&
 		git add alpha &&
 		git commit -m "add alpha" &&
 		git checkout -q -b not-master
@@ -518,7 +532,7 @@ test_expect_success 'hg tags' '
 		git --git-dir=3Dgitrepo-$x/.git tag -l &&
 		hg_log hgrepo2-$x &&
 		cat hgrepo2-$x/.hgtags
-		) > output-$x
+		) >output-$x
 	done &&
=20
 	test_cmp output-hg output-git
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index 5a6f745..72f745d 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -10,40 +10,44 @@ test_description=3D'Test remote-hg'
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq PYTHON; then
+if ! test_have_prereq PYTHON
+then
 	skip_all=3D'skipping remote-hg tests; python not available'
 	test_done
 fi
=20
-if ! python -c 'import mercurial'; then
+if ! python -c 'import mercurial'
+then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
=20
 check () {
-	echo $3 > expected &&
-	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 > actual
+	echo $3 >expected &&
+	git --git-dir=3D$1/.git log --format=3D'%s' -1 $2 >actual
 	test_cmp expected actual
 }
=20
 check_branch () {
-	if [ -n "$3" ]; then
-		echo $3 > expected &&
-		hg -R $1 log -r $2 --template '{desc}\n' > actual &&
+	if test -n "$3"
+	then
+		echo $3 >expected &&
+		hg -R $1 log -r $2 --template '{desc}\n' >actual &&
 		test_cmp expected actual
 	else
-		hg -R $1 branches > out &&
+		hg -R $1 branches >out &&
 		! grep $2 out
 	fi
 }
=20
 check_bookmark () {
-	if [ -n "$3" ]; then
-		echo $3 > expected &&
-		hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' > actual &&
+	if test -n "$3"
+	then
+		echo $3 >expected &&
+		hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' >actual &&
 		test_cmp expected actual
 	else
-		hg -R $1 bookmarks > out &&
+		hg -R $1 bookmarks >out &&
 		! grep $2 out
 	fi
 }
@@ -52,7 +56,7 @@ check_push () {
 	local expected_ret=3D$1 ret=3D0 ref_ret=3D0 IFS=3D':'
=20
 	shift
-	git push origin "$@" 2> error
+	git push origin "$@" 2>error
 	ret=3D$?
 	cat error
=20
@@ -92,7 +96,7 @@ setup () {
 	echo "username =3D H G Wells <wells@example.com>"
 	echo "[extensions]"
 	echo "mq =3D"
-	) >> "$HOME"/.hgrc &&
+	) >>"$HOME"/.hgrc &&
=20
 	GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230" &&
 	GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE" &&
@@ -107,7 +111,7 @@ test_expect_success 'cloning' '
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
-	echo zero > content &&
+	echo zero >content &&
 	hg add content &&
 	hg commit -m zero
 	) &&
@@ -122,7 +126,7 @@ test_expect_success 'cloning with branches' '
 	(
 	cd hgrepo &&
 	hg branch next &&
-	echo next > content &&
+	echo next >content &&
 	hg commit -m next
 	) &&
=20
@@ -137,7 +141,7 @@ test_expect_success 'cloning with bookmarks' '
 	cd hgrepo &&
 	hg checkout default &&
 	hg bookmark feature-a &&
-	echo feature-a > content &&
+	echo feature-a >content &&
 	hg commit -m feature-a
 	) &&
=20
@@ -157,7 +161,7 @@ test_expect_success 'update bookmark' '
 	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
 	git checkout --quiet devel &&
-	echo devel > content &&
+	echo devel >content &&
 	git commit -a -m devel &&
 	git push --quiet
 	) &&
@@ -172,7 +176,7 @@ test_expect_success 'new bookmark' '
 	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
 	git checkout --quiet -b feature-b &&
-	echo feature-b > content &&
+	echo feature-b >content &&
 	git commit -a -m feature-b &&
 	git push --quiet origin feature-b
 	) &&
@@ -184,9 +188,9 @@ test_expect_success 'new bookmark' '
 rm -rf hgrepo
=20
 author_test () {
-	echo $1 >> content &&
+	echo $1 >>content &&
 	hg commit -u "$2" -m "add $1" &&
-	echo "$3" >> ../expected
+	echo "$3" >>../expected
 }
=20
 test_expect_success 'authors' '
@@ -199,7 +203,7 @@ test_expect_success 'authors' '
 	touch content &&
 	hg add content &&
=20
-	> ../expected &&
+	>../expected &&
 	author_test alpha "" "H G Wells <wells@example.com>" &&
 	author_test beta "test" "test <unknown>" &&
 	author_test beta "test <test@example.com> (comment)" "test <test@exam=
ple.com>" &&
@@ -214,7 +218,7 @@ test_expect_success 'authors' '
 	) &&
=20
 	git clone "hg::hgrepo" gitrepo &&
-	git --git-dir=3Dgitrepo/.git log --reverse --format=3D"%an <%ae>" > a=
ctual &&
+	git --git-dir=3Dgitrepo/.git log --reverse --format=3D"%an <%ae>" >ac=
tual &&
=20
 	test_cmp expected actual
 '
@@ -226,11 +230,11 @@ test_expect_success 'strip' '
 	hg init hgrepo &&
 	cd hgrepo &&
=20
-	echo one >> content &&
+	echo one >>content &&
 	hg add content &&
 	hg commit -m one &&
=20
-	echo two >> content &&
+	echo two >>content &&
 	hg commit -m two
 	) &&
=20
@@ -240,20 +244,20 @@ test_expect_success 'strip' '
 	cd hgrepo &&
 	hg strip 1 &&
=20
-	echo three >> content &&
+	echo three >>content &&
 	hg commit -m three &&
=20
-	echo four >> content &&
+	echo four >>content &&
 	hg commit -m four
 	) &&
=20
 	(
 	cd gitrepo &&
 	git fetch &&
-	git log --format=3D"%s" origin/master > ../actual
+	git log --format=3D"%s" origin/master >../actual
 	) &&
=20
-	hg -R hgrepo log --template "{desc}\n" > expected &&
+	hg -R hgrepo log --template "{desc}\n" >expected &&
 	test_cmp actual expected
 '
=20
@@ -263,18 +267,18 @@ test_expect_success 'remote push with master book=
mark' '
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
-	echo zero > content &&
+	echo zero >content &&
 	hg add content &&
 	hg commit -m zero &&
 	hg bookmark master &&
-	echo one > content &&
+	echo one >content &&
 	hg commit -m one
 	) &&
=20
 	(
 	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
-	echo two > content &&
+	echo two >content &&
 	git commit -a -m two &&
 	git push
 	) &&
@@ -282,7 +286,7 @@ test_expect_success 'remote push with master bookma=
rk' '
 	check_branch hgrepo default two
 '
=20
-cat > expected <<EOF
+cat >expected <<\EOF
 changeset:   0:6e2126489d3d
 tag:         tip
 user:        A U Thor <author@example.com>
@@ -300,13 +304,13 @@ test_expect_success 'remote push from master bran=
ch' '
 	git init gitrepo &&
 	cd gitrepo &&
 	git remote add origin "hg::../hgrepo" &&
-	echo one > content &&
+	echo one >content &&
 	git add content &&
 	git commit -a -m one &&
 	git push origin master
 	) &&
=20
-	hg -R hgrepo log > actual &&
+	hg -R hgrepo log >actual &&
 	cat actual &&
 	test_cmp expected actual &&
=20
@@ -322,7 +326,7 @@ test_expect_success 'remote cloning' '
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
-	echo zero > content &&
+	echo zero >content &&
 	hg add content &&
 	hg commit -m zero
 	) &&
@@ -343,7 +347,7 @@ test_expect_success 'remote update bookmark' '
 	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
 	git checkout --quiet devel &&
-	echo devel > content &&
+	echo devel >content &&
 	git commit -a -m devel &&
 	git push --quiet
 	) &&
@@ -358,7 +362,7 @@ test_expect_success 'remote new bookmark' '
 	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
 	git checkout --quiet -b feature-b &&
-	echo feature-b > content &&
+	echo feature-b >content &&
 	git commit -a -m feature-b &&
 	git push --quiet origin feature-b
 	) &&
@@ -374,15 +378,15 @@ test_expect_success 'remote push diverged' '
 	(
 	cd hgrepo &&
 	hg checkout default &&
-	echo bump > content &&
+	echo bump >content &&
 	hg commit -m bump
 	) &&
=20
 	(
 	cd gitrepo &&
-	echo diverge > content &&
+	echo diverge >content &&
 	git commit -a -m diverged &&
-	check_push 1 <<-EOF
+	check_push 1 <<-\EOF
 	master:non-fast-forward
 	EOF
 	) &&
@@ -403,16 +407,16 @@ test_expect_success 'remote update bookmark diver=
ge' '
=20
 	(
 	cd hgrepo &&
-	echo "bump bookmark" > content &&
+	echo "bump bookmark" >content &&
 	hg commit -m "bump bookmark"
 	) &&
=20
 	(
 	cd gitrepo &&
 	git checkout --quiet diverge &&
-	echo diverge > content &&
+	echo diverge >content &&
 	git commit -a -m diverge &&
-	check_push 1 <<-EOF
+	check_push 1 <<-\EOF
 	diverge:fetch-first
 	EOF
 	) &&
@@ -427,7 +431,7 @@ test_expect_success 'remote new bookmark multiple b=
ranch head' '
 	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
 	git checkout --quiet -b feature-c HEAD^ &&
-	echo feature-c > content &&
+	echo feature-c >content &&
 	git commit -a -m feature-c &&
 	git push --quiet origin feature-c
 	) &&
@@ -442,20 +446,20 @@ setup_big_push () {
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
-	echo zero > content &&
+	echo zero >content &&
 	hg add content &&
 	hg commit -m zero &&
 	hg bookmark bad_bmark1 &&
-	echo one > content &&
+	echo one >content &&
 	hg commit -m one &&
 	hg bookmark bad_bmark2 &&
 	hg bookmark good_bmark &&
 	hg bookmark -i good_bmark &&
 	hg -q branch good_branch &&
-	echo "good branch" > content &&
+	echo "good branch" >content &&
 	hg commit -m "good branch" &&
 	hg -q branch bad_branch &&
-	echo "bad branch" > content &&
+	echo "bad branch" >content &&
 	hg commit -m "bad branch"
 	) &&
=20
@@ -463,40 +467,40 @@ setup_big_push () {
=20
 	(
 	cd gitrepo &&
-	echo two > content &&
+	echo two >content &&
 	git commit -q -a -m two &&
=20
 	git checkout -q good_bmark &&
-	echo three > content &&
+	echo three >content &&
 	git commit -q -a -m three &&
=20
 	git checkout -q bad_bmark1 &&
 	git reset --hard HEAD^ &&
-	echo four > content &&
+	echo four >content &&
 	git commit -q -a -m four &&
=20
 	git checkout -q bad_bmark2 &&
 	git reset --hard HEAD^ &&
-	echo five > content &&
+	echo five >content &&
 	git commit -q -a -m five &&
=20
 	git checkout -q -b new_bmark master &&
-	echo six > content &&
+	echo six >content &&
 	git commit -q -a -m six &&
=20
 	git checkout -q branches/good_branch &&
-	echo seven > content &&
+	echo seven >content &&
 	git commit -q -a -m seven &&
-	echo eight > content &&
+	echo eight >content &&
 	git commit -q -a -m eight &&
=20
 	git checkout -q branches/bad_branch &&
 	git reset --hard HEAD^ &&
-	echo nine > content &&
+	echo nine >content &&
 	git commit -q -a -m nine &&
=20
 	git checkout -q -b branches/new_branch master &&
-	echo ten > content &&
+	echo ten >content &&
 	git commit -q -a -m ten
 	)
 }
@@ -509,7 +513,7 @@ test_expect_success 'remote big push' '
 	(
 	cd gitrepo &&
=20
-	check_push 1 --all <<-EOF
+	check_push 1 --all <<-\EOF
 	master
 	good_bmark
 	branches/good_branch
@@ -537,17 +541,17 @@ test_expect_success 'remote big push fetch first'=
 '
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
-	echo zero > content &&
+	echo zero >content &&
 	hg add content &&
 	hg commit -m zero &&
 	hg bookmark bad_bmark &&
 	hg bookmark good_bmark &&
 	hg bookmark -i good_bmark &&
 	hg -q branch good_branch &&
-	echo "good branch" > content &&
+	echo "good branch" >content &&
 	hg commit -m "good branch" &&
 	hg -q branch bad_branch &&
-	echo "bad branch" > content &&
+	echo "bad branch" >content &&
 	hg commit -m "bad branch"
 	) &&
=20
@@ -556,28 +560,28 @@ test_expect_success 'remote big push fetch first'=
 '
 	(
 	cd hgrepo &&
 	hg bookmark -f bad_bmark &&
-	echo update_bmark > content &&
+	echo update_bmark >content &&
 	hg commit -m "update bmark"
 	) &&
=20
 	(
 	cd gitrepo &&
-	echo two > content &&
+	echo two >content &&
 	git commit -q -a -m two &&
=20
 	git checkout -q good_bmark &&
-	echo three > content &&
+	echo three >content &&
 	git commit -q -a -m three &&
=20
 	git checkout -q bad_bmark &&
-	echo four > content &&
+	echo four >content &&
 	git commit -q -a -m four &&
=20
 	git checkout -q branches/bad_branch &&
-	echo five > content &&
+	echo five >content &&
 	git commit -q -a -m five &&
=20
-	check_push 1 --all <<-EOF &&
+	check_push 1 --all <<-\EOF &&
 	master
 	good_bmark
 	bad_bmark:fetch-first
@@ -586,7 +590,7 @@ test_expect_success 'remote big push fetch first' '
=20
 	git fetch &&
=20
-	check_push 1 --all <<-EOF
+	check_push 1 --all <<-\EOF
 	master
 	good_bmark
 	bad_bmark:non-fast-forward
@@ -603,7 +607,7 @@ test_expect_failure 'remote big push force' '
 	(
 	cd gitrepo &&
=20
-	check_push 0 --force --all <<-EOF
+	check_push 0 --force --all <<-\EOF
 	master
 	good_bmark
 	branches/good_branch
@@ -633,7 +637,7 @@ test_expect_failure 'remote big push dry-run' '
 	(
 	cd gitrepo &&
=20
-	check_push 1 --dry-run --all <<-EOF &&
+	check_push 1 --dry-run --all <<-\EOF &&
 	master
 	good_bmark
 	branches/good_branch
@@ -644,7 +648,7 @@ test_expect_failure 'remote big push dry-run' '
 	branches/bad_branch:non-fast-forward
 	EOF
=20
-	check_push 0 --dry-run master good_bmark new_bmark branches/good_bran=
ch branches/new_branch <<-EOF
+	check_push 0 --dry-run master good_bmark new_bmark branches/good_bran=
ch branches/new_branch <<-\EOF
 	master
 	good_bmark
 	branches/good_branch
@@ -669,10 +673,10 @@ test_expect_success 'remote double failed push' '
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
-	echo zero > content &&
+	echo zero >content &&
 	hg add content &&
 	hg commit -m zero &&
-	echo one > content &&
+	echo one >content &&
 	hg commit -m one
 	) &&
=20
@@ -680,7 +684,7 @@ test_expect_success 'remote double failed push' '
 	git clone "hg::hgrepo" gitrepo &&
 	cd gitrepo &&
 	git reset --hard HEAD^ &&
-	echo two > content &&
+	echo two >content &&
 	git commit -a -m two &&
 	test_expect_code 1 git push &&
 	test_expect_code 1 git push
--=20
1.8.4-335-g2c126a6
