From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Mon, 12 Nov 2007 15:52:52 +0100
Message-ID: <20071112145252.GA343@artemis.corp>
References: <473463E0.7000406@gmail.com> <7vabpmpr9y.fsf@gitster.siamese.dyndns.org> <1b46aba20711120509l104792ebo4ea9a51c710510f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="zYM0uCDKw75PZbzx";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 15:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iraf2-0000Co-HL
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbXKLOw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbXKLOw4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:52:56 -0500
Received: from pan.madism.org ([88.191.52.104]:44581 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbXKLOwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:52:55 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 68F7D29B41;
	Mon, 12 Nov 2007 15:52:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4046F1458B2; Mon, 12 Nov 2007 15:52:52 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Carlos Rica <jasampler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Content-Disposition: inline
In-Reply-To: <1b46aba20711120509l104792ebo4ea9a51c710510f3@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64630>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2007 at 01:09:37PM +0000, Carlos Rica wrote:
> 2007/11/10, Junio C Hamano <gitster@pobox.com>:
> > Carlos Rica <jasampler@gmail.com> writes:
> >
> > > Also, this removes those tests ensuring that repeated
> > > -m options don't allocate memory more than once, because now
> > > this is done after parsing options, using the last one
> > > when more are given. The same for -F.
> >
> > The reason for this change is...?  Is this because it is
> > cumbersome to detect and refuse multiple -m options using the
> > parseopt API?  If so, the API may be what needs to be fixed.
> > Taking the last one and discarding earlier ones feels to me an
> > arbitrary choice.
>=20
> You can do many things with repeated options.
> Here in git-tag we considered two different ways to manage them:
> Concatenating values for the option and/or refusing more than one.
> I found that current option-parser can do both from the client
> using callbacks, as Pierre shows me, so I think it is the right way to do=
 it.
>=20
> Pierre, by default, I think that the parser should print an error
> when more than one option of the same type is given,

  I beg to differ. It makes sense for OPTION_STRING options, but not for
other. Though you cannot always detect that.

Also note that:
(1) repeating options was already silent in many git commands, so it's
    not really a regression ;
(2) for many commands it actually make sense to allow repeating (for
    _BOOLEAN e.g.). And I'd argue that for OPTION_BIT it also makes
    sense as well.

> in order to report it to the command-line user, but make this
> behaviour optional for the programmer.  Specifically, I thought in
> this last option:
>=20
> enum parse_opt_option_flags {
> 	PARSE_OPT_OPTARG   =3D 1,
> 	PARSE_OPT_NOARG    =3D 2,
> 	PARSE_OPT_ALLOWREP =3D 4
> };

  To do that you need to keep a list of the triggered commands to do
that, there is no way to achieve that reliably right now. As taking the
last one and discarding the other is the usual way for option parsers I
never saw this as a big issue.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOGjEvGr7W6HudhwRAtF6AJwOBcY9sAKZtaNMjKUoz4vcPfknSgCfRc2s
ryUWlGMIC9rK+Gz15ZnpV5k=
=WV6L
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
