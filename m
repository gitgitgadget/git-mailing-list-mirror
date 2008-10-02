From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git commit hash clash prevention
Date: Thu, 2 Oct 2008 11:18:13 +0200
Message-ID: <200810021118.15313.trast@student.ethz.ch>
References: <20081002085358.GA5342@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1282278.iQKkVG5EFi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 11:34:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlKa6-0002rL-EH
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 11:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbYJBJdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 05:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYJBJda
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 05:33:30 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:12089 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbYJBJd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 05:33:29 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Oct 2008 05:33:29 EDT
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Oct 2008 11:18:13 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Oct 2008 11:18:13 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20081002085358.GA5342@lapse.rw.madduck.net>
X-OriginalArrivalTime: 02 Oct 2008 09:18:13.0201 (UTC) FILETIME=[CB90E410:01C9246F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97300>

--nextPart1282278.iQKkVG5EFi
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

martin f krafft wrote:
> the other day during a workshop on Git, one of the attendants asked
> about the scenario when two developers, Jane and David, both working
> on the same project, both create a commit and the two just so happen
> to have the same SHA-1. I realise that the likelihood of this
> happening is about as high as the chance of <insert witty joke
> here>, but it *is* possible, isn't it? Even though this is thus
> somewhat academic, I am still very curious about it.
>=20
> What happens when David now pulls from Jane? How does Git deal with
> this?

There are two cases:

* The commits are exactly identical.  This won't happen in your
  scenario, but is still theoretically possible if you commit the same
  tree with the same author info, timestamps, etc. on two different
  machines.  Then there is no problem, because they really are the
  same.

* They're not identical, but there is a hash collision.  Git will
  become very confused because it only ever saves one of them.  (I
  suppose it'd "only" corrupt the DAG if the two are commits, but in
  the general case a commit could collide with a tree etc.)

  However, the expected number of objects needed to get a collision is
  on the order of 2**80 (http://en.wikipedia.org/wiki/Birthday_attack),
  and since there are (very roughly) 2**25 seconds in a year and 2**34
  years in the age of the universe, that still leaves you with 2**21
  ages of the universe to go.

(I hope I did the counting right...)

> I imagine it'll be able to distinguish the two commits based on
> metadata, but won't the DAG get corrupted?

No, it does not distinguish between objects in any way but the SHA1.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart1282278.iQKkVG5EFi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjkkdcACgkQqUud07tmzP2cawCfdW2kKOn18K4RV4Az4Pl7LXSq
9bUAnA4JuAO7I6jiNffnrjJFanmTOyCf
=1hRO
-----END PGP SIGNATURE-----

--nextPart1282278.iQKkVG5EFi--
