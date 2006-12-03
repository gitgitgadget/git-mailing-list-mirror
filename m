X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [BUG] git-mv fails with "source directory is empty" when it should not
Date: Sun, 3 Dec 2006 16:57:25 +0300
Message-ID: <20061203135725.GA7971@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
NNTP-Posting-Date: Sun, 3 Dec 2006 13:57:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33112>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqrqu-00013V-7J for gcvg-git@gmane.org; Sun, 03 Dec
 2006 14:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935873AbWLCN5x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 08:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936696AbWLCN5x
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 08:57:53 -0500
Received: from master.altlinux.org ([62.118.250.235]:8711 "EHLO
 master.altlinux.org") by vger.kernel.org with ESMTP id S935873AbWLCN5x (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 08:57:53 -0500
Received: by master.altlinux.org (Postfix, from userid 584) id CEE6FE494B;
 Sun,  3 Dec 2006 16:57:51 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

In some cases git-mv fails with "source directory is empty" when this
is definitely not the case.

Example (run in an empty directory):

$ git init-db
defaulting to local storage area
$ mkdir ab; touch ab.c; touch ab/d
$ git add .
$ git commit -m 'initial'
Committing initial tree f2dd231ec22a1d4376d4a6eadf49d87dd34ac2a0
$ git mv ab a
fatal: source directory is empty, source=3Dab, destination=3Da

However, at this point the source directory is definitely not empty:

$ git ls-tree -r HEAD
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391    ab.c
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391    ab/d
$ ls -ogR
=2E:
total 4
drwxr-xr-x 2 4096 Dec  3 16:47 ab
-rw-r--r-- 1    0 Dec  3 16:47 ab.c

=2E/ab:
total 0
-rw-r--r-- 1 0 Dec  3 16:47 d
$ git status    =20
nothing to commit

This happens both in v1.4.4.1 and in current 'master' (v1.4.4.1-g278fcd7).

--=20
Sergey Vlasov

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFctfFW82GfkQfsqIRArobAJ4pzYXgJuujLmLLTBbxG/r9peAOfwCfRODk
30sWk4bEaHqskrsW/mlFtqM=
=tVQk
-----END PGP SIGNATURE-----

