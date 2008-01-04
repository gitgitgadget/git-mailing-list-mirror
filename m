From: Michael Stefaniuc <mstefani@redhat.com>
Subject: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Fri, 4 Jan 2008 19:59:26 +0100
Message-ID: <20080104185926.GA11912@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 20:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JArlv-0007yJ-0P
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbYADS73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbYADS73
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:59:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273AbYADS72 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 13:59:28 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m04IxRJt024003
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 13:59:27 -0500
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m04IxRuF007768
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 13:59:27 -0500
Received: by brasov.str.redhat.com (Postfix, from userid 2500)
	id C070A303E3; Fri,  4 Jan 2008 19:59:26 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69595>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With "too many unreachable loose objects" git gc --auto will always
trigger. This clutters the output of git am and thus git rebase.

The work flow of the Wine project doesn't include git merge. git rebase
is therefor used to track the origin. This will produce soon too many
loose objects for git gc --auto's taste. Pruning the repository would
"fix" it. But we tell Wine developers new to git to NOT prune as long as
they aren't confident enough with git; just as a safety net in case they
have thrown away month of work.

Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
 git-am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 65c634f..5f0f241 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -469,9 +469,9 @@ do
 		"$GIT_DIR"/hooks/post-applypatch
 	fi
=20
-	git gc --auto
-
 	go_next
 done
=20
+git gc --auto
+
 rm -fr "$dotest"
--=20
1.5.4.rc2

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFHfoIO08alQ5mXm14RAjPdAJ9QuE8HfnAKw75CiqqyVXPI6r16rQCfZeaT
fgW0MEsF7zHOKyjMFr1fljc=
=SUbW
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
