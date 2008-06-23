From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 23:47:58 +0200
Message-ID: <20080623214758.GF13395@artemis.madism.org>
References: <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nYySOmuH/HDX6pKp";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtuL-0002is-4H
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbYFWVsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYFWVsI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:48:08 -0400
Received: from pan.madism.org ([88.191.52.104]:38101 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbYFWVsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:48:07 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 202AB37E5B;
	Mon, 23 Jun 2008 23:48:00 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E8D991D67E; Mon, 23 Jun 2008 23:47:58 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85940>


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 09:26:39PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Mon, 23 Jun 2008, Pierre Habouzit wrote:
> >=20
> >   Let's see if I can catch it elegantly.
>=20
> No.
>=20
> Look at builtin-blame.c.
>=20
> THEN get back to me.
>=20
> Trust me, you need what I wrote. Something that parses all the options in=
=20
> one go, and ignores the ones it cannot parse, because a TOTALLY DIFFERENT=
=20
> function than the caller will call it!

Well I really believe that with an incremental parse_revisions (I have
sent the patch to split {init,parse,setup}_revisions already) instead of
the 'do all at once' version, you can write the code in builtin-blame in
one pass exactly with the series I wrote.

> Why is that so hard to accept? Especially since I already wrote the code=
=20
> and sent it out?

I don't find it "hard to accept", I just don't like the idea because
it's broken wrt some parse-options mechanisms that I like a lot, and
would be sad to see broken, and that with a little work can be
overcomed. Note that builtin-blame is contains probably the most
involved option parser in git.git, and isn't really what one could call
representative of what awaits us on the path of migrating git.git to
parse-options fully.

I don't expect it to be easy to migrate at all. I do believe your code
works too, it's obvious to see it does actually. But it could be made
better, with real code that I will provide, just not tonight because I'm
exhausted.

Note that an incremental parse_revisions/parse_diff_opts/.. are a
precodition to many CLI parsers conversions anyways, so if the task
seems a bit exagerated for the sake of git-blame only, it actually helps
for dozens of other commands, where the conversion will just be trivial.

I fully understand you frustration wrt the poor handling of the command
line arguments in many git commands. Believe me I really do. I know I
haven't been active on this front for something like 6 months, but I'm
sadly not payed to work on git.git ;p Though things are moving right
now, so why don't we wait another week to see what other propose ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgGg4ACgkQvGr7W6HudhxGaQCgjXzVJr3uoMt0ANoZvlNqSl//
DDMAn0aZjLZFsIhBDGipSTLuGn2hvMxi
=Hr/2
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
