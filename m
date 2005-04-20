From: Martin Uecker <muecker@gmx.de>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 17:19:02 +0200
Message-ID: <20050420151902.GA13175@macavity>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com> <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com> <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com> <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc403205042005116484231c@mail.gmail.com> <20050420132446.GA10126@macavity> <Pine.LNX.4.61.0504201025030.2630@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
X-From: git-owner@vger.kernel.org Wed Apr 20 17:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOGwH-0006rz-0S
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVDTPUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDTPUl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:20:41 -0400
Received: from dialin-145-254-143-099.arcor-ip.net ([145.254.143.99]:59776
	"EHLO macavity") by vger.kernel.org with ESMTP id S261650AbVDTPUZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 11:20:25 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DOGyk-0003UX-BG
	for git@vger.kernel.org; Wed, 20 Apr 2005 17:19:02 +0200
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Martin Uecker <muecker@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504201025030.2630@cag.csail.mit.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2005 at 10:30:15AM -0400, C. Scott Ananian wrote:

Hi,

your code looks pretty cool. thank you!

> On Wed, 20 Apr 2005, Martin Uecker wrote:
>=20
> >The other thing I don't like is the use of a sha1
> >for a complete file. Switching to some kind of hash
> >tree would allow to introduce chunks later. This has
> >two advantages:
>=20
> You can (and my code demonstrates/will demonstrate) still use a whole-fil=
e=20
> hash to use chunking.  With content prefixes, this takes O(N ln M) time=
=20
> (where N is the file size and M is the number of chunks) to compute all=
=20
> hashes; if subtrees can share the same prefix, then you can do this in=20
> O(N) time (ie, as fast as possible, modulo a constant factor, which is=20
> '2').  You don't *need* internal hashing functions.

I don't understand this paragraph. What is an internal
hash function? Your code seems to do exactly what I want.
The hashes are computed recusively as in a hash tree
with O(N ln N). The only difference between your design
and a design based on a conventional (binary) hash tree
seems to be that data is stored in the intermediate nodes
too.=20

> >It would allow git to scale to repositories of large
> >binary files. And it would allow to build a very cool
> >content transport algorithm for those repositories.
> >This algorithm could combine all the advantages of
> >bittorrent and rsync (without the cpu load).
>=20
> Yes, the big benefit of internal hashing is that it lets you check=20
> validity of a chunk w/o having the entire file available.  I'm not sure=
=20
> that's terribly useful in this case.  [And, if it is, then it can=20
> obviously be done w/ other means.]

If I don't miss anything essential, you can validate
each treap piece at the moment you get it from the
network with its SHA1 hash and then proceed with
downloading the prefix and suffix tree (in parallel
if you have more than one peer a la bittorrent).

> >And it would allow trivial merging of patches which
> >apply to different chunks of a file in exact the same
> >way as merging changesets which apply to different
> >files in a tree.
>=20
> I'm not sure anyone should be looking at chunks.  To me, at least, they=
=20
> are an object-store-implementation detail only.  For merging, etc, we=20
> should be looking at whole files, or (better) the whole repository.
> The chunking algorithm is guaranteed not to respect semantic boundaries=
=20
> (for *some* semantics of *some* file).

You might be right. I just wanted to point out this
possibility because it would allow to avoid calling
external merging code for a lot of trivial merges.

bye,
Martin



--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCZnLmYDJInvULMKYRApU8AJ9yHypHGifDGvSQb8EzdDjnq9dw4ACfYyM9
GToMz3elzZCnqswgXALxQjs=
=RF91
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
