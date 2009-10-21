From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] everyday: fsck and gc are not everyday operations
Date: Wed, 21 Oct 2009 16:02:48 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910211559210.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hOb-0004am-Lv
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbZJUUCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 16:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZJUUCr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:02:47 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57166 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750919AbZJUUCq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 16:02:46 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9LK2fvV018251;
	Wed, 21 Oct 2009 16:02:41 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9LK2oa9026488;
	Wed, 21 Oct 2009 16:02:50 -0400 (EDT)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130955>

Back in 2005 when this document was written, it may have made sense to=20
introduce =E2=80=98git fsck=E2=80=99 (then =E2=80=98git fsck-objects=E2=
=80=99) as the very first example=20
command for new users of Git 0.99.9.  Now that Git has been stable for=20
years and does not actually tend to eat your data, it makes significant=
ly=20
less sense.  In fact, it sends an entirely wrong message.

=E2=80=98git gc=E2=80=99 is also unnecessary for the purposes of this d=
ocument, especially=20
with gc.auto enabled by default.

The only other commands in the =E2=80=9CBasic Repository=E2=80=9D secti=
on were =E2=80=98git init=E2=80=99=20
and =E2=80=98git clone=E2=80=99.  =E2=80=98clone=E2=80=99 is already li=
sted in the =E2=80=9CParticipant=E2=80=9D section,=20
so move =E2=80=98init=E2=80=99 to the =E2=80=9CStandalone=E2=80=9D sect=
ion and get rid of =E2=80=9CBasic=20
Repository=E2=80=9D entirely.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 Documentation/everyday.txt |   51 +++---------------------------------=
-------
 1 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 9310b65..e0ba8cc 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -1,13 +1,8 @@
 Everyday GIT With 20 Commands Or So
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-<<Basic Repository>> commands are needed by people who have a
-repository --- that is everybody, because every working tree of
-git is a repository.
-
-In addition, <<Individual Developer (Standalone)>> commands are
-essential for anybody who makes a commit, even for somebody who
-works alone.
+<<Individual Developer (Standalone)>> commands are essential for
+anybody who makes a commit, even for somebody who works alone.
=20
 If you work with other people, you will need commands listed in
 the <<Individual Developer (Participant)>> section as well.
@@ -20,46 +15,6 @@ administrators who are responsible for the care and =
feeding
 of git repositories.
=20
=20
-Basic Repository[[Basic Repository]]
-------------------------------------
-
-Everybody uses these commands to maintain git repositories.
-
-  * linkgit:git-init[1] or linkgit:git-clone[1] to create a
-    new repository.
-
-  * linkgit:git-fsck[1] to check the repository for errors.
-
-  * linkgit:git-gc[1] to do common housekeeping tasks such as
-    repack and prune.
-
-Examples
-~~~~~~~~
-
-Check health and remove cruft.::
-+
-------------
-$ git fsck <1>
-$ git count-objects <2>
-$ git gc <3>
-------------
-+
-<1> running without `\--full` is usually cheap and assures the
-repository health reasonably well.
-<2> check how many loose objects there are and how much
-disk space is wasted by not repacking.
-<3> repacks the local repository and performs other housekeeping tasks=
=2E
-
-Repack a small project into single pack.::
-+
-------------
-$ git gc <1>
-------------
-+
-<1> pack all the objects reachable from the refs into one pack,
-then remove the other packs.
-
-
 Individual Developer (Standalone)[[Individual Developer (Standalone)]]
 ----------------------------------------------------------------------
=20
@@ -67,6 +22,8 @@ A standalone individual developer does not exchange p=
atches with
 other people, and works alone in a single repository, using the
 following commands.
=20
+  * linkgit:git-init[1] to create a new repository.
+
   * linkgit:git-show-branch[1] to see where you are.
=20
   * linkgit:git-log[1] to see what happened.
--=20
1.6.5.1
