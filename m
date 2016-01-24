From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 17/19] mingw: fix git-svn tests that expect chmod to work
Date: Sun, 24 Jan 2016 16:45:47 +0100 (CET)
Message-ID: <9045a31ec16da672a74d9b1e0b65807d21ef277e.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1626058768-1453650348=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMrT-0001he-Hw
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbcAXPpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:64524 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbcAXPpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:51 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lv8hi-1ZxHSA2C7G-010PB0; Sun, 24 Jan 2016 16:45:48
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:JQDZL71JWK0UmLattsY+TteqNDUXNPFoxBUm7qZEKL1Cm+7wUkG
 nTdOq6rHNRRxDKy5IYF38HhruSrvjO7SFH7T8YDqMZe0gMNpnWPLhrRllbr5Rox6mz/BsBL
 ObrDZ6ISuYZu5mnn+uQEJQlwHrAJfeT91lCW48Aw0SA7xntoIUEfrBuv8gCgCzqIOa2cdLG
 odNSRVRWGSkjGFouqhm4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IfHbdPAZMV4=:T3ar5EZU8dHX/XjTO6je0E
 wD2FCFMdO1AmOFS/5JmSlql5zdmirjTphwhHgBZdKkVC9SM+jdsxo586pvJWIzO6g7gh4+Vdq
 Q3Glj6muC+FZr/+chcUZVusnh94/7QEoXct250QDez6qrLC+zRZ9c027y60yzLAgm8xX9Ha8J
 1vNXC/0q6Xe3urs4A7jvne7HhZx2n2YO4Fs0mE20rWtXANWBZIpJGV6Woq/RV5O1R9NwfuG36
 SXbxFqfMzr4avir8k4v5TdNxvigB5c+pldQ8KhWz2MoAZxmurqmpqziwv7WupqEWqyNyRtiWR
 oIAlm7Sn3s0LhcRuKAYGYloX5YM63BYV/Pk4AXw0kvxg21iYTa7fk21Be/Rq3I+xOP7WnOmgV
 hQ2ZPKPWLciaQTQ1Y7NwMxjlTc5mSvvuzi74f0AafS5vCWuHQhYa0i/+L6jOgHo4dRd0+eLe7
 STX7uxK0qri8bWj3W2LQWS+52rFqNL8n5Uscow4xFiK5zGJZt8XfTImcuTLMifIL5Bu1Y3AM5
 q25qc9xHGQnzXKZ8YE78FE4O1xltbmuuIlrDioD0BuMYgXbHItGipTCIYlR2FOBj+GNg5S52n
 VWMSDHzUATIz7C/+aH732Bcu9QdoAEgnQJfju2Je9D0VnaVS5FDebLa3dxSpvVeyQEDwIk3Sf
 5ZVcxn+7Qmeab0aRCWd1wiARHptX17+8Ev9F+rHWGBbCeQxuRWJrJ8fEBhqmQwPl4/Vu+BZdv
 HoGGIeT8WFqv9Q6f4jPpM0U+GFS5LbvfGPiWMjYi9BVLKnH+ZtfOIMyVaTO48mr1GTbCpvT+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284681>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1626058768-1453650348=:2964
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: =B8=B6=B4=A9=BF=A4 <nalla@users.noreply.github.com>

Some git-svn tests expect that the executable bit of files can be
toggled. On Windows, this is not possible because Windows' Access
Control Lists are much more fine-grained than the POSIX permission
concept. Let's just not try to flip the executable bit.

This lets t9118-git-svn-funky-branch-names.sh and
t9124-git-svn-dcommit-auto-props.sh pass in Git for Windows' SDK,
and partially fixes t9100-git-svn-basic.sh.

Signed-off-by: =B8=B6=B4=A9=BF=A4 <nalla@users.noreply.github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9100-git-svn-basic.sh              |  5 ++++-
 t/t9118-git-svn-funky-branch-names.sh | 12 +++++++++---
 t/t9124-git-svn-dcommit-auto-props.sh | 20 ++++++++++++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index dbb440b..bca7ec8 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -38,7 +38,10 @@ test_expect_success \
 =09=09mkdir bar &&
 =09=09echo "zzz" >bar/zzz &&
 =09=09echo "#!/bin/sh" >exec.sh &&
