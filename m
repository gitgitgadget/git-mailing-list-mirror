From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 23:23:22 +0200
Message-ID: <20080623212322.GD13395@artemis.madism.org>
References: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="11Y7aswkeuHtSBEs";
	protocol="application/pgp-signature"; micalg=SHA1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <g
X-From: git-owner@vger.kernel.org Mon Jun 23 23:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtWS-0001YF-KV
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946AbYFWVX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbYFWVX0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:23:26 -0400
Received: from pan.madism.org ([88.191.52.104]:37452 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757868AbYFWVXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:23:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A050337F40;
	Mon, 23 Jun 2008 23:23:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5E5621470FA; Mon, 23 Jun 2008 23:23:22 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080623210935.GC13395@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85932>


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 09:09:35PM +0000, Pierre Habouzit wrote:
> {
>     struct parse_opt_ctx_t ctx;
>=20
>     parse_options_start(&ctx, argc, argv, 0);
>=20
>     for (;;) {
>         const char *arg;
>=20
>         switch (parse_options_step(&ctx, options, usagestr)) {
>         case PARSE_OPT_HELP:
>             /* dump your help here, the one for options/usagestr is alrea=
dy dumped */

  At the expense of reworking how help is output, especially in the line
above, we also can have the nice feature that you can chain
parse_options_step with different options structure basically this way
(error handling removed):

  if (parse_options_step(&ctx, options1) =3D=3D PARSE_OPT_UNKNOWN &&
      parse_options_step(&ctx, options2) =3D=3D PARSE_OPT_UNKNOWN &&
      ...
      parse_options_step(&ctx, options_n) =3D=3D PARSE_OPT_UNKNOWN)
  {
      /* you're on ! */
  }

  But with the proposed series, it's not possible (well in the sense
that for valid command lines it will work, but you'll end up with funny
usage dumps for invalid ones).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgFEoACgkQvGr7W6HudhxQgACbBtOQDJtDOGY4uPcrJDWYLBdA
u3oAnjoBCxHwTPJ5Twj4/r8O2qO7+H7v
=Fv/w
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
