From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 1/2] t0025: Rename the test files
Date: Sun, 29 Jun 2014 08:34:22 +0200
Message-ID: <53AFB36E.7060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 08:34:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X18h7-0001GN-Th
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 08:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbaF2Gea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2014 02:34:30 -0400
Received: from mout.web.de ([212.227.15.14]:54918 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbaF2Ge3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 02:34:29 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M9GHu-1WoSyL0jQk-00CiH3; Sun, 29 Jun 2014 08:34:27
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:5TdOhUjy4vPS56FNwixllZFHIoMBEY/7kotVzmuI+qRFT2XhlrD
 kDscq9I7mcF/MzmpHJfNdz75gngwGqANi8DOFi8CrxqfU2uuPn3ZPYpmUDMHQ+FPpkVmpX4
 4KqML+syGwI1I5jzP7P50+uKuJqeDOIB6SEnisL4CvNWLvVKb1iL4S2uUWkZrsiGuH2jSsz
 DKREAFX38QZvs8IiNuTHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252630>

The current test files are named one, two and three.
Make it clearer what the tests do and rename them into
LFonly, CRLFonly and LFwithNUL.

After the renaming we can see easier that we may want more test cases
for 2 types of files:
- files which have mixed LF and CRLF line endings,
- files which have mixed LF and CR line endings.

See commit fd6cce9e, "Add per-repository eol normalization" and
"the new safer autocrlf handling" in convert.c

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0025-crlf-auto.sh | 122 +++++++++++++++++++++++++------------------=
--------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index 28102de..c164b46 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -12,144 +12,144 @@ test_expect_success setup '
=20
 	git config core.autocrlf false &&
=20
-	for w in Hello world how are you; do echo $w; done >one &&
-	for w in I am very very fine thank you; do echo ${w}Q; done | q_to_cr=
 >two &&
-	for w in Oh here is a QNUL byte how alarming; do echo ${w}; done | q_=
to_nul >three &&
+	for w in Hello world how are you; do echo $w; done >LFonly &&
+	for w in I am very very fine thank you; do echo ${w}Q; done | q_to_cr=
 >CRLFonly &&
+	for w in Oh here is a QNUL byte how alarming; do echo ${w}; done | q_=
to_nul >LFwithNUL &&
 	git add . &&
=20
 	git commit -m initial &&
=20
-	one=3D$(git rev-parse HEAD:one) &&
-	two=3D$(git rev-parse HEAD:two) &&
-	three=3D$(git rev-parse HEAD:three) &&
+	LFonly=3D$(git rev-parse HEAD:LFonly) &&
+	CRLFonly=3D$(git rev-parse HEAD:CRLFonly) &&
+	LFwithNUL=3D$(git rev-parse HEAD:LFwithNUL) &&
=20
 	echo happy.
 '
=20
 test_expect_success 'default settings cause no changes' '
=20
-	rm -f .gitattributes tmp one two three &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git read-tree --reset -u HEAD &&
=20
-	! has_cr one &&
-	has_cr two &&
-	onediff=3D$(git diff one) &&
-	twodiff=3D$(git diff two) &&
-	threediff=3D$(git diff three) &&
-	test -z "$onediff" && test -z "$twodiff" && test -z "$threediff"
+	! has_cr LFonly &&
+	has_cr CRLFonly &&
+	LFonlydiff=3D$(git diff LFonly) &&
+	CRLFonlydiff=3D$(git diff CRLFonly) &&
+	LFwithNULdiff=3D$(git diff LFwithNUL) &&
+	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'crlf=3Dtrue causes a CRLF file to be normalized' =
'
=20
 	# Backwards compatibility check
-	rm -f .gitattributes tmp one two three &&
-	echo "two crlf" > .gitattributes &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
+	echo "CRLFonly crlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
 	# Note, "normalized" means that git will normalize it if added
-	has_cr two &&
-	twodiff=3D$(git diff two) &&
-	test -n "$twodiff"
+	has_cr CRLFonly &&
+	CRLFonlydiff=3D$(git diff CRLFonly) &&
+	test -n "$CRLFonlydiff"
 '
=20
 test_expect_success 'text=3Dtrue causes a CRLF file to be normalized' =
'
=20
-	rm -f .gitattributes tmp one two three &&
-	echo "two text" > .gitattributes &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
+	echo "CRLFonly text" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
 	# Note, "normalized" means that git will normalize it if added
-	has_cr two &&
-	twodiff=3D$(git diff two) &&
-	test -n "$twodiff"
+	has_cr CRLFonly &&
+	CRLFonlydiff=3D$(git diff CRLFonly) &&
+	test -n "$CRLFonlydiff"
 '
=20
 test_expect_success 'eol=3Dcrlf gives a normalized file CRLFs with aut=
ocrlf=3Dfalse' '
=20
-	rm -f .gitattributes tmp one two three &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf false &&
-	echo "one eol=3Dcrlf" > .gitattributes &&
+	echo "LFonly eol=3Dcrlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
-	has_cr one &&
-	onediff=3D$(git diff one) &&
-	test -z "$onediff"
+	has_cr LFonly &&
+	LFonlydiff=3D$(git diff LFonly) &&
+	test -z "$LFonlydiff"
 '
=20
 test_expect_success 'eol=3Dcrlf gives a normalized file CRLFs with aut=
ocrlf=3Dinput' '
=20
-	rm -f .gitattributes tmp one two three &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf input &&
-	echo "one eol=3Dcrlf" > .gitattributes &&
+	echo "LFonly eol=3Dcrlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
-	has_cr one &&
-	onediff=3D$(git diff one) &&
-	test -z "$onediff"
+	has_cr LFonly &&
+	LFonlydiff=3D$(git diff LFonly) &&
+	test -z "$LFonlydiff"
 '
=20
 test_expect_success 'eol=3Dlf gives a normalized file LFs with autocrl=
f=3Dtrue' '
=20
-	rm -f .gitattributes tmp one two three &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
-	echo "one eol=3Dlf" > .gitattributes &&
+	echo "LFonly eol=3Dlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
-	! has_cr one &&
-	onediff=3D$(git diff one) &&
-	test -z "$onediff"
+	! has_cr LFonly &&
+	LFonlydiff=3D$(git diff LFonly) &&
+	test -z "$LFonlydiff"
 '
=20
 test_expect_success 'autocrlf=3Dtrue does not normalize CRLF files' '
=20
-	rm -f .gitattributes tmp one two three &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
=20
-	has_cr one &&
-	has_cr two &&
-	onediff=3D$(git diff one) &&
-	twodiff=3D$(git diff two) &&
-	threediff=3D$(git diff three) &&
-	test -z "$onediff" && test -z "$twodiff" && test -z "$threediff"
+	has_cr LFonly &&
+	has_cr CRLFonly &&
+	LFonlydiff=3D$(git diff LFonly) &&
+	CRLFonlydiff=3D$(git diff CRLFonly) &&
+	LFwithNULdiff=3D$(git diff LFwithNUL) &&
+	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue _does_ normalize CRL=
=46 files' '
=20
-	rm -f .gitattributes tmp one two three &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
 	echo "* text=3Dauto" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
-	has_cr one &&
-	has_cr two &&
-	onediff=3D$(git diff one) &&
-	twodiff=3D$(git diff two) &&
-	threediff=3D$(git diff three) &&
-	test -z "$onediff" && test -n "$twodiff" && test -z "$threediff"
+	has_cr LFonly &&
+	has_cr CRLFonly &&
+	LFonlydiff=3D$(git diff LFonly) &&
+	CRLFonlydiff=3D$(git diff CRLFonly) &&
+	LFwithNULdiff=3D$(git diff LFwithNUL) &&
+	test -z "$LFonlydiff" -a -n "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'text=3Dauto, autocrlf=3Dtrue does not normalize b=
inary files' '
=20
-	rm -f .gitattributes tmp one two three &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	git config core.autocrlf true &&
 	echo "* text=3Dauto" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
-	! has_cr three &&
-	threediff=3D$(git diff three) &&
-	test -z "$threediff"
+	! has_cr LFwithNUL &&
+	LFwithNULdiff=3D$(git diff LFwithNUL) &&
+	test -z "$LFwithNULdiff"
 '
=20
 test_expect_success 'eol=3Dcrlf _does_ normalize binary files' '
=20
-	rm -f .gitattributes tmp one two three &&
-	echo "three eol=3Dcrlf" > .gitattributes &&
+	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
+	echo "LFwithNUL eol=3Dcrlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
=20
-	has_cr three &&
-	threediff=3D$(git diff three) &&
-	test -z "$threediff"
+	has_cr LFwithNUL &&
+	LFwithNULdiff=3D$(git diff LFwithNUL) &&
+	test -z "$LFwithNULdiff"
 '
=20
 test_done
--=20
2.0.0.9631.g7e872d2
