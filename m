From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Sat, 24 Jan 2009 00:05:20 +0100
Message-ID: <20090123230520.GL21473@genesis.frugalware.org>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huLXOlJ1ghGp/P5+"
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 00:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQV6t-0008Lg-J2
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 00:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757543AbZAWXFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 18:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757071AbZAWXFX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 18:05:23 -0500
Received: from virgo.iok.hu ([212.40.97.103]:57589 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607AbZAWXFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 18:05:22 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 90472580B6;
	Sat, 24 Jan 2009 00:05:22 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AD1154465E;
	Sat, 24 Jan 2009 00:05:20 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9B2D811B87A9; Sat, 24 Jan 2009 00:05:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106929>


--huLXOlJ1ghGp/P5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2009 at 03:42:24AM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > > I am mostly worried about a failure case (connected but couldn't get=
=20
> > > the refs, or perhaps connection failed to start).  If you get a NULL=
=20
> > > in such a case you may end up saying "oh you cloned a void" when you=
=20
> > > should say "nah, such a remote repository does not exist".
> >=20
> > Yes, this was my concern as well.
>=20
> From what I can see in get_remote_heads(), the native protocols would=20
> die(), as would rsync().
>=20
> HTTP transport, however, would not die() on connection errors, from my=20
> cursory look.

I'm not familiar with the HTTP code, either, but here is the call stack
I see:

- builtin-clone calls transport_get_remote_refs()
- that will call transport->get_refs_list()
- that will call get_refs_via_curl()
- that die()s on error, does not use return error()

Have I missed something?

--huLXOlJ1ghGp/P5+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl6TTAACgkQe81tAgORUJafQgCfeIuDzux6pFOl87c2sHIr3q2X
dXMAn2tNuR8/dGVRKQA8gBqqIS5VMoeC
=7p+H
-----END PGP SIGNATURE-----

--huLXOlJ1ghGp/P5+--
