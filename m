From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: cvs diff -l equivalent?
Date: Wed, 30 Jul 2008 16:00:41 +0200
Message-ID: <200807301600.44205.trast@student.ethz.ch>
References: <20080730082030.GA12555@cuci.nl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2599087.pz7MOmO0WB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:01:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOCF8-0007P1-Ve
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbYG3OAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYG3OAa
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:00:30 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:53514 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYG3OAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:00:30 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jul 2008 16:00:28 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jul 2008 16:00:28 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080730082030.GA12555@cuci.nl>
X-OriginalArrivalTime: 30 Jul 2008 14:00:28.0636 (UTC) FILETIME=[9F6F31C0:01C8F24C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90790>

--nextPart2599087.pz7MOmO0WB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephen R. van den Berg wrote:
> Someone popped this question on me.  The closest I got was:
>=20
>    git diff .
>=20
> But that still recurses.  Any solutions without patching?

Maybe a scripted version?  For just 'git diff .', this should work:

  git diff $(git ls-files . | grep -v /)

That will still do the wrong thing if you diff against an older commit
with a different list of files.  In that case you need the list of
files in the other side of the diff too:

  git diff HEAD^..  -- $(git ls-files . | grep -v /; git ls-tree HEAD^ | cu=
t -f2)


=2D Thomas


--nextPart2599087.pz7MOmO0WB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiQdAwACgkQqUud07tmzP3PlwCfW/yQSlR7dwzZe4sRmlBSIYYL
JcsAmQH94MM64PgfkmpS5twC5ThSp4b6
=mGAg
-----END PGP SIGNATURE-----

--nextPart2599087.pz7MOmO0WB--
