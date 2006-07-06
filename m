From: Martin Waitz <tali@admingilde.org>
Subject: comparing file contents in is_exact_match?
Date: Thu, 6 Jul 2006 07:57:29 +0200
Message-ID: <20060706055729.GA12512@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
X-From: git-owner@vger.kernel.org Thu Jul 06 07:57:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyMrp-0003pH-6u
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 07:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWGFF5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 01:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWGFF5b
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 01:57:31 -0400
Received: from admingilde.org ([213.95.32.146]:47019 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1030190AbWGFF5b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 01:57:31 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FyMrh-00087e-9W
	for git@vger.kernel.org; Thu, 06 Jul 2006 07:57:29 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23373>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I created a git repository for my photo collection and then renamed
some photos (about 600).  Now git status and commit get hit by
the OOM killer.

The reason for that is that is_exact_match (in diffcore-rename.c) maps
both the source and destination file into memory and then compares them
byte for byte.  This is a little bit too much for my little machine.

When I remove the content comparation and only leave the sha1
comparision, then my renames are correctly found in a second.  But
unluckily, some other renames in the testcases are not correctly
handled any more.

So is there an easy solution?  Why is the content comparision in
is_exact_match needed?

--=20
Martin Waitz

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFErKZJj/Eaxd/oD7IRArLZAJsFBeHfzEbiNms1QPZyr9/0iEaQlQCfTPHI
b2OZZ1l299Jc+QSM5N4L7IQ=
=6sEG
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
