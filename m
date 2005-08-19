From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] git-rev-list: avoid crash on broken repository
Date: Fri, 19 Aug 2005 22:28:35 +0400
Message-ID: <20050819182835.GA12057@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 20:28:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Bbh-00037i-1G
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 20:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVHSS2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 14:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVHSS2l
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 14:28:41 -0400
Received: from master.altlinux.ru ([62.118.250.235]:47882 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932665AbVHSS2l
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 14:28:41 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id CD467E4732; Fri, 19 Aug 2005 22:28:39 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id 4DD52E49D54; Fri, 19 Aug 2005 22:28:35 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When following tags, check for parse_object() success and error out
properly instead of segfaulting.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 rev-list.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

f4ec41063d2f43b06b7c8e511108b4c9bf9e6ebe
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -418,6 +418,8 @@ static struct commit *get_commit_referen
 		if (tag_objects && !(object->flags & UNINTERESTING))
 			add_pending_object(object, tag->tag);
 		object =3D parse_object(tag->tagged->sha1);
+		if (!object)
+			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
 	}
=20
 	/*

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDBiTTW82GfkQfsqIRAjVpAJ4pTN4ucZvBmIkfc6Q/F4MWXBbJHACdHFNF
Od69VAeOTZqLzq4RjllyBMU=
=Sosz
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
