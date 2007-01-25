From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-reset: print always the status when HEAD changes
Date: Thu, 25 Jan 2007 09:48:03 +0100
Message-ID: <87lkjrv6f0.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 09:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA0He-00040S-E3
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 09:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965720AbXAYIs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 25 Jan 2007 03:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965722AbXAYIs2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 03:48:28 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:55813 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965720AbXAYIs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 03:48:27 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0P8mOq25440
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 09:48:25 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37714>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-reset.sh |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index fee6d98..a2405c6 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -84,14 +84,16 @@ fi
 git-update-ref -m "$GIT_REFLOG_ACTION" HEAD "$rev"
 update_ref_status=3D$?
=20
+if test $update_ref_status =3D 0 && test "$orig" !=3D "$rev"
+then
+	printf "HEAD is now at "
+	GIT_PAGER=3D git log --max-count=3D1 --pretty=3Doneline \
+		--abbrev-commit HEAD
+fi
+
 case "$reset_type" in
 --hard )
-	test $update_ref_status =3D 0 && {
-		printf "HEAD is now at "
-		GIT_PAGER=3D git log --max-count=3D1 --pretty=3Doneline \
-			--abbrev-commit HEAD
-	}
-	;;
+	;; # Nothing else to do
 --soft )
 	;; # Nothing else to do
 --mixed )
--=20
1.5.0.rc1.ga98e3
