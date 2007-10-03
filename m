From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: size_t vs "unsigned long"
Date: Wed, 03 Oct 2007 23:36:01 +0200
Message-ID: <20071003213601.GD28188@artemis.corp>
References: <7vabr0djqr.fsf@gitster.siamese.dyndns.org> <20071003204801.GC28188@artemis.corp> <200710032320.00263.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="at6+YcpfzWZg/htY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBt7-0003nr-4t
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbXJCVgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbXJCVgF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:36:05 -0400
Received: from pan.madism.org ([88.191.52.104]:56616 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbXJCVgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:36:04 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 28C7279E;
	Wed,  3 Oct 2007 23:36:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5DF75445D; Wed,  3 Oct 2007 23:36:01 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jan Wielemaker <wielemak@science.uva.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200710032320.00263.wielemak@science.uva.nl>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59889>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 09:19:59PM +0000, Jan Wielemaker wrote:
> On Wednesday 03 October 2007 22:48, Pierre Habouzit wrote:
> > On Wed, Oct 03, 2007 at 08:30:04PM +0000, Junio C Hamano wrote:
> > > Traditionally, inside git, we have used the length of things
> > > with "unsigned long" for pretty much anything, except where we
> > > wanted the length exactly sized we used int32_t, uint64_t and
> > > friends.
> > >
> > > A few places pass pointer to unsigned long as the second
> > > parameter to strbuf_detach(), triggering type mismatch warnings.
> > > An easy way out is to change strbuf_detach() to take a pointer
> > > to ulong but I think it is going backwards.  Most places that
> > > use "unsigned long" can safely be converted (and made more
> > > correct) to use size_t.
> >
> >   Well, afaict, on every linux archs I know of, unsigned longs and
> > size_t are the same. Though, I don't know if that holds for the msys
> > port, and if that does not holds, then a s/unsigned long/size_t/ would
> > help them. Else, for consistency sake, I believe the change is a good
> > one.
>=20
> Surely on the Microsoft 64-bit compilers size_t is 64-bits and long is
> 32-bits.  Don't blame me, I'm just the messenger that learned the hard
> way ...

  Yeah, I've been wondering, and it's the information I had. well, the
information I had is that sizeof(size_t) is 4 on win32, and 8 on win64,
OTOH (and this one I'm sure), on windows, longs are 32bits on both (32
and 64 bits ABIs).

  So replacing unsigned long with size_t's will help the msys port,
hence I had some insight that this could prove useful, now I'm sure :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBAtBvGr7W6HudhwRAnKAAJ42cSDech36wi1lxXGhIuJPYDIu8wCgp9Sq
6EzjGMgBGJ7AOpJ8paCUCyY=
=cK11
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
