From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
	trees
Date: Sun, 15 Apr 2007 20:32:09 -0700
Message-ID: <20070416033209.GI2689@curie-int.orbis-terrarum.net>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com> <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org> <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org> <20070416021729.GH2689@curie-int.orbis-terrarum.net> <20070416030103.GB27533@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 05:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdHwr-000557-BE
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 05:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbXDPDcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 23:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbXDPDcG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 23:32:06 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:53505 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754400AbXDPDcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 23:32:05 -0400
Received: (qmail 31783 invoked from network); 16 Apr 2007 03:32:02 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Mon, 16 Apr 2007 03:32:02 +0000
Received: (qmail 3390 invoked by uid 10000); 15 Apr 2007 20:32:09 -0700
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Content-Disposition: inline
In-Reply-To: <20070416030103.GB27533@thunk.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44565>


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 15, 2007 at 11:01:03PM -0400, Theodore Tso wrote:
> On Sun, Apr 15, 2007 at 07:17:29PM -0700, Robin H. Johnson wrote:
> > Nobody has addressed the single problem that I have with adding it when
> > it's leaving the environment, and that's still of paramount concern to
> > me. Simply put, there is a conflict between being able to add revision
> > information of stuff leaving the environment, and those additions
> > breaking previous checksums (which may be digitally signed, and thus
> > breaking the signatures).
> >=20
> > I'll reduce it further from my previous example.
> >=20
> > 1. Developer commits some change to file A.
> > 2. The checksum file is updated because A changed (the checksum file
> >    explicitly does not contain keywords).
> > 3. Developer signs the checksum file, and commits it.
> >=20
> > If during the export process (which is undertaken elsewhere, by a
> > different person or script), file A now has an expansion applied to it,
> > you break the checksum file, which you CANNOT redo, because you lose the
> > developer's digital signature on the checksum file!
>=20
> Simple, the release engineer runs a script which exports the tree,
> expanding any keywords and updating the checksum file as necessary,
> and then the release engineer signs the checksum file!  As has already
> been stated, if this doesn't work, you probably don't have a well
> defined and formal release process.=20
The checksum file (named Manifest) we are talking about is for a single
subdirectory, and is signed as proof that it was not modified between
the developer and submission to the tree.=20

As I wrote originally, this is the Gentoo distribution tree, it's NOT
delineated by well-defined releases in the conventional sense.

There are presently 11571 Manifest files in the tree. Our tools will
not allow commits to each package of things that radically break the
package (semantic correctness and some automatic validation, but thinkos
can still get through the checks).

The 'release' process for the tree runs automatically every 30 minutes,
and consists of more validation checks, updating a cache directory,
producing a signed master Manifest [1] and publishing everything to the
rsync servers.

> Just because a developer has signed a checksum doesn't mean that the
> tree is suitable for release; that's the job of the release engineer
> to confirm, probably after running a set of regression test suites.
> And in fact, with git, it's pointless for the developer to sign a
> checksum file and then commit it, since git is already maintaining
> checksums as an integral part of how revisions are named. =20
The entire point of the checksums is to allow end users to validate
content that has been exported, with only minimal tools.

[1] The master Manifest stage is only in production for the tree
tarballs, and NOT in the rsync production at the moment, but will be
within the next month. It exists solely to allow the detection of
compromised mirrors.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGIu44PpIsIjIzwiwRAglQAKDnacdJ4H1wbiuWwSkqZBaJMeLU2QCfXiPY
25ccsc7Zrc6onooYZclUAKU=
=1Jim
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--
