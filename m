From: Martin Uecker <muecker@gmx.de>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 17:57:34 +0200
Message-ID: <20050420155734.GA13575@macavity>
References: <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com> <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com> <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc403205042005116484231c@mail.gmail.com> <20050420132446.GA10126@macavity> <Pine.LNX.4.61.0504201025030.2630@cag.csail.mit.edu> <20050420151902.GA13175@macavity> <Pine.LNX.4.61.0504201121490.2630@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
X-From: git-owner@vger.kernel.org Wed Apr 20 17:56:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOHXb-0005nK-Lo
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDTP7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVDTP7S
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:59:18 -0400
Received: from dialin-145-254-143-099.arcor-ip.net ([145.254.143.99]:1665 "EHLO
	macavity") by vger.kernel.org with ESMTP id S261710AbVDTP65 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 11:58:57 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DOHa2-0003aS-Ka
	for git@vger.kernel.org; Wed, 20 Apr 2005 17:57:34 +0200
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Martin Uecker <muecker@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504201121490.2630@cag.csail.mit.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2005 at 11:28:20AM -0400, C. Scott Ananian wrote:

Hi,
=20
> A merkle-tree (which I think you initially pointed me at) makes the hash=
=20
> of the internal nodes be a hash of the chunk's hashes; ie not a straight=
=20
> content hash.  This is roughly what my current implementation does, but
> I would like to identify each subtree with the hash of the=20
> *(expanded) contents of that subtree* (ie no explicit reference to=20
> subtree hashes).  This makes it interoperable with non-chunked or=20
> differently-chunked representations, in that the top-level hash is *just=
=20
> the hash of the complete content*, not some hash-of-subtree-hashes.  Does=
=20
> that make more sense?

Yes, thank you. But I would like to argue against this:

You can make the representations interoperable
if you calculate the hash for the non-chunked
representations exactly as if this file is stored
chunked but simple do not store it in that way.

Of course this is not backward compatible to the
monolithic hash and not compatible with a differently
chunked representation (but you could store subtrees
unchunked if you think your chunks are too small).

> The code I posted doesn't demonstrate this very well, but now that Linus=
=20
> has abandoned the 'hash of compressed content' stuff, my next code postin=
g=20
> should show this more clearly.

I think the hash of the treap piece should be calculated
=66rom the hash of the prefix and suffix tree and the already
calculated hash of the uncompressed data. This makes hashing
nearly as cheap as in Linus version which is important
because checking whether a given file has identically
content as a stored version should be fast.

> >If I don't miss anything essential, you can validate
> >each treap piece at the moment you get it from the
> >network with its SHA1 hash and then proceed with
> >downloading the prefix and suffix tree (in parallel
> >if you have more than one peer a la bittorrent).
>=20
> Yes, I guess this is the detail I was going to abandon. =3D)
>=20
> I viewed the fact that the top-level hash was dependent on the exact chun=
k=20
> makeup a 'misfeature', because it doesn't allow easy interoperability wit=
h=20
> existing non-chunked repos.

I thought this as a misfeature too before I realized how
many advantages this has.

Martin
=20

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCZnvuYDJInvULMKYRAk4vAJ0dAT5aID3doA7Kk4l1KSgI0HM9agCfe/XQ
C0q6AVNMiQTyfbeicd0qMwQ=
=sP+f
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
