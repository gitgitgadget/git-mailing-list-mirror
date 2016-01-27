From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 20/20] mingw: do not bother to test funny file names
Date: Wed, 27 Jan 2016 17:20:26 +0100 (CET)
Message-ID: <c94cd23f349a48b7c461b16123fa18733f6a2d44.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-938498975-1453911626=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpo-00034K-7H
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbcA0QUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:51523 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934104AbcA0QU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:20:29 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M7HGA-1aCig038Ny-00x4N1; Wed, 27 Jan 2016 17:20:26
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mLan9opoEhYqS3BntKyVcVLhFxLWtCQvTSNAaUfKD5tReaFB1PC
 q9TVTU05x+x8hgCaWwM8Mi8Q/AtqABMxDjY36G1FTypXgzyq/JGcP1bv4/iScINhJOdmh8u
 UhIZxW+IWJPORZnRyjYulxyfA29DF+oB1u59LeVWj8brCdKq0jodjMW7FrOSjWmWgWRYeZX
 tdso7yeL5AjFm2aVoYkdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vw5DY3RjD7Y=:3sHl7GZR1Oyp714VOcALsc
 PFQkeapUVbeeBCZ8KeCNitGnna+AZqF8IOck15DxTuLijS0oFvEUMdANKIDaed6wrSMtLhI1z
 PLzHckv3bhEhl9t8o7VTYmbS+7fq5K8q3c+Sv9frEwzLTiIoYaGRkGtwFkvSf2VWvO7OiUQvL
 JL9IaHwRFhcfCKOnFeCgxq1wWiTuFd8KP0ChzbfxeNW1msec/phSC1eantAT2WhG3TkBGjbhw
 dFOJU6fJRuHTON38MoXRkw8wGWOrsL1HrXiSuE2JENJOU8OJezcbrg04HYUcjUmYy97cMzT1t
 9raSL1g6NJokx6HDcWdaw4N/TIY4cxyeb/roxSwTknKRMHVS8AQ4AlY5Pxz5pxqzIUYH2fNWm
 U55SgRDB1DqYsWZ4iEWRazR8c5YYtbAcfvB5wXCDlfZE9tDrPzhgiaLdFWlslgts1orhDaaaO
 yFnixgreAe0cbgiDFzbwC4nJq4rZZwK+ieLcf1zUhKnESibaaUwcGOMKFNGo3TA+oldk8MOqc
 fwAzHpWB5ZJXX/mn5L18Db/hnCrwr5VDNqwUtBzOgLKsT4Uddwwel34JAujcKneD4LbCnu2lS
 bBv0jxRK20futTHoHCxyu+Ridy+PWe6tjCN6oWQZbAkTkXYa5jBUW4DtsDXs+LY8OjRIG0zbB
 DpkghenjRzVJ/27iXh/uDY8IGCE0pPiR9dILoFEfQfCP93hdYx08yI0/2Cre2ayu/edC4i7qq
 sr00PBrqfX6hlnwt/UBLng8E1aOhwpk+WhWpTxaamxo2K23FeUUoIPj4SikWuYLZ1ZThcVil 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284939>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-938498975-1453911626=:2964
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

MSYS2 actually allows to create files or directories whose names contain
tabs, newlines or colors, even if plain Win32 API cannot access them.
As we are using an MSYS2 bash to run the tests, such files or
directories are created successfully, but Git itself has no chance to
work with them because it is a regular Windows program, hence limited by
the Win32 API.

With this change, on Windows otherwise failing tests in
t3300-funny-names.sh, t3600-rm.sh, t3703-add-magic-pathspec.sh,
t3902-quoted.sh, t4016-diff-quote.sh, t4135-apply-weird-filenames.sh,
t9200-git-cvsexportcommit.sh, and t9903-bash-prompt.sh are skipped.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3300-funny-names.sh           | 1 +
 t/t3600-rm.sh                    | 2 +-
 t/t3703-add-magic-pathspec.sh    | 2 +-
 t/t3902-quoted.sh                | 1 +
 t/t4016-diff-quote.sh            | 1 +
 t/t4135-apply-weird-filenames.sh | 3 ++-
 t/t9200-git-cvsexportcommit.sh   | 2 +-
 t/t9903-bash-prompt.sh           | 2 +-
 8 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 9a146f1..04de03c 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -13,6 +13,7 @@ tree, index, and tree objects.
=20
 HT=3D'=09'
=20
+test_have_prereq MINGW ||
 echo 2>/dev/null > "Name with an${HT}HT"
 if ! test -f "Name with an${HT}HT"
 then
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 2e47a2b..d046d98 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -14,7 +14,7 @@ test_expect_success \
      git add -- foo bar baz 'space embedded' -q &&
      git commit -m 'add normal files'"
=20
-if touch -- 'tab=09embedded' 'newline
+if test_have_prereq !MINGW && touch -- 'tab=09embedded' 'newline
 embedded' 2>/dev/null
 then
 =09test_set_prereq FUNNYNAMES
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
index 5115de7..3ef525a 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -38,7 +38,7 @@ cat >expected <<EOF
 add 'sub/foo'
 EOF
=20
-if mkdir ":" 2>/dev/null
+if test_have_prereq !MINGW && mkdir ":" 2>/dev/null
 then
 =09test_set_prereq COLON_DIR
 fi
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 892f567..f528008 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -12,6 +12,7 @@ GN=3D'=E7=B4=94'
 HT=3D'=09'
 DQ=3D'"'
=20
+test_have_prereq MINGW ||
 echo foo 2>/dev/null > "Name and an${HT}HT"
 if ! test -f "Name and an${HT}HT"
 then
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index cd543ec..9c48e5c 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -13,6 +13,7 @@ P1=3D'pathname=09with HT'
 P2=3D'pathname with SP'
 P3=3D'pathname
 with LF'
+test_have_prereq !MINGW &&
 echo 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
 =09skip_all=3D'Your filesystem does not allow tabs in filenames'
 =09test_done
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenam=
es.sh
index bf5dc57..27cb000 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -19,7 +19,8 @@ test_expect_success 'setup' '
=20
 =09test_when_finished "rm -f \"tab=09embedded.txt\"" &&
 =09test_when_finished "rm -f '\''\"quoteembedded\".txt'\''" &&
-=09if touch -- "tab=09embedded.txt" '\''"quoteembedded".txt'\''
+=09if test_have_prereq !MINGW &&
+=09=09touch -- "tab=09embedded.txt" '\''"quoteembedded".txt'\''
 =09then
 =09=09test_set_prereq FUNNYNAMES
 =09fi
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.s=
h
index 812c9cd..5cfb9cf 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -197,7 +197,7 @@ if p=3D"=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/=
s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6" &&
 then
=20
 # This test contains UTF-8 characters
-test_expect_success \
+test_expect_success !MINGW \
      'File with non-ascii file name' \
      'mkdir -p =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/=
y/z/=C3=A5/=C3=A4/=C3=B6 &&
       echo Foo >=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x=
/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index af82049..ffbfa0e 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -67,7 +67,7 @@ repo_with_newline=3D'repo
 with
 newline'
=20
-if mkdir "$repo_with_newline" 2>/dev/null
+if test_have_prereq !MINGW && mkdir "$repo_with_newline" 2>/dev/null
 then
 =09test_set_prereq FUNNYNAMES
 else
--=20
2.7.0.windows.1.7.g55a05c8
--8323329-938498975-1453911626=:2964--
