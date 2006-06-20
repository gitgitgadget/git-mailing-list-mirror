From: Keith Packard <keithp@keithp.com>
Subject: Re: packs and trees
Date: Tue, 20 Jun 2006 08:18:48 -0700
Message-ID: <1150816728.5382.27.camel@neko.keithp.com>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
	 <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com>
	 <9e4733910606200735u5741a9adr83264ae7d51dd37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H5iZoP0ErcSBrrnmaUIv"
Cc: keithp@keithp.com, Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 17:19:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsi0r-0001HD-0n
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 17:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWFTPT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 11:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFTPT2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 11:19:28 -0400
Received: from home.keithp.com ([63.227.221.253]:47378 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751312AbWFTPT1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 11:19:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 56BB9130022;
	Tue, 20 Jun 2006 08:19:25 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28047-01; Tue, 20 Jun 2006 08:19:24 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id C34BC13001E; Tue, 20 Jun 2006 08:19:24 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id B4CCF14002;
	Tue, 20 Jun 2006 08:19:24 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 5D097541CC; Tue, 20 Jun 2006 08:18:49 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606200735u5741a9adr83264ae7d51dd37@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22207>


--=-H5iZoP0ErcSBrrnmaUIv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-20 at 10:35 -0400, Jon Smirl wrote:

> Keith's parsecvs run ended up in a loop and mine hit a parsecvs error
> and then had memory corruption after about eight hours. That was last
> week,  I just checked the logs and I don't see any comments about
> fixing it.

Yeah, I'm rewriting the tool; the current codebase isn't supportable.

> Even after spending eight hours building the changeset info iit is
> still going to take it a couple of days to retrieve the versions one
> at a time and write them to git. Reparsing 50MB delta files n^2/2
> times is a major bottleneck for all three programs.

The eight hours in question *were* writing out the deltas and packing
the resulting trees. All that remained was to construct actual commit
objects and write them out.=20

The problem was that parsecvs's internals are structured so that this
processes would take a large amount of memory, so I'm reworking the code
to free stuff as it goes along.

With a rewritten parsecvs, I'm hoping to be able to steal the algorithms
from cvs2svn and stick those in place. Then work on truncating the
history so it can deal with incremental updates to the repository, which
I think will be straightforward if we stick a few breadcrumbs in the git
repository to recover state from.

--=20
keith.packard@intel.com

--=-H5iZoP0ErcSBrrnmaUIv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEmBHYQp8BWwlsTdMRAvKAAJ9im3xBdUowt9af+/MtoYDXsCHGtACaAtG4
GygX7WgiFOamLrnTMzWkIPE=
=28dp
-----END PGP SIGNATURE-----

--=-H5iZoP0ErcSBrrnmaUIv--