-=09=09chmod +x exec.sh &&
+=09=09{
+=09=09=09test_have_prereq !POSIXPERM ||
+=09=09=09chmod +x exec.sh
+=09=09} &&
 =09=09svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
 =09) &&
 =09rm -rf import &&
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-=
branch-names.sh
index a221915..49775a5 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -23,8 +23,11 @@ test_expect_success 'setup svnrepo' '
 =09              "$svnrepo/pr ject/branches/$scary_uri" &&
 =09svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
 =09=09=09"$svnrepo/pr ject/branches/.leading_dot" &&
-=09svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
-=09=09=09"$svnrepo/pr ject/branches/trailing_dot." &&
+=09{
+=09=09test_have_prereq MINGW ||
+=09=09svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
+=09=09=09"$svnrepo/pr ject/branches/trailing_dot."
+=09} &&
 =09svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
 =09=09=09"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
 =09svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
@@ -45,7 +48,10 @@ test_expect_success 'test clone with funky branch names'=
 '
 =09=09git rev-parse "refs/remotes/origin/more%20fun%20plugin!" &&
 =09=09git rev-parse "refs/remotes/origin/$scary_ref" &&
 =09=09git rev-parse "refs/remotes/origin/%2Eleading_dot" &&
-=09=09git rev-parse "refs/remotes/origin/trailing_dot%2E" &&
+=09=09{
+=09=09=09test_have_prereq MINGW ||
+=09=09=09git rev-parse "refs/remotes/origin/trailing_dot%2E"
+=09=09} &&
 =09=09git rev-parse "refs/remotes/origin/trailing_dotlock%2Elock" &&
 =09=09git rev-parse "refs/remotes/origin/$non_reflog"
 =09)
diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommi=
t-auto-props.sh
index aa841e1..c851121 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -35,7 +35,10 @@ test_expect_success 'enable auto-props config' '
=20
 test_expect_success 'add files matching auto-props' '
 =09echo "#!$SHELL_PATH" >exec1.sh &&
-=09chmod +x exec1.sh &&
+=09{
+=09=09test_have_prereq !POSIXPERM ||
+=09=09chmod +x exec1.sh
+=09} &&
 =09echo "hello" >hello.txt &&
 =09echo bar >bar &&
 =09git add exec1.sh hello.txt bar &&
@@ -49,7 +52,10 @@ test_expect_success 'disable auto-props config' '
=20
 test_expect_success 'add files matching disabled auto-props' '
 =09echo "#$SHELL_PATH" >exec2.sh &&
-=09chmod +x exec2.sh &&
+=09{
+=09=09test_have_prereq !POSIXPERM ||
+=09=09chmod +x exec2.sh
+=09} &&
 =09echo "world" >world.txt &&
 =09echo zot >zot &&
 =09git add exec2.sh world.txt zot &&
@@ -65,7 +71,10 @@ test_expect_success 'check resulting svn repository' '
 =09cd svnrepo &&
=20
 =09# Check properties from first commit.
-=09test "x$(svn_cmd propget svn:executable exec1.sh)" =3D "x*" &&
+=09{
+=09=09test_have_prereq !POSIXPERM ||
+=09=09test "x$(svn_cmd propget svn:executable exec1.sh)" =3D "x*"
+=09} &&
 =09test "x$(svn_cmd propget svn:mime-type exec1.sh)" =3D \
 =09     "xapplication/x-shellscript" &&
 =09test "x$(svn_cmd propget svn:mime-type hello.txt)" =3D "xtext/plain" &&
@@ -73,7 +82,10 @@ test_expect_success 'check resulting svn repository' '
 =09test "x$(svn_cmd propget svn:mime-type bar)" =3D "x" &&
=20
 =09# Check properties from second commit.
-=09test "x$(svn_cmd propget svn:executable exec2.sh)" =3D "x*" &&
+=09{
+=09=09test_have_prereq !POSIXPERM ||
+=09=09test "x$(svn_cmd propget svn:executable exec2.sh)" =3D "x*"
+=09} &&
 =09test "x$(svn_cmd propget svn:mime-type exec2.sh)" =3D "x" &&
 =09test "x$(svn_cmd propget svn:mime-type world.txt)" =3D "x" &&
 =09test "x$(svn_cmd propget svn:eol-style world.txt)" =3D "x" &&
--=20
2.7.0.windows.1.7.g55a05c8


--8323329-1626058768-1453650348=:2964--
