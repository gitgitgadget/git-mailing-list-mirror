From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-options: abbreviation engine fix.
Date: Mon, 05 Nov 2007 13:59:14 +0100
Message-ID: <20071105125914.GD25574@artemis.corp>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org> <1194264204-3475-2-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0711051230020.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HWvPVVuAAfuRc6SZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1YD-0000MU-Ca
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbXKEM7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754704AbXKEM7R
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:59:17 -0500
Received: from pan.madism.org ([88.191.52.104]:41234 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661AbXKEM7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:59:16 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D5C5A19730;
	Mon,  5 Nov 2007 13:59:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4D3BC8418; Mon,  5 Nov 2007 13:59:14 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711051230020.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63511>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On lun, nov 05, 2007 at 12:34:00 +0000, Johannes Schindelin wrote:
>=20
> When an option could be an ambiguous abbreviation of two options, the cod=
e=20
> used to error out.  Even if an exact match would have occured later.
>=20
> Test and original patch by Pierre Habouzit.
>=20
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>=20
> 	On Mon, 5 Nov 2007, Pierre Habouzit wrote:
>=20
> 	> When we had at least two long option then followed by another=20
> 	> one that was a prefix of both of them, then the abbreviation=20
> 	> detector failed.
>=20
> 	Yeah, I assumed that you would never do such a thing, but I agree=20
> 	that with recursing option parsing it is much more likely.
>=20
> 	It took me some time to understand your patch, and that the moving=20
> 	of the UNSET handling was unnecessary.

  yeah, that's because I dislike where it's done. Each time I read it,
I'm under the impression that it clobbers p->opt if this case is not the
one used.

  In fact, I believe that for code clarity we should do what you
proposed earlier: disallow `=3D` in option names (that's rather sane
anyway) and drop the `rest` variable altogether, just use your current
arg_end and prefixcmp/strncmps. That will incidentally also allow to
remove skip_prefix while we're at it.

  This way we could set p->opt first thing in the function and be done
with it instead of doing it two different ways in the function, hence
making the reader assume one is wrong or at least questionable.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLxOivGr7W6HudhwRAnBSAJ44ur0EnsIUOKvHa5bsYe6RxaTkhQCgjpSE
ESXUP8OWhCMNp25TI/ODq7Y=
=FWwD
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
