From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4] janitor: useless checks before free
Date: Wed, 22 Jul 2009 23:51:55 +0200
Message-ID: <20090722215154.GD13823@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jul 22 23:52:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjjR-00080B-SD
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbZGVVwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZGVVwB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:52:01 -0400
Received: from pan.madism.org ([88.191.52.104]:52742 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbZGVVwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:52:00 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2F8C24651F;
	Wed, 22 Jul 2009 23:52:00 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 82F5C2AEA0; Wed, 22 Jul 2009 23:51:55 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123791>


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

   On the same vein, a few simplifications wrt if (x) free(x)

 pack-revindex.c |    3 +--
 walker.c        |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 1de53c8..77a0465 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -149,8 +149,7 @@ void discard_revindex(void)
 	if (pack_revindex_hashsz) {
 		int i;
 		for (i =3D 0; i < pack_revindex_hashsz; i++)
-			if (pack_revindex[i].revindex)
-				free(pack_revindex[i].revindex);
+			free(pack_revindex[i].revindex);
 		free(pack_revindex);
 		pack_revindex_hashsz =3D 0;
 	}
diff --git a/walker.c b/walker.c
index e57630e..11d9052 100644
--- a/walker.c
+++ b/walker.c
@@ -245,7 +245,7 @@ void walker_targets_free(int targets, char **target, co=
nst char **write_ref)
 {
 	while (targets--) {
 		free(target[targets]);
-		if (write_ref && write_ref[targets])
+		if (write_ref)
 			free((char *) write_ref[targets]);
 	}
 }
--=20
1.6.4.rc1.193.g47c25d


--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpnifoACgkQvGr7W6HudhxgcwCfZPfWjo9q8u0aEz7zUyLkRXiQ
4AMAnA8VtNaXenn6kxDp+0KSJlflMIPO
=EFgb
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
