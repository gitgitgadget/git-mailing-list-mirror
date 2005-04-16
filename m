From: Martin Uecker <muecker@gmx.de>
Subject: Re: space compression (again)
Date: Sat, 16 Apr 2005 19:37:02 +0200
Message-ID: <20050416173702.GA12605@macavity>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu> <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org> <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu> <Pine.LNX.4.58.0504151210590.7211@ppc970.osdl.org> <20050416143905.GA10370@macavity> <Pine.LNX.4.61.0504161101470.29343@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
X-From: git-owner@vger.kernel.org Sat Apr 16 19:35:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMrCE-0006rY-KU
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 19:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVDPRin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 13:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVDPRim
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 13:38:42 -0400
Received: from dialin-145-254-144-203.arcor-ip.net ([145.254.144.203]:3969
	"EHLO macavity") by vger.kernel.org with ESMTP id S262710AbVDPRiX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 13:38:23 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DMrE6-0003Nc-Kf
	for git@vger.kernel.org; Sat, 16 Apr 2005 19:37:02 +0200
To: git@vger.kernel.org
Mail-Followup-To: Martin Uecker <muecker@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504161101470.29343@cag.csail.mit.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 16, 2005 at 11:11:00AM -0400, C. Scott Ananian wrote:
> On Sat, 16 Apr 2005, Martin Uecker wrote:
>=20
> >The right thing (TM) is to switch from SHA1 of compressed
> >content for the complete monolithic file to a merkle hash tree
> >of the uncompressed content. This would make the hash
> >independent of the actual storage method (chunked or not).
>=20
> It would certainly be nice to change to a hash of the uncompressed=20
> content, rather than a hash of the compressed content, but it's not=20
> strictly necessary, since files are fetched all at once: there's not 'rea=
d=20
> subrange' operation on blobs.
>=20
> I assume 'merkle hash tree' is talking about:
>   http://www.open-content.net/specs/draft-jchapweske-thex-02.html
> ..which is very interesting, but not quite what I was thinking.
> The merkle hash approach seems to require fixed chunk boundaries.

I don't know what is written there, but I don't
consider fixed chunk boundaries part of the definition.

> The rsync approach does not use fixed chunk boundaries; this is necessary=
=20
> to ensure good storage reuse for the expected case (ie; inserting a singl=
e=20
> line at the start or in the middle of the file, which changes all the=20
> chunk boundaries).

Yes. The chunk boundaries should be determined deterministically
=66rom local properties of the data. Use a rolling checksum over
some small window and split the file it it hits a special value (0).
This is what the rsyncable patch to zlib does.

> Further, in the absence of subrange reads on blobs, it's not entirely=20
> clear what using a merkle hash would buy you.

The whole design of git is a hash tree. If you extend
this tree structure into files you end up with merkle
hash trees. Everything else is just more complicated.

Martin
=20

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCYU0+YDJInvULMKYRAokvAJ4ui2II+aceTEz84ev3rEgLBBRejQCdEPOT
BaIevBldK7QOi3CxFL0jk68=
=EYGx
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
