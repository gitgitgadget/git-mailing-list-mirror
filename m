From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 00:24:05 +0200
Message-ID: <20080623222404.GM13395@artemis.madism.org>
References: <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org> <7v3an3hke8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pfTAc8Cvt8L6I27a";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:25:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuTB-0005Lm-Am
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYFWWYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbYFWWYJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:24:09 -0400
Received: from pan.madism.org ([88.191.52.104]:53984 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbYFWWYI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:24:08 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3FC2B37E5B;
	Tue, 24 Jun 2008 00:24:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2184718DB8; Tue, 24 Jun 2008 00:24:05 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v3an3hke8.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85945>


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 10:11:11PM +0000, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
> > On Mon, 23 Jun 2008, Pierre Habouzit wrote:
> >>=20
> >>   Let's see if I can catch it elegantly.
> >
> > No.
> >
> > Look at builtin-blame.c.
> >
> > THEN get back to me.
> >
> > Trust me, you need what I wrote. Something that parses all the options =
in=20
> > one go, and ignores the ones it cannot parse, because a TOTALLY DIFFERE=
NT=20
> > function than the caller will call it!
>=20
> I do not think you two are saying vastly different things.
>=20
> The series Pierre has just posted is prerequisite for teaching
> parse_options() to queue the unknown ones (besides allowing a finer
> grained stepwise parsing), so that the caller like cmd_blame() can call
> revision parser with the remainder.

Yeah actually one can use it this way, what I wrote can be used to do
the very same thing as your _KEEP_UNKNOWN flag, but also more.
=20
Though I didn't fixed the fact that parse_options clobbers argv[0],
which can be easily fixed. The issue with that is that _some_ callers
use the fact that the filtered argv is NULL terminated. I'm unsure if
posix says that argv[argc] is readable and NULL at all, if it isn't,
then changing that would break git for some commands on some OSes other
than Linux and BSD where AFAICT argv[argc] =3D=3D NULL holds.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgIoQACgkQvGr7W6HudhxNdQCeMleXwb20ilP1wDDnX6VC3289
xRwAnir8PmZv5BeSUFKbkhaAP1lcntox
=gcwf
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--
