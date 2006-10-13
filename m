From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-fetch: Allow branch."branchname".remote=.
Date: Fri, 13 Oct 2006 09:50:12 +0200
Message-ID: <87y7rk3b9n.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Oct 13 09:50:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYHoC-0003KA-IC
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 09:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWJMHuR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Oct 2006 03:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWJMHuQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 03:50:16 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:50901 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751366AbWJMHuP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 03:50:15 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k9D7oCs30590
	for <git@vger.kernel.org>; Fri, 13 Oct 2006 09:50:13 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28831>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-parse-remote.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 679f73c..617d022 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -187,6 +187,15 @@ get_remote_refs_for_push () {
 }
=20
 get_remote_refs_for_fetch () {
+	if [ "$#,$1" =3D "1,." ] ;
+	then
+	    curr_branch=3D$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||'=
)
+	    branch_remote=3D$(git-repo-config --get "branch.$curr_branch.remo=
te")
+	    if [ "$branch_remote" =3D "." ]
+	    then
+		set . $(git-repo-config --get-all "branch.${curr_branch}.merge")
+	    fi
+	fi
 	case "$#" in
 	0)
 	    die "internal error: get-remote-refs-for-fetch." ;;
--=20
1.4.3.rc2.ga442
